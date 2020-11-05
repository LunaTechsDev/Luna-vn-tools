package visnov;

import js.lib.Object;
import rm.types.RM.TextState;
import core.Amaryllis;
import visnov.Types.VNSysEvents;
import rm.core.Rectangle;
import rm.windows.Window_Message as RmWindow_Message;

using StringTools;

class Window_Message extends RmWindow_Message {
  public var _shadowVNWinOpacity: Float;
  public var _shadowVNFadeComplete: Bool;

  #if compileMV
  public override function initialize() {
    var params = Main.Params;
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

  public override function startMessage() {
    untyped _Window_Message_startMessage.call(this);
    if (Main.Params.enableWordWrap) {
      this.vnUpdateTextState(this._textState);
    }
  }

  // Word Wrap Support
  public function vnUpdateTextState(originalTextState: TextState) {
    var textState = originalTextState;
    var length = originalTextState.text.length;
    while (originalTextState.index < length) {
      var currentLines = textState.text.substring(0, textState.index + 1).split('\n');
      var latestLine = currentLines[currentLines.length - 1];
      var textUpToIndex = latestLine.substring(0, latestLine.length);
      if (untyped textWidth(textUpToIndex) > this.contentsWidth()) {
        // Look for last space on the latestLine to break on word
        var spaceOffset = 1;
        while (!textUpToIndex.isSpace(textUpToIndex.length - spaceOffset)) {
          spaceOffset += 1;
          trace('Processing Text Offset', spaceOffset);
        }
        // Adjusting for the initial space offset
        var textWithBreak = textState.text.substring(0, textState.index - (spaceOffset - 1));
        // Adjusting for the space we found
        var textAfterBreak = textState.text.substring(textState.index - (spaceOffset - 2), textState.text.length);
        textState.text = textWithBreak + '\n' + textAfterBreak;
      }
      originalTextState.index++;
    }
    originalTextState.index = 0;
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
