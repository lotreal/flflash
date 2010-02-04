package flf.flatland.game 
{
    import at.geoathome.utils.loader.AssetLoader;
    
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.geom.Rectangle;
    
    import flf.flatland.role.Creature;
    import flf.flatland.scene.PlayScene;
    
    import im.luo.camera.Camera;
    import im.luo.events.TickEvent;
    import im.luo.logging.Logger;
    import im.luo.staff.DirectorAbstract;
    import im.luo.util.KeyCode;
    import im.luo.util.Keyboard;

    public class Director extends DirectorAbstract {
        public var keyboard:Keyboard = Keyboard.instance;
        public var player1:Creature = null;

        public function Director(singleton_enforcer:SingletonEnforcer):void {}

        public static function get instance():Director {
            return Director.getInstance();
        }
        public static function getInstance():Director {
            if (_instance == null) _instance = new Director(new SingletonEnforcer());
            return _instance;
        }

        public function play():void {
            loadAssest();
        }
        
        protected function loadAssest():void {
            context.loader = new AssetLoader("flf-res.swf", context.loaderContext);
            context.loader.addEventListener(Event.COMPLETE, onAssestLoadComplete);
            context.loader.load();
        }
        
        protected function onAssestLoadComplete(e:Event):void 
        {
            _logger.debug('资源加载完成');
            context.stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
            
            scene = new PlayScene(new Rectangle(0, 0, context.width * 2, context.height * 2));
            scene.build();
            
            camera = new Camera(scene);
            action();
            debug(context.root);
        }

        override public function shooting(event:TickEvent):void {
            scene.play();
            camera.follow((scene as PlayScene).player);
            //camera.shooting(scene);
        }
        
        public function handleKeyUp(event:KeyboardEvent):void {
            var c:int  = event.keyCode;
            if(c == KeyCode.N) {
                player1.levelUp();
            }
            
            if(c == KeyCode.M) {
                player1.levelDown();
            }
            
            if(c == KeyCode.SPACEBAR) {
                pcf++;
                pcf = pcf > 1 ? 0 : pcf;
                //if (pcf == 1) player1.behaviour = new S2KBController();
                //else player1.behaviour = new PlayerHotkey();
            }
            
            if(c == KeyCode.D) {
            }
        }


        protected function debug(node:DisplayObject):void {
            _logger.debug("============= "+(String(node))+" =============");
            var c:DisplayObjectContainer = node as DisplayObjectContainer;
            if (c) {
                if (c.numChildren > 0 ) {
                    _logger.debug("Number of children of "+(String(c))+": " + c.numChildren);
                    for (var i:uint=0;i<c.numChildren;i++) {
                        _logger.debug(c.getChildAt(i));
                    }
                    for (var j:uint=0;j<c.numChildren;j++) {
                        debug(c.getChildAt(j));
                    }
                }
            } else {
                _logger.debug("DisplayObject(not container): "+(String(node)));
            }
        }

        private var pcf:int = 0;
        private static var _instance:Director = null;
        private var _logger:Logger = Logger.getLogger(this);

    }
}

// SingletonEnforcer
class SingletonEnforcer {}
