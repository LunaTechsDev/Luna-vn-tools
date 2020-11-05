/** ============================================================================
 *
 *  Luna_VNLoadMV.js
 * 
 *  Build Date: 11/5/2020
 * 
 *  Made with LunaTea -- Haxe
 *
 * =============================================================================
*/
// Generated by Haxe 4.1.3
/*:
@author LunaTechs - Kino
@plugindesc > A VN plugin that adds a load scene button to your game <LunaVNLoad>.

@target MV MZ

@command callEvent
@text Call Event
@desc Allows you to call an event from any map with any event ID


@param x
@text X Position 
@desc The x position in relation to the message window
@default 0

@param y 
@text Y Position
@desc The y position in relation to the message window
@default 0

@param width
@text Width
@desc The width of the load window
@default 100

@param height
@text Height
@desc The height of the load window
@default 75

@param backgroundType
@text Background Type 
@desc The background type of the window 0, 1, 2 (full opacity, semi-transparent, transparent).
@default 0

@param loadText
@text Load Text
@desc The save text shown in the load window
@default Save


@help
==== How To Use ====


MIT License
Copyright (c) 2020 LunaTechsDev
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE
*/

(function ($hx_exports, $global) {
  "use strict";
  var $estr = function () {
      return js_Boot.__string_rec(this, "");
    },
    $hxEnums = $hxEnums || {};
  class EReg {
    constructor(r, opt) {
      this.r = new RegExp(r, opt.split("u").join(""));
    }
    match(s) {
      if (this.r.global) {
        this.r.lastIndex = 0;
      }
      this.r.m = this.r.exec(s);
      this.r.s = s;
      return this.r.m != null;
    }
  }

  EReg.__name__ = true;
  Math.__name__ = true;
  class WindowExtensions {
    static isTouchedInsideFrame(win) {
      let x = win.canvasToLocalX(TouchInput.x);
      let y = win.canvasToLocalY(TouchInput.y);
      if (x >= 0 && y >= 0 && x < win.width) {
        return y < win.height;
      } else {
        return false;
      }
    }
    static isOpenOrVisible(win) {
      if (!win.isOpen()) {
        return win.visible;
      } else {
        return true;
      }
    }
  }

  WindowExtensions.__name__ = true;
  class haxe_iterators_ArrayIterator {
    constructor(array) {
      this.current = 0;
      this.array = array;
    }
    hasNext() {
      return this.current < this.array.length;
    }
    next() {
      return this.array[this.current++];
    }
  }

  haxe_iterators_ArrayIterator.__name__ = true;
  class js_Boot {
    static __string_rec(o, s) {
      if (o == null) {
        return "null";
      }
      if (s.length >= 5) {
        return "<...>";
      }
      let t = typeof o;
      if (t == "function" && (o.__name__ || o.__ename__)) {
        t = "object";
      }
      switch (t) {
        case "function":
          return "<function>";
        case "object":
          if (o.__enum__) {
            let e = $hxEnums[o.__enum__];
            let n = e.__constructs__[o._hx_index];
            let con = e[n];
            if (con.__params__) {
              s = s + "\t";
              return (
                n +
                "(" +
                (function ($this) {
                  var $r;
                  let _g = [];
                  {
                    let _g1 = 0;
                    let _g2 = con.__params__;
                    while (true) {
                      if (!(_g1 < _g2.length)) {
                        break;
                      }
                      let p = _g2[_g1];
                      _g1 = _g1 + 1;
                      _g.push(js_Boot.__string_rec(o[p], s));
                    }
                  }
                  $r = _g;
                  return $r;
                })(this).join(",") +
                ")"
              );
            } else {
              return n;
            }
          }
          if (o instanceof Array) {
            let str = "[";
            s += "\t";
            let _g = 0;
            let _g1 = o.length;
            while (_g < _g1) {
              let i = _g++;
              str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i], s);
            }
            str += "]";
            return str;
          }
          let tostr;
          try {
            tostr = o.toString;
          } catch (_g) {
            return "???";
          }
          if (
            tostr != null &&
            tostr != Object.toString &&
            typeof tostr == "function"
          ) {
            let s2 = o.toString();
            if (s2 != "[object Object]") {
              return s2;
            }
          }
          let str = "{\n";
          s += "\t";
          let hasp = o.hasOwnProperty != null;
          let k = null;
          for (k in o) {
            if (hasp && !o.hasOwnProperty(k)) {
              continue;
            }
            if (
              k == "prototype" ||
              k == "__class__" ||
              k == "__super__" ||
              k == "__interfaces__" ||
              k == "__properties__"
            ) {
              continue;
            }
            if (str.length != 2) {
              str += ", \n";
            }
            str += s + k + " : " + js_Boot.__string_rec(o[k], s);
          }
          s = s.substring(1);
          str += "\n" + s + "}";
          return str;
        case "string":
          return o;
        default:
          return String(o);
      }
    }
  }

  js_Boot.__name__ = true;
  class load_Main {
    static main() {
      let _g = [];
      let _g1 = 0;
      let _g2 = $plugins;
      while (_g1 < _g2.length) {
        let v = _g2[_g1];
        ++_g1;
        if (new EReg("<LunaVNLoad>", "ig").match(v.description)) {
          _g.push(v);
        }
      }
      let params = _g[0].parameters;
      load_Main.Params = {
        x: parseInt(params["x"], 10),
        y: parseInt(params["y"], 10),
        width: parseInt(params["width"], 10),
        height: parseInt(params["height"], 10),
        backgroundType: parseInt(params["backgroundType"], 10),
        loadText: params["loadText"],
      };
      console.log("src/load/Main.hx:33:", load_Main.Params);

      //=============================================================================
      // Scene_Map
      //=============================================================================
      let _Scene_Map__loadWindow = Scene_Map.prototype._loadWindow;
      Scene_Map.prototype._loadWindow = null;
      let _Scene_Map_createAllWindows = Scene_Map.prototype.createAllWindows;
      Scene_Map.prototype.createAllWindows = function () {
        _Scene_Map_createAllWindows.call(this);
        this.createVNLoadWindow();
      };
      let _Scene_Map_createVNLoadWindow =
        Scene_Map.prototype.createVNLoadWindow;
      Scene_Map.prototype.createVNLoadWindow = function () {
        let info = load_Main.Params;
        this._loadWindow = new load_VNLoadWindow(
          info.x,
          info.y,
          info.width,
          info.height
        );
        this._loadWindow.setLoadText(info.loadText);
        this._loadWindow.setupEvents(function (win) {
          win.on("gotoSaveScene", function () {
            SceneManager.push(Scene_Load);
          });
        });
        this.addWindow(this._loadWindow);
      };
      let _Scene_Map_update = Scene_Map.prototype.update;
      Scene_Map.prototype.update = function () {
        _Scene_Map_update.call(this);
        this.processVNLoadWindowVisibility();
      };
      let _Scene_Map_processVNLoadWindowVisibility =
        Scene_Map.prototype.processVNLoadWindowVisibility;
      Scene_Map.prototype.processVNLoadWindowVisibility = function () {
        if (
          WindowExtensions.isOpenOrVisible(this._messageWindow) &&
          !WindowExtensions.isOpenOrVisible(this._loadWindow)
        ) {
          this._loadWindow.show();
          this._loadWindow.open();
        } else {
          this._loadWindow.close();
          this._loadWindow.hide();
        }
      };
    }
  }

  load_Main.__name__ = true;
  class load_MapPatch extends Scene_Map {
    constructor() {
      super();
    }
    createAllWindows() {
      _Scene_Map_createAllWindows.call(this);
      this.createVNLoadWindow();
    }
    createVNLoadWindow() {
      let info = load_Main.Params;
      this._loadWindow = new load_VNLoadWindow(
        info.x,
        info.y,
        info.width,
        info.height
      );
      this._loadWindow.setLoadText(info.loadText);
      this._loadWindow.setupEvents(function (win) {
        win.on("gotoSaveScene", function () {
          SceneManager.push(Scene_Load);
        });
      });
      this.addWindow(this._loadWindow);
    }
    processVNLoadWindowVisibility() {
      if (
        WindowExtensions.isOpenOrVisible(this._messageWindow) &&
        !WindowExtensions.isOpenOrVisible(this._loadWindow)
      ) {
        this._loadWindow.show();
        this._loadWindow.open();
      } else {
        this._loadWindow.close();
        this._loadWindow.hide();
      }
    }
  }

  load_MapPatch.__name__ = true;
  class load_VNLoadWindow extends Window_Base {
    constructor(x, y, width, height) {
      super(x, y, width, height);
      this._loadText = "";
      this.setBackgroundType(load_Main.Params.backgroundType);
    }
    setupEvents(fn) {
      fn(this);
    }
    update() {
      _Window_Base_update.call(this);
      this.refresh();
      this.processClick();
    }
    processClick() {
      if (WindowExtensions.isTouchedInsideFrame(this)) {
        this.emit("gotoLoadScene");
      }
    }
    refresh() {
      if (this.contents != null) {
        this.contents.clear();
        this.paintLoadText();
      }
    }
    paintLoadText() {
      this.drawText(this._loadText, 0, 0, this.contentsWidth(), "center");
    }
    setLoadText(text) {
      this._loadText = text;
    }
  }

  load_VNLoadWindow.__name__ = true;

  class utils_Fn {
    static proto(obj) {
      return obj.prototype;
    }
    static updateProto(obj, fn) {
      return fn(obj.prototype);
    }
    static updateEntity(obj, fn) {
      return fn(obj);
    }
  }

  utils_Fn.__name__ = true;
  String.__name__ = true;
  Array.__name__ = true;
  js_Boot.__toStr = {}.toString;
  load_Main.main();
})(
  typeof exports != "undefined"
    ? exports
    : typeof window != "undefined"
    ? window
    : typeof self != "undefined"
    ? self
    : this,
  {}
);
