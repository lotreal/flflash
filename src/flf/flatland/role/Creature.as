package flf.flatland.role
{
    import flf.flatland.actor.CreatureActor;
    import flf.flatland.face.CreatureFace;
    import flf.flatland.ui.PlaySceneUI;
    
    import im.luo.geom.Vector2D;
    import im.luo.item.ICanUseItem;
    import im.luo.item.IItem;
    import im.luo.logging.Logger;
    import im.luo.role.RoleAbstract;

    public class Creature extends RoleAbstract implements ICanUseItem {
        public static var INIT_LEVEL:int = 5;
        public static var MAX_LEVEL:int = 9;

        public static const FORWARD:int = 1;
        public static const BACKWARD:int = 2;

        public var _level:int = INIT_LEVEL;
        public var score:int = 0;
        public var gold:int = 0;
        public var combo:int = 0;

        public var atk:int = 0;
        public var hp:int = 0;
        public var speed:int = 30; // px/sec
        public var angular:int = 0;
        public var weight:int = 0;
        public var exp:int = 0;
        
        public var color:uint = 0x990000;
        public var side:Number = 56;
        public var forwardSpeed:Number = 24;
        public var backwardSpeed:Number = -9;
        public var wanderSpeed:Number = 20;

        public var invincible:Boolean = false;

        private var _logger:Logger = Logger.getLogger(this);
        private var lastMove:int = 0;
        private var v0:Number = 0;
        
        public function Creature(name:String, x:int, y:int, level:int) {
            super(name, x, y);
            this.type = Role.CREATURE;
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
            this.actor = new CreatureActor(this);
            this.face = new CreatureFace(this);
        }
        
        public function initProp(attack:int, hp:int, speed:int, weight:int, exp:int):void {
            this.atk = attack;
            this.hp = hp;
            this.speed = speed;
            this.weight = weight;
            this.exp = exp;
        }
        
        override public function get radius():Number {
            var innerangle:Number = (2 * Math.PI) / level;
            return (side / 2) / Math.sin(innerangle / 2);
        }

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
        
        public function strafeEast(t:int = -1):void {
            var v1:Number = evalLinearVel(20, t, 30);
            var v:Vector2D = new Vector2D(-wanderSpeed, 0);
            actor.linearVel = actor.linearVel.add(v).truncate(wanderSpeed);
        }
        
        public function strafeWest(t:int = -1):void {
            var v1:Number = evalLinearVel(20, t, 30);
            var v:Vector2D = new Vector2D(wanderSpeed, 0);
            actor.linearVel = actor.linearVel.add(v).truncate(wanderSpeed);
        }
        
        public function strafeNorth(t:int = -1):void {
            var v1:Number = evalLinearVel(20, t, 30);
            var v:Vector2D = new Vector2D(0, -wanderSpeed);
            actor.linearVel = actor.linearVel.add(v).truncate(wanderSpeed);
        }
        
        public function strafeSouth(t:int = -1):void {
            var v1:Number = evalLinearVel(20, t, 30);
            var v:Vector2D = new Vector2D(0, wanderSpeed);
            actor.linearVel = actor.linearVel.add(v).truncate(wanderSpeed);
        }
        
/*        public function strafeEast(t:int):void {
            var d:Number = speed * t / 1000;
            _logger.debug('移动前', position, t, d);
            actor.position = new Vector2D(2,2);
            _logger.debug('移动后', position);
        }
        
        public function strafeWest(t:int):void {
            var d:Number = speed * t / 1000;
            position.x -= d;
        }
        
        public function strafeNorth(t:int):void {
            var d:Number = speed * t / 1000;
            position.y -= d;
        }
        
        public function strafeSouth(t:int):void {
            var d:Number = speed * t / 1000;
            position.y += d;
        }*/
        
        
        public function turnLeft():void {
            actor.angularVel -= 1;
        }
        
        public function turnRight():void {
            actor.angularVel += 1;
        }
        
        private function evalLinearVel(a:Number, t:int, maxVel:Number):Number {
            var v:Number = v0 + a * t / 1000;
            if (a > 0) {
                v = v > maxVel ? maxVel : v;
            } else {
                v = v < maxVel ? maxVel : v;
                v = v > v0 ? v0 : v;
            }
            //_logger.debug(v0, a, t, maxVel, v);
            return v;
        }
        
        public function move(type:int):void {
            if (type != lastMove) {
                lastMove = type;
                v0 = actor.linearVel.length;
            }
        }
        
        public function backward(t:int = -1):void {
            move(BACKWARD);
            var v:Number = evalLinearVel(-32, t, -20);
            
            actor.linearVel = new Vector2D(
                v * Math.cos(actor.angle),
                v * Math.sin(actor.angle));
            actor.angularVel *= 0.8;
        }
        
        public function forward(t:int = -1):void {
            move(FORWARD);
            var v:Number = evalLinearVel(24, t, 40);
            
            actor.linearVel = new Vector2D(
                v * Math.cos(actor.angle),
                v * Math.sin(actor.angle));
            actor.angularVel *= 0.8;
        }
        
        public function win():void {
            //if (!this.invincible) 
            this.score += 100;
            if (name == "user") {
                this.combo++;
                if (this.combo > 2) PlaySceneUI.instance.combo.content = "" + this.combo;
                PlaySceneUI.instance.score.content = "Score : " + this.score;
            }
         }
        
        public function lose():void {
            //destroy();
        }

        public function setGold(value:int):void {
            this.gold = value;
            if (name == "user") {
                PlaySceneUI.instance.gold.content = "" + 100;
                PlaySceneUI.instance.gold.position = position;
            }
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
            + 'I:' + invincible + '\n'
            ;
            return 'A:' + atk + '\n' 
            + 'H:' + hp + '\n' 
            + 'S:' + speed + '\n' 
            + 'T:' + type + '\n' 
            + 'N:' + name + '\n'
            + 'I:' + invincible + '\n'
            ;

        }

        public function activate(item:IItem):void {

        }

        public function deactivate(item:IItem):void {

        }
    }
}