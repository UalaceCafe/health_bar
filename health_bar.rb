require 'ruby2d'
require 'math2d'

class HealthBar < Ruby2D::Entity
  attr_reader :max
  attr_accessor :current

  def initialize(opts = {})
    @x = opts[:x] || 15
    @y = opts[:y] || 10
    @width = opts[:width] || 100
    @height = opts[:height] || 20
    @color1 = opts[:color1] || '#44ff00'
    @color2 = opts[:color2] || '#ff0011'
    @background = opts[:background] || '#2e2e2e'
    @change_color = opts[:change_color] || false

    @max = opts[:max] || 100
    raise ArgumentError, 'max health cannot be less or equal to zero' if @max <= 0

    @current = opts[:current] || @max
  end

  def max=(value)
    raise ArgumentError, 'max health cannot be less or equal to zero' if value <= 0
    
    @max = value
  end

  def render; end

  def update
    @current = 0 if @current.negative?
    @current = @max if @current > @max

    frame_size = 2
    Rectangle.new(x: @x, y: @y, width: @width, height: @height, color: 'black')
    Rectangle.new(x: @x + frame_size, y: @y + frame_size, width: @width - 2 * frame_size, height: @height - 2 * frame_size, color: @background)

    bar_width = Utils2D.map(@current, 0, @max, 0, @width - 2 * frame_size)
    color = if @change_color
              amount = @current / @max.to_f

              lerp_hex(@color1.gsub('#', '').to_i(16), @color2.gsub('#', '').to_i(16), amount)
            else
              @color1
            end
    Rectangle.new(x: @x + frame_size, y: @y + frame_size, width: bar_width, height: @height - 2 * frame_size, color: color)
  end

  private

  def lerp_hex(a, b, amt)
    a_rgb = [a >> 16, a >> 8 & 0xFF, a & 0xFF]
    b_rgb = [b >> 16, b >> 8 & 0xFF, b & 0xFF]

    value = [
      Utils2D.lerp(b_rgb[0], a_rgb[0], amt).to_i,
      Utils2D.lerp(b_rgb[1], a_rgb[1], amt).to_i,
      Utils2D.lerp(b_rgb[2], a_rgb[2], amt).to_i
    ]

    hex = ((1 << 24) + (value[0] << 16) + (value[1] << 8) + value[2] | 0).to_s(16)
    hex.slice!(0)

    "##{hex}"
  end
end
