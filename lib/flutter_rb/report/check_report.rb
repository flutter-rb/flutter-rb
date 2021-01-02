require 'colorize'

module FlutterRb
  # Check report
  class CheckReport
    def initialize(check_name, check_report_status, message)
      @check_name = check_name
      @check_report_status = check_report_status
      @message = message
    end

    def print(colorize: true)
      if colorize
        status_color = color_for_report_status(@check_report_status)
        " * [#{@check_report_status.colorize(status_color)}] #{@check_name}: #{@message}"
      else
        " * [#{@check_report_status}] #{@check_name}: #{@message}"
      end
    end

    def color_for_report_status(check_report_status)
      case check_report_status
      when CheckReportStatus::NORMAL
        :green
      when CheckReportStatus::WARNING
        :yellow
      when CheckReportStatus::ERROR
        :red
      end
    end

    attr_reader :check_name, :check_report_status, :message
  end

  # Check report status
  class CheckReportStatus
    NORMAL = 'normal'.freeze
    WARNING = 'warning'.freeze
    ERROR = 'error'.freeze
  end
end
