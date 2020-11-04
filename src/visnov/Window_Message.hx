package visnov;

import visnov.Types.VNSysEvents;
import core.VNExtensions;
import rm.core.Rectangle;
import rm.windows.Window_Message as RmWindow_Message;

class Window_Message extends RmWindow_Message {
  public var _shadowVNWinOpacity: Float;
  public var _shadowVNFadeComplete: Bool;

  #if compileMV
  public override function initialize() {
    untyped _Window_Message_intiailize.call(this);
    this._shadowVNFadeComplete = true;
    this.setupLVNEvents();
  }
  #else
  public override function initialize(rect: Rectangle) {
    untyped _Window_Message_initialize.call(this);
    this._shadowVNFadeComplete = true;
    this.setupLVNEvents();
  }
  #end

  public function setupLVNEvents() {
    Main.listener.on(VNSysEvents.SHOWMSGWINDOW, () -> {
      this.vnShow();
    });

    Main.listener.on(VNSysEvents.HIDEMSGWINDOW, () -> {
      this.vnHide();
    });
    Main.listener.on(VNSysEvents.FADEINMSGWINDOW, () -> {
      this.vnFadeIn();
    });

    Main.listener.on(VNSysEvents.FADEOUTMSGWINDOW, () -> {
      this.vnFadeOut();
    });
  }

  public override function update() {
    untyped _Window_Message_update.call(this);
    this.updateVNFade();
  }

  public function updateVNFade() {
    // var opacityResult = this.opacity;
    if (!this._shadowVNFadeComplete) {
      VNExtensions.updateFade(this._shadowVNWinOpacity, cast this);
    }
    // if (!this._shadowVNFadeComplete && this._shadowVNWinOpacity != this.opacity) {
    //   opacityResult = Amaryllis.lerp(this.opacity, this._shadowVNWinOpacity, 0.045);

    // }
    // if (Math.abs(this._shadowBackdropOpacity - this._lvnBackdropSprite.opacity) < 0.5) {
    //   opacityResult = Math.round(opacityResult);
    // }

    // this.opacity = opacityResult;
  }

  public function vnFadeIn() {
    this._shadowVNFadeComplete = false;
    this._shadowVNWinOpacity = 255;
  }

  public function vnFadeOut() {
    this._shadowVNFadeComplete = false;
    this._shadowVNWinOpacity = 0;
  }

  public function vnShow() {
    this.show();
  }

  // Hides the window when working with VN plugins.
  public function vnHide() {
    // May have to adjust if this hides children.
    this.hide();
  }
}
