require_relative './podspec'

module FlutterRb
  # iOS representation
  class IOSFolder
    def initialize(path, pubspec)
      podspec_path = "#{path}/#{pubspec.pubspec_info.name}.podspec"
      @podspec = File.exist?(podspec_path) ? PodspecParser.new(podspec_path).parse : nil
    end

    attr_reader :podspec
  end
end
