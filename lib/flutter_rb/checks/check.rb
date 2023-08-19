module FlutterRb
  # Base class for all checks
  # Class provides default methods structure
  # All methods using for create reports
  class Check
    UNIMPLEMENTED_ERROR = 'Error: missing method'.freeze

    # @return {String}
    def name
      raise UNIMPLEMENTED_ERROR
    end

    # @return {String}
    def summary
      raise UNIMPLEMENTED_ERROR
    end

    # @return {String}
    def description
      'No provided'
    end

    # rubocop:disable Lint/UnusedMethodArgument
    # @param {Project} project
    # @return {CheckReport}
    def check(project)
      raise UNIMPLEMENTED_ERROR
    end

    # rubocop:enable Lint/UnusedMethodArgument
  end
end
