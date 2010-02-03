package flf.flatland.scene
{
    import flash.display.DisplayObject;
    import flash.events.*;
    import flash.geom.Rectangle;
    
    import flf.flatland.action.PlayerHotkeyA;
    import flf.flatland.game.Context;
    import flf.flatland.role.Edge;
    import flf.flatland.role.Npc;
    import flf.flatland.role.Player;
    
    import im.luo.actor.IActor;
    import im.luo.logging.Logger;
    import im.luo.scene.ISceneLayer;
    import im.luo.scene.Scene;
    import im.luo.scene.SpriteLayer;
    import im.luo.scene.TileLayer;

    public class PlayScene extends Scene {
        public var player:Player;
        public var npcs:Vector.<Npc>;

        public function PlayScene(rect:Rectangle = null) {
            super(rect);
            npcs = new Vector.<Npc>();
        }

        override public function build():void {
            var context:Context = Context.instance;

            var bgLayer:ISceneLayer = addLayer(new TileLayer());

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

            player = new Player(385, 285);
            player.behaviour = new PlayerHotkeyA(this, player);

            var edge:Edge = new Edge(0, 0);
            addCharacter('edge', edge, mainLayer);

            var npc:Npc;
            var x:Number, y:Number;
            for (var i:int = 0; i < 1; i++) {
                x = Math.random() * rect.width;
                y = Math.random() * rect.height;

                npc = mainLayer.addCharacter(new Npc(x, y));
                npcs.push(npc);
            }

            var debugLayer:ISceneLayer = addLayer(new SpriteLayer());
            debugLayer.add(Context.instance.cache['world_debug_draw']);
            logger.debug(bgLayer.rect);
            logger.debug(mainLayer.rect);
            logger.debug(debugLayer.rect);


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
