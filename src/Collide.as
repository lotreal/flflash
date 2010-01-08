package
{
    import im.luo.logging.Logger;
    import Box2D.Common.Math.b2Vec2;

    public class Collide {
        private var _logger:Logger = Logger.getLogger(this);
        public static function process(contactPoint:ContactPoint):void {
            var actor1:Actor = contactPoint.actor1;
            var actor2:Actor = contactPoint.actor2;
            var position:b2Vec2 = contactPoint.position;

            new Peng(position);
            Referee.judge(actor1, actor2, position);
        }
    }
}
