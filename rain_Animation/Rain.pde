/*
  Code done by Chantel 
*/

class Rain {
  // variables
  float startX = random(width);
  float startY = random(-200, 0);
  float rainSpeed = random(6, 11);
  color rainColor = color(78, 149, 222, 100);
  // test :D
  
  int selectedDay = 0;
  
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
  
}
