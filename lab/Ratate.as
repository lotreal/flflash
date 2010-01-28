// ~/share/flex4sdk/bin/mxmlc -debug=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=/home/lot/workspace/flflash/lib/ -static-link-runtime-shared-libraries=true /home/lot/workspace/flflash/lab/Ratate.as

package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Matrix;

    [SWF(width="600",height="480",frameRate="60",backgroundColor="0xFFFFFF")]

    public class Ratate extends Sprite
    {
	public function Ratate()
	{
            var squareSize:int = 100;
            var square:Sprite = new Sprite();
            square.graphics.beginFill(0xFF0000, 0.5);
            square.graphics.drawRect(-50, -50, squareSize, squareSize);
            square.graphics.beginFill(0x00FF00, 0.5);
            square.graphics.endFill();
            addChild(square);

            var angle:int = 10;
            var angle_in_radians:Number = Math.PI * 2  / 360;

            square.rotation = 0; // If not, matrix starts wrong.
            var rotationMatrix:Matrix = square.transform.matrix;
            rotationMatrix.tx = 300;
            rotationMatrix.ty = 240;
            rotationMatrix.rotate(angle_in_radians * angle);
            square.transform.matrix = rotationMatrix;

	}
    }
}