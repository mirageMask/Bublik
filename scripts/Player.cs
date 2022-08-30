using Godot;
using System;

public class Player : KinematicBody2D
{
    const int maxJumpHeight = 64 * 12 * 3;

    public Vector2 gravityPerFrame = vector(.0f,10.0f);
    public Vector2 velocityPerFrame = new Vector2();
    public override void _PhysicsProcess(float delta)
    {

        
        velocityPerFrame = MoveAndSlide(velocityPerFrame - gravityPerFrame, Vector2.Up);
    }

    static Vector2 vector(float x,float y){
        return new Vector2(x,-y);
    }
}
