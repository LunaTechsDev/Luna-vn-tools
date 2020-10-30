package core;

enum abstract TimerCodes(Int) from Int to Int {
  public var START = 0;
  public var STOP = 1;
}

enum abstract MemberAddRemove(Int) from Int to Int {
  public var ADD = 0;
  public var REMOVE = 1;
}

enum abstract WinBackground(Int) from Int to Int {
  public var OPAQUE = 0;
  public var DIM = 1;
  public var TRANSPARENT = 2;
}

enum abstract WinPosition(Int) from Int to Int {
  public var TOP = 0;
  public var MIDDLE = 1;
  public var BOTTOM = 2;
}

enum abstract EventCode(Int) from Int to Int {
  public var END = 0;
  public var SHOWTEXT = 101;
  public var SHOWCHOICE = 102;
  public var COMMENT = 108;
  public var COMMENTDATA = 408;
  public var CONDBRANCH = 111;
  public var ELSE = 411;
  public var LOOP = 112;
  public var REPEATABOVE = 413;
  public var ENDLOOP = 113;
  public var EXITEVENTPROCESS = 115;
  public var COMMONEVENT = 117;
  public var LABEL = 118;
  public var JUMPTOLABEL = 119;
  public var CNTRLSWITCHES = 121;
  public var CNTRLVARIABLES = 122;
  public var CNTRLSELFSWITCHES = 123;
  public var CNTRLTIMER = 124;
  public var CHANGEGOLD = 125;
  public var CHANGEITEMS = 126;
  public var CHANGEWEP = 127;
  public var CHANGEARMOR = 128;
  public var CHANGEPARTYMEM = 129;
  public var CHANGEBATTLEBGM = 132;
  public var CHANGEVICTORYME = 133;
  public var CHANGESAVEACC = 134;
  public var CHANGEMENUACC = 135;

  /**
   * Change Encounter Disable
   */
  public var CHANGEENCDISABLE = 136;

  /**
   * Change Formation Access
   */
  public var CHANGEFORMACC = 138;

  public var CHANGEWINCOLOR = 139;
  public var CHANGEVEHICLEBGM = 140;
  public var TRANSFERPLAYER = 201;
  public var SETVEHICLELOC = 202;
  public var SETEVENTLOC = 203;
  public var SCROLLMAP = 204;
  public var SETMOVEROUTE = 205;
  public var BOARDVEHICLE = 206;
  public var SHOWBALLOON = 213;
  public var ERASEEVENT = 214;
  public var FADEOUTSCREEN = 221;
  public var FADEINSCREEN = 222;
  public var TINTSCREEN = 223;
  public var FLASHSCREEN = 224;
  public var SHAKESCREEN = 225;
  public var WAIT = 230;
  public var SHOWPIC = 231;
  public var MOVEPIC = 232;
  public var ROTATEPIC = 233;
  public var TINTPIC = 234;
  public var ERASEPIC = 235;
  public var SETWEATHEREFFECT = 236;
  public var PLAYBGM = 241;
  public var FADEOUTBGM = 242;
  public var SAVEBGM = 243;
  public var REPLAYBGM = 244;
  public var FADEOUTBGS = 246;
  public var PLAYME = 249;
  public var PLAYSE = 250;
  public var STOPSE = 251;
  public var PLAYMOVIE = 261;
  public var CHANGEMAPNAME = 281;
  public var CHANGETILESET = 282;
  public var CHANGEBATTLEBACK = 283;
  public var CHANGEPARALLAX = 284;
  public var GETLOCINFO = 285;
  public var BATTLEPROCESS = 301;
  public var SHOPPROCESS = 302;
  public var NAMEINPUT = 303;
  public var CHANGEHP = 311;
  public var CHANGEMP = 312;
  public var CHANGESTATE = 313;
  public var RECOVERALL = 313;
  public var CHANGEEXP = 315;
  public var CHANGELVL = 316;
  public var CHANGENICKNAME = 324;
  public var CHANGEPROFILE = 325;
  public var CHANGETP = 326;
  public var CHANGEENEMYHP = 331;
  public var CHANGENEMYMP = 332;
  public var CHANGENEMYSTATE = 333;
  public var ENEMYRECOVERALL = 334;
  public var ENEMYAPPEAR = 335;
  public var ENEMYTRASNFORM = 336;
  public var SHOWBATTLEANIM = 337;
  public var FORCEACTION = 339;
  public var ABORTBATTLE = 340;
  public var CHANGEENEMYTP = 342;
  public var OPENMENU = 351;
  public var OPENSAVE = 352;
  public var GAMEOVER = 353;
  public var TOTITLE = 354;
  public var SCRIPT = 355;
}
