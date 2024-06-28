# frozen_string_literal: true

module FlutterRb
  # A class representing a check to be performed on a project.
  class Check
    # Error message to be raised when a method is not implemented.
    UNIMPLEMENTED_ERROR = 'Error: missing method'

    # Returns the name of the check.
    #
    # @return [String] the name of the check
    # @raise [RuntimeError] if the method is not implemented
    def name
      raise UNIMPLEMENTED_ERROR
    end

    # Returns a description of the check.
    #
    # @return [String] a description of the check
    # @raise [RuntimeError] if the method is not implemented
    def description
      raise UNIMPLEMENTED_ERROR
    end

    # Performs the check on the given project and returns a report.
    #
    # @param project [Project] the project to be checked
    # @return [CheckReport] the report of the check
    # @raise [RuntimeError] if the method is not implemented
    def check(project)
      raise UNIMPLEMENTED_ERROR
    end
  end
end
