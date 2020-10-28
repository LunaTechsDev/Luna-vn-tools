package core;

import core.Types.EventCode;
import rm.types.RPG.EventCommand;

class EventBuilder {
  public var _commands: Array<EventCommand> = [];

  public function new() {}

  public static function create() {
    return new EventBuilder();
  }

  public function showText() {
    var command = null;
    // var command: EventCommand ={};
  }

  public function commands() {
    return this._commands;
  }
}
