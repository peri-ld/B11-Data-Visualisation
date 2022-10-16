class TempBackgroundChange {
  // put in everything related to the colour changing of the background
  // may have to change the rain to rain drops now since the opacity thing may not work
  // also add in (maybe main class not in here) the mousePressed function based on the calendar we already have!
  
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
  
  void setupTempBg() {
    //textAlign(LEFT, TOP);
    //textSize(15);
    table = loadTable("data/Air Temperature.csv", "header");
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
  
  void drawTempBg() {
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
  }
  
  void updateChosenDate(int selectedDay) {
    chooseDay = selectedDay;
  }
  
  // gets average temperature for the day
  public float avgForDay() {
    float average = 0;
    
    if (chooseDay == 0) {
      average = 0;
    }
    else {
      int selected = chooseDay - 1;
    
      for (int i = 0; i < airTemperatureTable.getRowCount(); i++) {
        if (i == selected) {
          average = airTemperatureTable.getFloat(i, 1);
          break;
        }
      }
    }
    
    return average;
  } // end avgForDay
  
} // end TempBackgroundChange class

class Data {
  float temp;
  int date;
  Data(float temp, int date) {
    this.temp=temp;
    this.date=date;
  }
}
