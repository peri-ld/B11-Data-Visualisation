class SunIcon {
  // variables
  float sunX = width - 90;
  float sunY = height/2;
  float sunRadius = 50;
  int rayCount = 20;
  float angle  = 0.01;
  float rayLocation = sunRadius * 0.5 + 5;
  
  int selectedDay = 0;
  
  void drawSun() {
    fill(249, 250, 18);
    stroke(249, 250, 18);
    translate(sunX, sunY);
    circle(0, 0, sunRadius);
    
    for (int i = 0; i < rayCount; i++) {
      pushMatrix();
      rotate(angle + (i * TWO_PI)/rayCount );
      line(rayLocation, 0, rayLocation + sunRadius / 2, 0);
      popMatrix();
    }
    angle += 0.01;
    
    translate(-sunX, -sunY); // reset back to (0, 0)
    stroke(0);
  } // end drawSun()
  
  // method to get the average UVA
  public float avgForDay() {
    float average = 0;
    
    if (selectedDay == 0) {
      average = 0;
    }
    else {
      int selected = selectedDay - 1;
    
      for (int i = 0; i < uvaRadiationTable.getRowCount(); i++) {
        if (i == selected) {
          average = uvaRadiationTable.getFloat(i, 1);
          break;
        }
      }
    }
    
    return average;
  } // end avgForDay
  
  // method to set what day is selected && update the radius of the sun icon
  public void updateDay(int day) {
    selectedDay = day;
    if (selectedDay > 0 && selectedDay <= 31) {
      setRadius();
    }
  }
  
  public void setRadius() {
     float uvaAvg = avgForDay();
     sunRadius = uvaAvg * 10 + 5;
     rayLocation = sunRadius * 0.5 + 5;
  }
  
} // end class
