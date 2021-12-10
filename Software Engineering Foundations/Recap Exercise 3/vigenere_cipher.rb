def vigenere_cipher(message, keys)
    count=0
    new_str=""
    l= keys.length
    alpha= "abcdefghijklmnopqrstuvwxyz"
    message.each_char do |char|
        old_index= alpha.index(char)
        key= keys[count%l]
        new_index= alpha[(old_index+key)%alpha.length]
        new_str+= alpha[new_index]
        count+=1
    end
    new_str
end

p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
p vigenere_cipher("yawn", [5, 1])             # => "dbbo"