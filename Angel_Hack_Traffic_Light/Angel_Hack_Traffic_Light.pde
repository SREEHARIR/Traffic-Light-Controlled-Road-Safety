import processing.net.*;

Client c;
String data;


int startingTime;
int stat = 1;
int prevstat = 0;

int prevSec = 0;
String prevData;

void setup() 
{
  size(700, 550);
  smooth();
  frameRate(0.5);

  PFont font = loadFont("ArialMT-48.vlw");
  textFont(font);
  color(67);

  startingTime = millis();
  
 // rectMode(CORNER);
 // imageMode(CORNER);

 // fill(50); // Colour of traffic light pole/hanger
 // rect(200, 125, width-50, 40); // Position of traffic light pole/hanger

  rectMode(CENTER);
  ellipseMode(CENTER);

 // fill(242, 201, 0); // Traffic light box colour
 // rect(350, 225, 125, 275); // Position of traffic light box

 // drawTrafficLight( 350, 140, 75, color(90, 25, 15) ); // Unlit red stop light
 // drawTrafficLight( 350, 225, 75, color(40, 30, 10) ); // Unlit yellow stop light
 // drawTrafficLight( 350, 310, 75, color(0, 0100, 0) ); // Unlit green stop light

}

void draw() 
{
  background(51);
  fill(90); // Colour of traffic light pole/hanger
  rect(200, 125, width-50, 40); // Position of traffic light pole/hanger
 
  fill(50); // Colour of traffic light pole/hanger
  rect(345,270,150,400);
 
  drawTrafficLight( 350, 140, 75, color(90, 25, 15) ); // Unlit red stop light
  drawTrafficLight( 350, 225, 75, color(40, 30, 10) ); // Unlit yellow stop light
  drawTrafficLight( 350, 310, 75, color(0, 0100, 0) ); // Unlit green stop light

//  drawTimer();
  turnLightOn(stat);
  
  c = new Client(this, "10.0.4.178", 80);
  mpcRequest();
  delay(100);
  println("req...");
  if (c.available() > 0) { // If there's incoming data from the client...
  //wait a sec before trying to read it
  println("available");
  delay(100);
  data = c.readString(); // ...then grab it and print it
  println(data);
  if(data.indexOf("<begin>")!=-1&&data.indexOf("<end>")!=-1)
  {
    data = data.substring(data.indexOf("<begin>")+7,data.indexOf("<end>"));
  } 
  else 
  {
    data = "Invalid data received";
  }
  if(data.equals(prevData) != true)
  {
    //only update stuff if there is anything new
 //   background(50);
 //   text(data, 10, 10);
    delay(10);
    prevData = data;
  }
  if(second()-prevSec>9||(second()<prevSec&&second()>(prevSec-51)))
  {
    //10 seconds elapsed: new request
    //mpcRequest();
    prevSec = second();
    }
  }
}

void mpcRequest()
{
  c.clear();
  c.write("GET /roadsafe/login/get.php?id=1/r/n" ); // Use the HTTP "GET" command to ask for a Web page
  println("HTTP req.");

}

//void drawTimer()
//{
//  int count = 99;
//  fill(10); // color of rectangle
//  rect(345,410,130,90);
//  fill(55, 255, 20); // color of text
//  textAlign(RIGHT);
//  textSize(80);
//  text(count,395,440);
//  
//}

void turnLightOn(int status)
{
  /*
    if (mouseX > 312 && mouseX < 388 && mouseY > 102 && mouseY < 178)
    drawTrafficLight( 350, 140, 75, color(240, 20, 10) ); // Lit red stop light

  else if (mouseX > 312 && mouseX < 388 && mouseY > 187 && mouseY < 263)
    drawTrafficLight( 350, 225, 75, color(225, 250, 5) ); // Lit yellow stop light

  else if (mouseX > 312 && mouseX < 388 && mouseY > 272 && mouseY < 348)
    drawTrafficLight( 350, 310, 75, color(55, 255, 20) ); // Lit green stop light
*/

  if(status == 1)
  {
    if(prevstat == 0)
    {
      drawTrafficLight( 350, 140, 75, color(90, 25, 15) );
      drawTrafficLight( 350, 225, 75, color(225, 250, 5) ); // Lit yellow stop light
      delay(500);
      drawTrafficLight( 350, 225, 75, color(40, 30, 10) );
      drawTrafficLight( 350, 310, 75, color(55, 255, 20) ); // Lit green stop light
    }
  }
  else
  {
    if(prevstat == 1)
    {
      drawTrafficLight( 350, 310, 75, color(0, 0100, 0) );
      drawTrafficLight( 350, 225, 75, color(225, 250, 5) ); // Lit yellow stop light
      delay(500);
      drawTrafficLight( 350, 310, 75, color(55, 255, 20) ); // Lit green stop light
      drawTrafficLight( 350, 140, 75, color(240, 20, 10) );
    }
  }
  prevstat = status;
}



void dela(int interval)
{
  int delstart = millis();
  int delcurr = millis();
  while(delcurr - delstart < interval)
  {
    delcurr = millis();
  }
}

void drawTrafficLight(int x, int y, int sz, color colour) 
{
  
  fill(colour); // color of stop light
  ellipse(x, y, sz, sz); // Position of stop light
}

