# frozen_string_literal: true

module FlutterRb
  # Base class for all checks
  # Class provides default methods structure
  # All methods using for create reports
  class Check
    UNIMPLEMENTED_ERROR = 'Error: missing method'

    # @return {String}
    def name
      raise UNIMPLEMENTED_ERROR
    end

    # @return {String}
    def description
      raise UNIMPLEMENTED_ERROR
    end

    # @param {Project} project
    # @return {CheckReport}
    def check(project)
      raise UNIMPLEMENTED_ERROR
    end
  end
end
