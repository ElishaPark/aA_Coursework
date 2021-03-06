require 'byebug'
require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database 
  include Singleton

  SQL_FILE = File.join(File.dirname(__FILE__), 'import_db.sql')
  DB_FILE = File.join(File.dirname(__FILE__), 'questions.db')

  def self.open
    @database = SQLite3::Database.new(DB_FILE)
    @database.results_as_hash = true
    @database.type_translation = true 
  end

  def self.instance
    reset! if @database.nil?
    @database 
  end

  def self.reset!
    commands = [
        "rm '#{DB_FILE}'", 
        "cat '#{SQL_FILE}' | sqlite3 '#{DB_FILE}'"
    ]
    commands.each {|command| "#{command}" }

    QuestionsDatabase.open
  end
end
