require 'minitest/autorun'
require_relative 'challenge'

class ParserTest < Minitest::Test
  def test_odds_are_reversed
    string = Parser.new('what the')
    assert_equal string.odds_reversed, "what eht"
  end

  def test_exception_for_long_words
    assert_raises ArgumentError do
      Parser.new('the californicationization')
    end
  end

  def test_periods_corrected
    string = Parser.new("what the  .")
    assert_equal string.input, "what the."
  end

  def test_no_in_sentence_periods
    assert_raises ArgumentError do
      Parser.new("what. the  .")
    end
  end
end
