# frozen_string_literal: true

module FlutterRb
  # Dev dependency, contains name and version
  class DevDependency
    # @param {String} name
    # @param {String} version
    def initialize(name, version)
      @name = name
      @version = version
    end

    attr_reader :name, :version
  end
end
