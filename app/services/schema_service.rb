class SchemaService
  require 'virtus'
  attr_accessor :file, :headers_csv
  require 'csv'
  @@schema  = ''
  @@hash    = {}

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
    @@hash.keys
    @models = []
    @@hash.each do |key, value|
      @models << Table.generate_models(key, value)
    end
    @models
  end

  private

  def parse_schema
    file.each do |line|
      parts = line.split ' '
      next if parts.nil? || parts.length < 1 || parts[0] == '#'
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

  def create_hash
    return if @@hash.present?
    array      = convert_source
    hash_array = convert_to_hash(array)

    hash_array.each_with_index do |i, _v|
      @@hash.merge!(i[0] => i.reject { |k| k == i[0] })
    end
  end

  def convert_source
    @@schema    = @@schema.split('__').join(',')
    @@schema[0] = ''
    @@schema.split(',,')
  end

  def convert_to_hash(array)
    arr_m = []
    array.each do |k, _v|
      arr_m << k.split(',')
    end
    arr_m
  end

  def schema_to_csv
    CSV.open('schema.csv', 'wb') { |csv| @@hash.to_a.each { |elem| csv << elem } }
  end
end
