package core;

import core.Types;
import rm.types.RPG.EventCommand;

using StringTools;
using Lambda;

@:native('EventBuilder')
class EventBuilder {
  public var _commands: Array<EventCommand> = [];
  public var _currentIndentLvl = 0;

  public function new() {}

  public static function create() {
    return new EventBuilder();
  }

  public function showText(text: String, background: WinBackground, position: WinPosition) {
    var params: Array<Any> = [text, background, position];
    this._commands.push({
      code: SHOWTEXT,
      indent: this._currentIndentLvl,
      parameters: params
    });

    return this;
  }

  public function controlTimer(startStop: TimerCodes, seconds: Int) {
    this._commands.push({
      code: CNTRLTIMER,
      indent: this._currentIndentLvl,
      parameters: [startStop, seconds]
    });
  }

  public function nameInput(actorId: Int, characterLength: Int) {
    this._commands.push({
      code: NAMEINPUT,
      indent: this._currentIndentLvl,
      parameters: [actorId, characterLength]
    });

    return this;
  }

  public function addPartyMember(actorId: Int) {
    this.changePartyMember(actorId, MemberAddRemove.ADD);
    return this;
  }

  public function removePartyMember(actorId: Int) {
    this.changePartyMember(actorId, MemberAddRemove.REMOVE);
    return this;
  }

  public function changePartyMember(actorId: Int, addRemove: MemberAddRemove) {
    this._commands.push({
      code: CHANGEPARTYMEM,
      indent: this._currentIndentLvl,
      parameters: [actorId, addRemove]
    });
    return this;
  }

  public function openSave() {
    this._commands.push({
      code: OPENSAVE,
      indent: this._currentIndentLvl,
      parameters: []
    });
    return this;
  }

  public function openMenu() {
    this._commands.push({
      code: OPENMENU,
      indent: this._currentIndentLvl,
      parameters: []
    });
    return this;
  }

  public function gameOver() {
    this._commands.push({
      code: GAMEOVER,
      indent: this._currentIndentLvl,
      parameters: []
    });
  }

  public function ToTitle() {
    this._commands.push({
      code: TOTITLE,
      indent: this._currentIndentLvl,
      parameters: []
    });

    return this;
  }

  public function script(script: String, indent: Int) {
    var params = [script.trim()];
    this._commands.push({
      code: SCRIPT,
      indent: this._currentIndentLvl,
      parameters: params
    });
    return this;
  }

  public function commands() {
    return this._commands;
  }
}
