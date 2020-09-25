package save;

enum abstract SaveEvents(String) from String to String {
  public var GOTO = 'gotoSaveScene';
  public var LEAVE = 'leaveSaveScene';
}
