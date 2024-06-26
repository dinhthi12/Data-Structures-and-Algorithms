require 'terminal-table'

class Employee < People
  attr_accessor :birth, :coefficients_salary
  @@allowance = 300

  def initialize(id, name, birth, coefficients_salary)
    super(id, name)
    @birth = birth
    @coefficients_salary = coefficients_salary
  end

  def self.allowance
    @@allowance
  end

  def self.input
    table = Terminal::Table.new do |t|
      t.add_row ["Enter employee information:".ljust(66)]
    end

    puts table

    print "id:"
    id = gets.chomp.to_i
    print "name:"
    name = gets.chomp
    print "birth:"
    birth = gets.chomp.to_i
    print "coefficients salary:"
    coefficients_salary = gets.chomp.to_f

    table = Terminal::Table.new do |t|
      t.add_row ["id:", id.to_s.ljust(43)]
      t.add_row ["name:", name.ljust(43)]
      t.add_row ["birth:", birth.to_s.ljust(43)]
      t.add_row ["coefficients salary:", coefficients_salary.to_s.ljust(43)]
    end

    puts table

    Employee.new(id, name, birth, coefficients_salary)
  end

  def output
    super
    puts "Birth: #{@birth}"
    puts "Coefficients salary: #{@coefficients_salary}"
  end

  def Payroll
    @coefficients_salary * 1550 + @@allowance
  end

  def >(other)
    @coefficients_salary > other.coefficients_salary
  end

  def to_h
    {
      "id" => @id,
      "name" => @name,
      "birth" => @birth,
      "coefficients_salary" => @coefficients_salary,
      "allowance" => @@allowance
    }
  end

  def to_json(options = {})
    {
      id: @id,
      name: @name,
      birth: @birth,
      coefficients_salary: @coefficients_salary,
      allowance: @@allowance
    }.to_json(options)
  end
end
