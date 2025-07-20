void updateSequenceLuarMasjid() {
  if (luarMasjidStartTime == 0) {
    luarMasjidStartTime = millis();
  }
  
  int elapsedTime = millis() - luarMasjidStartTime;
  
  // Auto transition setelah 5 detik ke scene ngobrol
  if (elapsedTime >= 7000) {
    changeScene(6); // Pindah ke scene ngobrol (scene 6)
  }
}

void scene_luar_masjid() {
  drawTwilightBackground();
  drawFlyingBirds();
  drawTreesLuar();
  drawGround();
  drawRocks();
  drawMainMosque(640, 620, 560);
  updateSequenceLuarMasjid();
}

void drawMainMosque(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  float bodyHeight = size * 0.45;
  drawMosqueBody(0, -bodyHeight, size, bodyHeight);
  drawGoldenDome(0, -bodyHeight, size);
  popMatrix();
}

void drawGoldenDome(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  
  stroke(color(184, 134, 11));
  strokeWeight(6);
  fill(color(255, 215, 0));
  arc(0, 0, size, size, PI, TWO_PI, PIE);
  
  noStroke();
  fill(color(255, 248, 220));
  ellipse(-size * 0.25, -size * 0.25, size * 0.15, size * 0.06);
  
  popMatrix();
}

void drawMosqueBody(float x, float y, float w, float h) {
  pushMatrix();
  translate(x, y);
  
  stroke(color(160, 82, 45));
  strokeWeight(6);
  fill(color(210, 180, 140));
  rect(-w / 2, 0, w, h);
  
  drawWindows2(w, h);
  
  float doorH = h * 0.5;
  float doorW = w * 0.25;
  drawDoubleDoor(0, h - doorH, doorW, doorH);
  popMatrix();
}

void drawWindows2(float size, float height) {
  fill(color(223, 248, 250));
  stroke(color(64, 164, 178));
  strokeWeight(4);
  
  float winW = size * 0.08;
  float winH = height * 0.45;
  float doorWidth = size * 0.25;
  float spacing = size * 0.02;
  float windowY = height * 0.25;
  
  float leftWindow1X = -(doorWidth/2 + winW/2 + size * 0.12);
  float leftWindow2X = leftWindow1X - (winW + spacing);
  float rightWindow1X = (doorWidth/2 + winW/2 + size * 0.12);
  float rightWindow2X = rightWindow1X + (winW + spacing);
  
  rect(leftWindow2X - winW/2, windowY, winW, winH, 5);
  rect(leftWindow1X - winW/2, windowY, winW, winH, 5);
  rect(rightWindow1X - winW/2, windowY, winW, winH, 5);
  rect(rightWindow2X - winW/2, windowY, winW, winH, 5);
}

void drawDoubleDoor(float x, float y, float w, float h) {
  stroke(color(74, 74, 74));
  strokeWeight(4);
  fill(color(101, 67, 33));
  
  rect(x - w/2, y, w, h);
  arc(x, y, w, w/3, PI, TWO_PI);
  
  stroke(color(139, 69, 19));
  strokeWeight(3);
  line(x, y + h * 0.1, x, y + h);
  
  noStroke();
  fill(color(255, 215, 0));
  ellipse(x - w/6, y + h * 0.45, 8, 8);
  ellipse(x + w/6, y + h * 0.45, 8, 8);
  
  stroke(color(139, 69, 19));
  strokeWeight(2);
  noFill();
  rect(x - w/2 + w/12, y + h * 0.2, w/2 - w/6, h * 0.6, 3);
  rect(x + w/12, y + h * 0.2, w/2 - w/6, h * 0.6, 3);
}

void drawTreesLuar() {
  drawTree(100, 620, 70, 450, color(101, 67, 33), color(27, 94, 32));
  drawTree(1200, 620, 75, 460, color(101, 67, 33), color(67, 160, 71));
}
