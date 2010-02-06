package flf.flatland.actor
{
    import im.luo.logging.Logger;
    import Box2D.Collision.Shapes.b2PolygonShape;
    import Box2D.Collision.Shapes.b2MassData;
    import im.luo.geom.Vector2D;
    import flf.flatland.role.Creature;
    import Box2D.Dynamics.b2FixtureDef;
    import im.luo.physics.box2d.ShapeUtil;
    import im.luo.actor.box2dActor;

    public class CreatureActor extends box2dActor {
        private var _logger:Logger = Logger.getLogger(this);

        public function CreatureActor(role:Creature) {
            super(role);
        }

        private var initMassData:b2MassData;
        override protected function createShape():void {
            var shape:b2PolygonShape = ShapeUtil.equilateral(role.radius, role.level);
            addFixture(shape);
        }
    }
}
