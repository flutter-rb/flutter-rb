require 'cocoapods'

module FlutterRb
  # Podspec representation
  class Podspec
    def initialize(
      name,
      version,
      authors,
      source
    )
      @name = name
      @version = version
      @authors = authors
      @source = source
    end

    attr_reader :name, :version, :authors, :source
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
        podspec.authors.nil? ? podspec.author : podspec.authors,
        podspec.source
      )
    end
  end
end
