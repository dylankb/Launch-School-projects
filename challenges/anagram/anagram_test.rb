require 'minitest/autorun'
require_relative 'anagram'

class AnagramTest < Minitest::Test

  def test_sentence
    assert_equal(true, Anagram.isAnagram("William Shakespeare", "I am a weakish speller"))
  end

  def test_word
    assert_equal(true, Anagram.isAnagram("Silent","Listen"))
  end

  def test_false_case
    assert_equal(false, Anagram.isAnagram("Car","Cat"))
  end

  def test_numbers
    assert_equal(true, Anagram.isAnagram("12345","54321"))
  end
end