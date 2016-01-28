require 'pry'

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

  def self.of_codon(rna)
    protein_codon_hsh = build_protein_codon_hsh
    match = nil
    protein_codon_hsh.each do |key, value|
      value.each do |codon|
        if codon == rna
          match = key
          break
        end
      end
    end
    match
  end

  def self.of_rna(rna)
    stop_index = find_stop_index(rna)
    codons = remove_stops(rna, stop_index)
    codon_arr = break_down_codons(codons)
    if translate_proteins(codon_arr).size == 0
      raise "InvalidCodonError"
    else 
      translate_proteins(codon_arr)
    end
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
    if stop_index
      return stop_index
    else
      return rna.size
    end
  end

  def self.remove_stops(rna, stop_index)
    codon_rna = rna.slice(0,stop_index)
  end

  def self.break_down_codons(codons)
    codon_arr = []
    start_idx = 0
    end_idx = 2
    (codons.size / CODON_SIZE).times do
      codon_arr << codons[start_idx..end_idx]
      start_idx += 3
      end_idx += 3
    end
    codon_arr
  end

  def self.translate_proteins(codon_arr)
    protein_translations = []

    codon_arr.each do |codon|
      if self.of_codon(codon)
        protein_translations << self.of_codon(codon)
      end
    end
    protein_translations
  end
end

