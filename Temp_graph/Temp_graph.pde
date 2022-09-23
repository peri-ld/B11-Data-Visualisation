// Temperature Time Graph - Peri

Table tempTable;
int[] day;
float[] temp;
float minTemp, maxTemp;
float X1, Y1, X2, Y2;
color bgColour = color(255);

void setup() {
 // drawing setup
 size(800, 600);
 X1 = 50; Y1 = 100;
 X2 = width - 50;
 Y2 = height - Y1;
 PFont legendFont = createFont("SansSerif", 10); // change font later
 textFont(legendFont);
 smooth();
 
 // Read temp data
 tempTable = loadTable("AirTemperatureAverage.csv");
 
 // collect list of days
 day = new int[tempTable.getRowCount()];
 for (int i = 0; i < tempTable.getRowCount(); i++) {
   day[i] = tempTable.getInt(i,0);
 }
 
  // collect list of temperatures
 temp = new float[tempTable.getRowCount()];
 for (int i = 0; i < tempTable.getRowCount(); i++) {
   temp[i] = tempTable.getFloat(i,1);
 }
 
 // min and max temps for graph size
 minTemp = min(temp);
 maxTemp = max(temp);
 
} // setup()



void draw() {
 background(0);
 // draw plot bounding box
 rectMode(CORNERS);
 noStroke();
 fill(bgColour); // variable
 rect(X1, Y1, X2, Y2);
 drawGraph(temp, minTemp, maxTemp);
 
 // draw legend
 //title
 fill(255);
 textSize(30);
 textAlign(LEFT);
 text("Average Daily Temperature of October", X1, Y1 - 10);
 textSize(10);
 textAlign(RIGHT, BOTTOM);
 text("Source: B11 Weather Sensor (*website here*)", width-10, height-10);
 
 // axis labels
 drawXLabels();
 drawYLabels();
 
} // draw()

void drawYLabels () {
  fill(255);
  textSize(10);
  textAlign(RIGHT);
  stroke(255);
  for (float i=minTemp; i <= maxTemp; i += 10) {
    float y = map(i, minTemp, minTemp, Y2, Y1);
    text(floor(i), X1-10, y);
    line(X1, y, X1-5, y);
  }
  
  textSize(25);
  rotate(radians(270));
  textAlign(CENTER);
  text("Temperature (°C)", -height/2, 40);
}

void drawXLabels () {
  fill(255);
  textSize(10);
  textAlign(RIGHT);
  stroke(255);
  for (float i=minTemp; i <= maxTemp; i += 10) {
    float y = map(i, minTemp, minTemp, Y2, Y1);
    text(floor(i), X1-10, y);
    line(X1, y, X1-5, y);
  }
  
  textSize(25);
  textAlign(CENTER);
  text("Day", width/2, height-60);
}

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
    curveVertex(x, y); // connects the mapped points
    //vertex(x, y);
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
