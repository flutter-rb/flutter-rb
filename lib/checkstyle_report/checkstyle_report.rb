require 'nokogiri'

module CheckstyleReport
  # Class for create report in Checkstyle format
  class CheckstyleReport
    def initialize(path, report_filename, errors)
      @path = path
      @report_filename = report_filename
      @errors = errors
    end

    # rubocop:disable Metrics/MethodLength
    def create_report
      report = Nokogiri::XML::Builder.new do |xml|
        xml.checkstyle(version: '8.38') do
          @errors.map do |error|
            xml.error(
              line: error.line,
              column: error.column,
              saverity: error.saverity,
              message: error.message,
              source: error.source
            )
          end
        end
      end
      File.open("#{@path}/#{@report_filename}.xml", 'w') do |file|
        file.write(report.to_xml)
      end
    end
    # rubocop:enable Metrics/MethodLength
  end

  # Checkstyle error representation
  class CheckstyleError
    # rubocop:disable Metrics/ParameterLists
    def initialize(
      saverity,
      message,
      source,
      line,
      column,
      name
    )
      @saverity = saverity
      @message = message
      @source = source
      @line = line
      @column = column
      @name = name
    end
    # rubocop:enable Metrics/ParameterLists

    attr_reader :saverity, :message, :source, :line, :column, :name
  end
end
