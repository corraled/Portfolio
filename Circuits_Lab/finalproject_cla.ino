// include the library code:
#include <LiquidCrystal.h>
int readByte;
const int ledG = 8;
const int ledB = 9;
const int buzzer = 10;
int CompScore = 0;
int PlayerScore = 0;

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup() {
  Serial.begin(9600);
  // set up the LCD's number of columns and rows:
  lcd.begin(16, 2);
  // Print a message to the LCD.
  //lcd.print("Se va hacer o no se va hacer");
  pinMode(ledG, OUTPUT);
  pinMode(ledB, OUTPUT);
  pinMode(buzzer, OUTPUT);
}

void loop() {
 lcd.setCursor(5, 0);
 lcd.print("READY??");

 
 // send data only when you receive data:
 if (Serial.available() > 0) {
        // read the incoming byte:
        readByte = Serial.read();
  //lcd.setCursor(5, 0);
  //lcd.print(readByte);
  //Serial.print("I received: ");
  //Serial.println(readByte);

 if ( readByte == 1){ //ComputerScore = ComputerScore+1;
  //Serial.println(readByte);
CompScore = CompScore +1;
  
  lcd.setCursor(0, 0);
  lcd.print("COMPUTER SCORED!");
  lcd.setCursor(0, 1);        //added
lcd.print("Score:");
 lcd.setCursor(8, 1);        //added
lcd.print(CompScore); 
  digitalWrite(ledB, HIGH);
  tone(buzzer, 2000);
  delay(2500);
  digitalWrite(ledB, LOW);
  noTone(buzzer);
  lcd.clear();
 
}

 if(CompScore == 3){
    lcd.clear();
   lcd.setCursor(1, 0);
  lcd.print("COMPUTER WINS!");
  delay(2000);
  lcd.clear();
  CompScore = 0;
  }
if ( readByte == 2){ 
  PlayerScore = PlayerScore+1;
  Serial.println(readByte);
  lcd.setCursor(2, 0);
  lcd.print("YOU SCORED!");
  lcd.setCursor(0, 1);        //added
lcd.print("Score:");
 lcd.setCursor(8, 1);        //added
lcd.print(PlayerScore);
  digitalWrite(ledG, HIGH);
  tone(buzzer, 2000);
  delay(2500);
  digitalWrite(ledG, LOW);
  noTone(buzzer);
  lcd.clear();
}
if(PlayerScore == 3){
    lcd.clear();
   lcd.setCursor(3, 0);
  lcd.print("YOU WIN!");
  delay(2000);
  lcd.clear();
  PlayerScore = 0;
  
  }
             
// write ComputerScore and PlayerScore to 7 segment displays

        }
}

