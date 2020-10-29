package core;

import core.Types;
import rm.types.RPG.EventCommand;

using StringTools;

class EventBuilder {
  public var _commands: Array<EventCommand> = [];

  public function new() {}

  public static function create() {
    return new EventBuilder();
  }

  public function showText(text: String, background: WinBackground, position: WinPosition) {
    var params: Array<Any> = [text, background, position];
    this._commands.push({
      code: SHOWTEXT,
      indent: 0,
      parameters: params
    });

    return this;
  }

  public function nameInput(actorId: Int, characterLength: Int) {
    this._commands.push({
      code: NAMEINPUT,
      indent: 0,
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
      indent: 0,
      parameters: [actorId, addRemove]
    });
    return this;
  }

  public function openSave() {
    this._commands.push({
      code: OPENSAVE,
      indent: 0,
      parameters: []
    });
    return this;
  }

  public function openMenu() {
    this._commands.push({
      code: OPENMENU,
      indent: 0,
      parameters: []
    });
    return this;
  }

  public function gameOver() {
    this._commands.push({
      code: GAMEOVER,
      indent: 0,
      parameters: []
    });
  }

  public function ToTitle() {
    this._commands.push({
      code: TOTITLE,
      indent: 0,
      parameters: []
    });

    return this;
  }

  public function script(script: String, indent: Int) {
    var params = [script.trim()];
    this._commands.push({
      code: SCRIPT,
      indent: 0,
      parameters: params
    });
    return this;
  }

  public function commands() {
    return this._commands;
  }
}
