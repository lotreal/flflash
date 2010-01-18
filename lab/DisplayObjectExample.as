package {
    import flash.display.Sprite;

    public class DisplayObjectExample extends Sprite {
        public function DisplayObjectExample() {
            var child:CustomDisplayObject = new CustomDisplayObject();
            addChild(child);
        }
    }
}

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.*;

class CustomDisplayObject extends Sprite {
    private var bgColor:uint = 0xFFCC00;
    private var size:uint    = 80;

    public function CustomDisplayObject() {
        draw();
        addEventListener(Event.ADDED, addedHandler);
        addEventListener(Event.ADDED_TO_STAGE, asHandler);
        addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        addEventListener(Event.REMOVED, removedHandler);
        addEventListener(MouseEvent.CLICK, clickHandler);
        addEventListener(Event.RENDER, renderHandler);
    }

    private function draw():void {
        graphics.beginFill(bgColor);
        graphics.drawRect(0, 0, size, size);
        graphics.endFill();
    }

    private function clickHandler(event:MouseEvent):void {
        trace("clickHandler: " + event);
        parent.removeChild(this);
    }

    private function addedHandler(event:Event):void {
        trace("addedHandler: " + event);
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        stage.addEventListener("resize", resizeHandler);
    }

    private function asHandler(event:Event):void {
        trace("asHandler: " + event);
    }

    private function enterFrameHandler(event:Event):void {
        trace("enterFrameHandler: " + event);
        removeEventListener("enterFrame", enterFrameHandler);
    }

    private function removedHandler(event:Event):void {
        trace("removedHandler: " + event);
        stage.removeEventListener("resize", resizeHandler);
    }

    private function renderHandler(event:Event):void {
        trace("renderHandler: " + event);
    }

    private function resizeHandler(event:Event):void {
        trace("resizeHandler: " + event);
    }
}