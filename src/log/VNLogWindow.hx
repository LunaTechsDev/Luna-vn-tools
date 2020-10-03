package log;

import log.Types.LogElement;
import rm.core.Rectangle;
import rm.windows.Window_Selectable;

using WindowExtensions;

class VNLogWindow extends Window_Selectable {
  private var _log: Array<LogElement>;

  public function new(x: Int, y: Int, width: Int, height: Int) {
    #if compileMV
    super(x, y, width, height);
    #else
    var rect = new Rectangle(x, y, width, height);
    super(rect);
    #end
  }

  public function setLog(log: Array<LogElement>) {
    this._log = log;
  }

  public override function update() {
    super.update();
  }

  // Draw ALl Items is called already

  public override function drawItem(index: Int) {
    this.paintLogTextItem(this._log[index], this.itemRect(index));
  }

  public function paintLogTextItem(item: LogElement, rect: Rectangle) {
    switch (item) {
      case(_.charName != null) => true:
        this.drawText(item.charName, cast rect.x, cast rect.y, cast rect.width, 'left');
      case(_.audioFileName != null) => true:
      // Show Audio File Icon
      case(_.bustImage != null) => true:
        this.drawFace(
          item.bustImage,
          0,
          cast rect.x,
          cast rect.y,
          cast rect.width,
          cast rect.height
        );
      case _:
        this.drawText(item.text, cast rect.x, cast rect.y, cast rect.width, 'left');
    }
  }
}
