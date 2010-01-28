package 
{
    import flash.events.*;
    import flash.display.*;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.GlowFilter;

    import im.luo.logging.Logger;

    import Box2D.Dynamics.*;
    import Box2D.Dynamics.Contacts.*;
    import Box2D.Common.Math.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    
    public class World implements IWorld {
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

        private var camera:Camera = Context.instance.camera;

        public function World(singleton_enforcer:SingletonEnforcer) {
            var context:Context = Context.instance;

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

            var glow:GlowFilter = new GlowFilter();
            glow.color = 0xffffff;
            glow.alpha = 0.8;
            glow.blurX = 12;
            glow.blurY = 12;
            glow.quality = BitmapFilterQuality.MEDIUM;

            //debugSprite.filters = [glow];

            world.SetDebugDraw(dbgDraw);

            contactListener = new ContactListener();
            world.SetContactListener(contactListener);
	    camera.addEventListener(Event.ENTER_FRAME, run);



            var width:int = 997 * 2;
            var height:int = 600 * 2;

            var bodyDef:b2BodyDef = new b2BodyDef();
            bodyDef.position.Set(0, 0);

            var body:b2Body = world.CreateBody(bodyDef);

	    var boxDef:b2PolygonDef;

	    boxDef = new b2PolygonDef();
            boxDef.SetAsOrientedBox(width/2/30, 0.2, new b2Vec2(width/30/2, -0.1), 0);
            boxDef.density = 0;
            body.CreateShape(boxDef);

	    boxDef = new b2PolygonDef();
            boxDef.SetAsOrientedBox(width/2/30, 0.2, new b2Vec2(width/30/2, height/30+0.1), 0);
            boxDef.density = 0;
            body.CreateShape(boxDef);

	    boxDef = new b2PolygonDef();
            boxDef.SetAsOrientedBox(0.2, height/2/30, new b2Vec2(-0.1, height/2/30), 0);
            boxDef.density = 0;
            body.CreateShape(boxDef);

	    boxDef = new b2PolygonDef();
            boxDef.SetAsOrientedBox(0.2, height/2/30, new b2Vec2(width/30+0.1, height/2/30), 0);
            boxDef.density = 0;
            body.CreateShape(boxDef);


            body.CreateShape(boxDef);
            body.SetMassFromShapes();

        }

        public function getWorld():b2World { return world; }

        public function run(e:Event):void {
            world.Step(timeStep, iterations);

            while(contactListener.contactStack[0])
            {
                var contactPoint:ContactPoint = contactListener.contactStack.pop();
                //logger.debug('contact!');
                Collide.process(contactPoint);
            }
        }

        public function destroyBody(body:*):void {
            world.DestroyBody(body);
        }
        public function createBody(body:*):* {
            return world.CreateBody(body);
        }

    }
}
// SingletonEnforcer
class SingletonEnforcer {}