class Category
    attr_accessor :id, :name

    @@all = []

    def initialize(id,name)
        @id = id
        @name = name
        @@all << self
    end

    def self.all
        @@all
    end

end
