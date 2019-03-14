/*
 * 01: Menger sponge
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

class Fractal{
  private float a;
  private int n;
  
  private Box b;
  private ArrayList<Box> frac;
  
  Fractal(float a){
    this.a = a;
    frac = new ArrayList<Box>();

    this.n = (int)random(1, 4);
    b = new Box(0, 0, 0, 200, noise(frameCount + random(100)));

    frac.add(b);
    frac = recursion(frac, n);
  }
  
  void exe(PGraphics pg){
    pg.camera(width/2.0, height/2.0, 275, width/2.0, height/2.0, 0, 0, 1, 0);

    pg.noStroke();
    pg.pushMatrix();
    pg.translate(width/2, height/2);
    pg.rotateX(a * 2);
    pg.rotateY(-a);
    pg.rotateZ(a / 2);
    
    for(Box b: frac){
      pg.fill(255, 255, 0, b.getAlpha());
      
      pg.pushMatrix();
      pg.translate(b.getPos().x, b.getPos().y, b.getPos().z);
      b.exe(pg);
      pg.popMatrix();
    }
    
    pg.popMatrix();
    
    a += 0.002;
  }
  
  ArrayList<Box> recursion(ArrayList<Box> fracList, int i){
    if(i > 0){
      ArrayList<Box> newFracList = new ArrayList<Box>();
      for(Box frac: fracList){
        newFracList.addAll(frac.generate());
      }
      
      i--;
      newFracList = recursion(newFracList, i);
      return newFracList;
    }
    else{
      return fracList;
    }
  }
  
  
}

class Box{
  private PVector pos;
  private float r;
  private float alpha;
  
  Box(float x, float y, float z, float r, float alpha){
    pos = new PVector(x, y, z);
    this.r = r;
    this.alpha = alpha;
  }
  
  ArrayList generate(){
    ArrayList<Box> boxes = new ArrayList<Box>();
    
    for(int x = -1; x < 2; x++){
      for(int y = -1; y < 2; y++){
        for(int z = -1; z < 2; z++){
          
          int sum = abs(x) + abs(y) + abs(z);
          
          if(sum > 1){
            float gR = r/3;
            Box b = new Box(pos.x + x * gR, pos.y + y * gR, pos.z + z * gR, gR, noise(frameCount + random(100)));
            boxes.add(b);
          }
        }
      }
    }
    
    return boxes;
  }
  
  void exe(PGraphics pg){
    pg.pushMatrix();
    pg.box(r);
    pg.popMatrix();
  }
  
  PVector getPos(){
    return pos;
  }
  
  float getAlpha(){
    return alpha * 50;
  }
}
