package im.luo.util
{
    public class MathUtil
    {
        public function MathUtil()
        {
        }
        
        public static function randomIn(min:int, max:int):int {
            return Math.round((max - min) * Math.random() + min);
        }
    }
}