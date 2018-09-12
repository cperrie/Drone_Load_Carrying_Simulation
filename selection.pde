//Makes the selector at the bottom of the screen
void selector(){
  textSize(10);
  stroke(0);
  //
  //Gray Box
  //
  fill(150);
  rect(0, height - 50, width, 50);
  //
  //White Drone Box
  //
  fill(255);
  rect(25, height - 40, 50, 30);
  fill(0);
  text("Drone", 30, height - 25);
  //
  //Brown loadOne box
  //
  fill(150, 100, 50);
  rect(100, height - 40, 50, 30);
  fill(0);
  text("Load 1", 105, height - 25);
  //
  //Blue loadTwo box
  //
  fill(66, 134, 244);
  rect(175, height - 40, 50, 30);
  fill(0);
  text("Load 2", 180, height - 25);
  //
  //Orange loadFive box
  //
  fill(244, 164, 66);
  rect(250, height - 40, 50, 30);
  fill(0);
  text("Load 5", 255, height - 25);
}
