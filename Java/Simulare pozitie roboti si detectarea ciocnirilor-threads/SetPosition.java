package ex4;

import java.util.ArrayList;

public class SetPosition extends Thread {
    private ArrayList<Robot> robots;

    public SetPosition(ArrayList<Robot> robots) {
        this.robots = robots;
    }

    @Override
    public void run() {
        int n = 0;
        int x,y;
        while (++n < 20) {
            synchronized (robots) {
                try {
                    for (int i = 0; i < robots.size() ; i++) {
                        x=(int)(Math.random()*100);
                        y=(int)(Math.random()*100);
                        robots.get(i).setX(x);
                        robots.get(i).setY(y);
                        System.out.println("Robotul "+i+" se afla la pozitia: ["+x+","+y+"];");
                        sleep(100);

                    }
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
