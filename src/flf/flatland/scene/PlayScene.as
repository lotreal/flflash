package flf.flatland.scene
{
    import flash.display.Bitmap;
    import flash.events.*;
    import flash.geom.Rectangle;
    
    import flf.flatland.action.PlayerHotkeyA;
    import flf.flatland.role.Edge;
    import flf.flatland.role.Npc;
    import flf.flatland.role.Player;
    
    import im.luo.logging.Logger;
    import im.luo.scene.ISceneLayer;
    import im.luo.scene.Scene;
    import im.luo.scene.SpriteLayer;
    import im.luo.scene.TileLayer;

    public class PlayScene extends Scene {
        public var player:Player;
        public var npcs:Vector.<Npc>;

        [Embed(source="../../../../resource/04.png")]
        public var bgImage:Class;

        public function PlayScene(rect:Rectangle = null) {
            super(rect);
            npcs = new Vector.<Npc>();
        }

        override public function build():void {
            var bgLayer:ISceneLayer = new TileLayer();

            //var map1:DisplayObject = new (context.loader.getDefinitionOf("Map1"))();
            //var map2:DisplayObject = new (context.loader.getDefinitionOf("Map2"))();
            //var map3:DisplayObject = new (context.loader.getDefinitionOf("Map3"))();
            //var map4:DisplayObject = new (context.loader.getDefinitionOf("Map4"))();
            //map2.x = 997;
            //map3.y = 600;
            //map4.x = 997;
            //map4.y = 600;
            //bgLayer.add(map1);
            //bgLayer.add(map2);
            //bgLayer.add(map3);
            //bgLayer.add(map4);
            
            var bg:Bitmap = new bgImage();
            bgLayer.add(bg);

            _logger.debug("完成游戏场景搭建");
            var mainLayer:ISceneLayer = new SpriteLayer();

            player = new Player(375, 275);
            player.action = new PlayerHotkeyA(this, player);
            addCharacter('player', player, mainLayer);

            var edge:Edge = new Edge(0, 0);
            addCharacter('edge', edge, mainLayer);

            var npc:Npc;
            var x:Number, y:Number;
            for (var i:int = 0; i < 1; i++) {
                x = Math.random() * rect.width;
                y = Math.random() * rect.height;

                npc = new Npc(x, y);
                addCharacter('npc'+i, npc, mainLayer);
                npcs.push(npc);
            }

            var debugLayer:ISceneLayer = new SpriteLayer();
            debugLayer.add(context.cache['world_debug_draw']);

            var uiLayer:ISceneLayer = new SpriteLayer();
            uiLayer.add(context.cache['ui']);

            addLayer(bgLayer);
            addLayer(mainLayer);
            addLayer(debugLayer);
            addLayer(uiLayer);

            _logger.debug(bgLayer.rect);
            _logger.debug(mainLayer.rect);
            _logger.debug(debugLayer.rect);
        }

        override public function play():void {
            for (var i:int = 0, l:int = roles.length; i < l; i++) {
                roles[i].play();
            }
        }

        private var _logger:Logger = Logger.getLogger(this);
    }
}
