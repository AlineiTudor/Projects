package view.sportsMenu;


import model.CaloriesBurnedUtil;
import model.PersonValues;
import model.sports.swim.SwimException;
import model.sports.swim.Swimming;
import model.sports.swim.SwimmingStyles;
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

public class SwimmingMenu extends GenericMenu {

    private JLabel styleL = new JLabel("Style:");
    private JTextField styleTF = new JTextField();
    private boolean done = false;
    private PersonValues personValues;
    private Swimming swimming;

    public SwimmingMenu() {
        super();
        super.setTitle("Swimming calories calculator");
        styleL.setBounds(20, 140, 50, 25);
        styleTF.setBounds(70, 140, 75, 25);
        getFirstPart().add(styleL);
        getFirstPart().add(styleTF);
        getDistanceTF().setEditable(false);
        getCalculate().addActionListener(e -> {
            try {
                personValues = new PersonValues(Integer.parseInt(getHeightTF().getText()),
                        Integer.parseInt(getWeightTF().getText()), Integer.parseInt(getAgeTF().getText()));
                String st = styleTF.getText().toUpperCase();
                if (st.isEmpty()) {
                    st = null;
                } else {
                    if (!(st.equals("CRAWL") || st.equals("BACKSTROKE") || st.equals("BREASTSTROKE") || st.equals("BUTTERFLY"))) {
                        throw new SwimException(st);
                    }
                }
                swimming = new Swimming(Double.parseDouble(getDurationTF().getText()), SwimmingStyles.valueOf(st));
                getBmrTF().setText(personValues.calc_bmr() + "");
                getExerciseTF().setText(swimming.mets() + "");
                int c = (int) CaloriesBurnedUtil.determineCalories(personValues.getBmr(), swimming.mets());
                getCaloriesTF().setText(c + "");
                done = true;
            } catch (NullPointerException exception) {
                new ErrorInterface();
            } catch (SwimException exception) {
                new ErrorInterface(exception.getMessage());
            } catch (NumberFormatException exception) {
                new ErrorInterface();
            }
        });

        getStore().addActionListener(e -> {
            if (done) {
                int c = (int) CaloriesBurnedUtil.determineCalories(personValues.getBmr(), swimming.mets());
                try {
                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
                    LocalDateTime now = LocalDateTime.now();

                    FileWriter wrHistory = new FileWriter("src/main/java/files/History.txt", true);
                    wrHistory.write("-------\n" + dtf.format(now) + "\n" + personValues.toString() + swimming.toString() +
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
