package flf.flatland.role
{
    import flash.events.TimerEvent;
    import flash.text.TextField;
    import flash.utils.Timer;
    
    import flf.flatland.actor.EdgeActor;
    import im.luo.face.Face;
    
    import im.luo.role.RoleAbstract;
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;


    public class Edge extends RoleAbstract {
        private var _logger:Logger = Logger.getLogger(this);
        public function Edge(name:String, x:int, y:int) {
            super(name, x, y);
            type = Role.EDGE;
            this.actor = new EdgeActor(this);
            this.face = new Face(this);
        }
    }
}