# dirigent's CLI for Homebrew, built from the release's source: the release workflow fills in
# the version and checksum and puts it in the tap (adamchol/homebrew-dirigent).
#
#   brew install adamchol/dirigent/dirigent
#   dirigent login https://dirigent.example.com
#   brew services start dirigent          # the host, as yours: a launchd agent (never with sudo,
#                                         # which makes it a daemon outside your login session)
class Dirigent < Formula
  desc "Command-line for dirigent: sign in, import sessions, and host players"
  homepage "https://github.com/adamchol/dirigent-0"
  url "https://github.com/adamchol/dirigent-0/archive/refs/tags/v0.1.14.tar.gz"
  sha256 "249c6be66a7bf5f89e894d6b785616923919c36c21721c3606c365769ea5040f"
  head "https://github.com/adamchol/dirigent-0.git", branch: "master"

  depends_on "rust" => :build
  uses_from_macos "git"

  def install
    ENV["DIRIGENT_VERSION"] = version.to_s
    system "cargo", "install", *std_cargo_args(path: "cli")
  end

  # The host: players run in process groups of their own, so they outlive it (each holds its
  # session's lease) when the service is stopped or restarted.
  service do
    run [opt_bin/"dirigent", "host", "run"]
    keep_alive true
    environment_variables PATH: std_service_path_env
    log_path var/"log/dirigent-host.log"
    error_log_path var/"log/dirigent-host.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dirigent --version")
    assert_match "slots", shell_output("#{bin}/dirigent host --help")
  end
end
