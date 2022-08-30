using Godot;
using System;

public class Player : KinematicBody2D
{
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        GD.Print("asas");
    }



    const int maxJumpHeight = 64*12*3;

    public override void _PhysicsProcess(float delta){


        MoveAndSlide(maxJumpHeight,Vector2.Up);
    }
    

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
