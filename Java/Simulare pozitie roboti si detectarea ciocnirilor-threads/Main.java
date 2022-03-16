package ex4;

import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        ArrayList<Robot> robots=new ArrayList<Robot>();
        int nr_roboti=10;
        for(int i=0;i<nr_roboti;i++){
            robots.add(new Robot(i,i));
        }
        GetPosition t1=new GetPosition(robots);
        SetPosition t2=new SetPosition(robots);

        t1.start();
        t2.start();
    }
}
