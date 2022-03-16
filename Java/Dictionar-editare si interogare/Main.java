package ex4;

import java.util.Collection;
import java.util.InputMismatchException;
import java.util.Scanner;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        Dictionary d = new Dictionary();
        Word word = new Word();
        Definition definition = new Definition();
        String s;
        Scanner scanner = new Scanner(System.in);
        int c = 33;
        while (c != 0) {
            System.out.println("Enter an option:");
            System.out.println("1) Add word in dictionary;");
            System.out.println("2) See word's definition;");
            System.out.println("3) See all words;");
            System.out.println("4) See all definitions;");
            System.out.println("0) Exit.");

            try {
                c = scanner.nextInt();
            } catch (Throwable e) {
                System.out.println("This is not a number, try again.");
                scanner.nextLine();
                System.out.println("Enter an option:");
                System.out.println("1) Add word in dictionary;");
                System.out.println("2) See word's definition;");
                System.out.println("3) See all words;");
                System.out.println("4) See all definitions;");
                System.out.println("0) Exit.");
                c = scanner.nextInt();
            }
            switch (c) {
                case 1:
                    System.out.println("Enter your word, press ENTER, and enter definition: ");
                    scanner.nextLine();
                    d.addWord(new Word(new String(scanner.nextLine())), new Definition(new String(scanner.nextLine())));
                    System.out.println("Your word has been added to the dictionary");
                    break;
                case 2:
                    System.out.println("Enter word: ");
                    scanner.nextLine();
                    s = scanner.nextLine();
                    word.setName(s);
                    if (d.getDefinition(word) != null) {
                        System.out.println(d.getDefinition(word).getDescription());
                    } else {
                        System.out.println("Word not found!");
                    }
                    break;
                case 3:
                    System.out.println("\n" + "Your words are:");
                    Set<Word> wordSet = d.getAllWords();
                    for (Word a : wordSet) {
                        System.out.println(a.getName());
                    }
                    break;
                case 4:
                    System.out.println("\n" + "Your words are:");
                    Collection<Definition> definitionCollection = d.getAllDefinitions();
                    for (Definition a : definitionCollection) {
                        System.out.println(a.getDescription());
                    }
                    break;
                case 0:
                    System.out.println("Goodbye!");
                    break;
                default:
                    System.out.println("Unknown option");
                    break;
            }

        }
    }
}
