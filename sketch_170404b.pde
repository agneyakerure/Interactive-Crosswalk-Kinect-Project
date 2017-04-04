import KinectPV2.KJoint;
import KinectPV2.*;

int t;
int interval = 10;

PVector circlePosition;
ArrayList<PVector> circleTrail;
int trailSize = 2000;
KinectPV2 kinect;
float c;

void setup() {
  size(1920, 1080, P3D);

  background(0); //set background white
  colorMode(HSB);   //set colors to Hue, Saturation, Brightness mode

  circlePosition = new PVector(width, width);
  circleTrail = new ArrayList<PVector>();

  kinect = new KinectPV2(this);

  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);

  kinect.init();
}

void draw() {
  //translate(width, 0);
  //rotateZ(radians(90));
  //scale(0.56, 1.77);
  
  
  background(255);
  strokeWeight(10);
  //ellipse(0,0, 40, 40);
  int trailLength;
  //image(kinect.getColorImage(), 0, 0, width, height);
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

  //individual JOINTS
  for(int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(0);
    KJoint[] joints = skeleton.getJoints();
    pushMatrix();
    translate(0, 1260);
    scale(1, 0.41);

 //if (skeleton.isTracked())
    {
     
        circlePosition = new PVector(joints[KinectPV2.JointType_HandRight].getX(), joints[KinectPV2.JointType_HandRight].getY());
        
        circleTrail.add(circlePosition);
        trailLength = circleTrail.size() - 2;
        
        for (int m = 0; m < trailLength; m++)
        {

          PVector cT = circleTrail.get(m);
          //PVector pT = circleTrail.get(m + 1);
          
          //strokeWeight(40);
          //line(cT.x, cT.y, pT.x, pT.y);
      if (joints[KinectPV2.JointType_HandRight].getState() != KinectPV2.HandState_Closed)
      {
        fill(random(255), random(255), random(255));
       
      
          noStroke();
          smooth();

          ellipse(cT.x, cT.y, 40, 40);
          scale(1, -1);
          translate(0, ((height-800)*1080/450));
          //line(cT.x, cT.y, pT.x, pT.y);
          ellipse(cT.x, cT.y, 40, 40);
        }
        }
      
      //drawBody(joints);
      //draw different color for each hand state
      //drawHandState(joints[KinectPV2.JointType_HandRight]);
      //drawHandState(joints[KinectPV2.JointType_HandLeft]);
    }
    ellipse(joints[KinectPV2.JointType_HandRight].getX(), joints[KinectPV2.JointType_HandRight].getY(), 30, 30);
    popMatrix();
  }
  stroke(0);
  t = interval - int(millis()/1000);
  if(t <= 0)
  {
    
  PImage c = get(0, (height-450), width, 450);
  c.save("Output.jpg");
  
  image(c, 0, 450, width, (height-900));
  noLoop();
  fill(255);
  rect(0,0,width,450);
  rect(0, height-450, width, 450);
  
  //interval+=20;
  }
  line(0, 450, width, 450);
  line(0, height-450, width, height-450);
  PImage blo;
  blo = loadImage("tree.png");
  image(blo, 30, 30, 200, 200);
  image(blo, 330, 30, 200, 200);
  image(blo, 630, 30, 200, 200);
  
  image(blo, 30, 1400, 200, 200);
  image(blo, 330, 1400, 200, 200);
  image(blo, 630, 1400, 200, 200);
  
  image(blo, 30+1900, 30, 200, 200);
  image(blo, 330+1900, 30, 200, 200);
  image(blo, 630+1900, 30, 200, 200);
  
  image(blo, 30+1900, 1400, 200, 200);
  image(blo, 330+1900, 1400, 200, 200);
  image(blo, 630+1900, 1400, 200, 200);
  
  rect(900, 450, 1000, 60); 
  rect(900, 510, 1000, 60); 
  rect(900, 570, 1000, 60); 
  rect(900, 630, 1000, 60); 
  rect(900, 690, 1000, 60); 
  rect(900, 750, 1000, 60); 
    rect(900, 750+60, 1000, 60); 
      rect(900, 750+60+60, 1000, 60); 
        rect(900, 750+60+60+60, 1000, 60); 
          rect(900, 750+60+60+60+60, 1000, 60); 
          
  
  println( (width-900)/17);
  //image(blo, 30, 30, 200, 200);
  //image(blo, 30, 30, 200, 200);
  //image(blo, 30, 30, 200, 200);
  //image(blo, 30, 30, 200, 200);
  text(frameRate, 50, 50);
}

//DRAW BODY
void drawBody(KJoint[] joints) {
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
  drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);

  // Right Arm
  drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);

  // Left Arm
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);

  // Right Leg
  drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);

  // Left Leg
  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);

  drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  drawJoint(joints, KinectPV2.JointType_HandTipRight);
  drawJoint(joints, KinectPV2.JointType_FootLeft);
  drawJoint(joints, KinectPV2.JointType_FootRight);

  drawJoint(joints, KinectPV2.JointType_ThumbLeft);
  drawJoint(joints, KinectPV2.JointType_ThumbRight);

  drawJoint(joints, KinectPV2.JointType_Head);
}

//draw joint
void drawJoint(KJoint[] joints, int jointType) {
  pushMatrix();
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
}

//draw bone
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}

//draw hand state
void drawHandState(KJoint joint) {
  noStroke();
  handState(joint.getState());
  pushMatrix();
  translate(joint.getX(), joint.getY(), joint.getZ());
  ellipse(0, 0, 70, 70);
  popMatrix();
}

/*
Different hand state
 KinectPV2.HandState_Open
 KinectPV2.HandState_Closed
 KinectPV2.HandState_Lasso
 KinectPV2.HandState_NotTracked
 */
void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    fill(0, 255, 0);
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    break;
  case KinectPV2.HandState_NotTracked:
    fill(255, 255, 255);
    break;
  }
}

void mousePressed() {
  ellipse( mouseX, mouseY, 2, 2 );
  println( "x: " + mouseX + " y: " + mouseY, mouseX + 2, mouseY );
}