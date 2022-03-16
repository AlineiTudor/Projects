#define G4 392
#define Bb 466
#define Dd 311
#define F4 349
#define C4 262
#define C5 523
#define Gd 415
const double twtwo=1.4137*1.4137*1.0594;//13 semitonuri mai jos
const int a=988/twtwo;
const int b=880/twtwo;
const int c=784/twtwo;
int speaker=9;
void EyeOfTheTiger();
//-----------------
#define tsensor 5
#define enable12 5
#define input1 3
#define input2 4
int temp=0;
long prev_time=0;
int temp_masurata();
void ventilator();
//-----------------
#define pir_sensor 12
#define bec 13
int prezenta=0;
long bec_prevtime=0;
void bec_aut();
//----------------
#define trigger 11
#define echo 10
float distanta;
void distance_alarm();
//--------------
void setup() {
  //buzzer
  pinMode(speaker,OUTPUT);
  
  //motor
  pinMode(input1,OUTPUT);
  pinMode(input2,OUTPUT);
  pinMode(enable12,OUTPUT);
  
  //bec+PIR
  pinMode(pir_sensor,INPUT);
  pinMode(bec,OUTPUT);
  
  //senzor ultrasonic
  pinMode(trigger,OUTPUT);
  pinMode(echo,INPUT);
  
  
  Serial.begin(9600);

}


void loop(){  
  ventilator();
  bec_aut();
  //Serial.println("merge");
  distance_alarm();
  //Serial.println("si de aici");
  //EyeOfTheTiger();
}

void distance_alarm(){
	int durata;
  	digitalWrite(trigger,HIGH);
  	digitalWrite(trigger,LOW);
  	durata=pulseIn(echo,HIGH);
  	distanta=(float)durata*0.01716;
  	//Serial.println(distanta);
    if(distanta<30){
    	EyeOfTheTiger();
    }
}

void bec_aut(){
  long c_time=millis();
  prezenta=digitalRead(pir_sensor);
  
  if(prezenta==HIGH){
    digitalWrite(bec,HIGH);
  }
  else{
    if(c_time-bec_prevtime>3000){
    	digitalWrite(bec,LOW);
      	bec_prevtime=c_time;
    }
  }
}

void ventilator(){
  long c_time=millis();
  temp=temp_masurata();
  if(c_time-prev_time>2000){
  	if(temp>20){
  	  analogWrite(enable12,temp);
      digitalWrite(input1,HIGH);
      digitalWrite(input2,LOW);
  	}else{
      analogWrite(enable12,0);
      digitalWrite(input1,HIGH);
      digitalWrite(input2,LOW);
  	}
    prev_time=c_time;
  }
}
int temp_masurata(){
  float u,gradeC;
  u=analogRead(tsensor)*0.0049;
  gradeC=(u-0.5)*100;
  return gradeC;
}


void EyeOfTheTiger(){
  
  //--------------
  for(int i=0;i<2;i++){
  tone(speaker, a);
  delay(1000);
  tone(speaker, a);
  delay(400);
  tone(speaker, b);
  delay(400);
  tone(speaker, a);
  delay(1000);
  
  tone(speaker, a);
  delay(400);
  tone(speaker, b);
  delay(400);
  tone(speaker, a);
  delay(1000);
  
  tone(speaker, a);
  delay(400);
  tone(speaker, b);
  delay(400);
  tone(speaker, c);
  delay(1000);
  tone(speaker, b);
  delay(1000);
  }
  
  //-------------
  
  noTone(speaker);
  delay(200);
  
  tone(speaker, G4);
  delay(300);
  noTone(speaker);
  tone(speaker,Bb);
  delay(300);
  noTone(speaker);
  tone(speaker,G4);
  delay(600);
  noTone(speaker);
  tone(speaker,F4);
  delay(400);
  noTone(speaker);
  tone(speaker,Dd);
  delay(300);
  noTone(speaker);
  tone(speaker,G4);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,Dd);
  delay(800);
  
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(400);
  noTone(speaker);
  tone(speaker,G4);
  delay(400);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,Dd);
  delay(500);
  
  noTone(speaker);
  tone(speaker,G4);
  delay(300);
  noTone(speaker);
  tone(speaker,Bb);
  delay(300);
  noTone(speaker);
  tone(speaker,C5);
  delay(300);
  noTone(speaker);
  tone(speaker,G4);
  delay(600);
  
  noTone(speaker);
  tone(speaker,F4);
  delay(400);
  noTone(speaker);
  tone(speaker,Dd);
  delay(400);
  noTone(speaker);
  tone(speaker,G4);
  delay(500);
  noTone(speaker);
  tone(speaker,F4);
  delay(500);
  noTone(speaker);
  tone(speaker,F4);
  delay(500);
  noTone(speaker);
  tone(speaker,Dd);
  delay(600);
  
  noTone(speaker);
  tone(speaker,C4);
  delay(500);
  noTone(speaker);
  tone(speaker,Dd);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(500);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,Dd);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(500);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,Dd);
  delay(300);
  noTone(speaker);
  tone(speaker,G4);
  delay(1000);
  
  noTone(speaker);
  tone(speaker,G4);
  delay(300);
  noTone(speaker);
  tone(speaker,G4);
  delay(300);
  noTone(speaker);
  tone(speaker,Bb);
  delay(500);
  noTone(speaker);
  tone(speaker,G4);
  delay(500);
  noTone(speaker);
  tone(speaker,Dd);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,Dd);
  delay(400);
  noTone(speaker);
  tone(speaker,G4);
  delay(400);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,Dd);
  delay(700);
  
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,G4);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,Dd);
  delay(700);
  
  noTone(speaker);
  tone(speaker,G4);
  delay(300);
  noTone(speaker);
  tone(speaker,G4);
  delay(300);
  noTone(speaker);
  tone(speaker,Bb);
  delay(300);
  noTone(speaker);
  tone(speaker,C5);
  delay(500);
  
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,Dd);
  delay(400);
  noTone(speaker);
  tone(speaker,G4);
  delay(400);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(500);
  noTone(speaker);
  tone(speaker,Dd);
  delay(600);
  
  noTone(speaker);
  tone(speaker,C4);
  delay(300);
  noTone(speaker);
  tone(speaker,Dd);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(500);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,Dd);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,Dd);
  delay(300);
  noTone(speaker);
  tone(speaker,G4);
  delay(1000);
  
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,G4);
  delay(300);
  noTone(speaker);
  tone(speaker,Gd);
  delay(300);
  noTone(speaker);
  tone(speaker,Gd);
  delay(300);
  noTone(speaker);
  tone(speaker,Gd);
  delay(300);
  noTone(speaker);
  tone(speaker,Gd);
  delay(300);
  noTone(speaker);
  tone(speaker,G4);
  delay(500);
  
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,Dd);
  delay(300);
  noTone(speaker);
  tone(speaker,Dd);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,G4);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(400);
  
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,G4);
  delay(300);
  noTone(speaker);
  tone(speaker,Gd);
  delay(500);
  noTone(speaker);
  tone(speaker,Gd);
  delay(300);
  noTone(speaker);
  tone(speaker,Gd);
  delay(300);
  noTone(speaker);
  tone(speaker,Gd);
  delay(300);
  noTone(speaker);
  tone(speaker,G4);
  delay(500);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,Dd);
  delay(300);
  noTone(speaker);
  tone(speaker,G4);
  delay(300);
  noTone(speaker);
  tone(speaker,F4);
  delay(600);
  
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,G4);
  delay(300);
  noTone(speaker);
  tone(speaker,Gd);
  delay(500);
  noTone(speaker);
  tone(speaker,Gd);
  delay(300);
  noTone(speaker);
  tone(speaker,Gd);
  delay(300);
  noTone(speaker);
  tone(speaker,Gd);
  delay(400);
  noTone(speaker);
  tone(speaker,G4);
  delay(300);
  
  noTone(speaker);
  tone(speaker,F4);
  delay(400);
  noTone(speaker);
  tone(speaker,Dd);
  delay(300);
  noTone(speaker);
  tone(speaker,Dd);
  delay(400);
  noTone(speaker);
  tone(speaker,F4);
  delay(300);
  noTone(speaker);
  tone(speaker,G4);
  delay(400);
  noTone(speaker);
  tone(speaker,F4);
  delay(500);
  
  noTone(speaker);
  tone(speaker,F4);
  delay(400);
  noTone(speaker);
  tone(speaker,G4);
  delay(500);
  noTone(speaker);
  tone(speaker,Gd);
  delay(500);
  noTone(speaker);
  tone(speaker,G4);
  delay(300);
  noTone(speaker);
  tone(speaker,Gd);
  delay(300);
  noTone(speaker);
  tone(speaker,Bb);
  delay(600);
  noTone(speaker);
  tone(speaker,Gd);
  delay(500);
  noTone(speaker);
  tone(speaker,Bb);
  delay(500);
  noTone(speaker);
  tone(speaker,C5);
  delay(1300);
  
  /*noTone(speaker);
  delay(150);*/
  
  noTone(speaker);
  tone(speaker,F4);
  delay(400);
  noTone(speaker);
  tone(speaker,Dd);
  delay(400);
  noTone(speaker);
  tone(speaker,F4);
  delay(500);
  noTone(speaker);
  tone(speaker,Dd);
  delay(600);
  noTone(speaker);
  
}
