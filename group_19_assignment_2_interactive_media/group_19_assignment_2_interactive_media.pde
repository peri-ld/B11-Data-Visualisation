
/*
  32027 31080 Interactive Media - Spring 2022
  Assignment 2
  Code for Group 19 - Peri Le Dain, Xinyue Zhang, Xueyu Chen, Chantel Mills
*/

// libraries
import beads.*;
//import controlP5.*;
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

TempBackgroundChange tempBgChange;

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
  calendar     = new Calendar();
  sun          = new UVARadiation();
  windDir      = new WindDirection();
  rain         = new Rain();
  rainCloud    = new CloudIcon();
  tempGraph    = new TempGraph();
  tempBgChange = new TempBackgroundChange();
  
  for (int i = 0; i < rainDrops.length; i++) {
    rainDrops[i] = new Rain();
  }
  
  for (int i = 0; i < cloudDrops.length; i++) {
    cloudDrops[i] = new CloudIcon();
  }
  
  tempBgChange.setupTempBg();
  
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
  
  tempBgChange.drawTempBg();
  
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
  
  tempGraph.setupTempGraph(); 
  /*
    temp graph isn't working quite right at the moment, commented out just so the basics can be added to github
    -> labels are in the wrong spot
    -> it messes with the calendar and don't want to change calendar till temp Graph works
  */
 
  
} // end draw()


void mousePressed() {
  int date=31;
  int rx = calendar.startPointX;
  int ry = calendar.startPointY;
  int s = calendar.shapeSize;
  
  for (int j=0; j<5; j++) {
    for (int i=0; i<7; i++) {
      
      if ( date<=31 && (mouseX > rx) && (mouseX < rx+s) && (mouseY > ry) && (mouseY < ry+s) ) {
        dayNumber = date;
        rain.updateDay(dayNumber);
        windDir.updateWindDirectionDay(dayNumber);
        sun.updateDay(dayNumber);
        tempBgChange.updateChosenDate(dayNumber);
        break;
      }
      date++;
      if (date==36) {
        date=1;
      }
      rx+=s;
    } // end for i
    
    rx=calendar.startPointX;
    ry+=s;
    
  } // end for j
  
} // end mousePressed()
