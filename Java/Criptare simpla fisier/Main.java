package ex3;


import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String option;
        System.out.println("Enter option(encript/decript):");
        option = scanner.nextLine();
        if (option.compareTo("encript") == 0) {
            try {
                String txt;
                System.out.println("Enter normal txt file path: ");
                txt = scanner.nextLine();
                FileReader re = new FileReader(txt);

                System.out.println("Enter encripted enc file path: ");
                String enc = scanner.nextLine();
                FileWriter wr = new FileWriter(enc);
                EncriptFile.encriptFile(re, wr);
            } catch (Exception e) {
                System.out.println("Error occurred");
                e.printStackTrace();
            }
        } else if(option.compareTo("decript")==0){
            try {
                String enc;
                System.out.println("Enter encripted txt file path: ");
                enc = scanner.nextLine();
                FileReader re = new FileReader(enc);

                System.out.println("Enter decripted file path: ");
                String dec = scanner.nextLine();
                FileWriter wr = new FileWriter(dec);
                EncriptFile.decriptFile(re, wr);
            } catch (Exception e) {
                System.out.println("Error occurred");
                e.printStackTrace();
            }
        }
        else {
            System.out.println("invalid option!");}
    }
}
