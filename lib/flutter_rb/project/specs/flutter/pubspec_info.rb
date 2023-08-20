module FlutterRb
  # Flutter plugin info from pubspec.yaml
  class PubspecInfo
    # @param {String} name
    # @param {String} description
    # @param {String} version
    # @param {String} author
    # @param {String} homepage
    def initialize(name, description, version, author, homepage)
      @name = name
      @description = description
      @version = version
      @author = author
      @homepage = homepage
    end

    attr_reader :name, :description, :version, :author, :homepage
  end
end
