module FlutterRb
  class AndroidFolder
    def initialize(exists)
      @exists = exists
    end

    attr_reader :exists
  end
end
