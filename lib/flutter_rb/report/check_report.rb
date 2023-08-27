# frozen_string_literal: true

require 'colorize'

module FlutterRb
  # Check report
  class CheckReport
    # @param {String} check_name
    # @param {CheckReportStatus} check_report_status
    # @param {String} message
    # @param {String} path
    def initialize(check_name, check_report_status, message, path)
      @check_name = check_name
      @check_report_status = check_report_status
      @message = message
      @path = path
    end

    # @param {Bool} colorize
    # @return {String}
    def print(colorize: true)
      if colorize
        status_color = color_for_report_status(@check_report_status)
        " * [#{@check_report_status.colorize(status_color)}] #{@check_name}: #{@message}"
      else
        " * [#{@check_report_status}] #{@check_name}: #{@message}"
      end
    end

    # @param {CheckReportStatus} check_report_status
    # @return {Presenter}
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

    attr_reader :check_name, :check_report_status, :message, :path
  end

  # Check report status
  class CheckReportStatus
    NORMAL = 'normal'
    WARNING = 'warning'
    ERROR = 'error'
  end
end
