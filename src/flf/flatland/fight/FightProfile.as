package flf.flatland.fight
{
    import flash.utils.getTimer;
    
    public class FightProfile
    {
        public function FightProfile()
        {
        }
        
        public function toString():String
        {
            return "Kills: " + kills + "\n"
                + "Exp: " + exp + "\n"
                + "Golds: " + golds + "\n"
                + "Best Combos: " + max_combo;  
        }
        

        
        public function evalCombo():void 
        {
            combo++;
            if (combo == 1) 
            {
                lastCombo = getTimer();
            } else {
                var thisHit:int = getTimer();
                if (thisHit - lastCombo <= 10000)
                {
                    lastCombo = thisHit;
                    max_combo = Math.max(max_combo, combo);
                }
                else
                {
                    clearCombo();
                    combo++;
                    lastCombo = getTimer();
                }
            }
        }
        
        public function clearCombo():void 
        {
            combo = 0;
        }
        
        public var kills:int = 0;
        public var exp:int = 0;
        public var golds:int = 0;
        public var max_combo:int = 0;
        
        public var combo:int = 0;
        public var lastCombo:int = 0;
    }
}