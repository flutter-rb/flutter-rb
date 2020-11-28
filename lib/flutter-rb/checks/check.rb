module FlutterRb
  # Base class for all checks
  class Check
    UNIMPLEMENTATION_ERROR = 'Error: method missing'

    def info
      raise UNIMPLEMENTATION_ERROR
    end

    def check
      raise UNIMPLEMENTATION_ERROR
    end
  end
end
