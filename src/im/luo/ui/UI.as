package im.luo.ui
{
    import im.luo.logging.Logger;
    import im.luo.geom.Vector2D;

    import flash.display.Sprite;
    import flash.text.TextFormat;
    import flash.text.TextField;
    import flash.text.TextFormatAlign;
    import flash.text.TextFieldAutoSize;
    import im.luo.staff.Context;
    import im.luo.staff.Screen;
    
    public class UI {
        public static var screen:Sprite;
        public static var fixScreen:Sprite;

        public static function get instance():UI {
            return UI.getInstance();
        }
        public static function getInstance():UI {
            if (_instance == null) _instance = new UI(new SingletonEnforcer());
            return _instance;
        }

        public function UI(singleton_enforcer:SingletonEnforcer) {
            var context:Context = Context.instance;
            _tbTip = createTextField(0, context.height - 18, context.width, 32,
                12, 0x089640);

            _tbTip.text = "";

            screen = context.screen.getLayer(Screen.SCENE_UI) as Sprite;
            fixScreen = context.screen.addChild(context.screen.getLayer(Screen.SCREEN_UI), true) as Sprite;
            fixScreen.addChild(_tbTip);
            //context.root.addChild(_tbTip);
        }

        public static function createTextField(x:int, y:int, width:int, height:int, size:int, color:uint):TextField {
            var fi:TextField = new TextField();
            fi.selectable = true;
            fi.height = height;
            fi.multiline = true;
            fi.wordWrap = true;
            //fi.autoSize = TextFieldAutoSize.LEFT;

            var fm:TextFormat = new TextFormat;
            //fm.font = "Verdana"; 
            fm.bold = false; 
            fm.size = size;
            fm.color = color;
            fm.align = TextFormatAlign.LEFT;


            fi.defaultTextFormat = fm; fi.x = x; fi.y = y; fi.width = width; fi.selectable = false;
            return fi;
        }

        public function tips(msg:String):void {
            _tbTip.text = msg;
        }

        public function showMe(x:int, y:int, msg:String):void {
            var txt:TextField = createTextField(x, y, 100, 100, 10, 0x000000);
            txt.text = msg;
            screen.addChild(txt);
        }

        public static function textPanel(position:Vector2D, width:int, height:int, size:int, color:uint):ITextPanel {
            var tp:ITextPanel = new TextPanel(position, width, height, size, color);
            tp.render(screen);
            return tp;
        }

        public static function fixTextPanel(position:Vector2D, width:int, height:int, size:int, color:uint):ITextPanel {
            var tp:ITextPanel = new TextPanel(position, width, height, size, color);
            tp.render(fixScreen);
            return tp;
        }
        
        private static var _instance:UI = null;

        private var _logger:Logger = Logger.getLogger(this);
        private var _tbTip:TextField;
    }
}

// SingletonEnforcer
class SingletonEnforcer {}
