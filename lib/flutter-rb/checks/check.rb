module FlutterRb
  # Base class for all checks
  # Class provides default methods structure
  # All methods using for create reports
  class Check
    UNIMPLEMENTATION_ERROR = 'Error: missing method'.freeze

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
