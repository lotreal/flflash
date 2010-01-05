package 
{
    import flash.events.*;
    import flash.display.*;
    import im.luo.log.Logger;

    import Box2D.Dynamics.*;
    import Box2D.Dynamics.Contacts.*;
    import Box2D.Common.Math.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    
    public class World extends Sprite {
        private static var _instance:World = null;
        public static function get instance():World {
            return World.getInstance();
        }
        public static function getInstance():World {
            if (_instance == null) _instance = new World(new SingletonEnforcer());
            return _instance;
        }

        private var logger:Logger = Logger.getLogger(this);
        private var world:b2World;
        private var body:b2Body;
        private var timeStep:Number = 1.0 / 60.0;
        private var iterations:Number = 10;

        private var myContactListener:ContactListener;

        public function World(singleton_enforcer:SingletonEnforcer) {
            var context:Context = Context.instance;
            context.camera.addChild(this);
            var worldAABB:b2AABB = new b2AABB();
            worldAABB.lowerBound.Set(-100.0, -100.0);
            worldAABB.upperBound.Set(100.0, 100.0);

            var gravity:b2Vec2 = new b2Vec2 (0.0, 0.0);
            var doSleep:Boolean = true;

            world = new b2World(worldAABB, gravity, doSleep);


            //debugSprite is some sprite that we want to draw our debug shapes into.
            var debugSprite:Sprite = new Sprite();
            addChild(debugSprite);
            
            // set debug draw
            var dbgDraw:b2DebugDraw = new b2DebugDraw();
            
            dbgDraw.m_sprite = debugSprite;
            dbgDraw.m_drawScale = 30.0;
            dbgDraw.m_fillAlpha = 0.3;
            dbgDraw.m_lineThickness = 1.0;
            dbgDraw.m_drawFlags = b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit;
            world.SetDebugDraw(dbgDraw);

            myContactListener = new ContactListener();
            world.SetContactListener(myContactListener);
	    addEventListener(Event.ENTER_FRAME, run);
        }

        public function getWorld():b2World { return world; }

        public function run(e:Event):void {
            world.Step(timeStep, iterations);
            //var position:b2Vec2 = body.GetPosition();
            //var angle:Number = body.GetAngle();
            //trace(position.x +','+ position.y +','+ angle);

            while(myContactListener.contactStack[0])
            {
                var currentContact:CustomContactPoint = myContactListener.contactStack.pop();
                logger.debug('contact!');
                //var xPos:Number = currentContact.position.x * physScale;
                //var yPos:Number = currentContact.position.y * physScale;
                //var penetration:Number = -currentContact.separation;
                //addChild(new Explosion(xPos, yPos, penetration));
            }
        }
    }
}
// SingletonEnforcer
class SingletonEnforcer {}