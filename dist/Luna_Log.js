//=============================================================================
// Luna_Log.js
//=============================================================================
//=============================================================================
// Build Date: 2020-09-24 21:26:17
//=============================================================================
//=============================================================================
// Made with LunaTea -- Haxe
//=============================================================================

// Generated by Haxe 4.1.3
/*:
@author LunaTechs - Kino
@plugindesc > A collection of plugins that allow you to create Visual novels in RPGMakerMV/MZ <LunaVnTools>

@target MV MZ

@command callEvent
@text Call Event
@desc Allows you to call an event from any map with any event ID


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





(function ($hx_exports, $global) { "use strict"
var $estr = function() { return js_Boot.__string_rec(this,''); },$hxEnums = $hxEnums || {};
Math.__name__ = true
class haxe_iterators_ArrayIterator {
	constructor(array) {
		this.current = 0
		this.array = array
	}
	hasNext() {
		return this.current < this.array.length;
	}
	next() {
		return this.array[this.current++];
	}
}
haxe_iterators_ArrayIterator.__name__ = true
class js_Boot {
	static __string_rec(o,s) {
		if(o == null) {
			return "null";
		}
		if(s.length >= 5) {
			return "<...>";
		}
		let t = typeof(o)
		if(t == "function" && (o.__name__ || o.__ename__)) {
			t = "object"
		}
		switch(t) {
		case "function":
			return "<function>";
		case "object":
			if(o.__enum__) {
				let e = $hxEnums[o.__enum__]
				let n = e.__constructs__[o._hx_index]
				let con = e[n]
				if(con.__params__) {
					s = s + "\t"
					return n + "(" + ((function($this) {
						var $r
						let _g = []
						{
							let _g1 = 0
							let _g2 = con.__params__
							while(true) {
								if(!(_g1 < _g2.length)) {
									break
								}
								let p = _g2[_g1]
								_g1 = _g1 + 1
								_g.push(js_Boot.__string_rec(o[p],s))
							}
						}
						$r = _g
						return $r;
					}(this))).join(",") + ")"
				} else {
					return n;
				}
			}
			if(((o) instanceof Array)) {
				let str = "["
				s += "\t";
				let _g = 0
				let _g1 = o.length
				while(_g < _g1) {
					let i = _g++
					str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i],s);
				}
				str += "]";
				return str;
			}
			let tostr
			try {
				tostr = o.toString
			} catch( _g ) {
				return "???";
			}
			if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
				let s2 = o.toString()
				if(s2 != "[object Object]") {
					return s2;
				}
			}
			let str = "{\n"
			s += "\t";
			let hasp = o.hasOwnProperty != null
			let k = null
			for( k in o ) {
			if(hasp && !o.hasOwnProperty(k)) {
				continue
			}
			if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
				continue
			}
			if(str.length != 2) {
				str += ", \n";
			}
			str += s + k + " : " + js_Boot.__string_rec(o[k],s);
			}
			s = s.substring(1)
			str += "\n" + s + "}";
			return str;
		case "string":
			return o;
		default:
			return String(o);
		}
	}
}
js_Boot.__name__ = true
class LunaLog {
	static main() {
		
//=============================================================================
// Scene_Map
//=============================================================================
      
		let _Scene_Map_start = Scene_Map.prototype.start
		Scene_Map.prototype.start = function() {
			_Scene_Map_start.call(this)
			this.setupEvents()
		}
		let _Scene_Map_update = Scene_Map.prototype.update
		Scene_Map.prototype.update = function() {
			_Scene_Map.update.call(this)
		}
		let _Scene_Map_processLogScene = Scene_Map.prototype.processLogScene
		Scene_Map.prototype.processLogScene = function() {
		}
		let _Scene_Map_setupEvents = Scene_Map.prototype.setupEvents
		Scene_Map.prototype.setupEvents = function() {
			let _gthis = this
			this.on("gotoLogScene",function() {
				_gthis.pushLogScene()
			})
		}
		let _Scene_Map_pushLogScene = Scene_Map.prototype.pushLogScene
		Scene_Map.prototype.pushLogScene = function() {
			SceneManager.push(log_VNLogScene)
		}
	}
}
$hx_exports["LunaLog"] = LunaLog
LunaLog.__name__ = true
class log_MapPatch extends Scene_Map {
	constructor() {
		super();
	}
	setupEvents() {
		let _gthis = this
		this.on("gotoLogScene",function() {
			_gthis.pushLogScene()
		})
	}
	pushLogScene() {
		SceneManager.push(log_VNLogScene)
	}
}
log_MapPatch.__name__ = true
class log_VNLogScene extends Scene_MenuBase {
}
log_VNLogScene.__name__ = true
class log_VNLogWindow extends Window_Selectable {
	constructor(x,y,width,height) {
		super(new Rectangle(x,y,width,height));
	}
	update() {
		super.update()
	}
}
log_VNLogWindow.__name__ = true
class utils_Fn {
	static proto(obj) {
		return obj.prototype;
	}
	static updateProto(obj,fn) {
		return (fn)(obj.prototype);
	}
	static updateEntity(obj,fn) {
		return (fn)(obj);
	}
}
utils_Fn.__name__ = true
String.__name__ = true
Array.__name__ = true
js_Boot.__toStr = ({ }).toString
LunaLog.main()
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, {})
