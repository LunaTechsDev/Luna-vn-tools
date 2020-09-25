package log;

enum abstract LogEvent(String) from String to String {
  public var GOTO = 'gotoLogScene';
  public var LEAVE = 'leaveLogScene';
}
