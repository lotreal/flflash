package flf.flatland.role
{
    import flash.events.TimerEvent;
    import flash.text.TextField;
    import flash.utils.Timer;
    
    import flf.flatland.actor.EdgeActor;
    import im.luo.face.Face;
    
    import im.luo.role.Role;
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;


    public class Edge extends Role {
        private var _logger:Logger = Logger.getLogger(this);
        public function Edge(name:String, x:int, y:int) {
            super(name, x, y);
            type = Roles.EDGE;
            this.actor = new EdgeActor(this);
            this.face = new Face(this);
        }
    }
}