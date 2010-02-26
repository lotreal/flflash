package im.luo.role
{
    import flash.display.DisplayObjectContainer;
    import flash.events.IEventDispatcher;
    import flash.geom.Rectangle;
    
    import im.luo.actor.IActor;
    import im.luo.face.Face;
    import im.luo.geom.Vector2D;
    import im.luo.scene.IScene;
    import im.luo.scene.ISceneLayer;
    import im.luo.util.Tags;

    public interface IRole extends IEventDispatcher {
        // 角色的唯一标识
        function get uuid():int;
        function set uuid(value:int):void;
        // 角色名
        function get name():String;
        function set name(value:String):void;
        // 角色分组，同一个角色可以用多个分组
        function get groups():Tags;
        function set groups(value:Tags):void;
        // 角色状态
        function get state():Tags;
        function set state(value:Tags):void;
        
        // 扮演角色的演员，演员可能调用物理引擎等
        function get actor():IActor;
        function set actor(value:IActor):void;

        // 角色当前所在场景
        function get scene():IScene;
        function set scene(value:IScene):void;
        
        // 角色当前位于场景的那个层
        function get sceneLayer():ISceneLayer;
        function set sceneLayer(value:ISceneLayer):void;

        // 角色造型
        function get face():Face;
        // 角色在场景上的位置（屏幕坐标）
        function get position():Vector2D;
        function set position(value:Vector2D):void;
        // 角色半径
        function get radius():Number;
        
        // 标识角色是否在场景上
        //function get onScene():Boolean;
        // 使角色离开当前场景
        //function outScene():void;
        
        // 使角色进行表演动作
        function play():void;
        // 彻底删除这个角色
        function destroy():void;

        // 在开始拍摄之前执行的行为
        function preShoot(container:DisplayObjectContainer, rectangle:Rectangle):void;
        // 在拍摄中执行的行为
        function shooting(container:DisplayObjectContainer, rectangle:Rectangle):void;
        // 在结束拍摄之后执行的行为
        function postShoot(container:DisplayObjectContainer, rectangle:Rectangle):void;
    }
}