package im.luo.util
{
    public class Tags
    {
        private var dict:Object = new Object();
        
        public function Tags()
        {
        }
        
        public function has(tag:String):Boolean
        {
            return dict.hasOwnProperty(tag) && dict[tag] == 1;
        }
        
        public function clear():Tags
        {
            dict = new Object();
            return this;
        }
        
        public function add(tag:String):Tags
        {
            dict[tag] = 1;
            return this;
        }
        
        public function remove(tag:String):Tags
        {
            dict[tag] = 0;
            return this;
        }
        
        public function toString():String {
            var str:String = "";
            for(var i:String in dict) {
                if (dict[i] == 1) str += i + ",";
            }
            return str;
        }
    }
}