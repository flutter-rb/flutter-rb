require 'json'

module FlutterRb
  # Gradle representation
  class Gradle
    # @param {String} path
    # @param {String} version
    def initialize(path, version)
      @path = path
      @version = version
    end

    attr_reader :path, :version
  end

  # Gradle parser
  class GradleParser
    # @param {String} path
    def initialize(path)
      @path = path
    end

    # @return {Gradle}
    def parse
      `gradle -p #{@path} -q prepareInfo`
      info_file = File.read "#{@path}/flutter_rb_gradle_plugin_output.json"
      info = JSON.parse info_file
      Gradle.new(@path, info['version'])
    end
  end
end
