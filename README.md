# Chatty desktop pet
A Chatty demonite desktop pet made with Godot Engine 4.3, written in GDScript.

## Functionalities
The desktop pet walks over the taskbar (measured in Windows 11) and can attach to the sides of the screen, or to the top, following them along. <br>
The user can grab the pet with the mouse, and launch it around the screen.<br>
Additionally, the pet can be right-clicked to be petted.

## How it works

Godot's Window class has many properties that are vital to this desktop pet, if you've seen [This tutorial by geegaz](https://github.com/geegaz/Multiple-Windows-tutorial), then you can probably guess how everything works.

First, a Window is created that matches the desktop pet's Height and Width. <br> ![Window_container](https://github.com/user-attachments/assets/0f539f44-e875-41e6-9d00-bc0e1ef1821f) <br>
You can notice the window is actually larger than the pet's sprite, but that's because Windows 11 has minimum window size. <br>

At this point when the window is created, the program reads the screen with current keyboard focus's First pixel (X: 0, Y: 0) at the top left of the screen, and the last pixel of the screen, at the bottom right corner. This becomes the maximum window size used later in determining actions. <br>

The pet then reads the usable screen size (a godot 4 native function) and compares that with the maximum window size. The result is that in Windows 11 at least (and hopefully in other Linux desktop environments, but this is not tested), the program finds if a taskbar is present or not.<br>

All of the pet's animations are based off of speed: <br>
- if the pet's speed is 0, it plays the idle animation
- if the pet's velocity is positive relative to its current axis, it plays a walk animation.
- if the pet's velocity is negative relative to it's current axis, it plays a flipped walk animation. <br>

![pet_idle](https://github.com/user-attachments/assets/b7a7b506-0a92-4ae4-a64e-bec12aab9bd8) <br>

The pet moves based off of a 5 seconds Timer, which procs an RNG function to decide the pet's next action. It will decide between staying still, moving to the right or to the left based on the current axis it's attached on. <br>
![pet_move](https://github.com/user-attachments/assets/566f5e44-ee04-4416-9173-e2f156bdb2d4) <br>
For each pet movement, the Window performs the exact same movement, updateing it's positon based on the pet's position, effectively following it around the screen area.

Once the Window meets either side of the screen, the pet decides between sticking to that window side's Y coordinates or not:<br>
- If the pet decides against sticking, it will start a timer that prevents it against swapping window sides, and moves in the opposite direction. <br>
- If the pet decides to sticking to that side of the screen, its X velocity is nullified, It's Y velocity starts receiving the movement choices and the sprite rotates 90 degrees if on the left side, or -90 degrees (270 degrees) if on the right side. <br>
![pet_walk_wall](https://github.com/user-attachments/assets/b73424da-1335-4beb-b555-78635adc0d46) <br>

This same decision making applies to the top side of the screen, with the rotation degree being 180 if swapping from the left side, or -180 of starting on the right side. <br>

Throughout all of these movement choices, there is a hidden Window following the pet that contains a heart sprite.<br> 
![heart_heart](https://github.com/user-attachments/assets/af83481e-91e1-44aa-b1e7-90363b5dc173) <br>

It receives all rotation degrees updates that the main sprite receives, and if the user right clicks the pet, this window becomes visible, its opacity gradually increases, and the sprites rotates 10 degrees back and forth relative to its starting degrees. <br>
![pet_heart](https://github.com/user-attachments/assets/5c257182-f1bd-4c0f-820b-c233c68ffb66) <br>

