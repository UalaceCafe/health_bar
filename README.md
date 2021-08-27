# Health Bar

![](https://i.imgur.com/mGdoR2S.gif)

## What is it?
  - A plug-n-play script for Ruby2D that provides a simple looking health bar for your game or project.

## How to use it?
  - For the script to work you will need the `ruby2d` and the `math2d` gems.
  - Simply copy and paste the `health_bar.rb` script into your project folder and then require it in your code.
  - Create a Health Bar entity with `HealthBar.new(`[options](#Options)`)`.
  - Add the health bar object to the scene with the `add` method (e.g.: `healthbar.add`).
  - See `example/example.rb`.

## Options
  When creating a health bar, you may specify a value for each of the following parameters:

  * `x:` the x coordinate of the health bar (default: 15)
  * `y:` the y coordinate of the health bar (default: 10)
  * `width:` the width of the health bar, including the frame. The true health bar has a width of `width - 4`, which means that the frame has a thickness of 2 (default: 100)
  * `height:` the height of the health bar, including the frame. The same rules applies (default: 20)
  * `background:` the background bar color (default: `#2e2e2e`)
  * `change_color:` defines if the color should change when the current health changes. If set to true, full health results in a green bar and low health results in a red bar - in between is orange (default: `false`)
  * `max_health:` self explanatory. Cannot be set lower or equal to zero, so be careful when calculating/setting the health of your character/enemy (default: 100)
  * `current_health:` self explanatory. This one doesn't raise errors on wrong values as they are automatically corrected on the update block (default: `max_health`)

## Credits
  - Thanks to [rosszurowski](https://github.com/rosszurowski) for his [hex linear interpolation algorithm](https://gist.github.com/rosszurowski/67f04465c424a9bc0dae).