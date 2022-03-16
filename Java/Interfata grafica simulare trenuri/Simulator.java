package ex5;

import ex4.Game;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;


public class Simulator extends JFrame {
    private JFrame w = new JFrame();
    private JTextField trainName = new JTextField();
    private JTextField destination = new JTextField();
    private JTextField segment = new JTextField();
    private JLabel label1 = new JLabel("Nume Tren:");
    private JLabel label2 = new JLabel("Destinatie:");
    private JLabel label3 = new JLabel("Segment:");
    private JTextArea textArea = new JTextArea();
    private JScrollPane scrTextArea = new JScrollPane(textArea,
            JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED, JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
    JButton addTrainB = new JButton("Adauga");

    public void initialize() {
        trainName.setBounds(20, 40, 200, 25);
        w.add(trainName);

        destination.setBounds(230, 40, 200, 25);
        w.add(destination);

        segment.setBounds(440, 40, 200, 25);
        w.add(segment);

        label1.setBounds(20, 20, 200, 25);
        w.add(label1);

        label2.setBounds(230, 20, 200, 25);
        w.add(label2);

        label3.setBounds(440, 20, 200, 25);
        w.add(label3);

        w.setDefaultCloseOperation(EXIT_ON_CLOSE);
        w.setBounds(50, 50, 700, 750);

        scrTextArea.setBounds(30, 200, 600, 500);
        textArea.setEditable(false);
        w.add(scrTextArea);

        addTrainB.setBounds(300, 160, 80, 25);
        w.add(addTrainB);
        addTrainB.addActionListener(new ApasareButon());
    }

    public Simulator() {
        w.setLayout(null);

        initialize();

        w.setVisible(true);
    }

    //build station Cluj-Napoca
    Controler c1 = new Controler("Cluj-Napoca");
    Segment s1 = new Segment(1);
    Segment s2 = new Segment(2);
    Segment s3 = new Segment(3);

    //build station Bucuresti
    Controler c2 = new Controler("Bucuresti");
    Segment s4 = new Segment(4);
    Segment s5 = new Segment(5);
    Segment s6 = new Segment(6);

    //build station Piatra-Neamt
    Controler c3 = new Controler("Piatra-Neamt");
    Segment s7 = new Segment(7);
    Segment s8 = new Segment(8);
    Segment s9 = new Segment(9);

    class ApasareButon implements ActionListener {
        boolean firstClick = false;

        @Override
        public void actionPerformed(ActionEvent e) {
            try {
                FileWriter fw = new FileWriter("src/main/java/ex5/Data.txt", true);

                if (!firstClick) {
                    firstClick = true;
                    //build station Cluj-Napoca
                    c1.addControlledSegment(s1);
                    c1.addControlledSegment(s2);
                    c1.addControlledSegment(s3);

                    //build station Bucuresti
                    c2.addControlledSegment(s4);
                    c2.addControlledSegment(s5);
                    c2.addControlledSegment(s6);

                    //build station Piatra-Neamt
                    c3.addControlledSegment(s7);
                    c3.addControlledSegment(s8);
                    c3.addControlledSegment(s9);


                    //connect the 2 controllers
                    c1.setNeighbourController(c2);
                    c1.setNeighbourController(c3);
                    c2.setNeighbourController(c1);
                    c2.setNeighbourController(c3);
                    c3.setNeighbourController(c1);
                    c3.setNeighbourController(c2);
                }

                if (segment.getText().length() == 1) {
                    int id = Integer.parseInt(segment.getText());
                    switch (id) {
                        case 1:
                            s1.arriveTrain(new Train(destination.getText(), trainName.getText()));
                            c1.displayStationState();
                            c2.displayStationState();
                            c3.displayStationState();
                            break;
                        case 2:
                            s2.arriveTrain(new Train(destination.getText(), trainName.getText()));
                            c1.displayStationState();
                            c2.displayStationState();
                            c3.displayStationState();
                            break;
                        case 3:
                            s3.arriveTrain(new Train(destination.getText(), trainName.getText()));
                            c1.displayStationState();
                            c2.displayStationState();
                            c3.displayStationState();
                            break;
                        case 4:
                            s4.arriveTrain(new Train(destination.getText(), trainName.getText()));
                            c1.displayStationState();
                            c2.displayStationState();
                            c3.displayStationState();
                            break;
                        case 5:
                            s5.arriveTrain(new Train(destination.getText(), trainName.getText()));
                            c1.displayStationState();
                            c2.displayStationState();
                            c3.displayStationState();
                            break;
                        case 6:
                            s6.arriveTrain(new Train(destination.getText(), trainName.getText()));
                            c1.displayStationState();
                            c2.displayStationState();
                            c3.displayStationState();
                            break;
                        case 7:
                            s7.arriveTrain(new Train(destination.getText(), trainName.getText()));
                            c1.displayStationState();
                            c2.displayStationState();
                            c3.displayStationState();
                            break;
                        case 8:
                            s8.arriveTrain(new Train(destination.getText(), trainName.getText()));
                            c1.displayStationState();
                            c2.displayStationState();
                            c3.displayStationState();
                            break;
                        case 9:
                            s9.arriveTrain(new Train(destination.getText(), trainName.getText()));
                            c1.displayStationState();
                            c2.displayStationState();
                            c3.displayStationState();
                            break;
                        default:
                            fw.write("\nSegment inexistent\n\n");
                            break;
                    }
                }

                BufferedReader fr = new BufferedReader(new FileReader("src/main/java/ex5/Data.txt"));
                String s;
                s = fr.readLine();
                while (s != null) {
                    textArea.append(s + "\n");
                    s = fr.readLine();
                }
                fw.write("\n\n====================================\n\n");
                fw.flush();
                fw.close();
            } catch (IOException exc) {
            }
        }
    }

    public static void main(String[] args) {
        new Simulator();
    }

}
