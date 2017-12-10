require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!
require 'simplecov'
SimpleCov.start

require_relative 'todo-list'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1 ,@list.first)
  end

  def test_last
    assert_equal(@todo3 ,@list.last)
  end

  def test_shift
    todo = @list.shift
    assert_equal(@todo1, todo)
    refute_includes(@list.todos, todo)
  end

  def test_pop
    todo = @list.pop
    assert_equal(@todo3, todo)
    refute_includes(@list.todos, todo)
  end

  def todos
    todos = @list.todos
    assert_equal([@todo1, @todo2, @todo3], todos)
  end

  def test_done?
    todo = @todo1.done?
    todo2 = @todo2.done?
    assert_equal(false, todo)
    assert_equal(false, todo2)
  end

  def test_add
    assert_raises(TypeError) { @list.add(1) }
  end

  def test_arrows
    @todo4 = Todo.new("Code")
    @list << @todo4
    assert_includes(@list.todos, @todo4)
  end

  def test_item_at
    assert_equal(@todo2, @list.item_at(1))
    assert_raises(IndexError) {@list.item_at(100)}
  end

  def test_mark_done_at
    assert_raises(IndexError) {@list.mark_done_at(100)}
    @list.mark_done_at(1)
    assert_equal(false, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(false, @todo3.done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) {@list.mark_done_at(100)}
    @list.mark_undone_at(1)
    assert_equal(false, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(false, @todo3.done?)
  end

  def test_mar_all_done
    @list.mark_all_done
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_done_bang
    @list.done!
    assert_equal(true, @list.done?)
  end

  def test_todo_to_s
    assert_equal("[ ] Buy milk", @todo1.to_s)
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_for_mark_done_at
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT

    @list.mark_done_at(1)
    assert_equal(output, @list.to_s)
  end

  def test_to_s_for_mark_all_done
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @list.mark_all_done
    assert_equal(output, @list.to_s)
  end

  def test_each
    each_arr = []
    @list.each { |todo| each_arr << todo }
    assert_equal(each_arr, @list.todos)
  end

  def test_each_returns_equal
    assert_equal(@list, @list.each {|todo| nil})
  end

  def test_select
    # assert_instance_of(TodoList, @list.select {|todo| nil})        # mine
    # grocery_tasks = @list.select { |todo| todo.title == 'Buy milk'}
    # assert_equal(grocery_tasks.todos.join, @todo1.to_s) #called join because select return an array
    @todo1.done!
    list = TodoList.new(@list.title)
    list.add(@todo1)

    assert_equal(list.title, @list.title)
    assert_equal(list.to_s, @list.select{ |todo| todo.done? }.to_s)
  end

end
