---QuickPawn---
By: EM-Creations

----------------------
General Information:

- Compiled (.amx) files are stored in the amx folder.
- Put your include (.inc) files in the include folder.
- The gamemodes folder includes some pre-existing SAMP gamemodes.
----------------------
Requirements:

* Linux
- JRE 5.0 (latest preferred, OpenJDK is best)
- g++ (sudo apt-get install g++)
- cmake (sudo apt-get install cmake)
- Pawn Compiler (supplied)

* Windows
- JRE 5.0 (latest preferred)
- Pawn Compiler (supplied)
----------------------
Installation:

* Linux (Ubuntu 10.04)
- First, make sure you've installed g++ and cmake!
- Right click on "install-linux-compiler" -> Permissions -> Tick "Allow executing file as program"
- Go to terminal navigate to the QuickPawn directory, type "sudo chmod 700 install-linux-compiler".
- Double click on "install-linux-compiler" and select "Run in Terminal" you may be prompted to enter your password, it should then automatically finish installing the Linux PAWN compiler in /opt/Pawn
- After it has finished you can delete it.
- Now right click on "QuickPawn.jar" -> Permissions -> Tick "Allow executing file as program".
- You should now be able to run QuickPawn using the method below.

* Windows
- Just delete the install-linux-compiler and the Pawn directory (not needed for Windows) then just go straight to Running.
----------------------
Running:

Windows - Double click the QuickPawn.jar file.

Linux - Right click the QuickPawn.jar file, then click "Open With OpenJDK Java 6 Runtime".

Mac - I have no experience of Mac so I don't know how you run it, but I'm sure its easy enough.
----------------------
Known Issues:

* LINUX: You can only put the QuickPawn folder directly under your /home/username/ directory.
----------------------
Notes:

* LINUX: The QuickPawn folder MUST (because of the stupid way the "Current Working Directory" works in Linux) be located in this format /home/yourusername/ for example my QuickPawn files are located under: "/home/edward/QuickPawn". You also MUST keep the folder name as "QuickPawn". If you don't like putting it there you could always create a link to it in another location.

* LINUX: Make a desktop Launcher!
If you want to create a desktop (or menu) launcher for QuickPawn you can do it by just right clicking on your desktop and select create launcher, and in the command box type: java -jar "/QuickPawnPath/QuickPawn.jar" for example mine is: java -jar "/home/edward/QuickPawn/QuickPawn.jar"

* If you delete the default-DO-NOT-DELETE.pwn file, you will not be able to use the New -> SAMP Script button.
However you can edit the file to create your own default template when you make a new SAMP Script.

----------------------
Problems:

If you have any problems please go to www.EM-Creations.info and follow the link to the forums or use Contact Us.

