package visnov;

import macros.FnMacros;
import utils.Comment;
import rm.Globals;
import rm.scenes.Scene_Map as RmScene_Map;

typedef VNParams = {};

@:native('LunaVN')
@:expose('LunaVN')
class Main {
  public static var Params: VNParams = null;

  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) -> ~/<LunaVN>/ig.match(plugin.description))[0];
    Params ={};

    trace(Params);
    Comment.title('Scene_Map');
    FnMacros.jsPatch(true, RmScene_Map, Scene_Map);
  }

  public static function params() {
    return Params;
  }
}
