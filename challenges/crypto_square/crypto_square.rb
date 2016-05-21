include Math

class Crypto
  def initialize(text)
    @text = text
  end

  def normalize_plaintext
    @text.gsub(/\W/,"").downcase
  end

  def size
    Math.sqrt(normalize_plaintext.size).ceil
  end

  def plaintext_segments
    normalize_plaintext.scan(/.{1,#{size}}/)
  end

  def transpose
    rows = plaintext_segments.map! {|rows| rows.split("")}
    rows.last << nil until rows.last.size == size
    rows.transpose.map { |row| row.compact.join }
  end

  def ciphertext
    transpose.join
  end

  def normalize_ciphertext
    transpose.join(" ").strip
  end
end
