package
{
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    
    import im.luo.logging.Logger;
    import im.luo.util.TimerUtil;

    /*
    保护罩 Guard
    获得金钱 GetCoin
    进度条 LoadMc
    连击 Combo
    损血（受到伤害） Hurt
    消灭敌人 KillEnemy
    撞击_未造成伤害 Pass
    撞击_造成伤害 Hit
    血瓶 HP
    血条 HPbar
    硬币 Coin
    游戏结束窗口 GameOver_Window
    */
    public class Fx {
        private var logger:Logger = Logger.getLogger(this);
        
        public function Fx() {
            
        }
        // Fx.add('GetCoin', {'coin_num')
        public function add(position:*):void
        {
        }
        
        public function addGuard(ground:DisplayObjectContainer, showtime:int):void
        {
            var guard:MovieClip = Resource.any('Guard');
            ground.addChild(guard);
            TimerUtil.delay(showtime, function() { ground.removeChild(guard);});
        }
    }
}

