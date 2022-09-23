/*
  Code done by Chantel 
  - This file relies on the Rain file
*/

// variables
Table rainDataTableOld;
Table rainDataTable;
int rainNumber = 1;

Rain rain;
Rain[] rainDrops = new Rain[250];

color backgroundColour = color(242, 234, 161); // this changes from a seperate method when day is hovered over, not in this file currently

void setup(){
  size(1100, 700);
  //rainDataTableOld = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2021-10-01T00%3A00%3A05&rToDate=2021-10-31T23%3A59%3A55&rFamily=weather&rSensor=RT", "csv");
  rainDataTable = loadTable("data/RainAverage.csv", "csv"); // <-- change it to this once method is changed
  rain = new Rain();
  //rain.calculateAvgRainfall();
    
  for (int i = 0; i < rainDrops.length; i++) {
    rainDrops[i] = new Rain();
  }
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
  
  if (avg == 0) {
    rainLimit = 0;
  }
  else if (avg > 4.5) {
    // display all
    rainLimit = rainDrops.length;
  }
  else if (avg <= 4.5 && avg > 3.5) {
    rainLimit = 200;
  }
  else if (avg <= 3.5 && avg > 2.5) {
    rainLimit = 150;
  }
  else if (avg <= 2.5 && avg > 1.5) {
    rainLimit = 100;
  }
  else if (avg <= 1.5 && avg > 0.5) {
    rainLimit = 50;
  }
  else if (avg <= 0.5) {
    rainLimit = 25;
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
        
        //rain.calculateAvgRainfall(); // won't need this anymore
      }
    }
    else if (keyCode == RIGHT) {
      if (rainNumber != 31) {
        rainNumber++;
        rain.updateDay(rainNumber);
        
        //rain.calculateAvgRainfall(); // wont need this anymore
      }
    }
  }
} // end keyPressed
// ** THIS ^^ NEEDS TO BE CHANGED SINCE IT RELIES ON KEY PRESSES NOT THE HOVER //**//
  //** HOVER FUNCTION TO BE MADE LATER //**//
