# frozen_string_literal: true

require_relative 'check'
require_relative '../report/check_report'

module FlutterRb
  # Base class for all info parameters in Flutter plugin podspec file
  class PluginPodspecCheck < Check
    # @return {String}
    def name
      "PluginPodspec#{podspec_parameter.capitalize}Check"
    end

    # @return {String}
    def podspec_parameter
      raise UNIMPLEMENTED_ERROR
    end

    # @return {String}
    def description
      "Validate Flutter plugin's #{podspec_parameter} in podspec file"
    end
  end

  # Check Flutter plugin name in podspec file. Exists or not
  class PluginPodspecNameCheck < PluginPodspecCheck
    # @return {String}
    def podspec_parameter
      'name'
    end

    # @return {String}
    def description
      'Check plugin name in podspec file'
    end

    # @param {Project} project
    # @return {CheckReport}
    def check(project)
      name_in_pubspec = project.pubspec.pubspec_info.name
      podspec = project.ios_folder.podspec
      name_in_podspec = podspec.name
      CheckReport.new(
        name,
        name_in_pubspec == name_in_podspec ? CheckReportStatus::NORMAL : CheckReportStatus::WARNING,
        description,
        podspec.path
      )
    end
  end

  # Check Flutter plugin version in podspec file. Exists or not
  class PluginPodspecVersionCheck < PluginPodspecCheck
    # @return {String}
    def podspec_parameter
      'version'
    end

    # @return {String}
    def description
      'Check plugin version in podspec file'
    end

    # @param {Project} project
    # @return {CheckReport}
    def check(project)
      version_in_pubspec = project.pubspec.pubspec_info.version
      podspec = project.ios_folder.podspec
      version_in_podspec = podspec.version
      CheckReport.new(
        name,
        version_in_pubspec == version_in_podspec ? CheckReportStatus::NORMAL : CheckReportStatus::WARNING,
        description,
        podspec.path
      )
    end
  end

  # Check Flutter plugin's authors. Exists or not
  class PluginPodspecAuthorsCheck < PluginPodspecCheck
    # @return {String}
    def podspec_parameter
      'authors'
    end

    # @return {String}
    def description
      "Check plugin's authors in podspec file"
    end

    # @param {Project} project
    # @return {CheckReport}
    def check(project)
      podspec = project.ios_folder.podspec
      author_exists = !podspec.authors.nil?
      CheckReport.new(
        name,
        author_exists ? CheckReportStatus::NORMAL : CheckReportStatus::ERROR,
        description,
        podspec.path
      )
    end
  end

  # Check plugin iOS source path in podspec file.
  # If Flutter plugin cannot contains iOS specific code, source path must be '.'
  class PluginPodspecSourceCheck < PluginPodspecCheck
    # @return {String}
    def podspec_parameter
      'source'
    end

    # @return {String}
    def description
      'Check plugin iOS source path in podspec file'
    end

    # @param {Project} project
    # @return {CheckReport}
    def check(project)
      podspec = project.ios_folder.podspec
      CheckReport.new(
        name,
        podspec.source.nil? ? CheckReportStatus::ERROR : CheckReportStatus::NORMAL,
        description,
        podspec.path
      )
    end
  end
end
