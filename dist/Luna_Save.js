//=============================================================================
// Luna_Save.js
//=============================================================================
//=============================================================================
// Build Date: 2020-09-25 20:37:08
//=============================================================================
//=============================================================================
// Made with LunaTea -- Haxe
//=============================================================================

// Generated by Haxe 4.1.3
/*:
@author LunaTechs - Kino
@plugindesc > A plugin that allows you to save your game VN style. <LunaVNSave>.

@target MV MZ

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
@desc The width of the load  window
@default 100

@param height
@text Height
@desc The height of the load window
@default 75

@param saveText
@text Save Text
@desc The save text shown in the save window
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





(function ($hx_exports, $global) { "use strict"
class EReg {
	constructor(r,opt) {
		this.r = new RegExp(r,opt.split("u").join(""))
	}
	match(s) {
		if(this.r.global) {
			this.r.lastIndex = 0
		}
		this.r.m = this.r.exec(s)
		this.r.s = s
		return this.r.m != null;
	}
}
class WindowExtensions {
	static isTouchedInsideFrame(win) {
		let x = win.canvasToLocalX(TouchInput.x)
		let y = win.canvasToLocalY(TouchInput.y)
		if(x >= 0 && y >= 0 && x < win.width) {
			return y < win.height;
		} else {
			return false;
		}
	}
	static isOpenOrVisible(win) {
		if(!win.isOpen()) {
			return win.visible;
		} else {
			return true;
		}
	}
}
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
class _$LTGlobals_$ {
}
class LunaVNSave {
	static main() {
		let _g = []
		let _g1 = 0
		let _g2 = $plugins
		while(_g1 < _g2.length) {
			let v = _g2[_g1]
			++_g1
			if(new EReg("<LunaVNSave>","ig").match(v.description)) {
				_g.push(v)
			}
		}
		let params = _g[0].parameters
		LunaVNSave.Params = { x : parseInt(params["x"],10), y : parseInt(params["y"],10), width : parseInt(params["width"],10), height : parseInt(params["height"],10), saveText : params["saveText"]}
		console.log("src/save/Main.hx:32:",LunaVNSave.Params)
		
//=============================================================================
// Scene_Map
//=============================================================================
      
		let _Scene_Map__saveWindow = Scene_Map.prototype._saveWindow
		Scene_Map.prototype._saveWindow = null
		let _Scene_Map_createAllWindows = Scene_Map.prototype.createAllWindows
		Scene_Map.prototype.createAllWindows = function() {
			_Scene_Map_createAllWindows.call(this)
			this.createVNSaveWindow()
		}
		let _Scene_Map_createVNSaveWindow = Scene_Map.prototype.createVNSaveWindow
		Scene_Map.prototype.createVNSaveWindow = function() {
			let info = LunaVNSave.Params
			this._saveWindow = new save_VNSaveWindow(info.x,info.y,info.width,info.height)
			this._saveWindow.setSaveText(info.saveText)
			this._saveWindow.setupEvents(function(win) {
				win.on("gotoSaveScene",function() {
					SceneManager.push(Scene_Save)
				})
			})
			this.addWindow(this._saveWindow)
		}
		let _Scene_Map_update = Scene_Map.prototype.update
		Scene_Map.prototype.update = function() {
			_Scene_Map_update.call(this)
			this.processVNSaveWindowVisibility()
		}
		let _Scene_Map_processVNSaveWindowVisibility = Scene_Map.prototype.processVNSaveWindowVisibility
		Scene_Map.prototype.processVNSaveWindowVisibility = function() {
			if(WindowExtensions.isOpenOrVisible(this._messageWindow) && !WindowExtensions.isOpenOrVisible(this._saveWindow)) {
				this._saveWindow.show()
				this._saveWindow.open()
			} else {
				this._saveWindow.close()
				this._saveWindow.hide()
			}
		}
	}
}
class save_MapPatch extends Scene_Map {
	constructor() {
		super();
	}
	createAllWindows() {
		_Scene_Map_createAllWindows.call(this)
		this.createVNSaveWindow()
	}
	createVNSaveWindow() {
		let info = LunaVNSave.Params
		this._saveWindow = new save_VNSaveWindow(info.x,info.y,info.width,info.height)
		this._saveWindow.setSaveText(info.saveText)
		this._saveWindow.setupEvents(function(win) {
			win.on("gotoSaveScene",function() {
				SceneManager.push(Scene_Save)
			})
		})
		this.addWindow(this._saveWindow)
	}
	processVNSaveWindowVisibility() {
		if(WindowExtensions.isOpenOrVisible(this._messageWindow) && !WindowExtensions.isOpenOrVisible(this._saveWindow)) {
			this._saveWindow.show()
			this._saveWindow.open()
		} else {
			this._saveWindow.close()
			this._saveWindow.hide()
		}
	}
}
class save_VNSaveWindow extends Window_Base {
	constructor(x,y,width,height) {
		super(new Rectangle(x,y,width,height));
		this._saveText = ""
	}
	setupEvents(fn) {
		fn(this)
	}
	update() {
		_Window_Base_update.call(this)
		this.refresh()
		this.processClick()
	}
	processClick() {
		if(WindowExtensions.isTouchedInsideFrame(this)) {
			this.emit("gotoSaveScene")
		}
	}
	refresh() {
		if(this.contents != null) {
			this.contents.clear()
			this.paintSaveText()
		}
	}
	paintSaveText() {
		this.drawText(this._saveText,0,0,this.contentsWidth(),"center")
	}
	setSaveText(text) {
		this._saveText = text
	}
}
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
LunaVNSave.main()
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, {})
