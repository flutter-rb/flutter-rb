require 'nokogiri'

# Module with classes for creating reports in Checkstyle format
module CheckstyleReport
  # Class for create report in Checkstyle format
  class CheckstyleReport
    def initialize(path, report_filename, checks)
      @path = path
      @report_filename = report_filename
      @checks = checks
    end

    def create_report
      checkstyle_files = sort_checks(@checks)
      report = Nokogiri::XML::Builder.new do |xml|
        xml.checkstyle(version: '8.38') do
          checkstyle_files
            .map { |file, errors| CheckstyleFile.new(file, errors) }
            .each { |file| write_file(xml, file) }
        end
      end
      File.open("#{@path}/#{@report_filename}.xml", 'w') { |file| file.write(report.to_xml) }
    end

    def sort_checks(checks)
      checkstyle_files = {}
      checks.each do |check|
        checkstyle_file = checkstyle_files[check.source]
        checkstyle_files[check.source] = [] if checkstyle_file.nil?
        checkstyle_files[check.source] += [check] if check.severity != CheckstyleError::SEVERITY_NORMAL
      end
      checkstyle_files
    end

    def write_file(xml, checkstyle_file)
      xml.file(name: checkstyle_file.file) do
        checkstyle_file.errors.each do |error|
          write_error(xml, error)
        end
      end
    end

    def write_error(xml, error)
      xml.error(
        line: error.line,
        column: error.column,
        severity: error.severity,
        message: error.message,
        source: error.source
      )
    end
  end

  # File representation for Checkstyle format
  class CheckstyleFile
    def initialize(file, errors)
      @file = file
      @errors = errors
    end

    attr_reader :file, :errors
  end

  # Checkstyle error representation
  class CheckstyleError
    SEVERITY_NORMAL = 'normal'.freeze
    SEVERITY_WARNING = 'warning'.freeze
    SEVERITY_ERROR = 'error'.freeze

    # rubocop:disable Metrics/ParameterLists
    def initialize(
      severity,
      message,
      source,
      line,
      column,
      name
    )
      @severity = severity
      @message = message
      @source = source
      @line = line
      @column = column
      @name = name
    end
    # rubocop:enable Metrics/ParameterLists

    attr_reader :severity, :message, :source, :line, :column, :name
  end
end
