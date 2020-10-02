package load;

import rm.scenes.Scene_Load;
import rm.managers.SceneManager;
import save.Types.SaveEvents;
import rm.scenes.Scene_Map;

using WindowExtensions;

class MapPatch extends Scene_Map {
  var _loadWindow: VNLoadWindow;

  public override function createAllWindows() {
    untyped _Scene_Map_createAllWindows.call(this);
    this.createVNLoadWindow();
  }

  public function createVNLoadWindow() {
    // Parameter
    var info = Main.Params;
    this._loadWindow = new VNLoadWindow(info.x, info.y, info.width, info.height);
    this._loadWindow.setLoadText(info.loadText);
    this._loadWindow.setupEvents((win) -> {
      win.on(SaveEvents.GOTO, () -> {
        SceneManager.push(Scene_Load);
      });
    });
    this.addWindow(this._loadWindow);
  }

  public override function update() {
    // super.update();
    untyped _Scene_Map_update.call(this);
    this.processVNLoadWindowVisibility();
  }

  public function processVNLoadWindowVisibility() {
    if (this._messageWindow.isOpenOrVisible() && !this._loadWindow.isOpenOrVisible()) {
      this._loadWindow.show();
      this._loadWindow.open();
    } else {
      this._loadWindow.close();
      this._loadWindow.hide();
    }
  }
}
