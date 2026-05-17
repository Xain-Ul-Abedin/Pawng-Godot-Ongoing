# Contributing to Pawng

Thank you for your interest in contributing to Pawng. To maintain high code quality and consistency, please adhere to the following professional guidelines.

## Development Standards

### 1. Code Style (GDScript 2.0)
- **Static Typing**: All variables, function parameters, and return types must be explicitly typed.
- **Documentation Strings**: Use `##` (double hash) for class and member documentation to support Godot's built-in doc generation.
- **PascalCase** for Classes/Scenes, **snake_case** for variables and functions.
- **Private Members**: Prefix with an underscore `_` if they are not intended for external access.

### 2. Scene Organization
- Keep scenes modular. Extract complex components into separate `.tscn` files.
- Use `Unique Name` access (`%NodeName`) sparingly; prefer explicit `@onready` path references for stability.

### 3. Asset Pipeline
- **Textures**: Use `.png` or `.svg`. Ensure VRAM compression is set to `Mobile` for target devices.
- **Scripts**: Always attach scripts to the root node of the scene unless there is a specific architectural reason not to.

## Workflow

1.  **Branching**: Create a feature branch from `main`.
    ```bash
    git checkout -b feature/your-feature-name
    ```
2.  **Commits**: Use descriptive, imperative commit messages (e.g., "Implement dynamic paddle scaling").
3.  **Testing**: Verify changes in the Godot editor using both the `Forward+` and `Mobile` renderers to ensure cross-platform compatibility.

## Licensing
By contributing to this project, you agree that your contributions will be licensed under the same terms as the project itself.

---
*Maintained by Zain-Ul-Abedin*
