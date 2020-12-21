require_relative './podspec'

module FlutterRb
  # iOS representation
  class IOSFolder
    def initialize(path)
      @podspec = PodspecParser.new("#{path}/app_rating_message.podspec").parse
    end

    attr_reader :podspec
  end
end
