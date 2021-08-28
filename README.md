# Health Bar

![](https://i.imgur.com/mGdoR2S.gif)

## What is it?
  - A copy-n-paste script for Ruby2D that provides a simple looking health bar for your game or project.
  - Although the script is called HealthBar, you can use it to make any status bar you may need in your project.

## How to use it?
  - For the script to work you will need the [ruby2d](https://github.com/ruby2d/ruby2d) and the [math2d](https://github.com/UalaceCafe/math2d) gems.
  - Simply copy and paste the `health_bar.rb` script into your project folder and then require it in your code.
  - Create a Health Bar entity with `HealthBar.new(`[options](#Options)`)`.
  - Add the health bar object to the scene with the `add` method (e.g.: `healthbar.add`).
  - See `example/example.rb`.

## Options
  When creating a health bar, you may specify a value for each of the following parameters:

  * `x:` the x coordinate of the health bar (default: 15)
  * `y:` the y coordinate of the health bar (default: 10)
  * `width:` the width of the health bar, including the frame. The actual health bar has a width of `width - 4`, which means that the frame has a thickness of 2 (default: 100)
  * `height:` the height of the health bar, including the frame. The same rules applies (default: 20)
  * `color1:` the color that represents full health. If you are using the color change feature of this script, this value must be written as a hex color string starting with a hash symbol. If not, hex, normalized rgb or even color keywords will work (default: `#44ff00`)
  * `color2:` the color that represents low health. If `change_color` is set to `false`, this is not used (default: `#ff0011`)
  * `background:` the background bar color (default: `#2e2e2e`)
  * `change_color:` defines if the bar color should change when the current health changes. If set to true, full health results in `color1` and low health results in `color2` - colors in between are calculated using linear interpolation (default: `false`)
  * `max:` self explanatory. Cannot be set lower or equal to zero, so be careful when calculating/setting the health of your character/enemy (default: 100)
  * `current:` self explanatory. This one doesn't raise errors on wrong values as they are automatically corrected on the update block (default: `max`)

## Credits
  - Thanks to [rosszurowski](https://github.com/rosszurowski) for his [hex linear interpolation algorithm](https://gist.github.com/rosszurowski/67f04465c424a9bc0dae).