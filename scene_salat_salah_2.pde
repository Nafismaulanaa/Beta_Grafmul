// Scene 2 function - dimulai dari posisi salat
void scene_salah_2() {
  // Draw background
  drawWindows();
  drawDots();
  drawFloor();
  
  // Draw characters
  drawCharacters2();
  
  // Update posisi karakter
  updateCharacterMovement2();
  
  // Update sequence timing
  updateSequence2();
  
  // Draw red X on top
  if (showRedX && red_x != null) {
    drawRedX();
  }
}

// Function untuk draw karakter scene 2
void drawCharacters2() {
  // Tentukan image mana yang akan ditampilkan berdasarkan sequence state
  PImage char1_img = getChar1ImageScene2();
  PImage char2_img = getChar2ImageScene2();
  PImage char3_img = getChar3ImageScene2();
  
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

// Function untuk mendapatkan image char1 scene 2
PImage getChar1ImageScene2() {
  switch(currentSequenceState) {
    case 25: return char1_salat;                    // State 25 = salat 10 detik
    case 26: return char1_takbir_a_mouth;          // State 26 = char1 takbir 2 detik
    case 27: case 28: case 29: return char1_rukuk; // State 27-29 = char1 rukuk + jeda + semua rukuk
    case 30: return char1_rukuk_ketut;             // State 30 = char1 kentut 5 detik
    case 31: return char1_standing;                // State 31 = char1 berdiri + berbalik 1 detik
    case 32: return char1_standing_flip;           // State 32 = char1 flip position
    case 33: return currentDialogImage;            // State 33 = char1 ngomong 3 detik
    case 34: return char1_standing_flip;           // State 34 = char1 berdiri terbalik 1 detik
    case 35: return char1_standing_flip;           // State 35 = char1 jalan keluar
    // State 36 ke atas: char1 sudah keluar
    default: return null;
  }
}

// Function untuk mendapatkan image char2 scene 2
PImage getChar2ImageScene2() {
  switch(currentSequenceState) {
    case 25: case 26: case 27: return char2_salat;    // State 25-27 = salat + char1 takbir + char1 rukuk + jeda
    case 28: return char2_takbir_a_mouth;             // State 28 = char2 takbir 2 detik
    case 29: case 30: case 31: case 32: case 33: case 34: case 35: case 36: case 37: return char2_rukuk; // State 29-37 = rukuk
    case 38: return char2_takbir_a_mouth;             // State 38 = char2 takbir 2 detik
    case 39: case 40: return char2_standing;          // State 39-40 = char2 berdiri 3 detik + red X
    default: return char2_standing;
  }
}

// Function untuk mendapatkan image char3 scene 2
PImage getChar3ImageScene2() {
  switch(currentSequenceState) {
    case 25: case 26: case 27: return char3_salat;    // State 25-27 = salat + char1 takbir + char1 rukuk + jeda
    case 28: return char3_takbir_a_mouth;             // State 28 = char3 takbir 2 detik
    case 29: case 30: case 31: case 32: case 33: case 34: case 35: case 36: case 37: case 38: case 39: case 40: case 41: return char3_rukuk; // State 29-40 = rukuk sampai selesai
    default: return char3_standing;
  }
}

// Function untuk update pergerakan karakter scene 2 (yang benar)
void updateCharacterMovement2() {
  // State 35: char1 berjalan keluar ke kanan
  if (currentSequenceState == 35) {
    char1_x += walkSpeed;
    return;
  }
  
  // State 36: char2 bergerak maju dalam posisi rukuk
  if (currentSequenceState == 36 && char2_moving) {
    println("Char2 bergerak maju - pos: " + char2_x + " target: " + char2_moveTarget); // Debug
    
    if (char2_x > char2_moveTarget) {
      char2_x -= walkSpeed;
      if (char2_x <= char2_moveTarget) {
        char2_x = char2_moveTarget;
        char2_moving = false;
        println("Char2 sampai target!"); // Debug
        // Lanjut ke state berikutnya setelah sampai target
        currentSequenceState = 37;
        sequenceStartTime = millis();
      }
    }
    return;
  }
}

// Function untuk update sequence timing scene 2
void updateSequence2() {
  if (!allArrived) return;
  
  int elapsedTime = millis() - sequenceStartTime;
  
  switch(currentSequenceState) {
    case 25: // Semua karakter salat selama 10 detik
      if (elapsedTime >= 10000) {
        currentSequenceState = 26;
        sequenceStartTime = millis();
      }
      break;
      
    case 26: // Char1 takbir selama 2 detik
      if (elapsedTime >= 2000) {
        currentSequenceState = 27;
        sequenceStartTime = millis();
      }
      break;
      
    case 27: // Char1 rukuk + jeda 1 detik
      if (elapsedTime >= 1000) {
        currentSequenceState = 28;
        sequenceStartTime = millis();
      }
      break;
      
    case 28: // Char2 & Char3 takbir selama 2 detik
      if (elapsedTime >= 2000) {
        currentSequenceState = 29;
        sequenceStartTime = millis();
      }
      break;
      
    case 29: // Char2 & Char3 rukuk + jeda 5 detik setelah semua rukuk
      if (elapsedTime >= 5000) {
        currentSequenceState = 30;
        sequenceStartTime = millis();
      }
      break;
      
    case 30: // Char1 kentut selama 5 detik
      if (elapsedTime >= 5000) {
        currentSequenceState = 31;
        sequenceStartTime = millis();
      }
      break;
      
    case 31: // Char1 kembali berdiri dan berbalik selama 1 detik
      if (elapsedTime >= 1000) {
        currentSequenceState = 32;
        sequenceStartTime = millis();
      }
      break;
      
    case 32: // Transisi ke posisi flip (instant)
      currentSequenceState = 33;
      sequenceStartTime = millis();
      dialogChangeTime = millis();
      break;
      
    case 33: // Char1 ngomong selama 3 detik
      updateDialogAnimation();
      if (elapsedTime >= 3000) {
        currentSequenceState = 34;
        sequenceStartTime = millis();
      }
      break;
      
    case 34: // Char1 kembali ke posisi berdiri terbalik selama 1 detik
      if (elapsedTime >= 1000) {
        currentSequenceState = 35;
        sequenceStartTime = millis();
      }
      break;
      
    case 35: // Char1 berjalan keluar frame
    // Check if char1 is off screen
    if (char1_x > width + 200) {
      println("Char1 keluar frame, mulai char2 movement"); // Debug
      currentSequenceState = 36;
      sequenceStartTime = millis();
      char2_moving = true; // Start char2 movement
    }
    break;
  
    case 36: // Char2 maju dalam keadaan rukuk (handled in updateCharacterMovement2)
    // Movement is handled in updateCharacterMovement2
    // This state will be changed to 37 when char2 reaches target
    // Debug: print current state
    println("State 36 - Char2 moving: " + char2_moving + ", pos: " + char2_x);
    break;
      
    case 37: // Jeda 1 detik setelah char2 selesai maju
      if (elapsedTime >= 1000) {
        currentSequenceState = 38;
        sequenceStartTime = millis();
      }
      break;
      
    case 38: // Char2 takbir selama 2 detik
      if (elapsedTime >= 2000) {
        currentSequenceState = 39;
        sequenceStartTime = millis();
      }
      break;
      
    case 39: // Char2 berdiri biasa selama 3 detik
      if (elapsedTime >= 1000) {
        currentSequenceState = 40;
        sequenceStartTime = millis();
        showRedX = true;
      }
      break;
      
    case 40: // Red X pop up
      updateRedXAnimation();
      if (elapsedTime >= 8000) {
        currentSequenceState = 41;
        sequenceStartTime = millis();
      }
      break;
      
    case 41: // Scene 2 complete - pindah otomatis ke scene benar
      if (elapsedTime >= 1000) { // Jeda 1 detik sebelum pindah scene
        changeScene(3); // Pindah ke scene benar
      }
      break;
  }
}
