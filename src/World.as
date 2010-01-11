package 
{
    import flash.events.*;
    import flash.display.*;
    import im.luo.logging.Logger;

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
        private var timeStep:Number = 1.0 / 60.0;
        private var iterations:Number = 10;

        private var contactListener:ContactListener;

        public function World(singleton_enforcer:SingletonEnforcer) {
            var context:Context = Context.instance;
            //context.camera.addChild(this);
            var worldAABB:b2AABB = new b2AABB();
            worldAABB.lowerBound.Set(-100.0, -100.0);
            worldAABB.upperBound.Set(100.0, 100.0);

            var gravity:b2Vec2 = new b2Vec2 (0.0, 0.0);
            var doSleep:Boolean = true;

            world = new b2World(worldAABB, gravity, doSleep);


            //debugSprite is some sprite that we want to draw our debug shapes into.
            var debugSprite:Sprite = new Sprite();
            context.camera.addChild(debugSprite);
            
            // set debug draw
            var dbgDraw:b2DebugDraw = new b2DebugDraw();
            
            dbgDraw.m_sprite = debugSprite;
            dbgDraw.m_drawScale = 30.0;
            dbgDraw.m_fillAlpha = 0.3;
            dbgDraw.m_lineThickness = 1.0;
	    dbgDraw.m_drawFlags = b2DebugDraw.e_shapeBit|b2DebugDraw.e_jointBit|b2DebugDraw.e_coreShapeBit|b2DebugDraw.e_pairBit|b2DebugDraw.e_centerOfMassBit;

            world.SetDebugDraw(dbgDraw);

            contactListener = new ContactListener();
            world.SetContactListener(contactListener);
	    addEventListener(Event.ENTER_FRAME, run);
        }

        public function getWorld():b2World { return world; }

        public function run(e:Event):void {
            world.Step(timeStep, iterations);

            while(contactListener.contactStack[0])
            {
                var contactPoint:ContactPoint = contactListener.contactStack.pop();
                logger.debug('contact!');
                Collide.process(contactPoint);
            }
        }
    }
}
// SingletonEnforcer
class SingletonEnforcer {}