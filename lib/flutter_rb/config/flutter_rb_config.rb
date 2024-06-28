# frozen_string_literal: true

module FlutterRb
  # This class represents the configuration for FlutterRb checks.
  # It holds arrays of checks for Flutter, Android, and iOS platforms.
  class FlutterRbConfig
    # Initializes a new instance of FlutterRbConfig.
    #
    # @param flutter_checks [Array<Check>] An array of Flutter checks.
    # @param android_checks [Array<Check>] An array of Android checks.
    # @param ios_checks [Array<Check>] An array of iOS checks.
    def initialize(flutter_checks, android_checks, ios_checks)
      @flutter_checks = flutter_checks
      @android_checks = android_checks
      @ios_checks = ios_checks
    end

    # Provides read and write access to the flutter_checks attribute.
    attr_accessor :flutter_checks

    # Provides read and write access to the android_checks attribute.
    attr_accessor :android_checks

    # Provides read and write access to the ios_checks attribute.
    attr_accessor :ios_checks
  end
end
