package flf.flatland.role
{
    import flf.flatland.actor.CitizenActor;
    import flf.flatland.face.CitizenFace;
    import flf.flatland.game.Roles;
    import flf.flatland.game.States;
    import flf.flatland.item.InjuryProtect;
    
    import im.luo.geom.Vector2D;
    import im.luo.item.ICanUseItem;
    import im.luo.item.IItem;
    import im.luo.logging.Logger;
    import im.luo.motion.IAdvancedMotion;
    import im.luo.motion.IBasicMotion;
    import im.luo.role.Role;
    import im.luo.util.TimerUtil;
    
    /**
    * 平面国公民角色。Player 和 Npc 皆继承此类。
    */
    public class Citizen extends Role implements ICanUseItem, IBasicMotion, IAdvancedMotion {
        public static var INIT_LEVEL:int = 5;
        public static var MAX_LEVEL:int = 9;

        public static const FORWARD:int = 1;
        public static const BACKWARD:int = 2;

        public var _level:int = INIT_LEVEL;
        public var score:int = 0;
        public var gold:int = 0;
        public var combo:int = 0;

        // ********* 战斗相关属性 *********
        // 初始血量
        public var init_hp:int = 0;
        // 血量
        public var _hp:int = 0;
        public function get hp():int
        {
            return _hp;
        }
        public function set hp(value:int):void
        {
            _hp = value;
        }
        
        public function heal(num:int):void
        {
            hp += num;
            face.express(CitizenFace.HEAL);
        }
        
        // 攻击力
        public var attack:int = 0;
        // 正常行动速度
        //public var speed:int = 30; // px/sec
        public var wanderSpeed:Number = 40;
        // 角度
        public var angular:int = 0;
        // 负重
        public var weight:int = 0;
        // 经验值
        public var exp:int = 0;


        // 得到最大速度数值
        public function get speed():Number { return 24; }
        public function set speed(value:Number):void{}

        // ********* 角色造型相关属性 *********
        // 颜色
        public var color:uint = 0x990000;
        // 边长
        public var side:Number = 56;
        // 前进速度
        public var forwardSpeed:Number = 24;
        // 后退速度
        public var backwardSpeed:Number = -9;
        // 是否处于无敌状态
        public var invincible:Boolean = false;

        private var _logger:Logger = Logger.getLogger(this);
        
        public function Citizen(name:String, level:int) {
            super(name);
            this.groups.add(Roles.CITIZEN);

            this._level = level;
            switch (level) {
                case 3:
                    initProp(5, 13, 10, 30, 100);
                    break;
                case 4:
                    initProp(4, 18, 9, 40, 150);
                    break;
                case 5:
                    initProp(3, 24, 8, 50, 200);
                    break;
                case 6:
                    initProp(2, 32, 7, 60, 250);
                    break;
            }
            this.actor = new CitizenActor(this);
            this.face = new CitizenFace(this);
        }
        
        public function get velocity():Vector2D {
            return actor.velocity;
        }

        public function set velocity(value:Vector2D):void {
            actor.velocity = value;
        }
        
        public function get steeringForce():Vector2D
        {
            return actor.steeringForce;
        }
        
        public function set steeringForce(value:Vector2D):void
        {
            actor.steeringForce = value;
        }
        
        // 初始化角色的基本属性
        public function initProp(attack:int, hp:int, speed:int, weight:int, exp:int):void {
            this.attack = attack;
            this.init_hp = hp;
            this.hp = hp;
            this.speed = speed;
            this.weight = weight;
            this.exp = exp;
        }
        
        // 得到角色半径
        override public function get radius():Number {
            var innerangle:Number = (2 * Math.PI) / level;
            return (side / 2) / Math.sin(innerangle / 2);
        }

        // 得到角色级别
        public function get level():int {
            return _level;
        }
        public function set level(value:int):void {
            if (value > 8) value = 8;
            if (value < 2) value = 2;
            if (_level != value) {
                _level = value;
                actor.update();
                face.repaint();
            }
        }

        /**
         * 击中敌人
         * @parm enemy 被击中的敌人
         */
        public function hit(enemy:Citizen):void {
            var hurt:int = this.attack;
            enemy.getHurt(hurt);
            if (enemy.state.has(States.DIED))
            {
                enemy.die();
                var _score:int = enemy.exp;
                this.score += _score;
            }
        }
        
        /**
        * 受到伤害
        * @parm hurt int 受到的伤害值
        */
        public function getHurt(hurt:int):void {
            this.hp -= hurt;
            if (this.hp <=0)
            {
                this.state.clear().add(States.DIED);
            }
            else
            {
                face.express(CitizenFace.HURT);
                new InjuryProtect().apply(this);
            }
        }
        
        /**
         * 角色死亡 
         */        
        public function die():void
        {
            // 不能在事件中销毁对象 @TODO 更好地解决方案
            this.scene.roles.removeRole(this);
        }

        public function pickGold(gold:int):void {
            this.gold += gold;
         }
        
        public function levelUp():void {
            level++;
        }
        
        public function levelDown():void {
            level--;
        }

        override public function toString():String {
            return 'Name:' + name + '\n' 
            + 'Hp:' + hp + '\n' 
            + 'Score:' + score + '\n' 
            + 'Gold:' + gold + '\n' 
            + 'State:' + state + '\n'
            + 'uuid:' + uuid + '\n'
            ;
         }

        public function activate(item:IItem):void {

        }

        public function deactivate(item:IItem):void {

        }
    }
}