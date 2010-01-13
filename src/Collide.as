package
{
    import im.luo.logging.Logger;
    import Box2D.Common.Math.b2Vec2;

    public class Collide {
        public static function process(contactPoint:ContactPoint):void {
            var actor1:Actor = contactPoint.actor1;
            var actor2:Actor = contactPoint.actor2;
            var position:b2Vec2 = contactPoint.position;

            trace(actor1, actor2);
            if (actor1 == null || actor2 == null) {
                new Peng(position);
            } else {
                new Peng2(position);
                Referee.judge(actor1, actor2, position);
            }
        }
    }
}
