module FlutterRb
  # Base class for all checks
  class Check
    UNIMPLEMENTATION_ERROR = 'Error: method missing'

    def name
      raise UNIMPLEMENTATION_ERROR
    end

    def summary
      raise UNIMPLEMENTATION_ERROR
    end

    def description
      'No provided'
    end

    def check
      raise UNIMPLEMENTATION_ERROR
    end
  end
end
