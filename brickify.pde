
int[][] legoPalette = new int[][]{ 
   {242, 243, 242, 1},
   {161, 165, 162, 2},
   {249, 233, 153, 3},
   {215, 197, 153, 5},
   {194, 218, 184, 6},
   {232, 186, 199, 9},
   {203, 132, 66, 12},
   {204, 142, 104, 18},
   {196, 40, 27, 21},
   {196, 112, 160, 22},
   {13, 105, 171, 23},
   {245, 205, 47, 24},
   {98, 71, 50, 25},
   {27, 42, 52, 26},
   {109, 110, 108, 27},
   {40, 127, 70, 28},
   {161, 196, 139, 29},
   {243, 207, 155, 36},
   {75, 151, 74, 37},
   {160, 95, 52, 38},
   {193, 202, 222, 39},
   {180, 210, 227, 45},
   {238, 196, 182, 100},
   {218, 134, 121, 101},
   {110, 153, 201, 102},
   {199, 193, 183, 103},
   {107, 50, 123, 104},
   {226, 155, 63, 105},
   {218, 133, 64, 106},
   {0, 143, 155, 107},
   {104, 92, 67, 108},
   {67, 84, 147, 110},
   {104, 116, 172, 112},
   {199, 210, 60, 115},
   {85, 165, 175, 116},
   {183, 215, 213, 118},
   {164, 189, 70, 119},
   {217, 228, 167, 120},
   {231, 172, 88, 121},
   {211, 111, 76, 123},
   {146, 57, 120, 124},
   {234, 184, 145, 125},
   {220, 188, 129, 127},
   {174, 122, 89, 128},
   {156, 163, 168, 131},
   {116, 134, 156, 135},
   {135, 124, 144, 136},
   {224, 152, 100, 137},
   {149, 138, 115, 138},
   {32, 58, 86, 140},
   {39, 70, 44, 141},
   {121, 136, 161, 145},
   {149, 142, 163, 146},
   {147, 135, 103, 147},
   {87, 88, 87, 148},
   {22, 29, 50, 149},
   {171, 173, 172, 150},
   {120, 144, 129, 151},
   {149, 121, 118, 153},
   {123, 46, 47, 154},
   {117, 108, 98, 168},
   {215, 169, 75, 180},
   {130, 138, 93, 200},
   {249, 214, 46, 190},
   {232, 171, 45, 191},
   {105, 64, 39, 192},
   {207, 96, 36, 193},
   {163, 162, 164, 194},
   {70, 103, 164, 195},
   {35, 71, 139, 196},
   {142, 66, 133, 198},
   {99, 95, 97, 199},
   {229, 228, 222, 208},
   {176, 142, 68, 209},
   {112, 149, 120, 210},
   {121, 181, 181, 211},
   {159, 195, 233, 212},
   {108, 129, 183, 213},
   {143, 76, 42, 216},
   {124, 92, 69, 217},
   {150, 112, 159, 218},
   {107, 98, 155, 219},
   {167, 169, 206, 220},
   {205, 98, 152, 221},
   {228, 173, 200, 222},
   {220, 144, 149, 223},
   {240, 213, 160, 224},
   {235, 184, 127, 225},
   {253, 234, 140, 226},
   {125, 187, 221, 232},
   {52, 43, 117, 268},
   {236, 236, 236, 40},
   {205, 84, 75, 41},
   {193, 223, 240, 42},
   {123, 182, 232, 43},
   {247, 241, 141, 44},
   {217, 133, 108, 47},
   {132, 182, 141, 48},
   {248, 241, 132, 49},
   {236, 232, 222, 50},
   {191, 183, 177, 111},
   {228, 173, 200, 113},
   {165, 165, 203, 126},
   {213, 115, 61, 133},
   {216, 221, 86, 134},
   {207, 226, 247, 143},
   {255, 246, 123, 157},
   {225, 164, 194, 158},
   {151, 105, 91, 176},
   {180, 132, 85, 178},
   {137, 135, 136, 179}
};

boolean useLegoColors = true;

ArrayList<Button> myButtons = new ArrayList<Button>(5);

//The current loaded original
PImage loadedImage;
//The converted image
PImage convertedImage;
//The lego brick image used to 'brickify' images later
PImage legoBrick;

String currentlyLoaded = "None";
int pixelGrouping = 32;//Can't be larger than lego.png width or height (128 x 128)

float currentZoom = 1;

//The upper left corner of the currently displayed image
PVector displayPosition = new PVector(0, 0);

//Variables to handle dragging the position of the image
boolean draggingImage = false;
PVector draggingPosition = new PVector(0, 0);

Slider contrastSlider;
Slider brightnessSlider;

float adjustContrast = 1.0;
int adjustBrightness = 150;

void setup()  {
  size(800, 600);
  
  //float mixFactor = map(brightness(color(100, 204, 0)), 0, 255, 0.2, 0.8);
  //println(brightness(color(100, 204, 0)));
  
  legoBrick = loadImage("lego.png");
  
  myButtons.add(new Button(15, 15, "Load Image", 100, 25, 0, "load"));
  myButtons.add(new Button(15, 45, "Save", 100, 25, 0, "save"));
  
  myButtons.add(new Button(120, 15, "Pixelate", 100, 25, 1, "pixelate"));
  myButtons.add(new Button(225, 15, "Brickify", 100, 25, 1, "brickify"));
  myButtons.add(new Button(120, 45, "Zoom In", 100, 25, 1, "zoomin"));
  myButtons.add(new Button(225, 45, "Zoom Out", 100, 25, 1, "zoomout"));
  
  contrastSlider = new Slider(600, 27, 100, 0, 100, 40);
  brightnessSlider = new Slider(600, 57, 100, 0, 100, 25);
  
  strokeWeight(2);
}

void draw()  {
  background(#2E334F);
  
  if(convertedImage != null)  {
    float w = convertedImage.width * currentZoom;
    float h = convertedImage.height  * currentZoom;
    //float aspectRatio = w / h;

    image(convertedImage, displayPosition.x, displayPosition.y, w, h); 
  }
  
  noStroke();
  fill(#1A1C2B);
  rect(0, 0, width, 100);
  
  textSize(14);
  textAlign(CENTER, CENTER);
  boolean hover = false;
  for(int i = 0; i < myButtons.size(); i++)  {
    myButtons.get(i).show();
    if(myButtons.get(i).checkHover())  {
      hover = true; 
    }
  }
  if(hover)  {
    cursor(HAND);
  }  else  {
    cursor(ARROW); 
  }
  if(convertedImage != null)  {
    float w = convertedImage.width * currentZoom;
    float h = convertedImage.height  * currentZoom;
    if(mouseX > displayPosition.x && mouseX < displayPosition.x + w && mouseY > displayPosition.y && mouseY < displayPosition.y + h)  {
      if(mouseY > 100)  {
        cursor(MOVE);
        if(mousePressed)  {
          if(!draggingImage)  {
            draggingPosition.x = mouseX - displayPosition.x;
            draggingPosition.y = mouseY - displayPosition.y;
            draggingImage = true; 
          }
        }
      }
    }  else  {
      if(hover)  {
        cursor(HAND); 
      }  else  {
        cursor(ARROW); 
      }
    }
    if(draggingImage)  {
      if(mousePressed)  {
        displayPosition.x = mouseX - draggingPosition.x;
        displayPosition.y = mouseY - draggingPosition.y;
        
        int midX = width / 2;
        int midY = (height / 2) + 100;
        if(displayPosition.x > midX)  {
          displayPosition.x = midX;  
        }  else if(displayPosition.x + w < midX) {
          displayPosition.x = midX - w;
        }
        if(displayPosition.y > midY)  {
          displayPosition.y = midY;
        }  else if(displayPosition.y + h < midY) {
          displayPosition.y = midY - h;
        }
      }  else  {
        cursor(ARROW);
        draggingImage = false;
      }
    }
  }
  
  contrastSlider.show();
  contrastSlider.update();
  adjustContrast = map(contrastSlider.currentValue(), 0, 100, 2.0, 1.0);
  
  brightnessSlider.show();
  brightnessSlider.update();
  
  adjustBrightness = int(map(brightnessSlider.currentValue(), 0, 100, -200, 0));
  
  fill(225);
  rect(330, 15, 15, 15);
  if(useLegoColors)  {
    stroke(100);
    line(332, 17, 343, 28);
    line(332, 28, 343, 17);
  }
  if(mouseX > 330 && mouseX < 345)  {
    if(mouseY > 15 && mouseY < 30)  {
      if(mousePressed)  {
        if(useLegoColors)  {
          useLegoColors = false;  
        }  else  {
          useLegoColors = true;   
        }
        mousePressed = false;
      }
    }
  }
  
  fill(255);
  textSize(12);
  text("Current Image: " + currentlyLoaded, width / 2, 85);
  
  textAlign(LEFT, CENTER);
  text("Contrast", 530, 27);
  text("Brightness", 530, 57);
  text("Use only Lego colors", 350, 20);
}

public class Slider {
  PVector pos;
  PVector sliderPos;
  int sliderWidth;
  int min;
  int max;
  int value = 0;
  boolean dragging = false;
  
  public Slider(float x, float y, int w, int min, int max, int initialValue)  {
    this.pos = new PVector(x, y); 
    this.sliderPos = new PVector(x, y);
    this.sliderWidth = w;
    this.min = min;
    this.max = max;
    this.value = initialValue;
    
    this.sliderPos.x = int(map(initialValue, min, max, x, x + w)); 
  }
  
  public void show()  {
    fill(255);
    text(this.value, this.pos.x + this.sliderWidth + 20, this.pos.y - 1);
    noStroke();
    rect(this.pos.x, this.pos.y - 1, this.sliderWidth, 2);
    fill(100);
    if(this.dragging)  {
      fill(50);  
    }
    rect(this.sliderPos.x - 5, this.sliderPos.y - 10, 10, 20);
  }
  
  public void update()  {
    if(!this.dragging) {
      if(mouseX > this.sliderPos.x - 5 && mouseX < this.sliderPos.x + 5)  {
        if(mouseY > this.sliderPos.y - 10 && mouseY < this.sliderPos.y + 10)  {
          if(mousePressed)  {
            this.dragging = true;
          }
        }
      }
    }  else  {
      if(!mousePressed)  {
        this.dragging = false; 
      }  else  {
        this.sliderPos.x = mouseX;
        this.sliderPos.x = max(this.sliderPos.x, this.pos.x);
        this.sliderPos.x = min(this.sliderPos.x, this.pos.x + this.sliderWidth);
        
        this.value = int(map(this.sliderPos.x, this.pos.x, this.pos.x + this.sliderWidth, this.min, this.max)); 
      }
    }
  }
  
  public int currentValue()  {
    return this.value;  
  }
}

public class Button {
  PVector pos;
  String text;
  int w, h;
  boolean hover = false;
  color colorPrimary;
  color colorSecondary;
  color colorFont;
  String type = "";
  
  public Button(float x, float y, String text, int w, int h, int colorScheme, String type)  {
    this.pos = new PVector(x, y);
    this.text = text;
    this.w = w;
    this.h = h;
    this.type = type;
    
    if(colorScheme == 0)  {
      this.colorPrimary = #00AAFF;
      this.colorSecondary = #379BFF;
      this.colorFont = 255;
    }  else  {
      this.colorPrimary = #19ff8c;
      this.colorSecondary = #5cdb9b;
      this.colorFont = 0;
    }
  }
  
  public void show()  {
    if(this.hover)  {
      fill(this.colorSecondary);
    }  else  {
      fill(this.colorPrimary);
    }
    rect(this.pos.x, this.pos.y, this.w, this.h, 5);
    fill(this.colorFont);
    text(this.text, this.pos.x + (this.w / 2), this.pos.y + (this.h / 2));
  }
  
  public boolean checkHover()  {
    this.hover = false;
    
    if(mouseX >= this.pos.x && mouseX <= this.pos.x + this.w)  {
      if(mouseY >= this.pos.y && mouseY <= this.pos.y + this.h)  {
        this.hover = true;
        if(mousePressed && !draggingImage)  {
          this.clicked();
          mousePressed = false;
        }
      }
    }
    return this.hover;
  }
  
  public void clicked()  {
    switch(this.type)  {
      case "load":  {
        selectInput("Choose an image...", "inputFileSelected");
        break; 
      }
      case "save":  {
        selectOutput("Choose output file...", "outputFileSelected");
        break;  
      }
      case "pixelate":  {
        if(loadedImage != null)  {
          int w = loadedImage.width;
          int h = loadedImage.height;
          
          //Load the loaded image's pixels
          loadedImage.loadPixels();

          //Load the converted image's pixels to manipulate
          convertedImage = createImage(w, h, ARGB);
          convertedImage.loadPixels();

          for(int x = 0; x < loadedImage.width; x += pixelGrouping)  {
            for(int y = 0; y < loadedImage.height; y += pixelGrouping)  {
              
              if(x + pixelGrouping <= loadedImage.width && y + pixelGrouping <= loadedImage.height)  {
                int pos = x + y * w;
                color tempColor = loadedImage.pixels[pos];
                
                //Enumerate from the current x position upto the pixelGrouping amount
                for(int i = 0; i < pixelGrouping; i++)  {
                  for(int j = 0; j < pixelGrouping; j++)  {
                    pos = x + i + (y + j) * w;
                    convertedImage.pixels[pos] = tempColor;
                  }
                }
              }
            }
          }
          convertedImage.updatePixels();
        }
        break; 
      }
      case "brickify":  {
        if(loadedImage != null)  {
          PImage legoReduced = createImage(legoBrick.width, legoBrick.height, RGB);
          legoReduced = legoBrick;
          legoReduced.resize(pixelGrouping, 0);
          
          int w = loadedImage.width;
          int h = loadedImage.height;
          
          //Load the loaded image's pixels
          loadedImage.loadPixels();

          //Load the converted image's pixels to manipulate
          convertedImage = createImage(w, h, ARGB);
          convertedImage.loadPixels();

          for(int x = 0; x < loadedImage.width; x += pixelGrouping)  {
            for(int y = 0; y < loadedImage.height; y += pixelGrouping)  {
              
              if(x + pixelGrouping <= loadedImage.width && y + pixelGrouping <= loadedImage.height)  {
                int pos = x + y * w;
                color firstColor = loadedImage.pixels[pos];
                if(useLegoColors)  {
                  firstColor = closestLegoColor(firstColor);
                }
                //Enumerate from the current x position upto the pixelGrouping amount
                for(int i = 0; i < pixelGrouping; i++)  {
                  for(int j = 0; j < pixelGrouping; j++)  {
                    color secondColor = legoReduced.pixels[i + j * pixelGrouping];
                    color mixedColor = lerpColor(firstColor, secondColor, 0.5);
                    
                    float r = mixedColor >> 16 & 0xFF;
                    float g = mixedColor >> 8 & 0xFF;
                    float b = mixedColor & 0xFF;

                    pos = x + i + (y + j)* w;
                    convertedImage.pixels[pos] = color(r * adjustContrast + adjustBrightness, g * adjustContrast + adjustBrightness, b * adjustContrast + adjustBrightness);
                  }
                }
              }
            }
          }
          convertedImage.updatePixels();
        }
        break;  
      }
      case "zoomin":  {
        currentZoom += 0.25;
        currentZoom = min(currentZoom, 2.0);
        
        //Centers the image
        float x = (width / 2) - (loadedImage.width * currentZoom / 2);
        float y = (height / 2) - (loadedImage.height * currentZoom / 2);
        
        displayPosition.x = x;
        displayPosition.y = y + 50;
        break;
      }
      case "zoomout":  {
        currentZoom -= 0.25;
        currentZoom = max(currentZoom, 0.50);
        
        //Centers the image
        float x = (width / 2) - (loadedImage.width * currentZoom / 2);
        float y = (height / 2) - (loadedImage.height * currentZoom / 2);
        
        displayPosition.x = x;
        displayPosition.y = y + 50;
        break; 
      }
    }
  }
}

void inputFileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    String filePath = selection.getAbsolutePath();
    if(isItAnImage(filePath))  {
      println("User selected " + selection.getAbsolutePath());
      
      currentZoom = 1;
      
      loadedImage = loadImage(filePath);
      float x = (width / 2) - (loadedImage.width * currentZoom / 2);
      float y = (height / 2) - (loadedImage.height * currentZoom / 2);
      
      displayPosition.x = x;
      displayPosition.y = y + 50;

      convertedImage = loadedImage;
      currentlyLoaded = filePath; 
            
    }  else  {
      println("Selected file is not an image!"); 
    }
  }
}

void outputFileSelected(File selection)  {
  if(convertedImage != null)  {
    if(selection == null)  {
      
    }  else  {
       String filePath = selection.getAbsolutePath();
       if(!isItAnImage(filePath))  {
         filePath += ".png"; 
       }
       convertedImage.save(filePath);
    }
  }
}

boolean isItAnImage(String loadPath) {
  loadPath = loadPath.toLowerCase();
  return (loadPath.endsWith(".jpg") || loadPath.endsWith(".jpeg") || loadPath.endsWith(".png")  ) ;
}

color closestLegoColor(color rgbColor)  {     
  float r = rgbColor >> 16 & 0xFF;
  float g = rgbColor >> 8 & 0xFF;
  float b = rgbColor & 0xFF;
  
  int closest = 0;
  double bestScore = 1000;
  
  for(int i = 0; i < legoPalette.length; i++)  {
    double d = Math.pow( (legoPalette[i][0] - r) * 0.30,  2 )
             + Math.pow( (legoPalette[i][1] - g) * 0.59, 2)
             + Math.pow( (legoPalette[i][2]-b) * 0.11,   2);  
    
    if(d < bestScore)  {
      closest = i;
      bestScore = d;
    }
  }
  return color(legoPalette[closest][0], legoPalette[closest][1], legoPalette[closest][2]);
}
