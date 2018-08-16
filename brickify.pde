
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

void setup()  {
  size(800, 600);

  //float mixFactor = map(brightness(color(100, 204, 0)), 0, 255, 0.2, 0.8);
  //println(brightness(color(100, 204, 0)));
  
  legoBrick = loadImage("lego2.png");
  
  myButtons.add(new Button(15, 15, "Load Image", 100, 25, 0, "load"));
  myButtons.add(new Button(15, 45, "Save", 100, 25, 0, "save"));
  
  myButtons.add(new Button(120, 15, "Pixelate", 100, 25, 1, "pixelate"));
  myButtons.add(new Button(225, 15, "Brickify", 100, 25, 1, "brickify"));
  myButtons.add(new Button(120, 45, "Zoom In", 100, 25, 1, "zoomin"));
  myButtons.add(new Button(225, 45, "Zoom Out", 100, 25, 1, "zoomout"));
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
  if(hover == true)  {
    cursor(HAND);
  }  else  {
    if(convertedImage != null)  {
      int w = convertedImage.width;
      int h = convertedImage.height;
      if(mouseX > displayPosition.x && mouseX < displayPosition.x + w && mouseY > displayPosition.y && mouseY < displayPosition.y + h)  {
        cursor(MOVE);
        if(mousePressed)  {
          if(!draggingImage)  {
            draggingPosition.x = mouseX - displayPosition.x;
            draggingPosition.y = mouseY - displayPosition.y;
            draggingImage = true; 
          }  else  {
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
          }
        }  else  {
          draggingImage = false; 
        }
      }  else  { 
        cursor(ARROW);
        if(draggingImage)  {
          draggingImage = false;  
        }
      }
    }  else  {
      cursor(ARROW);
      if(draggingImage)  {
        draggingImage = false;  
      }
    }
  }
  
  fill(255);
  textSize(12);
  text("Current Image: " + currentlyLoaded, width / 2, 85);
}

public class Slider {
  PVector pos;
  PVector sliderPos;
  int sliderWidth;
  int[] values;
  int optionsCount;
  
  public Slider(float x, float y, int w, int[] values)  {
    this.pos = new PVector(x, y); 
    this.sliderPos = this.pos;
    this.sliderWidth = w;
    this.values = values;
    
    this.optionsCount = this.values.length;
  }
  
  public void show()  {
    
  }
  
  public void update()  {
    
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
        if(mousePressed == true)  {
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
          convertedImage = createImage(w, h, RGB);
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
          convertedImage = createImage(w, h, RGB);
          convertedImage.loadPixels();

          for(int x = 0; x < loadedImage.width; x += pixelGrouping)  {
            for(int y = 0; y < loadedImage.height; y += pixelGrouping)  {
              
              if(x + pixelGrouping <= loadedImage.width && y + pixelGrouping <= loadedImage.height)  {
                int pos = x + y * w;
                color firstColor = loadedImage.pixels[pos];
                
                //Enumerate from the current x position upto the pixelGrouping amount
                for(int i = 0; i < pixelGrouping; i++)  {
                  for(int j = 0; j < pixelGrouping; j++)  {
                    color secondColor = legoReduced.pixels[i + j * pixelGrouping];
                    color mixedColor = lerpColor(firstColor, secondColor, 0.5);
                    
                    float r = mixedColor >> 16 & 0xFF;
                    float g = mixedColor >> 8 & 0xFF;
                    float b = mixedColor & 0xFF;

                    pos = x + i + (y + j)* w;
                    convertedImage.pixels[pos] = color(r * 1.6 - 150, g * 1.6 - 150, b * 1.6 - 150);
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
        currentZoom += 0.1;
        currentZoom = min(currentZoom, 2.0);
        
        //Centers the image
        float x = (width / 2) - (loadedImage.width * currentZoom / 2);
        displayPosition.x = x;
        displayPosition.y = 100;
        break;
      }
      case "zoomout":  {
        currentZoom -= 0.1;
        currentZoom = max(currentZoom, 0.1);
        
        //Centers the image
        float x = (width / 2) - (loadedImage.width * currentZoom / 2);
        displayPosition.x = x;
        displayPosition.y = 100;
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
      
      displayPosition.x = x;
      displayPosition.y = 100;

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
