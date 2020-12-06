require_relative './podspec'

require 'cocoapods'

module FlutterRb
  # iOS representation
  class IOSFolder
    def initialize(path)
      podspec = Pod::Specification.from_file("#{path}/app_rating_message.podspec")
      @podspec = Podspec.new(
        podspec.name,
        podspec.version,
        podspec.summary,
        podspec.homepage,
        podspec.authors
      )
    end

    attr_reader :podspec
  end
end
