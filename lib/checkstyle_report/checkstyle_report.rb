# frozen_string_literal: true

require 'nokogiri'

# Module with classes for creating reports in Checkstyle format
module CheckstyleReport
  # Class for create report in Checkstyle format
  class CheckstyleReport
    # Initializes a new instance of CheckstyleReport
    #
    # @param path [String] The path where the report file will be saved
    # @param report_filename [String] The name of the report file
    # @param checks [Array<CheckstyleError>] An array of CheckstyleError objects
    def initialize(path, report_filename, checks)
      @path = path
      @report_filename = report_filename
      @checks = checks
    end

    # Creates a Checkstyle report XML file
    #
    # This method groups the errors by file, creates a new CheckstyleFile object for each file,
    # and writes the report to an XML file.
    def create_report
      checkstyle_files = sort_checks(@checks)
      report = Nokogiri::XML::Builder.new do |xml|
        xml.checkstyle(version: '8.38') do
          checkstyle_files
            .map { |file, errors| CheckstyleFile.new(file, errors) }
            .each { |file| write_file(xml, file) }
        end
      end
      File.open("#{@path}/#{@report_filename}.xml", 'w') do |file|
        file.write(report.to_xml)
      end
    end

    # Sorts the checks by file
    #
    # @param checks [Array<CheckstyleError>] An array of CheckstyleError objects
    # @return [Hash<String, Array<CheckstyleError>>] A hash where the keys are file names and the values are arrays of CheckstyleError objects
    def sort_checks(checks)
      checkstyle_files = {}
      checks.each do |check|
        checkstyle_file = checkstyle_files[check.source]
        checkstyle_files[check.source] = [] if checkstyle_file.nil?
        checkstyle_files[check.source] += [check] if check.severity != CheckstyleError::SEVERITY_NORMAL
      end
      checkstyle_files
    end

    # Writes a file element to the XML report
    #
    # @param xml [Nokogiri::XML::Builder] The XML builder object
    # @param checkstyle_file [CheckstyleFile] The CheckstyleFile object to be written
    def write_file(xml, checkstyle_file)
      xml.file(name: checkstyle_file.file) do
        checkstyle_file.errors.each do |error|
          write_error(xml, error)
        end
      end
    end

    # Writes an error element to the XML report
    #
    # @param xml [Nokogiri::XML::Builder] The XML builder object
    # @param error [CheckstyleError] The CheckstyleError object to be written
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
    # @param {String} file
    # @param {CheckstyleError[]} errors
    def initialize(file, errors)
      @file = file
      @errors = errors
    end

    attr_reader :file, :errors
  end

  # Checkstyle error representation
  class CheckstyleError
    SEVERITY_NORMAL = 'normal'
    SEVERITY_WARNING = 'warning'
    SEVERITY_ERROR = 'error'

    # @param {String} severity
    # @param {String} message
    # @param {String} source
    # @param {Integer} line
    # @param {Integer} column
    # @param {String} name
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

    attr_reader :severity, :message, :source, :line, :column, :name
  end
end
