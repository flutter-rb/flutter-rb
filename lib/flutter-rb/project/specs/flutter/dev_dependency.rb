module FlutterRb
  # Dev dependency, contains name and version
  class DevDependency
    def initialize(name, version)
      @name = name
      @version = version
    end

    attr_reader :name, :version
  end
end
