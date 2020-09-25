package log;

import rm.scenes.Scene_MenuBase;

class VNLogScene extends Scene_MenuBase {
  var logText: Array<String>;
  private var _logWindow: VNLogWindow;

  public function new() {
    super();
  }

  public override function create() {
    super.create();
    this.createLogWindow();
  }

  public function createLogWindow() {}

  public function setLogText(text: Array<String>) {
    this.logText = text;
  }
}
