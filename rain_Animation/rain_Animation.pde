/*
  Code done by Chantel 
*/

// libraries
import beads.*;

// variables
Table rainDataTable;
int rainNumber = 1;

Rain rain;
Rain[] rainDrops = new Rain[250];

color backgroundColour = color(195, 234, 159); // this changes from a seperate method when day is hovered over, not in this file currently


// Sounds
AudioContext ac;
SamplePlayer rainPlayer;
Gain rainGain;
float gainLevel = 0;

void setup(){
  size(1100, 700);
  rainDataTable = loadTable("data/RainAverage.csv", "csv");
  rain = new Rain();
    
  for (int i = 0; i < rainDrops.length; i++) {
    rainDrops[i] = new Rain();
  }
  
  ac = AudioContext.getDefaultContext();
  String rainAudioFileName = "/Users/chantelmills/Documents/GitHub/B11-Data-Visualisation/rain_Animation/sounds/raining.mp3";
  rainPlayer = new SamplePlayer(ac, SampleManager.sample(rainAudioFileName));
  rainPlayer.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  rainGain = new Gain(ac, 2, 0);
  rainGain.addInput(rainPlayer);
  ac.out.addInput(rainGain);
  ac.start();
  
}

void draw() {
  //background(backgroundColour, 150);
  fill(backgroundColour, 150);
  rect(0, 0, width, height);
  
  println("Rain Number (Day of Month): " + rainNumber);
  println("Rain Average: " + rain.avgForDay());
  println(" ");
  
  float avg = rain.avgForDay();
  float rainLimit = 0;
  
  rainGain.setGain(rain.avgForDay()); // bases the gain from the average rain for the selected day
  
  if (avg == 0) {
    rainLimit = 0;
    //rainGain.setGain(0);
  }
  else if (avg > 4.5) {
    // display all
    rainLimit = rainDrops.length;
    //rainGain.setGain(2);
  }
  else if (avg <= 4.5 && avg > 3.5) {
    rainLimit = 200;
    //rainGain.setGain(1.5);
  }
  else if (avg <= 3.5 && avg > 2.5) {
    rainLimit = 150;
    //rainGain.setGain(1);
  }
  else if (avg <= 2.5 && avg > 1.5) {
    rainLimit = 100;
    //rainGain.setGain(0.75);
  }
  else if (avg <= 1.5 && avg > 0.5) {
    rainLimit = 50;
    //rainGain.setGain(0.5);
  }
  else if (avg <= 0.5) {
    rainLimit = 25;
    //rainGain.setGain(0.25);
  }
  
  for (int i = 0; i < rainLimit; i++) {
    rainDrops[i].rainDrop();
  }
  
} // end draw

// ** THIS NEEDS TO BE CHANGED SINCE IT RELIES ON KEY PRESSES NOT THE HOVER //**//
  //** HOVER FUNCTION TO BE MADE LATER //**//
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      if (rainNumber != 1) {
        rainNumber--;
        rain.updateDay(rainNumber);        
      }
    }
    else if (keyCode == RIGHT) {
      if (rainNumber != 31) {
        rainNumber++;
        rain.updateDay(rainNumber);        
      }
    }
  }
} // end keyPressed
// ** THIS ^^ NEEDS TO BE CHANGED SINCE IT RELIES ON KEY PRESSES NOT THE HOVER //**//
  //** HOVER FUNCTION TO BE MADE LATER //**//
