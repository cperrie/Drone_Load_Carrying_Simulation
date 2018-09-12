class Drone {
  color c;
  float xpos;
  float ypos;
  float xdir;
  float ydir;
  float speed;
  int size;
  Load destination;
  Load prevDest;
  boolean first = true;
  boolean firstDir = true;
  boolean moving = false;
  
  
  Drone(float x, float y) {
    c = color(255);
    size = 15;
    xpos = x - size/2;
    ypos = y - size/2;
    speed = 2;
    destination = null;
    prevDest = null;
  }


  void add() {
    ellipseMode(CENTER);
    stroke(0);
    fill(c);
    ellipse(xpos, ypos, size, size);
  }

  void moveTowards() {
    
    if (loads.size() == 0)
      return;
    //Will find the right destination based on the algorithm chosen
    //When the destination is found, there is a load created called destination
    //and that load is commonly refered to below verify the proper amount of drones are at it
    //and allow the load to move and stop moving. IDK why I decided to make the load move in the class.
    if (algorithm == "Lowest")
      getDestinationLowest();
    if (algorithm == "Highest")
      getDestinationHighest();
    if (algorithm == "Close")
      getDestinationClosest();
    if (algorithm == "Far")
      getDestinationFurthest();
      
    if (destination ==null)
      return;
      
    //Calls getDirections method to find a new xdir and ydir
    getDirections(destination.xpos, destination.ypos);
    if (!atLoad()){
      xpos += xdir;
      ypos += ydir;
    }
    //Classifies the drone as moving unless it is done handeling a load
    //Will wait at a load until total amount of drones are at load
    if (!moving){
      moving = true;
      if (destination.handled){
        //Checks that there are enough drones at load to move
        for(Drone d: destination.dronesAt){
          if (!d.atLoad()){
            moving = false;
          }
        }
      }
      else
        moving = false;
    }
    //If it is moving, make the load it is at start moving.
    if (moving){
      destination.moving = true;
      getDirections(550, 500);
      xpos += xdir;
      ypos += ydir;
      
      //If reached destination, stop the load and change it's moved boolean to true
      if (destination.xpos > 545 && destination.ypos > 495){
        destination.moved = true; 
      }
      //IF the load has been dropped off, reset the drone, allowing it to pick up other loads.
      if (destination.moved){
        destination.dronesAt.remove(this);
        destination.moving = false;
        destination.xdir = 0;
        destination.ydir = 0;
        destination = null;
        first = true;
        moving = false;
      }
      return;
    }
  }
//Pretty self explanatory, checks if the drone has reached a certain range of the load it was headed to.
  private boolean atLoad(){
    //I used a multiplier of *6 to the destination size to have the drone be an appropriate distance from the load.
    //Try changing it and see how it effects the visuals
    if (xpos < (destination.xpos + destination.size*6) && xpos > (destination.xpos - destination.size*6) && 
        ypos < (destination.ypos + destination.size*6) && ypos > (destination.ypos - destination.size*6)){
      return true;
    }
    return false;
  }

  //Simply tells the drones where to go.
  public void getDirections(int x, int y) {
    //int divisor = abs(gcd((destination.xpos - xpos), (destination.ypos - ypos)));
    //xdir = abs((destination.xpos - xpos)/divisor);
    //ydir = abs((destination.ypos - ypos)/divisor);
    float distance = getDistance(x, y);
    if (xpos > x)
      xdir = xdir * -1;
    if (ypos > y)
      ydir = ydir * -1;
    xdir = (speed/distance)*(x - xpos);
    ydir = (speed/distance)*(y - ypos);
  }
  public float getDistance(int x, int y) {
    float distance = sqrt((x - xpos)*(x - xpos) + (y - ypos)*(y - ypos));
    return distance;
  }
  
  
  
  //-------------------------------------------------------------------------------------------------
  //Everything below this has to do with the drone priority.
  //I would recommend reworking this as there is probably a more effecient way and you may want to
  //use other alogrithms. 
  //For example, package drones you could add a date ordered field and prioritize packages by order date
  
  
  //Sets destination to lightest available load.
  void getDestinationLowest() {
    if (destination == null) {
      Load lowest= new Load(0, 0, 0, 100);
      //destination = new Load((int)xpos, (int)ypos, 0, 100);
      for (Load l : loads) {
        if (first){
          lowest = l;
          first = false;
        }
        
          if (l.size < lowest.size) {
            if (!l.handled){
              //if (destination != null){
              //  prevDest = destination;
              //  prevDest.numDronesAt--;
              //}
            lowest = l;
            //System.out.println(l.size + " " + lowest.size);
            }
          }
      }
      if(!lowest.handled){
      //meaning that there is a destination
      if (lowest.size != 100){
        destination = lowest;
        destination.numDronesAt ++;
        destination.dronesAt.add(this);
        System.out.println(destination.numDronesAt);
        if (destination.size == destination.numDronesAt) {
          destination.handled = true;
          //loads.remove(destination);
        }
      }
      }
    }
  }
  
  //Sets destination to heaviest available load.
  void getDestinationHighest() {
    if (destination == null) {
      Load highest= new Load(0, 0, 0, 0);
      //destination = new Load((int)xpos, (int)ypos, 0, 100);
      for (Load l : loads) {
        if (first){
          highest = l;
          first = false;
        }
          if (l.size > highest.size) {
            if (!l.handled){
            highest = l;
            }
          }
      }
      if(!highest.handled){
      //meaning that there is a destination
      if (highest.size != 0){
        destination = highest;
        destination.numDronesAt ++;
        destination.dronesAt.add(this);
        System.out.println(destination.numDronesAt);
        if (destination.size == destination.numDronesAt) {
          destination.handled = true;
          //loads.remove(destination);
        }
      }
      }
    }
  }
  
   //Sets destination to closest available load.
  void getDestinationClosest() {
    if (destination == null) {
      Load closest= new Load(-1000, -1000, 0, 0);
      float close = getDistance(closest.xpos, closest.ypos);
      //destination = new Load((int)xpos, (int)ypos, 0, 100);
      for (Load l : loads) {
        if (first){
          closest = l;
          first = false;
        }
        float distance = getDistance(l.xpos, l.ypos);
          if (distance < close) {
            if (!l.handled){
            closest = l;
            }
          }
      }
      if(!closest.handled){
      //meaning that there is a destination
      if (closest.size != 0){
        destination = closest;
        destination.numDronesAt ++;
        destination.dronesAt.add(this);
        System.out.println(destination.numDronesAt);
        if (destination.size == destination.numDronesAt) {
          destination.handled = true;
          //loads.remove(destination);
        }
      }
      }
    }
  }
  
   //Sets destination to furhtest available load.
  void getDestinationFurthest() {
    if (destination == null) {
      Load furthest= new Load((int)xpos, (int)ypos, 0, 0);
      for (Load l : loads) {
        if (first){
          furthest = l;
          first = false;
        }
        float far = getDistance(furthest.xpos, furthest.ypos);
        float distance = getDistance(l.xpos, l.ypos);
          if (distance > far) {
            if (!l.handled){
              furthest = l;
            }
          }
      }
      if(!furthest.handled){
      //meaning that there is a destination
      if (furthest.size != 0){
        destination = furthest;
        destination.numDronesAt ++;
        destination.dronesAt.add(this);
        
        if (destination.size == destination.numDronesAt) {
          destination.handled = true;
          //loads.remove(destination);
        }
      }
      }
    }
  }
}
