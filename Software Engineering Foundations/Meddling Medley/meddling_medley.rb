require "byebug"
def duos(str)
    count=0
    (0...str.length-1).each do |i|
        count+=1 if str[i]==str[i+1]
    end
    count
end

# p duos('bootcamp')      # 1
# p duos('wxxyzz')        # 2
# p duos('hoooraay')      # 3
# p duos('dinosaurs')     # 0
# p duos('e')             # 0

def sentence_swap(sentence, hash)
    arr= sentence.split(" ")
    new_arr= arr.map do |word|
        hash[word] || word
    end
    new_arr.join(" ")
end

# p sentence_swap('anything you can do I can do',
#     'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
# ) # 'nothing you shall drink I shall drink'
# 
# p sentence_swap('what a sad ad',
#     'cat'=>'dog', 'sad'=>'happy', 'what'=>'make'
# ) # 'make a happy ad'
# 
# p sentence_swap('keep coding okay',
#     'coding'=>'running', 'kay'=>'pen'
# ) # 'keep running okay'

def hash_mapped(hash, prc1, &prc)
    new_hash={}
    hash.each do |key, val|
        new_hash[prc.call(key)]= prc1.call(val)
    end
    new_hash
end

# double = Proc.new { |n| n * 2 }
# p hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' }
# # {"A!!"=>8, "X!!"=>14, "C!!"=>-6}
# 
# first = Proc.new { |a| a[0] }
# p hash_mapped({-5=>['q', 'r', 's'], 6=>['w', 'x']}, first) { |n| n * n }
# # {25=>"q", 36=>"w"}

def counted_characters(str)
    hash=Hash.new(0)
    str.each_char do |char|
        hash[char]+=1
    end
    hash
        .select{|k,v| v>2}
        .keys
end

# p counted_characters("that's alright folks") # ["t"]
# p counted_characters("mississippi") # ["i", "s"]
# p counted_characters("hot potato soup please") # ["o", "t", " ", "p"]
# p counted_characters("runtime") # []

def triplet_true(str)
    if duos(str)>=3
        true
    else
        false
    end
end

# p triplet_true('caaabb')        # true
# p triplet_true('terrrrrible')   # true
# p triplet_true('runninggg')     # true
# p triplet_true('bootcamp')      # false
# p triplet_true('e')             # false

def energetic_encoding(str, hash)
    new_str=""
    str.each_char do |char|
        if char==' '
            new_str+=char
        else
            new_str+=hash[char]||'?'
        end
    end
    new_str
end

# p energetic_encoding('sent sea',
#     'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
# ) # 'zimp ziu'
# 
# p energetic_encoding('cat',
#     'a'=>'o', 'c'=>'k'
# ) # 'ko?'
# 
# p energetic_encoding('hello world',
#     'o'=>'i', 'l'=>'r', 'e'=>'a'
# ) # '?arri ?i?r?'
# 
# p energetic_encoding('bike', {}) # '????'

def uncompress(str)
    i=0
    new_str=""
    while i<str.length
       new_str+= str[i] * str[i+1].to_i
       i+=2  
    end
    new_str
end

# p uncompress('a2b4c1') # 'aabbbbc'
# p uncompress('b1o2t1') # 'boot'
# p uncompress('x3y1x2z4') # 'xxxyxxzzzz'

def conjunct_select(arr, *prc)
    new_arr= arr.select do |ele|
        prc.all? do |prcc|
            prcc.call(ele)
        end
    end
end

is_positive = Proc.new { |n| n > 0 }
is_odd = Proc.new { |n| n.odd? }
less_than_ten = Proc.new { |n| n < 10 }

# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) # [4, 8, 11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd) # [11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten) # [7]

def convert_pig_latin(sentence)
    arr= sentence.split(" ")
    new_words= arr.map do |word|
        new_word= word.length > 2 ? convert_word(word) : word
        word == word.capitalize ? new_word.capitalize : new_word
    end
    new_words.join(" ")
end

def convert_word(word)
    alpha="aeiouAEIOU"
    return word + 'yay' if alpha.include?(word[0])
    word.each_char.with_index do |char,i|
        if alpha.include?(char)
            return word[i..-1] + word[0...i] + 'ay'
        end
    end
end

# p convert_pig_latin('We like to eat bananas') # "We ikelay to eatyay ananasbay"
# p convert_pig_latin('I cannot find the trash') # "I annotcay indfay ethay ashtray"
# p convert_pig_latin('What an interesting problem') # "Atwhay an interestingyay oblempray"
# p convert_pig_latin('Her family flew to France') # "Erhay amilyfay ewflay to Ancefray"
# p convert_pig_latin('Our family flew to France') # "Ouryay amilyfay ewflay to Ancefray"

def reverberate(sentence)
    words= sentence.split(" ")
    new_words= words.map do |word|
        new_word= word.length > 2 ? reconvert_word(word) : word
        word == word.capitalize ? new_word.capitalize : new_word
    end
    new_words.join(" ")
end

def reconvert_word(word)
    alpha="aeiouAEIOU"
    return word + word if alpha.include?(word[-1])
    i= word.length-1
    while i>=0
        if alpha.include?(word[i])
            return word + word[i..-1]
        end
        i-=1
    end
end

# p reverberate('We like to go running fast') # "We likelike to go runninging fastast"
# p reverberate('He cannot find the trash') # "He cannotot findind thethe trashash"
# p reverberate('Pasta is my favorite dish') # "Pastapasta is my favoritefavorite dishish"
# p reverberate('Her family flew to France') # "Herer familyily flewew to Francefrance"

def disjunct_select(arr, *prc)
    new_arr= arr.select do |ele|
        prc.any? {|prcc| prcc.call(ele)}
    end
end

longer_four = Proc.new { |s| s.length > 4 }
contains_o = Proc.new { |s| s.include?('o') }
starts_a = Proc.new { |s| s[0] == 'a' }

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
# ) # ["apple", "teeming"]
# 
# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o
# ) # ["dog", "apple", "teeming", "boot"]
# 
# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o,
#     starts_a
# ) # ["ace", "dog", "apple", "teeming", "boot"]

def alternating_vowel(sentence)
    words= sentence.split(" ")
    new_words= words.map.with_index do |word, i|
        i.even? ? remove_first_vowel(word) : remove_last_vowel(word)
    end
    new_words.join(" ")
end

def remove_first_vowel(word)
    alpha= "AEIOUaeiou"
    word.each_char.with_index do |char, i|
        if alpha.include?(char)
            return word[0...i] + word[i+1..-1]
        end
    end
    word
end

def remove_last_vowel(word)
    remove_first_vowel(word.reverse).reverse
end

# p alternating_vowel('panthers are great animals') # "pnthers ar grat animls"
# p alternating_vowel('running panthers are epic') # "rnning panthrs re epc"
# p alternating_vowel('code properly please') # "cde proprly plase"
# p alternating_vowel('my forecast predicts rain today') # "my forecst prdicts ran tday"

def silly_talk(sentence)
    words= sentence.split(" ")
    alpha= "aeiou"
    new_words= words.map do |word|
        new_word=""
        if alpha.include?(word[-1])
            new_word= word + word[-1]
            word == word.capitalize ? new_word.capitalize : new_word
        else
            word.each_char.with_index do |char, i|
                if alpha.include?(char)
                    new_word+= char + 'b' + char
                else
                    new_word+= char
                end
            end
            word == word.capitalize ? new_word.capitalize : new_word
        end
    end
    new_words.join(" ")
end

# p silly_talk('Kids like cats and dogs') # "Kibids likee cabats aband dobogs"
# p silly_talk('Stop that scooter') # "Stobop thabat scobooboteber"
# p silly_talk('They can code') # "Thebey caban codee"
# p silly_talk('He flew to Italy') # "Hee flebew too Ibitabaly"

def compress(str)
    i=0
    count=1
    new_str=""
    while i < str.length
        if str[i] == str[i+1]
            count+=1
        else
            if count==1
                new_str+= str[i]
            else
                new_str+= str[i] + count.to_s
                count=1
            end
        end
        i+=1
    end
    new_str
end

# p compress('aabbbbc')   # "a2b4c"
# p compress('boot')      # "bo2t"
# p compress('xxxyxxzzzz')# "x3yx2z4"