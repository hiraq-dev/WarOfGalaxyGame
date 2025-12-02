🌌 War Of Galaxy - 2D Space Shooter

A 2D space shooting game developed in Unity where you control a spaceship, destroy asteroids, battle enemy ships, and survive in the endless expanse of space.

🎮 Click the image below to watch the complete gameplay video on Google Drive</p>
<a href="https://drive.google.com/file/d/1hRCEqglyK667mazIrsrAbaCPIQeXv7Oo/view?usp=drive_link" target="_blank">
    <img src="Icon-120.png" alt="War of Galaxy Gameplay" />
</a>
<p>

✨ Features
🚀 Core Gameplay
Smooth Spaceship Controls - Responsive movement using WASD or Arrow keys

Dynamic Combat System - Shoot enemies and destroy asteroids

Score System - Earn points for each enemy destroyed

Health Management - Monitor your spaceship's health

Game Over System - Restart and try for a higher score

🎨 Visuals & Effects
Space Background - Parallax scrolling starfield

Particle Effects - Explosions and engine trails

Sprite Animations - Animated enemies and objects

UI Design - Clean score and health display

⚙️ Technical Implementation
Unity 2D Physics - Collision detection and response

Object Pooling - Optimized performance for bullets and enemies

Modular Architecture - Organized code structure

Audio Management - Sound effects for actions

🎯 How to Play
Start the Game - Run the executable or build from source

Control Your Ship - Use WASD or Arrow keys to move

Shoot Enemies - Press Spacebar to fire bullets

Avoid Damage - Dodge asteroids and enemy fire

Survive - Monitor your health and try to get the highest score

Controls Summary
Action	Keyboard
Move Up	W / ↑
Move Down	S / ↓
Move Left	A / ←
Move Right	D / →
Shoot	Spacebar
Pause	Escape
📁 Project Structure
text
WarOfGalaxyGame/
├── Assets/                          # All game assets
│   ├── Prefabs/                    # Unity prefabs
│   ├── Scripts/                    # C# scripts
│   │   ├── EnemySpawner.cs        # Controls enemy spawning
│   │   ├── Player.cs              # Player controller and health
│   │   ├── Enemy.cs               # Enemy behavior
│   │   ├── Asteroid.cs            # Asteroid movement and destruction
│   │   ├── Bullet.cs              # Bullet behavior
│   │   ├── Explosion.cs           # Explosion effects
│   │   └── GameManager.cs         # Main game controller
│   ├── Scenes/                    # Game scenes
│   │   └── SampleScene.unity      # Main game scene
│   ├── Sprites/                   # 2D artwork
│   └── ...
├── Packages/                       # Unity packages
├── ProjectSettings/               # Unity project settings
├── README.md                      # This file
└── WarOfGalaxyGame.sln           # Visual Studio solution
🛠️ Installation
Option 1: Download Pre-built Game
Coming soon - Check the Releases section for downloadable builds

Option 2: Build from Source
Requirements:

Unity 2022.3.20f1 or compatible version

Git (optional, for cloning)

Steps:

Clone or Download the repository

bash
git clone https://github.com/hiraq-dev/WarOfGalaxyGame.git
or download as ZIP from GitHub

Open in Unity

Launch Unity Hub

Add project from disk

Select the cloned/downloaded folder

Build the Game

Open Assets/Scenes/SampleScene.unity

Go to File > Build Settings

Select your platform (Windows recommended)

Click Build and choose output folder

🔧 Development
Key Scripts Explained
Player.cs
csharp
// Main player controller
// Handles movement, shooting, and health management
// Implements damage handling and game over conditions
EnemySpawner.cs
csharp
// Manages enemy spawning at random intervals
// Controls difficulty progression
// Handles enemy wave patterns
GameManager.cs
csharp
// Central game controller
// Manages score, game state, and UI updates
// Handles game over and restart logic
Adding New Features
Create new C# scripts in Assets/Scripts/

Attach to GameObjects in Unity Editor

Follow existing naming conventions

Test thoroughly before committing

📊 Game Mechanics
Element	Description
Player Health	Starts at 100, decreases when hit
Score	Increases by 10 for each enemy destroyed
Enemies	Spawn randomly, move toward player
Asteroids	Random movement patterns
Bullets	Travel upward, destroy on contact
🤝 Contributing
Contributions are welcome! Here's how you can help:

Fork the repository

Create a feature branch

bash
git checkout -b feature/new-feature
Make your changes

Commit and push

bash
git commit -m "Add new feature"
git push origin feature/new-feature
Create a Pull Request

Suggested Improvements
Add power-up system

Implement different enemy types

Add background music

Create multiple levels

Add particle effects

Implement saving high scores

📝 License
This project is open source and available under the MIT License.

🙏 Acknowledgments
Unity Technologies for the game engine

Free asset creators from the Unity community

Open source contributors for inspiration

Testers for valuable feedback

🐛 Issues and Support
Found a bug or have a feature request? Open an issue!

📞 Contact
GitHub: @hiraq-dev

Repository: WarOfGalaxyGame

<div align="center">
⭐ If you like this project, give it a star! ⭐
"In space, no one can hear you shoot... but they'll see the explosions!" 💥

</div>

Build and upload a Windows executable to Releases section
