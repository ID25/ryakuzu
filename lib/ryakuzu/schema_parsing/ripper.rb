require 'ripper'
module Ryakuzu
  class Ripper
    attr_reader :schema

    def parse(filename)
      sexp = ::Ripper.sexp IO.read(filename)

      schema_commands = sexp[1][0][2][2]
      @schema = schema_commands.inject({}) do |s, command|
        next if command.length < 1
        command_name = command[1][1][1]

        if command_name == 'create_table'
          table_name = command[1][2][1][0][1][1][1].to_sym
          columns    = command[2][2].map { |i| i[4][1][0][1][1][1] }

          s.merge!(table_name => columns)
        end
        s
      end

      self
    end

    def self.parse(filename)
      new.parse(filename).schema
    end
  end
end
