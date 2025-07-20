void scene_benar() {
  // Draw background
  drawWindows();
  drawDots();
  drawFloor();
  
  // Draw characters
  drawCharactersBenar();
  
  // Update posisi karakter
  updateCharacterMovementBenar();
  
  // Update sequence timing
  updateSequenceBenar();
  
  // Draw green checkmark on top (gunakan green_check image)
  if (showGreenCheck && green_check != null) {
    drawGreenCheck();
  }
}

// Function untuk draw karakter scene benar
void drawCharactersBenar() {
  // Tentukan image mana yang akan ditampilkan berdasarkan sequence state
  PImage char1_img = getChar1ImageBenar();
  PImage char2_img = getChar2ImageBenar();
  PImage char3_img = getChar3ImageBenar();
  
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

// Function untuk mendapatkan image char1 scene benar
PImage getChar1ImageBenar() {
  switch(currentSequenceState) {
    case 50: return char1_salat;                    // State 50 = salat 10 detik
    case 51: return char1_takbir_a_mouth;          // State 51 = char1 takbir 2 detik
    case 52: case 53: case 54: return char1_rukuk; // State 52-54 = char1 rukuk + jeda + semua rukuk
    case 55: return char1_rukuk_ketut;             // State 55 = char1 kentut 5 detik
    case 56: return char1_standing;                // State 56 = char1 berdiri + berbalik 1 detik
    case 57: return char1_standing_flip;           // State 57 = char1 flip position
    case 58: return currentDialogImage;            // State 58 = char1 ngomong 3 detik
    case 59: return char1_standing_flip;           // State 59 = char1 berdiri terbalik 1 detik
    case 60: return char1_standing_flip;           // State 60 = char1 jalan keluar
    // State 61 ke atas: char1 sudah keluar
    default: return null;
  }
}

// Function untuk mendapatkan image char2 scene benar
PImage getChar2ImageBenar() {
  switch(currentSequenceState) {
    case 50: case 51: case 52: return char2_salat;    // State 50-52 = salat + char1 takbir + char1 rukuk + jeda
    case 53: return char2_takbir_a_mouth;             // State 53 = char2 takbir 2 detik
    case 54: case 55: case 56: case 57: case 58: case 59: case 60: case 61: return char2_rukuk; // State 54-61 = rukuk
    case 62: return char2_takbir_a_mouth;             // State 62 = char2 takbir 2 detik
    case 63: return char2_standing;                   // State 63 = char2 berdiri 1 detik
    case 64: case 65: return char2_standing;          // State 64-65 = char2 maju + berdiri + green check
    default: return char2_standing;
  }
}

// Function untuk mendapatkan image char3 scene benar
PImage getChar3ImageBenar() {
  switch(currentSequenceState) {
    case 50: case 51: case 52: return char3_salat;    // State 50-52 = salat + char1 takbir + char1 rukuk + jeda
    case 53: return char3_takbir_a_mouth;             // State 53 = char3 takbir 2 detik
    case 54: case 55: case 56: case 57: case 58: case 59: case 60: case 61: case 62: case 63: case 64: case 65: case 66: return char3_rukuk; // State 54-65 = rukuk sampai selesai
    default: return char3_standing;
  }
}

// Function untuk update pergerakan karakter scene benar
void updateCharacterMovementBenar() {
  // State 60: char1 berjalan keluar ke kanan
  if (currentSequenceState == 60) {
    char1_x += walkSpeed;
    return;
  }
  
  // State 64: char2 bergerak maju dalam posisi standing
  if (currentSequenceState == 64 && char2_moving) {
    println("Char2 bergerak maju (scene benar) - pos: " + char2_x + " target: " + char2_moveTarget); // Debug
    
    if (char2_x > char2_moveTarget) {
      char2_x -= walkSpeed;
      if (char2_x <= char2_moveTarget) {
        char2_x = char2_moveTarget;
        char2_moving = false;
        println("Char2 sampai target (scene benar)!"); // Debug
        // Lanjut ke state berikutnya setelah sampai target
        currentSequenceState = 65;
        sequenceStartTime = millis();
      }
    }
    return;
  }
}

// Function untuk update sequence timing scene benar
void updateSequenceBenar() {
  if (!allArrived) return;
  
  int elapsedTime = millis() - sequenceStartTime;
  
  switch(currentSequenceState) {
    case 50: // Semua karakter salat selama 10 detik
      if (elapsedTime >= 10000) {
        currentSequenceState = 51;
        sequenceStartTime = millis();
      }
      break;
      
    case 51: // Char1 takbir selama 2 detik
      if (elapsedTime >= 2000) {
        currentSequenceState = 52;
        sequenceStartTime = millis();
      }
      break;
      
    case 52: // Char1 rukuk + jeda 1 detik
      if (elapsedTime >= 1000) {
        currentSequenceState = 53;
        sequenceStartTime = millis();
      }
      break;
      
    case 53: // Char2 & Char3 takbir selama 2 detik
      if (elapsedTime >= 2000) {
        currentSequenceState = 54;
        sequenceStartTime = millis();
      }
      break;
      
    case 54: // Char2 & Char3 rukuk + jeda 5 detik setelah semua rukuk
      if (elapsedTime >= 5000) {
        currentSequenceState = 55;
        sequenceStartTime = millis();
      }
      break;
      
    case 55: // Char1 kentut selama 5 detik
      if (elapsedTime >= 5000) {
        currentSequenceState = 56;
        sequenceStartTime = millis();
      }
      break;
      
    case 56: // Char1 kembali berdiri dan berbalik selama 1 detik
      if (elapsedTime >= 1000) {
        currentSequenceState = 57;
        sequenceStartTime = millis();
      }
      break;
      
    case 57: // Transisi ke posisi flip (instant)
      currentSequenceState = 58;
      sequenceStartTime = millis();
      dialogChangeTime = millis();
      break;
      
    case 58: // Char1 ngomong selama 3 detik
      updateDialogAnimation();
      if (elapsedTime >= 3000) {
        currentSequenceState = 59;
        sequenceStartTime = millis();
      }
      break;
      
    case 59: // Char1 kembali ke posisi berdiri terbalik selama 1 detik
      if (elapsedTime >= 1000) {
        currentSequenceState = 60;
        sequenceStartTime = millis();
      }
      break;
      
    case 60: // Char1 berjalan keluar frame
      // Check if char1 is off screen
      if (char1_x > width + 200) {
        println("Char1 keluar frame (scene benar), char2 takbir dulu"); // Debug
        currentSequenceState = 61;
        sequenceStartTime = millis();
      }
      break;
    
    case 61: // Tunggu setelah char1 keluar (optional delay)
      if (elapsedTime >= 500) { // Jeda 0.5 detik
        currentSequenceState = 62;
        sequenceStartTime = millis();
      }
      break;
      
    case 62: // Char2 takbir selama 2 detik
      if (elapsedTime >= 2000) {
        currentSequenceState = 63;
        sequenceStartTime = millis();
      }
      break;
      
    case 63: // Char2 berdiri biasa selama 1 detik
      if (elapsedTime >= 1000) {
        currentSequenceState = 64;
        sequenceStartTime = millis();
        char2_moving = true; // Start char2 movement
      }
      break;
      
    case 64: // Char2 maju dalam keadaan standing (handled in updateCharacterMovementBenar)
      // Movement is handled in updateCharacterMovementBenar
      // This state will be changed to 65 when char2 reaches target
      println("State 64 - Char2 moving: " + char2_moving + ", pos: " + char2_x);
      break;
      
    case 65: // Green check pop up
      updateGreenCheckAnimation();
      if (elapsedTime >= 8000) {
        currentSequenceState = 66;
        sequenceStartTime = millis();
      }
      break;
      
    case 66: // Scene benar complete - pindah otomatis ke scene imam menjelaskan
    if (elapsedTime >= 1000) { // Jeda 1 detik sebelum pindah scene
      changeScene(4); // Pindah ke scene imam menjelaskan
    }
    break;
  }
}

// Function untuk update green check animation
void updateGreenCheckAnimation() {
  // Pop-up animation - scale in and pulse (sama seperti red X tapi hijau)
  int elapsedTime = millis() - sequenceStartTime;
  
  if (elapsedTime < 500) {
    // Scale in animation
    greenCheckScale = map(elapsedTime, 0, 500, 0, maxGreenCheckSize * 1.2);
    showGreenCheck = true;
  } else if (elapsedTime < 1000) {
    // Bounce back
    greenCheckScale = map(elapsedTime, 500, 1000, maxGreenCheckSize * 1.2, maxGreenCheckSize);
  } else {
    // Pulse animation
    float pulsePhase = (elapsedTime - 1000) / 1000.0;
    greenCheckScale = maxGreenCheckSize + sin(pulsePhase * PI * 4) * 0.05;
  }
}

// Function untuk draw green check
void drawGreenCheck() {
  pushMatrix();
  translate(width/2, height/2);
  scale(greenCheckScale);
  imageMode(CENTER);
  image(green_check, 0, 0);
  imageMode(CORNER);
  popMatrix();
}
