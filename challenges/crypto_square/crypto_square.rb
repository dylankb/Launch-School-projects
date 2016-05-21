include Math

class Crypto
  def initialize(text)
    @text = text
  end

  def normalize_plaintext
    @text.gsub(/\W/,"").downcase
  end

  def size
    size = Math.sqrt(normalize_plaintext.size)
    size % 1 == 0 ? size.to_i : size.to_i + 1
  end

  def plaintext_segments
    normalize_plaintext.scan(/.{1,#{size}}/)
  end

  def ciphertext
    normalize_ciphertext.gsub(/\s/,"")
  end

  def normalize_ciphertext
    cipher = []
    self.size.times do |index|
      new_segment = []
      plaintext_segments.each do |segment|
        new_segment << segment[index]
      end
      cipher << new_segment.compact
    end
    cipher.map! do |segment|
      segment.join
    end
    cipher.join(" ").strip
  end
end
