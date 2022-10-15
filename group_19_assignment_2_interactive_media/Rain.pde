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
    //rainSpeed = random(6, 11);
    rainSpeed = random(10, 16);
    rainColor = color(78, 149, 222, 100);
  }
  
  //// methods
  
  // draw rain
  void rainDrop() {
    //fill(rainColor);
    //noStroke();
    //rect(startX, startY, random(1, 4), random(5, 20));
    
    drawDroplet();
    
    updateRainFallLocation();
  }
  
  // move rain
  void updateRainFallLocation() {
    startY += rainSpeed;
    
    if (startY > height) {
      startY = random(-200, -50);
    }
  }
  
  void drawDroplet() {
    fill(111, 174, 234, 75);
    strokeWeight(1);
    stroke(111, 174, 234);
    beginShape();
    vertex(startX, startY);
    vertex(startX - 3, startY + 6);
    curveVertex(startX - 3, startY + 6);
    curveVertex(startX - 3, startY + 6);
    curveVertex(startX - 1.5, startY + 7);
    curveVertex(startX - 1.5, startY + 7);
    curveVertex(startX, startY + 8);
    curveVertex(startX, startY + 8);
    curveVertex(startX + 1.5, startY + 7);
    curveVertex(startX + 1.5, startY + 7);
    curveVertex(startX + 3, startY + 6);
    curveVertex(startX + 3, startY + 6);
    vertex(startX + 3, startY + 6);
    vertex(startX, startY);
    endShape();
    stroke(0);
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
