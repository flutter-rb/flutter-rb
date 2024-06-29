# frozen_string_literal: true

require_relative 'check'
require_relative '../report/check_report'

module FlutterRb
  # This class represents a check for Flutter plugin's podspec file.
  # It is an abstract class and should be subclassed to perform specific checks.
  class PluginPodspecCheck < Check
    # Returns the name of the check.
    # The name is constructed by appending the capitalized podspec_parameter to "PluginPodspecCheck".
    #
    # @return [String] the name of the check
    def name
      "PluginPodspec#{podspec_parameter.capitalize}Check"
    end

    # Returns the parameter for which the check is performed in the podspec file.
    # This method should be implemented in subclasses to specify the specific parameter.
    #
    # @raise [RuntimeError] if the method is not implemented in a subclass
    # @return [String] the parameter for which the check is performed
    def podspec_parameter
      raise UNIMPLEMENTED_ERROR
    end

    # Returns the description of the check.
    # The description explains the purpose of the check,
    # which is to validate a specific parameter in the Flutter plugin's podspec file.
    #
    # @return [String] the description of the check
    def description
      "Validate Flutter plugin's #{podspec_parameter} in podspec file"
    end
  end

  # This class represents a check for Flutter plugin's name in the podspec file.
  # It is a subclass of PluginPodspecCheck and overrides the necessary methods to perform the specific check.
  class PluginPodspecNameCheck < PluginPodspecCheck
    # Returns the parameter for which the check is performed in the podspec file.
    # In this case, it returns 'name'.
    #
    # @return [String] the parameter for which the check is performed
    def podspec_parameter
      'name'
    end

    # Performs the check for the plugin's name in the podspec file.
    # It compares the name in the pubspec file with the name in the podspec file.
    # If they match, it returns a CheckReport with a normal status.
    # If they do not match, it returns a CheckReport with a warning status.
    #
    # @param project [Project] the project for which the check is performed
    # @return [CheckReport] the report of the check
    def check(project)
      name_in_pubspec = project.pubspec.pubspec_info.name
      podspec = project.ios_folder.podspec
      name_in_podspec = podspec.name

      CheckReport.new(
        name,
        name_in_pubspec == name_in_podspec ? ::CheckReportStatus::NORMAL : ::CheckReportStatus::WARNING,
        description,
        podspec.path
      )
    end
  end

  # This class represents a check for Flutter plugin's version in the podspec file.
  # It is a subclass of PluginPodspecCheck and overrides the necessary methods to perform the specific check.
  class PluginPodspecVersionCheck < PluginPodspecCheck
    # Returns the parameter for which the check is performed in the podspec file.
    # In this case, it returns 'version'.
    #
    # @return [String] the parameter for which the check is performed
    def podspec_parameter
      'version'
    end

    # Performs the check for the plugin's version in the podspec file.
    # It compares the version in the pubspec file with the version in the podspec file.
    # If they match, it returns a CheckReport with a normal status.
    # If they do not match, it returns a CheckReport with a warning status.
    #
    # @param project [Project] the project for which the check is performed
    # @return [CheckReport] the report of the check
    def check(project)
      version_in_pubspec = project.pubspec.pubspec_info.version
      podspec = project.ios_folder.podspec
      version_in_podspec = podspec.version

      CheckReport.new(
        name,
        version_in_pubspec == version_in_podspec ? ::CheckReportStatus::NORMAL : ::CheckReportStatus::WARNING,
        description,
        podspec.path
      )
    end
  end

  # This class represents a check for Flutter plugin's authors in the podspec file.
  # It is a subclass of PluginPodspecCheck and overrides the necessary methods to perform the specific check.
  class PluginPodspecAuthorsCheck < PluginPodspecCheck
    # Returns the parameter for which the check is performed in the podspec file.
    # In this case, it returns 'authors'.
    #
    # @return [String] the parameter for which the check is performed
    def podspec_parameter
      'authors'
    end

    # Performs the check for the plugin's authors in the podspec file.
    # It checks if the 'authors' parameter is present in the podspec file.
    # If it is present, it returns a CheckReport with a normal status.
    # If it is not present, it returns a CheckReport with an error status.
    #
    # @param project [Project] the project for which the check is performed
    # @return [CheckReport] the report of the check
    def check(project)
      podspec = project.ios_folder.podspec
      author_exists = !podspec.authors.nil?

      CheckReport.new(
        name,
        author_exists ? ::CheckReportStatus::NORMAL : ::CheckReportStatus::ERROR,
        description,
        podspec.path
      )
    end
  end

  # This class represents a check for Flutter plugin's source in the podspec file.
  # It is a subclass of PluginPodspecCheck and overrides the necessary methods to perform the specific check.
  class PluginPodspecSourceCheck < PluginPodspecCheck
    # Returns the parameter for which the check is performed in the podspec file.
    # In this case, it returns 'source'.
    #
    # @return [String] the parameter for which the check is performed
    def podspec_parameter
      'source'
    end

    # Performs the check for the plugin's source in the podspec file.
    # It checks if the 'source' parameter is present in the podspec file.
    # If it is present, it returns a CheckReport with a normal status.
    # If it is not present, it returns a CheckReport with an error status.
    #
    # @param project [Project] the project for which the check is performed
    # @return [CheckReport] the report of the check
    def check(project)
      podspec = project.ios_folder.podspec

      CheckReport.new(
        name,
        podspec.source.nil? ? ::CheckReportStatus::ERROR : ::CheckReportStatus::NORMAL,
        description,
        podspec.path
      )
    end
  end
end
