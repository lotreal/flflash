            var context:Context = Context.getInstance(stage);
            var scene:Scene = context.addScene(sceneFight);
            {
                scene.init();
                scene.createDoll('player1', 'keyboard1');
            }
            context.changeScene('fight');

            {
                function run
                keyboard.pressed() = 1;
            }
