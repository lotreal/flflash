package flf.flatland.actor
{
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import Box2D.Dynamics.Contacts.*;
    
    import flf.flatland.role.Edge;
    
    import im.luo.actor.box2dStaticActor;
    import im.luo.logging.Logger;

    public class EdgeActor extends box2dStaticActor {
        private var _logger:Logger = Logger.getLogger(this);

        public function EdgeActor(role:Edge) {
            super(role);
        }

        private var initMassData:b2MassData;
        override protected function createShape():void {
            var width:int = context.width * 2;
            var height:int = context.height * 2;
            
            var fixtureDef:b2FixtureDef = new b2FixtureDef();
            
            //var bodyDef:b2BodyDef = new b2BodyDef();
            //bodyDef.position.Set(0, 0);
            
            //var body:b2Body = world.CreateBody(bodyDef);
            
            var boxDef:b2PolygonShape;
            
            boxDef = new b2PolygonShape();
            boxDef.SetAsOrientedBox(width/2/30, 0.2, new b2Vec2(width/30/2, -0.1), 0);
            
            fixtureDef.shape = boxDef;
            fixtureDef.friction = 1;
            fixtureDef.density = 1;
            
            body.CreateFixture(fixtureDef);
            
            boxDef = new b2PolygonShape();
            boxDef.SetAsOrientedBox(width/2/30, 0.2, new b2Vec2(width/30/2, height/30+0.1), 0);
            fixtureDef.shape = boxDef;
            fixtureDef.friction = 1;
            fixtureDef.density = 1;
            
            body.CreateFixture(fixtureDef);
            
            
            boxDef = new b2PolygonShape();
            boxDef.SetAsOrientedBox(0.2, height/2/30, new b2Vec2(-0.1, height/2/30), 0);
            fixtureDef.shape = boxDef;
            fixtureDef.friction = 1;
            fixtureDef.density = 1;
            
            body.CreateFixture(fixtureDef);
            
            boxDef = new b2PolygonShape();
            boxDef.SetAsOrientedBox(0.2, height/2/30, new b2Vec2(width/30+0.1, height/2/30), 0);
            fixtureDef.shape = boxDef;
            fixtureDef.friction = 1;
            fixtureDef.density = 1;
            
            body.CreateFixture(fixtureDef);

        }
    }
}
