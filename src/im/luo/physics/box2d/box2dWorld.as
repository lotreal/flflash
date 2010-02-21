package im.luo.physics.box2d 
{
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import Box2D.Dynamics.Contacts.*;
    
    import flash.display.*;
    import flash.events.*;

    import flf.flatland.game.Grip;

    import im.luo.events.TickEvent;
    import im.luo.logging.Logger;
    import im.luo.util.Tick;
    import im.luo.staff.Context;
    import im.luo.sim.IWorld;
    import im.luo.geom.Vector2D;
    import im.luo.util.TimeUtil;
    
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
            world.SetContinuousPhysics(false);
            if (Settings.debug) debugDraw();
            createEdge();

            Tick.instance.addEventListener(TickEvent.TICK, run);
            world.addEventListener(b2World.BEGINCONTACT, contact);
            //world.addEventListener(b2World.ENDCONTACT, contact2);
            //world.addEventListener(b2World.PRESOLVE, contact4);
            //world.addEventListener(b2World.POSTSOLVE, contact3);
        }
        
        public function getWorld():b2World { return world; }
        
        public function run(event:Event = null):void {
            world.Step(timeStep, iterations, 10); //10 = positionIterations
            world.ClearForces() 
            if (Settings.debug) world.DrawDebugData();
        }

        private var contactCooldown:int = 500;
        private var contactFlag:Boolean = true;

        public function contact2(event:b2ContactEvent):void {
            _logger.debug('end contact');
        }

        public function contact3(event:b2PostSolveEvent):void {
            _logger.debug('post solve');
        }

        public function contact4(event:b2PreSolveEvent):void {
            _logger.debug('pre solve');
        }

        public function contact(event:b2ContactEvent):void {
            _logger.debug('begin contact');
            var contact:b2Contact = event.contact;
            var worldManifold:b2WorldManifold;
            var contactPoint:b2Vec2;
            if (contact != null) {
                var a:* = contact.GetFixtureA().GetUserData();
                var b:* = contact.GetFixtureB().GetUserData();

                if (Grip.validate(a, b)) {
                    try {
                        worldManifold = new b2WorldManifold();
                        contact.GetWorldManifold(worldManifold);
                        contactPoint = worldManifold.m_points[0];
                        Grip.collide(a, b, new Vector2D(contactPoint.x * 30, contactPoint.y * 30));
                    }
                    catch (e:Error) {
                    }
                }
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