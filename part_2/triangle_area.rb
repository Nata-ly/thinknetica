# frozen_string_literal: true

def data_validation
  value = 0
  loop do
    puts 'Вы ошиблись. Попробуйте еще раз. Для выхода нажмите Ctrl + C'
    value = gets.chomp.to_i
    break if value.positive?
  end
  value
end

puts 'Введите размер основания треугольника'
a = gets.chomp.to_i
a = data_validation unless a.positive?

puts 'Введите высоту треугольника'
h = gets.chomp.to_i
h = data_validation unless h.positive?

puts "Площадь треугольника = #{0.5 * a * h}"
