package core;

import pixi.core.display.DisplayObject;

interface OpacityObject {
  var opacity: Float;
}

class VNExtensions {
  public static inline function updateFade(shadowOpacity: Float, displayObj: OpacityObject) {
    var opacityResult = displayObj.opacity;
    if (shadowOpacity != displayObj.opacity) {
      opacityResult = Amaryllis.lerp(displayObj.opacity, shadowOpacity, 0.045);
    }
    if (Math.abs(shadowOpacity - displayObj.opacity) < 0.5) {
      opacityResult = Math.round(opacityResult);
    }
    displayObj.opacity = opacityResult;
  }
}
