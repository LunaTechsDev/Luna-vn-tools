package visnov;

typedef VNParams = {
  var bustLimit: Int;
  var breathingAnim: Bool;
};

enum abstract BustEvents(String) from String to String {
  public var MOVETO = 'moveTo';
  public var MOVEBY = 'moveBy';
  public var HIDE = 'hide';
  public var SHOW = 'show';
  public var FADEOUT = 'fadeOut';
  public var FADETO = 'fadeTo';
  public var FADEBY = 'fadeBy';
  public var FADEIN = 'fadeIn';
  public var SCALETO = 'scaleTo';
}

enum abstract VNSysEvents(String) from String to String {
  public var MOVEBUSTTO = 'moveBustTo';
  public var MOVEBUSTBY = 'moveBustBy';
  public var HIDEBUST = 'hideBust';
  public var SHOWBUST = 'showBust';
  public var FADEBUSTTO = 'fadeToBust';
  public var FADEBUSTBY = 'fadeByBust';
  public var SCALEBUSTTO = 'scaleTo';
  public var EMOTEBUST = 'emoteBust';

  /**
   * Used for showing animations on the bust via MV/MZ animation handler.
   */
  public var ANIMBUST = 'animBust';

  public var HIGHLIGHTBUST = 'highlightBust';
  public var DARKENBUST = 'darkenBust';
  public var SETBUST = 'setBust';
  // Backdrop & Screen Pic Types
  public var SETBACKDROP = 'setBackdrop';
  public var SHOWBACKDROP = 'showBackdrop';
  public var HIDEBACKDROP = 'hideBackdrop';
  public var SETSCREENPIC = 'setScreenPic';
  public var SHOWSCREENPIC = 'showScreenPic';
  public var HIDESCREENPIC = 'hideScreenPic';
  // Hide & Show VN Message Window
  public var SHOWMSGWINDOW = 'showMsgWindow';
  public var HIDEMSGWINDOW = 'hideMsgWindow';
  public var FADEINMSGWINDOW = 'fadeInMsgWindow';
  public var FADEOUTMSGWINDOW = 'fadeOutMsgWindow';
}
