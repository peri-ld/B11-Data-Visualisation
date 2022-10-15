class TempGraph {
  // Temperature Time Graph - Peri
  
  //Table tempTable; // table being called in main file (airTemperatureTable)
  int[] day;
  float[] temp;
  float minTemp, maxTemp;
  float X1, Y1, X2, Y2;
  color bgColour = color(255);
  PFont legendFont;
  
  TempGraph() {
    X1 = width - 250; Y1 = 80;
    X2 = width - 50;
    Y2 = 200;
    legendFont = createFont("SansSerif", 10); // change font later
    textFont(legendFont);
    smooth();
     
    // collect list of days
    day = new int[airTemperatureTable.getRowCount()];
    for (int i = 0; i < airTemperatureTable.getRowCount(); i++) {
      day[i] = airTemperatureTable.getInt(i,0);
    }
     
    // collect list of temperatures
    temp = new float[airTemperatureTable.getRowCount()];
    for (int i = 0; i < airTemperatureTable.getRowCount(); i++) {
      temp[i] = airTemperatureTable.getFloat(i,1);
    }
     
    // min and max temps for graph size
    minTemp = min(temp);
    maxTemp = max(temp);
  }
  
  void setupTempGraph() {
    rectMode(CORNERS);
    noStroke();
    fill(bgColour); // variable
    rect(X1, Y1, X2, Y2);
    drawGraph(temp, minTemp, maxTemp);
    
    // drawing red line for day
    int day = dayNumber; // dayNumber is from the main class
    int dayx = (width - 255);
    int dayy = height-570;
    stroke(255, 0, 0);
    
    if (day == 30) {
      line(dayx+(190/31)*day +10, dayy, dayx+(190/31)*day +10, dayy+120);
    }
    else if (day == 31) {
      line(dayx+(190/31)*day +17, dayy, dayx+(190/31)*day +17, dayy+120);
    }
    else {
      line(dayx+(190/31)*day, dayy, dayx+(190/31)*day, dayy+120);
    }
     
    // axis labels
    //drawXLabels();
    drawYLabels();
     
    rectMode(CORNER); // reset back to default rectMode (if this isn't here, the formating gets messed around)
  }
  
  void drawYLabels () {
    push();
    textSize(18);
    rotate(radians(270));
    textAlign(CENTER);
    text("Temp (°C)", -height/4+20, width-270);
    pop();
  }
  
  //void drawXLabels () {
  //  textSize(25);
  //  textAlign(CENTER);
  //  text("Day", width/2, height-60);
  //}
  
  // creates line of graph
  void drawGraph(float[] data, float yMin, float yMax) {
    stroke(95, 232, 107); // could do gradient upper is red, lower is green/blue
    strokeWeight(5);
    //fill(95, 232, 107);
    
    beginShape(); // specifies each data point as a vertex in the plot
    for (int i=0; i < data.length; i++) {
      // map function repositions each point
      float x = map(i, 0, data.length-1, X1, X2);
      float y = map(data[i], yMin, yMax, Y2, Y1);
      //curveVertex(x, y); // connects the mapped points
      vertex(x, y);
      //push();
      //stroke(0);
      //circle(x, y, 5);
      //pop();
    }
    //to make a filled graph
    //vertex(map(data.length-1, 0, data.length-1, X1, X2), map(data[data.length-1], yMin, yMax, Y2, Y1));
    //vertex(X2, Y2);
    //vertex(X1, Y2);
    //vertex(map(0, 0, data.length-1, X1, X2), map(data[0], yMin, yMax, Y2, Y1));
    endShape();
    
    // draws dots on top of line
    //for (int i=0; i < data.length; i++) {
    //  // map function repositions each point
    //  float x = map(i, 0, data.length-1, X1, X2);
    //  float y = map(data[i], yMin, yMax, Y2, Y1);
    //  push();
    //  stroke(0);
    //  circle(x, y, 5);
    //  pop();
    //}
  } // drawGraph()
  
} // end class
