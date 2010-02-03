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
            var def:b2PolygonShape = ShapeUtil.equilateral(role.radius, role.level);

            var fixtureDef:b2FixtureDef = new b2FixtureDef();
            fixtureDef.shape = def;
            fixtureDef.density = 1;// was boxDef.density=1;
            fixtureDef.friction = 1;// was boxDef.friction=1;
            fixtureDef.restitution = 10;// was boxDef.restitution=0.1;
            fixtureDef.userData = role;
            body.CreateFixture(fixtureDef);// was body.CreateShape(boxDef);

            //def.density = 10;
            //def.restitution = 8;
            //def.friction = 1;
            //if (role.level == 3 ) {
            //    initMassData = role.actor.mass;
            //}
            //if (role.level == 2) {
            //    role.actor.mass = initMassData;
            //}
        }
    }
}
