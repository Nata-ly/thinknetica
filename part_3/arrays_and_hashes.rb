# frozen_string_literal: true

# 1. Сделать хеш, содержащий месяцы и количество дней в месяце.
# В цикле выводить те месяцы, у которых количество дней ровно 30

months = {
  January: 31,
  February: 28,
  March: 31,
  April: 30,
  May: 31,
  June: 30,
  July: 31,
  August: 31,
  September: 30,
  October: 31,
  November: 30,
  December: 31
}

months.each { |month, day| puts month if day == 30 }
puts "\n"

# 2. Заполнить массив числами от 10 до 100 с шагом 5

puts (10..100).step(5).to_a
puts "\n"

# 3. Заполнить массив числами фибоначчи до 100

fib = [0, 1]

fib << fib[-1] + fib[-2] while fib[-1] + fib[-2] <= 100
puts fib
puts "\n"

# 4. Заполнить хеш гласными буквами,
# где значением будет являтся порядковый номер буквы в алфавите (a - 1).

vowels_hash = {}

%w[a e i o u y].each { |vowel| vowels_hash[vowel] = vowel.ord - 96 }
puts vowels_hash
