#!/bin/ruby

class LinkedList
    include Enumerable

    # Inner Node structure
    class Node
        def initialize(val)
            @val = val
            @prev = nil
            @next = nil
        end
        def setPrev(node)
            @prev = node
        end
        def setNext(node)
            @next = node
        end

        attr_reader :val
        attr_reader :next
        attr_reader :prev

        def to_s
            @val.to_s
        end
        def inspect
            self.to_s
        end
    end

    # constructor with optional copy constructor 
    # from Array or other LinkedList
    def initialize(list=nil)
        @head = nil
        @tail = nil
        @len = 0
        if list.is_a?(Enumerable)
            self.addAll(list)
        end
    end

    attr_reader :len

    # push methods for front and back of list
    def push(ele)
        curr = Node.new(ele)
        if @head.nil?
            @head = curr
            @tail = curr
        else
            @tail.setNext(curr) 
            curr.setPrev(@tail)
            @tail = curr
        end
        @len += 1
        self
    end
    def <<(ele)
        self.push(ele)
    end
    def pushLeft(ele)
        if @head.nil?
            push(ele)
        else
            curr = Node.new(ele)
            @head.setPrev(curr)
            curr.setNext(@head)
            @head = curr
        end
        @len += 1
        self
    end
    def >>(ele)
        self.pushLeft(ele)
    end

    # insert at the nth position
    def insert(ele, n = 0)
        if n > @len or n < 0
            throw "Tried to insert outside of list"
        end
        if n == @len
            push(ele)
        elsif n == 0
            pushLeft(ele)
        else
            curr = Node.new(ele)
            prev,succ = navTo(n)
            prev.setNext(curr)
            curr.setPrev(prev)
            succ.setPrev(curr)
            curr.setNext(succ)
            @len += 1
        end
        self
    end

    # utility method to add all elements from an Enumerable 
    # i.e. multiple appends
    def addAll(arr)
        arr.each {|x| push(x)}
    end

    # removes all elements from list and sets back to default
    def clear
        @head = nil
        @tail = nil
        @len = 0
        self
    end

    # pop method for queue-like list
    # optionally send index to pop 
    def pop(n=@len-1)
        if n >= @len or n < 0
            raise "Index out of range"
        elsif @tail.nil?
            nil
        elsif n == @len-1
            curr = @tail
            if @tail.prev.nil?
                @tail = nil
                @head = nil
            else
                @tail.prev.setNext(nil)
                @tail = @tail.prev
            end
            @len -= 1
            curr.val
        elsif n == 0
            self.popLeft
        else
            prev,curr = navTo(n)
            prev.setNext(curr.next)
            curr.next.setPrev(prev)
            @len -= 1
            curr.val
        end
    end
    def popLeft
        if @head.nil?
            nil
        else
            curr = @head
            if @head.next.nil?
                @head = nil
                @tail = nil
            else 
                @head.next.setPrev(nil)
                @head = @head.next
            end
            @len -= 1
            curr.val
        end
    end

    # getters for elements in list
    def getHead
        if @head.nil?
            nil
        else
            @head.val
        end
    end
    def getTail
        if @tail.nil?
            nil
        else
            @tail.val
        end
    end
    def get(n)
        if n >= @len or n < 0
            raise "Index out of bounds"
        elsif n == 0
            self.getHead
        elsif n == @len-1
            self.getTail
        else
            _,curr = navTo(n)
            curr.val
        end
    end

    # each is needed for the Enumerable module
    # this gives the Enumerable methods
    def each(&block)
        if block_given?
            curr = @head
            while curr
                block.call(curr.val)
                curr = curr.next
            end
        else
            to_enum(:each)
        end
    end

    # utility method to see if list is empty
    def empty?
        @head.nil?
    end

    # overriding to_s method to output contents of list
    # surrounded by angle brackets i.e. <1,2,3>
    def to_s
        rep = "<"
        if !(@head.nil?)
            curr = @head
            while !curr.next.nil?
                rep += (curr.to_s + ",")
                curr = curr.next
            end

            rep += curr.to_s 
        end
        rep += ">"
        rep
    end
    def inspect
        self.to_s
    end

    # Auxiliary method for finding indices
    private
    def navTo(n)
        prev = @head 
        succ = @head.next
        for _ in 1...n
            prev = prev.next
            succ = succ.next
        end
        return prev,succ
    end
end
