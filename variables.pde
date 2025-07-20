// Variables untuk scene management
int currentScene = 0;

// Variables untuk animasi karakter
float char1_x = 1400; // Mulai dari kanan layar
float char2_x = 1500; 
float char3_x = 1600;
float walkSpeed = 5.0; // Kecepatan jalan

// Posisi Y karakter (dibuat global)
int char1_y = 270;
int char2_y = 270;
int char3_y = 270;

// Target posisi (posisi berhenti)
float char1_target = 200;
float char2_target = 300;
float char3_target = 290;

// Status apakah karakter sudah sampai target
boolean char1_arrived = false;
boolean char2_arrived = false;
boolean char3_arrived = false;

// Variables untuk timing sequence
int sequenceStartTime = 0;
int currentSequenceState = 0;
// Scene 1 States: 0 = walking, 1 = waiting 2 seconds, 2 = char1 takbir, 3 = char1 salat + wait 1 sec, 
// 4 = char2&3 takbir, 5 = char2&3 salat + wait 10 sec, 6 = char1 takbir again, 
// 7 = char1 rukuk + wait 1 sec, 8 = char2&3 takbir again, 9 = char2&3 rukuk + wait 5 sec,
// 10 = char1 kentut + wait 2 sec, 11 = char1 standing + wait 1 sec, 12 = char1 flip + wait 2 sec,
// 13 = char1 berbicara 5 sec, 14 = char1 flip again, 15 = char1 walk out,
// 16 = wait for char1 to exit + zoom to char2, 17 = red X animation, 18 = scene complete

// Scene 2 States: 0 = walking, 1 = waiting 2 seconds, 2 = char1 takbir, 3 = char1 salat + wait 1 sec, 
// 4 = char2&3 takbir, 5 = char2&3 salat + wait 10 sec, 6 = char1 takbir again, 
// 7 = char1 rukuk + wait 1 sec, 8 = char2&3 takbir again, 9 = char2&3 rukuk + wait 5 sec,
// 10 = char1 kentut + wait 2 sec, 11 = char1 standing + wait 1 sec, 12 = char1 flip + wait 2 sec,
// 13 = char1 berbicara 5 sec, 14 = char1 flip again, 15 = char1 walk out,
// 16 = wait 2 sec after char1 exit, 17 = char2 move forward, 18 = char2 takbir 2 sec,
// 19 = char2 standing + wait 1 sec, 20 = red X animation, 21 = scene complete
boolean allArrived = false;

// Variables untuk dialog char1
int dialogChangeTime = 0;
PImage currentDialogImage;

// Variables untuk zoom dan red X
float zoomLevel = 1.5;
float targetZoom = 2.5;
boolean zoomToChar2 = false;
boolean showRedX = false;
float redXScale = 0.0;
float maxRedXSize = 0.4; // Ukuran maksimal red X (lebih kecil)

// Variables untuk mengatur posisi zoom
float zoomOffsetX = 350;   // Offset horizontal dari center char2&char3
float zoomOffsetY = 300; // Offset vertikal dari center char2&char3 (negatif = ke atas)

// Variables untuk scene 2 - char2 movement
float char2_moveTarget = 100; // Target posisi char2 maju
boolean char2_moving = false;

boolean showGreenCheck = false;
float greenCheckScale = 0.0;
float maxGreenCheckSize = 0.4;

// Bird variables
float[] birdX = new float[8]; 
float[] birdY = new float[8];
float[] birdSpeed = new float[8];

// Variables untuk scene imam menjelaskan (tambahkan di bagian atas kode)
float zoom = 1.0;
float zoomSpeed = 0.02;
boolean imamMulaiNgomong = false;
int waktuMulaiNgomong = 0;
int durasiNgomong = 27000; // 10 detik
boolean imamDiamSetelahNgomong = false;
int waktuMulaiDiam = 0;
int delaySetelahNgomong = 1000; // 1 detik delay
boolean scenePenutupDimulai = false;
int waktuscenePenutupMulai = 0;

// Variables untuk posisi imam
float imamX = 150; // Sama dengan char1_target
float imamY = 270;

// Variables untuk scene ngobrol (DIPERBAIKI)
int ngobrolStartTime = 0;
int ngobrolCurrentState = 0;
boolean ngobrolInitialized = false;
int dialogSwitchTime = 0;
boolean char2Speaking = true;

int luarMasjidStartTime = 0;

// Posisi karakter untuk scene ngobrol (di tengah layar)
float char2_ngobrol_x = 0;  // Posisi yang diinginkan
float char2_ngobrol_y = 270;  // Posisi Y yang sesuai
float char3_ngobrol_x = 650;  // Posisi yang diinginkan  
float char3_ngobrol_y = 0;  // Posisi Y yang sesuai

// Posisi awal untuk reset (HARUS SAMA dengan posisi di atas)
float char2_ngobrol_start_x = 0;  // Sama dengan char2_ngobrol_x
float char3_ngobrol_start_x = 50;  // Sama dengan char3_ngobrol_x

// Variables untuk scene masuk masjid (tambahkan di bagian atas kode)
int masukMasjidStartTime = 0;
int masukMasjidCurrentState = 0;
boolean masukMasjidInitialized = false;

// Posisi karakter untuk scene masuk masjid
float char2_masuk_x = 0;  // Mulai dari kanan
float char2_masuk_y = 270;   // Posisi Y sesuai ground
float char3_masuk_x = 0;  // Mulai dari kanan (sedikit belakang)
float char3_masuk_y = 270;   // Posisi Y sesuai ground

// Posisi awal untuk reset
float char2_masuk_start_x = 1500;
float char3_masuk_start_x = 1550;

import processing.sound.*;

SoundFile backgroundMusic;
boolean audioLoaded = false;
