package
{
    import im.luo.logging.Logger;
    import Box2D.Collision.Shapes.b2PolygonDef;
    import Box2D.Common.Math.b2Vec2;

    public class GladiatorActor extends Actor {
        private var _logger:Logger = Logger.getLogger(this);

        public function GladiatorActor(role:GladiatorRole) {
            super(role);
        }

        override protected function createShape():void {
            var vertices:Vector.<b2Vec2> = GeomUtil.evalPolygonVertices(role.level, role.radius);
            var def:b2PolygonDef = new b2PolygonDef();
            def.vertexCount = role.level
	    for (var i:Number = 0; i < role.level; i++)
	    {
                var p:b2Vec2 = vertices[i];
                def.vertices[i].Set(p.x, p.y);
	    }
            def.density = 0.1;
            def.restitution = 0.6;
            //def.friction = 1;
            def.userData = this;

            shape = body.CreateShape(def);
            body.SetMassFromShapes();
        }
    }
}
