package log;

import log.Types.LogEvent;
import rm.managers.SceneManager;
import rm.scenes.Scene_Map;

class MapPatch extends Scene_Map {
  public override function start() {
    // super.start();
    untyped _Scene_Map_start.call(this);
    this.setupEvents();
  }

  public override function update() {
    // super.update();
    untyped _Scene_Map.update.call(this);
  }

  public function processLogScene() {
    // // If Pushed Button For Log Scene
    // if () {
    //   this.pushLogScene();
    // }
  }

  public function setupEvents() {
    this.on(LogEvent.GOTO, () -> {
      this.pushLogScene();
    });
  }

  public function pushLogScene() {
    SceneManager.push(VNLogScene);
  }
}
