void scene_masuk_masjid() {
  // Draw background (masjid yang diperbesar)
  drawMosqueSceneZoomed();
  
  // Draw characters
  drawCharactersMasukMasjid();
  
  // Update sequence timing
  updateSequenceMasukMasjid();
}

// Function untuk draw background masjid yang diperbesar
void drawMosqueSceneZoomed() {
  // Background twilight
  drawTwilightBackground();
  
  // Draw flying birds (optional)
  drawFlyingBirds();
  
  // Draw ground
  drawGroundZoomed();
  
  // Draw rocks (optional)
  drawRocksZoomed();
  
  // Draw main mosque (diperbesar untuk efek masuk)
  drawMainMosqueZoomed(-100, 650, 1250); // Diperbesar dari 560 ke 800
}

// Function untuk draw ground yang disesuaikan
void drawGroundZoomed() {
  fill(color(34, 139, 34));
  stroke(color(0, 100, 0));
  strokeWeight(5);
  rect(0, 650, width, height - 50); // Ground sedikit lebih tinggi
}

// Function untuk draw rocks yang disesuaikan
void drawRocksZoomed() {
  fill(color(105, 105, 105));
  stroke(color(47, 79, 79));
  strokeWeight(2);
  
  // Rocks yang disesuaikan posisi
  ellipse(50, 680, 45, 30);
  ellipse(250, 700, 35, 25);
  ellipse(550, 690, 40, 28);
  ellipse(750, 710, 30, 22);
  ellipse(1050, 685, 35, 25);
}

// Function untuk draw masjid yang diperbesar
void drawMainMosqueZoomed(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  float bodyHeight = size * 0.45;
  drawMosqueBodyZoomed(0, -bodyHeight, size, bodyHeight);
  drawGoldenDomeZoomed(0, -bodyHeight, size);
  popMatrix();
}

// Function untuk draw body masjid yang diperbesar
void drawMosqueBodyZoomed(float x, float y, float w, float h) {
  pushMatrix();
  translate(x, y);
  
  stroke(color(160, 82, 45));
  strokeWeight(8); // Stroke lebih tebal
  fill(color(210, 180, 140));
  rect(-w / 2, 0, w, h);
  
  drawWindows2Zoomed(w, h);
  
  float doorH = h * 0.6; // Door lebih tinggi
  float doorW = w * 0.3; // Door lebih lebar
  drawDoubleDoorZoomed(0, h - doorH, doorW, doorH);
  popMatrix();
}

// Function untuk draw windows yang diperbesar
void drawWindows2Zoomed(float size, float height) {
  fill(color(223, 248, 250));
  stroke(color(64, 164, 178));
  strokeWeight(6); // Stroke lebih tebal
  
  float winW = size * 0.1; // Window lebih besar
  float winH = height * 0.5; // Window lebih tinggi
  float doorWidth = size * 0.3;
  float spacing = size * 0.025;
  float windowY = height * 0.2;
  
  float leftWindow1X = -(doorWidth/2 + winW/2 + size * 0.08);
  float leftWindow2X = leftWindow1X - (winW + spacing);
  float rightWindow1X = (doorWidth/2 + winW/2 + size * 0.08);
  float rightWindow2X = rightWindow1X + (winW + spacing);
  
  rect(leftWindow2X - winW/2, windowY, winW, winH, 8);
  rect(leftWindow1X - winW/2, windowY, winW, winH, 8);
  rect(rightWindow1X - winW/2, windowY, winW, winH, 8);
  rect(rightWindow2X - winW/2, windowY, winW, winH, 8);
}

// Function untuk draw door yang diperbesar
void drawDoubleDoorZoomed(float x, float y, float w, float h) {
  stroke(color(74, 74, 74));
  strokeWeight(6); // Stroke lebih tebal
  fill(color(101, 67, 33));
  
  rect(x - w/2, y, w, h);
  arc(x, y, w, w/3, PI, TWO_PI);
  
  stroke(color(139, 69, 19));
  strokeWeight(4);
  line(x, y + h * 0.1, x, y + h);
  
  noStroke();
  fill(color(255, 215, 0));
  ellipse(x - w/6, y + h * 0.45, 12, 12); // Handle lebih besar
  ellipse(x + w/6, y + h * 0.45, 12, 12);
  
  stroke(color(139, 69, 19));
  strokeWeight(3);
  noFill();
  rect(x - w/2 + w/12, y + h * 0.2, w/2 - w/6, h * 0.6, 5);
  rect(x + w/12, y + h * 0.2, w/2 - w/6, h * 0.6, 5);
}

// Function untuk draw dome yang diperbesar
void drawGoldenDomeZoomed(float x, float y, float size) {
  pushMatrix();
  translate(x, y);
  
  stroke(color(184, 134, 11));
  strokeWeight(8); // Stroke lebih tebal
  fill(color(255, 215, 0));
  arc(0, 0, size, size, PI, TWO_PI, PIE);
  
  noStroke();
  fill(color(255, 248, 220));
  ellipse(-size * 0.25, -size * 0.25, size * 0.18, size * 0.08); // Highlight lebih besar
  
  popMatrix();
}

// Function untuk draw karakter scene masuk masjid
void drawCharactersMasukMasjid() {
  // Tentukan image berdasarkan state
  PImage char2_img = getChar2ImageMasukMasjid();
  PImage char3_img = getChar3ImageMasukMasjid();
  
  if (char2_img != null) {
    image(char2_img, char2_masuk_x, char2_masuk_y);
  }
  
  if (char3_img != null) {
    image(char3_img, char3_masuk_x, char3_masuk_y);
  }
}

// Function untuk mendapatkan image char2 scene masuk masjid
PImage getChar2ImageMasukMasjid() {
  switch(masukMasjidCurrentState) {
    case 0: // Berjalan masuk
      return char2_standing; // Char2 berjalan normal
    default:
      return char2_standing;
  }
}

// Function untuk mendapatkan image char3 scene masuk masjid
PImage getChar3ImageMasukMasjid() {
  switch(masukMasjidCurrentState) {
    case 0: // Berjalan masuk
      return char3_standing; // Char3 berjalan normal
    default:
      return char3_standing;
  }
}

// Function untuk update sequence timing scene masuk masjid
void updateSequenceMasukMasjid() {
  if (!masukMasjidInitialized) {
    masukMasjidStartTime = millis();
    masukMasjidInitialized = true;
  }
  
  int elapsedTime = millis() - masukMasjidStartTime;
  
  switch(masukMasjidCurrentState) {
    case 0: // Berjalan dari kanan ke kiri (masuk masjid)
      // Update posisi karakter bergerak ke kiri
      char2_masuk_x -= walkSpeed;
      char3_masuk_x -= walkSpeed;
      
      // Jika kedua karakter sudah keluar frame kiri (masuk ke masjid)
      if (char2_masuk_x < -750 && char3_masuk_x < -750) {
        // Pindah ke scene salah_1
        changeScene(1);
      }
      break;
  }
}

// Function untuk reset posisi karakter scene masuk masjid
void resetMasukMasjidPositions() {
  char2_masuk_x = char2_masuk_start_x;  // Reset ke posisi awal
  char3_masuk_x = char3_masuk_start_x;  // Reset ke posisi awal
  masukMasjidStartTime = 0;
  masukMasjidCurrentState = 0;
  masukMasjidInitialized = false;
  
  // Debug print untuk cek posisi
  println("Reset masuk masjid positions:");
  println("char2_masuk_x: " + char2_masuk_x);
  println("char3_masuk_x: " + char3_masuk_x);
}
