package
{
    import im.luo.logging.Logger;
    
    public class Screen {
        private var logger:Logger = Logger.getLogger(this);

        private var width:int;
        private var height:int;
        private var transparent:Boolean;
        private var backgroundColor:uint;

        public function Screen() (width:Number, height:Number, transparent:Boolean = true, backgroundColor:uint = 0xFFFFFF):void {
	    this.backgroundColor = backgroundColor;
	    this.transparent = transparent;
	    this.width = width;
	    this.height = height;
	}
    }
}
