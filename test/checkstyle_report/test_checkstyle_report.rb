require_relative '../test__helper.rb'
require_relative '../../lib/checkstyle_report/checkstyle_report'

require 'minitest/autorun'
require 'nokogiri'

class CheckstyleReportTest < Minitest::Test
  def test_checkstyle_report_creation
    path = './test_assets/checkstyle_report'
    filename = 'checkstyle-report'
    errors = [
      CheckstyleReport::CheckstyleError.new(
        'error',
        'Test message',
        'pubspec.yaml',
        '1',
        '1',
        'PubspecTestError'
      ),
      CheckstyleReport::CheckstyleError.new(
        'warning',
        'Test message',
        'pubspec.yaml',
        '1',
        '1',
        'PubspecTestWarning'
      ),
    ]

    checkstyle_report = CheckstyleReport::CheckstyleReport.new(
      path,
      filename,
      errors
    )
    checkstyle_report.create_report()

    report_in_xml = File.open('./test_assets/checkstyle_report/checkstyle-report.xml') do |file|
      Nokogiri::XML(file)
    end

    checkstyle_block = report_in_xml.xpath('//checkstyle')
    assert checkstyle_block.length == 1

    errors_block = checkstyle_block.xpath('//error')
    assert errors_block.length == 2

    first_error = errors_block.first
    assert first_error.attr('saverity') == 'error'
    assert first_error.attr('line') == '1'
    assert first_error.attr('message') == 'Test message'
    assert first_error.attr('source') == 'pubspec.yaml'
    assert first_error.attr('line') == '1'
    assert first_error.attr('column') == '1'
    assert first_error.attr('name').nil?

    second_error = errors_block.last
    assert second_error.attr('saverity') == 'warning'
    assert second_error.attr('line') == '1'
    assert second_error.attr('message') == 'Test message'
    assert second_error.attr('source') == 'pubspec.yaml'
    assert second_error.attr('line') == '1'
    assert second_error.attr('column') == '1'
    assert second_error.attr('name').nil?
  end
end
