package flf.flatland.scene
{
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.geom.Rectangle;
    
    import flf.flatland.action.PlayerHotkeyA;
    import flf.flatland.action.PlayerHotkeyB;
    import flf.flatland.actor.CreatureActor;
    import flf.flatland.role.Edge;
    import flf.flatland.role.Gold;
    import flf.flatland.role.Heart;
    import flf.flatland.role.Npc;
    import flf.flatland.role.Player;
    
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import im.luo.scene.ISceneLayer;
    import im.luo.scene.Scene;
    import im.luo.scene.SpriteLayer;
    import im.luo.scene.TileLayer;
    import im.luo.util.MathUtil;
    
    public class PlayScene extends Scene {
        public var player:Player;
        public var npcs:Vector.<Npc>;

        //[Embed(source="../../../../resource/04.png")]
        //public var bgImage:Class;

        public function PlayScene(rect:Rectangle = null) {
            super(rect);
            npcs = new Vector.<Npc>();
        }

        override public function build():void {
            var bgLayer:ISceneLayer = new TileLayer();

            var bg:Bitmap = context.loader.getBitmap("bg");
            bgLayer.add(bg);

            var mainLayer:ISceneLayer = new SpriteLayer();

            player = new Player('user', 375, 275, 3);
            player.action = new PlayerHotkeyA(this, player);
            addCharacter('player', player, mainLayer);

            var edge:Edge = new Edge('edge', 0, 0);
            addCharacter('edge', edge, mainLayer);

            var npc:Npc;
            var x:Number, y:Number;

            var npcCount:int = 9;
            var goldCount:int = 9;
            var heartCount:int = 9;

            for (var i:int = 0; i < npcCount; i++) {
                x = Math.random() * rect.width;
                y = Math.random() * rect.height;

                npc = new Npc('npc'+i, x, y);
                addCharacter('npc'+i, npc, mainLayer);
                npcs.push(npc);
            }

            for (var j:int = 0; j < goldCount; j++) {
                x = Math.random() * rect.width;
                y = Math.random() * rect.height;
                
                var gold:Gold = new Gold('gold'+j, x, y);
                addCharacter('gold'+j, gold, mainLayer);
            }
            
            for (var k:int = 0; k < heartCount; k++) {
                x = Math.random() * rect.width;
                y = Math.random() * rect.height;
                
                var heart:Heart = new Heart('heart'+k, x, y);
                addCharacter('heart'+k, heart, mainLayer);
            }

            var debugLayer:ISceneLayer = new SpriteLayer();
            debugLayer.add(context.cache['world_debug_draw']);

            var uiLayer:ISceneLayer = new SpriteLayer();
            uiLayer.add(context.cache['ui']);

            addLayer(bgLayer);
            addLayer(mainLayer);
            addLayer(debugLayer);
            addLayer(uiLayer);
            (player.actor as CreatureActor).seek(new Vector2D(0, 0));
            _logger.debug("完成游戏场景搭建");
        }

        override public function play():void {
            for (var i:int = 0, l:int = roles.length; i < l; i++) {
                roles[i].play();
            }
        }

        private var _logger:Logger = Logger.getLogger(this);
    }
}
