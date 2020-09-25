import pixi.interaction.EventEmitter;
import core.Amaryllis;
import rm.Globals;

using Lambda;
using core.StringExtensions;
using core.NumberExtensions;
using StringTools;
using utils.Fn;

typedef LCParams = {}

@:native('LunaCallEvent')
@:expose('LunaCallEvent')
class Main {
  public static var Params: LCParams = null;
  public static var listener: EventEmitter = Amaryllis.createEventEmitter();

  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) -> ~/<LunaCallEvent>/ig.match(plugin.description))[0];
    var params = plugin.parameters;
    Params ={}

    trace(Params);
  }

  public static function params() {
    return Params;
  }
}
