package flf.flatland.game {
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
    import im.luo.staff.ContextAbstract;

    public class Context extends ContextAbstract {
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
        private static var _instance:Context = null;
        public function Context(singleton_enforcer:SingletonEnforcer) {}

        override protected function postInitStage():void {
            loadAssest();
            logger.debug("tc");
        }

        protected function loadAssest():void {
            _asset_loader_context = new LoaderContext(true, ApplicationDomain.currentDomain, null);
            _asset_loader = new AssetLoader("flf-res.swf", _asset_loader_context);
            _asset_loader.addEventListener(Event.COMPLETE, onAssestLoadComplete);
            _asset_loader.load();
        }
        
        protected function onAssestLoadComplete(e:Event):void 
        {
            logger.debug('资源加载完成');
            director = Director.instance;
            debug(root);
        }
    }
}


// SingletonEnforcer
class SingletonEnforcer {}