String command;

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  
  Serial.begin(57600);
  while (!Serial) { delay(1);}
  establishContact();
  command = String("");
}


void loop() {
  if(!Serial) {
    blink(5);
  }
  if (Serial.available() > 0) {
    char inByte = Serial.read();
    command += inByte;
    if(inByte == '\n')
      {
        Serial.print(command);
        command = "";
       }
  }
}


void establishContact() {
  while (Serial.available() <= 0) {
    Serial.print('\n');
    delay(100);
  }
  Serial.read();
  Serial.print('\n');
}

void blink(int a) {
  for(int i=0; i<a; ++i) {
    digitalWrite(LED_BUILTIN, HIGH);
    delay(200);
    digitalWrite(LED_BUILTIN, LOW);
    delay(200);
  }
}
