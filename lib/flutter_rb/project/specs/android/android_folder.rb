require_relative './gradle'

module FlutterRb
  # Android project representation
  class AndroidFolder
    # @param {String} path
    def initialize(path)
      @path = path
      @gradle = GradleParser.new(@path).parse
    end

    attr_reader :path, :gradle
  end
end
