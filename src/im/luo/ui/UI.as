package im.luo.ui
{
    import flash.display.DisplayObjectContainer;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import im.luo.staff.Context;
    import im.luo.staff.Screen;
    
    /**
     * UI - 用户界面 目前分三级： 全局， 场景相关，角色相关 
     */    
    public class UI {
        public function UI() {
            //_tbTip = createTextField(0, context.height - 18, context.width, 32, 12, 0x089640);
            this.scene_ui = context.screen.getLayer(Screen.SCENE_UI);
            this.screen_ui = context.screen.getUIScreen();
        }
        
        public function build():void {}

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
        }

        public function showMe(x:int, y:int, msg:String):void {
            var txt:TextField = createTextField(x, y, 100, 100, 10, 0x000000);
            txt.text = msg;
            //screen.addChild(txt);
        }

        public function textPanel(position:Vector2D, width:int, height:int, size:int, color:uint):ITextPanel {
            var tp:ITextPanel = new TextPanel(position, width, height, size, color);
            tp.render(this.scene_ui);
            return tp;
        }

        public function fixTextPanel(position:Vector2D, width:int, height:int, size:int, color:uint):ITextPanel {
            var tp:ITextPanel = new TextPanel(position, width, height, size, color);
            tp.render(this.screen_ui);
            return tp;
        }
        
        public function register(name:String, ui:ITextPanel):void
        {
            ui_elements[name] = ui;
        }
        
        public function setValue(name:String, value:*):void
        {
            (ui_elements[name] as ITextPanel).content = String(value);
        }
        
        public var context:Context = Context.instance;
        public var scene_ui:DisplayObjectContainer;
        public var screen_ui:DisplayObjectContainer;
        
        public var ui_elements:Object = new Object();
        private var _logger:Logger = Logger.getLogger(this);
    }
}