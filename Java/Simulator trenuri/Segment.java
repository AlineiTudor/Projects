package ex3modificat;

public class Segment {
    public int id;
    public Train train;

    public Segment(int id){
        this.id = id;
    }

    public boolean hasTrain(){
        return train!=null;
    }

    public Train departTRain(){
        Train tmp = train;
        this.train = null;
        return tmp;
    }

    public void arriveTrain(Train t){
        train = t;
    }

    public Train getTrain(){
        return train;
    }

}
