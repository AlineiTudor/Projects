package ex5;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

public class Controler {
    public FileWriter fw;
    public String stationName;

    public ArrayList<Controler> neighbourController = new ArrayList<Controler>();

    //storing station train track segments
    public ArrayList<Segment> list = new ArrayList<Segment>();

    public Controler(String gara) {
        stationName = gara;
    }

    public void setNeighbourController(Controler v) {
        neighbourController.add(v);
    }

    public void addControlledSegment(Segment s) {
        list.add(s);
    }

    /**
     * Check controlled segments and return the id of the first free segment or -1 in case there is no free segment in this station
     *
     * @return
     */
    public int getFreeSegmentId() {
        for (Segment s : list) {
            if (s.hasTrain() == false)
                return s.id;
        }
        return -1;
    }

    void controlStep() {
        //check which train must be sent
        try {
            FileWriter fw = new FileWriter(new File("src/main/java/ex5/Data.txt"),true);
            for (Segment segment : list) {
                if (segment.hasTrain()) {
                    Train t = segment.getTrain();

                    for (Controler c : neighbourController) {
                        if (t.getDestination().equals(c.stationName)) {
                            //check if there is a free segment
                            int id = c.getFreeSegmentId();
                            if (id == -1) {
                                fw.write("Trenul +" + t.name + "din gara " + stationName + " nu poate fi trimis catre " + c.stationName + ". Nici un segment disponibil!\n");
                                return;
                            }
                            //send train
                            fw.write("Trenul " + t.name + " pleaca din gara " + stationName + " spre gara " + c.stationName+"\n");
                            segment.departTRain();
                            c.arriveTrain(t, id);
                        }
                    }

                }
            }//.for
            fw.flush();
            fw.close();
        } catch (IOException e) {

        }
    }//.


    public void arriveTrain(Train t, int idSegment) {
        try {
            FileWriter fw = new FileWriter(new File("src/main/java/ex5/Data.txt"),true);
            for (Segment segment : list) {
                //search id segment and add train on it
                if (segment.id == idSegment)
                    if (segment.hasTrain() == true) {
                        fw.write("CRASH! Train " + t.name + " colided with " + segment.getTrain().name + " on segment " + segment.id + " in station " + stationName+"\n");

                        return;
                    } else {
                        fw.write("Train " + t.name + " arrived on segment " + segment.id + " in station " + stationName+"\n");
                        segment.arriveTrain(t);
                        return;
                    }
            }
            //this should not happen
            fw.write("Train " + t.name + " cannot be received " + stationName + ". Check controller logic algorithm!\n");
            fw.flush();
            fw.close();
        }
        catch (IOException e){
        }


    }


    public void displayStationState() {
        try {
            FileWriter fw = new FileWriter(new File("src/main/java/ex5/Data.txt"),true);
            fw.write("=== STATION " + stationName + " ===\n");
            for (Segment s : list) {
                if (s.hasTrain())
                    fw.write("|----------ID=" + s.id + "__Train=" + s.getTrain().name + " to " + s.getTrain().destination + "__----------|\n");
                else
                    fw.write("|----------ID=" + s.id + "__Train=______ catre ________----------|\n");
            }
            fw.flush();
            fw.close();
        }
        catch(IOException e){        }
    }
}
