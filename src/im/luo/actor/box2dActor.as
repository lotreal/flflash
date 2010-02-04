package im.luo.actor {
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import flash.geom.*;
    import im.luo.logging.Logger;
    import caurina.transitions.Tweener;
    import im.luo.geom.Vector2D;
    import im.luo.staff.Context;
    import im.luo.sim.IWorld;
    import im.luo.role.RoleAbstract;
    import im.luo.physics.box2d.box2dWorld;
    
    public class box2dActor extends box2dStaticActor implements IActor {
        private var _logger:Logger = Logger.getLogger(this);

        public function box2dActor(role:RoleAbstract):void {
            super(role);
        }
        
        override protected function initBodyDef():void {
            super.initBodyDef();
            bodyDef.type = b2Body.b2_dynamicBody;
        }
    }
}
