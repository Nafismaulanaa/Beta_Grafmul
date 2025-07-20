void scene_salah_1() {
  // Update zoom and camera
  updateZoom();
  
  // Setup camera transformation
  pushMatrix();
  if (zoomToChar2) {
    // Zoom ke area char2 dan char3 dengan offset yang bisa diatur
    float centerX = (char2_x + char3_x) / 2 + zoomOffsetX;
    float centerY = (char2_y + char3_y) / 2 + zoomOffsetY;
    
    translate(width/2, height/2);
    scale(zoomLevel);
    translate(-centerX, -centerY);
  }
  
  // Draw background
  drawWindows();
  drawDots();
  drawFloor();
  
  // Draw characters
  drawCharacters1();
  
  // Reset transformation
  popMatrix();
  
  // Update posisi karakter (jalan dari kanan ke kiri)
  updateCharacterMovement();
  
  // Update sequence timing
  updateSequence();
  
  // Draw red X on top (after popMatrix so it's not affected by zoom)
  if (showRedX && red_x != null) {
    drawRedX();
  }
}

// Function untuk draw karakter-karakter
void drawCharacters1() {
  // Tentukan image mana yang akan ditampilkan berdasarkan sequence state
  PImage char1_img = getChar1Image();
  PImage char2_img = getChar2Image();
  PImage char3_img = getChar3Image();
  
  if (char1_img != null) {
    image(char1_img, char1_x, char1_y);
  }
  
  if (char2_img != null) {
    image(char2_img, char2_x, char2_y);
  }
  
  if (char3_img != null) {
    image(char3_img, char3_x, char3_y);
  }
}

// Function untuk mendapatkan image char1 berdasarkan state
PImage getChar1Image() {
  switch(currentSequenceState) {
    case 0: case 1: return char1_standing;
    case 2: case 6: return char1_takbir_a_mouth;
    case 3: case 4: case 5: return char1_salat;
    case 7: case 8: case 9: return char1_rukuk;
    case 10: return char1_rukuk_ketut;
    case 11: return char1_standing;
    case 12: case 14: case 15: return char1_standing_flip;
    case 13: return currentDialogImage;
    default: return char1_standing;
  }
}

// Function untuk mendapatkan image char2 berdasarkan state
PImage getChar2Image() {
  switch(currentSequenceState) {
    case 0: case 1: case 2: case 3: return char2_standing;
    case 4: case 8: return char2_takbir_a_mouth;
    case 5: case 6: case 7: return char2_salat;
    case 9: case 10: case 11: case 12: case 13: case 14: case 15: case 16: case 17: case 18: return char2_rukuk;
    default: return char2_standing;
  }
}

// Function untuk mendapatkan image char3 berdasarkan state
PImage getChar3Image() {
  switch(currentSequenceState) {
    case 0: case 1: case 2: case 3: return char3_standing;
    case 4: case 8: return char3_takbir_a_mouth;
    case 5: case 6: case 7: return char3_salat;
    case 9: case 10: case 11: case 12: case 13: case 14: case 15: case 16: case 17: case 18: return char3_rukuk;
    default: return char3_standing;
  }
}

// Function untuk update pergerakan karakter
void updateCharacterMovement() {
  // State 15: char1 berjalan keluar ke kanan
  if (currentSequenceState == 15) {
    char1_x += walkSpeed;
    return;
  }
  
  // Gerakkan karakter dari kanan ke kiri sampai target position (untuk state awal)
  if (!char1_arrived && char1_x > char1_target) {
    char1_x -= walkSpeed;
    if (char1_x <= char1_target) {
      char1_x = char1_target;
      char1_arrived = true;
    }
  }
  
  if (!char2_arrived && char2_x > char2_target) {
    char2_x -= walkSpeed;
    if (char2_x <= char2_target) {
      char2_x = char2_target;
      char2_arrived = true;
    }
  }
  
  if (!char3_arrived && char3_x > char3_target) {
    char3_x -= walkSpeed;
    if (char3_x <= char3_target) {
      char3_x = char3_target;
      char3_arrived = true;
    }
  }
  
  // Cek apakah semua karakter sudah sampai
  if (char1_arrived && char2_arrived && char3_arrived && !allArrived) {
    allArrived = true;
    sequenceStartTime = millis();
    currentSequenceState = 1; // Mulai sequence
  }
}

// Function untuk update sequence timing
void updateSequence() {
  if (!allArrived) return;
  
  int elapsedTime = millis() - sequenceStartTime;
  
  switch(currentSequenceState) {
    case 1: // Waiting 2 seconds after arrival
      if (elapsedTime >= 2000) {
        currentSequenceState = 2;
        sequenceStartTime = millis();
      }
      break;
      
    case 2: // Char1 takbir for 2 seconds
      if (elapsedTime >= 2000) {
        currentSequenceState = 3;
        sequenceStartTime = millis();
      }
      break;
      
    case 3: // Char1 salat + wait 1 second
      if (elapsedTime >= 1000) {
        currentSequenceState = 4;
        sequenceStartTime = millis();
      }
      break;
      
    case 4: // Char2 & Char3 takbir for 2 seconds
      if (elapsedTime >= 2000) {
        currentSequenceState = 5;
        sequenceStartTime = millis();
      }
      break;
      
    case 5: // Char2 & Char3 salat + wait 10 seconds
      if (elapsedTime >= 10000) {
        currentSequenceState = 6;
        sequenceStartTime = millis();
      }
      break;
      
    case 6: // Char1 takbir again for 2 seconds
      if (elapsedTime >= 2000) {
        currentSequenceState = 7;
        sequenceStartTime = millis();
      }
      break;
      
    case 7: // Char1 rukuk + wait 1 second
      if (elapsedTime >= 1000) {
        currentSequenceState = 8;
        sequenceStartTime = millis();
      }
      break;
      
    case 8: // Char2 & Char3 takbir again for 2 seconds
      if (elapsedTime >= 2000) {
        currentSequenceState = 9;
        sequenceStartTime = millis();
      }
      break;
      
    case 9: // Char2 & Char3 rukuk + wait 5 seconds
      if (elapsedTime >= 5000) {
        currentSequenceState = 10;
        sequenceStartTime = millis();
      }
      break;
      
    case 10: // Char1 kentut + wait 2 seconds
      if (elapsedTime >= 2000) {
        currentSequenceState = 11;
        sequenceStartTime = millis();
      }
      break;
      
    case 11: // Char1 standing + wait 1 second
      if (elapsedTime >= 1000) {
        currentSequenceState = 12;
        sequenceStartTime = millis();
      }
      break;
      
    case 12: // Char1 flip + wait 2 seconds
      if (elapsedTime >= 1000) {
        currentSequenceState = 13;
        sequenceStartTime = millis();
        dialogChangeTime = millis();
      }
      break;
      
    case 13: // Char1 berbicara for 2 seconds
      updateDialogAnimation();
      if (elapsedTime >= 2000) {
        currentSequenceState = 14;
        sequenceStartTime = millis();
      }
      break;
      
    case 14: // Char1 flip again + prepare to walk
      if (elapsedTime >= 500) {
        currentSequenceState = 15;
        sequenceStartTime = millis();
      }
      break;
      
    case 15: // Char1 walk out to right
      // Check if char1 is off screen to start zoom
      if (char1_x > width + 200) {
        currentSequenceState = 16;
        sequenceStartTime = millis();
        zoomToChar2 = true;
      }
      break;
      
    case 16: // Zoom to char2 for 3 seconds
      if (elapsedTime >= 5000) {
        currentSequenceState = 17;
        sequenceStartTime = millis();
        showRedX = true;
      }
      break;
      
    case 17: // Red X animation for 10 seconds
      updateRedXAnimation();
      if (elapsedTime >= 8000) {
        currentSequenceState = 18;
        sequenceStartTime = millis();
      }
      break;
      
    case 18: // Scene 1 complete - pindah otomatis ke scene 2
      if (elapsedTime >= 1000) { // Jeda 1 detik sebelum pindah scene
        changeScene(2);
      }
      break;
  }
}

// Function untuk update dialog animation
void updateDialogAnimation() {
  // Animasi mulut setiap 200ms
  int mouthCycle = (millis() / 200) % 3;
  switch(mouthCycle) {
    case 0: currentDialogImage = char1_batal; break;
    case 1: currentDialogImage = char1_batal_a_mouth; break;
    case 2: currentDialogImage = char1_batal_o_mouth; break;
  }
}

// Function untuk update zoom
void updateZoom() {
  if (zoomToChar2 && zoomLevel < targetZoom) {
    zoomLevel += 0.05; // Smooth zoom in
    if (zoomLevel >= targetZoom) {
      zoomLevel = targetZoom;
    }
  }
}

// Function untuk update red X animation
void updateRedXAnimation() {
  // Pop-up animation - scale in and pulse
  int elapsedTime = millis() - sequenceStartTime;
  
  if (elapsedTime < 500) {
    // Scale in animation
    redXScale = map(elapsedTime, 0, 500, 0, maxRedXSize * 1.2);
  } else if (elapsedTime < 1000) {
    // Bounce back
    redXScale = map(elapsedTime, 500, 1000, maxRedXSize * 1.2, maxRedXSize);
  } else {
    // Pulse animation
    float pulsePhase = (elapsedTime - 1000) / 1000.0;
    redXScale = maxRedXSize + sin(pulsePhase * PI * 4) * 0.05;
  }
}

// Function untuk draw red X
void drawRedX() {
  pushMatrix();
  translate(width/2, height/2);
  scale(redXScale);
  imageMode(CENTER);
  image(red_x, 0, 0);
  imageMode(CORNER);
  popMatrix();
}
