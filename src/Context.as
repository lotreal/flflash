package {
    import flash.display.*;

    import flash.events.*;
    import flash.display.MovieClip;
    import flash.display.StageScaleMode;
    import flash.events.*;
    import com.actionsnippet.qbox.*;
    import Box2D.Dynamics.*;

    import at.geoathome.utils.loader.AssetLoader;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flf.*;
    import im.luo.utils.*;
    import im.luo.logging.Logger;

    import ghostcat.debug.EnabledSWFScreen;

    public class Context {
        public var width:int = 640;
        public var height:int = 480;

        public var logger:Logger;
        public var root:DisplayObjectContainer;
        public var stage:Stage;

        public var world:World;
        public var camera:Camera;

        public var scenario:Scenario;
        public var director:Director;

	public function get asset_loader():AssetLoader { return _asset_loader; }

        public function Context(singleton_enforcer:SingletonEnforcer) {
            logger   = Logger.getLogger(this);
        }

        public static function Init(root:DisplayObjectContainer):void {
            Context.instance.init(root);
        }
        public function init(root:DisplayObjectContainer):void {
            this.root = root;
            if(root != null && stage == null && root.stage != null){
        	initStage(root.stage);
            }
        }
        private function initStage(stage:Stage):void {
            if(this.stage == null) {
                stage.scaleMode = StageScaleMode.NO_SCALE;
                this.stage = stage;
                this.width = stage.stageWidth;
                this.height = stage.stageHeight;

		//new EnabledSWFScreen(stage);
                //,function ():void{refreshInterval = 2},function ():void{refreshInterval = 0})
                this.loadAssest();
            }
        }

        public function loadAssest():void {
	    _asset_loader_context = new LoaderContext(true, ApplicationDomain.currentDomain, null);
	    _asset_loader = new AssetLoader("main.swf", _asset_loader_context);
	    _asset_loader.addEventListener(Event.COMPLETE, onAssestLoadComplete);
	    _asset_loader.load();
        }

	private function onAssestLoadComplete(e:Event):void 
	{
            logger.debug('资源加载完成');
            camera   = Camera.instance;
            world    = World.instance;

            director = Director.instance;
            scenario = Scenario.instance;
            director.action();

            debug(stage);
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
        public static function get instance():Context {
	    return Context.getInstance();
	}
	public static function getInstance():Context {
	    if (_instance == null) _instance = new Context(new SingletonEnforcer());
	    return _instance;
	}
	private var _asset_loader_context:LoaderContext;
        private var _asset_loader:AssetLoader;

    }
}

// SingletonEnforcer
class SingletonEnforcer {}