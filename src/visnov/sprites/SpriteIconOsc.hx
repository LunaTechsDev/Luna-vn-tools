package visnov.sprites;

import rm.core.Bitmap;
import rm.sprites.Sprite_Base;

/**
 * Utility Sprite Class for creating sprites of oscillating size.
 */
@:keep
@:native('LVNSpriteIconOsc')
@:expose('LVNSpriteIconOsc')
class LTSpriteIconOsc extends Sprite_Base {
  public function new(x: Int, y: Int, ?bitmap: Bitmap) {
    super();
    this.x = x;
    this.y = y;
    this.anchor.x = 0.5;
    this.anchor.y = 0.5;
    if (bitmap != null) {
      this.bitmap = bitmap;
    }
  }

  public override function update() {
    super.update();
    this.oscillateSize();
  }

  public function oscillateSize() {
    var xYResult = Math.abs(Math.sin(Date.now().getTime() / 1000) / 2.0);
    this.scale.x = 1 - xYResult;
    this.scale.y = 1 - xYResult;
  }
}
