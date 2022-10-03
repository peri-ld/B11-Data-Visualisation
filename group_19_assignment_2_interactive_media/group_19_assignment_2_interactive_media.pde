
/*
  Code for Group 19 - 32027 31080 Interactive Media - Spring 2022
*/

// libraries
import beads.*;
import controlP5.*;
import java.text.DecimalFormat;

//// variables
int dayNumber = 0; // this is what day is being hovered over, 0 == not hovered over anything
color backgroundColour = color(255, 173, 49);
DecimalFormat df = new DecimalFormat("##.000"); // converts in input value to 3 decimal places


Calendar calendar;

Rain rain;
Rain[] rainDrops = new Rain[250];

UVARadiation sun;

CloudIcon rainCloud;
CloudIcon[] cloudDrops = new CloudIcon[15];

WindDirection windDir;

TempGraph tempGraph;

// Tables
Table windDirectionTable;
Table uvaRadiationTable;
Table rainDataTable;
Table airTemperatureTable;
Table windSpeedTable;

// sounds
AudioContext ac;

SamplePlayer rainPlayer;
Gain rainGain;
float gainLevel = 0;

SamplePlayer windPlayer;
Panner windPanner;
Gain windGain;

void setup() {
  size(1000, 650);
  
  // initalise tables
  rainDataTable       = loadTable("data/RainAverage.csv", "csv");
  windDirectionTable  = loadTable("data/windDirectionAverage.csv", "csv");
  uvaRadiationTable   = loadTable("data/uvaRadiationAverage.csv", "csv");
  airTemperatureTable = loadTable("data/AirTemperatureAverage.csv", "csv");
  windSpeedTable      = loadTable("data/windSpeedAverage.csv", "csv");
  
  // initalise classes
  calendar  = new Calendar();
  sun       = new UVARadiation();
  windDir   = new WindDirection();
  rain      = new Rain();
  rainCloud = new CloudIcon();
  tempGraph = new TempGraph();
  
  for (int i = 0; i < rainDrops.length; i++) {
    rainDrops[i] = new Rain();
  }
  
  for (int i = 0; i < cloudDrops.length; i++) {
    cloudDrops[i] = new CloudIcon();
  }
  
  // sound
  ac = AudioContext.getDefaultContext();
  
  String rainAudioFileName = "/Users/chantelmills/Documents/GitHub/B11-Data-Visualisation/group_19_assignment_2_interactive_media/sounds/raining.mp3";
  rainPlayer = new SamplePlayer(ac, SampleManager.sample(rainAudioFileName));
  rainPlayer.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  rainGain = new Gain(ac, 2, 0);
  rainGain.addInput(rainPlayer);
  ac.out.addInput(rainGain);
  
  String windAudioFileName = "/Users/chantelmills/Documents/GitHub/B11-Data-Visualisation/group_19_assignment_2_interactive_media/sounds/the_wind.mp3";
  windPlayer = new SamplePlayer(ac, SampleManager.sample(windAudioFileName));
  windPlayer.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  windGain = new Gain(ac, 1, 0);
  windGain.addInput(windPlayer);
  windPanner = new Panner(ac, 0);
  windPanner.addInput(windGain);
  ac.out.addInput(windPanner);
  
  ac.start();
  
} // end setup()



void draw() {
  background(backgroundColour, 150);
  
  int rainLimit = rain.limitForRain();
  rainGain.setGain(rain.avgForDay() / 2);
  
  for (int i = 0; i < rainLimit; i++) {
    rainDrops[i].rainDrop();
  }
  
  calendar.drawCalendar();
  
  sun.drawSun();
  
  // rain cloud icon
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
  
  windDir.setSoundVariables();
  windDir.drawWind();
  resetMatrix();
  
  //tempGraph.setupTempGraph(); 
  /*
    temp graph isn't working quite right at the moment, commented out just so the basics can be added to github
    -> labels are in the wrong spot
    -> it messes with the calendar and don't want to change calendar till temp Graph works
  */
 
  
} // end draw()


void mouseMoved() {
  // place hover functionality here once it's done and working
  
  //
  //
  //
  
}




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
