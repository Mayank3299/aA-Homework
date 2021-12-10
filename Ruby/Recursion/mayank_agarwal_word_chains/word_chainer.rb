require "Set"

class WordChainer

    def initialize(filename)
        @dictionary= File.readlines(filename).map(&:chomp)
        @dictionary= Set.new(@dictionary)
    end

    def adjacent_words(word)
        words=[]
        word.each_char.with_index do |old_letter,idx|
            ('a'..'z').each do |new_letter|
                next if old_letter == new_letter
                new_word= word.dup
                new_word[idx]= new_letter
                words << new_word if @dictionary.include?(new_word)
            end
        end
        words
    end

    def run(source, target)
        @current_words= [source]
        @all_seen_words= {source => nil}
        until @current_words.empty? || @all_seen_words.include?(target)
            explore_current_words
        end

        build_path(target)
    end

    def explore_current_words
        new_current_words=[]
        @current_words.each do |current_word|
            adjacent_word= adjacent_words(current_word)
            adjacent_word.each do |check_word|
                next if @all_seen_words.key?(check_word)
                new_current_words << check_word
                @all_seen_words[check_word] = current_word
            end
        end
        @current_words= new_current_words
    end

    def build_path(target)
        
        path=[]
        until target.nil?
            if @all_seen_words.key?(target)
                path << target
                target= @all_seen_words[target]
            end
        end
        path.reverse
    end

    if $PROGRAM_NAME == __FILE__
        p WordChainer.new("dictionary.txt").run(ARGV[0],ARGV[1])
    end
end
