/*
  Code done by Chantel
*/

class WindDirection {
  
  int selectedDay = 0;
  PImage wind;
  
  float windIconX;
  float windIconY;
  
  WindDirection() {
    wind = loadImage("wind.png");
    windIconX = width - 100;
    windIconY = height - 250;
  }
  
  public void updateWindDirectionDay(int day) {
    selectedDay = day;
  }
  
  public float avgForDay() {
    float average = 0;
    
    if (selectedDay == 0) {
      average = 0;
    }
    else {
      int selected = selectedDay - 1;
    
      for (int i = 0; i < windDirectionTable.getRowCount(); i++) {
        if (i == selected) {
          average = windDirectionTable.getFloat(i, 1);
          break;
        }
      }
    }
    
    return average;
    
  } // end avgForDay
  
  // method for wind icon
  void drawWind() {
    
    if (selectedDay == 0) {
      image(wind, windIconX, windIconY, wind.width/2, wind.height/2);
    }
    else {
      translate(windIconX, windIconY);
      rotate(radians(avgForDay()));
      image(wind, 0 - 30, 0 - 100, wind.width/2, wind.height/2);
      translate(-windIconX, -windIconY); // reset back to (0, 0)
    }
    
  }
  
} // end class
