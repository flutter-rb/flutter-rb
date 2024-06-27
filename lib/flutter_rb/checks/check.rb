# frozen_string_literal: true

module FlutterRb
  # This class serves as a base class for all checks in the FlutterRb module.
  # It provides a default structure for methods and includes error handling for unimplemented methods.
  class Check
    # Error message to be raised when a method is not implemented.
    UNIMPLEMENTED_ERROR = 'Error: missing method'

    # Returns the name of the check.
    #
    # @return [String] the name of the check
    def name
      raise UNIMPLEMENTED_ERROR
    end

    # Returns a description of the check.
    #
    # @return [String] a description of the check
    def description
      raise UNIMPLEMENTED_ERROR
    end

    # Performs the check on the given project and returns a report.
    #
    # @param project [Project] the project to be checked
    # @return [CheckReport] the report of the check
    def check(project)
      raise UNIMPLEMENTED_ERROR
    end
  end
end
