package im.luo.staff {
    import br.com.stimuli.loading.BulkLoader;
    
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.system.LoaderContext;
    
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
            if (_loader == null) _loader = BulkLoader.createUniqueNamedLoader();
            return _loader;
        }

        public function set loader(value:BulkLoader):void {
            _loader = value;
        }

        /**
         * 从资源文件中通过 id 读出指定的 Class 
         * @param id 资源 id
         * @param content 资源文件 id, 参见 BulkLoader，默认为 "res"
         * @return Class
         * 
         */        
        public function getLoadedClass(id:String, content:String = "res"):Class
        {
            return loader.getContent(content).loaderInfo.applicationDomain.getDefinition(id) as Class;
        }
        
        public function init(root:DisplayObjectContainer):void {
            this.root = root;
            this.stage = root.stage;
            this.width = this.stage.stageWidth;
            this.height = this.stage.stageHeight;
        }
    }
}
// SingletonEnforcer
class SingletonEnforcer {}