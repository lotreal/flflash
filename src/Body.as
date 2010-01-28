package
{
    import im.luo.logging.Logger;
    
    public class Body {
        private var logger:Logger = Logger.getLogger(this);
        
        public function Body() {
            
        }

		/**
		 * Sets / gets mass of character.
		 */
		public function set mass(value:Number):void
		{
			_mass = value;
		}
		public function get mass():Number
		{
			return _mass;
		}

    }
}
