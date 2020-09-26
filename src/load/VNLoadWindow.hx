package load;

import load.Types.LoadEvents;
import rm.core.Rectangle;
import rm.windows.Window_Base;

using WindowExtensions;

class VNLoadWindow extends Window_Base {
  private var _loadText: String;

  public function new(x: Int, y: Int, width: Int, height: Int) {
    #if compileMV
    super(x, y, width, height);
    #else
    var rect = new Rectangle(x, y, width, height);
    super(rect);
    #end
    this._loadText = '';
    // Setup for button mode and clicking
  }

  public function setupEvents(fn: (VNLoadWindow) -> Void) {
    fn(this);
  }

  public override function update() {
    untyped _Window_Base_update.call(this);
    this.refresh();
    this.processClick();
  }

  public function processClick() {
    if (this.isTouchedInsideFrame()) {
      this.emit(LoadEvents.GOTO);
    }
  }

  public function refresh() {
    if (this.contents != null) {
      this.contents.clear();
      this.paintSaveText();
    }
  }

  public function paintSaveText() {
    this.drawText(this._loadText, 0, 0, this.contentsWidth(), 'center');
  }

  public function setSaveText(text: String) {
    this._loadText = text;
  }
}
