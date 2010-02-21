package im.luo.staff {
    import flash.display.DisplayObjectContainer;
    import flash.display.Stage;
    import flash.display.Sprite;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    
    import br.com.stimuli.loading.BulkLoader;
    import com.hexagonstar.util.debug.Debug;

    import im.luo.logging.Logger;
    
    /**
     * 提供 flash 运行时的上下文环境信息，比如舞台，根，宽，高等。
     */
    public final class Context {
        private static var _instance:Context = null;

        public var cache:Object = new Object();
        public var root:DisplayObjectContainer;
        public var stage:Stage;

        private var _logger:Logger = Logger.getLogger(this);

        private var _loader:BulkLoader = null;
        private var _loaderContext:LoaderContext = null;

        private var _width:int = 640;
        private var _height:int = 480;

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

        public function get width():int {
            return _width;
        }

        public function set width(value:int):void {
            _width = value;
        }
        
        public function get height():int {
            return _height;
        }
        
        public function set height(value:int):void {
            _height = value;
        }
        
        public function get loader():BulkLoader {
            return _loader;
        }
        
        public function set loader(value:BulkLoader):void {
            _loader = value;
        }

        public function get loaderContext():LoaderContext {
            if (_loaderContext == null) _loaderContext =  new LoaderContext(
                true, ApplicationDomain.currentDomain, null);
            return _loaderContext;
        }

        public function set loaderContext(value:LoaderContext):void {
            _loaderContext = value;
        }

        public function init(root:DisplayObjectContainer):void {
            this.root = root;
            if(root != null && stage == null && root.stage != null) {
                initStage(root.stage);
            }
        }
        
        protected function initStage(stage:Stage):void {
            if(this.stage == null) {
                if (Settings.debug) Debug.monitor(stage, 1000);
                this.stage = stage;
                this.width = stage.stageWidth;
                this.height = stage.stageHeight;
            }
        }
    }
}
// SingletonEnforcer
class SingletonEnforcer {}