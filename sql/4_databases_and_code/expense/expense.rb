#! /usr/bin/env ruby

require 'bundler/setup'
require 'pg'
require 'io/console'

class ExpenseData
  def initialize
    @db = PG.connect(dbname: "expenses")
    setup_schema
  end

  def add_item(new_amount, new_memo)
    sql = "INSERT INTO expenses(amount, memo) VALUES ($1, $2)"
    @db.exec_params(sql, [new_amount, new_memo])
  end

  def delete_item(id)
    sql = "SELECT * FROM expenses WHERE id = $1"
    results = @db.exec_params(sql, [id])
    if results.values.empty?
      puts "There is no expense with id '#{id}'"
    else
      delete_sql = "DELETE FROM expenses WHERE id = $1"
      delete_results = @db.exec_params(delete_sql, [id])
      puts "The following expense has been deleted"
      display_results(results)
    end
  end

  def delete_expenses
    sql = "DELETE FROM expenses"
    @db.exec(sql)
    puts "All expenses have been removed"
  end

  def search_expenses(term)
    sql = "SELECT * FROM expenses WHERE memo ILIKE $1"
    results = @db.exec_params(sql, [term])
    display_count(results)
    display_results(results) unless results.ntuples == 0
  end

  def setup_schema
    result = @db.exec <<~SQL
      SELECT COUNT(*) FROM information_schema.tables
      WHERE table_schema = 'public' AND table_name = 'expenses';
    SQL

    if result[0]["count"] == "0"
      @db.exec <<~SQL
        CREATE TABLE expenses (
          id serial PRIMARY KEY,
          amount numeric(6,2) NOT NULL CHECK (amount >= 0.01),
          memo text NOT NULL,
          created_on date NOT NULL
        );
      SQL
    end
  end

  def display_expenses
    results = @db.exec("SELECT * FROM expenses ORDER BY created_on")
    display_count(results)
    display_results(results) unless results.ntuples == 0
  end

  private

  def display_count(results)
    multiple = results.ntuples > 1
    if results.ntuples == 0
      puts "There are no expenses."
    else
      puts "There #{multiple ? "are" : "is"} #{results.ntuples} expense#{"s" if multiple}."
    end
  end

  def display_results(results)
    results.each do |row|
      columns = [row["id"].rjust(3),
                  row["created_on"].rjust(12),
                  row["amount"].rjust(10),
                  row["memo"].rjust(12)]
      puts columns.join("|")
    end

    total = results.reduce(0) { |acc, row| acc += row["amount"].to_f }
    puts "-" * (3 + 12 + 10 + 22)
    puts "Total #{total.to_s.rjust(12 + 10 - 1)}"
  end
end

class CLI
  def initialize
    @app = ExpenseData.new
  end
  def display_help
    puts <<-HELP
  An expense recording system

  Commands:

  add AMOUNT MEMO [DATE] - record a new expense
  clear - delete all expenses
  list - list all expenses
  delete NUMBER - remove expense with id NUMBER
  search QUERY - list expenses with a matching memo field
    HELP
  end
  def run(args)
    command = args.shift
    case command
    when "add"
      amount, memo = args[0], args[1]
      abort "Please provide an amount and memo." unless amount && memo
      @app.add_item(amount, memo)
    when "clear"
      puts "This will remove all expenses. Are you sure? (y/n)"
      response = STDIN.getch
      if /y/ =~ response
        @app.delete_expenses
      else
        puts "No expenses removed"
      end
    when "delete"
      id = args[0]
      abort "Please provide an amount and memo." unless id
      @app.delete_item(id)
    when "list"
      @app.display_expenses
    when "search"
      term = args[0]
      abort "Please provide an search term." unless term
      @app.search_expenses(term)
    else
      display_help
    end
  end
end

CLI.new.run(ARGV)
