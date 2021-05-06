# Selfish Brian
Selfish Brian was a course project for cpsc 599.82 a special topics computer science class centered around retro game development. 
Selfish Brian was completed collaboratively in the 2021 Winter semester.
The following document outlines our project Makefile, tools, paratext, files, subroutines, and contributions.

- [**How To Play**](#how-to-play)
- [**Makefile**](#makefile)
- [**Tools**](#tools)
- [**Paratext**](#paratext)
- [**Files and Subroutines**](#files-and-subroutines)
- [**Contributions**](#contributions)

## How To Play
1. To play click the following link: https://pages.cpsc.ucalgary.ca/~aycock/x/vic20.html
2. Then in the debug command input type "g" and click the "Run" button or enter. If the vic-20 console turns white continue to the next step.
3. Then click the "Load PRG from URL" button.
4. Then copy the link below and paste it into the input field and click the "OK" button or press enter.
```
https://pages.cpsc.ucalgary.ca/~nielson.trung/599.82/final_back_up/game.prg
```
5. After loading the game.prg file wait a few seconds and type "list" in the vic-20 console and enter. Repeat this step until you see "12345 SYS4109" in the console.
6. After you see the "12345 SYS4109" message type "run" in the vic-20 console and press enter.
7. Enjoy the game!

## Makefile
To make the executable prg file configure the DEST and URL variables in Makefile to the desired path location. Then run following commands to compile or to remove the prg files.

compile with:
```sh
make file=game
```
print the URL location:
```sh
make echo
```
remove all prg files:
```sh
make
```

## Tools
The following tools were developed by Ronan and Nielson respectively to assist in our project development. The first link is a web application developed by Ronan used to assist us with level design and programmable characters. The second link is a python script that was developed by Nielson used to convert bitmaps into hex strings used in character_set.asm.
 
- **https://superdaxter.github.io/599.82_content/**
- **https://replit.com/@nielsontrung/binary-image-to-hex-array-converter**
## Paratext
| Cover Art | Manual | Magazine Ad |
| ------ | ------ | ------ |
| ![https://pages.cpsc.ucalgary.ca/~nielson.trung/599.82/paratext.png](https://pages.cpsc.ucalgary.ca/~nielson.trung/599.82/paratext.png "Paratext 1") | ![https://pages.cpsc.ucalgary.ca/~ronan.ranknemish1/599.82/theWorld_Paratext.png](https://pages.cpsc.ucalgary.ca/~ronan.ranknemish1/599.82/theWorld_Paratext.png "Paratext 1") | ![https://pages.cpsc.ucalgary.ca/~alfath.zikir1/599.82/paratext.png](https://pages.cpsc.ucalgary.ca/~alfath.zikir1/599.82/paratext.png "Paratext 1") |
 
## Files and Subroutines
All project files listed below ordered alphabetically. Containing a brief description of each file as well as a listing of essential subroutines in each file. The listing of subroutines are ordered sequentially as they appear in each file the following is an example of the format.
- subroutine
    - description
#### character_set.asm
the following file contains custom character bit maps designed and used in our game
#### collision.asm
Contains subroutines related to collision detection in our game.
The following are a list of all the subroutines in collision.asm
- empty_space_collision
    - used to set SCREEN_CODE macro to an empty space used in collision subroutines
- damage_collision
    - calls spike_collision subroutine which checks if the player is on top of a spike
- update_health
    - subroutine used to update player health after taking damage
- take_damage
    - calls shake_screen subroutine which shakes the screen horizontally, and calls update_health
- spike_collision
    - subroutine used to check if player is on top of a spike
- update_score
    - used to update the score after collecting collectibles
- left_collision
    - used to check the player's left collision with the SCREEN_CODE
- right_collision
    - used to check the player's right collision with the SCREEN_CODE
- collision_true
    - load 1 in accumulator if collision is true
- collision_false
    - load 0 in accumulator if collision is true
- top_collision
    - used to check the player's top collision with the SCREEN_CODE
- bottom_collision
    - used to check the player's bottom collision with the SCREEN_CODE
#### game.asm
Contains subroutines related to player movement and game logic
the following are a list of essential subroutines in game.asm
- game_loop
    - handles the game logic and loop
- game_over
    - ends the game if player health is 0
- gravity
    - updates the players vertical position
- jump
    - handles the main jumping logic of the player
- scan_key
    - loads key press memory location used to determine player input
- reset_key_scan
    - resets keypress memory and keyboard buffer memory locations
- move_left
    - decrement the player's x offset by the value stored in the HORIZONTAL_VELOCITY macro
- player_move_left
    - handles player movement to the left
- move_right increment the player's x offset by the value stored in the HORIZONTAL_VELOCITY macro
- player_move_right
    - handles player movement to the right
#### graphics.asm
Contains subroutines used or related to update screen and colour memory
The following are a list of essential subroutines in graphics.asm
- clear_screen
    - used to store an empty space screen code at every visible location in screen memory clearing the screen
- erase_player
    - erases the player's current position in screen memory
- colour_player
    - colours the player's current position in colour memory
- draw_player_move_left
    - draws the player's moving left sprite at their current position in screen memory
- draw_player_move_right
    - draws the player's moving right sprite at their current position in screen memory
- draw_player_jump
    - determines if player is jumping left or right and calls the respective subroutine 
- draw_player_jump_left
    - draws the player's jumping left sprite at their current position in screen memory
- draw_player_jump_right
    - draws the player's jumping right sprite at their current position in screen memory
- draw_player_fall
    - determines if player is falling left or right and calls the respective subroutine 
- draw_player_fall_left
    - draws the player's falling left sprite at their current position in screen memory
- draw_player_fall_right
    - draws the player's falling right sprite at their current position in screen memory
- erase_player_health
    - erases the player's health in screen memory
- draw_player_health
    - draws the player's health according the value stored in the PLAYER_HEALTH macro
- print_score
    - draws the current score at the top right of the screen with the values stored in SCORE_1 and SCORE_2
- score_add_10
    - used to increment the 10s value place of the score
- draw_x_y
    - the following subroutines are used to draw levels with screen code x for level y
- draw_platform
    - draws and colours the screen code stored in SCREEN_CODE and colour code stored in COLOUR_CODE macro at SCREEN_MEM micro and COLOUR_MEM macro with offset x
 
#### levels.asm
Contains the subroutines used in handling level logic such as loading and drawing levels
the following are a list of essential subroutines in levels.asm
- next_level
    - checks if the player has made it to the next level and loads the next level
- load_level 
    - loads the corresponding level stored in the LEVEL macro
- load_level_x
    - loads level x and calls its corresponding draw_level_x subroutine in graphics.asm
- x_platform
    - these subroutines load and store SCREEN_CODE x and colour y in COLOUR_CODE macros used by draw_level_x to draw the corresponding platforms for the level
- platform_x_y
    - these labels contain the level data which are offsets of each platform used in draw_level_x
#### print_character_set.asm
This file is used to print out our custom programmable character set.
#### screens.asm
screens.asm contains subroutines used to draw different screens ex. title screen, game over screen, and victory screen
The following are a list of all the subroutines in screens.asm
- normal_character_set
    - switches back to 8x8 character size and the normal character set to draw the screens
- shake_screen
    - shakes the screen horizontally used when the player takes damage which is used in collision.asm
- setup_screen
    - clears the screen and loads the text and screen colour used for drawing the title, game over, and victory screens
- title
    - draws the title screen
- gameover
    - draws the game over screen
- victory
    - draws the victory screen
#### sounds.asm
sounds.asm contains subroutines related to sound and music used in our project. Sound and music are played throughout the game loop each loop acts as one duration for NOTE1 NOTE2 and NOTE3.
The following are a list of all the subroutines in game.asm
- play_music
    - plays the corresponding music stored in the MUSIC macro
- play_x_music
    - plays the music corresponding to the game state
- reset_music
    - resets the value stored in the NOTE2 macro which is used as a note iterator for the current music being played
- set_sound
    - stores 195 in the NOTE1 macro which is used by speaker 1 to handle player movement sounds
- update_sound
    - resets the value in the NOTE1 macro 
- x_music
    - labels used to store the notes according to music x
#### utilities.asm
Contains general purpose subroutines used across multiple files
The following are a list of all the subroutines in game.asm
- subtract
    - used to subtract 22 from the value in accumulator used in collision and graphics to check positions above the player's current screen memory location
- timer
    - general purpose busy loop used in multiple files to delay visual and audio subroutines
## Contributions
#### Nielson
- character_set.asm
- collision.asm
- game.asm
- graphics.asm
- levels.asm
- print_character_set.asm
- sound.asm
- utilities.asm
- tool: https://replit.com/@nielsontrung/binary-image-to-hex-array-converter
- paratext: https://pages.cpsc.ucalgary.ca/~nielson.trung/599.82/paratext.png
#### Ronan
- Level creation
- Graphics
- Platform design
- Character set
- https://superdaxter.github.io/599.82_content/ (VIC20 Content Creator)
- manual/guide paratext: http://pages.cpsc.ucalgary.ca/~ronan.ranknemish1/599.82/theWorld_Paratext.png
#### Alfa
- Levels design
- Collision detection
- Graphics
- Movements
- Character set
