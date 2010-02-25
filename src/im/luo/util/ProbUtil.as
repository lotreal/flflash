package im.luo.util
{
    /**
     * 概率(probability)计算工具 
     */    
    public class ProbUtil
    {
        public function ProbUtil()
        {
        }
        
        /**
         * 计算指定概率是否命中。例如 hit(0.25) => 25% 的几率返回 true.
         * @param percent 百分比
         * @return 如命中则返回真，否则返回假
         * 
         */        
        public static function hit(percent:Number):Boolean
        {
            return (1 - Math.random()) <= percent;
        }
    }
}