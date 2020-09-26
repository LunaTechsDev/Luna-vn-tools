package save;

import save.Types.SaveEvents;
import rm.core.Rectangle;
import rm.windows.Window_Base;

using WindowExtensions;

class VNSaveWindow extends Window_Base {
  private var _saveText: String;

  public function new(x: Int, y: Int, width: Int, height: Int) {
    #if compileMV
    super(x, y, width, height);
    #else
    var rect = new Rectangle(x, y, width, height);
    super(rect);
    #end
    this._saveText = '';
    this.setBackgroundType(Main.Params.backgroundType);
    // Setup for button mode and clicking
  }

  public function setupEvents(fn: (VNSaveWindow) -> Void) {
    fn(this);
  }

  public override function update() {
    untyped _Window_Base_update.call(this);
    this.refresh();
    this.processClick();
  }

  public function processClick() {
    if (this.isTouchedInsideFrame()) {
      this.emit(SaveEvents.GOTO);
    }
  }

  public function refresh() {
    if (this.contents != null) {
      this.contents.clear();
      this.paintSaveText();
    }
  }

  public function paintSaveText() {
    this.drawText(this._saveText, 0, 0, this.contentsWidth(), 'center');
  }

  public function setSaveText(text: String) {
    this._saveText = text;
  }
}
