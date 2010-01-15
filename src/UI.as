package
{
    import im.luo.logging.Logger;

    import flash.display.Stage;
    import flash.text.TextFormat;
    import flash.text.TextField;
    import flash.text.TextFormatAlign;
    
    public class UI {
        private static var _instance:UI = null;
        public static function get instance():UI {
            return UI.getInstance();
        }
        public static function getInstance():UI {
            if (_instance == null) _instance = new UI(new SingletonEnforcer());
            return _instance;
        }

        public function UI(singleton_enforcer:SingletonEnforcer) {
            var stage:Stage = Context.instance.stage;
            messageField = createTextField(0, 0, stage.stageWidth, 32,
                16, 0xffffff);

            messageField.y = 0;
            messageField.text = "";
            stage.addChild(messageField);
        }

        public function createTextField(x:int, y:int, width:int, height:int, size:int, color:uint):TextField {
            var fm:TextFormat = new TextFormat, fi:TextField = new TextField();
            //fm.font = ""; 
            fm.bold = false; 
            fm.size = size;
            fm.color = color;
            fm.align = TextFormatAlign.LEFT;

            fi.selectable = true;
            fi.height = height;
            fi.multiline = true;
            fi.wordWrap = true;

            fi.defaultTextFormat = fm; fi.x = x; fi.y = y; fi.width = width; fi.selectable = false;
            return fi;
        }

        public function tips(msg:String):void {
            messageField.text = msg;
        }

        private var logger:Logger = Logger.getLogger(this);
        private var messageField:TextField;
    }
}

// SingletonEnforcer
class SingletonEnforcer {}
