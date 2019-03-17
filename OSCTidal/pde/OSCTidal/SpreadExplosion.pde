/*
 * 03: generating time-explosive object
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

import java.util.LinkedList;
import java.util.Iterator;

class SpreadExplosion{
  LinkedList<Seed> seedList;
  Iterator<Seed> i;
  
  SpreadExplosion(){
    seedList = new LinkedList<Seed>();
  }
  
  public void create(){
    seedList.add(new Seed());
  }
  
  public void exe(PGraphics pg){
    pg.camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
    i = seedList.iterator();
    
    while(i.hasNext()){
      Seed element = i.next();
      element.exe(pg);
      
      if(!element.getExistence()){
        i.remove();
      }
    }
  }
}

class Seed{
  float time;
  boolean existence;
  
  PVector vec;
  float r, decR;
  float alp, stcAlp;
  
  Seed(){
    time = millis() + 3000;
    existence = true;
    
    vec = new PVector(noise(random(100) + millis()) * width, noise(random(100) + millis()) * height);

    r = 5 + noise(random(100) + millis()) * 45;
    alp = 200;
    stcAlp = alp;
    decR = r;
  }
  
  void exe(PGraphics pg){
    float lTime = time - millis();
    
    if(lTime > 0){
      pg.noStroke();
      pg.fill(random(255), random(255), random(255), alp);
      
      pg.rect(vec.x - r, vec.y - r, 2 * r, 2 * r);
    }
    else{
      pg.fill(155, alp);
      
      pg.rect(0, vec.y - decR, width, 2 * decR);
      
      alp--;
      decR = decR * .5;
      
      if(alp <= 0 || decR <= 0){
        existence = false;
      }
    }
  }
  
  boolean getExistence(){
    return existence;
  }
}
