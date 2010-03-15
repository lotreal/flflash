package flf.flatland.fight
{
    import flash.utils.getTimer;
    
    import flf.flatland.game.Groups;
    import flf.flatland.game.States;
    import flf.flatland.role.Citizen;
    
    import im.luo.logging.Logger;
    import im.luo.vw.Manifold;
    
    public class Fight
    {
        // 战斗结果之击中对方
        public static var HIT:int = 0;
        // 战斗结果之未击中对方
        public static var MISS:int = 1;
        // 战斗结果之对方处于无敌状态，攻击无效
        public static var INVINCIBLE:int = 2;
        
        public function Fight()
        {
        }

        /**
        * 攻击判定流程
        *  ) 如果任一方为伤害保护状态，则进攻无效，并播放伤害动画（及音效）
        *  ) 根据攻击点决定进攻方和防守方
        *  ) 如果是平局，则（暂定为）进攻无效，并显示平局效果
        * 3) 根据进攻方的命中率和防守方的回避率计算是否命中，
        *    如未命中，则进攻无效，并播放回避动画（及音效）
        *    如命中，则进攻有效，继续下一步
        * 4) 根据进攻方的攻击力和防守方的防御计算伤害数值
        * @parm offensive Citizen 进攻方
        * @parm defensive Citizen 防守方
        * @parm manifold Manifold 战场环境信息
        * @return int 返回定义在 Fight 类中的战斗结果常量，分别为击中，未击中，无敌。
        */
        public function attackRolls(mf:Manifold):void 
        {
            var role1:Citizen = mf.role1 as Citizen;
            var role2:Citizen = mf.role2 as Citizen;

            _logger.debug(role1.state, role2.state);
            if (role1.state.has(States.PROTECTED) || role2.state.has(States.PROTECTED))
            {
//                role1.face.showProtected();
//                role2.face.showProtected();
                _logger.debug("in protected");
                return;
            }
            else if (role1.state.has(States.DIED) || role2.state.has(States.DIED))
            {
                return;
            }
            var of:Citizen = role1; // 进攻方
            var df:Citizen = role2; // 防守方

            var d1:Number = of.radius - of.position.dist(mf.attackPoint);
            var d2:Number = df.radius - df.position.dist(mf.attackPoint);

            if (d1 == d2) {
//                role1.face.showDraw();
//                role2.face.showDraw();
                _logger.debug("draw");
                return;
            } else if (d1 > d2) {
                of = role2;
                df = role1;
            }

            // 计算伤害值(转移到 role 计算)
            of.hit(df);
            _logger.debug(of.name,"hit",df.name);
        }

        private var _logger:Logger = Logger.getLogger(this);
    }
}