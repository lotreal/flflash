package im.luo.vw.box2d
{
    import Box2D.Collision.Shapes.b2PolygonShape;
    import Box2D.Common.Math.b2Vec2;
    public class ShapeUtil {
        public static function evalEquilateralVertices(radius:Number, edges:int):Vector.<b2Vec2> {
            var vertices:Vector.<b2Vec2> = new Vector.<b2Vec2>(edges);
            var innerangle:Number = (2 * Math.PI) / edges;
	    var x:Number, y:Number;
            for (var i:int = 0; i < edges; i++) {
		x = Math.cos((innerangle * i)) * radius;
		y = Math.sin((innerangle * i)) * radius;
                vertices[i] = new b2Vec2(x, y);
            }
            return vertices;
        }

        public static function equilateral(radius:Number, edges:int):b2PolygonShape {
            var vertices:Vector.<b2Vec2> = evalEquilateralVertices(radius, edges);
            if (edges == 2) {
                return b2PolygonShape.AsBox(vertices[0].x, 0.01);
            } else {
                return b2PolygonShape.AsVector(vertices, edges);
            }
        }
    }
}