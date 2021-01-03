require_relative './gradle'

module FlutterRb
  # Android project representation
  class AndroidFolder
    def initialize(path)
      @path = path
      @gradle = GradleParser.new("#{@path}/build.gradle").parse
    end

    attr_reader :path, :gradle
  end
end
