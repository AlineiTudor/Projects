package ex4;

import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Set;

public class Dictionary {
    private HashMap<Word, Definition> words;

    public Dictionary() {
        this.words = new HashMap<>();
    }

    public void addWord(Word word, Definition definition) {
        this.words.put(word, definition);
    }

    public Definition getDefinition(Word word){
        return this.words.get(word);
    }

    public Set<Word> getAllWords(){
        return this.words.keySet();
    }

    public Collection<Definition> getAllDefinitions(){
        return this.words.values();
    }

}
