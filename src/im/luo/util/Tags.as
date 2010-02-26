package im.luo.util
{
    public class Tags
    {
        public function Tags()
        {
        }
        
        /**
         * 判断两个标签组是否包含同样数量，同样名字的标签 
         * @param tags
         * @return 
         * 
         */        
        public function eq(tags:Tags):Boolean
        {
            if (this.length != tags.length) return false;
            for(var tag:String in dict) {
                if (dict[tag] == 1 && (! tags.has(tag))) return false;
            }
            return true;
        }
        
        public function has(tag:String):Boolean
        {
            return dict.hasOwnProperty(tag) && dict[tag] == 1;
        }
        
        public function clear():Tags
        {
            length = 0;
            dict = new Object();
            return this;
        }
        
        public function add(tag:String):Tags
        {
            length++;
            dict[tag] = 1;
            return this;
        }
        
        public function remove(tag:String):Tags
        {
            length--;
            dict[tag] = 0;
            return this;
        }
        
        public function toString():String {
            var str:String = "";
            for(var tag:String in dict) {
                if (dict[tag] == 1) str += tag + ",";
            }
            return str;
        }

        private var dict:Object = new Object();
        
        public var length:int = 0;
    }
}