# lib/csv_to_json_converter/converter.rb

require 'csv'
require 'json'

module CsvToJsonConverter
  class Converter
    def initialize(csv_file_path, delimiter: ',')
      @csv_file_path = csv_file_path
      @delimiter = delimiter
    end

    def to_json
      data = CSV.read(@csv_file_path, headers: true, col_sep: @delimiter)
      json_data = data.map(&:to_h)
      JSON.pretty_generate(json_data)
    end

    def save_to_file(json_file_path)
      json_content = to_json
      File.write(json_file_path, json_content)
    end
  end
end
