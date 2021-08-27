require 'ruby2d'
require_relative '../health_bar'

set(title: 'Health Bar example', width: 600, height: 400, background: '#205b7d')

WIDTH = Window.width
HEIGHT = Window.height

health_bar = HealthBar.new

on :key_held do |event|
  case event.key
  when 'a'
    health_bar.current_health -= 1
  when 'd'
    health_bar.current_health += 1
  when 'w'
    health_bar.max_health += 10
    health_bar.current_health = health_bar.max_health
  when 's'
    health_bar.max_health -= 10
    health_bar.current_health = health_bar.max_health
  end
end

update do
  clear

  health_bar.add

  Text.new("Max health: #{health_bar.max_health}", x: WIDTH - 130, y: 10, size: 15, color: 'yellow')
  Text.new("Current health: #{health_bar.current_health}", x: WIDTH - 130, y: 30, size: 15, color: 'yellow')
end

show
