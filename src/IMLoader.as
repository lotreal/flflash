// ~/share/flex4sdk/bin/mxmlc -debug=true -static-link-runtime-shared-libraries=true -sp+=/home/lot/workspace/flflash/lib/ -sp+=/home/lot/workspace/flflash/etc/debug/as3/ /home/lot/workspace/flflash/src/IMLoader.as -o /home/lot/workspace/flflash/build/loader.swf
// ~/share/flex4sdk/bin/mxmlc -debug=false -static-link-runtime-shared-libraries=true -sp+=/home/lot/workspace/flflash/lib/ -sp+=/home/lot/workspace/flflash/etc/deploy/as3/ /home/lot/workspace/flflash/src/IMLoader.as -o /home/lot/workspace/flflash/build/loader.swf
package
{
    import br.com.stimuli.loading.BulkLoader;
    import br.com.stimuli.loading.BulkProgressEvent;
    
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.system.Security;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    [SWF(width="750", height="485", backgroundColor="#cccccc", frameRate="30")]
    public class IMLoader extends Sprite {
        private var loader:BulkLoader = new BulkLoader("look-ahead");
        private var label:TextField;
        private var labelText:String = "-";

        [Embed(source="../resource/FL_Show.swf", symbol="LoadMC")]
        private var loadmc:Class;

        private var loading:*;

        public function IMLoader () {
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        public function init(event:Event = null):void {
            configureLabel();
            setLabel(labelText);
            
            loader.add(Settings.domain + "/flf/flf.swf", {id:"flf", weight:100});
            loader.add(Settings.domain + "/flf/resource/FL_Show.swf", {weight:22});
            loader.add(Settings.domain + "/flf/resource/map/map01.png", {weight:8});
            loader.add(Settings.domain + "/flf/resource/map/map02.png", {weight:343});
            loader.add(Settings.domain + "/flf/resource/map/map03.png", {weight:95});
            loader.add(Settings.domain + "/flf/resource/map/map04.png", {weight:73});
            loader.add(Settings.domain + "/flf/resource/map/map05.png", {weight:3});
            loader.addEventListener(BulkLoader.COMPLETE, onAllLoaded);
            loader.addEventListener(BulkLoader.PROGRESS, onAllProgress);
            loader.addEventListener(BulkLoader.ERROR, onAllError);
            loader.start();
        }
        
        public function onAllLoaded(event:BulkProgressEvent):void {
            setLabel(event.toString());
            removeChild(label);
            removeChild(loading);

            loader.removeEventListener(BulkLoader.COMPLETE, this.onAllLoaded);
            loader.removeEventListener(BulkLoader.PROGRESS, this.onAllProgress);
            var clazz:Class = loader.getContent("flf").loaderInfo.applicationDomain.getDefinition("Main") as Class;
            var mc:DisplayObject = new clazz();
            this.addChild(mc);

            loader.removeAll();
            loader.clear();
            
        }
        
        public function onAllProgress(event:BulkProgressEvent):void {
            setLabel(Math.floor(event.weightPercent * 100) + '%');
            (loading.getChildByName("loadMC")).scaleX = event.weightPercent;
        }
        
        public function onAllError(event:ErrorEvent):void {
            setLabel(event.toString());
        }
        
        public function setLabel(str:String):void {
            label.text = str;
        }
        
        private function configureLabel():void {
            var x:int = 72;
            var y:int = 260;

            loading = new loadmc();
            label = loading.getChildByName("txt");
            loading.x = x;
            loading.y = y;

            label.x = x + 72;
            label.y = y;

            addChild(label);
            addChild(loading);
        }
    }
}