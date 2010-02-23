package im.luo.vw.box2d 
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
    import im.luo.staff.Context;
    import im.luo.util.Tick;
    import im.luo.vw.IWorld;
    import im.luo.vw.Manifold;
    import im.luo.vw.World;
    
    public class Box2DWorld extends EventDispatcher implements IWorld {
        public static function get instance():Box2DWorld {
            if (_instance == null) _instance = new Box2DWorld(new SingletonEnforcer());
            return _instance;
        }
        
        public function Box2DWorld(singleton_enforcer:SingletonEnforcer) {
            var gravity:b2Vec2 = new b2Vec2 (0.0, 0.0);
            var doSleep:Boolean = true;
            world = new b2World(gravity, doSleep);
            world.SetContinuousPhysics(false);
            if (Settings.debug) debugDraw();
            
            Tick.instance.addEventListener(TickEvent.TICK, run);
            world.addEventListener(b2World.BEGINCONTACT, contact);
        }
        
        public function getWorld():b2World { return world; }
        
        public function run(event:Event = null):void {
            world.Step(timeStep, iterations, 10); //10 = positionIterations
            world.ClearForces();
            //if (Settings.debug) world.DrawDebugData();
        }
        
        public function contact(event:b2ContactEvent):void {
            var manifold:Manifold = new Manifold();
            manifold.role1 = event.contact.GetFixtureA().GetUserData();
            manifold.role2 = event.contact.GetFixtureB().GetUserData();
            var _beginContactEvent:ContactEvent = new ContactEvent(World.BEGINCONTACT);
            _beginContactEvent.contact = event.contact;
            _beginContactEvent.manifold = manifold;
            dispatchEvent(_beginContactEvent);
        }
        
        public function destroyBody(body:*):void {
            world.DestroyBody(body);
        }
        
        public function createBody(body:*):* {
            return world.CreateBody(body);
        }

        // 绘制 box2d world 测试图形
        public function debugDraw():void {
            var m_sprite:Sprite;
            m_sprite = new Sprite();
            
            var dbgDraw:b2DebugDraw = new b2DebugDraw();
            var dbgSprite:Sprite = new Sprite();
            m_sprite.addChild(dbgSprite);
            dbgDraw.SetSprite(m_sprite);
            dbgDraw.SetDrawScale(30);
            dbgDraw.SetAlpha(0.5);
            dbgDraw.SetFillAlpha(0.5);
            dbgDraw.SetLineThickness(1);
            dbgDraw.SetFlags(b2DebugDraw.e_shapeBit|b2DebugDraw.e_pairBit|b2DebugDraw.e_centerOfMassBit);
            world.SetDebugDraw(dbgDraw);
            
            context.cache['world_debug_draw'] = m_sprite;
        }
        
        private static var _instance:Box2DWorld = null;
        
        private var _logger:Logger = Logger.getLogger(this);
        private var world:b2World;
        private var timeStep:Number = 1.0 / 60.0;
        private var iterations:Number = 10;
        private var context:Context = Context.instance;
        //private var _beginContactEvent:ContactEvent = new ContactEvent(World.BEGINCONTACT);
    }
}
// SingletonEnforcer
class SingletonEnforcer {}