//Assignment 2
//by Ceren Savasan
//username: csavasan


public String getAnimalName(Animal thisAn){
  return thisAn.name;
}

public ArrayList<Integer> getAnimalDistances(Animal thisAn){
  return thisAn.distances;
}


//TESTING PRINT
public void print_animal(Animal thisanimal){
  String v1 = getAnimalName(thisanimal);
  print("\n" + v1);
}


//initate a bunch of animals
Animal aardvark = new Animal("aardvark", "true", "false", "false", "true", "false", "false", "true", "true", "true", "true", "false", "false", "4", "false", "false", "true", "1");
Animal antelope = new Animal("antelope", "true", "false",  "false", "true", "false", "false",  "false",  "true",  "true", "true" , "false" , "false" , "4", "true",  "false",  "true",  "1");
Animal bass = new Animal("bass", "false", "false", "true", "false", "false",  "true",  "true",  "true",  "true",  "false",  "false",  "true",  "0",  "true",  "false",  "false",  "4");
Animal bear = new Animal("bear", "true",  "false",  "false", "true",  "false",  "false",  "true",  "true",  "true",  "true",  "false",  "false",  "4",  "false",  "false",  "true", "1");
Animal clam = new Animal("clam", "false",  "false",  "true",  "false",  "false",  "false",  "true",  "false",  "false",  "false",  "false",  "false",  "0", "false", "false",  "false",  "7");
Animal elephant = new Animal("elephant", "true", "false", "false", "true", "false", "false", "false", "true", "true", "true", "false", "false", "4", "true", "false", "true", "1");
Animal human = new Animal("human", "true",  "false", "false", "true", "false", "false", "true" , "true" ,"true", "true", "false", "false", "2", "false", "true", "true", "1");
Animal kiwi = new Animal("kiwi", "false", "true", "true", "false", "false", "false", "true", "false", "true", "true", "false", "false", "2", "true", "false", "false", "2");


ArrayList<Animal> animals = new ArrayList<Animal>();

void addAnimals(){
  print("About to add animals");
  animals.add(aardvark);
  animals.add(antelope);
  animals.add(bass);
  animals.add(bear);
  animals.add(clam);
  animals.add(elephant);
  animals.add(human);
  animals.add(kiwi);
  print("just added all animals");
}

