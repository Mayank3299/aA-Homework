def all_words_capitalized?(arr)
    arr.all? {|word| word==word.capitalize}
end

def no_valid_url?(arr)
    valid= [".com",".net",".io",".org"]
    arr.none? do |url|
        valid.one? {|valid_url| url.end_with?(valid_url)}
    end
end

def any_passing_students?(arr)
    arr.any?  {|hash| hash[:grades].sum/hash[:grades].length>=75}
end