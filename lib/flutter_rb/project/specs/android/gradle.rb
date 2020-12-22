module FlutterRb
  # Gradle representation
  class Gradle
    def initialize(version)
      @version = version
    end

    attr_reader :version
  end

  # Gradle parser
  class GradleParser
    def initialize(path)
      @path = path
    end

    def parse
      config = parse_gradle_config(@path)
      Gradle.new(
        config[:version]
      )
    end

    private

    def parse_gradle_config(file)
      parameters = {}
      File.open file do |opened_file|
        opened_file.find do |line|
          parameters[:version] = line[8, line.length].gsub(/\s|"|'/, '') if line.start_with?('version')
        end
      end
      parameters
    end
  end
end