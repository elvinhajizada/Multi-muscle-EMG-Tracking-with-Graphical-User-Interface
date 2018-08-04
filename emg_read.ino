
/////////////////////
// Pin Definitions //
/////////////////////
const int selectPins[3] = {2, 3, 4}; // S0~2, S1~3, S2~4
const int selectPins2[3] = {5, 6, 7}; // S0~2, S1~3, S2~4
const int zOutput = 5; 
String chosenMusc = "0";
int musc = 0;
//const int zInput = A0; // Connect common (Z) to A0 (analog input)


// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  
  for (int i=0; i<3; i++)
  {
    pinMode(selectPins[i], OUTPUT);
    digitalWrite(selectPins[i], HIGH);
  }

   for (int i=0; i<3; i++)
  {
    pinMode(selectPins2[i], OUTPUT);
    digitalWrite(selectPins2[i], HIGH);
  }
  selectMuxPin(musc);
}

// the loop routine runs over and over again forever:
void loop() {
  if ( Serial.available()) // If data is available,
  {  
    chosenMusc = Serial.read();         // read it and store it in val
    musc = chosenMusc.toInt()-1;
    selectMuxPin(musc); 
    delay(1000);
  }
  
    // read the input on analog pin 0:
    int sensorValue = analogRead(A0);
    delay(40);
    // Convert the analog reading (which goes from 0 - 1023) to a voltage (0 - 5V):
    float voltage = sensorValue * (5.0 / 1023.0);
    // print out the value you read:
      

    Serial.println(voltage);

  
}

void selectMuxPin(byte pin)
{
  for (int i=0; i<3; i++)
  {
    if (pin & (1<<i))
      digitalWrite(selectPins[i], HIGH);
    else
      digitalWrite(selectPins[i], LOW);
  }

  for (int i=0; i<3; i++)
  {
    if (pin & (1<<i))
      digitalWrite(selectPins2[i], HIGH);
    else
      digitalWrite(selectPins2[i], LOW);
  }
}
