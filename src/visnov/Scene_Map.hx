package visnov;

import rm.managers.ImageManager;
import rm.core.Sprite;
import visnov.Types.VNSysEvents;
import core.Amaryllis;
import pixi.interaction.EventEmitter;
import visnov.sprites.SpriteBust;
import rm.scenes.Scene_Map as RmScene_Map;

class Scene_Map extends RmScene_Map {
  public var _lvnBusts: Array<SpriteBust>;
  public var _lvnListener: EventEmitter;
  public var _lvnBackdropSprite: Sprite;
  public var _lvnScreenPicSprite: Sprite;
  public var _shadowBackdropOpacity: Float;
  public var _shadowScreenPicOpacity: Float;

  public override function initialize() {
    untyped _Scene_Map_initialize.call(this);
    this._lvnBusts = [];
    this._lvnListener = Amaryllis.createEventEmitter();
    this._shadowBackdropOpacity = 0;
    this._shadowScreenPicOpacity = 0;

    this.setupBackdropEvents();
    this.setupScreenPicEvents();
  }

  public override function createDisplayObjects() {
    // super.createDisplayObjects();
    untyped _Scene_Map_createDisplayObjects.call(this);
    this.createLVNBackdropSprite();
    this.createLVNScreenPicSprite();
  }

  public function createLVNBackdropSprite() {
    this._lvnBackdropSprite = new Sprite();
    this._lvnBackdropSprite.opacity = 0;
    this.addChildAt(this._lvnBackdropSprite, 3);
  }

  public function createLVNScreenPicSprite() {
    this._lvnScreenPicSprite = new Sprite();
    this._lvnScreenPicSprite.opacity = 0;
    this.addChildAt(this._lvnBackdropSprite, 4);
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

    Main.listener.on(VNSysEvents.FADEBUSTTO, (id: Int, opacity: Int, duration: Int) -> {
      var bust = this.bust(id);
      bust.fadeTo(opacity, duration);
    });

    Main.listener.on(VNSysEvents.FADEBUSTBY, (id: Int, opacity: Int, duration: Int) -> {
      var bust = this.bust(id);
      bust.fadeBy(opacity, duration);
    });

    Main.listener.on(VNSysEvents.SCALEBUSTTO, (id: Int, x: Float, y: Float, duration: Int) -> {
      var bust = this.bust(id);
      bust.scaleTo(x, y, duration);
    });

    Main.listener.on(VNSysEvents.SETBUST, (id: Int, bustSetName: String) -> {
      var bust = this.bust(id);
      bust.setBust(bustSetName);
    });
  }

  public function setupBackdropEvents() {
    Main.listener.on(VNSysEvents.SHOWBACKDROP, () -> {
      // Start Fade In
      this._shadowBackdropOpacity = 255;
    });

    Main.listener.on(VNSysEvents.HIDEBACKDROP, () -> {
      // Fade Out
      this._shadowBackdropOpacity = 0;
    });
  }

  public function setupScreenPicEvents() {
    Main.listener.on(VNSysEvents.SHOWSCREENPIC, () -> {
      // Start Fade In
      this._shadowScreenPicOpacity = 255;
    });

    Main.listener.on(VNSysEvents.HIDESCREENPIC, () -> {
      // Fade Out
      this._shadowScreenPicOpacity = 0;
    });
  }

  /*
   * Map Control Functions ---
   */
  public function bust(Id: Int) {
    return this._lvnBusts[Id - 1];
  }

  public function setBackdrop(imageName: String) {
    var bitmap = ImageManager.loadPicture(imageName);
    bitmap.addLoadListener((bitmap) -> {
      this._lvnBackdropSprite.bitmap = bitmap;
      // transition backdrop
      Main.listener.emit(VNSysEvents.SHOWBACKDROP);
    });
  }

  public function setScreenPicture(imageName: String) {
    var bitmap = ImageManager.loadPicture(imageName);
    bitmap.addLoadListener((bitmap) -> {
      this._lvnScreenPicSprite.bitmap = bitmap;
      // transition screen picture
      Main.listener.emit(VNSysEvents.SHOWSCREENPIC);
    });
  }

  public override function update() {
    untyped _Scene_Map_update.call(this);
    this.updateBackdrop();
    this.updateScreenSprite();
  }

  public function updateBackdrop() {}

  public function updateScreenSprite() {}
}
