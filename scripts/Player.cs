using Godot;

public class Player : KinematicBody2D
{
    const int FPS = 60;

    [Export] float timeInSeconds = 1.0f;


    const int maxJumpHeight = 64 * 12 * 3;


    public Vector2 _velocityPerFrame;

    public Vector2 velocityPerFrame
    {
        get { return _velocityPerFrame; }
        set { _velocityPerFrame = value.y < 0 ? new Vector2(value.x, 0) : value; }
    }
    public Vector2 gravityPerFrame = vector(.0f, 16.0f);

    public override void _PhysicsProcess(float delta)
    {
        if (Input.IsActionPressed("jump"))

        // velocityPerFrame
        velocityPerFrame = MoveAndSlide(velocityPerFrame - gravityPerFrame, Vector2.Up);
    }

    static Vector2 vector(float x, float y) => new Vector2(x, -y);
}
