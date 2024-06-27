# frozen_string_literal: true

require 'colorize'

module FlutterRb
  # Check report
  # Represents a report for a specific check.
  class CheckReport
    # Initializes a new instance of CheckReport.
    #
    # @param check_name [String] The name of the check.
    # @param check_report_status [CheckReportStatus] The status of the check report.
    # @param message [String] The message associated with the check report.
    # @param path [String] The path associated with the check report.
    def initialize(check_name, check_report_status, message, path)
      @check_name = check_name
      @check_report_status = check_report_status
      @message = message
      @path = path
    end

    # Prints the check report.
    #
    # @param colorize [Bool] Whether to colorize the output or not. Default is true.
    # @return [String] The formatted check report.
    def print(colorize: true)
      if colorize
        status_color = color_for_report_status(@check_report_status)
        " * [#{@check_report_status.colorize(status_color)}] #{@check_name}: #{@message}"
      else
        " * [#{@check_report_status}] #{@check_name}: #{@message}"
      end
    end

    # Determines the color for the check report status.
    #
    # @param check_report_status [CheckReportStatus] The status of the check report.
    # @return [Symbol] The color associated with the check report status.
    def color_for_report_status(check_report_status)
      case check_report_status
      when CheckReportStatus::NORMAL
        :green
      when CheckReportStatus::WARNING
        :yellow
      when CheckReportStatus::ERROR
        :red
      else
        :blue
      end
    end

    # Reader for check_name attribute.
    attr_reader :check_name

    # Reader for check_report_status attribute.
    attr_reader :check_report_status

    # Reader for message attribute.
    attr_reader :message

    # Reader for path attribute.
    attr_reader :path
  end

  # Check report status
  class CheckReportStatus
    NORMAL = 'normal'
    WARNING = 'warning'
    ERROR = 'error'
  end
end
