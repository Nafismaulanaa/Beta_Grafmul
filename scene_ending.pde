void scene_penutup() {
  background(#D2B48C);
  int waktuLalu = millis() - waktuscenePenutupMulai;
  int transisiText = int(map(constrain(waktuLalu, 0, 3000), 0, 3000, 0, 255));
  fill(255, transisiText);
  textAlign(CENTER, CENTER);
  textFont(pixelFont);
  textSize(64);
  text("TERIMA KASIH", width / 2, height / 2);
  
  if (waktuLalu >= 3000) {
    println("Animasi selesai.");
    // Close program
    exit();
  }
}
