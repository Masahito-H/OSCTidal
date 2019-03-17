/*
 * 01: generating four stripes
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

class FourStripes{
  LinkedList<Stripe> fStripes;
  
  FourStripes(){
    fStripes = new LinkedList<Stripe>();
  }
  
  void addList(){
    fStripes.add(new Stripe((int)(width * 3/5), (int)(height/2), 1, color(100, 100, 255)));
    fStripes.add(new Stripe((int)(width * 3/5), (int)(height/2), -5, color(100, 100, 255)));
    fStripes.add(new Stripe((int)(width * 2/5), (int)(height/2), 5, color(255, 100, 100)));
    fStripes.add(new Stripe((int)(width * 2/5), (int)(height/2), -1, color(155, 100, 100)));
  }
  
  void drawList(PGraphics pg){
    pg.camera(width/2.0, height/2.0, 275, width/2.0, height/2.0, 0, 0, 1, 0);
    LinkedList<Stripe> deleteList = new LinkedList<Stripe>();
    
    if(fStripes.size() != 0){
      for(Stripe e: fStripes){
        e.drawPara(pg);
        
        if(e.getEnd()){
          deleteList.add(e);
        }
      }
      
      
      if(deleteList.size() != 0){
        for(Stripe de: deleteList){
          fStripes.remove(de);
        }
        
        deleteList.clear();
      }
    }
  }
  
  
}

class Stripe{
  private int x, y, a;
  private color col;
  private boolean init, end;
  
  private int verH, horH;
  
  private int rot;
  
  Stripe(int x, int y, int a, color col){
    this.x = x;
    this.y = y;
    this.a = a;
    this.col = col;
    
    init = true;
    end = false;
    
    horH = 15;
    verH = height / 2;
    rot = 90;
  }
  
  void drawPara(PGraphics pg){
    pg.noStroke();
    pg.fill(col, 35);
    pg.quad(x - verH, y + verH, x - verH + horH, y + verH, x + verH, y - verH, x + verH - horH, y - verH);
    
    x += a;
    if(x - verH > width){
      end = true;
    }
  }
  
  boolean getEnd(){
    return end;
  }
}
