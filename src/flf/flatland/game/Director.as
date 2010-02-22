package flf.flatland.game
{
    import br.com.stimuli.loading.BulkLoader;
    
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    
    import flf.flatland.shooting.PlaySceneSS;
    import im.luo.logging.Logger;
    import im.luo.shooting.IShootingSchedule;
    import im.luo.staff.Context;
    import im.luo.util.MathUtil;

    /**
     * 全局调度场景切换，拍摄。
     */
    public final class Director {
        private static var _instance:Director = null;
        public var context:Context = Context.instance;

        private var _logger:Logger = Logger.getLogger(this);

        public static function get instance():Director {
            if (_instance == null) _instance = new Director(new SingletonEnforcer());
            return _instance;
        }

        public function Director(singleton_enforcer:SingletonEnforcer):void {}

        public function play():void {
            loadAssest();
        }

        /**
         * 载入所有资源文件
         */
        protected function loadAssest():void {
            context.loader.add(Settings.domain + "/flf/resource/FL_Show.swf", {"id":"res"});
            context.loader.add(Settings.domain + "/flf/resource/map/map0" + MathUtil.randomIn(1,5) + ".png", {"id":"bg"});
            
            context.loader.addEventListener(BulkLoader.COMPLETE, onAssestLoadComplete);
            //context.loader.addEventListener(BulkLoader.PROGRESS, onAllProgress);
            //context.loader.addEventListener(BulkLoader.ERROR, onAllError);
            context.loader.start();
        }
        
        protected function onAssestLoadComplete(e:Event):void 
        {
            _logger.debug('资源加载完成');
            var ss:IShootingSchedule = new PlaySceneSS();
            ss.init();
            ss.action();
        }
    }
}

// SingletonEnforcer
class SingletonEnforcer {}