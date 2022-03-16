package ex4;

import java.util.ArrayList;

public class GetPosition extends Thread {
    private ArrayList<Robot> robots;

    public GetPosition(ArrayList<Robot> robots) {
        this.robots = robots;
    }

    @Override
    public void run() {
        int n = 0;
        while (++n < 20) {
            synchronized (robots) {
                try {
                    for (int i = 0; i < robots.size() - 1; i++) {
                        for (int j = i + 1; j < robots.size(); j++) {
                            if (robots.get(i).getX() == robots.get(j).getX() && robots.get(i).getY() == robots.get(j).getY()) {
                                System.out.println("Robotul " + i + " s-a ciocnit cu robotul " + j);
                                robots.remove(i);
                                robots.remove(j);
                            }
                        }
                    }
                    sleep(100);
                }catch(InterruptedException e){
                    e.printStackTrace();
                }
            }
        }
    }
}
