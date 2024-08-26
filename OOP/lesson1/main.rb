# frozen_string_literal: true

require_relative 'transportation_means'
require_relative 'o_to'
require 'json'
require 'terminal-table'
require 'byebug'
require 'tty-prompt'
require 'colorize'

def data_file_path
  File.join(File.dirname(__FILE__), 'data.json')
end

def save_data(new_data)
  file_path = data_file_path
  # Kiểm tra xem tệp data.json đã tồn tại hay không
  if File.exist?(file_path)
    # Đọc dữ liệu từ tệp data.json
    existing_data = JSON.parse(File.read(file_path))
  else
    # Nếu tệp data.json không tồn tại, sử dụng dữ liệu mới là dữ liệu hiện tại
    existing_data = []
  end

  # Chuyển đổi dữ liệu mới thành hash với ID là key
  new_data_hash = new_data.map(&:to_h).each_with_object({}) do |entry, hash|
    hash[entry["id"]] = entry
  end

  # Tạo một hash để kiểm tra trùng lặp ID từ dữ liệu hiện tại
  existing_data_hash = existing_data.each_with_object({}) do |entry, hash|
    hash[entry["id"]] = entry
  end

  # Kết hợp dữ liệu hiện tại với dữ liệu mới
  combined_data = existing_data_hash.merge(new_data_hash).values

  # Ghi dữ liệu mới vào tệp data.json
  File.open(file_path, 'w') do |file|
    file.puts JSON.pretty_generate(combined_data)
  end
end

def continue?
  puts "Do you want to continue? (Y/N)"
  continue  = gets.chomp.upcase
  continue == "Y"
end

def display_success(message)
  puts message.colorize(:green)
end

def display_error(message)
  puts message.colorize(:red)
end

def display_data(data)
  return puts "No data available".colorize(:red) if data.empty?

  rows = data.map { |d| d.values }
  headings = data.first.keys
  table = Terminal::Table.new(headings: headings, rows: rows)
  puts table
end

def display_menu
  menu = Terminal::Table.new do |t|
    t.title = 'Vehicle Management Menu'.colorize(:cyan)
    t.headings = ['Option', 'Description']
    t.add_row ['1', 'Enter information for 1 vehicle object']
    t.add_row ['2', 'Display information for vehicle object by ID']
    t.add_row ['3', 'Enter information for n vehicle objects']
    t.add_row ['4', 'Display information for all vehicle objects with base speed']
    t.add_row ['5', 'Sort vehicle list by base speed in descending order']
    t.add_row ['6', 'Exit']
  end
  puts menu
  print 'Select function: '.colorize(:green)
end

def main
  vehicle = []

  loop do
    display_menu
    choice = gets.chomp.to_i

    case choice
    when 1
      begin
        puts "\n"
        oto = OTo.input
        break  if oto.nil?
        vehicle << oto
        save_data(vehicle)
        display_success("Car added successfully! \u{1F697}") # Xe hơi icon
      rescue => e
        display_error("Failed to add car: #{e.message}")
      end
      break unless continue?
    when 2
      puts "\n"
    when 3
      puts "\n"
    when 4
      puts "\n"
    when 6
      display_success("Exiting...")
      break
    else
      puts 'Invalid function. Please select again.'
    end
  end
end

main
