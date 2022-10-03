class Calendar {
  
  String[] weekDays = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
  int startPointX = 50;
  int startPointY = 120;
  int shapeSize = 82;
  
  void drawCalendar(){
    PFont legendFont = createFont("AcademyEngravedLetPlain-48", 45);
    textFont(legendFont);
    textSize(32);//October Size
    fill(255);//October color
    text("October 2021",160,50);
    textSize(20);//weekDays Size
    text("Sun",80,100);
    text("Mon",80+shapeSize,100);
    text("Tue",80+shapeSize*2,100);
    text("Wed",80+shapeSize*3,100);
    text("Thu",80+shapeSize*4,100);
    text("Fri",80+shapeSize*5,100);
    text("Sat",80+shapeSize*6,100);//weekdays position
    
    fill(135,206,235);
    strokeWeight(1);
    stroke(255);//square color
    
    for(int i = 0; i < 360; i = i + shapeSize){
      for(int m = 0; m < 504; m = m + shapeSize){
        square(startPointX + m,startPointY + i,shapeSize);//columns
      }
    }
    
    fill(255); // numbers
    text(1,470,140);
    text(2,470 + shapeSize,140);
    text(3,60,222);
    text(4,60 + shapeSize,222);
    text(5,60 + shapeSize*2,222);
    text(6,60 + shapeSize*3,222);
    text(7,60 + shapeSize*4,222);
    text(8,60 + shapeSize*5,222);
    text(9,60 + shapeSize*6,222);
    text(10,55,222 + shapeSize);
    text(11,55 + shapeSize,222 + shapeSize);
    text(12,55 + shapeSize*2,222 + shapeSize);
    text(13,55 + shapeSize*3,222 + shapeSize);
    text(14,55 + shapeSize*4,222 + shapeSize);
    text(15,55 + shapeSize*5,222 + shapeSize);
    text(16,55 + shapeSize*6,222 + shapeSize);
    text(17,55,222 + shapeSize*2);
    text(18,55 + shapeSize,222 + shapeSize*2);
    text(19,55 + shapeSize*2,222 + shapeSize*2);
    text(20,55 + shapeSize*3,222 + shapeSize*2);
    text(21,55 + shapeSize*4,222 + shapeSize*2);
    text(22,55 + shapeSize*5,222 + shapeSize*2);
    text(23,55 + shapeSize*6,222 + shapeSize*2);
    text(24,55,222 + shapeSize*3);
    text(25,55 + shapeSize,222 + shapeSize*3);
    text(26,55 + shapeSize*2,222 + shapeSize*3);
    text(27,55 + shapeSize*3,222 + shapeSize*3);
    text(28,55 + shapeSize*4,222 + shapeSize*3);
    text(29,55 + shapeSize*5,222 + shapeSize*3);
    text(30,55 + shapeSize*6,222 + shapeSize*3);
    text(31,55,222 - shapeSize);
  } // end drawCalendar()
  
}
