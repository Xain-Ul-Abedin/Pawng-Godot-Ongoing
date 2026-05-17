# Pawng Technical Documentation

Pawng is a high-performance, mobile-optimized 2D sports simulation developed using the Godot Engine 4.5. This project serves as a modern implementation of classic paddle-and-ball mechanics, specifically engineered for vertical handheld devices and touch-based interaction.

## Core Technical Specifications

*   **Engine**: Godot 4.5
*   **Renderer**: Forward+ (Mobile)
*   **Language**: GDScript 2.0
*   **Target Resolution**: 720x1280 (Portrait)
*   **Aspect Ratio**: 9:16 with Expand Stretch Mode
*   **Input**: Emulated Touch from Mouse (Point-and-Drag)

## Gameplay Mechanics

### Physics and Collision Detection
The game utilizes a deterministic velocity-based reflection system. The ball is implemented as a `CharacterBody2D`, leveraging `move_and_collide` to handle high-velocity impacts without tunneling.
*   **Velocity Scaling**: Upon every successful collision with a paddle, the ball's velocity magnitude is multiplied by a configurable `speed_multiplier` (default 1.05).
*   **Reflection Logic**: Standard vector reflection is applied using the collision normal: `velocity.bounce(collision.get_normal())`.

### AI Implementation
The single-player opponent employs a heuristic-based tracking algorithm.
*   **Target Acquisition**: The AI identifies the ball's X-coordinate globally.
*   **Movement Smoothing**: Instead of instant snapping, the AI utilizes the `move_toward` function, capped by an `ai_speed` variable, to simulate human-like reaction latency and travel time.
*   **Clamping**: AI movement is constrained within safe screen bounds to prevent clipping into side boundaries.

### State Management and Scene Flow
*   **Global Reset**: When a goal is detected via `Area2D` triggers, the `main.gd` controller invokes a reset sequence.
*   **Tweening System**: The ball uses Godot's `Tween` API to handle the respawn animation, smoothly interpolating the `scale` property from `Vector2.ZERO` to its original dimensions before applying an initial impulse.

## Project Structure

### Scene Tree Hierarchy
*   **Main Menu**: Entry point handling user navigation and mode selection.
*   **Game Arena**: Contains the physics environment, boundaries, and score zones.
*   **Actors**:
    *   `Player`: Versatile node handling both local input (top/bottom) and AI states.
    *   `Ball`: Self-contained physics object with internal speed management.

### Key Scripts
*   `ball.gd`: Logic for speed progression, bounce calculations, and tween-based reset cycles.
*   `player.gd`: Input multiplexer handling `InputEventScreenDrag` for players and target tracking for AI.
*   `main.gd`: Coordinate-based goal placement and scene lifecycle management.

## Deployment and Installation

1.  **Repository Acquisition**:
    ```bash
    git clone https://github.com/Xain-Ul-Abedin/Pawng-Godot-Ongoing.git
    ```
2.  **Environment Setup**: Ensure Godot Engine 4.5 or higher is installed.
3.  **Project Import**: Select the `project.godot` file in the project manager to load the workspace.
4.  **Execution**: Utilize the built-in debugger or export to Android/iOS using the provided presets.

## Assets and Licensing
All graphical assets, including paw-themed sprites and UI components, are located in the `Assets/` directory. These are optimized for the Godot Mobile renderer with appropriate VRAM compression settings.

---
*Documentation maintained by Zain-Ul-Abedin*
