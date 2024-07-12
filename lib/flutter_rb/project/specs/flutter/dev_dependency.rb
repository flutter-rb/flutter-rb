# frozen_string_literal: true

module FlutterRb
  # Represents a development dependency in a Flutter project.
  class DevDependency
    # Initializes a new instance of DevDependency.
    #
    # @param name [String] The name of the development dependency.
    # @param version [String] The version of the development dependency.
    def initialize(name, version)
      @name = name
      @version = version
    end

    # Returns the name of the development dependency.
    #
    # @return [String] The name of the development dependency.
    attr_reader :name

    # Returns the version of the development dependency.
    #
    # @return [String] The version of the development dependency.
    attr_reader :version
  end
end
