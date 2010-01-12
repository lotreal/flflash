package
{
    import im.luo.logging.Logger;
    import Box2D.Common.Math.b2Vec2;

    public class GeomUtil {
        private var _logger:Logger = Logger.getLogger(this);

        public static function evalPolygonVertices(edges:int, radius:Number):Vector.<b2Vec2> {
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
    }
}
