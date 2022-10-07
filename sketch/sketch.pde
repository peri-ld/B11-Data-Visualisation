Table table;
color colR1, colR2;
color colY1, colY2;
color colGrey1, colGrey2;
color colGreen1, colGreen2;
color bg1, bg2;
int chooseDay=1;
Data datas[]=new Data[31];
float monthAverageTemperature=0;
float chooseTemp=0;
float tempOff=1;//设定超过平均温度几度就算较大偏差
String week[]={"SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"};

void setup() {  
  size(1000, 600);
  textAlign(LEFT, TOP);
  textSize(15);
  table = loadTable("Air Temperature.csv", "header");
  float dayilySum=0;
  float monthSum=0;
  int number=0;
  int nowDay=1, lastDay=1;
  float dailyAverageTemperature=0;
  
  for (TableRow row : table.rows()) {

    String time = row.getString("date");
    float temp = row.getFloat("temp");

    nowDay=int(time.substring(8, 10));
    if (lastDay!=nowDay) {
      dailyAverageTemperature=dayilySum/number;
      monthSum+=dailyAverageTemperature;
      println(dailyAverageTemperature, lastDay);
      datas[lastDay-1]=new Data(dailyAverageTemperature, lastDay);
      lastDay=nowDay;
      dayilySum=0;
      number=0;
    } else {
      number++;
      dayilySum+=temp;
    }
  }
  dailyAverageTemperature=dayilySum/number;
  monthSum+=dailyAverageTemperature;

  println(dailyAverageTemperature, lastDay);
  datas[lastDay-1]=new Data(dailyAverageTemperature, lastDay);

  lastDay=nowDay;
  monthAverageTemperature=monthSum/31;
  println(monthAverageTemperature);

  colR1    =color(#F07777);
  colR2    =color(#E08E29);
  //红色渐变组
  colY1    =color(#F0E18F);
  colY2    =color(#F59D3E);
  //黄色渐变组
  colGrey1 =color(#8595A5);
  colGrey2 =color(#556C83);
  //灰色渐变组
  colGreen1=color(#9ADEAF);
  colGreen2=color(#90F565);
  //绿色渐变组
  //设定各组颜色
} 

void draw() {
  chooseTemp=datas[chooseDay-1].temp;
  if (chooseTemp>monthAverageTemperature) {
    if (abs(chooseTemp-monthAverageTemperature)>tempOff) {
      //选定的日期温度比月均高较多
      bg1=colR1;
      bg2=colR2;
    } else { //选定的日期温度比月均高较小
      bg1=colY1;
      bg2=colY2;
    }
  } else {
    if (abs(chooseTemp-monthAverageTemperature)>tempOff) {
      //选定的日期温度比月均低较多
      bg1=colGrey1;
      bg2=colGrey2;
    } else {
      //选定的日期温度比月均低较小
      bg1=colGreen1;
      bg2=colGreen2;
    }
  }
  for (int  i=0; i<height; i++) {
    color c=lerpColor(bg1, bg2, map(i, 0, height, 0, 1));
    stroke(c);
    line(0, i, width, i);
  }
  //绘制渐变背景

  drawGird();
}

int date=31;
float s=3.5;//控制方块大小倍率 // // control of rectangle size rate
float rw=30*s, rh=25*s;//方块大小 // rect size
float sx=70, sy=100;//方块起始位置  // rect start position
float rx=sx, ry=sy;//方块当前位置 // rect current position

void drawGird() {
  //绘制日期表格
  int date=31;
  rx=sx;
  ry=sy;//方块当前位置
  stroke(0);
  for (int j=0; j<5; j++) {
    for (int i=0; i<7; i++) {
      noFill();
      if (date==chooseDay) {
        stroke(255);
        strokeWeight(2);
      } else { 
        stroke(0);
        strokeWeight(1);
      }
      rect(rx, ry, rw, rh);
      if (date<=31) {
        fill(0);
        text(date, rx+5, ry+5);
      }
      date++;
      if (date==36) {
        date=1;
      }
      rx+=rw;
    }
    rx=sx;
    ry+=rh;
  }
  rx=sx;
  ry=sy;
  for (int j=0; j<5; j++) {
    for (int i=0; i<7; i++) {
      noFill();
      if (date==chooseDay) {
        stroke(255);
        strokeWeight(2);
      } else { 
        noStroke();
      }
      rect(rx, ry, rw, rh);
      date++;
      if (date==36) {
        date=1;
      }
      rx+=rw;
    }
    rx=sx;
    ry+=rh;
  }
  //绘制一个白框在选中日期的框上

  rx=sx;
  for (int i=0; i<7; i++) {
    text(week[i], rx+5, sy-25);
    rx+=rw;
  }
  //绘制星期文字
}

void mousePressed() {
  int date=31;
  rx=sx;
  ry=sy;//方块当前位置

  for (int j=0; j<5; j++) {
    for (int i=0; i<7; i++) {
      if (date<=31 && mouseX>rx && mouseX<rx+rw && mouseY>ry && mouseY<ry+rh) {
        chooseDay=date;
      }
      date++;
      if (date==36) {
        date=1;
      }
      rx+=rw;
    }
    rx=sx;
    ry+=rh;
  }
}

class Data {
  float temp;
  int date;
  Data(float temp, int date) {
    this.temp=temp;
    this.date=date;
  }
}
