class Rain {
  
  float startX;
  float startY;
  float rainSpeed;
  color rainColor;
  
  int selectedDay = 0;
  
  //// constructors
  Rain() {
    startX = random(width);
    startY = random(-200, 0);
    rainSpeed = random(6, 11);
    rainColor = color(78, 149, 222, 100);
  }
  
  //// methods
  
  // draw rain
  void rainDrop() {
    fill(rainColor);
    noStroke();
    rect(startX, startY, random(1, 4), random(5, 20));
    updateRainFallLocation();
  }
  
  // move rain
  void updateRainFallLocation() {
    startY += rainSpeed;
    
    if (startY > height) {
      startY = random(-200, -50);
    }
  }
  
  public void updateDay(int day) {
    selectedDay = day;
  }
  
  public float avgForDay() {
    float average = 0;
    
    if (selectedDay == 0) {
      average = 0;
    }
    else {
      int selected = selectedDay - 1;
    
      for (int i = 0; i < rainDataTable.getRowCount(); i++) {
        if (i == selected) {
          average = rainDataTable.getFloat(i, 1);
          break;
        }
      }
    }
    
    return average;
  } // end avgForDay
  
  public int limitForRain() {
    int rainLimit = 0;
    float rainAvg = avgForDay();
    
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
    
    return rainLimit;
  }

} // end rain class
