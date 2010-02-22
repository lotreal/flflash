package flf.flatland.actor
{
    import Box2D.Collision.Shapes.b2CircleShape;
    import Box2D.Dynamics.b2FixtureDef;
    
    import im.luo.actor.box2dActor;
    import im.luo.role.Role;
    
    public class PropActor extends box2dActor
    {
        public function PropActor(role:Role)
        {
            super(role);
        }
        
        override protected function createShape():void {
            var shape:b2CircleShape = new b2CircleShape(10 / 30);
            addFixture(shape);
        }
    }
}