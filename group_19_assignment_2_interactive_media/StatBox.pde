class StatBox {
  
  float rainAverage, tempAverage, uvaAverage, windDirAverage;
  int selectedDay = 0;
  
  int startX = 50;
  int startY = height - 100;
  
  // constructors
  StatBox() {
    rainAverage    = 0;
    tempAverage    = 0;
    uvaAverage     = 0;
    windDirAverage = 0;
  }
  
  // methods
  void drawStatBox() {
    strokeWeight(1);
    stroke(255);
    fill(144,135,234);
    rect(startX, startY, startX+525, 60);
    
    fill(255);  
    text("Averages:", startX + 10, startY + 35);
    stroke(255, 85);
    line(startX + 10, startY + 37, startX + 80, startY + 37);
    
    if (selectedDay == 0) {
      text("No day selected yet", startX + 85, startY + 35);
    }
    else {
      text("Air Temperature", startX + 100, startY + 25);
      text(tempAverage, startX + 125, startY + 45);
      
      text("Rainfall", startX + 240, startY + 25);
      text(rainAverage, startX + 242, startY + 45);
      
      text("UVA Radiation", startX + 325, startY + 25);
      text(uvaAverage, startX + 350, startY + 45);
      
      text("Wind Direction", startX + 450, startY + 25);
      text(windDirAverage + "˚", startX + 463, startY + 45);
    }
    
  }
  
  public void updateDay(int day) {
    selectedDay = day;
    setAverages();
  }
  
  public void setAverages() {
    rainAverage = rain.avgForDay();
    tempAverage = tempBgChange.avgForDay();
    uvaAverage  = sun.avgForDay();
    windDirAverage = windDir.avgForDay();
  }
  
} // end class
