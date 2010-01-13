package
{
    import im.luo.logging.Logger;
    import Box2D.Common.Math.b2Vec2;
    public class Referee {
        public static var logger:Logger = Logger.getLogger(new Referee());

        public static function judge(actor1:Actor, actor2:Actor, position:b2Vec2):void {
            var distance1:Number = actor1.role.radius - b2Vec2Util.distanceBetweenPoints(
                actor1.center, position);
            var distance2:Number = actor2.role.radius - b2Vec2Util.distanceBetweenPoints(
                actor2.center, position);
            //logger.debug(distance1, distance2);
            if (distance1 < distance2) {
                actor1.role.levelUp();
                actor2.role.levelDown();
            } else if (distance1 > distance2) {
                actor1.role.levelDown();
                actor2.role.levelUp();
            } else {
            }
        }
    }
}
