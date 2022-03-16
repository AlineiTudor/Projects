package view.sportsMenu;


import model.CaloriesBurnedUtil;
import model.PersonValues;
import model.sports.Running;
import view.DrawGraph;
import view.ErrorInterface;

import javax.swing.*;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class RunningMenu extends GenericMenu {
    private JLabel speedL = new JLabel("Running speed:");
    private JTextField speedTF = new JTextField();
    private JLabel speedUnit = new JLabel("km/h");
    private boolean done = false;
    private PersonValues personValues;
    private Running running;

    public RunningMenu() {
        super();
        super.setTitle("Running calories calculator");
        speedL.setBounds(20, 140, 100, 25);
        speedTF.setBounds(120, 140, 75, 25);
        speedUnit.setBounds(195, 140, 75, 25);
        speedTF.setEditable(false);
        getFirstPart().add(speedL);
        getFirstPart().add(speedTF);
        getFirstPart().add(speedUnit);
        getCalculate().addActionListener(e -> {
            try {
                personValues = new PersonValues(Integer.parseInt(getHeightTF().getText()),
                        Integer.parseInt(getWeightTF().getText()), Integer.parseInt(getAgeTF().getText()));
                running = new Running(Double.parseDouble(getDistanceTF().getText()), Double.parseDouble(getDurationTF().getText()));
                speedTF.setText((int) running.getSpeedKph() + "");
                getBmrTF().setText(personValues.calc_bmr() + "");
                getExerciseTF().setText(running.mets() + "");
                int c = (int) CaloriesBurnedUtil.determineCalories(personValues.getBmr(), running.mets());
                getCaloriesTF().setText(c + "");
                done = true;
            } catch (Exception exception) {
                new ErrorInterface();
            }
        });

        getStore().addActionListener(e -> {
            if (done) {
                int c = (int) CaloriesBurnedUtil.determineCalories(personValues.getBmr(), running.mets());
                try {
                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
                    LocalDateTime now = LocalDateTime.now();

                    FileWriter wrHistory = new FileWriter("src/main/java/files/History.txt", true);
                    wrHistory.write("-------\n" + dtf.format(now) + "\n" + personValues.toString() + running.toString() +
                            "Calories burned: " + c + "\n-------\n\n");
                    wrHistory.flush();
                    wrHistory.close();
                } catch (IOException ioException) {
                    new ErrorInterface("History file not found");
                }
                try {
                    FileWriter wrStats = new FileWriter("src/main/java/files/Statistic.txt", true);
                    wrStats.write(c + "\n");
                    wrStats.flush();
                    wrStats.close();
                } catch (IOException ioException) {
                    new ErrorInterface("Statistic file not found");
                }
            }
        });
        getVisualise().addActionListener(e -> {
            List<Integer> scores = new ArrayList<Integer>();
            try {
                Scanner scanner = new Scanner(new File("src/main/java/files/Statistic.txt"));
                int i = 0;
                while (scanner.hasNextLine()) {
                    Integer s = Integer.parseInt(scanner.nextLine());
                    scores.add(s);
                }
                scanner.close();
            } catch (Exception E) {
                new ErrorInterface("Visualising error");
            }
            DrawGraph drawGraph = new DrawGraph(scores);
            drawGraph.createAndShowGui();
        });
    }

}
