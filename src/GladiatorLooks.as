package
{
    import im.luo.logging.Logger;
    import flash.events.Event;
    import Box2D.Common.Math.b2Vec2;

    public class GladiatorLooks extends Looks {
        private var _logger:Logger = Logger.getLogger(this);

        public function GladiatorLooks(role:Role) {
            super(role);
        }

        override public function paint():void {
            vision = camera.observe(this);
            addEventListener(Event.ENTER_FRAME, update);

            //camera.addChild(dialogue);
            //dialogue.addChild(dialogueTextBox);
            paintBody();
        }

        override public function repaint():void {
            paintBody();
        }

        protected function paintBody():void {
            vision.graphics.clear();
            vision.lineStyle(1, 0x990000, .75);

            var vertices:Vector.<b2Vec2> = GeomUtil.evalPolygonVertices(role.level, role.radius);

            var p:b2Vec2 = vertices[0];
            vision.moveTo(p.x, p.y);
	    for (var i:int = 1; i < level; i++) {
                p = vertices[i];
                vision.lineTo(p.x, p.y);
	    }
            p = vertices[0];
            vision.lineTo(p.x, p.y);
        }

        override public function update(e:Event = null):void {
            var position:b2Vec2 = body.GetPosition();
            var rotation:Number = body.GetAngle();

            vision.rotation = 0; // If not, matrix starts wrong.
            var m:Matrix;
            m = vision.transform.matrix;
            m.rotate(rotation);
            m.tx = camera.rx(position.x);
            m.ty = camera.ry(position.y);

            vision.transform.matrix = m;

            //m = dialogue.transform.matrix;
            //m.tx = camera.rx(position.x);
            //m.ty = camera.ry(position.y);
            //dialogue.transform.matrix = m;
        }
    }
}