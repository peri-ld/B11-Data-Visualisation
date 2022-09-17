/*
  This file was purely used for the preprocessed calculations of the averages in each dataset. It is not used in the main program.
*/

// variables

Table airTempTable;
Table rainDataTable;
Table uvaRadiationTable;
Table windSpeedTable;
Table windDirectionTable;

String whichTable = "windDirectionTable"; // can put in any table name here (table names above)

float tableAvgForDay = 0;
float tableTotal = 0;
float tableCount = 0;
int tableDayNumber = 1;

void setup() {
  size(100, 100);
  
  airTempTable       = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2021-10-01T00%3A00%3A05&rToDate=2021-10-31T23%3A59%3A55&rFamily=weather&rSensor=AT", "csv");
  rainDataTable      = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2021-10-01T00%3A00%3A05&rToDate=2021-10-31T23%3A59%3A55&rFamily=weather&rSensor=RT", "csv");
  uvaRadiationTable  = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2021-10-01T00%3A00%3A05&rToDate=2021-10-31T23%3A59%3A55&rFamily=weather&rSensor=UV", "csv");
  windSpeedTable     = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2021-10-01T00%3A00%3A05&rToDate=2021-10-31T23%3A59%3A55&rFamily=weather&rSensor=WS", "csv");
  windDirectionTable = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=2021-10-01T00%3A00%3A05&rToDate=2021-10-31T23%3A59%3A55&rFamily=weather&rSensor=WD ", "csv");

  calculateAverage();
}

void draw() {
  println("Table: " + whichTable);
  println("Day: " + tableDayNumber);
  println("Average: " + getAverage());
  println(" ");
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      if (tableDayNumber != 1) {
        tableDayNumber--;
        calculateAverage();
      }
    }
    else if (keyCode == RIGHT) {
      if (tableDayNumber != 31) {
        tableDayNumber++;
        calculateAverage();
      }
    }
  }
} // end keyPressed

void calculateAverage() {
    tableAvgForDay = 0;
    tableTotal = 0;
    tableCount = 0;
    String stringSearch;
    for (int i = 1; i <= 31; i++) {
      if (i == tableDayNumber) {
        
        if (tableDayNumber < 10) {
          stringSearch = "2021-10-0" + tableDayNumber;
        }
        else {
          stringSearch = "2021-10-" + tableDayNumber;
        }
        
        println(stringSearch);
        
        String stringFromTable;
        
        switch (whichTable) {
          case "airTempTable":
            for (int j = 0; j < airTempTable.getRowCount(); j++) {
              stringFromTable = airTempTable.getString(j, 0);
              if ( stringFromTable.contains(stringSearch) ) {
                tableTotal += airTempTable.getFloat(j, 1);
                tableCount++;
              }
            } // end for j
            break;
          case "rainDataTable":
            for (int j = 0; j < rainDataTable.getRowCount(); j++) {
              stringFromTable = rainDataTable.getString(j, 0);
              if ( stringFromTable.contains(stringSearch) ) {
                tableTotal += rainDataTable.getFloat(j, 1);
                tableCount++;
              }
            } // end for j
            break;
          case "uvaRadiationTable":
            for (int j = 0; j < uvaRadiationTable.getRowCount(); j++) {
              stringFromTable = uvaRadiationTable.getString(j, 0);
              if ( stringFromTable.contains(stringSearch) ) {
                tableTotal += uvaRadiationTable.getFloat(j, 1);
                tableCount++;
              }
            } // end for j
            break;
          case "windSpeedTable":
            for (int j = 0; j < windSpeedTable.getRowCount(); j++) {
              stringFromTable = windSpeedTable.getString(j, 0);
              if ( stringFromTable.contains(stringSearch) ) {
                tableTotal += windSpeedTable.getFloat(j, 1);
                tableCount++;
              }
            } // end for j
            break;
          case "windDirectionTable":
            for (int j = 0; j < windDirectionTable.getRowCount(); j++) {
              stringFromTable = windDirectionTable.getString(j, 0);
              if ( stringFromTable.contains(stringSearch) ) {
                tableTotal += windDirectionTable.getFloat(j, 1);
                tableCount++;
              }
            } // end for j
            break;
        } // end switch
        
        tableAvgForDay = tableTotal / tableCount;
        
        break;
      } // end if i == tableDayNumber
    } // end for i
  } // end avg rainfall function
  
  public float getAverage() {
    return tableAvgForDay;
  }
