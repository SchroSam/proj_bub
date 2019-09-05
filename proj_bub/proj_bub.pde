/* Main Collaborators:
 Shrod, OlynCoon
 
/*extra library that needed to be imported
 TO RUN THIS WITH PROCESSING YOU NEED TO HAVE THIS LIBRARY DOWNLOADED AND ENABLED OR IT WILL NOT WORK
 
 */

import ddf.minim.*;

//pre-program variables that need to be made global, sound and image files being loaded, intro music being played etc.

//ps. this code person (or some version of him) should totally be me and my partners' mascot/logo/something
//I name her WESL

int score = 0;
float Hx = 30;
float Hy = 30; 
float Vx = 470;
float Vy = 470;
float VSD = 1;
float SD = 3;
int ChangeColl = 0;
int numChangeColl = 0;
float Cx = random(width - 5);
float Cy = random(height - 5);
int GemStet = 0;
PImage skull = null;
PImage greenblob = null;
boolean upPressed = false;
boolean downPressed = false;
boolean rightPressed = false;
boolean leftPressed = false;
boolean rPressed = false;
Minim game;
AudioSample lose = null;
AudioSample coin = null;
AudioSample start = null;
void setup() {
  size (500, 500);
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
  movingBlob();
  HitReg();
  restart();
}

//way to restart without closing INCOMPLETE
void restart() {

  if (keyPressed) {
    if (rPressed) {
      score = 0;
      Hx = 30;
      Hy = 30;
      Vx = 470;
      Vy = 470;
      VSD = 1;
      SD = 3;
      ChangeColl = 0;
      numChangeColl = 0;
      Cx = random(width - 5);
      Cy = random(height - 5);
      GemStet = 0;
      start.trigger();
    }
  }
}

//function to draw/redraw the villain blob (used in the main movement function for the villain blob)
void redraw() {
  if (GemStet == 0) {
    background(255);
    image(greenblob, Vx-15, Vy-15, 30, 30);
    fill(255);
    ellipse(Hx, Hy, 30, 30);
    fill(240, 233, 12);
    ellipse(Cx, Cy, 5, 5);
    fill(0);
    text("Score: " + score, 220, 13);
  }
  if (ChangeColl == 1) {
    background(255);
    Cx = random(width - 5);
    Cy = random(height - 5);
    fill (240, 233, 12);
    ellipse(Cx, Cy, 5, 5);
    fill(0, 170, 80);
    ellipse(Vx, Vy, 30, 30);
    fill(255);
    ellipse(Hx, Hy, 30, 30);
    fill(0);
    text("Score: " + score, 220, 13);
    ChangeColl = 0;
  }
  if (GemStet == 1) {
    background(255);
    image(skull, Hx-15, Hy-15, 30, 30);
    image(greenblob, Vx-15, Vy-15, 30, 30);
    fill(240, 233, 12);
    ellipse(Cx, Cy, 5, 5);
    fill(0);
    text("Score: " + score, 220, 13);
  }
}



void keyPressed() {
  if (keyCode == UP) {
    upPressed = true;
  }
  if (keyCode == DOWN) {
    downPressed = true;
  }
  if (keyCode == LEFT) {
    leftPressed = true;
  }
  if (keyCode == RIGHT) {
    rightPressed = true;
  }
  if (key == 'r') {
    rPressed = true;
  }
}

void keyReleased() {
  if (keyCode == UP) {
    upPressed = false;
  }
  if (keyCode == DOWN) {
    downPressed = false;
  }
  if (keyCode == LEFT) {
    leftPressed = false;
  }
  if (keyCode == RIGHT) {
    rightPressed = false;
  }
  if (key == 'r') {
    rPressed = false;
  }
}

//the programming for the movement of the hero (player) "movingBlob"
void movingBlob() { 
  redraw();
  if (GemStet == 0) {

    if (keyPressed) {
      if (upPressed) {
        redraw();
        Hy -= SD;
      }
      if (downPressed) {
        redraw();
        Hy += SD;
      }
      if (rightPressed) {
        redraw();
        Hx += SD;
      }
      if (leftPressed) {
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

void VmovingBlob() {
  redraw();

  if (Vx < Hx) {
    Vx += VSD;
    redraw();
  }
  if (Vx > Hx) {
    Vx -= VSD;
    redraw();
  }
  if (Vy > Hy) {
    Vy -= VSD;
    redraw();
  }
  if (Vy < Hy) {
    Vy += VSD;
    redraw();
  }
}



//the hero dies
void HitReg() {
  if (GemStet == 0) {
    //hit detection for the player and the enemy
    float dx = Hx - Vx;
    float dy = Hy - Vy;
    //hit detection for player anc coins
    float dcx = Hx - Cx;
    float dcy = Hy - Cy;
    //calculation on player vs enemey
    float distanceHV = sqrt(dx * dx + dy * dy);
    //calculation on player vs coin
    float distanceHC = sqrt(dcx * dcx + dcy * dcy); 
    //good ol' pythatgorous
    if (distanceHV < 15 + 15) {  
      println("U Just Got Game Ended, Score: " + numChangeColl);
      VSD = 0;
      GemStet = 1;
      lose.trigger();
      delay(750);
      VSD = 0.5;
    }
    //hit detection for collecting the change

    if (distanceHC < 15 + 2.5) {
      numChangeColl += 1;
      ChangeColl = 1;
      score += 10;
      println(numChangeColl);
      coin.trigger();
      VSD += 0.1;
      SD += 0.03;
    }
  }
}
