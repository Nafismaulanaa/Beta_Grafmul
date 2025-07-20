// Scene Imam Menjelaskan function
void scene_imam_menjelaskan() {
  // Draw background
  drawWindows();
  drawDots();
  drawFloor();
  
  // Smooth Zoom
  if (zoom < targetZoom) {
    zoom += zoomSpeed;
    if (zoom >= targetZoom) {
      zoom = targetZoom;
      imamMulaiNgomong = true;
      waktuMulaiNgomong = millis();
    }
  }
  
  pushMatrix();
  float centerX = imamX + img1.width / 3;
  float centerY = imamY + img1.height / 2.3;
  translate(width / 2, height / 2);
  scale(zoom);
  translate(-centerX, -centerY);
  
  // Imam Ngomong (animasi mulut)
  if (imamMulaiNgomong && millis() - waktuMulaiNgomong < durasiNgomong) {
    int waktuNgomong = millis() - waktuMulaiNgomong;
    int frame = (waktuNgomong / 400) % 4;
    if (frame == 0 || frame == 2) {
      image(img1, imamX, imamY);  // netral
    } else if (frame == 1) {
      image(img1_aMouth, imamX, imamY);  // mulut "a"
    } else {
      image(img1_oMouth, imamX, imamY);  // mulut "o"
    }
  } else {
    image(img1, imamX, imamY);
    
    if (imamMulaiNgomong && !imamDiamSetelahNgomong) {
      imamDiamSetelahNgomong = true;
      waktuMulaiDiam = millis();
    }
    if (imamDiamSetelahNgomong && millis() - waktuMulaiDiam >= delaySetelahNgomong) {
      if (!scenePenutupDimulai) {
        scenePenutupDimulai = true;
        waktuscenePenutupMulai = millis();
        changeScene(5); // Scene penutup = scene 5
      }
    }
  }
  
  popMatrix();
}
