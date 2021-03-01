#!/bin/ruby

def testList
    # Empty list <>
    list = LinkedList.new
    raise "Not empty list" unless list.empty?
    raise "Head is not nil!" unless list.getHead.nil?
    puts list
        
    # <1>
    list.push(1)
    raise "Length not increased" unless list.len == 1
    raise "Head not 1" unless list.getHead == 1
    raise "Tail not 1" unless list.getTail == 1
    puts list

    # <1,2>
    list.push(2)
    raise "Length not increased" unless list.len == 2
    raise "Head changed!" unless list.getHead == 1
    raise "Tail not 2" unless list.getTail == 2
    puts list

    # <1,2,"10">
    list.push("10")
    raise "Length not increased" unless list.len == 3
    raise "Head changed!" unless list.getHead == 1
    raise "Tail not 10" unless list.getTail == "10"
    puts list

    # <5,1,2,"10">
    list.pushLeft(5)
    raise "Length not increased" unless list.len == 4
    raise "Head not 5" unless list.getHead == 5
    raise "Tail changed" unless list.getTail == "10"
    puts list

    # <5,1,2> -> "10"
    popped = list.pop
    raise '"10" not popped: %s' % popped unless popped == "10"
    raise "Length not decreased" unless list.len == 3
    raise "Head changed!" unless list.getHead == 5
    raise "Tail not 2" unless list.getTail == 2
    puts "#{list} -> \"#{popped}\""

    # <5,1> -> 2
    popped = list.pop
    raise "2 not popped" unless popped == 2
    raise "Length not decreased" unless list.len == 2
    raise "Head changed!" unless list.getHead == 5
    raise "Tail not 1" unless list.getTail == 1
    puts "#{list} -> #{popped}"

    # <5> -> 1
    popped = list.pop
    raise "1 not popped" unless popped == 1
    raise "Length not decreased" unless list.len == 1
    raise "Head changed!" unless list.getHead == 5
    raise "Tail not 5" unless list.getTail == 5
    puts "#{list} -> #{popped}"
    
    # <> -> 5
    popped = list.pop
    raise "5 not popped" unless popped == 5
    raise "Length not decreased" unless list.len == 0
    raise "Head not nil!" unless list.getHead.nil?
    raise "Tail not nil!" unless list.getTail.nil?
    puts "#{list} -> #{popped}"

    # <0>
    list.push(0)
    raise "Length not increased" unless list.len == 1
    raise "Head not 0" unless list.getHead == 0
    raise "Tail not 0" unless list.getTail == 0
    puts list

    # <-1,0>
    list.pushLeft(-1)
    raise "Length not increased" unless list.len == 2
    raise "Head not -1" unless list.getHead == -1
    raise "Tail not 0" unless list.getTail == 0
    puts list

    # -1 <- <0>
    popped = list.popLeft
    raise "-1 not popped" unless popped == -1
    raise "Length not decreased" unless list.len == 1
    raise "Head not 0" unless list.getHead == 0
    raise "Tail not 0" unless list.getTail == 0
    puts "#{popped} <- #{list}"

    # 0 <- <> 
    popped = list.popLeft
    raise "0 not popped" unless popped == 0
    raise "Length not decreased" unless list.len == 0
    raise "Head not nil" unless list.getHead.nil?
    raise "Tail not nil" unless list.getTail.nil?
    puts "#{popped} <- #{list}"

    # [3,1,4,1,5,9] -> <3,1,4,1,5,9>
    list.addAll([3,1,4,1,5,9])
    raise "not copied correctly" unless list.to_s == "<3,1,4,1,5,9>"
    puts list

    # test Enumerable methods
    raise "incorrect include?" unless list.include?(5)
    raise "incorrect sort" unless list.sort == [1,1,3,4,5,9]
    raise "incorrect max" unless list.max == 9
    raise "incorrect min" unless list.min == 1
    raise "incorrect take" unless list.take(3) == [3,1,4]

    # <3,1,4,1,9> -> 5
    popped = list.pop(4)
    raise "5 not popped" unless popped == 5
    raise "5 still in list" if list.include?(5)
    raise "Length not decreased" unless list.len == 5
    raise "Head changed" unless list.getHead == 3
    raise "Tail changed" unless list.getTail == 9
    puts "#{list} -> #{popped}"

    # <3,1,4,1,5,9>
    list.insert(5,4)
    raise "Length not increased" unless list.len == 6
    raise "5 not added" unless list.get(4) == 5
    raise "5 added wrong" unless list.find_index(5) == 4
    raise "Head changed" unless list.getHead == 3
    raise "Tail changed" unless list.getTail == 9
    puts list

    # <>
    list.clear
    raise "Length non-zero" unless list.len == 0
    raise "Head non nil" unless list.getHead.nil?
    raise "Tail non nil" unless list.getTail.nil?
    puts list

    puts "Succeeded!"
end
