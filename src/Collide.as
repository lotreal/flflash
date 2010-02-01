package
{
    import im.luo.logging.Logger;
    import Box2D.Common.Math.b2Vec2;
    import im.luo.geom.Vector2D;
    import im.luo.physics.box2d.box2dActor;
    import flf.flatland.fx.Peng;
    import flf.flatland.fx.Peng2;

    public class Collide {
        public static function process(contactPoint:ContactPoint):void {
            var actor1:box2dActor = contactPoint.actor1;
            var actor2:box2dActor = contactPoint.actor2;
            var p:b2Vec2 = contactPoint.position;
            var position:Vector2D = new Vector2D(p.x, p.y);

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
