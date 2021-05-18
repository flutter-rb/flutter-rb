require 'json'

module FlutterRb
  # Gradle representation
  class Gradle
    def initialize(path, version)
      @path = path
      @version = version
    end

    attr_reader :path, :version
  end

  # Gradle parser
  class GradleParser
    def initialize(path)
      @path = path
    end

    def parse
      current_path = Dir.pwd
      Dir.chdir @path
      `gradle -q prepareInfo`
      Dir.chdir current_path
      info_file = File.read "#{@path}/flutter_rb_gradle_plugin_output.json"
      info = JSON.parse info_file
      Gradle.new(@path, info['version'])
    end
  end
end
