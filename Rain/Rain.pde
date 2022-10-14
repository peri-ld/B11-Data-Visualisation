/*
  Code done by Chantel 
*/

class Rain {
  // variables
  float startX = random(width);
  float startY = random(-300, 0);
  float rainSpeed = random(4, 10);
  color rainColor = color(78, 149, 222, 100);
  
  float rainAvgForDay = 0;
  float rainTotal = 0;
  float rainCount = 0;
  
  int selectedDay = 1;
  
  // draw rain
  void rainDrop() {
    fill(rainColor);
    noStroke();
    rect(startX, startY, random(2, 4), random(5, 20));
    updateRainFallLocation();
  }
  
  // move rain
  void updateRainFallLocation() {
    startY += rainSpeed;
    
    if (startY > height) {
      startY = random(-200, -50);
    }
    
  }
  
  //void calculateAvgRainfall() {
  //  rainTotal = 0;
  //  rainCount = 0;
  //  String stringSearch;
  //  for (int i = 1; i <= 31; i++) {
  //    if (i == rainNumber) {
        
  //      if (rainNumber < 10) {
  //        stringSearch = "2021-10-0" + rainNumber;
  //      }
  //      else {
  //        stringSearch = "2021-10-" + rainNumber;
  //      }
        
  //      println(stringSearch);
        
  //      String stringFromTable;
  //      for (int j = 0; j < rainDataTableOld.getRowCount(); j++) {
  //        stringFromTable = rainDataTableOld.getString(j, 0);
  //        if ( stringFromTable.contains(stringSearch) ) {
  //          rainTotal += rainDataTableOld.getFloat(j, 1);
  //          rainCount++;
  //        }
  //      } // end for j
        
  //      rainAvgForDay = rainTotal / rainCount;
        
  //      break;
  //    }
  //  } // end for i
  //} // end avg rainfall function
  
  //public float getAverage() {
  //  return rainAvgForDay;
  //}
  
  public void updateDay(int day) {
    selectedDay = day;
  }
  
  public float avgForDay() {
    float average = 0;
    int selected = selectedDay - 1;
    
    for (int i = 0; i < rainDataTable.getRowCount(); i++) {
      if (i == selected) {
        average = rainDataTable.getFloat(i, 1);
        break;
      }
    }
    
    return average;
  } // end avgForDay
  
}
