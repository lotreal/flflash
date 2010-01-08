package
{
    import im.luo.logging.Logger;
    import Box2D.Common.Math.b2Vec2;
    public class Referee {
        private var _logger:Logger = Logger.getLogger(this);

        public static function judge(actor1:Actor, actor2:Actor, position:b2Vec2):void {
            var distance1:Number = MathUtil.distanceBetweenPoints(
                actor1.body.GetPosition(), position);
            var distance2:Number = MathUtil.distanceBetweenPoints(
                actor2.body.GetPosition(), position);
            if (distance1 > distance2) {
                actor1.say("win");
                actor2.say("lose");
            } else if (distance2 > distance1) {
                actor1.say("lose");
                actor2.say("win");
            } else {
                actor1.say("draw");
                actor2.say("draw");
            }
        }
    }
}
