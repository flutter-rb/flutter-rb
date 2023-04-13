require_relative 'check'
require_relative '../report/check_report'

module FlutterRb
  # Base class for all info parameters in Flutter plugin pubspec.yaml file
  class PluginPubspecCheck < Check
    def name
      "PluginPubspec#{pubspec_parameter.capitalize}Check"
    end

    def pubspec_parameter
      raise UNIMPLEMENTED_ERROR
    end

    def summary
      "Validate Flutter plugin's #{pubspec_parameter} in pubspec.yaml"
    end
  end

  # Check Flutter plugin name in podspec file. Exists or not
  class PluginPubspecNameCheck < PluginPubspecCheck
    def pubspec_parameter
      'name'
    end

    def check(project)
      pubspec = project.pubspec
      CheckReport.new(
        name,
        pubspec.pubspec_info.name.nil? ? CheckReportStatus::ERROR : CheckReportStatus::NORMAL,
        description,
        pubspec.path
      )
    end

    def description
      'Check plugin name in pubspec file'
    end
  end

  # Check Flutter plugin description in pubspec file. Exists or not
  class PluginPubspecDescriptionCheck < PluginPubspecCheck
    def pubspec_parameter
      'description'
    end

    def check(project)
      pubspec = project.pubspec
      CheckReport.new(
        name,
        pubspec.pubspec_info.description.nil? ? CheckReportStatus::WARNING : CheckReportStatus::NORMAL,
        description,
        pubspec.path
      )
    end

    def description
      'Check plugin description in pubspec file'
    end
  end

  # Check Flutter plugin version in pubspec file. Exists or not
  class PluginPubspecVersionCheck < PluginPubspecCheck
    def pubspec_parameter
      'version'
    end

    def check(project)
      pubspec = project.pubspec
      CheckReport.new(
        name,
        pubspec.pubspec_info.version.nil? ? CheckReportStatus::ERROR : CheckReportStatus::NORMAL,
        description,
        pubspec.path
      )
    end

    def description
      'Check plugin version in pubspec'
    end
  end

  # Check Flutter plugin author in pubspec file. Exists or not
  class PluginPubspecAuthorCheck < PluginPubspecCheck
    def pubspec_parameter
      'author'
    end

    def check(project)
      pubspec = project.pubspec
      CheckReport.new(
        name,
        pubspec.pubspec_info.author.nil? ? CheckReportStatus::NORMAL : CheckReportStatus::WARNING,
        description,
        pubspec.path
      )
    end

    def description
      'Check plugin author in pubspec'
    end
  end

  # Check Flutter plugin homepage in pubspec file. Exists or not
  class PluginPubspecHomepageCheck < PluginPubspecCheck
    def pubspec_parameter
      'homepage'
    end

    def check(project)
      pubspec = project.pubspec
      CheckReport.new(
        name,
        pubspec.pubspec_info.homepage.nil? ? CheckReportStatus::ERROR : CheckReportStatus::NORMAL,
        description,
        pubspec.path
      )
    end

    def description
      'Check plugin homepage in pubspec'
    end
  end

  # Check Flutter plugin Effective Dart depencency in pubspec file. Exists or not
  class PluginPubspecEffectiveDartCheck < Check
    def name
      'PluginPubspecEffectiveDartCheck'
    end

    def summary
      'Validate Flutter plugin\'s Effective Dart rules implementation in pubspec.yaml'
    end

    def check(project)
      pubspec = project.pubspec
      effective_dart = pubspec.dev_dependencies&.detect do |dev_dependency|
        dev_dependency.name == 'effective_dart'
      end
      CheckReport.new(
        name,
        effective_dart.nil? ? CheckReportStatus::ERROR : CheckReportStatus::NORMAL,
        description,
        pubspec.path
      )
    end

    def description
      'Check Flutter plugin Effective Dart depencency in pubspec file'
    end
  end
end
