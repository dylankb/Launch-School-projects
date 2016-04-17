require 'minitest/autorun'
require_relative 'to_currency'

class CurrencyTest < Minitest::Test
  def test_invalid_currency
    assert_raises(ArgumentError) { to_currency("453&$*#") }
  end

  def test_dollar_format
    assert_equal '$', to_currency("5")[0]
  end

  def test_cents_formatting
    assert_equal '.32', to_currency("10.32")[-3..-1]
  end

  def test_rounds_to_hundreth
    assert_equal '$22.57', to_currency("22.5683213")
  end

  def test_small_number
    assert_equal '$782.32', to_currency("782.32")
  end

  def test_large_number
    assert_equal '$3,234,111.85', to_currency("3234111.85")
  end
end