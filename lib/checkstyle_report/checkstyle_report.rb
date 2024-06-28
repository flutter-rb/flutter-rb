# frozen_string_literal: true

require 'nokogiri'

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
    # @return [Hash<String, Array<CheckstyleError>>] A hash where the keys are file names
    # and the values are arrays of CheckstyleError objects
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

  # Represents a file in Checkstyle format.
  class CheckstyleFile
    # Initializes a new instance of CheckstyleFile.
    #
    # @param file [String] The name of the file.
    # @param errors [Array<CheckstyleError>] An array of CheckstyleError objects related to this file.
    def initialize(file, errors)
      @file = file
      @errors = errors
    end

    # Returns the name of the file.
    #
    # @return [String] The name of the file.
    attr_reader :file

    # Returns the array of CheckstyleError objects related to this file.
    #
    # @return [Array<CheckstyleError>] An array of CheckstyleError objects related to this file.
    attr_reader :errors
  end

  # Represents a single error in Checkstyle format.
  class CheckstyleError
    # Severity levels for Checkstyle errors.
    SEVERITY_NORMAL = 'normal'
    SEVERITY_WARNING = 'warning'
    SEVERITY_ERROR = 'error'

    # Initializes a new instance of CheckstyleError.
    #
    # @param severity [CheckstyleError] The severity level of the error.
    # Must be one of SEVERITY_NORMAL, SEVERITY_WARNING, or SEVERITY_ERROR.
    # @param message [String] The error message.
    # @param source [String] The source of the error.
    # @param line [Integer] The line number where the error occurred.
    # @param column [Integer] The column number where the error occurred.
    # @param name [String] The name of the error.
    def initialize(severity, message, source, line, column, name)
      @severity = severity
      @message = message
      @source = source
      @line = line
      @column = column
      @name = name
    end

    # Returns the severity level of the error.
    #
    # @return [String] The severity level of the error.
    attr_reader :severity

    # Returns the error message.
    #
    # @return [String] The error message.
    attr_reader :message

    # Returns the source of the error.
    #
    # @return [String] The source of the error.
    attr_reader :source

    # Returns the line number where the error occurred.
    #
    # @return [Integer] The line number where the error occurred.
    attr_reader :line

    # Returns the column number where the error occurred.
    #
    # @return [Integer] The column number where the error occurred.
    attr_reader :column

    # Returns the name of the error.
    #
    # @return [String] The name of the error.
    attr_reader :name
  end
end
