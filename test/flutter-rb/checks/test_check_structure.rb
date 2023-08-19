require_relative '../../test_helper'
require_relative '../../../lib/flutter_rb/checks/check.rb'

require 'minitest/autorun'

class CheckStructureTest < Minitest::Test
  def test_check_structure
    check = FlutterRb::Check.new

    assert_raises FlutterRb::Check::UNIMPLEMENTED_ERROR do
      check.name
    end
    assert_raises FlutterRb::Check::UNIMPLEMENTED_ERROR do
      check.summary
    end
    assert_raises FlutterRb::Check::UNIMPLEMENTED_ERROR do
      check.check(nil)
    end

    assert_equal('No provided', check.description)
  end
end
