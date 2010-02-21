package flf.flatland.actor
{
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import Box2D.Dynamics.Contacts.*;
    
    import flf.flatland.role.Edge;
    
    import im.luo.actor.box2dActor;
    import im.luo.logging.Logger;

    public class EdgeActor extends box2dActor {
        private var _logger:Logger = Logger.getLogger(this);

        public function EdgeActor(role:Edge) {
            lockPosition = true;
            super(role);
        }

        override protected function createShape():void {
            var width:int = context.width * 2;
            var height:int = context.height * 2;
            
            var v1:b2Vec2 = new b2Vec2(0, 0);
            var v2:b2Vec2 = new b2Vec2(width / 30, 0);
            var v3:b2Vec2 = new b2Vec2(width / 30, height/30);
            var v4:b2Vec2 = new b2Vec2(0, height/30);
            
            var fixtureDef:b2FixtureDef = new b2FixtureDef();
            
            
            var boxDef:b2PolygonShape;
            
            boxDef = new b2PolygonShape();
            boxDef.SetAsEdge(v1, v2);
            addFixture(boxDef);
            
            boxDef = new b2PolygonShape();
            boxDef.SetAsEdge(v2, v3);
            addFixture(boxDef);
            
            boxDef = new b2PolygonShape();
            boxDef.SetAsEdge(v3, v4);
            addFixture(boxDef);

            boxDef = new b2PolygonShape();
            boxDef.SetAsEdge(v4, v1);
            addFixture(boxDef);
        }
    }
}
