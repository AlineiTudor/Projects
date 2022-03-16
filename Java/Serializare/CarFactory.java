package ex4;

import java.io.*;

public class CarFactory {

    public Car createCar(int price, String model) {
        Car c=new Car(price,model);
        System.out.println(c+" has been fabricated");
        return c;
    }

    public void serializeCar(Car c,String fileName) throws IOException{
        ObjectOutputStream out=new ObjectOutputStream(new FileOutputStream(fileName));
        out.writeObject(c);
        System.out.println(c+" is in garage");
    }

    public Car deserializeCar(String fileName) throws  IOException, ClassNotFoundException{
        ObjectInputStream in=new ObjectInputStream(new FileInputStream(fileName));
        Car c=(Car)in.readObject();
        System.out.println(c+" is ready for a run");
        return c;
    }

}
