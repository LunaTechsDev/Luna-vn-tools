package load;

import macros.FnMacros;
import utils.Comment;
import utils.Fn;
import rm.Globals;

typedef VNParams = {
  var x: Int;
  var y: Int;
  var width: Int;
  var height: Int;
  var loadText: String;
}

class Main {
  public static var Params: VNParams = null;

  public static function main() {
    var params = Globals.Plugins.filter((plugin) -> ~/<LunaVNLoad>/ig.match(plugin.description))[0].parameters;
    Params = {
      x: Fn.parseIntJs(params['x']),
      y: Fn.parseIntJs(params['y']),
      width: Fn.parseIntJs(params['width']),
      height: Fn.parseIntJs(params['height']),
      loadText: params['loadText']
    }

    // Patches the Scene_Map with functionality for the VNLoadPlugin
    trace(Params);
    Comment.title('Scene_Map');
    FnMacros.jsPatch(true, Scene_Map, MapPatch);
  }

  public static function params() {
    return Params;
  }
}
