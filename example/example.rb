#=
# Controls:
#   W - increase maximum health
#   S - decrease maximum health
#   A - decrease current health
#   D - increase current health
#=
require 'ruby2d'
require_relative '../health_bar'

set(title: 'Health Bar example', width: 600, height: 400, fullscreen: true, background: '#205b7d')

WIDTH = Window.width
HEIGHT = Window.height

health_bar = HealthBar.new(color1: [0.266, 1, 0, 1], color2: [1, 0, 0.066, 1], change_color: true)

on :key_held do |event|
  case event.key
  when 'a'
    health_bar.current -= 1
  when 'd'
    health_bar.current += 1
  when 'w'
    health_bar.max += 10
    health_bar.current = health_bar.max
  when 's'
    health_bar.max -= 10
    health_bar.current = health_bar.max
  end
end

update do
  clear

  health_bar.add

  Text.new("Max health: #{health_bar.max}", x: WIDTH - 130, y: 10, size: 15, color: 'yellow')
  Text.new("Current health: #{health_bar.current}", x: WIDTH - 130, y: 30, size: 15, color: 'yellow')
end

show
