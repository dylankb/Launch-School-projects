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

  def encode
    size.times.with_object([]) do |index, result|
      new_segment = []
      plaintext_segments.each do |segment|
        new_segment << segment[index]
      end
      result << new_segment.compact.join
    end
  end

  def ciphertext
    encode.join
  end

  def normalize_ciphertext
    encode.join(" ").strip
  end
end
