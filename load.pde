//The load class, makes loads and controls them.
class Load{
  color c;
  int xpos;
  int ypos;
  float xdir;
  float ydir;
  int speed;
  int size;
  int numDronesAt;
  boolean handled;
  ArrayList<Drone> dronesAt = new ArrayList<Drone>();
  boolean moved;
  boolean moving;
  
  Load(int x, int y, color h, int weight) {
    c = color(h);
    size = weight;
    xpos = x;
    ypos = y;
    xdir = 0;
    ydir = 0;
    speed = 2;
    numDronesAt = 0;
    handled = false;
    moved = false;
    moving = false;
  }
  //IMPORTNAT:
  //The basic overview of these are that they stay where they are until
  //an equal amount of drones to the size of the load reach the 
  //load, then (in the drone class), that load's boolean moving is changed to true.
  //Then the load's add method is called repeatedly in the draw method (main sketch). This will
  //create a new load moved over a little bit. The background also resets covering the older image of
  //the load. This is how I created movement, also happens for the drones.
  void add(){
    stroke(0);
    fill(c);
    if (moving){
       getDirections(550, 500);
    }
    rectMode(CENTER);
    rect(xpos += xdir, ypos += ydir, size * 10, size * 10);
    rectMode(CORNER);
    
  }
  //Tells the load where to go in the next frame.
  public void getDirections(int x, int y) {
    //int divisor = abs(gcd((destination.xpos - xpos), (destination.ypos - ypos)));
    //xdir = abs((destination.xpos - xpos)/divisor);
    //ydir = abs((destination.ypos - ypos)/divisor);
    float distance = sqrt((x - xpos)*(x - xpos) + (y - ypos)*(y - ypos));
    if (xpos > x)
      xdir = xdir * -1;
    if (ypos > y)
      ydir = ydir * -1;
    xdir = (speed/distance)*(x - xpos);
    ydir = (speed/distance)*(y - ypos);
  }
}
