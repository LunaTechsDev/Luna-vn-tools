package save;

import rm.scenes.Scene_Save;
import rm.managers.SceneManager;
import save.Types.SaveEvents;
import rm.scenes.Scene_Map;

using WindowExtensions;

class MapPatch extends Scene_Map {
  var _saveWindow: VNSaveWindow;

  public override function createAllWindows() {
    untyped _Scene_Map_createAllWindows.call(this);
    this.createVNSaveWindow();
  }

  public function createVNSaveWindow() {
    // Parameter
    var info = Main.Params;
    this._saveWindow = new VNSaveWindow(info.x, info.y, info.width, info.height);
    this._saveWindow.setSaveText(info.saveText);
    this._saveWindow.setupEvents((win) -> {
      win.on(SaveEvents.GOTO, () -> {
        SceneManager.push(Scene_Save);
      });
    });
    this.addWindow(this._saveWindow);
  }

  public override function update() {
    // super.update();
    untyped _Scene_Map_update.call(this);
    this.processVNSaveWindowVisibility();
  }

  public function processVNSaveWindowVisibility() {
    if (this._messageWindow.isOpenOrVisible() && !this._saveWindow.isOpenOrVisible()) {
      this._saveWindow.show();
      this._saveWindow.open();
    } else {
      this._saveWindow.close();
      this._saveWindow.hide();
    }
  }
}
