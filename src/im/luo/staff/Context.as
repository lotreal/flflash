package im.luo.staff {
    import br.com.stimuli.loading.BulkLoader;
    
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.display.StageScaleMode;
    
    import im.luo.logging.Logger;

    public class Context {
        public var cache:Object = new Object();
        public var root:DisplayObjectContainer;
        public var stage:Stage;
        public var width:int = 640;
        public var height:int = 480;
        
        private var _logger:Logger = Logger.getLogger(this);
        private var _loader:BulkLoader = null;
        
        private static var _instance:Context = null;
        
        public function Context(singleton_enforcer:SingletonEnforcer) {
            cache['ui'] = new Sprite();
            cache['static'] = new Sprite();
        }

        public static function get instance():Context {
            return Context.getInstance();
        }
        
        public static function getInstance():Context {
            if (_instance == null) _instance = new Context(new SingletonEnforcer());
            return _instance;
        }
        
        public static function Init(root:DisplayObjectContainer):void {
            Context.instance.init(root);
        }

        public function get loader():BulkLoader {
            if (_loader == null) _loader = BulkLoader.createUniqueNamedLoader();
            return _loader;
        }
        
        public function set loader(value:BulkLoader):void {
            _loader = value;
        }

        public function init(root:DisplayObjectContainer):void {
            this.root = root;
            this.stage = root.stage;
            this.width = this.stage.stageWidth;
            this.height = this.stage.stageHeight;

            this.stage.scaleMode = StageScaleMode.NO_SCALE;
        }
    }
}
// SingletonEnforcer
class SingletonEnforcer {}