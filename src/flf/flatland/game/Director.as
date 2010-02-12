package flf.flatland.game
{
    import br.com.stimuli.loading.BulkLoader;
    
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    
    import flf.flatland.shooting.PlaySceneSS;
    import flf.flatland.ui.PlaySceneUI;
    
    import im.luo.logging.Logger;
    import im.luo.shooting.IShootingSchedule;
    import im.luo.staff.DirectorAbstract;
    import im.luo.util.Keyboard;
    import im.luo.util.MathUtil;

    //import com.facebook.Facebook;
    //import com.facebook.events.FacebookEvent;
    //import com.facebook.net.FacebookCall;
    //import com.facebook.data.users.FacebookUser;
    //import com.facebook.data.users.GetInfoData;
    //import com.facebook.commands.users.GetInfo;
    //import com.facebook.utils.FacebookSessionUtil;

    public class Director extends DirectorAbstract {
        public var keyboard:Keyboard = Keyboard.instance;

        //private var fbook:Facebook;
        //private var session:FacebookSessionUtil;
        
        //private var API_KEY:String = "9c3b07f55e5e9ee759aa8dc87ac6c64d";
        //private var SECRET_KEY:String = "7e5237b6d88b72363e546fdf37676e67";

        public function Director(singleton_enforcer:SingletonEnforcer):void {}

        public static function get instance():Director {
            return Director.getInstance();
        }
        public static function getInstance():Director {
            if (_instance == null) _instance = new Director(new SingletonEnforcer());
            return _instance;
        }

        public function play():void {
            loadAssest();
        }
        
        protected function loadAssest():void {
            //context.loader = new BulkLoader(Settings.domain + "/swf/flf-res1.swf", context.loaderContext);
            if (context.loader == null) {
                context.loader = new BulkLoader('main-site');
                context.loader.add(Settings.domain + "/flf/resource/FL_Show.swf", {"id":"res"});
                context.loader.add(Settings.domain + "/flf/resource/map/map0" + MathUtil.randomIn(1,5) + ".png", {"id":"bg"});
                
                context.loader.addEventListener(BulkLoader.COMPLETE, onAssestLoadComplete);
                //context.loader.addEventListener(BulkLoader.PROGRESS, onAllProgress);
                //context.loader.addEventListener(BulkLoader.ERROR, onAllError);
                context.loader.start();
                //context.loader.addEventListener(Event.COMPLETE, onAssestLoadComplete);
                //context.loader.load();
            }
        }
        
        protected function onAssestLoadComplete(e:Event):void 
        {
            _logger.debug('资源加载完成');

           //session=new FacebookSessionUtil(
           //    API_KEY,
           //    SECRET_KEY,
           //    context.root.loaderInfo);
           //session.addEventListener(FacebookEvent.CONNECT, onConnect);
           //fbook=session.facebook;
            PlaySceneUI.instance.build();
            var ss:IShootingSchedule = new PlaySceneSS();
            ss.init();
            ss.action();
            //debug(context.root);
        }

        //private function onConnect(e:FacebookEvent):void {
        //    _logger.debug("facebook api ready", e);
        //    session.login();
        //}
        
        protected function debug(node:DisplayObject):void {
            _logger.debug("============= "+(String(node))+" =============");
            var c:DisplayObjectContainer = node as DisplayObjectContainer;
            if (c) {
                if (c.numChildren > 0 ) {
                    _logger.debug("Number of children of "+(String(c))+": " + c.numChildren);
                    for (var i:uint=0;i<c.numChildren;i++) {
                        _logger.debug(c.getChildAt(i));
                    }
                    for (var j:uint=0;j<c.numChildren;j++) {
                        debug(c.getChildAt(j));
                    }
                }
            } else {
                _logger.debug("DisplayObject(not container): "+(String(node)));
            }
        }
        private static var _instance:Director = null;
        private var _logger:Logger = Logger.getLogger(this);

    }
}

// SingletonEnforcer
class SingletonEnforcer {}
