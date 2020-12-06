module FlutterRb
  # Podspec representation
  class Podspec
    def initialize(
      name,
      version,
      summary,
      homepage,
      author
    )
      @name = name
      @version = version.version
      @summary = summary
      @homepage = homepage
      @author = author.nil? ? nil : author.first.first
    end

    attr_reader :name, :version, :summary, :homepage, :author
  end
end
