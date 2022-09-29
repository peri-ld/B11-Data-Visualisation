
class CloudIcon {
  
  // variables
  float cloudX;
  float cloudY;
  float rainX;
  float rainY;
  float rainSpeed;
  
  // constructors
  CloudIcon() {
    
    /*
      if cloudX or cloudY are changed, 
      rainX and rainY will highly likely need updating
    */
    
    cloudX = width - 120;
    cloudY = height/2 - 10;
    
    rainX = random(width - 100, width - 50);
    rainY = random (height - 320, height - 330);
    
    rainSpeed = random(1, 2);
  }
  
  // methods 
  void drawRainCloud() {
    image(cloud, cloudX, cloudY, cloud.width/2, cloud.height/2);
  }
  
  void drawRainDrop() {
    fill(111, 174, 234, 100);
    stroke(111, 174, 234);
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
    
    if (rainY >= height - 280) {
      rainY = random (height - 330, height - 320);
    }
    
  }
  
}
