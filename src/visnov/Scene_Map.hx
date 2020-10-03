package visnov;

import visnov.Types.VNSysEvents;
import core.Amaryllis;
import pixi.interaction.EventEmitter;
import visnov.sprites.SpriteBust;
import rm.scenes.Scene_Map as RmScene_Map;

class Scene_Map extends RmScene_Map {
  public var _lvnBusts: Array<SpriteBust>;
  public var _lvnListener: EventEmitter;

  public override function initialize() {
    untyped _Scene_Map_initialize.call(this);
    this._lvnBusts = [];
    this._lvnListener = Amaryllis.createEventEmitter();
  }

  public override function createAllWindows() {
    untyped _Scene_Map_createAllWindows.call(this);
    this.addBustsToMessageWindow();
  }

  public function addBustsToMessageWindow() {
    // Adds all necessary busts to the message window

    for (index in 0...Main.Params.bustLimit) {
      var bust = new SpriteBust(0, 0); // add Optional bitmap later
      setupBustEvents(bust);
      this._lvnBusts.push(bust);
      this._messageWindow.addChild(bust);
    }
  }

  public function setupBustEvents(bust: SpriteBust) {
    Main.listener.on(VNSysEvents.SHOWBUST, (id: Int) -> {
      var bust = this.bust(id);
      bust.show();
    });

    Main.listener.on(VNSysEvents.HIDEBUST, (id: Int) -> {
      var bust = this.bust(id);
      bust.hide();
    });

    Main.listener.on(VNSysEvents.MOVEBUSTTO, (id: Int, x: Int, y: Int) -> {
      var bust = this.bust(id);
      bust.moveTo(x, y);
    });

    Main.listener.on(VNSysEvents.MOVEBUSTBY, (id: Int, x: Int, y: Int) -> {
      var bust = this.bust(id);
      bust.moveBy(x, y);
    });
  }

  public function bust(Id: Int) {
    return this._lvnBusts[Id - 1];
  }
}
