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
            _bodyDef.position.Set(wx, wy);
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
            evalVertices();
            var def:b2PolygonDef = new b2PolygonDef();
            def.vertexCount = level
	    for (var i:Number = 0; i < level; i++)
	    {
                var vv:b2Vec2 = vertices[i];
                logger.debug(vv.x, vv.y);
                def.vertices[i].Set(vv.x, vv.y);
	    }

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

        public var wx:Number = 10.0;
        public var wy:Number = 6.0;


        private var _behaviour:IRoleBehaviour;

        private var sideLength:Number = 3.0;

        private var physScale:Number = 30;
        private var torque:Number = 3;
        private var speed:Number = 0.3;

        private var forwardSpeed:Number = 18.0;
        private var backwardSpeed:Number = -9.0;

        public function Actor(_b:IRoleBehaviour = null):void {
            addEventListener(Event.ENTER_FRAME, run);

            body = world.CreateBody(bodyDef);
            body.m_userData = this;
            attachShape(shapeDef);
            crossIn();

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

        private var vertices:Vector.<b2Vec2> = new Vector.<b2Vec2>(10);
        private function evalVertices():void {
            var nAngle:Number = (2 * Math.PI) / level;
            sideLength = 3 / (1 + level/10);
	    var nRadius:Number = (sideLength / 2) / Math.sin(nAngle / 2);
	    var nPx:Number,nPy:Number;

	    for (var i:Number = 0; i < level; i++)
	    {
		nPx = Math.cos((nAngle * i)) * nRadius;
		nPy = Math.sin((nAngle * i)) * nRadius;
                var vv:b2Vec2 = new b2Vec2(nPx, nPy);
                vertices[i] = vv;
	    }
        }

        private function changeLevel(lv:uint):void {
            if (level != lv) {
                //modelling();
            }
        }

        private var dialogue:Vision = new Vision(camera);
        private var dialogueTextBox:TextField = new TextField();
        // on enter camera
        private function crossIn():void {
            vision = camera.observe(this);

            var p:b2Vec2 = vertices[0];
            vision.lineStyle(1, 0x990000, .75);
            vision.moveTo(p.x, p.y);
	    for (var i:int = 1; i < level; i++) {
                p = vertices[i];
                vision.lineTo(p.x, p.y);
	    }
            p = vertices[0];
            vision.lineTo(p.x, p.y);

            camera.addChild(dialogue);
            dialogue.addChild(dialogueTextBox);
        }

        private var dialogueTimer:Timer;
        public function say(s:String):void
        {
            dialogueTextBox.text = s;
            dialogueTimer = new Timer(1000, 1);
            dialogueTimer.addEventListener("timer", timerHandler);
            dialogueTimer.start();
        }

        public function timerHandler(event:TimerEvent):void {
            dialogueTimer = null;
            dialogueTextBox.text = ".";
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

            m = dialogue.transform.matrix;
            m.tx = camera.rx(position.x);
            m.ty = camera.ry(position.y);
            dialogue.transform.matrix = m;
        }

        public function destroy():void {
            vision.parent.removeChild(vision);
            world.DestroyBody(body);
        }

        public function levelUp():void {
            level++;
            body.DestroyShape(shape);
            attachShape(shapeDef);
        }

        private var charVel:b2Vec2 = new b2Vec2();
        private var charVelAng:Number = 1;

        public function get linearVel():b2Vec2 {
            return body.GetLinearVelocity();
        }
        public function set linearVel(p_linearVel:b2Vec2):void {
            body.SetLinearVelocity(p_linearVel);
        }

        public function get angularVel():Number {
            return body.GetAngularVelocity();
        }
        public function set angularVel(p_angularVel:Number):void {
            body.SetAngularVelocity(p_angularVel);
        }

        public function turnLeft():void {
            logger.debug ("left");
            body.WakeUp();
            linearVel.x -= 1;
            angularVel -= 1;
        }

        public function turnRight():void {
            logger.debug ("right");
            body.WakeUp();
            linearVel.x += 1;
            angularVel += 1;
        }

        public function forward():void {
            logger.debug ("forward");
            body.WakeUp();
            var v:b2Vec2 = new b2Vec2(
                forwardSpeed * Math.cos(body.GetAngle()),
                forwardSpeed * Math.sin(body.GetAngle()));
            linearVel = v;
            angularVel *= 0.8;
        }

        public function backward():void {
            logger.debug ("backward");
            body.WakeUp();
            var v:b2Vec2 = new b2Vec2(
                backwardSpeed * Math.cos(body.GetAngle()),
                backwardSpeed * Math.sin(body.GetAngle()));
            linearVel = v;
            angularVel *= 0.8;
        }

        public function collide(actor:Actor, position:b2Vec2):void {
            var mySprite:Sprite = new Sprite();
            camera.addChild(mySprite);
            //mySprite.graphics.beginFill(0xFFCC00);
            mySprite.graphics.lineStyle(1, 0xffffff);
            mySprite.graphics.drawCircle(0, 0, 32);
            mySprite.x = camera.rx(position.x);
            mySprite.y = camera.ry(position.y);
            var distance:Number = MathUtil.distanceBetweenPoints(body.GetPosition(), position);
            logger.debug(distance);
            say(String(distance));
            Tweener.addTween(mySprite, {scaleX:0.01, scaleY:0.01, alpha:0, time:1,
                    onComplete:function():void{Context.instance.camera.removeChild(mySprite);}
                });
        }
    }
}
