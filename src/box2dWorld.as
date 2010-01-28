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
    
    public class box2dWorld implements IWorld {
        private static var _instance:box2dWorld = null;
        public static function get instance():box2dWorld {
            return box2dWorld.getInstance();
        }
        public static function getInstance():box2dWorld {
            if (_instance == null) _instance = new box2dWorld(new SingletonEnforcer());
            return _instance;
        }

        private var logger:Logger = Logger.getLogger(this);
        private var world:b2World;
        private var timeStep:Number = 1.0 / 60.0;
        private var iterations:Number = 10;

        private var contactListener:ContactListener;

        private var camera:Camera = Context.instance.camera;

        public function box2dWorld(singleton_enforcer:SingletonEnforcer) {
            var gravity:b2Vec2 = new b2Vec2 (0.0, 0.0);
            var doSleep:Boolean = true;
            world = new b2World(gravity, doSleep);
            debug_draw();




            //contactListener = new ContactListener();
            //world.SetContactListener(contactListener);
	    camera.addEventListener(Event.ENTER_FRAME, run);


            var width:int = 997 * 2;
            var height:int = 600 * 2;

            var fixtureDef:b2FixtureDef = new b2FixtureDef();

            var bodyDef:b2BodyDef = new b2BodyDef();
            bodyDef.position.Set(0, 0);

            var body:b2Body = world.CreateBody(bodyDef);

	    var boxDef:b2PolygonShape;

	    boxDef = new b2PolygonShape();
            boxDef.SetAsOrientedBox(width/2/30, 0.2, new b2Vec2(width/30/2, -0.1), 0);

            fixtureDef.shape = boxDef;
            fixtureDef.friction = 1;
            fixtureDef.density = 1;

            body.CreateFixture(fixtureDef);

	    boxDef = new b2PolygonShape();
            boxDef.SetAsOrientedBox(width/2/30, 0.2, new b2Vec2(width/30/2, height/30+0.1), 0);
            fixtureDef.shape = boxDef;
            fixtureDef.friction = 1;
            fixtureDef.density = 1;

            body.CreateFixture(fixtureDef);


	    boxDef = new b2PolygonShape();
            boxDef.SetAsOrientedBox(0.2, height/2/30, new b2Vec2(-0.1, height/2/30), 0);
            fixtureDef.shape = boxDef;
            fixtureDef.friction = 1;
            fixtureDef.density = 1;

            body.CreateFixture(fixtureDef);

	    boxDef = new b2PolygonShape();
            boxDef.SetAsOrientedBox(0.2, height/2/30, new b2Vec2(width/30+0.1, height/2/30), 0);
            fixtureDef.shape = boxDef;
            fixtureDef.friction = 1;
            fixtureDef.density = 1;

            body.CreateFixture(fixtureDef);
        }

        public function getWorld():b2World { return world; }

        public function run(e:Event):void {
            world.Step(timeStep, iterations, 10); //10 = positionIterations
            world.ClearForces() 
            world.DrawDebugData();

            //while(contactListener.contactStack[0])
            //{
            //    var contactPoint:ContactPoint = contactListener.contactStack.pop();
            //    //logger.debug('contact!');
            //    Collide.process(contactPoint);
            //}
        }

        public function destroyBody(body:*):void {
            world.DestroyBody(body);
        }
        public function createBody(body:*):* {
            return world.CreateBody(body);
        }

        public function debug_draw():void {
            var m_sprite:Sprite;
            m_sprite = new Sprite();
            camera.addChild(m_sprite);

            var dbgDraw:b2DebugDraw = new b2DebugDraw();
            var dbgSprite:Sprite = new Sprite();
            m_sprite.addChild(dbgSprite);
            dbgDraw.SetSprite(m_sprite); // was dbgDraw.m_sprite=m_sprite;
            dbgDraw.SetDrawScale(30); // was dbgDraw.m_drawScale=30;
            //dbgDraw.SetAlpha(1); // was dbgDraw.m_alpha=1;
            dbgDraw.SetFillAlpha(0.5); // was dbgDraw.m_fillAlpha=0.5;
            dbgDraw.SetLineThickness(1); // was dbgDraw.m_lineThickness=1;
            dbgDraw.SetFlags(b2DebugDraw.e_shapeBit|b2DebugDraw.e_pairBit|b2DebugDraw.e_centerOfMassBit);
            //b2DebugDraw.e_shapeBit

            world.SetDebugDraw(dbgDraw);

            //var glow:GlowFilter = new GlowFilter();
            //glow.color = 0xffffff;
            //glow.alpha = 0.8;
            //glow.blurX = 12;
            //glow.blurY = 12;
            //glow.quality = BitmapFilterQuality.MEDIUM;
            //debugSprite.filters = [glow];
        }

    }
}
// SingletonEnforcer
class SingletonEnforcer {}