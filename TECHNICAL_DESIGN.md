# Pawng Technical Design Document (TDD)

## 1. Introduction
This document provides a comprehensive technical overview of **Pawng**, a 2D sports simulation developed in Godot 4.5. It outlines the architectural decisions, system behaviors, and implementation details for developers and stakeholders.

## 2. System Architecture
Pawng follows a decoupled, composition-based architecture utilizing Godot's Scene Tree and Signal systems.

### 2.1. Principal Nodes
*   **Game Controller (`main.gd`)**: Orchestrates global game state, goal detection, and scene transitions.
*   **Physics Actors (`CharacterBody2D`)**: 
    *   `Ball`: Autonomous projectile with internal physics state.
    *   `Player`: Versatile paddle node supporting local human input and heuristic AI controllers.

### 2.2. Coordinate System
The game utilizes a **Portrait 9:16** aspect ratio (720x1280). 
*   **Viewport**: Fixed width, expandable height logic.
*   **Coordinate Mapping**: Touch inputs are mapped to viewport-local coordinates and clamped to prevent actor clipping at boundaries.

## 3. Core Systems

### 3.1. Physics & Collision Model
The ball utilizes a discrete collision detection method to ensure performance on mobile devices.
*   **Bounce Algorithm**: `v' = reflect(v, n) * m`, where `v` is velocity, `n` is collision normal, and `m` is the speed multiplier.
*   **Speed Progression**: To prevent stalemates, the magnitude of the velocity vector increases by 5% per bounce, bounded by floating-point limits (effectively capped by gameplay duration).

### 3.2. AI Control System
The AI implementation utilizes a proportional tracking algorithm rather than a predictive one to maintain a "fair" challenge level.
*   **Logic Loop**: Performed in `_physics_process` to ensure synchronization with ball movement.
*   **Smoothing**: Uses `move_toward` to simulate a maximum angular/lateral velocity, preventing instantaneous tracking.

### 3.3. Lifecycle & Animation
*   **Reset Sequence**: Triggered by `Area2D` goal zones.
*   **Tween Interpolation**: The ball's `scale` property is animated using a Quadratic Ease-Out curve to provide visual feedback of "respawning" from the center point.

## 4. Scene Structure & Data Flow
1.  **Main Menu** -> Mode Selection (Single/Multi).
2.  **Game Scene** -> Instantiates `Ball` and `Player` nodes.
3.  **Signals**:
    *   `goal_top_body_entered` -> Handled by `main.gd` to update state and reset ball.
    *   `home_btn_pressed` -> Scene transition back to menu.

## 5. Extensibility
The project is designed for modularity:
*   **New Paws**: Assets can be swapped via the `Sprite2D` texture property.
*   **Difficulty Scaling**: The `speed_multiplier` and `ai_speed` are exported variables, allowing for runtime difficulty adjustments.

---
*Author: Zain-Ul-Abedin*
*Date: May 17, 2026*
