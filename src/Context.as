package {
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
    import im.luo.game.Camera;
    
    public class Context {
        public static function get instance():Context {
            return Context.getInstance();
        }
        public static function getInstance():Context {
            if (_instance == null) _instance = new Context(new SingletonEnforcer());
            return _instance;
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
        
        
        public var logger:Logger = Logger.getLogger(this);
        public var root:DisplayObjectContainer;
        public var stage:Stage;
        
        public var camera:Camera;
        
        public var director:Director;
        
        public function get loader():AssetLoader { return _asset_loader; }
        
        public function Context(singleton_enforcer:SingletonEnforcer) {}
        
        public static function Init(root:DisplayObjectContainer):void {
            Context.instance.init(root);
        }
        public function init(root:DisplayObjectContainer):void {
            this.root = root;
            if(root != null && stage == null && root.stage != null) {
                initStage(root.stage);
            }
        }
        private function initStage(stage:Stage):void {
            if(this.stage == null) {
                stage.scaleMode = StageScaleMode.NO_SCALE;
                this.stage = stage;
                this.width = stage.stageWidth;
                this.height = stage.stageHeight;
                
                this.loadAssest();
                logger.debug("tc");
            }
        }
        
        public function loadAssest():void {
            _asset_loader_context = new LoaderContext(true, ApplicationDomain.currentDomain, null);
            _asset_loader = new AssetLoader("flf-res.swf", _asset_loader_context);
            _asset_loader.addEventListener(Event.COMPLETE, onAssestLoadComplete);
            _asset_loader.load();
        }
        
        private function onAssestLoadComplete(e:Event):void 
        {
            logger.debug('资源加载完成');
            director = Director.instance;
            //scenario = Scenario.instance;
            //director.action();
            debug(root);
        }
        
        private function debug(node:DisplayObject):void {
            logger.debug("============= "+(String(node))+" =============");
            var c:DisplayObjectContainer = node as DisplayObjectContainer;
            if (c) {
                if (c.numChildren > 0 ) {
                    logger.debug("Number of children of "+(String(c))+": " + c.numChildren);
                    for (var i:uint=0;i<c.numChildren;i++) {
                        logger.debug(c.getChildAt(i));
                    }
                    for (var j:uint=0;j<c.numChildren;j++) {
                        debug(c.getChildAt(j));
                    }
                }
            } else {
                logger.debug("DisplayObject(not container): "+(String(node)));
            }
        }
        
        private static var _instance:Context = null;
        private var _asset_loader_context:LoaderContext;
        private var _asset_loader:AssetLoader;
        private var _width:int = 640;
        private var _height:int = 480;
    }
}

// SingletonEnforcer
class SingletonEnforcer {}