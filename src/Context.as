package {
    import flash.display.*;

    import flash.events.*;
    import flash.display.MovieClip;
    import flash.display.StageScaleMode;
    import flash.events.*;
    import com.actionsnippet.qbox.*;
    import Box2D.Dynamics.*;

    import flf.*;
    import im.luo.utils.*;
    import im.luo.log.Logger;

    public class Context {
        //private var keys:Vector.<Boolean> = new Vector.<Boolean>(256);

	private static var _instance:Context = null;
        public static function get instance():Context {
	    return Context.getInstance();
	}
	public static function getInstance():Context {
	    if (_instance == null) _instance = new Context(new SingletonEnforcer());
	    return _instance;
	}
        public var logger:Logger;
        public var sprite:Sprite;
        public var stage:Stage;

        public var world:World;
        public var camera:Camera;

        public var scenario:Scenario;
        public var director:Director;

        public var keyMapper:KeyMapper;

        public function Context(singleton_enforcer:SingletonEnforcer) {}
	
        public static function init(root:Sprite):void {
            root.stage.scaleMode = StageScaleMode.NO_SCALE;
            var context:Context = Context.instance;
            with(context) {
                sprite = root;
                stage = root.stage;
                logger = Logger.getLogger(context);

                camera = Camera.instance;
                world = World.instance;
                
                scenario = Scenario.instance;
                director = Director.instance;


                director.Action();
            }
        }
    }
}

// SingletonEnforcer
class SingletonEnforcer {}