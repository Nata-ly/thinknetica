# frozen_string_literal: true

require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'train.rb'

train1 = Train.new('train 1', :cargo, 3)
train2 = Train.new('train 2', :passenger)
train3 = Train.new('train 3', :passenger)
puts "Созданы поезда #{train1}, #{train2}"

station1 = Station.new('station1')
station2 = Station.new('station2')
station3 = Station.new('station3')
station4 = Station.new('station4')
station5 = Station.new('station5')
station6 = Station.new('station6')
puts 'Созданы станции 1-6'

route1 = Route.new(station1, station6)
route2 = Route.new(station2, station5)
puts 'Созданы маршруты 1-2'

train2.add_route(route2)
puts 'train2.add_route(route2)'
route2.print_route_list
puts "текущая станция #{train2.station.train_list}"
puts "текущая - #{train2.station}"
puts "следущая - #{train2.next_station}"
puts "предыдущая - #{train2.past_station}"

# Может возвращать список всех поездов на станции, находящиеся в текущий момент
station2.train_list


# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
route2.add_station(station2)
route2.add_station(station3)
route2.add_station(station1)
puts 'станции добавлены'
route2.print_route_list
route2.delete_station(station2)
puts 'станции удалены - station2'
route2.print_route_list

# Может перемещаться между станциями, указанными в маршруте.
# Перемещение возможно вперед и назад, но только на 1 станцию за раз.
puts 'перемещаться между станциям train2'
train2.move_next_station
puts train2.station.name
puts "прошлая #{train2.past_station.train_list}"
puts "текущая #{train2.station.train_list}"
train2.move_past_station
puts train2.station.name
train2.move_past_station
puts train2.station.name

# Может прицеплять/отцеплять вагоны (по одному вагону за операцию,
# метод просто увеличивает или уменьшает количество вагонов).
# Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
#
# Может возвращать текущую скорость
train2.add_speed(10)
puts train2.speed
train2.add_wagons
puts train2.amount_wagons
train2.brake
train2.add_wagons
puts train2.amount_wagons
puts "\n"

# Может возвращать список поездов на станции по типу (см. ниже):
# кол-во грузовых, пассажирских
train1.add_route(route2)
train2.add_route(route2)
train3.add_route(route2)
puts "поездов на станции #{train2.station.count_train_list}"
puts "поездов на станции по типам - #{train2.station.train_list_by_type}"
