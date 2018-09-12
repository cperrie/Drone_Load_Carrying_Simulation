/* This code allows one to place "drones" and "loads". The drones
*  will automatically fly towards the loads and begin carrying them towards
*  the other zone. You can also preset situations of loads and drones
*  then use the spacebar to activate the setup.
*  There are three prebuilt algorithms, Lowest, Highest... find the rest in drone class
*  Basically comments explain about everything...
*  One important not is that this is not too effecient and that
*  somethings are manipulated in places that are sup-optimal, but eh.
*  Basic movement is done by recreating the image of drones and loads to their next location
*  and reseting the background to cover the older images.
*
*  Basics of the code created by Cameron Perrie
*  Permissions for use of the code granted to those who have access to it.
*  Original code can be found at 
*/

//This method is used for setup and refreshing 
//Basically makes everything you see except drones and loads
void setup() {
  size(600, 600);
  background(55, 145, 30);
  grid();
  selector();
  textSize(15);
  fill(0);
  rect(width-160, 0, 160, 30);
  fill(255);
  text("numDrones:", width-150, 20);
  text(numDrones, width - 50, 20);
  fill(0);
  rect(width-185, 30, 185, 30);
  fill(255);
  text("TimePassed:", width-180, 50);
  text(totalTime += 10*(stopTimer ? 0: 1), width - 50, 50);
  fill(0);
  rect(width-185, 60, 185, 30);
  fill(255);
  text("Algorithm Type:", width-180, 80);
  text(algorithm, width - 50, 80);
  firstRun = false;
}

int numDrones = 0;
int numLoads = 0;
//Load start and end are just the boxes outlined in yellow, can be changed.
int loadStartX = 300;
int loadStartY = 200;
int loadEndX = 200;
int loadEndY = 250;
//Starts at -20 because on my system the timer would always tick to 20 before waiting
//for something to happen and timing for real
int totalTime = -20;
//
//Use this to select the alogrithm you want to use
//
String algorithm = "Lowest";

boolean stopTimer = false;
boolean drone = false;
boolean loadOne = false;
boolean loadTwo = false;
boolean loadFive = false;

//for initial setup
boolean firstRun = false;

ArrayList<Load> loads = new ArrayList<Load>();
ArrayList<Drone> drones = new ArrayList<Drone>();

ArrayList<Load> handledLoads = new ArrayList<Load>();

//This method runs over and over again
void draw() {
  //This if statement is solely to run presets found in the grid class
  if (keyPressed){
    firstRun = true;
    delay(1000);
    totalTime = 0;
  }
  //Setup method refreshes everything excep the loads and drones.
  //This is necessary to refresh data... I just remember it not working out when I didn't have everything refreshed from
  //grid and stuff so feel free to play around with it and make it more effecient
  setup();
  //Stop timer is to stop the timer when all the loads are in the end zone.
  stopTimer = true;
  //Checks if all the loads are finished moving
  for (Load l: loads){
    if (!l.moved)
      stopTimer = false;
   l.add(); 
  }
  //Moves all the drones
  for (Drone d: drones){
   d.add();
   d.moveTowards();
  }
  //This is the speed that everything happens, basically. You should always have at least a small delay.
  delay(10);
}

//Used for selecting drones and loads
void mousePressed() {
  //If adding a drone
  if (mouseX > 25 && mouseX < 75 &&
    mouseY > height - 40 && mouseY < height - 10) {
    drone = true;
  }
  //If adding a load of weight 1
  if (mouseX > 100 && mouseX < 150 &&
    mouseY > height - 40 && mouseY < height - 10) {
    loadOne = true;
  }
  
  //If adding a load of weight 2
  if (mouseX > 175 && mouseX < 225 &&
    mouseY > height - 40 && mouseY < height - 10) {
    loadTwo = true;
  }
  
  //If adding a load of weight 5
  if (mouseX > 250 && mouseX < 300 &&
    mouseY > height - 40 && mouseY < height - 10) {
    loadFive = true;
  }
}
//Used for placing drones and loads
void mouseReleased() {
  if (drone) {
    //Makes sure that the user is not placing it in the selection area
    if (mouseY < height-50) {
      //Idk why I name the new drone test, but whatever it isn't a test
      Drone test  = new Drone(mouseX, mouseY);
      test.add();
      drones.add(test);
      numDrones++;
      //This is most likely not necessary because it is in the setup method
      //But I left it here maybe for some reason so I just commented it out.
      //fill(0);
      //rect(width-160, 0, 160, 30);
      //fill(255);
      //text("numDrones:", width-150, 20);
      //text(numDrones, width - 50, 20);
    }
    drone = false;
  } else
  //Places load 1 if that was selected and the mouse is in the placement zone (top left)
  if (mouseY < loadStartY && mouseX < loadStartX) {
    if (loadOne) {
      color c = color(150, 100, 50);
      addLoad(c, 1, mouseX, mouseY);
      loadOne = false;
    } 
    //places load 2
    if (loadTwo) {
      color c = color(66, 134, 244);
      addLoad(c, 2, mouseX, mouseY);
      loadTwo = false;
    }
    //places load 5
    if (loadFive) {
      color c = color(244, 164, 66);
      addLoad(c, 5, mouseX, mouseY);
      loadFive = false;
    }
  } else{
    drone = false;
    loadOne = false;
    loadTwo = false;
    loadFive = false;
  }
  
  
}

//Method that creates a load.
void addLoad(color col, int size, int x, int y) {
  if (mouseY < height-50) {
    Load test = new Load(x, y, col, size);
    test.add();
    loads.add(test);
  }
  

  
  
}
