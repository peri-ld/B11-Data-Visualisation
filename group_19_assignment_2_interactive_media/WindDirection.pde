class WindDirection {
  
  int selectedDay = 0;
  PImage wind;
  
  float windIconX;
  float windIconY;
  
  WindDirection() {
    wind = loadImage("images/wind.png");
    windIconX = width - 160;
    windIconY = height - 170;
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
  
  // set windDirection in sound (panner && gain)
  
  public void setSoundVariables() {
    float windDirAvg = avgForDay();
    
    if (selectedDay == 0) {
      windGain.setGain(0);
      windPanner.setPos(0);
    }
    else {
      if (windDirAvg <= 151) {
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
    }
    
  }
  
} // end class
