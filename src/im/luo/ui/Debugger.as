package im.luo.ui
{
    import flash.text.*;
    import flash.display.Stage;
    import flash.utils.*;
    import flf.flatland.game.Context;
    
    public class Debugger {
	private static var _instance:Debugger = null;
        public static function get instance():Debugger {
	    if (_instance == null) _instance = new Debugger();
	    return _instance;
	}

        private var messageField:TextField;
        private var line:Number = 0;

        public function Debugger():void {
            var stage:Stage = Context.instance.stage;

            //var fm:TextFormat = new TextFormat;
            //fm.font = "_typewriter"; 
            //fm.bold = false;
            //fm.size = 12;
            //fm.color = 0; 
            //fm.align = TextFormatAlign.RIGHT;

            //fi.selectable = true;
            //fi.height = 52;
            //fi.multiline = true;
            //fi.wordWrap = true;
            //fi.defaultTextFormat = fm; 
            //fi.x = x; 
            //fi.y = y; 
            //fi.width = width; 
            //fi.selectable = false;

            messageField = createTextField(0, 0, stage.stageWidth, stage.stageHeight,
                12, 0);

            messageField.y = 0;
            messageField.text = String("");
            stage.addChild(messageField);
        }

        public function createTextField(x:int, y:int, width:int, height:int, size:int, color:int):TextField {
            var fm:TextFormat = new TextFormat, fi:TextField = new TextField();
            fm.font = "_typewriter"; 
            fm.bold = false; 
            fm.size = 12; 
            fm.color = 0x006400;
            fm.align = TextFormatAlign.LEFT;

            fi.selectable = true;
            fi.height = height;
            fi.multiline = true;
            fi.wordWrap = true;

            fi.defaultTextFormat = fm; fi.x = x; fi.y = y; fi.width = width; fi.selectable = false;
            return fi;
        }

        public function print(msg:String):void {
            line++;
            messageField.appendText('\n'+line+'.'+msg);
            messageField.scrollV = messageField.maxScrollV;
        }
    }
}
