module FlutterRb
  # FlutterRb configuration representation from config in Flutter plugin
  class FlutterRbConfig
    # @param {Check[]} flutter_checks
    # @param {Check[]} android_checks
    # @param {Check[]} ios_checks
    def initialize(flutter_checks, android_checks, ios_checks)
      @flutter_checks = flutter_checks
      @android_checks = android_checks
      @ios_checks = ios_checks
    end

    attr_accessor :flutter_checks, :android_checks, :ios_checks
  end
end
