
class CloudIcon {
  
  // variables
  float cloudX;
  float cloudY;
  float rainX;
  float rainY;
  float rainSpeed;
  PImage cloud;
  
  // constructors
  CloudIcon() {
    
    /*
      if cloudX or cloudY are changed, 
      rainX and rainY will highly likely need updating
    */
    
    cloud = loadImage("images/cloud.png");
    
    cloudX = width - 200;
    cloudY = height/2 + 60;
    
    rainX = random(width - 180, width - 130);
    rainY = random (height/2 + 80, height/2 + 90);
    
    rainSpeed = random(1, 2);
  }
  
  // methods 
  void drawRainCloud() {
    image(cloud, cloudX, cloudY, cloud.width/2, cloud.height/2);
    
    //// to display text over cloud
    //fill(0);
    //if (dayNumber == 0) {
    //  textSize(12);
    //  text("N/A", cloudX + 37, cloudY + 40);
    //}
    //else {
    //  if (rain.avgForDay() == 0) {
    //    textSize(12);
    //    text("0.000 mm", cloudX + 25, cloudY + 40);
    //  }
    //  else {
    //    textSize(12);
    //    text(df.format(rain.avgForDay()) + " mm", cloudX + 25, cloudY + 40);
    //  }
    //}
    
  }
  
  void drawRainDrop() {
    fill(110, 198, 232, 175);
    stroke(110, 143, 232);
    beginShape();
    vertex(rainX, rainY);
    vertex(rainX - 3, rainY + 6);
    curveVertex(rainX - 3, rainY + 6);
    curveVertex(rainX - 3, rainY + 6);
    curveVertex(rainX - 1.5, rainY + 7);
    curveVertex(rainX - 1.5, rainY + 7);
    curveVertex(rainX, rainY + 8);
    curveVertex(rainX, rainY + 8);
    curveVertex(rainX + 1.5, rainY + 7);
    curveVertex(rainX + 1.5, rainY + 7);
    curveVertex(rainX + 3, rainY + 6);
    curveVertex(rainX + 3, rainY + 6);
    vertex(rainX + 3, rainY + 6);
    vertex(rainX, rainY);
    endShape();
    stroke(0);
  }
  
  void updateDropLocation() {
    rainY += rainSpeed;
    
    if (rainY >= height - 190) {
      rainY = random (height/2 + 80, height/2 + 90);
    }
    
  }
  
}
