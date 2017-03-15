class CircularQueue
  def initialize(size)
    @queue = Array.new(size)
    @start = nil
    @end = nil
  end

  def enqueue(obj)
    if empty_buffer?
      index = rand(@queue.length)
      start = index
      @queue[index] = obj
    else
  end

  def dequeue
    nil
  end

  def empty_buffer?
    @queue.all? {|item| item == nil}
  end

end

queue = CircularQueue.new(3)
puts queue.dequeue == nil
puts queue.empty_buffer? == true

# queue.enqueue(1)
# queue.enqueue(2)
# p queue
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2
#
# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil
#
# queue = CircularQueue.new(4)
# puts queue.dequeue == nil
#
# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1
#
# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2
#
# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 4
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil
