package visnov.sprites;

import pixi.core.math.Point;
import rm.managers.ImageManager;
import rm.core.Bitmap;
import rm.sprites.Sprite_Base;
import rm.core.Sprite;
import core.Amaryllis;
import core.VNExtensions;

enum MoveType {
  Linear;
  // Add More Later
}

@:keep
@:native('LVNSpriteBust')
@:expose('LVNSpriteBust')
#if compileMV
class SpriteBust extends Sprite_Base {
#else
class SpriteBust extends Sprite {
#end
private var _shadowOpacity: Float;
private var _shadowX: Float;
private var _shadowY: Float;
private var _shadowScale: Point;
private var _fadeDuration: Int;
private var _scaleDuration: Int;
private var _defaultMoveType: MoveType;
private var _moveWait: Int;

public function new(x: Int, y: Int, ?bitmap: Bitmap) {
  super();
  if (bitmap != null) {
    this.bitmap = bitmap;
    handleLoading(this.bitmap);
  }
  this.x = x;
  this.y = y;
  this._moveWait = 30;
}

public function setBust(bustSetName: String) {
  var bustBitmap = ImageManager.loadPicture(bustSetName, 0);
  handleLoading(bustBitmap);
}

public function handleLoading(bitmap: Bitmap) {
  bitmap.addLoadListener((bitmap) -> {
    this.bitmap = new Bitmap(Main.Params.bustWidth, Main.Params.bustHeight);
    this.bitmap.blt(
      bitmap,
      0,
      0,
      bitmap.width,
      bitmap.height,
      0,
      0,
      Main.Params.bustWidth,
      Main.Params.bustHeight
    );
    trace('Loaded Sprite Bust');
    this.show();
  });
}

#if compileMV
override public function initialize(): Void {
  super.initialize();
#else
override public function initialize(?bitmap: Bitmap): Void {
  super.initialize(bitmap);
#end

this._fadeDuration = 0;
this._shadowOpacity = this.opacity;
this._shadowX = this.x;
this._shadowY = this.y;
this._shadowScale = this.scale;
this._defaultMoveType = Linear;
} // TODO: Replace with proper Some/None
public function moveTo(x: Int, ?y: Int) {
  this._shadowX = x;
  if (y != null) {
    this._shadowY = y;
  }

  this._moveWait = 30;
  trace('Starting Move', this._moveWait);
}

public function moveBy(x: Int, ?y: Int) {
  this._shadowX += x;
  if (y != null) {
    this._shadowY += y;
  }

  this._moveWait = 30;
}

public function fadeTo(opacity: Float, duration: Int = 30) {
  this._shadowOpacity = opacity;
  this._fadeDuration = duration;
}

public function fadeBy(opacity: Float, duration: Int = 30) {
  this._shadowOpacity += opacity;
  this._fadeDuration = duration;
}

public function scaleTo(x: Float, ?y: Float, ?duration: Int = 30) {
  this.scale.set(x, y);
  this._scaleDuration = duration;
}

// Add update function to sprite_base
public override function update() {
  super.update();
  this.updateFade();
  this.updateScaling();
  if (this._moveWait == 0) {
    this.updateMovement();
  }
  if (this._moveWait > 0) {
    this._moveWait--;
  }
}

public function updateFade() {
  VNExtensions.updateFade(this._shadowOpacity, cast this);
}

public function updateScaling() {}

public function updateMovement() {
  var xResult = this.x;
  var yResult = this.y;
  switch (this._defaultMoveType) {
    case Linear:
      if (this._shadowX != this.x) {
        xResult = Amaryllis.lerp(this.x, this._shadowX, 0.025);
      }

      if (this._shadowY != this.y) {
        yResult = Amaryllis.lerp(this.y, this._shadowY, 0.025);
      }
    case _:
      // Do nothing
  }
  if (this._shadowX == this.x && this._shadowY == this.y) {
    // Disable Movement When matching
    this._moveWait = -1;
    trace('Disable Moving');
  }
  var xDiff = Math.abs(this._shadowX - this.x);
  var yDiff = Math.abs(this._shadowY - this.y);
  if (xDiff < 0.5) {
    xResult = Math.round(xResult);
  }

  if (yDiff < 0.5) {
    yResult = Math.round(yResult);
  }

  this.move(xResult, yResult);
  trace('Moving', this.x, this.y);
  this._refresh();
}

public function oscillateSize() {
  var xYResult = Math.abs(Math.sin(Date.now().getTime() / 1000) / 2.0);
  this.scale.x = 1 - xYResult;
  this.scale.y = 1 - xYResult;
}
}
