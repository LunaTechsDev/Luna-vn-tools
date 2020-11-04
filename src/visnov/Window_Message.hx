package visnov;

import core.Amaryllis;
import visnov.Types.VNSysEvents;
import rm.core.Rectangle;
import rm.windows.Window_Message as RmWindow_Message;

class Window_Message extends RmWindow_Message {
  public var _shadowVNWinOpacity: Float;
  public var _shadowVNFadeComplete: Bool;

  #if compileMV
  public override function initialize() {
    var params = Main.params;
    var width = params.msgWindowWidth;
    var height = params.msgWindowHeight;
    var x = params.msgWindowX;
    var y = params.msgWindowY;
    this.openness = 0;
    this.initMembers();
    this.createSubWindows();
    this.updatePlacement();
    untyped _Window_Message_intiailize.call(this, x, y, width, height);
    this._shadowVNFadeComplete = true;
    this.setupLVNEvents();
  }
  #else
  public override function initialize(rect: Rectangle) {
    untyped _Window_Message_initialize.call(this, rect);
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
    if (!this._shadowVNFadeComplete) {
      var displayObj = this;
      var shadowOpacity = this._shadowVNWinOpacity;

      var opacityResult = displayObj.opacity;
      if (shadowOpacity != displayObj.opacity) {
        opacityResult = Amaryllis.lerp(displayObj.opacity, shadowOpacity, 0.045);
      }
      if (Math.abs(shadowOpacity - displayObj.opacity) < 0.5) {
        opacityResult = Math.round(opacityResult);
      }
      displayObj.opacity = opacityResult;
      this.contentsOpacity = opacityResult;
    }
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
