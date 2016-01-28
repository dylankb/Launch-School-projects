require 'pry'

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList 
  attr_accessor :title, :done

  def initialize(title)
    @title = title
    @todos = []
    @done = false
  end
  # rest of class needs implementation

  # def add(todo)
    # if todo.class.to_s == 'Todo'                  #mine
    #   @todos << todo
    # else
    #   raise TypeError, "Can only add Todo objects"
    # end
    # @todos

  def <<(todo) 
  #   add(todo)  # mine
    raise TypeError, 'can only add Todo objects' unless todo.instance_of? Todo
    @todos << todo
  end
  alias_method :add, :<<

  def size
    @todos.size
  end

  def first
    @todos[0]
  end

  def todos
    @todos
  end

  def done!
    self.done = true
  end

  def done?
    self.done == true
  end

  def to_a
    @todos.to_a
  end

  def last
    @todos[-1]
  end

  def item_at(index)
    #@todos[index] # does not return index error
    @todos.fetch(index)
  end

  def mark_done_at(index)
    #@todos[index].done! # mine   
    item_at(index).done! # answer
  end

  def mark_undone_at(index)
    #@todos[index].undone! # mine
    item_at(index).undone! # answer
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    #@todos.pop(index)  # mine
    @todos.delete(item_at(idx)) # answer
  end

  def to_s
    # puts "---- #{title}----"  # mine
    # @todos.each do |todo|
    #   puts todo
    # end
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n") # answer
    text
  end

  def each
    # counter = 0             # mine
    # while counter < size
    #   yield item_at(counter)

    #   counter += 1
    # end
    @todos.each do |todo|   # answer
      yield(todo)
    end

    self
  end

  def select
    output = TodoList.new(title)

    each do |todo|
      output << todo if yield(todo)
    end
    output
  end

  def find_by_title(task_name)
    select {|todo| todo.title == task_name}.first
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(task_name)
    # each do |todo|
    #   if todo.title == task_name  # mine
    #     todo.done!
    #   end
    # end
    find_by_title(task_name).done! #&& find_by_title(title).done!
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end
end

# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")
# list = TodoList.new("Today's Todos")

# list.add(todo1)
# list.add(todo2)
# list.add(todo3)
