void setup() {
  size(1280, 720);
  frameRate(60);
  
  // Load dan play background music "audio-grafmul"
  try {
    backgroundMusic = new SoundFile(this, "audio_grafmul_fix.MP3");
    audioLoaded = true;
    
    // Langsung play dan loop
    backgroundMusic.loop();
    backgroundMusic.amp(1); // Volume 100%
    
    println("Audio 'audio-grafmul' loaded and playing!");
    
  } catch (Exception e) {
    println("Error loading audio: " + e.getMessage());
    audioLoaded = false;
  }
  
  // Load standing images
  char1_standing = loadImage("char1_standing.png");
  char2_standing = loadImage("char2_standing.png");
  char3_standing = loadImage("char3_standing.png");
  
  // Load takbir images
  char1_takbir_a_mouth = loadImage("char1_takbir_a mouth.png");
  char2_takbir_a_mouth = loadImage("char2_takbir_a mouth.png");
  char3_takbir_a_mouth = loadImage("char3_takbir_a mouth.png");
  
  // Load salat images
  char1_salat = loadImage("char1_salat.png");
  char2_salat = loadImage("char2_salat.png");
  char3_salat = loadImage("char3_salat.png");
  
  // Load rukuk images
  char1_rukuk = loadImage("char1_rukuk.png");
  char2_rukuk = loadImage("char2_rukuk.png");
  char3_rukuk = loadImage("char3_rukuk.png");
  
  // Load char1 special images
  char1_rukuk_ketut = loadImage("char1_rukuk_ketut.png");
  char1_standing_flip = loadImage("char1_standing_flip.png");
  
  // Load char1 dialog images
  char1_batal = loadImage("char1_batal.png");
  char1_batal_a_mouth = loadImage("char1_batal_a mouth.png");
  char1_batal_o_mouth = loadImage("char1_batal_o mouth.png");
  
  // Load red X image
  red_x = loadImage("red_x.png");
  
  green_check = loadImage("green_check.png");
  
  // Initialize birds
  initializeBirds();
  
  img1 = loadImage("char1_standing.png");        
  img1_aMouth = loadImage("char1_standing_a mouth.png");
  img1_oMouth = loadImage("char1_standing_o mouth.png");
  
  // Load images untuk scene ngobrol
  char2_standing_flip = loadImage("char2_standing_flip.png");
  char2_standing_a_mouth_flip = loadImage("char2_standing_a mouth_flip.png");
  char3_standing = loadImage("char3_standing.png");
  char3_standing_a_mouth = loadImage("char3_standing_a mouth.png");
  
  pixelFont = createFont("PressStart2P-Regular.ttf", 64);
}

void draw() {
  // Scene management
  if (currentScene == 0) {
    scene_luar_masjid(); 
  } else if (currentScene == 6) {
    scene_ngobrol();  
  } else if (currentScene == 7) {
    scene_masuk_masjid();   
  } else if (currentScene == 1) {
    scene_salah_1();        
  } else if (currentScene == 2) {
    scene_salah_2();        
  } else if (currentScene == 3) {
    scene_benar();        
  } else if (currentScene == 4) {
    scene_imam_menjelaskan(); 
  } else if (currentScene == 5) {
    scene_penutup();            
  }
}
