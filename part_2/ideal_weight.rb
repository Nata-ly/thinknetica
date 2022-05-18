# frozen_string_literal: true

puts 'Как вас зовут?'
name = gets.chomp.capitalize
name = 'Неизвестный' if name.empty?
height = 0

loop do
  puts 'Какого вы роста?'
  height = gets.chomp.to_i
  break if height.positive?

  puts 'Вы ошиблись. Попробуйте еще раз. Для выхода нажмите Ctrl + C'
end

ideal_weight = (height - 110) * 1.15

if ideal_weight.positive?
  puts "#{name}, ваш идеальный вес #{ideal_weight}"
elsif ideal_weight.zero?
  puts "#{name}, вы близки к идеалу"
else
  puts 'Ваш вес уже оптимальный'
end
