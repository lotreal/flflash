package im.luo.staff {
    import flash.display.*;
    
    import flash.events.*;
    import flash.display.MovieClip;
    import flash.display.StageScaleMode;
    import flash.events.*;
    import Box2D.Dynamics.*;
    
    import at.geoathome.utils.loader.AssetLoader;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flf.*;
    import im.luo.util.*;
    import im.luo.logging.Logger;
    import flf.flatland.game.Director;
    import flf.flatland.game.Director;
    
    public class ContextAbstract {
        public function get width():int {
            return _width;
        }
        public function set width(value:int):void {
            _width = value;
        }
        
        public function get height():int {
            return _height;
        }
        public function set height(value:int):void {
            _height = value;
        }
        
        public var cache:Object = new Object();
        public var logger:Logger = Logger.getLogger(this);
        public var root:DisplayObjectContainer;
        public var stage:Stage;
        
        public var director:Director;
        
        public function get loader():AssetLoader { return _asset_loader; }
        
        public function init(root:DisplayObjectContainer):void {
            this.root = root;
            if(root != null && stage == null && root.stage != null) {
                initStage(root.stage);
            }
        }
        protected function initStage(stage:Stage):void {
            if(this.stage == null) {
                stage.scaleMode = StageScaleMode.NO_SCALE;
                this.stage = stage;
                this.width = stage.stageWidth;
                this.height = stage.stageHeight;

                this.postInitStage();
            }
        }

        protected virtual function postInitStage():void {}

        protected function debug(node:DisplayObject):void {
            logger.debug("============= "+(String(node))+" =============");
            var c:DisplayObjectContainer = node as DisplayObjectContainer;
            if (c) {
                if (c.numChildren > 0 ) {
                    logger.debug("Number of children of "+(String(c))+": " + c.numChildren);
                    for (var i:uint=0;i<c.numChildren;i++) {
                        logger.debug(c.getChildAt(i));
                    }
                    for (var j:uint=0;j<c.numChildren;j++) {
                        debug(c.getChildAt(j));
                    }
                }
            } else {
                logger.debug("DisplayObject(not container): "+(String(node)));
            }
        }
        
        protected var _asset_loader_context:LoaderContext;
        protected var _asset_loader:AssetLoader;
        protected var _width:int = 640;
        protected var _height:int = 480;
    }
}

// SingletonEnforcer
class SingletonEnforcer {}