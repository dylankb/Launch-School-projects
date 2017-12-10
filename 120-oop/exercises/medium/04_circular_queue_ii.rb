require 'pry'

# Program should keep track of oldest index, not value
# Becuase it tracks values, inserted values must be unique
class CircularQueue
  attr_reader :queue, :queue_size
  attr_accessor :oldest_value, :newest_value

  def initialize(size)
    @queue_size = size
    @queue = Array.new(size)
    self.oldest_value = nil
    self.newest_value = nil
  end

  def enqueue(new_value)
    if empty?
      self.oldest_value = new_value
      queue[0] = new_value
    elsif not_full?
      next_empty_slot = find_next_slot(queue.index(newest_value))
      queue[next_empty_slot] = new_value
    else # full
      previous_oldest_value_index = queue.index(oldest_value)
      replace_oldest_value(new_value)
      set_new_oldest_value(previous_oldest_value_index)
    end
    self.newest_value = new_value
  end

  def dequeue
    return nil if oldest_value == nil

    oldest_value_index = queue.index(oldest_value)
    previous_oldest_value = oldest_value
    queue[oldest_value_index] = nil
    self.oldest_value = queue[find_next_slot(oldest_value_index)]

    previous_oldest_value
  end

  def replace_oldest_value(new_value)
    queue[queue.index(oldest_value)] = new_value
  end

  def set_new_oldest_value(prev_oldest_value_index)
    next_oldest_element_slot = find_next_slot(prev_oldest_value_index)
    self.oldest_value = queue[next_oldest_element_slot]
  end

  def find_next_slot(index)
    if index == queue_size - 1
      0
    else
      index + 1
    end
  end


  def empty?
    queue.all? { |value| value.nil? }
  end

  def not_full?
    queue.any? { |value| value.nil? }
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)

queue.enqueue(6)
queue.enqueue(7)

puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
