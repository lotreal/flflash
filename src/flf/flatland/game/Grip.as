package flf.flatland.game
{
    import flf.flatland.item.Invincible;
    import flf.flatland.role.Creature;
    import flf.flatland.role.Gold;
    import flf.flatland.role.Heart;
    import flf.flatland.role.Role;
    import im.luo.item.IItem;
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import im.luo.role.IRole;
    import im.luo.util.TimeUtil;

    public class Grip
    {
        public function Grip()
        {
        }
        
        public static function sortOnType(a:IRole, b:IRole):Number {
            return 1;
        }

        public static function validate(a:IRole, b:IRole):Boolean {
            //var contacts:Vector.<IRole> = new Vector.<IRole>(a, b);
            //contacts.sort(sortOnType);

            //if (a.type == Role.CREATURE || b.type == Role.CREATURE) return true;
            //return false;

            if (a.type == Role.EDGE || b.type == Role.EDGE) return false;
            return true;
        }

        public static function collide(a:IRole, b:IRole, p:Vector2D):void {
            if (a.type == Role.CREATURE && b.type == Role.CREATURE) {
                collidByCreature(a as Creature, b as Creature, p);
            } else if (a.type == Role.CREATURE && b.type == Role.GOLD) {
                collidByGold(a as Creature, b as Gold, p);
            } else if (b.type == Role.CREATURE && a.type == Role.GOLD) {
                collidByGold(b as Creature, a as Gold, p);
            } else if (a.type == Role.CREATURE && b.type == Role.HEART) {
                collidByHeart(a as Creature, b as Heart, p);
            } else if (b.type == Role.CREATURE && a.type == Role.HEART) {
                collidByHeart(b as Creature, a as Heart, p);
            }
        }

        public static function collidByCreature(a:Creature, b:Creature, position:Vector2D):void {
            if (a.invincible || b.invincible) {
                _logger.debug('invincible');
                return void;
            }
            var distance1:Number = a.radius - a.position.dist(position);
            var distance2:Number = b.radius - b.position.dist(position);
            _logger.debug('collidByCreature', position, distance1, distance2);
            if (distance1 < distance2) {
                a.win();
                b.lose();
                _logger.debug('a.win');
            } else if (distance1 > distance2) {
                a.lose();
                b.win();
                _logger.debug('b.win');
            } else {
                _logger.debug('unknown');
            }

            new Invincible().apply(a);
            new Invincible().apply(b);

        }

        public static function collidByGold(a:Creature, b:Gold, position:Vector2D):void {
            a.setGold(a.gold + 100);
            TimeUtil.delay(100, function handler():void{ b.destroy(); });
        }

        public static function collidByHeart(a:Creature, b:Heart, position:Vector2D):void {
            a.hp += 1;
            TimeUtil.delay(100, function handler():void{ b.destroy(); });
        }
        
        private static var _logger:Logger = Logger.getLogger(new Grip());
    }
}