class CircularQueue
  attr_accessor :first

  def initialize(size)
    @queue = Array.new(size)
    @first = nil
    @next_position = nil
  end

  def enqueue(obj)
    if empty_buffer?
      set_initial_values(obj)
    elsif full_buffer?
      replace_oldest(obj)
    else
      @queue[find_last] = obj
    end
  end

  def set_initial_values(obj)
    self.first = rand(@queue.length)
    @queue[first] = obj
    @next_position = next_slot_in_buffer(first)
  end

  def dequeue
    return nil if empty_buffer?

    previous_first_index = first
    previous_first_obj = @queue[first]

    self.first = next_slot_in_buffer(first)
    @queue[previous_first_index] = nil

    previous_first_obj
  end

  def next_slot_in_buffer(num)
    num == @queue.length - 1 ? 0 : num + 1
  end

  def replace_oldest(obj)
    @queue[first] = obj
    self.first = next_slot_in_buffer(first)
  end

  def empty_buffer?
    @queue.all? { |obj| obj == nil }
  end

  def full_buffer?
    @queue.all? { |obj| obj != nil }
  end

  def next_empty_slot
    slot_under_test = @next_position ? @next_position : @first + 1

    while (!@queue[slot_under_test].nil?) do
      slot_under_test = next_slot_in_buffer(slot_under_test)
    end

    return slot_under_test
  end

  def find_last
    @queue[@next_position].nil? ? @next_position : next_empty_slot
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
p queue

puts queue.dequeue == 1

p queue
queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

p queue
queue.enqueue(5)
p queue
queue.enqueue(6)
p queue
queue.enqueue(7)
p queue
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
