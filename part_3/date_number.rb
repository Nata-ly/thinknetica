# frozen_string_literal: true

puts 'Введите число.месяц.год через точку'
day, month, year = gets.chomp.gsub(/\s+/, '').split('.').map(&:to_i)

def high_year?(year)
  (year % 4).zero? && (year % 100).zero? && (year % 400).zero?
end

def data_valid?(day, month, year)
  return false if month > 12
  return false if day > DAYS_IN_MONTH[month][:day]

  true
end

days_in_february = ->(year) { high_year?(year) ? 29 : 28 }

DAYS_IN_MONTH = {
  1  => { label: :January,   day: 31 },
  2  => { label: :February,  day: days_in_february.call(year) },
  3  => { label: :March,     day: 31 },
  4  => { label: :April,     day: 30 },
  5  => { label: :May,       day: 31 },
  6  => { label: :June,      day: 30 },
  7  => { label: :July,      day: 31 },
  8  => { label: :August,    day: 31 },
  9  => { label: :September, day: 30 },
  10 => { label: :October,   day: 31 },
  11 => { label: :November,  day: 30 },
  12 => { label: :December,  day: 31 }
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
