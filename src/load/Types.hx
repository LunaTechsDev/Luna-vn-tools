package load;

enum abstract LoadEvents(String) from String to String {
  public var GOTO = 'gotoLoadScene';
  public var LEAVE = 'leaveLoadScene';
}
