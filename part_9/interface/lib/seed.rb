# frozen_string_literal: true

# Preload data.
module Seed
  private

  def seed
    train1 = CargoTrain.new('train1')
    train2 = CargoTrain.new('train2')
    train3 = PassengerTrain.new('train3')
    puts "Созданы поезда #{train1}, #{train2}, #{train3}"

    station1 = Station.new('station1')
    station2 = Station.new('station2')
    station3 = Station.new('station3')
    station4 = Station.new('station4')
    station5 = Station.new('station5')
    station6 = Station.new('station6')
    puts 'Созданы станции 1-6'

    route1 = Route.new(station1, station6)
    route2 = Route.new(station2, station5)
    route3 = Route.new(station1, station6)
    route4 = Route.new(station3, station4)
    puts 'Созданы маршруты 1-4'

    wagons1 = CargoWagon.new('Cargo - 1', 200)
    wagons2 = PassengerWagon.new('Passenger - 1', 50)
    wagons3 = CargoWagon.new('Cargo - 2', 100)
    wagons4 = PassengerWagon.new('Passenger - 2', 60)

    train1.add_route(route1)
    train2.add_route(route2)
    train3.add_route(route3)
    train3.add_route(route4)

    train1.add_wagons(wagons1)
    train1.add_wagons(wagons3)
    train2.add_wagons(wagons3)
    train3.add_wagons(wagons2)
    train3.add_wagons(wagons4)
  end
end
