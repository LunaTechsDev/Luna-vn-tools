package save;

import utils.Comment;
import utils.Fn;
import macros.FnMacros;
import rm.Globals;
import rm.scenes.Scene_Map;

typedef VNParams = {
  var x: Int;
  var y: Int;
  var width: Int;
  var height: Int;
  var saveText: String;
}

@:native('LunaVNSave')
@:native('LunaVNSave')
class Main {
  public static var Params: VNParams = null;

  public static function main() {
    var params = Globals.Plugins.filter((plugin) -> ~/<LunaVNSave>/ig.match(plugin.description))[0].parameters;
    Params = {
      x: Fn.parseIntJs(params['x']),
      y: Fn.parseIntJs(params['y']),
      width: Fn.parseIntJs(params['width']),
      height: Fn.parseIntJs(params['height']),
      saveText: params['saveText']
    }

    trace(Params);
    Comment.title('Scene_Map');
    FnMacros.jsPatch(true, Scene_Map, MapPatch);
  }

  public static function params() {
    return Params;
  }
}
