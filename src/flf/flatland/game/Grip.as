package flf.flatland.game
{
    import flf.flatland.item.Invincible;
    import flf.flatland.role.Citizen;
    import flf.flatland.role.Gold;
    import flf.flatland.role.Heart;
    import flf.flatland.role.Roles;
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

            if (a.type == Roles.EDGE || b.type == Roles.EDGE) return false;
            return true;
        }

        public static function collide(a:IRole, b:IRole, p:Vector2D):void {
            if (a.type == Roles.CITIZEN && b.type == Roles.CITIZEN) {
                collidByCreature(a as Citizen, b as Citizen, p);
            } else if (a.type == Roles.CITIZEN && b.type == Roles.GOLD) {
                collidByGold(a as Citizen, b as Gold, p);
            } else if (b.type == Roles.CITIZEN && a.type == Roles.GOLD) {
                collidByGold(b as Citizen, a as Gold, p);
            } else if (a.type == Roles.CITIZEN && b.type == Roles.HEART) {
                collidByHeart(a as Citizen, b as Heart, p);
            } else if (b.type == Roles.CITIZEN && a.type == Roles.HEART) {
                collidByHeart(b as Citizen, a as Heart, p);
            }
        }

        public static function collidByCreature(a:Citizen, b:Citizen, position:Vector2D):void {
            if (a.invincible || b.invincible) {
                _logger.debug('invincible');
                return void;
            }
            var distance1:Number = a.radius - a.position.dist(position);
            var distance2:Number = b.radius - b.position.dist(position);
            _logger.debug('collidByCreature', position, distance1, distance2);
            if (distance1 < distance2) {
                //a.attack(b);
            } else if (distance1 > distance2) {
                //b.attack(a);
            } else {
                _logger.debug('unknown');
            }

            new Invincible().apply(a);
            new Invincible().apply(b);

        }

        public static function collidByGold(a:Citizen, b:Gold, position:Vector2D):void {
            a.setGold(a.gold + 100);
            TimeUtil.delay(100, function handler():void{ b.destroy(); });
        }

        public static function collidByHeart(a:Citizen, b:Heart, position:Vector2D):void {
            a.hp += 1;
            TimeUtil.delay(100, function handler():void{ b.destroy(); });
        }
        
        private static var _logger:Logger = Logger.getLogger(new Grip());
    }
}