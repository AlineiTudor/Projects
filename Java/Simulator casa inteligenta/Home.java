package ex4;

import ex4.events.Event;
import ex4.events.FireEvent;
import ex4.events.NoEvent;
import ex4.events.TemperatureEvent;
import ex4.units.ControlUnit;

import java.io.FileWriter;
import java.io.IOException;
import java.util.Random;

public abstract class Home {
    private Random r = new Random();
    private final int SIMULATION_STEPS = 20;

    protected abstract void setValueInEnvironment(Event event);

    protected abstract void controllStep();

    private Event getHomeEvent() {
        //randomly generate a new event;
        int k = r.nextInt(100);
        if (k < 30)
            return new NoEvent();
        else if (k < 60)
            return new FireEvent(r.nextBoolean());
        else
            return new TemperatureEvent(r.nextInt(50));
    }

    public void simulate() {
        int k = 0;
        ControlUnit c = ControlUnit.getInstance();
        try {
            FileWriter wr = new FileWriter("src/main/java/ex4/system_logs.txt");
            while (k < SIMULATION_STEPS) {
                Event event = this.getHomeEvent();
                setValueInEnvironment(event);
                c.controlHouse(event, wr);
                controllStep();

                try {
                    Thread.sleep(300);
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }

                k++;
            }
            wr.flush();
            wr.close();
        } catch (IOException e) {
            System.out.println("There has been a problem with the logs file");
        }
    }
}
