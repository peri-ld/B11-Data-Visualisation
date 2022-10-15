class Calendar {
  
  String[] weekDays = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
  int startPointX = 50;
  int startPointY = 120;
  int shapeSize = 82;
  int currentPosX = 50;
  int currentPosY = 120;
  
  void drawCalendar(){
    int date=31;

    PFont legendFont = createFont("AcademyEngravedLetPlain-48", 45);
    textFont(legendFont);
    textSize(32);//October Size
    fill(255);//October color
    text("October 2021",150,50);
    
    textSize(20);//weekDays Size
    currentPosX = startPointX;
    for (int q=0; q<7; q++) {
      text(weekDays[q], currentPosX, 100);
      currentPosX+=shapeSize;
    }
    
    strokeWeight(1);
    stroke(255);//square color
    currentPosY = startPointY;
    for(int i = 0; i < 360; i = i + shapeSize){
      for(int m = 0; m < 504; m = m + shapeSize){
        if (date == dayNumber) {
          fill(144,135,234);
        }
        else {
          fill(135,206,235);
        }
        square(startPointX + m,startPointY + i,shapeSize);//columns
        
        if(date<=31){
          fill(255);
          textSize(15);
          text(date, startPointX + m + 5, startPointY + i + 20);
        }
        
        date++;
          
        if (date==36) {
          date=1;
        }
      }
    }
        
  } // end drawCalendar()
  
}
