#include <Adafruit_NeoPixel.h>

#define LED_PIN 14
#define LED_BRIGHTNESS 32
#define DISTANCE_PIN 2
#define STEP_NUM 12
#define FILTER_LENGTH  5
#define THRESHOLD 200
#define LED_NUM 240

int time = 0;
boolean is_steps[STEP_NUM];
Adafruit_NeoPixel strip = Adafruit_NeoPixel(LED_NUM, LED_PIN);

void setup() {
  Serial.begin(19200);
  
  for(int i=0; i<STEP_NUM; i++) {
    is_steps[i] = false;
  }
  
  strip.begin();
  strip.show();
  strip.setBrightness(LED_BRIGHTNESS);
}

void loop() {
 for(int i=DISTANCE_PIN; i<DISTANCE_PIN + STEP_NUM; i++) {
   int n = i - DISTANCE_PIN;
   printStep(n);
 } 
 Serial.println("");
 illuminateStep();

 delay(100);
}

void printStep(int i) {
  int ain = analogRead(i);
  if(THRESHOLD < ain) {
    if(!is_steps[i]) {
      Serial.print("1");
      is_steps[i] = true;
    } else {
      Serial.print("0");
    }
  } else {
    Serial.print("0");
    is_steps[i] = false;
  }
}

void illuminateStep() {
  for(int i=0; i<LED_NUM; i++) {
    int si = 1.0 * i / LED_NUM * STEP_NUM;
    int wi = 1.0 * i / LED_NUM * 255 + time;
    float brightness = 0.1;
    if(is_steps[si]) { brightness = 1.0; }
    
    strip.setPixelColor(i, Wheel(wi, brightness));
  }
  strip.show();

  time += LED_NUM - 1;
  time %= LED_NUM;
}

uint32_t Wheel(int WheelPos, float brightness) {
  WheelPos = WheelPos%255;
  
  if(WheelPos < 85) {
   return strip.Color(1.0*brightness * WheelPos * 3, 1.0*brightness * (255.0 - WheelPos * 3), 0);
  } else if(WheelPos < 170) {
   WheelPos -= 85;
   return strip.Color(1.0*brightness * (255.0 - WheelPos * 3), 0, 1.0*brightness * WheelPos * 3);
  } else {
   WheelPos -= 170;
   return strip.Color(0, 1.0*brightness * WheelPos * 3, 1.0*brightness * (255.0 - WheelPos * 3));
  }
}

