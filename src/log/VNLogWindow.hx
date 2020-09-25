package log;

import rm.core.Rectangle;
import rm.windows.Window_Selectable;

using WindowExtensions;

class VNLogWindow extends Window_Selectable {
  private var _logText: Array<String>;

  public function new(x: Int, y: Int, width: Int, height: Int) {
    #if compileMV
    super(x, y, width, height);
    #else
    var rect = new Rectangle(x, y, width, height);
    super(rect);
    #end
  }

  public function setLogText(text: Array<String>) {
    this._logText = text;
  }

  public override function update() {
    super.update();
  }

  public function paintLogTextItem() {}
}
