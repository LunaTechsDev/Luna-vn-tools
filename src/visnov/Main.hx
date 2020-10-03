package visnov;

import utils.Fn;
import visnov.Types.VNSysEvents;
import visnov.Types.VNParams;
import core.Amaryllis;
import pixi.interaction.EventEmitter;
import macros.FnMacros;
import utils.Comment;
import rm.Globals;
import rm.scenes.Scene_Map as RmScene_Map;

using StringTools;

@:native('LunaVN')
@:expose('LunaVN')
class Main {
  public static var listener: EventEmitter = Amaryllis.createEventEmitter();
  public static var Params: VNParams = null;

  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) -> ~/<LunaVN>/ig.match(plugin.description))[0];
    var params = plugin.parameters;
    Params = {
      bustLimit: Fn.parseIntJs(params['bustLimit']),
      breathingAnim: untyped params['breathingAnim'].toLowerCase().trim() == 'true'
    };

    trace(Params);
    Comment.title('Scene_Map');
    FnMacros.jsPatch(true, RmScene_Map, Scene_Map);
  }

  public static function params() {
    return Params;
  }

  public static function moveBustTo(id: Int, x: Int, y: Int) {
    listener.emit(VNSysEvents.MOVEBUSTTO, id, x, y);
  }

  public static function moveBustBy(id: Int, x: Int, y: Int) {
    listener.emit(VNSysEvents.MOVEBUSTBY, id, x, y);
  }

  public static function hideBust(id: Int) {
    listener.emit(VNSysEvents.HIDEBUST, id);
  }

  public static function showBust(id: Int) {
    listener.emit(VNSysEvents.SHOWBUST, id);
  }
}
