require_relative '../../test_helper'
require_relative '../../../lib/flutter_rb/report/check_report.rb'

require 'minitest/autorun'

class CheckReportTest < Minitest::Test
  def test_print
    report = FlutterRb::CheckReport.new(
      'Name',
      FlutterRb::CheckReportStatus::NORMAL,
      'Message',
      'path'
    )

    assert_equal(
      " * [#{FlutterRb::CheckReportStatus::NORMAL}] Name: Message",
      report.print(colorize: false)
    )
  end
end
