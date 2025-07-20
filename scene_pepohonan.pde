void scene_ngobrol() {
  // Draw background
  drawTwilightBackground();
  drawFlyingBirds();
  drawTrees();
  drawGround();
  drawRocks();
  
  // Draw characters
  drawCharactersNgobrol();
  
  // Update sequence timing
  updateSequenceNgobrol();
}

// Function untuk draw karakter scene ngobrol
void drawCharactersNgobrol() {
  // Tentukan image berdasarkan state dan siapa yang ngomong
  PImage char2_img = getChar2ImageNgobrol();
  PImage char3_img = getChar3ImageNgobrol();
  
  if (char2_img != null) {
    image(char2_img, char2_ngobrol_x, char2_y);
  }
  
  if (char3_img != null) {
    image(char3_img, char3_ngobrol_x, char3_y);
  }
}

// Function untuk mendapatkan image char2 scene ngobrol
PImage getChar2ImageNgobrol() {
  switch(ngobrolCurrentState) {
    case 0: // Ngobrol 5 detik
      if (char2Speaking) {
        return char2_standing_a_mouth_flip; // Char2 ngomong
      } else {
        return char2_standing_flip; // Char2 diam
      }
    case 1: // Char2 berdiri biasa 1 detik
      return char2_standing;
    case 2: // Berjalan keluar ke kiri
      return char2_standing; // Menghadap ke kiri saat jalan
    default:
      return char2_standing_flip;
  }
}

// Function untuk mendapatkan image char3 scene ngobrol
PImage getChar3ImageNgobrol() {
  switch(ngobrolCurrentState) {
    case 0: // Ngobrol 5 detik
      if (!char2Speaking) {
        return char3_standing_a_mouth; // Char3 ngomong
      } else {
        return char3_standing; // Char3 diam
      }
    case 1: // Char2 berdiri biasa, char3 tetap
      return char3_standing;
    case 2: // Berjalan keluar ke kiri
      return char3_standing; // Char3 menghadap normal
    default:
      return char3_standing;
  }
}

// Function untuk update sequence timing scene ngobrol (DIPERBAIKI)
void updateSequenceNgobrol() {
  if (!ngobrolInitialized) {
    ngobrolStartTime = millis();
    dialogSwitchTime = millis();
    ngobrolInitialized = true;
  }
  
  int elapsedTime = millis() - ngobrolStartTime;
  
  switch(ngobrolCurrentState) {
    case 0: // Ngobrol bergantian selama 10 detik
      // Ganti siapa yang ngomong setiap 1 detik
      if (millis() - dialogSwitchTime >= 1000) {
        char2Speaking = !char2Speaking; // Toggle siapa yang ngomong
        dialogSwitchTime = millis();
      }
      
      // Setelah 10 detik, lanjut ke state berikutnya
      if (elapsedTime >= 7000) {
        ngobrolCurrentState = 1;
        ngobrolStartTime = millis();
      }
      break;
      
    case 1: // Char2 berdiri biasa selama 1 detik
      if (elapsedTime >= 1000) {
        ngobrolCurrentState = 2;
        ngobrolStartTime = millis();
      }
      break;
      
    case 2: // Berjalan keluar ke kiri bersama-sama
    char2_ngobrol_x -= walkSpeed;
    char3_ngobrol_x -= walkSpeed;
    
    // Jika kedua karakter sudah keluar frame kiri
    if (char2_ngobrol_x < -750 && char3_ngobrol_x < -750) {
      // Pindah ke scene masuk masjid (bukan langsung ke scene salah_1)
      changeScene(7);
    }
    break;
  }
}

// Function untuk reset posisi karakter scene ngobrol (DIPERBAIKI)
void resetNgobrolPositions() {
  char2_ngobrol_x = char2_ngobrol_start_x;  // Reset ke posisi awal
  char3_ngobrol_x = char3_ngobrol_start_x;  // Reset ke posisi awal
  ngobrolStartTime = 0;
  ngobrolCurrentState = 0;
  ngobrolInitialized = false;
  dialogSwitchTime = 0;
  char2Speaking = true;
  
  // Debug print untuk cek posisi
  println("Reset ngobrol positions:");
  println("char2_ngobrol_x: " + char2_ngobrol_x);
  println("char3_ngobrol_x: " + char3_ngobrol_x);
}

void drawTrees() {
  drawTree(200, 620, 70, 450, color(101, 67, 33), color(27, 94, 32));
  drawTree(380, 620, 90, 400, color(101, 67, 33), color(46, 125, 50));
  drawTree(640, 620, 100, 480, color(139, 69, 19), color(34, 139, 34));
  drawTree(900, 620, 85, 410, color(160, 82, 45), color(76, 175, 80));
  drawTree(1120, 620, 75, 460, color(101, 67, 33), color(67, 160, 71));
}

void drawTree(float x, float y, float trunkWidth, float height, color trunkColor, color leavesColor) {
  // Gambar batang pohon
  fill(trunkColor);
  stroke(color(69, 39, 19));
  strokeWeight(2);
  
  float trunkHeight = height * 0.4;
  rect(x - trunkWidth/2, y - trunkHeight, trunkWidth, trunkHeight);
  
  // Gambar daun - semua tanpa stroke kecuali outline utama
  noStroke();
  float leavesSize = trunkWidth * 2.5;
  
  // Daun tambahan untuk membuat pohon lebih rimbun (tanpa stroke)
  fill(leavesColor);
  ellipse(x - leavesSize/4, y - trunkHeight - leavesSize/4, leavesSize * 0.8, leavesSize * 0.8);
  ellipse(x + leavesSize/4, y - trunkHeight - leavesSize/4, leavesSize * 0.8, leavesSize * 0.8);
  
  // Daun utama (tanpa stroke)
  fill(leavesColor);
  ellipse(x, y - trunkHeight - leavesSize/3, leavesSize, leavesSize);
  
  // Outline hanya di daun utama
  stroke(color(27, 94, 32));
  noStroke();
  noFill();
  ellipse(x, y - trunkHeight - leavesSize/3, leavesSize, leavesSize);
  
  // Highlight pada daun (tanpa stroke)
  fill(color(red(leavesColor) + 30, green(leavesColor) + 30, blue(leavesColor) + 30));
  noStroke();
  ellipse(x - leavesSize/6, y - trunkHeight - leavesSize/2, leavesSize * 0.3, leavesSize * 0.3);
}

void drawTwilightBackground() {
  noStroke();
  for (int i = 0; i <= height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color c = lerpColor(color(255, 140, 60), color(80, 50, 120), inter);
    fill(c);
    rect(0, i, width, 1);
  }
}

void initializeBirds() {
  float[] startX = {150, 200, 250, 400, 600, 800, 950, 1100};
  float[] startY = {120, 150, 140, 180, 160, 130, 170, 200};
  
  for (int i = 0; i < 8; i++) {
    birdX[i] = startX[i];
    birdY[i] = startY[i];
    birdSpeed[i] = random(0.8, 1.5);
  }
}

void drawFlyingBirds() {
  for (int i = 0; i < 8; i++) {
    birdX[i] += birdSpeed[i];
    birdY[i] += sin(millis() * 0.001 + i * 0.5) * 0.3;
    
    if (birdX[i] > width + 20) {
      birdX[i] = -20;
      birdY[i] = random(100, 220);
    }
    
    drawBird(birdX[i], birdY[i]);
  }
}

void drawBird(float x, float y) {
  pushMatrix();
  translate(x, y);
  
  float wingFlap = sin(millis() * 0.008 + x * 0.01) * 8;
  
  stroke(color(47, 79, 79));
  strokeWeight(2);
  
  line(-12, 2 + wingFlap, -3, -2);
  line(-3, -2, 0, -3);
  line(0, -3, 3, -2);
  line(3, -2, 12, 2 + wingFlap);
  
  noStroke();
  fill(color(47, 79, 79));
  ellipse(0, -2, 2, 3);
  
  popMatrix();
}

void drawGround() {
  fill(color(34, 139, 34));
  stroke(color(0, 100, 0));
  strokeWeight(5);
  rect(0, 620, width, height - 620);
}

void drawRocks() {
  fill(color(105, 105, 105));
  stroke(color(47, 79, 79));
  strokeWeight(2);
  
  ellipse(200, 650, 40, 25);
  ellipse(400, 670, 30, 20);
  ellipse(800, 660, 35, 22);
  ellipse(1000, 680, 25, 18);
  ellipse(100, 690, 20, 15);
  ellipse(1100, 655, 28, 20);
}
