module FlutterRb
  # Android project representation
  class AndroidFolder
    def initialize(gradle_config)
      @gradle_config = gradle_config
    end

    attr_reader :gradle_config
  end
end
