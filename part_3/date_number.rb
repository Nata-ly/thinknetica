# frozen_string_literal: true

puts 'Введите число.месяц.год через точку'
day, month, year = gets.chomp.gsub(/\s+/, '').split('.').map(&:to_i)

def high_year?(year)
  (year % 4).zero? && (!(year % 100).zero? || ((year % 100).zero? && (year % 400).zero?))
end

def data_valid?(day, month, year)
  return false if month > 12
  return false if day > DAYS_IN_MONTH[month][:day]

  true
end

days_in_february = ->(year) { high_year?(year) ? 29 : 28 }

DAYS_IN_MONTH = {
  1  => { label: :january,   day: 31 },
  2  => { label: :february,  day: days_in_february.call(year) },
  3  => { label: :march,     day: 31 },
  4  => { label: :april,     day: 30 },
  5  => { label: :may,       day: 31 },
  6  => { label: :june,      day: 30 },
  7  => { label: :july,      day: 31 },
  8  => { label: :august,    day: 31 },
  9  => { label: :september, day: 30 },
  10 => { label: :october,   day: 31 },
  11 => { label: :november,  day: 30 },
  12 => { label: :december,  day: 31 }
}.freeze

until data_valid?(day, month, year) do
  puts 'Вы ввели неправильную дату. Введите число.месяц.год через точку'
  day, month, year = gets.chomp.gsub(/\s+/, '').split('.').map(&:to_i)
end

number_of_days = 0

# слаживаем дни месяцов до заданного
(1...month).each { |index| number_of_days += DAYS_IN_MONTH[index][:day] }
# добавляем дни заданного месяца
number_of_days += day

puts "#{day} #{DAYS_IN_MONTH[month][:label]} #{year} - #{number_of_days} дней от начала года"
