require 'cocoapods'

module FlutterRb
  # Podspec representation
  class Podspec
    def initialize(
      name,
      version,
      source
    )
      @name = name
      @version = version
      @source = source
    end

    attr_reader :name, :version, :source
  end

  # Podspec parser
  class PodspecParser
    def initialize(path)
      @path = path
    end

    def parse
      podspec = Pod::Specification.from_file(@path)
      @podspec = Podspec.new(
        podspec.name,
        podspec.version.version,
        podspec.source
      )
    end
  end
end
