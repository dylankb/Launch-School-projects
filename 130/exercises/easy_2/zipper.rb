def zip(arr1, arr2)
  arr1.length.times.with_object([]) { |i, acc| acc << [arr1[i],arr2[i]] }
end


p zip([1, 2, 3], [4, 5, 6]) # [[1, 4], [2, 5], [3, 6]]
