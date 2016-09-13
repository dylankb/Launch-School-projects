#v1 Doesn't account for spaces, etc.

# def decipher(string)
#   indexes = string.split("").map { |letter| ALPHABET.index(letter.downcase) }
#   decrypted = indexes.map do |number|
#     number < 13 ? ALPHABET[number + 13] : ALPHABET[number - 13]
#   end
#   decrypted.join()
# end

ALPHABET = ('a'..'z').to_a + ('A'..'Z').to_a

def decipher(arr)
  results = []
  arr.each do |name|
    decrypted = name.split("").map do |encrypted_char|
      decrypt_character(encrypted_char)
    end.join()
    results << decrypted
  end
  puts results
end

# def decipher(name)
#   decrypted = name.split("").map do |encrypted_char|
#     decrypt_character(encrypted_char)
#   end.join()
#   decrypted
# end

def decrypt_character(character)
  case character

  when 'a'..'m','A'..'M'
    ALPHABET[ALPHABET.index(character) + 13]
  when 'n'..'z', 'N'..'Z'
    ALPHABET[ALPHABET.index(character) - 13]
  else
    character
  end
end

list = ["Nqn Ybirynpr", "Tenpr Ubccre", "Nqryr Tbyqfgvar", "Nyna Ghevat", "Puneyrf Onoontr", "Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv", "Wbua Ngnanfbss", "Ybvf Unyog", "Pynhqr Funaaba", "Fgrir Wbof", "Ovyy Tngrf", "Gvz Orearef-Yrr", "Fgrir Jbmavnx", "Xbaenq Mhfr", "Wbua Ngnanfbss", "Fve Nagbal Ubner", "Zneiva Zvafxl", "Lhxvuveb Zngfhzbgb", "Unllvz Fybavzfxv", "Tregehqr Oynapu"]

puts decipher(list)

# p decipher(list)

# p decipher("Nqn Ybirynpr")
