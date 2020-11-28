require_relative 'check_report_status'

module FlutterRb
  class CheckReport
    def initialize(check_name, check_report_status, message)
      @check_name = check_name
      @check_report_status = check_report_status
      @message = message
    end

    def print
      "[#{@check_report_status}] #{@check_name}: #{@message}"
    end

    attr_reader :check_report_status
  end
end
