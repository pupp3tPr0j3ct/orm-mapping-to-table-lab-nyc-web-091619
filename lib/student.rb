class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  attr_reader :id
  attr_accessor :name, :grade

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = 1
  end

  def self.create_table
    sql = <<-SQL 
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      ) 
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students;
      SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES ( ?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    #Important: Remember that the INTEGER PRIMARY KEY datatype will assign and auto-increment the id attribute of each record that gets saved
  end

  def self.create(name:, grade:)
    a_student = Student.new(name, grade)
    a_student.save
    a_student
  end
end
