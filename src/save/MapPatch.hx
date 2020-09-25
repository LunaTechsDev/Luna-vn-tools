package save;

import rm.scenes.Scene_Save;
import rm.managers.SceneManager;
import save.Types.SaveEvents;
import rm.scenes.Scene_Map;

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
}
