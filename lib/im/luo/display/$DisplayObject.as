package im.luo.display
{
    import im.luo.logging.Logger;
    
    public class $DisplayObject {
        private var logger:Logger = Logger.getLogger(this);
        private var children:Vector.<$Sprite> = new Vector.<$Sprite>;
        
        public function $DisplayObject() {
            
        }

        public function addChild(child:$DisplayObject):$DisplayObject {
            children.push(child);
            return child;
        }

        public function addChildAt(child:$DisplayObject, index:int):$DisplayObject {
	    children.splice(index, 0, child);
            return child;
        }
    }
}
