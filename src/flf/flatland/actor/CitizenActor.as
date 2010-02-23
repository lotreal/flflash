package flf.flatland.actor
{
    import im.luo.logging.Logger;
    import Box2D.Collision.Shapes.b2PolygonShape;
    import Box2D.Collision.Shapes.b2MassData;
    import im.luo.geom.Vector2D;
    import flf.flatland.role.Citizen;
    import Box2D.Dynamics.b2FixtureDef;
    import im.luo.vw.box2d.ShapeUtil;
    import im.luo.actor.Box2DActor;

    public class CitizenActor extends Box2DActor {
        private var _logger:Logger = Logger.getLogger(this);

        public function CitizenActor(role:Citizen) {
            super(role);
        }

        override protected function createShape():void {
            var shape:b2PolygonShape = ShapeUtil.equilateral(role.radius / scale, role.level);
            addFixture(shape);
        }
    }
}
