package {
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.text.TextField;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import flash.geom.*;
    import im.luo.logging.Logger;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import caurina.transitions.Tweener;
    public class Actor extends Sprite {
        private var logger:Logger = Logger.getLogger(this);
        private var context:Context = Context.instance;
        private var camera:Camera = context.camera;

        public var body:b2Body;
        private var vision:Vision;
;

        public function get behaviour():IRoleBehaviour {
            return _behaviour;
        }
        public function set behaviour(_b:IRoleBehaviour):void {
            _behaviour = _b;
            _behaviour.actor = this;
            run();
        }

        private var _world:b2World = context.world.getWorld();
        public function get world():b2World {
            return _world;
        }

        private var _bodyDef:b2BodyDef = null;
        public function get bodyDef():b2BodyDef {
            _bodyDef = new b2BodyDef();
            _bodyDef.position.Set(ix, iy);
	    _bodyDef.linearDamping = 1;
	    _bodyDef.angularDamping = 2;
            _bodyDef.angle = 0;
            return _bodyDef;
        }
        public function set bodyDef(t_bodyDef:b2BodyDef):void {
            _bodyDef = t_bodyDef;
        }

        private var _shapeDef:b2ShapeDef = null;

        public function get shapeDef():b2ShapeDef {
            var def:b2PolygonDef = new b2PolygonDef();
            def.SetAsBox(sideLength/2, sideLength/2);

            def.density = 1.0;
            def.friction = 0.3;
            def.userData = this;

            _shapeDef = def;
            return _shapeDef;
        }
        public function set shapeDef(t_shapeDef:b2ShapeDef):void {
            _shapeDef = t_shapeDef;
        }

        private var _shape:b2Shape = null;
        public function get shape():b2Shape {
            return _shape;
        }
        public function set shape(t_shape:b2Shape):void {
            _shape = t_shape;
        }

        public var level:uint = 4;

        public var ix:Number = 10;
        public var iy:Number = 6;


        private var _behaviour:IRoleBehaviour;

        private var sideLength:Number = 3;

        private var physScale:Number = 30;
        private var torque:Number = 3;
        private var speed:Number = 0.3;

        private var forwardSpeed:Number = 18;
        private var backwardSpeed:Number = -9;

        public function Actor(ix:Number = 10, iy:Number = 6, _b:IRoleBehaviour = null):void {
            this.ix = ix;
            this.iy = iy;
            addEventListener(Event.ENTER_FRAME, run);

            body = world.CreateBody(bodyDef);
            body.m_userData = this;
            attachShape(shapeDef);
            paint();

            if (_b != null) {
                behaviour = _b;
            }
        }


        public function run(event:Event = null):void {
            if (behaviour != null) {
                behaviour.run();
            }
            updateVision(event);
        }

        private function attachShape(def:b2ShapeDef):void {
            shape = body.CreateShape(def);
            body.SetMassFromShapes();
        }


        private function paint():void {
            vision = camera.observe(this);
            paintBody();
        }
        
        private function repaint():void {
            paintBody();
        }


        private function paintBody():void {
            vision.graphics.clear();
            var p:b2Vec2 = vertices[0];
            vision.lineStyle(1, 0x990000, .75);
            vision.moveTo(p.x, p.y);
	    for (var i:int = 1; i < level; i++) {
                p = vertices[i];
                vision.lineTo(p.x, p.y);
	    }
            p = vertices[0];
            vision.lineTo(p.x, p.y);
        }


        public function updateVision(e:Event):void {
            var position:b2Vec2 = body.GetPosition();
            var rotation:Number = body.GetAngle();

            vision.rotation = 0; // If not, matrix starts wrong.
            var m:Matrix;
            m = vision.transform.matrix;
            m.rotate(rotation);
            m.tx = camera.rx(position.x);
            m.ty = camera.ry(position.y);

            vision.transform.matrix = m;
        }

        public function destroy():void {
            vision.parent.removeChild(vision);
            world.DestroyBody(body);
        }

    }
}
