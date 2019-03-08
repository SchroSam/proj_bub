/* Main Collaborators:
Shrod, OlynCoon

Policy from Shrod:

Collaborators, please make most of your edits on this repository, and only use processing to test the code, 
don't just Cntrl+A, then Cntrl+V your additional code from processing onto here, it can and will screw up the changes history

*/

/*extra libraries that needed to be imported
TO RUN THIS WITH PROCESSING YOU NEED TO HAVE THESE LIBRARIES DOWNLOADED AND ENABLED OR IT WILL NOT WORK

*/

import ddf.minim.*;



//pre-program variables that need to be made global, sound and image files being loaded, intro music being played etc.

//ps. this code person (or some version of him) should totally be me and my partners' mascot/logo/something

int score = 0;
float Hx = 30;
float Hy = 30; 
float Vx = 470;
float Vy = 470;
float VSD = 1;
int ChangeColl = 0;
int numChangeColl = 0;
float Cx = random(width - 5);
float Cy = random(height - 5);
int GemStet = 0;
PImage skull = null;
PImage greenblob = null;
Minim game;
AudioSample lose = null;
AudioSample coin = null;
AudioSample start = null;
void setup() {
  size (500,500);
  background(255);
  textSize(15);
  greenblob = loadImage("green blob.jpg");
  skull = loadImage("Skull.jpg");
  game = new Minim(this);
  lose = game.loadSample("lose.mp3");
  coin = game.loadSample("coin.wav");
  start = game.loadSample("start.wav");
  start.trigger();
}

void draw() {
  VmovingBlob();
  movingBlob(3);
  HitReg();
}

//function to draw/redraw the villain blob (used in the main movement function for the villain blob)
void redraw(){
  if(GemStet == 0){
    background(255);
    image(greenblob,Vx-15,Vy-15,30,30);
    fill(255);
    ellipse(Hx,Hy,30,30);
    fill(240,233,12);
    ellipse(Cx,Cy,5,5);
    fill(0);
    text("Score: " + score, 220, 13);
   }
    if(ChangeColl == 1){
    background(255);
   Cx = random(width - 5);
   Cy = random(height - 5);
   fill (240,233,12);
   ellipse(Cx,Cy,5,5);
   fill(0,170,80);
   ellipse(Vx,Vy,30,30);
   fill(255);
   ellipse(Hx,Hy,30,30);
   fill(0);
   text("Score: " + score, 220, 13);
   ChangeColl = 0;
  }
  if(GemStet == 1){
    background(255);
    image(skull,Hx-15,Hy-15,30,30);
    image(greenblob, Vx-15,Vy-15,30,30);
    fill(240,233,12);
    ellipse(Cx,Cy,5,5);
    fill(0);
    text("Score: " + score, 220, 13);
    
  }
}


//the programming for the movement of the hero (player) "movingBlob"
void movingBlob(int SD) { 
  redraw();
 if(GemStet == 0){
 
 if(keyPressed) {
   if (keyCode == UP) {
     redraw();
     Hy -= SD;
   }
   if (keyCode == DOWN) {
     redraw();
     Hy += SD;
   }
   if (keyCode == RIGHT) {
    redraw();
    Hx += SD;
   }
   if (keyCode == LEFT) {
    redraw();
    Hx -= SD;
   }
 }
 
  }
    if (Hx>=width) {
    Hx -= 10;
  }
  if (Hx <= 0) {
    Hx += 10;
  }
  if (Hy >= height) {
    Hy -= 10;
  }
  if (Hy <= 0) {
    Hy += 10;
  }
 }

//the programming for the villain blob "VmovingBlob"

void VmovingBlob(){
 redraw();
   
 if(Vx < Hx){
   Vx += VSD;
   redraw();
 }
 if(Vx > Hx){
   Vx -= VSD;
   redraw();
 }
 if(Vy > Hy){
   Vy -= VSD;
   redraw();
 }
 if(Vy < Hy){
   Vy += VSD;
   redraw();
 }
}
 
 

//the hero dies
void HitReg(){
 if(GemStet == 0){
 //hit detection for the player and the enemy
   float dx = Hx - Vx;
   float dy = Hy - Vy;
   float dcx = Hx - Cx;
   float dcy = Hy - Cy;
   float distanceHV = sqrt(dx * dx + dy * dy);
   float distanceHC = sqrt(dcx * dcx + dcy * dcy); 
   //good ol' pythatgorous
   if(distanceHV < 15 + 15){  
   println("U Just Got Game Ended, Score: " + numChangeColl);
   VSD = 0;
   GemStet = 1;
   lose.trigger();
   delay(750);
   VSD = 0.5;
  }
  //hit detection for collecting the change
  
  if(distanceHC < 15 + 2.5){
    numChangeColl += 1;
    ChangeColl = 1;
    score += 10;
    println(numChangeColl);
    coin.trigger();
    VSD += 0.1;
    HSD += 0.03
  }
 }

  }
