package 
{
    import flash.events.*;
    import im.luo.logging.Logger;
    import Box2D.Dynamics.*;
    import Box2D.Dynamics.Contacts.*;
    import Box2D.Common.Math.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import caurina.transitions.Tweener;
    import flash.display.*;
    
    public class ContactListener extends b2ContactListener {
        public var contactStack:Array = new Array();
        
        override public function Add(point:b2ContactPoint):void{
            var actor1:Actor = Actor(point.shape1.GetUserData());
            var actor2:Actor = Actor(point.shape2.GetUserData());
            var separation:Number = point.separation;
            // var penetration:Number = -separation;
            var position:b2Vec2 = point.position.Copy();

            var contactPoint:ContactPoint = new ContactPoint(actor1, actor2, separation, position); 
            if (!findDuplicate(contactPoint)) contactStack.push(contactPoint);
        }

        private function findDuplicate(contactPoint:ContactPoint):Boolean {
            for each(var p:ContactPoint in contactStack) {
                if (p.actor1 == contactPoint.actor1 && p.actor2 == contactPoint.actor2)
                    return true;
            }
            return false;
        }
        private var _logger:Logger = Logger.getLogger(this);
    }
}
