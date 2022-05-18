# frozen_string_literal: true

def data_validation(number)
  value = 0
  loop do
    puts "Введите сторону - #{number}"
    value = gets.chomp.to_i
    break if value.positive?

    puts 'Вы ошиблись. Попробуйте еще раз. Для выхода нажмите Ctrl + C'
  end
  value
end

array_of_sides = []

3.times do |i|
  value = data_validation(i + 1)
  array_of_sides << value
end

pifagor_array = array_of_sides.sort.collect { |element| element**2 }
array_size = array_of_sides.group_by { |i| i }.size

puts 'Треугольник прямоугольный.' if (pifagor_array[0] + pifagor_array[1]) == pifagor_array[2]
puts 'Треугольник равнобедренный.' if array_size == 2
puts 'Треугольник равносторонний.' if array_size == 1
