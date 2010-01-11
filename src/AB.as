        private function changeLevel(lv:uint):void {
            if (level != lv) {
                //modelling();
            }
        }

        private var dialogue:Vision = new Vision(camera);
        private var dialogueTextBox:TextField = new TextField();



override


        private function paint():void {
            vision = camera.observe(this);
            camera.addChild(dialogue);
            dialogue.addChild(dialogueTextBox);
            paintBody();
        }
        
        private function repaint():void {
            paintBody();
        }
