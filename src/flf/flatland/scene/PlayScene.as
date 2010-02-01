package flf.flatland.scene
{
    import flash.events.*;
    import flash.display.DisplayObject;
    import im.luo.logging.Logger;
    import flf.flatland.game.PlayerHotkeyA;
    import im.luo.geom.Vector2D;
    import flf.flatland.role.Player;
    import im.luo.game.ISceneLayer;
    import im.luo.game.IActor;
    import im.luo.game.Scene;
    import im.luo.game.SpriteLayer;

    public class PlayScene extends Scene {
        public var player:Player;
        public var npcs:Vector.<IActor>;

        public function PlayScene() {
            super();
            npcs = new Vector.<IActor>();
        }

        override public function build():void {
            var context:Context = Context.instance;

            var bgLayer:ISceneLayer = addLayer(new SpriteLayer());

            var map1:DisplayObject = new (context.loader.getDefinitionOf("Map1"))();
            var map2:DisplayObject = new (context.loader.getDefinitionOf("Map2"))();
            var map3:DisplayObject = new (context.loader.getDefinitionOf("Map3"))();
            var map4:DisplayObject = new (context.loader.getDefinitionOf("Map4"))();
            map2.x = 997;
            map3.y = 600;
            map4.x = 997;
            map4.y = 600;

            bgLayer.add(map1);
            bgLayer.add(map2);
            bgLayer.add(map3);
            bgLayer.add(map4);
            logger.debug("完成游戏场景搭建");
            var mainLayer:ISceneLayer = addLayer(new SpriteLayer());

            //var player:Player = mainLayer.addCharacter(new Player(20, 12));

            player = new Player(20, 12);
            player.behaviour = new PlayerHotkeyA(this, player);

            addCharacter('player', player, mainLayer);

            //var npc:Npc;
            //var x:Number, y:Number;
            //for (var i:int = 0; i < 8; i++) {
            //    x = Math.random() * width / 30;
            //    y = Math.random() * height / 30;

            //    npc = mainLayer.addCharacter(new Npc(x, y));
            //    npcs.push(npc);
            //}

            //logger.debug('建立场景');

	    //var npcForceTimer:Timer = new Timer(200);
	    //npcForceTimer.addEventListener(TimerEvent.TIMER, forceNpc);
            //npcForceTimer.start();
            //forceNpc();
        }

        override public function play():void {
            player.play();
        }

        //public function forceNpc(event:TimerEvent = null):void {
        //    //logger.debug('force npc');
        //    for (var i:int = 0, n:int=npcs.length; i < n; i++) {
        //        var actor:IActor = npcs[i].actor;

        //        var vel:Vector2D = new Vector2D(
        //            (Math.random() - 0.5)*30, (Math.random() - 0.5)*30);
        //        actor.linearVel = vel;
        //        actor.angularVel -= 1;
        //    }
        //}

        //public function shooting(camera:Icamera):void {
        //    camera.follow(player);
        //}

        private var logger:Logger = Logger.getLogger(this);
    }
}
