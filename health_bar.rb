require 'ruby2d'

class HealthBar < Ruby2D::Entity
  attr_reader :max
  attr_accessor :x, :y, :width, :height, :color1, :color2, :background, :change_color, :current

  FRAME_SIZE = 2

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

    Rectangle.new(x: @x, y: @y, width: @width, height: @height, color: 'black')
    Rectangle.new(x: @x + FRAME_SIZE, y: @y + FRAME_SIZE, width: @width - 2 * FRAME_SIZE, height: @height - 2 * FRAME_SIZE, color: @background)

    bar_width = map(@current, 0, @max, 0, @width - 2 * FRAME_SIZE)
    color = if @change_color
              amount = @current / @max.to_f

              if @color1.is_a?(String) && @color2.is_a?(String)
                lerp_hex(@color1.gsub('#', '').to_i(16), @color2.gsub('#', '').to_i(16), amount)
              elsif @color1.is_a?(Array) && @color2.is_a?(Array)
                r = lerp(@color2[0], @color1[0], amount)
                g = lerp(@color2[1], @color1[1], amount)
                b = lerp(@color2[2], @color1[2], amount)
                a = lerp(@color2[3], @color1[3], amount)
                [r, g, b, a]
              else
                raise ArgumentError, 'both `color1` and `color2` must be of the same type: either a Hex String or a Normalized RGBA Array'
              end
            else
              @color1
            end
    Rectangle.new(x: @x + FRAME_SIZE, y: @y + FRAME_SIZE, width: bar_width, height: @height - 2 * FRAME_SIZE, color: color)
  end

  private

  def map(value, a1, a2, b1, b2)
    raise ArgumentError, 'division by 0 when mapping two ranges - a1 cannot be equal to a2' if a2 == a1

    slope = 1.0 * (b2 - b1) / (a2 - a1)
    b1 + slope * (value - a1)
  end

  def lerp(a, b, amt)
    (b - a) * (3.0 - amt * 2.0) * amt * amt + a
  end

  def lerp_hex(a, b, amt)
    a_rgb = [a >> 16, a >> 8 & 0xFF, a & 0xFF]
    b_rgb = [b >> 16, b >> 8 & 0xFF, b & 0xFF]

    value = [
      lerp(b_rgb[0], a_rgb[0], amt).to_i,
      lerp(b_rgb[1], a_rgb[1], amt).to_i,
      lerp(b_rgb[2], a_rgb[2], amt).to_i
    ]

    hex = ((1 << 24) + (value[0] << 16) + (value[1] << 8) + value[2] | 0).to_s(16)
    hex.slice!(0)

    "##{hex}"
  end
end
