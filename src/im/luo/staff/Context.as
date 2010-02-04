package im.luo.staff {
    import com.hexagonstar.util.debug.Debug;
    import flash.display.*;
    
    import flash.events.*;
    import flash.display.MovieClip;
    import flash.display.StageScaleMode;
    import flash.events.*;
    import Box2D.Dynamics.*;
    
    import at.geoathome.utils.loader.AssetLoader;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;

    import flf.*;
    import im.luo.util.*;
    import im.luo.logging.Logger;

    public class Context {
        public var cache:Object = new Object();
        public var root:DisplayObjectContainer;
        public var stage:Stage;

        protected var _width:int = 640;
        protected var _height:int = 480;

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
        
        public function get loader():AssetLoader {
            return _loader;
        }
        public function set loader(value:AssetLoader):void {
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
                Debug.monitor(stage, 1000);
                stage.scaleMode = StageScaleMode.NO_SCALE;
                this.stage = stage;
                this.width = stage.stageWidth;
                this.height = stage.stageHeight;
            }
        }
        
        private static var _instance:Context = null;

        private var _logger:Logger = Logger.getLogger(this);
        private var _loader:AssetLoader = null;
        private var _loaderContext:LoaderContext = null;
    }
}


// SingletonEnforcer
class SingletonEnforcer {}