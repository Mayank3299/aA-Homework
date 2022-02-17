require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    return @columns if @columns
    col= DBConnection.execute2(<<-SQL).first
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    col.map!(&:to_sym)
    @columns= col
  end

  def self.finalize!
    self.columns.each do |name|
      define_method(name) do 
        self.attributes[name]
      end

      define_method("#{name}=") do |val|
        self.attributes[name]= val
      end
    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name= table_name
  end

  def self.table_name
    # ...
    @table_name || self.name.tableize
  end

  def self.all
    # ...
    results= DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    parse_all(results)
  end

  def self.parse_all(results)
    # ...
    results.map do |res|
      self.new(res)
    end
  end

  def self.find(id)
    # ...
    res= DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{self.table_name}.id = ?
    SQL

    res ? parse_all(res).first : nil
  end

  def initialize(params = {})
    # ...
    params.each do |name, val|
      name= name.to_sym
      if self.class.columns.include?(name)
        self.send("#{name}=", val)
      else
        raise "unknown attribute '#{name}'"
      end
    end
  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...
    self.class.columns.map {|attr| self.send(attr)}
  end

  def insert
    # ...
    columns= self.class.columns.drop(1)
    col_names= columns.map(&:to_s).join(", ")
    questions= (["?"]*columns.count).join(", ")
    DBConnection.execute(<<-SQL, *attribute_values.drop(1)) 
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{questions})
    SQL

    self.id= DBConnection.last_insert_row_id
  end

  def update
    # ...
    columns= self.class.columns.map{|attr| "#{attr} = ?"}.join(", ")
    DBConnection.execute(<<-SQL, *attribute_values, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{columns}
      WHERE
        #{self.class.table_name}.id= ?
    SQL
  end

  def save
    # ...
    id.nil? ? insert : update
  end
end
