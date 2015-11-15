class SchemaService
  attr_accessor :file, :headers_csv
  require 'csv'
  @@schema  = ''
  @@hash    = { }

  def initialize
    file  = File.readlines('./db/schema.rb')
    @file = file
  end

  def call
    parse_schema
    create_hash
  end

  def hash
    call
    @@hash
  end

  private

  def parse_schema
    file.each do |line|
    	parts = line.split ' '
    	unless parts == nil or parts.length < 1 or parts[0] == '#'
    		if parts[0] == 'create_table'
    			table_name = parts[1].delete("\"").delete(',')
          @@schema << "__#{table_name},"
    		end

    		if parts[0][0] == 't'
    			field_name = parts[1].delete("\",").chomp('t.')
          @@schema << "#{field_name}__"
    		end
    	end
    end
  end

  def create_hash
    return if @@hash.present?
    array      = convert_source
    hash_array = convert_to_hash(array)

    hash_array.each_with_index do |i, v|
      @@hash.merge!( { i[0] => i.reject { |k| k == i[0] } } )
    end
  end

  def convert_source
    @@schema    = @@schema.split('__').join(',')
    @@schema[0] =  ''
    @@schema.split(',,')
  end

  def convert_to_hash(array)
    _arr = []
    array.each do |k, v|
      _arr << k.split(',')
    end
    _arr
  end

  def schema_to_csv
    CSV.open("schema.csv", "wb") {|csv| @@hash.to_a.each {|elem| csv << elem} }
  end
end
