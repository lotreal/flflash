package flf.flatland.actor
{
    import Box2D.Collision.Shapes.b2CircleShape;
    import Box2D.Dynamics.b2FixtureDef;
    
    import im.luo.actor.Box2DActor;
    import im.luo.role.Role;
    
    public class PropActor extends Box2DActor
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