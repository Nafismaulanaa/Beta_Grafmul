void drawWindows() {
  background(#D2B48C);
  stroke(#aad2d9);
  strokeWeight(10);
  fill(#cbf2f8);

  int windowW = 200;
  int windowH = 400;
  int spacing = 170;
  int baseY = 160;

  for (int i = 0; i < 3; i++) {
    int x = spacing + i * (windowW + spacing);
    beginShape();
    vertex(x, baseY);
    endShape();
    rect(x, baseY, windowW, windowH, 5);
  }
}

void drawDots() {
  fill(#747474);
  noStroke();
  int[][] dotPositions = {
    {80, 280}, {80, 320}, {80, 360},
    {455, 280}, {455, 320}, {455, 360},
    {820, 280}, {820, 320}, {820, 360},
    {1190, 280}, {1190, 320}, {1190, 360},
  };
  for (int[] pos : dotPositions) {
    ellipse(pos[0], pos[1], 10, 10);
  }
}

void drawFloor() {
  noStroke();
  fill(#FFEBB2);
  rect(0, 670, width, 80);
}
