require_relative '../test_helper'
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
    checkstyle_report.create_report

    report_in_xml = File.open('./test_assets/checkstyle_report/checkstyle-report.xml') do |file|
      Nokogiri::XML(file)
    end

    checkstyle_block = report_in_xml.xpath('//checkstyle')
    assert_equal(1, checkstyle_block.length)

    errors_block = checkstyle_block.xpath('//error')
    assert_equal(2, errors_block.length)

    first_error = errors_block.first
    assert_equal('error', first_error.attr('severity'))
    assert_equal('1', first_error.attr('line'))
    assert_equal('Test message', first_error.attr('message'))
    assert_equal('pubspec.yaml', first_error.attr('source'))
    assert_equal('1', first_error.attr('line'))
    assert_equal('1', first_error.attr('column'))
    assert_nil(first_error.attr('name'))

    second_error = errors_block.last
    assert_equal('warning', second_error.attr('severity'))
    assert_equal('1', second_error.attr('line'))
    assert_equal('Test message', second_error.attr('message'))
    assert_equal('pubspec.yaml', second_error.attr('source'))
    assert_equal('1', second_error.attr('line'))
    assert_equal('1', second_error.attr('column'))
    assert_nil(second_error.attr('name'))
  end
end
