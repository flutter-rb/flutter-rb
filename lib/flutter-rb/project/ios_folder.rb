module FlutterRb
  class IOSFolder
    def initialize(exists)
      @exists = exists
    end

    attr_reader :exists
  end
end
