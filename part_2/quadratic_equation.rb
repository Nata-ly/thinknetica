# frozen_string_literal: true

puts 'Введите стороны a,b,c через запятую'
a, b, c = gets.chomp.gsub(/\s+/, '').split(',').map(&:to_i)

d = b**2 - 4 * a * c
puts "d = #{d}"
if d.negative?
  puts 'Уравнение действительных решений не имеет'
elsif d.zero?
  x = - b / (2 * a)
  puts "x = #{x}"
else
  x1 = (- b + Math.sqrt(d)) / (2 * a)
  x2 = (- b - Math.sqrt(d)) / (2 * a)
  puts "x1 = #{x1}, x2 = #{x2}"
end
