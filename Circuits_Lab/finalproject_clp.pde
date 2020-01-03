float theta1 = 5;
float theta2 = 5;
float deltaTheta1 = 10;
float deltaTheta2 = 10;
int length1 = 100;
float X, Y, x1, y1, x2, y2;
float orginx, orginy;
float R, D1, D2;
float Quadrant;
float BallX = 0;
float BallY = 10;
float XVel = 5;
float YVel = 1;
float RPY = 10;        // Right Paddly Y
float LPY = -50;       // Left Paddle Y
float VLPY = 1;        // left paddle velocity
float LPF = 0.0003;    // left paddly friction
float Score1 = 5;
float Score2 = 6;
float BallW = 20;      // can shrink as time goes on?
float BallH = 20;
float Ballsubtract;     // can be used to subtract from ball width, height, test parameters
int lineFeed = 10;

import processing.serial.*;
Serial myPort;

void setup(){
 size(800,600);
 printArray(Serial.list());
  // Open the port you are using at the rate you want:
myPort = new Serial(this, Serial.list()[3], 9600); 
myPort.bufferUntil(lineFeed);
}

void draw(){
  background(50);
  translate(width/2,height/2);
   BallY = BallY + YVel;
   BallX = BallX + XVel;
   VLPY=VLPY - LPF;       //much to slow
  
  fill(250,250,50);
  stroke(150,150,150);
  ellipse(BallX, BallY, BallW, BallH);
  
if (LPY>BallY){
  LPY = LPY - VLPY;
}

if (LPY<BallY){
  LPY = LPY + VLPY;
}


  RPY = mouseY-400;
  println(mouseY);
  println(LPF);
  rectMode(CENTER);  // Set rectMode to CENTER
  fill(50,150,50);
  stroke(150,150,150);
  rect(380,RPY,20,200);
  
  fill(50,50,150);
  stroke(150,150,150);
  rect(-380,LPY,20,200);


// add up down ball bounce criteria
if (abs(BallY) >= 300){
  YVel=-YVel;
}

// if (BallX >= 375)    // test for right  paddle bounce, tests past paddle
if (abs(BallX-375) < 5) {
    if (abs(RPY-BallY) < 100){  // is right paddle in way?
    XVel = -XVel;
    }
}    // end test for right  paddle bounce
  
// if (BallX <= -375)    // test for left paddle bounce, tests after paddle?
if (abs(BallX+375) < 5){
    if (abs(LPY-BallY) < 100){ // is left paddle in way?
    XVel = -XVel;
    }
}    // end test for left paddle bounce
  
if (BallX >= 400){  // should be a score
   if (abs(RPY-BallY) < 50){  // is paddle in way? (irrelevant here?
    XVel = -XVel;
    }
}   // end test for left paddle bounce
  
if (BallX >=400){
   println("CP GOALLLL"); //write out
   // Send a number 1 out the serial port
   myPort.write(1);
   delay(2500);
BallX = 0;
}  // end if right score
  
if (BallX <=-400){
   println("YOU GOALLLL");//write out
   // Send the value 2 out the serial port
   myPort.write(2); // send info to arduino
   delay(2500);
   BallX = 0;
}   // end if left socre
// send score 1,2 out to arduino 
//changes the orgin to the center of the screen
}
  
void serialEvent(Serial myPort){
  String inString = myPort.readString();
  if ( inString !=null){
    // show the contents of inString in the console window
    println(inString);
  }
}