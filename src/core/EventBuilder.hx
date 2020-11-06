package core;

import core.Types;
import rm.types.RPG.EventCommand;

using StringTools;
using Lambda;

// TODO: Combine Event Functionality
@:native('EventBuilder')
@:expose('EventBuilder')
class EventBuilder {
  public var _commands: Array<EventCommand> = [];
  public var _metadata: Map<String, Dynamic> = new Map<String, Dynamic>();
  public var _currentIndentLvl = 0;

  public function new() {}

  public static function create() {
    return new EventBuilder();
  }

  public function showText(text: String, background: WinBackground = OPAQUE, position: WinPosition = BOTTOM) {
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

  public function changeGoldDir(amount: Int) {
    return this.changeGold(ChangeType.DIRECT, amount);
  }

  public function changeGoldVar(variableId: Int) {
    return this.changeGold(ChangeType.VARIABLE, variableId);
  }

  public function changeGold(changeType: ChangeType, amount: Int) {
    this._commands.push({
      code: CHANGEGOLD,
      indent: this._currentIndentLvl,
      parameters: [this.operationSign(amount), changeType, amount]
    });
    return this;
  }

  public function changeItemDir(itemId: Int, amount: Int) {
    return this.changeItems(itemId, ChangeType.DIRECT, amount);
  }

  public function changeItemVar(variableId: Int, amount: Int) {
    return this.changeItems(variableId, ChangeType.VARIABLE, amount);
  }

  public function changeItems(itemVarId: Int, changeType: ChangeType, amount: Int) {
    this._commands.push({
      code: CHANGEITEMS,
      indent: this._currentIndentLvl,
      parameters: [itemVarId, this.operationSign(amount), changeType, amount]
    });
    return this;
  }

  public function changeWepDir(itemId: Int, amount: Int, includeEqp: Bool = false) {
    return this.changeWep(itemId, ChangeType.DIRECT, amount, includeEqp);
  }

  public function changeWepVar(variableId: Int, amount: Int, includeEqp: Bool = false) {
    return this.changeWep(variableId, ChangeType.VARIABLE, amount, includeEqp);
  }

  public function changeWep(itemVarId: Int, changeType: ChangeType, amount: Int, includeEqp: Bool = false) {
    this._commands.push({
      code: CHANGEWEP,
      indent: this._currentIndentLvl,
      parameters: [itemVarId, this.operationSign(amount), changeType, amount, includeEqp]
    });
    return this;
  }

  public function changeArmorDir(itemId: Int, amount: Int, includeEqp: Bool = false) {
    return this.changeArmor(itemId, ChangeType.DIRECT, amount, includeEqp);
  }

  public function changeArmorVar(variableId: Int, amount: Int, includeEqp: Bool = false) {
    return this.changeArmor(variableId, ChangeType.VARIABLE, amount, includeEqp);
  }

  public function changeArmor(itemVarId: Int, changeType: ChangeType, amount: Int, includeEqp: Bool = false) {
    this._commands.push({
      code: CHANGEARMOR,
      indent: this._currentIndentLvl,
      parameters: [itemVarId, this.operationSign(amount), changeType, amount, includeEqp]
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

  public function changeWindowColor(red: Int, green: Int, blue: Int, alpha: Int = 1) {
    this._commands.push({
      code: CHANGEWINCOLOR,
      indent: this._currentIndentLvl,
      parameters: [red, green, blue, alpha]
    });
    return this;
  }

  public function eraseEvent() {
    this._commands.push({
      code: ERASEEVENT,
      indent: this._currentIndentLvl,
      parameters: []
    });
    return this;
  }

  public function changePlayerFollowers(onOff: Bool) {
    this._commands.push({
      code: CHANGEFOLLOWERS,
      indent: this._currentIndentLvl,
      parameters: []
    });
    return this;
  }

  public function gatherFollowers() {
    this._commands.push({
      code: GATHERFOLLOWERS,
      indent: this._currentIndentLvl,
      parameters: []
    });
    return this;
  }

  public function fadeOutScreen() {
    this._commands.push({
      code: FADEOUTSCREEN,
      indent: this._currentIndentLvl,
      parameters: []
    });
    return this;
  }

  public function fadeInScreen() {
    this._commands.push({
      code: FADEINSCREEN,
      indent: this._currentIndentLvl,
      parameters: []
    });
    return this;
  }

  public function wait(frames: Int) {
    this._commands.push({
      code: WAIT,
      indent: this._currentIndentLvl,
      parameters: [frames]
    });
    return this;
  }

  public function changeBattleBgm(name: String, volume: Int = 100, pitch: Int = 100, pan: Int = 0) {
    this._commands.push({
      code: CHANGEBATTLEBGM,
      indent: this._currentIndentLvl,
      parameters: [name, volume, pitch, pan]
    });
    return this;
  }

  public function changeVictoryMe(name: String, volume: Int = 100, pitch: Int = 100, pan: Int = 0) {
    this._commands.push({
      code: CHANGEVICTORYME,
      indent: this._currentIndentLvl,
      parameters: [name, volume, pitch, pan]
    });
    return this;
  }

  public function changeDefeatMe(name: String, volume: Int = 100, pitch: Int = 100, pan: Int = 0) {
    this._commands.push({
      code: CHANGEDEFEATME,
      indent: this._currentIndentLvl,
      parameters: [name, volume, pitch, pan]
    });
    return this;
  }

  public function playBgm(name: String, volume: Int = 100, pitch: Int = 100, pan: Int = 0) {
    this._commands.push({
      code: PLAYBGM,
      indent: this._currentIndentLvl,
      parameters: [name, volume, pitch, pan]
    });
    return this;
  }

  public function fadeOutBgm(frames: Int) {
    this._commands.push({
      code: FADEOUTBGM,
      indent: this._currentIndentLvl,
      parameters: [frames]
    });
    return this;
  }

  public function resumeBgm() {
    this._commands.push({
      code: REPLAYBGM,
      indent: this._currentIndentLvl,
      parameters: []
    });
    return this;
  }

  public function saveBgm() {
    this._commands.push({
      code: SAVEBGM,
      indent: this._currentIndentLvl,
      parameters: []
    });
    return this;
  }

  public function playMe(name: String, volume: Int = 100, pitch: Int = 100, pan: Int = 0) {
    this._commands.push({
      code: PLAYME,
      indent: this._currentIndentLvl,
      parameters: [name, volume, pitch, pan]
    });
    return this;
  }

  public function playSe(name: String, volume: Int = 100, pitch: Int = 100, pan: Int = 0) {
    this._commands.push({
      code: PLAYSE,
      indent: this._currentIndentLvl,
      parameters: [name, volume, pitch, pan]
    });
    return this;
  }

  public function stopSe() {
    this._commands.push({
      code: STOPSE,
      indent: this._currentIndentLvl,
      parameters: []
    });
    return this;
  }

  public function playMovie(name: String) {
    this._commands.push({
      code: PLAYMOVIE,
      indent: this._currentIndentLvl,
      parameters: [name]
    });
    return this;
  }

  public function changeMapName(name: String) {
    this._commands.push({
      code: CHANGEMAPNAME,
      indent: this._currentIndentLvl,
      parameters: [name]
    });
    return this;
  }

  public function changeTileset(tilesetId: Int) {
    this._commands.push({
      code: CHANGETILESET,
      indent: this._currentIndentLvl,
      parameters: [tilesetId]
    });
    return this;
  }

  public function changeBattleBack(battleBack1: String, battleBack2: String) {
    this._commands.push({
      code: CHANGEBATTLEBACK,
      indent: this._currentIndentLvl,
      parameters: [battleBack1, battleBack2]
    });
    return this;
  }

  public function changeName(actorId: Int, name: String) {
    this._commands.push({
      code: CHANGENAME,
      indent: this._currentIndentLvl,
      parameters: [actorId, name]
    });
    return this;
  }

  public function changeNickname(actorId: Int, nickname: String) {
    this._commands.push({
      code: CHANGENICKNAME,
      indent: this._currentIndentLvl,
      parameters: [actorId, nickname],
    });
    return this;
  }

  public function changeProfile(actorId: Int, profileText: String) {
    this._commands.push({
      code: CHANGEPROFILE,
      indent: this._currentIndentLvl,
      parameters: [actorId, profileText]
    });
    return this;
  }

  /**
   * Recovers the actor or actors hp/mp, etc.
   * If Id > 0 it will recover a specific actor hp/mp.
   * If Id < 0 it will recover all actors.
   * @param partyActorId
   */
  public function recoverAll(partyActorId: Int = -1) {
    this._commands.push({
      code: RECOVERALL,
      indent: this._currentIndentLvl,
      parameters: [partyActorId]
    });
    return this;
  }

  /**
   * Recovers the enemy or enemies hp/mp, etc.
   * If Id > 0 it will recover a specific enemies hp.
   * If Id < 0 it will recover all enemies.
   * @param troopEnemyId
   */
  public function enemyRecoverAll(troopEnemyId: Int = -1) {
    this._commands.push({
      code: ENEMYRECOVERALL,
      indent: this._currentIndentLvl,
      parameters: []
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

  public function abortBattle() {
    this._commands.push({
      code: ABORTBATTLE,
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

  public function metadata() {
    return this._metadata;
  }

  public function addMetadata(key: String, value: Dynamic) {
    this._metadata.set(key, value);
    return this;
  }

  public function getMetadata(key: String) {
    return this._metadata.get(key);
  }

  public function operationSign(value: Float) {
    return value > 0 ? 0 : 1;
  }
}
