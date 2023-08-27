# frozen_string_literal: true

require 'nokogiri'

# Module with classes for creating reports in Checkstyle format
module CheckstyleReport
  # Class for create report in Checkstyle format
  class CheckstyleReport
    # @param {String} path
    # @param {String} report_filename
    # @param {CheckstyleError[]}
    def initialize(path, report_filename, checks)
      @path = path
      @report_filename = report_filename
      @checks = checks
    end

    # rubocop:disable Metrics/MethodLength
    # noinspection RubyResolve
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

    # rubocop:enable Metrics/MethodLength

    # @param {CheckstyleError} checks
    # @return {CheckstyleFile[]}
    def sort_checks(checks)
      checkstyle_files = {}
      checks.each do |check|
        checkstyle_file = checkstyle_files[check.source]
        checkstyle_files[check.source] = [] if checkstyle_file.nil?
        checkstyle_files[check.source] += [check] if check.severity != CheckstyleError::SEVERITY_NORMAL
      end
      checkstyle_files
    end

    # @param {XML} xml
    # @param {CheckstyleFile} checkstyle_file
    def write_file(xml, checkstyle_file)
      xml.file(name: checkstyle_file.file) do
        checkstyle_file.errors.each do |error|
          write_error(xml, error)
        end
      end
    end

    # @param {XML} xml
    # @param {CheckstyleError} error
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

    # rubocop:disable Metrics/ParameterLists
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

    # rubocop:enable Metrics/ParameterLists

    attr_reader :severity, :message, :source, :line, :column, :name
  end
end
