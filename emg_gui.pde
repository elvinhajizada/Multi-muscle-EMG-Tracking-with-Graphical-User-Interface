import processing.serial.*;

PImage img;
PShape biceps, triceps, shoulderFront, shoulderRear, forearm, traps, chosenMusc;
PShape [] muscles = new PShape [6];

// Declare global variables that will be saved to spreadsheet
int xPos, yPos;

int red, green;

// Set up color and size of click circles
color clickColor = color(0, 255, 0);
color saveColor = color(255, 0, 0);
int circleSize = 4;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
float muscleVal;
int value = 2;
float [] inByte = new float [4];
int xAxis = 651;

void setup() {
  // Images must be in the "data" directory to load correctly
  
  String portName = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port
  println(portName);
  myPort = new Serial(this, portName, 9600);
  
  //size(650, 538);
  size(1200,538);
  fill(0);
  rect(651, 0, 549, 538);
  img = loadImage("human.jpg");
  image(img, 0, 0);
  
  red = 0;
  green = 255;
  
  // Muscles
  biceps = createShape();
  biceps.beginShape();
  biceps.fill(102);
  biceps.noStroke();
  biceps.vertex(83, 186);
  biceps.vertex(88, 184);
  biceps.vertex(94, 181);
  biceps.vertex(100, 179);
  biceps.vertex(105, 173);
  biceps.vertex(107, 165);
  biceps.vertex(110, 157);
  biceps.vertex(110, 148);
  biceps.vertex(109, 140);
  biceps.vertex(103, 138);
  biceps.vertex(97, 140);
  biceps.vertex(93, 143);
  biceps.vertex(90, 148);
  biceps.vertex(87, 152);
  biceps.vertex(84, 158);
  biceps.vertex(83, 164);
  biceps.vertex(82, 174);
  biceps.vertex(83, 178);
  biceps.vertex(84, 183);
  biceps.endShape(CLOSE);


  triceps = createShape();
  triceps.beginShape();
  triceps.fill(102);
  triceps.noStroke();
  triceps.vertex(573, 165);
  triceps.vertex(573, 169);
  triceps.vertex(573, 173);
  triceps.vertex(572, 177);
  triceps.vertex(571, 179);
  triceps.vertex(569, 179);
  triceps.vertex(563, 182);
  triceps.vertex(558, 181);
  triceps.vertex(565, 181);
  triceps.vertex(560, 181);
  triceps.vertex(555, 178);
  triceps.vertex(551, 173);
  triceps.vertex(547, 167);
  triceps.vertex(540, 150);
  triceps.vertex(540, 143);
  triceps.vertex(542, 136);
  triceps.vertex(543, 130);
  triceps.vertex(546, 125);
  triceps.vertex(549, 126);
  triceps.vertex(556, 131);
  triceps.vertex(560, 133);
  triceps.vertex(561, 138);
  triceps.vertex(565, 144);
  triceps.vertex(569, 149);
  triceps.vertex(570, 154);
  triceps.vertex(571, 158);
  triceps.endShape(CLOSE);

  shoulderFront = createShape();
  shoulderFront.beginShape();
  shoulderFront.fill(102);
  shoulderFront.noStroke();
  shoulderFront.vertex(92, 138);
  shoulderFront.vertex(90, 133);
  shoulderFront.vertex(90, 126);
  shoulderFront.vertex(91, 120);
  shoulderFront.vertex(94, 113);
  shoulderFront.vertex(98, 109);
  shoulderFront.vertex(103, 104);
  shoulderFront.vertex(109, 104);
  shoulderFront.vertex(116, 102);
  shoulderFront.vertex(123, 101);
  shoulderFront.vertex(127, 103);
  shoulderFront.vertex(125, 107);
  shoulderFront.vertex(119, 112);
  shoulderFront.vertex(114, 118);
  shoulderFront.vertex(111, 123);
  shoulderFront.vertex(108, 128);
  shoulderFront.vertex(105, 130);
  shoulderFront.vertex(99, 134);
  shoulderFront.endShape(CLOSE);
  
  shoulderRear = createShape();
  shoulderRear.beginShape();
  shoulderRear.fill(102);
  shoulderRear.noStroke();  
  shoulderRear.vertex(544, 117);
  shoulderRear.vertex(547, 121);
  shoulderRear.vertex(551, 122);
  shoulderRear.vertex(554, 124);
  shoulderRear.vertex(558, 126);
  shoulderRear.vertex(562, 128);
  shoulderRear.vertex(562, 123);
  shoulderRear.vertex(562, 118);
  shoulderRear.vertex(561, 113);
  shoulderRear.vertex(558, 105);
  shoulderRear.vertex(552, 99);
  shoulderRear.vertex(545, 95);
  shoulderRear.vertex(538, 92);
  shoulderRear.vertex(531, 92);
  shoulderRear.vertex(522, 91);
  shoulderRear.vertex(520, 93);
  shoulderRear.vertex(523, 96);
  shoulderRear.vertex(528, 101);
  shoulderRear.vertex(532, 104);
  shoulderRear.vertex(538, 106);
  shoulderRear.vertex(542, 110);
  shoulderRear.endShape(CLOSE);

  forearm = createShape();
  forearm.beginShape();
  forearm.fill(102);
  forearm.noStroke();  
  forearm.vertex(57, 244);
  forearm.vertex(50, 238);
  forearm.vertex(56, 222);
  forearm.vertex(61, 211);
  forearm.vertex(65, 198);
  forearm.vertex(71, 187);
  forearm.vertex(79, 179);
  forearm.vertex(80, 192);
  forearm.vertex(88, 190);
  forearm.vertex(97, 189);
  forearm.vertex(95, 198);
  forearm.vertex(87, 210);
  forearm.vertex(77, 218);
  forearm.vertex(69, 226);
  forearm.vertex(63, 235);
  forearm.endShape(CLOSE);
  
  traps = createShape();
  traps.beginShape();
  traps.fill(102);
  traps.noStroke(); 
  traps.vertex(489, 69);
  traps.vertex(489, 78);
  traps.vertex(495, 80);
  traps.vertex(502, 82);
  traps.vertex(511, 85);
  traps.vertex(504, 78);
  traps.vertex(499, 72);
  traps.vertex(496, 67);
  traps.endShape(CLOSE);
  muscles [0] = forearm;
  muscles [1]=biceps;
  muscles [2]=triceps;
  muscles [3]=shoulderFront;
  muscles [4]=shoulderRear;
  muscles [5]=traps;
  inByte[0]=0;
  inByte[1]=0;
  inByte[2]=0;
  inByte[3]=0;
  
}

void draw() {
  
  if ( myPort.available() > 0) // If data is available,
  {  
    val = myPort.readStringUntil('\n');         // read it and store it in val
  } 
  
  println(val); //print it out in the console
  if (val != null)
  {
    muscleVal = float(val);
    if (value == 1 || value == 4) muscleVal=muscleVal*2;
  }
  red = int (255*muscleVal/5);
  green = 255 - red;
  //println(red);
  
  for (int m = 0; m<4; m++)
  {
    if (m==(value-1))
    {
      muscles[m].setFill(color(red,green,0));
      inByte[m]=map(muscleVal, 0, 5, 0, 125);
    }
    else
    {
      muscles[m].setFill(color(105,105,105));
      inByte[m]=0;
    }
    
    shape(muscles[m]);
  }
  
  // plot graphs
  
  stroke(255, 0, 0);
  line(xAxis, height-130*3-10, xAxis, height - 130*3 - inByte[0]-10);
 
  stroke(0, 255, 0);
  line(xAxis, height-130*2-10, xAxis, height - 130*2 - inByte[1]-10);
  
  stroke(0, 0, 255);
  line(xAxis, height-130-10, xAxis, height - 130 - inByte[2]-10);
  
  stroke(127, 34, 255);
  line(xAxis, height-10, xAxis, height-10 - inByte[3]);

  // at the edge of the screen, go back to the beginning:
  if (xAxis >= width) {
    xAxis = 651;
    fill(0);
    rect(651, 0, 549, 538);
  } else {
    // increment the horizontal position:
    xAxis++;
  }
}

void mousePressed() {
  //// Change cursor to wait
  //cursor(WAIT);
  
  //// Get x and y position values of click
  //xPos = mouseX;
  //yPos = mouseY;
  
  //// Draw circle where click occurred
  //fill(clickColor);
  //ellipse(xPos, yPos, circleSize, circleSize);
}

void mouseReleased() {

  //// Run the AppendValues Choreo function
  //println("traps.vertex(" + str(mouseX)+ ", " + str(mouseY) + ");");
  //// Draw finished circle
  //fill(saveColor);
  //ellipse(xPos, yPos, circleSize, circleSize);

  //// Write a finished message to console
  
  //// Change cursor back to normal
  //cursor(ARROW);
}

void keyPressed() {
 if (key == '1') {
   value = 1;
   myPort.write('1');
 }
 if (key == '2') {
   value = 2;
   myPort.write('2');
 }
 if (key == '3'){
   value = 3;
   myPort.write('3');
 }
 if (key == '4'){
   value = 4;
   myPort.write('4');
 }
 println(value);
  };
