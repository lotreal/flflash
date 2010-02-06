package flf.flatland.face
{
    import im.luo.face.Face;
    import flf.flatland.role.Prop;
    
    public class PropFace extends Face
    {
        public function PropFace(role:Prop)
        {
            super(role);
            //render.graphics.beginFill(role.color);
            //render.graphics.lineStyle(2, role.color);
            //render.graphics.drawCircle(0, 0, role.radius);
            //render.graphics.endFill();
        }
    }
}