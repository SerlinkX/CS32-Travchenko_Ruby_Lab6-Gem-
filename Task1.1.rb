# test/test_converter.rb

require 'minitest/autorun'
require 'Task1'
require 'json'

class TestCsvToJsonConverter < Minitest::Test
  def setup
    @csv_comma_file_path = 'test_comma.csv'
    @csv_semicolon_file_path = 'test_semicolon.csv'
    @json_file_path = 'test.json'

    # CSV з комами
    CSV.open(@csv_comma_file_path, 'wb') do |csv|
      csv << %w[id name age]
      csv << [1, 'Alice', 30]
      csv << [2, 'Bob', 25]
    end

    # CSV з крапками з комою
    CSV.open(@csv_semicolon_file_path, 'wb', col_sep: ';') do |csv|
      csv << %w[id name age]
      csv << [1, 'Alice', 30]
      csv << [2, 'Bob', 25]
    end
  end

  def teardown
    File.delete(@csv_comma_file_path) if File.exist?(@csv_comma_file_path)
    File.delete(@csv_semicolon_file_path) if File.exist?(@csv_semicolon_file_path)
    File.delete(@json_file_path) if File.exist?(@json_file_path)
  end

  def test_to_json_with_comma_delimiter
    converter = CsvToJsonConverter::Converter.new(@csv_comma_file_path)
    expected_json = [
      { "id" => "1", "name" => "Alice", "age" => "30" },
      { "id" => "2", "name" => "Bob", "age" => "25" }
    ].to_json

    assert_equal JSON.parse(expected_json), JSON.parse(converter.to_json)
  end

  def test_to_json_with_semicolon_delimiter
    converter = CsvToJsonConverter::Converter.new(@csv_semicolon_file_path, delimiter: ';')
    expected_json = [
      { "id" => "1", "name" => "Alice", "age" => "30" },
      { "id" => "2", "name" => "Bob", "age" => "25" }
    ].to_json

    assert_equal JSON.parse(expected_json), JSON.parse(converter.to_json)
  end
end
