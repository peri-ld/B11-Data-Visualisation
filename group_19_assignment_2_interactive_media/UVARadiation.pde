class UVARadiation {
  /*
    This class is for:
      - Drawing the sun icon
      - updating size of sun icon
      - finding the average of the UVARadiation for the selected day
  */
  
  // variables
  int selectedDay = 0;
  float sunX;
  float sunY;
  float sunRadius;
  int rayCount;
  float angle;
  float rayLocation;
  
  // constructors
  UVARadiation() {
    sunX        = width - 150;
    sunY        = height/2 - 20;
    sunRadius   = 50;
    rayCount    = 20;
    angle       = 0.01;
    rayLocation = sunRadius * 0.5 + 5;
  }
  
  //methods
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
    
    //// to put text over the sun
    //fill(0);
    //if ( avgForDay() == 0 ) {
    //  textSize(12);
    //  text("N/A", -12, 5);
    //}
    //else {
    //  if (avgForDay() < 2.8) {
    //    textSize(10);
    //    text(avgForDay(), -18, 5);
    //  }
    //  else {
    //    textSize(12);
    //    text(avgForDay(), -20, 5);
    //  }
    //}
    
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
  
  // sets the radius depending on the average UVA Radiation
  public void setRadius() {
     float uvaAvg = avgForDay();
     sunRadius = uvaAvg * 10 + 5;
     rayLocation = sunRadius * 0.5 + 5;
  }
  
}
