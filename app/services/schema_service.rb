class SchemaService
  require 'virtus'
  attr_accessor :file, :schema, :sch_hash
  require 'csv'

  def initialize
    file      = File.readlines('./db/schema.rb')
    @file     = file
    @schema   = ''
    @sch_hash = {}
  end

  def call
    parse_schema
    create_hash
  end

  def hash
    call
    @models = []
    sch_hash.each do |key, value|
      @models << Table.generate_models(key, value)
    end
    @models
  end

  def take_column(table, column)
    file.each do |line|
      parts = line.split ' '
      next if parts.nil? || parts.length < 1 || parts[0] == '#'
      if parts[0] == 'create_table'
        @table_name = parts[1].delete("\"").delete(',')
      end
      next unless @table_name == table
      @field_name = parts[1].delete("\",").chomp('t.') if parts[0][0] == 't'
      next unless @field_name == column
      type    = parts[0].gsub!('t.', '')
      default = parts[3].delete("\",") if parts[3]
      key_d   = parts[2].gsub(':', '') if parts[2]
      if parts[1]
        if @field_name.end_with? '_id'
          @hash = { key_d => default, type: type }
        elsif key_d.nil?
          @hash = { key_d => default, type: type }
        else
          @hash = { key_d => default, type: type } if parts[2] && parts[0] != 'add_index'
        end
      end
    end
    Column.new(@hash.symbolize_keys).column_info
  end

  private

  def parse_schema
    file.each do |line|
      parts = line.split ' '
      next if parts.nil? || parts.length < 1 || parts[0] == '#'
      if parts[0] == 'create_table'
        table_name = parts[1].delete("\"").delete(',')
        schema << "__#{table_name},"
      end

      if parts[0][0] == 't'
        field_name  = parts[1].delete("\",").chomp('t.')
        schema << "#{field_name}__"
      end
    end
  end

  def create_hash
    return if sch_hash.present?
    array      = convert_source
    hash_array = convert_to_hash(array)

    hash_array.each_with_index do |i, _v|
      sch_hash.merge!(i[0] => i.reject { |k| k == i[0] })
    end
  end

  def convert_source
    @schema = schema.split('__').join(',')
    schema[0] = ''
    schema.split(',,')
  end

  def convert_to_hash(array)
    arr_m = []
    array.each do |k, _v|
      arr_m << k.split(',')
    end
    arr_m
  end

  def schema_to_csv
    CSV.open('schema.csv', 'wb') { |csv| sch_hash.to_a.each { |elem| csv << elem } }
  end
end
