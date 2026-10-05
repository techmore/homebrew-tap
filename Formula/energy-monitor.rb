class EnergyMonitor < Formula
  desc "Local-first Emporia Vue 3 energy monitor for the macOS menu bar"
  homepage "https://github.com/techmore/Emporia-Vue3-Mac-Utility-Monitor"
  url "https://github.com/techmore/Emporia-Vue3-Mac-Utility-Monitor/releases/download/v2.2.0/Emporia-Energy-Monitor-2.2.0-macos.zip"
  sha256 "b3f5959bd8920429307ed75118ee1e0c5e10d83a76aee6e7e535ff03ce50fc73"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :ventura
  depends_on "python@3.12"

  resource "arm64-wheels" do
    url "https://github.com/techmore/Emporia-Vue3-Mac-Utility-Monitor/releases/download/v2.2.0/Emporia-Energy-Monitor-2.2.0-arm64-wheels.tar.gz"
    sha256 "d99197466d36b76e8210e974a74fda9c51bc7c3f0a6c9790e45d9bdcfe21d319"
  end

  def install
    root = buildpath/"Emporia-Energy-Monitor-#{version}"
    odie "Expected the release source directory at #{root}" unless root.directory?
    root.children.each { |path| libexec.install path }

    wheelhouse = libexec/"wheelhouse"
    wheelhouse.mkpath
    resource("arm64-wheels").stage { |path| wheelhouse.install Dir[path/"*.whl"] }
    python = formula_opt_bin("python@3.12")/"python3.12"
    system python, "-m", "venv", libexec/"venv"
    system libexec/"venv/bin/python3", "-m", "pip", "install", "--no-index",
           "--find-links=#{wheelhouse}", "-r", libexec/"requirements.lock"

    bundle = prefix/"EnergyMonitorApp.app"
    executable = bundle/"Contents/MacOS/EnergyMonitorApp"
    resources = bundle/"Contents/Resources"
    resources.mkpath
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
      exec open -a "#{opt_prefix}/EnergyMonitorApp.app"
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
    keep_alive true
    log_path var/"log/energy-monitor.log"
    error_log_path var/"log/energy-monitor.log"
  end

  def caveats
    <<~EOS
      Start the menu bar monitor at login:
        brew services start techmore/tap/energy-monitor

      Or start it once from a terminal:
        energy-monitor

      Local settings, credentials and SQLite history live in:
        #{var}/energy-monitor

      The app is compiled from source on this Mac. Xcode Command Line Tools are required.
      Homebrew uninstall preserves your local data directory.
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
