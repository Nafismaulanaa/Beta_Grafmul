// Update changeScene() untuk scene 6 (DIPERBAIKI)
void changeScene(int sceneNumber) {
  currentScene = sceneNumber;
  
  if (sceneNumber == 0) {
    // Scene 0 = Luar Masjid
    luarMasjidStartTime = 0;
    println("Pindah ke Scene Luar Masjid");
    
  } else if (sceneNumber == 1) {
    // Scene 1 = Salah 1 (reset ke awal)
    char1_x = 1400;
    char2_x = 1500;
    char3_x = 1600;
    char1_arrived = false;
    char2_arrived = false;
    char3_arrived = false;
    allArrived = false;
    currentSequenceState = 0;
    sequenceStartTime = 0;
    dialogChangeTime = 0;
    
    // Reset effects
    zoomLevel = 1.0;
    zoomToChar2 = false;
    showRedX = false;
    redXScale = 0.0;
    showGreenCheck = false;
    greenCheckScale = 0.0;
    
    // Reset movement variables
    char2_moving = false;
    
    println("Pindah ke Scene Salah_1, State: " + currentSequenceState);
    
  } else if (sceneNumber == 2) {
    // Scene 2 = Salah 2 (mulai dari posisi salat)
    char1_x = char1_target;  // 150
    char2_x = char2_target;  // 300
    char3_x = char3_target;  // 290
    
    // Set status karakter
    char1_arrived = true;
    char2_arrived = true;
    char3_arrived = true;
    allArrived = true;
    
    // Set state dan timing untuk scene 2
    currentSequenceState = 25;
    sequenceStartTime = millis();
    
    // Reset effects
    zoomLevel = 1.0;
    zoomToChar2 = false;
    showRedX = false;
    redXScale = 0.0;
    showGreenCheck = false;
    greenCheckScale = 0.0;
    
    // Reset scene 2 variables
    char2_moving = false;
    dialogChangeTime = 0;
    
    println("Pindah ke Scene Salah_2, State: " + currentSequenceState);
    
  } else if (sceneNumber == 3) {
    // Scene 3 = Benar (mulai dari posisi salat)
    char1_x = char1_target;  // 150
    char2_x = char2_target;  // 300
    char3_x = char3_target;  // 290
    
    // Set status karakter
    char1_arrived = true;
    char2_arrived = true;
    char3_arrived = true;
    allArrived = true;
    
    // Set state dan timing untuk scene benar
    currentSequenceState = 50;
    sequenceStartTime = millis();
    
    // Reset effects
    zoomLevel = 1.0;
    zoomToChar2 = false;
    showRedX = false;
    redXScale = 0.0;
    showGreenCheck = false;
    greenCheckScale = 0.0;
    
    // Reset movement variables
    char2_moving = false;
    dialogChangeTime = 0;
    
    println("Pindah ke Scene Benar, State: " + currentSequenceState);
    
  } else if (sceneNumber == 4) {
    // Scene 4 = Imam Menjelaskan
    char1_x = char1_target;  // 150 (imam di posisi char1)
    char2_x = char2_target;  // 300
    char3_x = char3_target;  // 290
    
    // Set status karakter
    char1_arrived = true;
    char2_arrived = true;
    char3_arrived = true;
    allArrived = true;
    
    // Reset zoom variables untuk scene imam
    zoom = 1.0;
    targetZoom = 2.0;
    imamMulaiNgomong = false;
    waktuMulaiNgomong = 0;
    imamDiamSetelahNgomong = false;
    waktuMulaiDiam = 0;
    scenePenutupDimulai = false;
    waktuscenePenutupMulai = 0;
    
    // Reset other effects
    zoomLevel = 1.0;
    zoomToChar2 = false;
    showRedX = false;
    redXScale = 0.0;
    showGreenCheck = false;
    greenCheckScale = 0.0;
    
    // Reset movement variables
    char2_moving = false;
    dialogChangeTime = 0;
    
    println("Pindah ke Scene Imam Menjelaskan");
    
  } else if (sceneNumber == 5) {
    // Scene 5 = Penutup
    if (!scenePenutupDimulai) {
      scenePenutupDimulai = true;
      waktuscenePenutupMulai = millis();
    }
    
    // Reset all effects
    zoomLevel = 1.0;
    zoomToChar2 = false;
    showRedX = false;
    redXScale = 0.0;
    showGreenCheck = false;
    greenCheckScale = 0.0;
    zoom = 1.0;
    
    // Reset movement variables
    char2_moving = false;
    dialogChangeTime = 0;
    
    println("Pindah ke Scene Penutup");
    
  } else if (sceneNumber == 6) {
    // Scene 6 = Ngobrol (DIPERBAIKI)
    resetNgobrolPositions();  // Gunakan function reset yang benar
    
    println("Pindah ke Scene Ngobrol");
    println("char2 pos: " + char2_ngobrol_x + ", " + char2_ngobrol_y);
    println("char3 pos: " + char3_ngobrol_x + ", " + char3_ngobrol_y);
  } else if (sceneNumber == 7) {
    // Scene 7 = Masuk Masjid
    resetMasukMasjidPositions();
    
    println("Pindah ke Scene Masuk Masjid");
    println("char2 pos: " + char2_masuk_x + ", " + char2_masuk_y);
    println("char3 pos: " + char3_masuk_x + ", " + char3_masuk_y);
  }
}
