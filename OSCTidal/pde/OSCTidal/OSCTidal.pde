/*
 * 00: realtime synchronization between video and sound by Open Sound Control
 *
 * The MIT License (MIT)
 *
 * Copyright (c) 2017-2019 Masahito H.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import oscP5.*;
import netP5.*;

OscP5 osc;

ElementList el;
Fractal fl;
SpreadExplosion se;
PGraphics pg;
LinkedList<LatencyMessage> l;

float alp, rotate;
int sw;

void setup() {
  //fullScreen(OPENGL);
  size(1200, 1000, OPENGL);
  background(0);

  el = new ElementList();
  fl = new Fractal(0);
  se = new SpreadExplosion();
  pg = createGraphics(width, height, OPENGL);
  l = new LinkedList<LatencyMessage>();

  alp = 0;
  rotate = 0;
  sw = 0;
  
  osc = new OscP5(this, 12000);
}

void draw() {
  while(l.size() != 0 && l.get(0).getRemaining() <= 0){

    if(sw == 1 || sw == 0){
      el.addList();
    }
    if(sw == 2 || sw == 0){
      fl = new Fractal(rotate);
    }
    if(sw == 3 || sw == 0){
      se.create();
    }
    
    l.remove(0);
  }
 
  pg.beginDraw();
  pg.camera();
  pg.background(30);
  
  if(sw == 1 || sw == 0){
    el.drawList(pg);
  }
  if(sw == 2 || sw == 0){
    fl.exe(pg);
  }
  if(sw == 3 || sw == 0){
    se.exe(pg);
  }
  
  image(pg, 0, 0);
  pg.endDraw();

  alp = (alp += 0.50) % 255;
  rotate += 0.002;
}

void keyPressed() {
  if(key == '0'){
    sw = 0;
  }
  else if(key == '1'){
    sw = 2;
    el = new ElementList();
  }
  else if(key == '2'){
    sw = 1;
    fl = new Fractal(rotate);
  }
  else if(key == '3'){
    sw = 3;
    se = new SpreadExplosion();
  }
}



void oscEvent(OscMessage msg){
  l.add(new LatencyMessage());
}



//control latency
class LatencyMessage{
  private float lTime;
  
  LatencyMessage(){
    lTime = millis() + 100;
  }
  
  float getRemaining(){
    return lTime - millis();
  }
}
