<<<<<<< HEAD
# CSCI 466 PA3 - Networked Client Server

## Instructions


Complete the following assignment individually.
Submit your work on D2L into the "Programming Assignment 3" folder. 


## Learning Objectives

In this programming assignment you will:

- Implement a Socket class for networked communications and Google Mock testing
- Modify your Client and Server implementations to transmit shots and results over the network, rather than through
 files on disk
- Alternate the processing of shots from each player using threads and semaphores


## Overview


Your objective is to extend your implementation of the 
[Battleship](https://en.wikipedia.org/wiki/Battleship_\(game\)) 
to transmit shot and result messages over the network.
To do so you will implement the `Socket` class that wraps TCP sockets into objects that send data, check if data on
 the socket is available, and receive data.
The advantage of using a separate `Socket` class is that we can also mock it in `tests.cpp`.

To complete this assignment you will extend your current implementation of Battleship.
You will extend your `Client` and `Server` classes to use your implementation of sockets.
I have also provided you with an updated `client_main.cpp` and `server_main.cpp` that uses the new socket class and
 also controls the processing of shots from the players using threads and semaphores.
The `server_main.cpp` sets up two semaphores and runs two `run_server` threads to process shots from each player.
You should modify the `Server.process_shot` function such that the two `run_server` threads alternate the processing of
 shots from each player.
 
I have also modified the tests to used the Google Mock framework, which allows the testing of functions without
 actually opening TCP sockets.


## Program Invocation

To play Battleship you should first start the server by running the `run-server` executable.
Then start the player clients by running two instances of the `run-client` executable.
Unfortunately, the client and server executables will not do anything interesting until you implement `Client.cpp` 
and `Server.cpp`.
As you progress in these implementations, your code will pass more and more tests in `tests.cpp`.
When your code passes all the tests, you will be able to run the client and server executables to play the game.


## What to Submit

Submit your work on D2L into the "Programming Assignment 3" folder. 

* A text file containing a link to a GitHub repository with your solution for the base assignment.
Please not that your repository should be private, so that other students cannot see your solutions.
You can create an unlimited number of private repositories by upgrading your github account to the pro version for
 free using the [academic discount](https://help.github.com/en/github/teaching-and-learning-with-github-education/applying-for-an-educator-or-researcher-discount) with your school email.
In order for us to be able to see your solution, please add github users `cooperstrahan` and `mwittie` as
 collaborators through repository settings.
 
* A link to a YouTube video showing that your program forces the players to take alternate shots. In other words, the
 same client should not be able to make two shots in a row.


## Grading 

We will grade your submissions based on how many test cases in `tests.cpp` your solution passes.
You will also receive points based on whether your program forces the players to take alternating shots.

As in PA2, you have the opportunity to get working the tests that didn't work in the previous assignments to earn
 credit for those.



=======
# CSCI 466 PA2 - Bit Board Storage

## Instructions


Complete the following assignment individually.
Submit your work on D2L into the "Programming Assignment 2" folder. 


## Learning Objectives

In this programming assignment you will:

- Implement a class to store the setup board as bits. The core functionality of your class will be implemented in the
 Netwide Assembler (NASM).


## Overview

Your objective is to extend your basic implementation of the 
[Battleship](https://en.wikipedia.org/wiki/Battleship_\(game\)) 
game to store the player setup boards in two dimensional bit arrays.
The core of the idea is that the `Server` reads in the player setup boards and instead of referencing the file to
 evaluate each shot, it saves the board in internal memory.
You might wonder why not store the board in a two dimensional vector?
Well, since all we want to store is whether a ship is present in a given position, using a vector, even just of bytes, still uses 8 bits for every ship position. 
We want to get this down to one bit.
Of course you could use something like an array of [bitsets](http://www.cplusplus.com/reference/bitset/bitset/), but
 you can save even more memory by implementing a two dimensional bit storage yourself in assembly.
For very large data sets, or on very memory-constrained devices, every bit counts!

To complete this assignment you will extend your current implementation of Battleship.
I have added some functions that you'll need to implement, but most of your `Server` code should carry over. 
Your `Client` code will remain unchanged.
I have also added a few tests to check the new functionality, while keeping all the old tests in tact.
So, if you have those working, great! 
If not, you can earn back some points by getting your code to pass the tests you missed in PA1.


## Program Invocation

To play Battleship you should first start the server by running the `run-server` executable.
Then start the player clients by running two instances of the `run-client` executable.
Unfortunately, the client and server executables will not do anything interesting until you implement `Client.cpp` 
and `Server.cpp`.
As you progress in these implementations, your code will pass more and more tests in `tests.cpp`.
When your code passes all the tests, you will be able to run the client and server executables to play the game.


## Bonus 

I will award __one bonus point__ for each of the following:  

* Server sends a different result when a ship is sunk. The client implementation notifies the player when they sink a
 ship (implementation and tests). 
 This will require you to store more than 1 bit in the setup board array - you will also need to store ship type.


## What to Submit

Submit your work on D2L into the "Programming Assignment 2" folder. 

* A text file containing a link to a GitHub repository with your solution for the base assignment.
Please not that your repository should be private, so that other students cannot see your solutions.
You can create an unlimited number of private repositories by upgrading your github account to the pro version for
 free using the [academic discount](https://help.github.com/en/github/teaching-and-learning-with-github-education/applying-for-an-educator-or-researcher-discount) with your school email.
In order for us to be able to see your solution, please add github users `cooperstrahan` and `mwittie` as
 collaborators through repository settings.

* If you implement the bonus solution, please submit a YouTube video of your implementation. 
Be sure to show the tests you have written as well as your assembly code.


## Grading 

We will grade your submissions based on how many test cases in `tests.cpp` your solution passes.



>>>>>>> PA2_Bit_Board_Storage
