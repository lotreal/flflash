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
    import im.luo.log.Logger;

    public class Context {
	private static var _instance:Context = null;
        public static function get instance():Context {
	    return Context.getInstance();
	}
	public static function getInstance():Context {
	    if (_instance == null) _instance = new Context(new SingletonEnforcer());
	    return _instance;
	}
        public var logger:Logger;
        public var sprite:Sprite;
        public var stage:Stage;

        public var world:World;
        public var camera:Camera;

        public var scenario:Scenario;
        public var director:Director;

	private var _asset_loader_context:LoaderContext;
        private var _asset_loader:AssetLoader;
	public function get asset_loader():AssetLoader { return _asset_loader; }

        public function Context(singleton_enforcer:SingletonEnforcer) {
            logger   = Logger.getLogger(this);
        }

        public static function init(root:Sprite):void {
            root.stage.scaleMode = StageScaleMode.NO_SCALE;
            var context:Context = Context.instance;
            with (context) {
                sprite = root;
                stage = root.stage;
                loadAssest();
            }
        }

        public function loadAssest():void {
	    // start loading assets
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
            scenario = Scenario.instance;
            director = Director.instance;
            director.action();
            debug(stage);
        }
        
        private function debug(node:DisplayObject):void {
            logger.debug("============= "+(String(node))+" =============");
            var c:DisplayObjectContainer = node as DisplayObjectContainer;
            if (c) {
                logger.debug("Number of children of "+(String(c))+": ");
                logger.debug(c.numChildren);
                if (c.numChildren > 0 ) {
                    logger.debug("List children of "+(String(c))+": ");
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
    }
}

// SingletonEnforcer
class SingletonEnforcer {}