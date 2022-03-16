package ex4.events;

public class NoEvent extends Event{
    public NoEvent() {
        super(EventType.NONE);
    }

    @Override
    public String toString() {
        return "NoEvent{}";
    }
}
