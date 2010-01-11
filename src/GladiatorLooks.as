        private var dialogue:Vision = new Vision(camera);
        private var dialogueTextBox:TextField = new TextField();

        private function paint():void {
        }
        
        protected function repaint():void {
            paintBody();
        }


        protected function paintBody():void {
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
