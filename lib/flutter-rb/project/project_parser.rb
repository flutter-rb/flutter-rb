require_relative './project'
require_relative './android_folder'
require_relative './ios_folder'

require 'yaml'

module FlutterRb
  class ProjectParser
    def initialize(path)
      @path = path
    end

    def project
      pubspec_path = "#{@path}/pubspec.yaml"
      if File.exist?(pubspec_path)
        return Project.new(
          YAML.load_file(pubspec_path).inspect,
          AndroidFolder.new(File.exist?("#{@path}/android")),
          IOSFolder.new(File.exist?("#{@path}/ios"))
        )
      end
      nil
    end
  end
end
