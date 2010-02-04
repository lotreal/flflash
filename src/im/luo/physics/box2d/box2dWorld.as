package im.luo.physics.box2d 
{
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import Box2D.Dynamics.Contacts.*;
    
    import flash.display.*;
    import flash.events.*;
    
    import im.luo.events.TickEvent;
    import im.luo.logging.Logger;
    import im.luo.util.Tick;
    import im.luo.staff.Context;
    import im.luo.sim.IWorld;
    
    public class box2dWorld implements IWorld {
        private static var _instance:box2dWorld = null;
        public static function get instance():box2dWorld {
            return box2dWorld.getInstance();
        }
        public static function getInstance():box2dWorld {
            if (_instance == null) _instance = new box2dWorld(new SingletonEnforcer());
            return _instance;
        }
        
        private var _logger:Logger = Logger.getLogger(this);
        private var world:b2World;
        private var timeStep:Number = 1.0 / 60.0;
        private var iterations:Number = 10;
        private var context:Context = Context.instance;

        //private var contactListener:ContactListener;
        
        public function box2dWorld(singleton_enforcer:SingletonEnforcer) {
            var gravity:b2Vec2 = new b2Vec2 (0.0, 0.0);
            var doSleep:Boolean = true;
            world = new b2World(gravity, doSleep);
            debugDraw();
            createEdge();

            Tick.instance.addEventListener(TickEvent.TICK, run);
            world.addEventListener(b2World.BEGINCONTACT, contact);
        }
        
        public function getWorld():b2World { return world; }
        
        public function run(event:Event = null):void {
            world.Step(timeStep, iterations, 10); //10 = positionIterations
            world.ClearForces() 
            world.DrawDebugData();
            
            //while(contactListener.contactStack[0])
            //{
            //    var contactPoint:ContactPoint = contactListener.contactStack.pop();
            //    //_logger.debug('contact!');
            //    Collide.process(contactPoint);
            //}
        }
        
        public function contact(event:b2ContactEvent):void {
            var contact:b2Contact = event.contact;
            if (contact != null) {
                var fixtureA:b2Fixture = contact.GetFixtureA();
                var fixtureB:b2Fixture = contact.GetFixtureB();
                _logger.debug("contact!",fixtureA.GetUserData(),fixtureB.GetUserData());
            }
        }
        
        public function destroyBody(body:*):void {
            world.DestroyBody(body);
        }

        public function createBody(body:*):* {
            return world.CreateBody(body);
        }
        
        public function debugDraw():void {
            var m_sprite:Sprite;
            m_sprite = new Sprite();
            
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
            context.cache['world_debug_draw'] = m_sprite;
        }

        public function createEdge():void {
        }
    }
}
// SingletonEnforcer
class SingletonEnforcer {}