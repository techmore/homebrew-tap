class EnergyMonitor < Formula
  desc "Local-first Emporia Vue 3 energy monitor for the macOS menu bar"
  homepage "https://github.com/techmore/Emporia-Vue3-Mac-Utility-Monitor"
  url "https://github.com/techmore/Emporia-Vue3-Mac-Utility-Monitor/releases/download/v2.3.21/Emporia-Energy-Monitor-2.3.21-macos.zip"
  sha256 "0545a7dda86503cc5e95fc3a8a5809c8903b69d3dd66330c6bf2d5cfbc6481a1"
  license "MIT"

  # Prebuilt Python wheels lack space for expanded absolute dylib IDs.
  preserve_rpath

  depends_on arch: :arm64
  depends_on macos: :ventura
  depends_on "python@3.12"

  resource "arm64-wheels" do
    url "https://github.com/techmore/Emporia-Vue3-Mac-Utility-Monitor/releases/download/v2.3.21/Emporia-Energy-Monitor-2.3.21-arm64-wheels.tar.gz"
    sha256 "95c93e50b0be857ded770931e5c3493532ba253f72e18c6a9e5ff47327f491e5"
  end

  def install
    # Homebrew strips a single top-level archive directory, so the sources may already be buildpath.
    nested = buildpath/"Emporia-Energy-Monitor-#{version}"
    root = nested.directory? ? nested : buildpath
    odie "Expected release sources in #{root}" unless (root/"web.py").file?
    root.children.each { |path| libexec.install path }

    wheelhouse = libexec/"wheelhouse"
    wheelhouse.mkpath
    resource("arm64-wheels").stage { wheelhouse.install Dir[Pathname.pwd/"**/*.whl"] }
    python = formula_opt_bin("python@3.12")/"python3.12"
    system python, "-m", "venv", libexec/"venv"
    system libexec/"venv/bin/python3", "-m", "pip", "install", "--no-index",
           "--find-links=#{wheelhouse}", "-r", libexec/"requirements.lock"

    bundle = prefix/"EnergyMonitorApp.app"
    executable = bundle/"Contents/MacOS/EnergyMonitorApp"
    resources = bundle/"Contents/Resources"
    resources.mkpath
    executable.dirname.mkpath
    swift_sources = Dir[(libexec/"EnergyMonitorApp/Sources/*.swift").to_s]
    system "swiftc", "-sdk", Utils.safe_popen_read("xcrun", "--show-sdk-path").strip,
           "-target", "arm64-apple-macosx13.0", "-framework", "AppKit",
           "-framework", "SwiftUI", *swift_sources, "-o", executable
    cp libexec/"EnergyMonitorApp/Resources/Info.plist", bundle/"Contents/Info.plist"
    (resources/"project_root.txt").write "#{opt_prefix}/libexec\n"
    (resources/"data_root.txt").write "#{var}/energy-monitor\n"
    (resources/"flask_port.txt").write "5019\n"
    (resources/"project_root.txt").chmod 0600
    (resources/"data_root.txt").chmod 0600
    (resources/"flask_port.txt").chmod 0600

    (bin/"energy-monitor").write <<~SH
      #!/bin/bash
      APP="#{opt_prefix}/EnergyMonitorApp.app"
      case "${1:-start}" in
        start) exec open -a "$APP" ;;
        autostart|uninstall) cmd="$1"; shift; exec "$APP/Contents/MacOS/EnergyMonitorApp" "--$cmd" "$@" ;;
        *)
          echo "usage: energy-monitor [start | autostart on|off|status | uninstall [--purge]]" >&2
          exit 64 ;;
      esac
    SH
    (bin/"energy-monitor").chmod 0755
  end

  post_install_steps do
    mkdir_p "energy-monitor", base: :var
    set_permissions "energy-monitor", "0700", base: :var
  end

  service do
    run opt_prefix/"EnergyMonitorApp.app/Contents/MacOS/EnergyMonitorApp"
    working_dir var/"energy-monitor"
    keep_alive false
    log_path var/"log/energy-monitor.log"
    error_log_path var/"log/energy-monitor.log"
  end

  def caveats
    <<~EOS
      Start the menu bar monitor:
        energy-monitor

      It starts at login automatically after the first run. To change that:
        energy-monitor autostart off      (or on / status)
      or use the menu bar icon, then the ... menu, then "Start at Login".

      To uninstall (your data is kept; add --purge to delete it too):
        energy-monitor uninstall

      Local settings, credentials and SQLite history live in:
        #{var}/energy-monitor

      The app is compiled from source on this Mac. Xcode Command Line Tools are required.
    EOS
  end

  test do
    app_binary = prefix/"EnergyMonitorApp.app/Contents/MacOS/EnergyMonitorApp"
    assert_predicate app_binary, :executable?
    python = libexec/"venv/bin/python3"
    assert_predicate python, :executable?
    assert_equal "flask", shell_output("#{python} -c 'import flask; print(flask.__name__)'").strip
  end
end
