package flf.flatland.role
{
    import flf.flatland.game.Groups;
    import flf.flatland.game.Roles;
    
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import im.luo.scene.IScene;
    import im.luo.scene.ISceneLayer;
    import im.luo.util.MathUtil;
    import im.luo.util.ProbUtil;
    import im.luo.util.TimerUtil;
    
    public class Npc extends Citizen {
        private var _logger:Logger = Logger.getLogger(this);
        
        public function Npc(name:String) {
            var level:int = MathUtil.randomIn(3, 6);
            super(name, level);
            type = Roles.CITIZEN;
            color = 0xffffff;
            groupid = Groups.NPC;
        }
        
        override public function die():void
        {
            var p:Vector2D = this.position.clone(); //new Vector2D(position.x + 30, position.y + 30);
            var scene:IScene = this.scene;
            var layer:ISceneLayer = this.sceneLayer;
            var money:int = this.gold;
            
            super.die();
            
            if (money > 0)
            {
                TimerUtil.delay(100, function handler():void
                {
                    var gold:Gold = new Gold(money);
                    //new InjuryProtect().apply(gold);
                    Roles.layoutRole(scene, layer, gold, p);
                });
            }

            if (ProbUtil.hit(0.20)) {
                // 不能在事件中创建对象 @TODO 更好地解决方案
                TimerUtil.delay(200, function handler():void
                {
                    var heart:Heart = new Heart();
                    Roles.layoutRole(scene, layer, heart, p);
                });
            }
        }
    }
}
