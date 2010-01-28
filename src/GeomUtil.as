package
{
    import im.luo.logging.Logger;
    import im.luo.geom.Vector2D;

    public class GeomUtil {
        private var _logger:Logger = Logger.getLogger(this);

        public static function evalPolygonVertices(edges:int, radius:Number):Vector.<Vector2D> {
            var vertices:Vector.<Vector2D> = new Vector.<Vector2D>(edges);
            var innerangle:Number = (2 * Math.PI) / edges;
	    var x:Number, y:Number;
            for (var i:int = 0; i < edges; i++) {
		x = Math.cos((innerangle * i)) * radius;
		y = Math.sin((innerangle * i)) * radius;
                vertices[i] = new Vector2D(x, y);
            }
            return vertices;
        }
    }
}
