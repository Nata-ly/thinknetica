# frozen_string_literal: true

shopping_list = {}
loop do
  puts 'Введите название товара'
  title = gets.chomp
  break if title == 'стоп'

  puts 'Введите цену за единицу товара'
  price = gets.chomp
  puts 'Введите количество товара'
  quantity = gets.chomp

  shopping_list[title] = { price: price, quantity: quantity }
end

sum = 0
shopping_list.each do |title, value|
  itog = value[:price].to_i * value[:quantity].to_f
  sum += itog
  puts "#{title}: #{value[:price]} * #{value[:quantity]} = #{itog}"
end

print "Итого: #{sum}"
