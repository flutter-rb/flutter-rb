# frozen_string_literal: true

require_relative 'check'
require_relative '../report/check_report'

module FlutterRb
  # This class represents a check for plugin directories structure in a Flutter project.
  class PluginDirectoriesCheck < Check
    # Returns the name of the check.
    #
    # @return [String] The name of the check.
    def name
      'PluginDirectoriesCheck'
    end

    # Returns a description of the check.
    #
    # @return [String] A description of the check.
    def description
      'Check plugin directories structure in pubspec file'
    end

    # Performs the check on the given project.
    #
    # @param project [Project] The project to perform the check on.
    # @return [CheckReport] The report of the check result.
    def check(project)
      # Check if android and ios folders exist.
      android_exists = !project.android_folder.nil?
      ios_exists = !project.ios_folder.nil?

      # Determine the check result based on the existence of android and ios folders.
      check_result = android_exists && ios_exists || !android_exists && !ios_exists

      # Create a new CheckReport with the result.
      CheckReport.new(
        name,
        check_result ? CheckReportStatus::NORMAL : CheckReportStatus::ERROR,
        description,
        project.path
      )
    end
  end
end
