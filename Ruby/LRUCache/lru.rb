class LRUCache
    def initialize(size= 4)
        @cache= []
        @size= size
    end

    def count
      # returns number of elements currently in cache
        @cache.count
    end

    def add(el)
      # adds element to cache according to LRU principle
        if @cache.length < @size
            if already_in_cache?(el)
                remove_dup(el)
            end
            @cache << el
        else
            if already_in_cache?(el)
                remove_dup(el)
                @cache << el
            else
                @cache.shift
                @cache << el
            end
        end
    end

    def show
      # shows the items in the cache, with the LRU item first
      p @cache
    end

    private
    # helper methods go here!

    def already_in_cache?(el)
        @cache.include?(el)
    end

    def remove_dup(el)
        index= @cache.index(el)
        @cache.delete_at(index)
    end
  end