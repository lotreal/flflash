package im.luo.util{
    import flash.display.*;
    import flash.text.*;
    public class DevUtils extends Sprite{
        public var messageField:TextField = new TextField;
        public function DevUtils(stage:Stage):void {
        }

        public function createTextField(x:int, y:int, width:int, size:int, color:int):TextField {
            var fm:TextFormat = new TextFormat, fi:TextField = new TextField;
            fm.font = "_typewriter"; fm.bold = false; fm.size = size; fm.color = color; fm.align = TextFormatAlign.RIGHT;
            fi.selectable = true;
            fi.defaultTextFormat = fm; fi.x = x; fi.y = y; fi.width = width; fi.selectable = false;
            return fi;
        }
        public function print(... args):void {
            return void;
            var str:String = "";
            for (var i:int=0; i<args.length; i++) str += String(args[i]) + "; ";
            trace(str);
            messageField.text = str;
        }
    }
}