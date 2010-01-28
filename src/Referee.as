package
{
    import im.luo.logging.Logger;
    import im.luo.geom.Vector2D;

    public class Referee {
        public static var logger:Logger = Logger.getLogger(new Referee());

        public static function judge(actor1:box2dActor, actor2:box2dActor, position:Vector2D):void {
            var distance1:Number = actor1.role.radius - actor1.center.dist(position);
            var distance2:Number = actor2.role.radius - actor2.center.dist(position);
            logger.debug(actor1.role.type, distance1, distance2);
            if (distance1 < distance2) {
                actor1.role.levelUp();
                actor2.role.levelDown();
            } else if (distance1 > distance2) {
                actor1.role.levelDown();
                actor2.role.levelUp();
            } else {
            }

            //actor1.applyImpulse(position, actor1.center);
            //actor2.applyImpulse(position, actor2.center);
        }
    }
}
