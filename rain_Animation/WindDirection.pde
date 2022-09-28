/*
  Code done by Chantel
*/

class WindDirection {
  
  int selectedDay = 0;
  
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
  
} // end class
