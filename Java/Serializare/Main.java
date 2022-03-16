package ex4;

import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException, ClassNotFoundException {
        //CarFactory carFactory=new CarFactory();
        Car c1=new CarFactory().createCar(2000,"Dacia Solenta");
        Car c2=new CarFactory().createCar(500,"Tico");
        Car c3=new CarFactory().createCar(50000,"Tesla Cybertruck");
        Car c4=new CarFactory().createCar(4000,"Ford Focus");
        System.out.println("--------------");

        new CarFactory().serializeCar(c2,"cars1.ser");
        new CarFactory().serializeCar(c3,"cars2.ser");
        new CarFactory().serializeCar(c1,"cars3.ser");
        //carFactory.serializeCar(c4,"cars.ser");
        System.out.println("-------------");

        Car car1=new CarFactory().deserializeCar("cars2.ser");
        Car car2=new CarFactory().deserializeCar("cars1.ser");
        Car car3=new CarFactory().deserializeCar("cars3.ser");

    }
}
