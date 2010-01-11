package
{
    import im.luo.logging.Logger;
    
    public class GladiatorActor extends Actor {
        private var _logger:Logger = Logger.getLogger(this);
        
        public function GladiatorActor() {
            
        }

        private function paint():void {
            vision = camera.observe(this);
            camera.addChild(dialogue);
            dialogue.addChild(dialogueTextBox);
            paintBody();
        }

        protected function paintBody():void {
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


    }
}
