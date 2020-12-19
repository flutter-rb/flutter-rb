require_relative '../../test__helper.rb'
require_relative '../../../lib/flutter-rb/report/check_report.rb'

require 'minitest/autorun'

class CheckReportTest < Minitest::Test
  def test_print
    report = FlutterRb::CheckReport.new(
        'Name',
        FlutterRb::CheckReportStatus::NORMAL,
        'Message'
    )

    assert report.print(colorize: false) == " * [#{FlutterRb::CheckReportStatus::NORMAL}] Name: Message"
  end
end
