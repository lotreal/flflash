package im.luo.staff
{
    import im.luo.logging.Logger;
    import im.luo.shooting.IShootingSchedule;
    
    /**
     * 全局调度场景切换，拍摄。
     */
    public final class Director {
        public var context:Context = Context.instance;
        private var _logger:Logger = Logger.getLogger(this);
        
        
        public function Director():void {}
        
        public function play(shootingSchedule:IShootingSchedule):void {
            context.screen.clear();
            shootingSchedule.init();
            shootingSchedule.action();
        }
        
        /**
         * 重拍拍摄计划 
         * 
         */        
        public function remake(ss:IShootingSchedule = null):void
        {
            context.screen.clear();
            if (ss == null) ss = this.shootingSchedule;
            ss.cut();
            ss.destroy();
            ss.init();
            ss.action();
        }
        
        private var shootingSchedule:IShootingSchedule;
    }
}

// SingletonEnforcer
class SingletonEnforcer {}