package log;

import macros.FnMacros;
import utils.Fn;
import utils.Comment;
import rm.scenes.Scene_Map;

typedef LogParams = {}

@:native('LunaLog')
@:expose('LunaLog')
class Main {
  public static var Params: LogParams = null;

  public static function main() {
    Comment.title('Scene_Map');
    FnMacros.jsPatch(true, Scene_Map, MapPatch);
  }
}
