#!/bin/ruby

class Dog
    def initialize(name,breed,color,age)
        @name = name
        @breed = breed
        @color = color
        @age = age
    end

    def to_s
        "#@name is a #@age year old, #@color #@breed"
    end

    def inspect
        self.to_s
    end
end
