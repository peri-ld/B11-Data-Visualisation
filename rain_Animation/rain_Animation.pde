/*
  Code done by Chantel 
*/

//// libraries
import beads.*;
import controlP5.*;

//// variables for all
int dayNumber = 0;

//// rain variables
Table rainDataTable;
Rain rain;
Rain[] rainDrops = new Rain[250];

//// wind direction variables
Table windDirectionTable;
WindDirection windDir;

//// sun variables
Table uvaRadiationTable;
SunIcon sun;

//// cloud variables
PImage cloud;
CloudIcon rainCloud;
CloudIcon[] cloudDrops = new CloudIcon[10];

//// background colour
color backgroundColour = color(250, 198, 174); // this changes from a seperate method when day is hovered over, not in this file currently


//// Sounds
AudioContext ac;

//// rain sounds
SamplePlayer rainPlayer;
Gain rainGain;
float gainLevel = 0;

//// wind direction + speed sounds
SamplePlayer windPlayer;
Panner windPanner;
Gain windGain;

void setup(){
  size(1100, 700);
  rainDataTable      = loadTable("data/RainAverage.csv", "csv");
  windDirectionTable = loadTable("data/windDirectionAverage.csv", "csv");
  uvaRadiationTable  = loadTable("data/uvaRadiationAverage.csv", "csv");

  rain    = new Rain();
  windDir = new WindDirection();
  sun     = new SunIcon();
  
  cloud = loadImage("cloud.png");
  rainCloud = new CloudIcon();
      
  for (int i = 0; i < rainDrops.length; i++) {
    rainDrops[i] = new Rain();
  }
  
  for (int i = 0; i < cloudDrops.length; i++) {
    cloudDrops[i] = new CloudIcon();
  }
  
  ac = AudioContext.getDefaultContext();
  
  String rainAudioFileName = "/Users/chantelmills/Documents/GitHub/B11-Data-Visualisation/rain_Animation/sounds/raining.mp3";
  rainPlayer = new SamplePlayer(ac, SampleManager.sample(rainAudioFileName));
  rainPlayer.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  rainGain = new Gain(ac, 2, 0);
  rainGain.addInput(rainPlayer);
  ac.out.addInput(rainGain);
  
  // wind sounds here
  String windAudioFileName = "/Users/chantelmills/Documents/GitHub/B11-Data-Visualisation/rain_Animation/sounds/the_wind.mp3";
  windPlayer = new SamplePlayer(ac, SampleManager.sample(windAudioFileName));
  windPlayer.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  windGain = new Gain(ac, 1, 0);
  windGain.addInput(windPlayer);
  windPanner = new Panner(ac, 0);
  windPanner.addInput(windGain);
  ac.out.addInput(windPanner);
  
  ac.start();
}

void draw() {
  //background(backgroundColour, 150);
  fill(backgroundColour, 150);
  rect(-1, -1, width + 1, height + 1);
  
  println("Rain Number (Day of Month): " + dayNumber);
  println("Rain Average: " + rain.avgForDay());
  println(" ");
  
  float rainAvg = rain.avgForDay();
  float rainLimit = 0;
  rainGain.setGain(rainAvg / 2); // bases the gain from the average rain for the selected day
  
  if (rainAvg == 0) {
    rainLimit = 0;
  }
  else if (rainAvg > 4.5) {
    // display all
    rainLimit = rainDrops.length;
  }
  else if (rainAvg <= 4.5 && rainAvg > 3.5) {
    rainLimit = 200;
  }
  else if (rainAvg <= 3.5 && rainAvg > 2.5) {
    rainLimit = 150;
  }
  else if (rainAvg <= 2.5 && rainAvg > 1.5) {
    rainLimit = 100;
  }
  else if (rainAvg <= 1.5 && rainAvg > 0.5) {
    rainLimit = 50;
  }
  else if (rainAvg <= 0.5) {
    rainLimit = 25;
  }
  
  for (int i = 0; i < rainLimit; i++) {
    rainDrops[i].rainDrop();
  }
  
  float windDirAvg = windDir.avgForDay();
  
  println("Wind Number (Day of Month): " + dayNumber);
  println("WindDir Average: " + windDirAvg);
  println(" ");
  
  if (windDirAvg == 0) {
    windGain.setGain(0);
    windPanner.setPos(0);
  }
  else if (windDirAvg <= 151) {
    // full right panner
    windPanner.setPos(1);
    windGain.setGain(0.75);
  }
  else if (windDirAvg <= 155 && windDirAvg > 151) {
    windPanner.setPos(0.75);
    windGain.setGain(0.75);
  }
  else if (windDirAvg <= 159 && windDirAvg > 155) {
    windPanner.setPos(0.5);
    windGain.setGain(0.75);
  }
  else if (windDirAvg <= 163 && windDirAvg > 159) {
    windPanner.setPos(0.25);
    windGain.setGain(0.75);
  }
  else if (windDirAvg < 170 && windDirAvg > 163) { 
    // center panner
    windPanner.setPos(0);
    windGain.setGain(0.75);
  }
  else if (windDirAvg >= 170 && windDirAvg < 174) {
    windPanner.setPos(-0.25);
    windGain.setGain(0.75);
  }
  else if (windDirAvg >= 174 && windDirAvg < 178) {
    windPanner.setPos(-0.5);
    windGain.setGain(0.75);
  }
  else if (windDirAvg >= 178 && windDirAvg < 182) {
    windPanner.setPos(-0.75);
    windGain.setGain(0.75);
  }
  else if (windDirAvg >= 182) {
    // full left panner
    windPanner.setPos(-1);
    windGain.setGain(0.75);
  }
  
  // sun icon goes here
  println("UVARad Number (Day of Month): " + dayNumber);
  println("UVARad Average: " + sun.avgForDay());
  println(" ");
  
  //if (sun.avgForDay() > 0) {
    sun.drawSun();
  //}
  
  
  // rain cloud icon (to appear over sun when raining)
  if (rain.avgForDay() > 0) {
    // draw rain cloud
    rainCloud.drawRainCloud();
    rainCloud.drawRainDrop();
    rainCloud.updateDropLocation();
    
    for (int i = 0; i < cloudDrops.length; i++) {
      cloudDrops[i].drawRainDrop();
      cloudDrops[i].updateDropLocation();
      cloudDrops[i].drawRainCloud();
    }    
  }
  
  windDir.drawWind();
  
} // end draw

// ** THIS NEEDS TO BE CHANGED SINCE IT RELIES ON KEY PRESSES NOT THE HOVER //**//
  //** HOVER FUNCTION TO BE MADE LATER //**//
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      if (dayNumber != 1) {
        dayNumber--;
        rain.updateDay(dayNumber);
        windDir.updateWindDirectionDay(dayNumber);
        sun.updateDay(dayNumber);
      }
    }
    else if (keyCode == RIGHT) {
      if (dayNumber != 31) {
        dayNumber++;
        rain.updateDay(dayNumber);    
        windDir.updateWindDirectionDay(dayNumber);
        sun.updateDay(dayNumber);
      }
    }
  }
} // end keyPressed
// ** THIS ^^ NEEDS TO BE CHANGED SINCE IT RELIES ON KEY PRESSES NOT THE HOVER //**//
  //** HOVER FUNCTION TO BE MADE LATER //**//
