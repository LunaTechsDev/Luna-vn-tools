package visnov;

import rm.core.JsonEx;
import rm.managers.PluginManager;
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
    registerAllPluginCommands(plugin.name);
  }

  public static function params() {
    return Params;
  }

  public static inline function registerAllPluginCommands(pluginName: String) {
    #if compileMV
    #else
    PluginManager.registerCommand(pluginName, 'moveBustTo', (jsonParams) -> {
      var params: Dynamic = JsonEx.parse(jsonParams);
      moveBustTo(params.id, params.x, params.y);
    });

    PluginManager.registerCommand(pluginName, 'moveBustBy', (jsonParams) -> {
      var params: Dynamic = JsonEx.parse(jsonParams);
      moveBustBy(params.id, params.x, params.y);
    });

    PluginManager.registerCommand(pluginName, 'fadeBustTo', (jsonParams) -> {
      var params: Dynamic = JsonEx.parse(jsonParams);
      fadeBustTo(params.id, params.opacity, params.duration);
    });

    PluginManager.registerCommand(pluginName, 'fadeBustBy', (jsonParams) -> {
      var params: Dynamic = JsonEx.parse(jsonParams);
      fadeBustBy(params.id, params.opacity, params.duration);
    });

    PluginManager.registerCommand(pluginName, 'scaleBustTo', (jsonParams) -> {
      var params: Dynamic = JsonEx.parse(jsonParams);
      scaleBustTo(params.id, params.x, params.y, params.duration);
    });

    PluginManager.registerCommand(pluginName, 'hideBust', (jsonParams) -> {
      var params: Dynamic = JsonEx.parse(jsonParams);
      hideBust(params.id);
    });

    PluginManager.registerCommand(pluginName, 'showBust', (jsonParams) -> {
      var params: Dynamic = JsonEx.parse(jsonParams);
      showBust(params.id);
    });

    PluginManager.registerCommand(pluginName, 'emoteBust', (jsonParams) -> {
      var params: Dynamic = JsonEx.parse(jsonParams);
      emoteBust(params.id, params.emote);
    });

    PluginManager.registerCommand(pluginName, 'animBust', (jsonParams) -> {
      var params: Dynamic = JsonEx.parse(jsonParams);
      animateBust(params.id, params.animation);
    });

    PluginManager.registerCommand(pluginName, 'highlightBust', (jsonParams) -> {
      var params: Dynamic = JsonEx.parse(jsonParams);
      highlightBust(params.id);
    });

    PluginManager.registerCommand(pluginName, 'darkenBust', (jsonParams) -> {
      var params: Dynamic = JsonEx.parse(jsonParams);
      darkenBust(params.id);
    });

    PluginManager.registerCommand(pluginName, 'setBust', (jsonParams) -> {
      var params: Dynamic = JsonEx.parse(jsonParams);
      setBust(params.id, params.bustSetName);
    });
    #end
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

  public static function fadeBustTo(Id: Int, opacity: Int, duration: Int) {
    listener.emit(VNSysEvents.FADEBUSTTO, Id, opacity, duration);
  }

  public static function fadeBustBy(id: Int, opacity: Int, duration: Int) {
    listener.emit(VNSysEvents.FADEBUSTBY, id, opacity, duration);
  }

  public static function scaleBustTo(id: Int, x: Float, y: Float, duration: Int) {
    listener.emit(VNSysEvents.SCALEBUSTTO, x, y, duration);
  }

  // Replace emote with the string name
  public static function emoteBust(id: Int, emote: String) {
    listener.emit(VNSysEvents.EMOTEBUST, id, emote);
  }

  public static function animateBust(id: Int, animation: String) {
    listener.emit(VNSysEvents.ANIMBUST, id, animation);
  }

  public static function highlightBust(id: Int) {
    listener.emit(VNSysEvents.HIGHLIGHTBUST, id);
  }

  public static function darkenBust(id: Int) {
    listener.emit(VNSysEvents.DARKENBUST, id);
  }

  public static function setBust(id: Int, bustSetName: String) {}

  public static function setBackdrop(imageName: String) {
    listener.emit(VNSysEvents.SETBACKDROP, imageName);
  }

  public static function showBackdrop() {
    listener.emit(VNSysEvents.SHOWBACKDROP);
  }

  public static function hideBackdrop() {
    listener.emit(VNSysEvents.HIDEBACKDROP);
  }

  public static function setScreenPic(imageName: String) {
    listener.emit(VNSysEvents.SETSCREENPIC, imageName);
  }

  public static function showScreenPic() {
    listener.emit(VNSysEvents.SHOWSCREENPIC);
  }

  public static function hideScreenPic() {
    listener.emit(VNSysEvents.HIDESCREENPIC);
  }
}
