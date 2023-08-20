require_relative 'check'
require_relative '../report/check_report'

module FlutterRb
  # Base class for all info parameters in Flutter plugin pubspec.yaml file
  class PluginPubspecCheck < Check
    # @return {String}
    def name
      "PluginPubspec#{pubspec_parameter.capitalize}Check"
    end

    # @return {String}
    def pubspec_parameter
      raise UNIMPLEMENTED_ERROR
    end

    # @return {String}
    def summary
      "Validate Flutter plugin's #{pubspec_parameter} in pubspec.yaml"
    end
  end

  # Check Flutter plugin name in podspec file. Exists or not
  class PluginPubspecNameCheck < PluginPubspecCheck
    # @return {String}
    def pubspec_parameter
      'name'
    end

    # @return {String}
    def description
      'Check plugin name in pubspec file'
    end

    # @param {Project} project
    # @return {CheckReport}
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

  # Check Flutter plugin description in pubspec file. Exists or not
  class PluginPubspecDescriptionCheck < PluginPubspecCheck
    # @return {String}
    def pubspec_parameter
      'description'
    end

    # @return {String}
    def description
      'Check plugin description in pubspec file'
    end

    # @param {Project} project
    # @return {CheckReport}
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

  # Check Flutter plugin version in pubspec file. Exists or not
  class PluginPubspecVersionCheck < PluginPubspecCheck
    # @return {String}
    def pubspec_parameter
      'version'
    end

    # @return {String}
    def description
      'Check plugin version in pubspec'
    end

    # @param {Project} project
    # @return {CheckReport}
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

  # Check Flutter plugin author in pubspec file. Exists or not
  class PluginPubspecAuthorCheck < PluginPubspecCheck
    # @return {String}
    def pubspec_parameter
      'author'
    end

    # @return {String}
    def description
      'Check plugin author in pubspec'
    end

    # @param {Project} project
    # @return {CheckReport}
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

  # Check Flutter plugin homepage in pubspec file. Exists or not
  class PluginPubspecHomepageCheck < PluginPubspecCheck
    # @return {String}
    def pubspec_parameter
      'homepage'
    end

    # @return {String}
    def description
      'Check plugin homepage in pubspec'
    end

    # @param {Project} project
    # @return {CheckReport}
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

  # Check Flutter plugin lints dependency in pubspec file. Exists or not
  class PluginPubspecLintsCheck < Check
    # @return {String}
    def name
      'PluginPubspecLintsCheck'
    end

    # @return {String}
    def summary
      'Validate Flutter plugin\'s lints rules implementation in pubspec.yaml'
    end

    # @return {String}
    def description
      'Check Flutter plugin lints dependency in pubspec file'
    end

    # @param {Project} project
    # @return {CheckReport}
    def check(project)
      pubspec = project.pubspec
      lints = pubspec.dev_dependencies&.detect do |dev_dependency|
        dev_dependency.name == 'lints'
      end
      CheckReport.new(
        name,
        lints.nil? ? CheckReportStatus::ERROR : CheckReportStatus::NORMAL,
        description,
        pubspec.path
      )
    end
  end
end
