/* SamuelS
   11/16/18
   Project bubby (that's my super cool development name)
   
   
   PLEASE NOTE YOU WILL NEED THE ADDITIONAL USER CREATED "MINIM" 
   SOUND LIBRARY TO RUN THIS CODE 
*/
//import processing.sound.*;
import ddf.minim.*;

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
Minim game;
AudioSample lose = null;
AudioSample coin = null;
AudioSample start = null;
void setup() {
  size (500,500);
  background(255);
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
  Change();
}

void drawBlobH(){
  if(GemStet == 0){
  fill(255);
  background(255);
  ellipse(Hx,Hy,30,30);
  fill(0,170,80);
  ellipse(Vx,Vy,30,30);
  fill(240,233,12);
  ellipse(Cx,Cy,5,5);
  }
}

void drawBlobV(){
  if(GemStet == 0){
    fill(0,170,80);
    background(255);
    ellipse(Vx,Vy,30,30);
    fill(255);
    ellipse(Hx,Hy,30,30);
    fill(240,233,12);
    ellipse(Cx,Cy,5,5);
  }
  if(GemStet == 1){
    fill(0,170,80);
    background(255);
    image(skull,Hx-15,Hy-15,30,30);
    ellipse(Vx,Vy,30,30);
    fill(240,233,12);
    ellipse(Cx,Cy,5,5);
    
  }
}


//thus begins the tale of "mobingBlob"
void movingBlob(int SD) { 
  drawBlobH();
 if(GemStet == 0){
 
 if(keyPressed) {
   if (keyCode == UP) {
     drawBlobH();
     Hy -= SD;
   }
   if (keyCode == DOWN) {
     drawBlobH();
     Hy += SD;
   }
   if (keyCode == RIGHT) {
    drawBlobH();
    Hx += SD;
   }
   if (keyCode == LEFT) {
    drawBlobH();
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

//thus marks the end of "movingBlob" the hero of our story (and begins the villain story oWo)

void VmovingBlob(){
 drawBlobV();
   
 if(Vx < Hx){
   Vx += VSD;
   drawBlobV();
 }
 if(Vx > Hx){
   Vx -= VSD;
   drawBlobV();
 }
 if(Vy > Hy){
   Vy -= VSD;
   drawBlobV();
 }
 if(Vy < Hy){
   Vy += VSD;
   drawBlobV();
 }
}
 
 

//oof hero boi died er- the hero of our story has fallen
void HitReg(){
 if(GemStet == 0){
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
  if(distanceHC < 15 + 2.5){
    numChangeColl += 1;
    ChangeColl = 1;
    println(numChangeColl);
    coin.trigger();
    VSD += 0.1;
  }
 }
}

//there's a lot of change on the ground while your running for your life
void Change(){
  if(GemStet == 0){
  if(ChangeColl == 0){
    background(255);
  fill(240,233,12);
  ellipse(Cx,Cy,5,5);
  fill(0,170,80);
  ellipse(Vx,Vy,30,30);
  fill(255);
  ellipse(Hx,Hy,30,30);
  }
  else if(ChangeColl == 1){
    background(255);
   Cx = random(width - 5);
   Cy = random(height - 5);
   fill (240,233,12);
   ellipse(Cx,Cy,5,5);
   fill(0,170,80);
   ellipse(Vx,Vy,30,30);
   fill(255);
   ellipse(Hx,Hy,30,30);
   ChangeColl = 0;
  }
  if(GemStet == 1){
    background(255);
    fill(240,233,12);
    ellipse(Cx,Cy,5,5);
    image(skull,Hx-15,Hy-15,30,30);
    fill(0,170,80);
    ellipse(Vx,Vy,30,30);
    
  }
  }
}
