//This class creates the background, a green background with a black grid
//It also makes the start and end zones.
void grid() {
  stroke(0);
  for (int i = 0; i < width; i+=10){
    line(i, 0, i, height); 
  }
  for (int i = 0; i < height; i+=10){
    line(width, i, 0, i); 
  }
 
   stroke(244, 241, 65);
   line(loadStartX, 0, loadStartX, loadStartY);
   line(0, loadStartY, loadStartX, loadStartY);
   
   line(width - loadEndX, height - loadEndY, width, height - loadEndY);
   line(width - loadEndX, height, width - loadEndX, height - loadEndY);
   
   
   
   //------------------------------------------------------------------------------------
   //Edit this section to make setups to run automatically when you hit the spacebar.
   //Or just comment it out or delete it and do something else, whatever.
   if (firstRun){
     //loads of size one
     color c = color(150, 100, 50);
     int heightOne = 15; //15 for setups 1 and 2, 100 for 3 and 4
     addLoad(c, 1, 15, heightOne);
     addLoad(c, 1, 55, heightOne); 
     addLoad(c, 1, 35, heightOne);
     addLoad(c, 1, 75, heightOne);
     addLoad(c, 1, 95, heightOne);
     addLoad(c, 1, 115, heightOne); 
     addLoad(c, 1, 135, heightOne);
     addLoad(c, 1, 155, heightOne);
     //For SetupTwo and Four
     //addLoad(c, 1, 175, heightOne);
     
     //loads of size two
     c = color(66, 134, 244);
     int heightTwo = 45; //45 for setups 1 and 2, 80 for 3 and 4
     addLoad(c, 2, 15, heightTwo);
     addLoad(c, 2, 45, heightTwo);
     addLoad(c, 2, 75, heightTwo);
     addLoad(c, 2, 105, heightTwo);
     //For SetupTwo and Four
     //addLoad(c, 2, 135, heightTwo);
     
     //loads of size five
     c = color(244, 164, 66);
     int heightFive = 85; //85 for setups 1 and 2, 30 for 3 and 4
     addLoad(c, 5, 35, heightFive);
     addLoad(c, 5, 105, heightFive);
     //For SetupTwo and Four
     //addLoad(c, 5, 175, heightFive);
     
     //adds the ten drones
     for (int i = 0; i < 10; i++) {
       Drone test  = new Drone(35 + i*20, 250);
       test.add();
       drones.add(test);
       numDrones++;
     }
      fill(0);
      rect(width-160, 0, 160, 30);
      fill(255);
      text("numDrones:", width-150, 20);
      text(numDrones, width - 50, 20);
   }
}
