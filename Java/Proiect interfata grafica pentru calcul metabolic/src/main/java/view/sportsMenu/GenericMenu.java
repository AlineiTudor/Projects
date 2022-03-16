package view.sportsMenu;

import javax.swing.*;
import java.awt.*;

public class GenericMenu extends JFrame {
    /**
     * ------------
     */
    private JLabel ageLabel = new JLabel("Age:");
    private JLabel heightLabel = new JLabel("Height:");
    private JLabel weightLabel = new JLabel("Weight:");
    private JLabel durationLabel = new JLabel("Duration:");
    private JLabel distanceLabel = new JLabel("Distance:");

    private JTextField ageTF = new JTextField();
    private JTextField heightTF = new JTextField();
    private JTextField weightTF = new JTextField();
    private JTextField durationTF = new JTextField();
    private JTextField distanceTF = new JTextField();

    private JLabel ageUnit = new JLabel("years");
    private JLabel heightUnit = new JLabel("cm");
    private JLabel weightUnit = new JLabel("kg");
    private JLabel durationUnit = new JLabel("minutes");
    private JLabel distaceUnit = new JLabel("km");
    /**
     * --------------------
     */
    private JLabel bmrLabel = new JLabel("BMR:");
    private JLabel exerciseLabel = new JLabel("Exercise:");
    private JLabel caloriesBurnedLabel = new JLabel("Calories burned:");

    private JTextField bmrTF = new JTextField();
    private JTextField exerciseTF = new JTextField();
    private JTextField caloriesTF = new JTextField();

    private JLabel bmrUnit = new JLabel("kcal/day");
    private JLabel exerciseUnit = new JLabel("mets");
    private JLabel caloriesBurnedUnit = new JLabel("kcal");
    /**
     * -----------------------
     */
    private JButton calculate = new JButton("Calculate");
    private JButton store = new JButton("Store");
    private JButton visualise = new JButton("Graph");

    /**
     * -----------------------
     */
    private JPanel firstPart = new JPanel(null);
    private JPanel secondPart = new JPanel(null);


    /**
     * ------
     */
    public GenericMenu() {
        setBounds(100, 100, 700, 400);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        setLayout(new GridLayout(1, 2));
        setVisible(true);

        /**---first half*/
        ageLabel.setBounds(20, 50, 50, 25);
        heightLabel.setBounds(20, 80, 75, 25);
        weightLabel.setBounds(20, 110, 75, 25);
        //todo:particular field
        durationLabel.setBounds(15, 170, 75, 25);
        distanceLabel.setBounds(20, 200, 75, 25);
        firstPart.add(distanceLabel);
        firstPart.add(ageLabel);
        firstPart.add(heightLabel);
        firstPart.add(weightLabel);
        firstPart.add(durationLabel);

        ageTF.setBounds(70, 50, 100, 25);
        heightTF.setBounds(70, 80, 100, 25);
        weightTF.setBounds(70, 110, 100, 25);
        //todo:particular field
        durationTF.setBounds(70, 170, 100, 25);
        distanceTF.setBounds(70, 200, 100, 25);
        firstPart.add(distanceTF);
        firstPart.add(ageTF);
        firstPart.add(heightTF);
        firstPart.add(weightTF);
        firstPart.add(durationTF);

        ageUnit.setBounds(170, 50, 75, 25);
        heightUnit.setBounds(170, 80, 75, 25);
        weightUnit.setBounds(170, 110, 75, 25);
        //todo:particular unit
        durationUnit.setBounds(170, 170, 75, 25);
        distaceUnit.setBounds(170, 200, 75, 25);
        firstPart.add(distaceUnit);
        firstPart.add(ageUnit);
        firstPart.add(heightUnit);
        firstPart.add(weightUnit);
        firstPart.add(durationUnit);

        calculate.setBounds(10, 280, 100, 25);
        store.setBounds(115, 280, 70, 25);
        visualise.setBounds(190, 280, 70, 25);
        firstPart.add(calculate);
        firstPart.add(store);
        firstPart.add(visualise);
        add(firstPart);
        /**------*/

        /**--second half----*/
        bmrLabel.setBounds(20, 50, 50, 25);
        exerciseLabel.setBounds(20, 80, 75, 25);
        caloriesBurnedLabel.setBounds(20, 110, 100, 25);
        secondPart.add(bmrLabel);
        secondPart.add(exerciseLabel);
        secondPart.add(caloriesBurnedLabel);

        bmrTF.setEditable(false);
        bmrTF.setBounds(120, 50, 70, 25);
        exerciseTF.setEditable(false);
        exerciseTF.setBounds(120, 80, 70, 25);
        caloriesTF.setEditable(false);
        caloriesTF.setBounds(120, 110, 70, 25);
        secondPart.add(bmrTF);
        secondPart.add(exerciseTF);
        secondPart.add(caloriesTF);

        bmrUnit.setBounds(190, 50, 50, 25);
        exerciseUnit.setBounds(190, 80, 50, 25);
        caloriesBurnedUnit.setBounds(190, 110, 50, 25);
        secondPart.add(bmrUnit);
        secondPart.add(exerciseUnit);
        secondPart.add(caloriesBurnedUnit);
        add(secondPart);

    }

    public JTextField getAgeTF() {
        return ageTF;
    }

    public JTextField getHeightTF() {
        return heightTF;
    }

    public JTextField getWeightTF() {
        return weightTF;
    }

    public JTextField getDurationTF() {
        return durationTF;
    }

    public JPanel getFirstPart() {
        return firstPart;
    }


    public JButton getCalculate() {
        return calculate;
    }

    public JButton getStore() {
        return store;
    }

    public JButton getVisualise() {
        return visualise;
    }

    public JTextField getDistanceTF() {
        return distanceTF;
    }

    public JTextField getBmrTF() {
        return bmrTF;
    }

    public JTextField getExerciseTF() {
        return exerciseTF;
    }


    public JTextField getCaloriesTF() {
        return caloriesTF;
    }


}
