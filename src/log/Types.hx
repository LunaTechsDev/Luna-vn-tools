package log;

typedef LogElement = {
  var text: String;
  var ?bustImage: String;
  var ?charName: String;
  var ?audioFileName: String;
}

enum abstract LogEvent(String) from String to String {
  public var GOTO = 'gotoLogScene';
  public var LEAVE = 'leaveLogScene';
}
