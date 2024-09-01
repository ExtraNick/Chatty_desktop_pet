# Chatty desktop pet
A Chatty demonite desktop pet made with Godot Engine 4.3, written in GDScript.

## Functionalities
The desktop pet walks over the taskbar (measured in Windows 11) and can attach to the sides of the screen, or to the top, following them along. <br>
The user can grab the pet with the mouse, and launch it around the screen.<br>
Additionally, the pet can be right-clicked to be petted.

## How it works

### Window
Godot's Window class has many properties that are vital to this desktop pet, if you've seen [This tutorial by geegaz](https://github.com/geegaz/Multiple-Windows-tutorial), then you can probably guess how everything works.

First, a Window is created that matches the desktop pet's Height and Width. <br>
<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/0f539f44-e875-41e6-9d00-bc0e1ef1821f" alt="Window_size">
</p>
You can notice the window is actually larger than the pet's sprite, but that's because Windows 11 has minimum window size. <br>

### Pet's play area
At this point when the window is created, the program reads the screen with current keyboard focus's First pixel (X: 0, Y: 0) at the top left of the screen, and the last pixel of the screen, at the bottom right corner. This becomes the maximum window size used later in determining actions. <br>

The pet then reads the usable screen size (a godot 4 native function) and compares that with the maximum window size. The result is that in Windows 11 at least (and hopefully in other Linux desktop environments, but this is not tested), the program finds if a taskbar is present or not.<br>

### Animations
All of the pet's animations are based off of speed: <br>
- if the pet's speed is 0, it plays the idle animation
- if the pet's velocity is positive relative to its current axis, it plays a walk animation.
- if the pet's velocity is negative relative to it's current axis, it plays a flipped walk animation. <br>
<p align="center">
    <img width="48" src="https://github.com/user-attachments/assets/b7a7b506-0a92-4ae4-a64e-bec12aab9bd8" alt="pet_idle">
</p>

### Pet movement
The pet moves based off of a 5 seconds Timer, which procs an RNG function to decide the pet's next action. It will decide between staying still, moving to the right or to the left based on the current axis it's attached on. <br>
<p align="center">
  <img width="48" src="https://github.com/user-attachments/assets/566f5e44-ee04-4416-9173-e2f156bdb2d4" alt="pet_walk">
</p>
For each pet movement, the Window performs the exact same movement, updateing it's positon based on the pet's position, effectively following it around the screen area.

### Side and top swapping
Once the Window meets either side of the screen, the pet decides between sticking to that window side's Y coordinates or not:<br>
- If the pet decides against sticking, it will start a timer that prevents it against swapping window sides, and moves in the opposite direction. <br>
- If the pet decides to sticking to that side of the screen, its X velocity is nullified, It's Y velocity starts receiving the movement choices and the sprite rotates 90 degrees if on the left side, or -90 degrees (270 degrees) if on the right side. <br>
<p align="center">
  <img width="48" src="https://github.com/user-attachments/assets/b73424da-1335-4beb-b555-78635adc0d46" alt="pet_walk_wall">
</p>
This same decision making applies to the top side of the screen, with the rotation degree being 180 if swapping from the left side, or -180 if swapping from the right side. <br>


### Petting animation
Throughout all of these movement choices, there is a hidden Window following the pet that contains a heart sprite.<br> 
<p align="center">
  <img width="48" src="https://github.com/user-attachments/assets/af83481e-91e1-44aa-b1e7-90363b5dc173" alt="heart_sprite">
</p>
It receives all rotation degrees updates that the main sprite receives, and if the user right clicks the pet, this window becomes visible, its opacity gradually increases, and the sprites rotates 10 degrees back and forth relative to its starting degrees. <br>
<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/5c257182-f1bd-4c0f-820b-c233c68ffb66" alt="heart_sprite_animation">
</p>

### Grabbing, flinging and gravity
The last Functionatility, is the grabbing and flinging mechanic. <br>
If ther left clicks (from now on i will refer to this as simply clicking) the pet, the pet enters a grabbed state: <br>
<p align="center">
  <img width="48" src="https://github.com/user-attachments/assets/662378b5-bbfb-4d5b-b57f-8468dcc8981b" alt="pet_float">
</p> 
While grabbed, the pet cannot perform movement actions, but can stick to the sides or top of the screen. <br>
Additionaly, moving the mouse while the pet is grabbed, will move the pet's position along the mouse's position in the screen (This is relative to a variable True_Position which is calculated from subtracting the maximum screen size from the starting screen size), effectively creating a Window dragging function since the window will follow the pet's position. <br>

As the pet is being dragged by the mouse, an array variable stores the mouse's X positon, and another array variable stores the mouse's Y position. Both of these arrays have a maximum length of 10. <br>
1 second after the pet is dragged, the pet receives the fligable state. This means that once the mouse is released, the "force" of the flinging is released, effectively launching the pet based off of the force's direction. <br>
"Force" is defined comparing the X and Y Coordiantes arrays 10th value, subtracted by the 1st value. <br>

Once the pet is flung with the mouse click release, it receives the flinging state, which slowly reduces the force at which the pet is being flung.  Once the force is zeroed (Specifically the Y axis force), the flinging state receives the falling state, at which point it is subjective to a gradually increasing "gravity force" that eventually will drag the pet to the bottom of the screen (likely the taskbar).

### Play area limits 
The pet cannot fall below a value defined as the pet play area.<br> 
This is important because its a fixed Y axis value and due to the high falling gravity speed, the pet *could* potentially fall through the floor entering a limbo state. <br>
If the pet does fall through the pet play area, it's position and the Window's is reset to pet play area's equivalent Y axis value. <br>


### Miscellaneous
The pet cannot swap screens. If you wish to change the pet's active screen, you have to close the application and re-open it in the desired screen.<br>
The pet's active screen, is based off of the keyboard's active screen at the time the application is started. Note: window's taskbar keyboard activity seems to default to the primary screen. <br>
The Window's click through functionality was possible thanks to [This tutorial made by chewedgum](https://medium.com/@chewedgumah/godot-4-partially-clickthrough-window-with-transparent-background-3de637cdf95b) <br>


## Known Issues
if you have a top and a bottom screen set in Windows 11 settings, the pet will be unable to stick to the top of the bottom screen - This was untested in Linux, and in previous versions of Windows. <br>



