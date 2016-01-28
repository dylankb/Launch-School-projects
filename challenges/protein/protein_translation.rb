class InvalidCodonError < StandardError
end

class Translation
  CODON_SIZE = 3
  STOPS = %w(UAA UAG, UGA)
  CODONS = [ ['AUG'], ['UUU', 'UUC'], 
             ['UUA', 'UUG'], ['UCU', 'UCC', 'UCA', 'UCG'], 
             ['UAU', 'UAC'], ['UGU', 'UGC'], 
             ['UGG'], ['UAA', 'UAG', 'UGA'] ]
  PROTEINS = %w(Methionine Phenylalanine 
                Leucine Serine Tyrosine Cysteine 
                Tryptophan STOP)

  def self.of_codon(codon)
    protein_codon_hsh = build_protein_codon_hsh
    translation = protein_codon_hsh.select { |protein, codons| codons.include?(codon) }.keys.first
    raise InvalidCodonError unless translation
  end

  def self.of_rna(rna)
    stop_index = find_stop_index(rna)
    codons = remove_stops(rna, stop_index)
    codon_arr = break_down_codons(codons)
    raise InvalidCodonError if translate_proteins(codon_arr).size == 0
    translate_proteins(codon_arr)
  end

  def self.build_protein_codon_hsh
    protein_codon_arr = []
    Translation::CODONS.size.times do |int|
      protein_codon_arr << [ Translation::PROTEINS[int],Translation::CODONS[int] ]
    end
    protein_codon_hsh = protein_codon_arr.to_h
  end

  def self.find_stop_index(rna)
    stop_index = nil
    STOPS.each do |stop|
      break if stop_index
      stop_index = rna.index(stop)
    end
    stop_index ? stop_index : rna.size
  end

  def self.remove_stops(rna, stop_index)
    codon_rna = rna.slice(0,stop_index)
  end

  def self.break_down_codons(codons)
    codon_arr = codons.scan(/.../)
  end

  def self.translate_proteins(codon_arr)
    protein_translations = []

    codon_arr.each do |codon|
      if of_codon(codon)
        protein_translations << of_codon(codon)
      end
    end
    protein_translations
  end
end

puts Translation.of_codon('AUG')
