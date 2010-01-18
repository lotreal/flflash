// ~/share/flex4sdk/bin/mxmlc -debug=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=/home/lot/workspace/flflash/lib/ -static-link-runtime-shared-libraries=true /home/lot/workspace/flflash/lab/BombExample.as

package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    
    import ghostcat.debug.EnabledSWFScreen;
    import ghostcat.display.residual.ResidualScreen;
    import ghostcat.display.transfer.Cataclasm;
    import ghostcat.util.Util;

    [SWF(width="600",height="480",frameRate="60",backgroundColor="0xFFFFFF")]
    /**
    * 爆炸效果
    * @author flashyiyi
    * 
    */
    public class BombExample extends Sprite
    {
	[Embed("p6.jpg")]
	public var c:Class;
	public var s:Cataclasm;
	private var step:int = 1;
	public function BombExample()
	{
	    new EnabledSWFScreen(stage)
	    
            var squareSize:uint = 100;
            var square:Sprite = new Sprite();
            square.graphics.beginFill(0xFF0000, 0.5);
            square.graphics.drawRect(0, 0, squareSize, squareSize);
            square.graphics.beginFill(0x00FF00, 0.5);
            square.graphics.drawRect(200, 0, squareSize, squareSize);
            square.graphics.beginFill(0x0000FF, 0.5);
            square.graphics.drawRect(400, 0, squareSize, squareSize);
            square.graphics.endFill();
            //this.addChild(square);


	    s = new Cataclasm(square);

            var scr:ResidualScreen = new ResidualScreen(600,480);
	    addChild(Util.createObject(scr, {blurSpeed:4,fadeSpeed:0.7,children:[s]}));
	    scr.addChildAt(new c(), 0);
	    stage.addEventListener(MouseEvent.CLICK,clickHandler);
	}
	
	private function clickHandler(event:Event):void
	{
	    if (step == 0)
	    s.createTris();//重置三角形
	    else
	    s.bomb(new Point(mouseX,mouseY));//爆炸
	    
	    step = (++step) % 2;
	}
    }
}