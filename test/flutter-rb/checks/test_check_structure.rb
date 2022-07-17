require_relative '../../../lib/flutter_rb/checks/check.rb'

require 'minitest/autorun'

class CheckStructureTest < Minitest::Test
  def test_check_structure
    check = FlutterRb::Check.new

    assert_raises FlutterRb::Check::UNIMPLEMENTATION_ERROR do
      check.name
    end
    assert_raises FlutterRb::Check::UNIMPLEMENTATION_ERROR do
      check.summary
    end
    assert_raises FlutterRb::Check::UNIMPLEMENTATION_ERROR do
      check.check
    end

    assert check.description == 'No provided'
  end
end
