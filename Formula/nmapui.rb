class Nmapui < Formula
  include Language::Python::Virtualenv

  desc "Web UI for Nmap network discovery, service scans and reports"
  homepage "https://techmore.github.io/TM-NMapUI-www/"
  url "https://github.com/techmore/TM-NmapUI/archive/refs/tags/v2026.10.25.tar.gz"
  version "2026.10.25"
  sha256 "272a409a0cea76e7bb2ca721fd5c9cb5a2196d6022dd8ba85ed31ece530a77a4"
  license "MIT"

  depends_on arch: :arm64
  depends_on "libxslt"
  depends_on "libyaml"
  depends_on :macos
  depends_on "nmap"
  depends_on "python@3.12"

  # Prebuilt Python wheels lack space for expanded absolute dylib IDs.
  preserve_rpath

  # BEGIN generated resources (scripts/bump_nmapui.py)
  resource "bidict" do
    url "https://files.pythonhosted.org/packages/97/53/2a3c7d562271ec6b6e38e7216b3104899f8aa4180c0713cb8aaf69e29cd5/bidict-0.24.1-py3-none-any.whl"
    sha256 "fd3eaa737917d8a14f4baa391670c433c4e3f6f5fd2cd99d4bf436437f432364"
  end

  resource "blinker" do
    url "https://files.pythonhosted.org/packages/10/cb/f2ad4230dc2eb1a74edf38f1a38b9b52277f75bef262d8908e60d957e13c/blinker-1.9.0-py3-none-any.whl"
    sha256 "ba0efaa9080b619ff2f3459d1d500c57bddea4a6b424b60a91141db6fd2f08bc"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/32/d1/a3652fe2c19134d0d15922177821d863cbd7e842d53a21bbe7e8e3a1b5ac/certifi-2026.10.23-py3-none-any.whl"
    sha256 "e9b54de76e530bb6cf0ccd036787103acb58fd42ba930ea8bf948ddbaa2f61d1"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/54/7d/16e5a096677b5e313ca80cd5e5170efa3ea44624a82bb111925522da64b1/cffi-2.1.1-cp312-cp312-macosx_11_0_arm64.whl"
    sha256 "f81b3b8f3d4e343550fa4baa0e479bba9f2d29ce9c2e9b51d1ce1718d7442fcf"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/e7/c8/693809898870237d82785a03f3b2b58fe4c9f14669f84a7d4e623c92a59e/charset_normalizer-3.5.2-cp312-cp312-macosx_10_13_universal2.whl"
    sha256 "ed2a239c0ea213acc1908150a3037257083c7c083128f1a4cec2ec4b97dca491"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/58/50/6c0d534c5f134586a8e1ba4e330569e32f057e33372ae556463212fb4cd3/click-8.5.0-py3-none-any.whl"
    sha256 "255bc9599cf7748b4b1a446ccc735421bd08a2ae529a8b88597d3de5664ee360"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/e5/56/d194340cc4a57535e82e1bee9e89667ac4b7c13b5d3f59686deae3094dd5/cryptography-50.0.2-cp311-abi3-macosx_11_0_arm64.whl"
    sha256 "fa8f5efb344d6908a1ce62f4a24e2e5780f825d6f53f5f50ec5ffacac72936cb"
  end

  resource "flask" do
    url "https://files.pythonhosted.org/packages/7f/9c/34f6962f9b9e9c71f6e5ed806e0d0ff03c9d1b0b2340088a0cf4bce09b18/flask-3.1.3-py3-none-any.whl"
    sha256 "f4bcbefc124291925f1a26446da31a5178f9483862233b23c0c96a20701f670c"
  end

  resource "flask-cors" do
    url "https://files.pythonhosted.org/packages/49/55/5bb1a2d918e9f02f131e47a59032bae70e48050e986e941511fd737a935c/flask_cors-6.0.5-py3-none-any.whl"
    sha256 "68fcf75693e961f3af26683b23c4b9a8fb6b64de17d20d0c37b95e8de7ab2ed8"
  end

  resource "flask-socketio" do
    url "https://files.pythonhosted.org/packages/35/40/79ed0a2086b6eb0d310dca81e4813b8e385a33b2938df83702e7036a6905/flask_socketio-5.7.0-py3-none-any.whl"
    sha256 "2e399a4a747c6248baec188d3b1294081fda8a85597d11815a2219836bafcbad"
  end

  resource "greenlet" do
    url "https://files.pythonhosted.org/packages/72/18/3fc6d951466ae9a2a688edcddde3b2e388da0a8244e0caf7117bbeb0eb95/greenlet-3.5.6-cp312-cp312-macosx_11_0_universal2.whl"
    sha256 "a5876d0a60355af98d535c47f6cd6eb0f8a432396dab26845d380b92f8412422"
  end

  resource "gunicorn" do
    url "https://files.pythonhosted.org/packages/fe/85/7522a52e5e2f42faf1a129113ab63e548c42e103e9af395b7bfe65e403e2/gunicorn-26.2.0-py3-none-any.whl"
    sha256 "bd249d0b3f7972f7432f0a6b6ff3b3ee2d129f70cd1ff6c09a9dd9e29a2b88e3"
  end

  resource "h11" do
    url "https://files.pythonhosted.org/packages/04/4b/29cac41a4d98d144bf5f6d33995617b185d14b22401f75ca86f384e87ff1/h11-0.16.0-py3-none-any.whl"
    sha256 "63cf8bbe7522de3bf65932fda1d9c2772064ffb3dae62d55932da54b31cb6c86"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/58/a2/bb081bab032533a855d44de1d56f8e8426114ff1ba5d1f07a438a0a654f8/idna-3.20-py3-none-any.whl"
    sha256 "ab7ae7122974553370f0bdb919e1a960b2cd1bc1ef0276416d896db81c14582c"
  end

  resource "itsdangerous" do
    url "https://files.pythonhosted.org/packages/04/96/92447566d16df59b2a776c0fb82dbc4d9e07cd95062562af01e408583fc4/itsdangerous-2.2.0-py3-none-any.whl"
    sha256 "c6242fc49e35958c8b15141343aa660db5fc54d4f13a1db01a3f5891b98700ef"
  end

  resource "jinja2" do
    url "https://files.pythonhosted.org/packages/62/a1/3d680cbfd5f4b8f15abc1d571870c5fc3e594bb582bc3b64ea099db13e56/jinja2-3.1.6-py3-none-any.whl"
    sha256 "85ece4451f492d0c13c5dd7c13a64681a86afae63a5f347908daf103ce6d2f67"
  end

  resource "markupsafe" do
    url "https://files.pythonhosted.org/packages/a2/f0/d6613774d86fbf6d145751d43c59875e47a6f9f17daee0aef173bd36d90e/markupsafe-3.0.4-cp312-cp312-macosx_11_0_arm64.whl"
    sha256 "0930db9bdc62d22944e10b066448bb65dc9abe9112880c7cab8da54db4284d5f"
  end

  resource "netifaces" do
    url "https://files.pythonhosted.org/packages/a6/91/86a6eac449ddfae239e93ffc1918cf33fd9bab35c04d1e963b311e347a73/netifaces-0.11.0.tar.gz"
    sha256 "043a79146eb2907edf439899f262b3dfe41717d34124298ed281139a8b93ca32"
  end

  resource "playwright" do
    url "https://files.pythonhosted.org/packages/72/4f/572bbbe60a5787ca61a84bad934c3ce19c08c2bc9c0e9781bf0d99cad1a6/playwright-1.64.1-py3-none-macosx_11_0_arm64.whl"
    sha256 "59f7b041284ce8d1b72098ae50ca48a2d83692eec25154ab5ba79d4b6b4fe8a9"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/b6/ae/315bbeee126a769cbde43cf4908acb4b40408d8bf8bbf334dd7368d8dadf/pycparser-3.12-py3-none-any.whl"
    sha256 "a076f3f489b39b43ed13563a1dafe42447445bec2e294154ec5c57fcdda4c85e"
  end

  resource "pyee" do
    url "https://files.pythonhosted.org/packages/81/12/5347938b1f9a6453f0dbdfcc3e2388a1320ef9b9ec17fbefbc4ab647ea98/pyee-14.0.0-py3-none-any.whl"
    sha256 "3ac2d3229a9677f7de2c33d7f52fe25b638a46b19c413fea2edc8c6d0a644e4d"
  end

  resource "python-engineio" do
    url "https://files.pythonhosted.org/packages/38/5c/552f1dce2443dc33ce6b2ee7f67599ba5c83ef5582e2235a9878ac239049/python_engineio-4.15.1-py3-none-any.whl"
    sha256 "745cb3c07701c719a2906439a00b67e44ef042904036568530a2c3a8cf18c89a"
  end

  resource "python-socketio" do
    url "https://files.pythonhosted.org/packages/ee/be/44b558c944bc16618483967ecd3424c578705aa33ceee7df8c1e4ab43ea0/python_socketio-5.17.0-py3-none-any.whl"
    sha256 "b5826fd2f8aa02e11347816349b74ac6b53e8a4f4e4b1cf1388e1aff19b7f3f4"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/89/a0/6cf41a19a1f2f3feab0e9c0b74134aa2ce6849093d5517a0c550fe37a648/pyyaml-6.0.3-cp312-cp312-macosx_11_0_arm64.whl"
    sha256 "fc09d0aa354569bc501d4e787133afc08552722d3ab34836a80547331bb5d4a0"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/a0/f4/c67b0b3f1b9245e8d266f0f112c500d50e5b4e83cb6f3b71b6528104182a/requests-2.34.2-py3-none-any.whl"
    sha256 "2a0d60c172f83ac6ab31e4554906c0f3b3588d37b5cb939b1c061f4907e278e0"
  end

  resource "simple-websocket" do
    url "https://files.pythonhosted.org/packages/52/59/0782e51887ac6b07ffd1570e0364cf901ebc36345fea669969d2084baebb/simple_websocket-1.1.0-py3-none-any.whl"
    sha256 "4af6069630a38ed6c561010f0e11a5bc0d4ca569b36306eb257cd9a192497c8c"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/49/d3/b8441a820a491ddfc024b0b0cf0393375b75ea13866d9c66727e54c2fc80/typing_extensions-4.16.0-py3-none-any.whl"
    sha256 "481caa481374e813c1b176ada14e97f1f67a4539ce9cfeb3f350d78d6370c2e8"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/92/9d/c4e665119135114480843e7ab388fa94d8480650450e6f8e26b70d323a4c/urllib3-2.8.0-py3-none-any.whl"
    sha256 "0cf3cae568d36aa9576b28dfb35f11328f1cb974ca7647d9475ebb86c75ac6e3"
  end

  resource "werkzeug" do
    url "https://files.pythonhosted.org/packages/a1/38/df03f564f43cec2684823f3cccae1a652ee7face1cbaa76fb223096e64d7/werkzeug-3.1.9-py3-none-any.whl"
    sha256 "6392e50c78460ba618e5b21f08a71f59c99ce99cdc6cf6e3dd7e6ccca8754fab"
  end

  resource "wsproto" do
    url "https://files.pythonhosted.org/packages/a4/f5/10b68b7b1544245097b2a1b8238f66f2fc6dcaeb24ba5d917f52bd2eed4f/wsproto-1.3.2-py3-none-any.whl"
    sha256 "61eea322cdf56e8cc904bd3ad7573359a242ba65688716b0710a5eb12beab584"
  end

  resource "setuptools" do
    url "https://files.pythonhosted.org/packages/a3/dc/17031897dae0efacfea57dfd3a82fdd2a2aeb58e0ff71b77b87e44edc772/setuptools-80.9.0-py3-none-any.whl"
    sha256 "062d34222ad13e0cc312a4c02d73f059e86a4acbfbdea8f8f76b28c99f306922"
  end

  resource "wheel" do
    url "https://files.pythonhosted.org/packages/0b/2c/87f3254fd8ffd29e4c02732eee68a83a1d3c346ae39bc6822dcbcb697f2b/wheel-0.45.1-py3-none-any.whl"
    sha256 "708e7481cc80179af0e556bbf0cc00b8444c7321e2700b8d8580231d13017248"
  end
  # END generated resources

  def install
    odie "Expected NmapUI sources in #{buildpath}" unless (buildpath/"app.py").file?
    rm_r buildpath/".claude" if (buildpath/".claude").exist?
    libexec.install buildpath.children

    # Install offline from the pinned, checksummed wheels above; pip then
    # re-checks every file against the hash-locked requirements.
    wheelhouse = buildpath/"wheelhouse"
    wheelhouse.mkpath
    resources.each do |r|
      cp r.cached_download, wheelhouse/File.basename(r.url)
    end
    # virtualenv_create points the venv at python@3.12's opt path, so the
    # install survives Python patch upgrades.
    venv = virtualenv_create(libexec/"venv", "python3.12", system_site_packages: false)
    pip = [formula_opt_bin("python@3.12")/"python3.12", "-m", "pip", "--python", venv.root/"bin/python",
           "install", "--no-index", "--find-links=#{wheelhouse}"]
    system(*pip, "setuptools==80.9.0", "wheel==0.45.1")
    system(*pip, "--no-build-isolation", "--no-deps", "--require-hashes",
           "-r", libexec/"packaging/homebrew/requirements.lock")

    bin.install_symlink libexec/"packaging/homebrew/nmapui-server" => "nmapui"
    bin.install_symlink libexec/"packaging/homebrew/nmapui-privileged-setup"
  end

  def caveats
    <<~EOS
      NmapUI runs as your user (never as root) on http://127.0.0.1:9000:
        brew services start nmapui
      Data and logs: ~/Library/Application Support/NmapUI-brew (`nmapui paths`).

      On first use macOS asks whether "Python" may find devices on your
      local network: choose Allow, or scans report 0 hosts.

      Scans are unprivileged by default (connect scans, TCP ping discovery).
      For SYN/OS/ARP scans, install the nmap.org macOS package (root-owned
      /usr/local/bin/nmap), start NmapUI once, then run once:
        sudo #{opt_bin}/nmapui-privileged-setup install --user "$USER" \\
          --data-dir "$HOME/Library/Application Support/NmapUI-brew/data"
      It allows sudo only for a validating helper, never for nmap itself.

      PDF reports need Chromium for Playwright (~150 MB):
        nmapui install-pdf-browser
    EOS
  end

  service do
    run [opt_bin/"nmapui", "serve"]
    keep_alive true
    log_path var/"log/nmapui.log"
    error_log_path var/"log/nmapui.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    port = free_port
    ENV["NMAPUI_STATE_DIR"] = (testpath/"state").to_s
    ENV["NMAPUI_PORT"] = port.to_s
    assert_match "127.0.0.1:#{port}", shell_output("#{bin}/nmapui paths")

    pid = spawn bin/"nmapui", "serve"
    begin
      url = "http://127.0.0.1:#{port}/api/health/ready"
      60.times do
        break if quiet_system "curl", "-sf", url

        sleep 1
      end
      assert_match '"ready":true', shell_output("curl -s #{url}")
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end
  end
end
