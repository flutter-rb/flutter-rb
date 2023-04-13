module FlutterRb
  # Base class for all checks
  # Class provides default methods structure
  # All methods using for create reports
  class Check
    UNIMPLEMENTED_ERROR = 'Error: missing method'.freeze

    def name
      raise UNIMPLEMENTED_ERROR
    end

    def summary
      raise UNIMPLEMENTED_ERROR
    end

    def description
      'No provided'
    end

    def check
      raise UNIMPLEMENTED_ERROR
    end
  end
end
