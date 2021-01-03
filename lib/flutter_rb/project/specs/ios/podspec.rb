require 'cocoapods'

module FlutterRb
  # Podspec representation
  class Podspec
    def initialize(
      path,
      name,
      version,
      authors,
      source
    )
      @path = path
      @name = name
      @version = version
      @authors = authors
      @source = source
    end

    attr_reader :path, :name, :version, :authors, :source
  end

  # Podspec parser
  class PodspecParser
    def initialize(path)
      @path = path
    end

    def parse
      podspec = Pod::Specification.from_file(@path)
      @podspec = Podspec.new(
        @path,
        podspec.name,
        podspec.version.version,
        podspec.authors.nil? ? podspec.author : podspec.authors,
        podspec.source
      )
    end
  end
end
