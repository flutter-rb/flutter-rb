# frozen_string_literal: true

require_relative 'check'
require_relative '../report/check_report'

module FlutterRb
  # This class represents a check for Flutter plugin's pubspec.yaml file.
  # It is an abstract class and should be subclassed to perform specific checks.
  class PluginPubspecCheck < Check
    # Returns the name of the check.
    # The name is constructed by appending the capitalized pubspec_parameter to "PluginPubspecCheck".
    #
    # @return [String] the name of the check
    def name
      "PluginPubspec#{pubspec_parameter.capitalize}Check"
    end

    # Returns the parameter to be checked in the pubspec.yaml file.
    # This method should be implemented in subclasses to specify the specific parameter to be checked.
    #
    # @raise [NotImplementedError] if not implemented in subclasses
    # @return [String] the parameter to be checked
    def pubspec_parameter
      raise UNIMPLEMENTED_ERROR
    end

    # Returns the description of the check.
    # The description explains what the check is validating.
    #
    # @return [String] the description of the check
    def description
      "Validate Flutter plugin's #{pubspec_parameter} in pubspec.yaml"
    end
  end

  # This class represents a check for Flutter plugin's pubspec.yaml file for 'name' parameter.
  # It inherits from PluginPubspecCheck class.
  class PluginPubspecNameCheck < PluginPubspecCheck
    # Returns the parameter to be checked in the pubspec.yaml file.
    # In this case, it returns 'name'.
    #
    # @return [String] the parameter to be checked
    def pubspec_parameter
      'name'
    end

    # Returns the description of the check.
    # The description explains what the check is validating.
    #
    # @return [String] the description of the check
    def description
      'Check plugin name in pubspec file'
    end

    # Performs the check for the 'name' parameter in the pubspec.yaml file.
    # It creates a CheckReport object with the result of the check.
    #
    # @param project [Project] the project to be checked
    # @return [CheckReport] the report of the check result
    def check(project)
      pubspec = project.pubspec

      CheckReport.new(
        name,
        pubspec.pubspec_info.name.nil? ? CheckReportStatus::ERROR : CheckReportStatus::NORMAL,
        description,
        pubspec.path
      )
    end
  end

  # This class represents a check for Flutter plugin's pubspec.yaml file for 'description' parameter.
  # It inherits from PluginPubspecCheck class.
  class PluginPubspecDescriptionCheck < PluginPubspecCheck
    # Returns the parameter to be checked in the pubspec.yaml file.
    # In this case, it returns 'description'.
    #
    # @return [String] the parameter to be checked
    def pubspec_parameter
      'description'
    end

    # Returns the description of the check.
    # The description explains what the check is validating.
    #
    # @return [String] the description of the check
    def description
      'Check plugin description in pubspec file'
    end

    # Performs the check for the 'description' parameter in the pubspec.yaml file.
    # It creates a CheckReport object with the result of the check.
    #
    # @param project [Project] the project to be checked
    # @return [CheckReport] the report of the check result
    def check(project)
      pubspec = project.pubspec

      CheckReport.new(
        name,
        pubspec.pubspec_info.description.nil? ? CheckReportStatus::WARNING : CheckReportStatus::NORMAL,
        description,
        pubspec.path
      )
    end
  end

  # This class represents a check for Flutter plugin's pubspec.yaml file for 'version' parameter.
  # It inherits from PluginPubspecCheck class.
  class PluginPubspecVersionCheck < PluginPubspecCheck
    # Returns the parameter to be checked in the pubspec.yaml file.
    # In this case, it returns 'version'.
    #
    # @return [String] the parameter to be checked
    def pubspec_parameter
      'version'
    end

    # Returns the description of the check.
    # The description explains what the check is validating.
    #
    # @return [String] the description of the check
    def description
      'Check plugin version in pubspec'
    end

    # Performs the check for the 'version' parameter in the pubspec.yaml file.
    # It creates a CheckReport object with the result of the check.
    #
    # @param project [Project] the project to be checked
    # @return [CheckReport] the report of the check result
    def check(project)
      pubspec = project.pubspec

      CheckReport.new(
        name,
        pubspec.pubspec_info.version.nil? ? CheckReportStatus::ERROR : CheckReportStatus::NORMAL,
        description,
        pubspec.path
      )
    end
  end

  # This class represents a check for Flutter plugin's pubspec.yaml file for 'author' parameter.
  # It inherits from PluginPubspecCheck class.
  class PluginPubspecAuthorCheck < PluginPubspecCheck
    # Returns the parameter to be checked in the pubspec.yaml file.
    # In this case, it returns 'author'.
    #
    # @return [String] the parameter to be checked
    def pubspec_parameter
      'author'
    end

    # Returns the description of the check.
    # The description explains what the check is validating.
    #
    # @return [String] the description of the check
    def description
      'Check plugin author in pubspec'
    end

    # Performs the check for the 'author' parameter in the pubspec.yaml file.
    # It creates a CheckReport object with the result of the check.
    #
    # @param project [Project] the project to be checked
    # @return [CheckReport] the report of the check result
    def check(project)
      pubspec = project.pubspec

      CheckReport.new(
        name,
        pubspec.pubspec_info.author.nil? ? CheckReportStatus::NORMAL : CheckReportStatus::WARNING,
        description,
        pubspec.path
      )
    end
  end

  # This class represents a check for Flutter plugin's pubspec.yaml file for 'homepage' parameter.
  # It inherits from PluginPubspecCheck class.
  class PluginPubspecHomepageCheck < PluginPubspecCheck
    # Returns the parameter to be checked in the pubspec.yaml file.
    # In this case, it returns 'homepage'.
    #
    # @return [String] the parameter to be checked
    def pubspec_parameter
      'homepage'
    end

    # Returns the description of the check.
    # The description explains what the check is validating.
    #
    # @return [String] the description of the check
    def description
      'Check plugin homepage in pubspec'
    end

    # Performs the check for the 'homepage' parameter in the pubspec.yaml file.
    # It creates a CheckReport object with the result of the check.
    #
    # @param project [Project] the project to be checked
    # @return [CheckReport] the report of the check result
    def check(project)
      pubspec = project.pubspec

      CheckReport.new(
        name,
        pubspec.pubspec_info.homepage.nil? ? CheckReportStatus::ERROR : CheckReportStatus::NORMAL,
        description,
        pubspec.path
      )
    end
  end

  # This class represents a check for Flutter plugin's pubspec.yaml file for 'lints' dependency.
  # It inherits from the Check class.
  class PluginPubspecLintsCheck < Check
    # Returns the name of the check.
    #
    # @return [String] the name of the check
    def name
      'PluginPubspecLintsCheck'
    end

    # Returns the description of the check.
    # The description explains what the check is validating.
    #
    # @return [String] the description of the check
    def description
      'Check Flutter plugin lints dependency in pubspec file'
    end

    # Performs the check for the 'lints' dependency in the pubspec.yaml file.
    # It creates a CheckReport object with the result of the check.
    #
    # @param project [Project] the project to be checked
    # @return [CheckReport] the report of the check result
    def check(project)
      pubspec = project.pubspec
      # Detects if 'lints' is a dependency in the pubspec file
      lints = pubspec.dev_dependencies&.detect do |dev_dependency|
        dev_dependency.name == 'lints'
      end

      # Creates a CheckReport object with the result of the check
      CheckReport.new(
        name,
        lints.nil? ? CheckReportStatus::ERROR : CheckReportStatus::NORMAL,
        description,
        pubspec.path
      )
    end
  end

  # This class represents a check for Flutter plugin's pubspec.yaml file for 'flutter_lints' dependency.
  # It inherits from the Check class.
  class PluginPubspecFlutterLintsCheck < Check
    # Returns the name of the check.
    #
    # @return [String] the name of the check
    def name
      'PluginPubspecFlutterLintsCheck'
    end

    # Returns the description of the check.
    # The description explains what the check is validating.
    #
    # @return [String] the description of the check
    def description
      'Check Flutter plugin flutter_lints dependency in pubspec file'
    end

    # Performs the check for the 'flutter_lints' dependency in the pubspec.yaml file.
    # It creates a CheckReport object with the result of the check.
    #
    # @param project [Project] the project to be checked
    # @return [CheckReport] the report of the check result
    def check(project)
      pubspec = project.pubspec
      # Detects if 'flutter_lints' is a dependency in the pubspec file
      flutter_lints = pubspec.dev_dependencies&.detect do |dev_dependency|
        dev_dependency.name == 'flutter_lints'
      end

      # Creates a CheckReport object with the result of the check
      CheckReport.new(
        name,
        flutter_lints.nil? ? CheckReportStatus::ERROR : CheckReportStatus::NORMAL,
        description,
        pubspec.path
      )
    end
  end
end
