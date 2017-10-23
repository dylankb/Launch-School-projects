require "pg"
require "pry"

class DatabasePersistence
  def initialize(logger)
    @db = PG.connect(dbname: "todos")
    @logger = logger
  end

  def query(statement, *params)
    @logger.info "#{statement}: #{params}"
    @db.exec_params(statement, params)
  end

  def all_lists
    sql = "SELECT * FROM lists"
    result = query(sql)

    result.map do |row|
      list_todos = find_list_todos(row["id"])
      { id: row["id"], name: row["name"], todos: list_todos }
    end
  end

  def create_new_list(list_name)
    sql = "INSERT INTO lists (name) VALUES ($1)"
    query(sql, list_name)
  end

  def create_new_todo(id, todo_name)
    sql = "INSERT INTO todos(name, list_id) VALUES ($1, $2)"
    query(sql, todo_name, id)
  end

  def delete_list(id)
    query("DELETE FROM todos WHERE list_id = $1", id)
    query("DELETE FROM lists WHERE id = $1", id)
  end

  def delete_todo_from_list(todo_id)
    sql = "DELETE FROM todos WHERE id = $1"
    query(sql, todo_id)
  end

  def find_list(id)
    sql = "SELECT * FROM lists WHERE ID = $1"
    result = query(sql, id)

    row = result.first
    list_id = row["id"].to_i
    name = row["name"]
    list_todos = find_list_todos(id)

    { id: list_id, name: name, todos: list_todos }
  end

  def mark_all_complete(id)
    list = find_list(id)
    sql = "UPDATE todos SET completed = true WHERE id = $1"
    query(sql, id)
  end

  def toggle_todo_status(list_id, todo_id)
    list = find_list(list_id)
    todo = list[:todos].find { |t| t[:id] == todo_id }
    # use t in block to avoid shadowing (reassignment like here would work, tho)
    sql = "UPDATE todos SET completed = $1"
    query(sql, !todo[:completed])
  end

  def update_list_name(id, name)
    sql = "UPDATE lists SET name = $2 WHERE id = $1"
    query(sql, id, name)
  end

  private

  def find_list_todos(list_id)
    sql = "SELECT * FROM todos WHERE list_id = $1"
    result = query(sql, list_id)

    result.map do |row|
      {
        id: row["id"].to_i,
        name: row["name"],
        completed: row["completed"] == "t",
      }
    end
  end
end
