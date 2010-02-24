// ~/share/flex4sdk/bin/mxmlc -debug=true -static-link-runtime-shared-libraries=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=/home/lot/workspace/flflash/lib/ -sp+=/home/lot/workspace/flflash/etc/debug/as3/ /home/lot/workspace/flflash/src/Main.as -o /home/lot/workspace/flflash/build/flf.swf
// ~/share/flex4sdk/bin/mxmlc -debug=false -static-link-runtime-shared-libraries=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=/home/lot/workspace/flflash/lib/ -sp+=/home/lot/workspace/flflash/etc/deploy/as3/ /home/lot/workspace/flflash/src/Main.as -o /home/lot/workspace/flflash/release/flf.swf
package {
    import br.com.stimuli.loading.BulkLoader;
    import com.hexagonstar.util.debug.Debug;

    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    
    import flf.flatland.shooting.PlaySceneSS;
    
    import im.luo.logging.Logger;
    import im.luo.staff.Context;
    import im.luo.util.MathUtil;
    
    [SWF(width="750", height="485", backgroundColor="#999999", frameRate="30")]
    public class Main extends Sprite {
        public function Main() {
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        public function init(event:Event = null):void {
            if (Settings.debug) Debug.monitor(stage, 1000);
            stage.scaleMode = StageScaleMode.NO_SCALE;
            Context.Init(this);
            
            loadAssest();
        }
        
        /**
         * 载入所有资源文件
         */
        protected function loadAssest():void {
            var loader:BulkLoader = Context.instance.loader;
            loader.add(Settings.domain + "/flf/resource/FL_Show.swf", {"id":"res"});
            loader.add(Settings.domain + "/flf/resource/map/map0" + MathUtil.randomIn(1,5) + ".png", {"id":"bg"});
            
            loader.addEventListener(BulkLoader.COMPLETE, onAssestLoadComplete);
            //context.loader.addEventListener(BulkLoader.PROGRESS, onAllProgress);
            //context.loader.addEventListener(BulkLoader.ERROR, onAllError);
            loader.start();
        }
        
        protected function onAssestLoadComplete(e:Event):void 
        {
            _logger.debug('资源加载完成');
            Context.director.play(new PlaySceneSS());
        }
        
        private var _logger:Logger = Logger.getLogger(this);
    }
}