ArrayList<Animal> cluster = new ArrayList<Animal>();

ArrayList<Animal> root = new ArrayList<Animal>(); //two in root

public ArrayList<Cluster> clusterKeeper = new ArrayList<Cluster>();

public ArrayList<Distance> new_distances = new ArrayList<Distance>();

abstract class Node{
  Node parent;
  ArrayList<Integer> distances;
}


class Cluster extends Node{
  Animal a1;
  Animal a2;
  Animal a3;
  int distance;
  
  Cluster(Animal a1){
    this.a1 = a1;
  }
  
  
  Cluster(Animal a1,Animal a2, int aDist){
    this.a1 = a1;
    this.a2 = a2;
    this.distance = aDist;
  }
  
  
  Cluster(Animal a1,Animal a2, Animal a3, int aDist){
    this.a1 = a1;
    this.a2 = a2;
    this.a3 = a3;
    this.distance = aDist;
  }
}
 
void putEachAnimalInCluster(ArrayList<Animal> thisanimals){
  for(Animal an : thisanimals){
    new Cluster(an);
    


Animal makeRoot(ArrayList<Distance> new_dist){
    //create root
    Distance current_smallest = findClosestPair(new_dist);
    root.add(new Animal(getFirstAnimal(current_smallest)));
    root.add(new Animal(getSecAnimal(current_smallest)));
  
    //remove root animals from animals list
    print("\nAbout to remove root animal: " + getAnimalName(getFirstAnimal(current_smallest)));
    print("\nAbout to remove root animal: " + getAnimalName(getSecAnimal(current_smallest)) + "\n");
    animals.remove(findIndexOfAnimalName(getAnimalName(getFirstAnimal(current_smallest))));
    animals.remove(findIndexOfAnimalName(getAnimalName(getSecAnimal(current_smallest))));
  
    cluster = root;
    Animal rootCluster = new Animal("cluster0", getFirstAnimal(current_smallest), getSecAnimal(current_smallest));
    print("Root cluster is:"); 
    print_animal(rootCluster);
    print("\n");
    animals.add(new Animal(rootCluster));
    return rootCluster;
}


void makeClusters(){
    Animal rootCluster = makeRoot(distances);
    int nameCount = 0;
    
    Animal fatherCluster = rootCluster;
    
    new_distances.clear();
    
    //find average distance to root for each animal left in the list
    new_distances = findDistancesToCurrentRoot(rootCluster);
    
    Animal newRoot; 
    while(animals.size() > 1){
    for(int counter = 0; counter < animals.size(); counter++){
         Distance smallest = calculateSecondarySmallest(new_distances);
         nameCount++;
         print("Name count after incrementing is:" + nameCount); 
         print("current smallest distance is:\n");
         print_distance(smallest);
             
         cluster.add(new Animal(getFirstAnimal(smallest))); 
         cluster.add(new Animal(getSecAnimal(smallest)));  
         
         newRoot = (new Animal("cluster" + nameCount, cluster.get(findIndexOfClusterAnimalName("cluster"+(nameCount-1))) , cluster.get(findIndexOfClusterAnimalName(getAnimalName(getSecAnimal(smallest))))));
         print("\nNew root is:\n");
         print_animal(newRoot);
         print("\n Child 1: " + newRoot.child1);
         print("\n Child 2: " + newRoot.child2);
         
         
         print("\nAbout to add cluster" + nameCount + ": has animals as children: " + getAnimalName(getFirstAnimal(smallest)) + " and " + getAnimalName(getSecAnimal(smallest)) + "\n"); 
         animals.add(new Animal(newRoot));                
               
         print("\nAbout to remove: " + getAnimalName(getFirstAnimal(smallest)));
         print("\nAbout to remove: " + getAnimalName(getSecAnimal(smallest)) + "\n");
         animals.remove(findIndexOfAnimalName(getAnimalName(getFirstAnimal(smallest)))); 
         animals.remove(findIndexOfAnimalName(getAnimalName(getSecAnimal(smallest)))); 
         
         print("I'm trying to remove: ");
         print_distance(smallest);
         removeDistanceBetween(getFirstAnimal(smallest), getSecAnimal(smallest), new_distances); 
         
         smallest = calculateSecondarySmallest(new_distances); 
         findDistancesToCurrentRoot(cluster.get(findIndexOfAnimalName("cluster"+(nameCount))));     
         print("\nPrinting list of animals left in list: \n");
         
         for(Animal anim : animals){
            print_animal(anim);
         }  
    }
  }

}

Distance calculateSecondarySmallest(ArrayList<Distance> thisDistances){
  Distance smallest = new Distance(error, error, 9999999);
  for(int counter = 0; counter < thisDistances.size(); counter++){
    if(getHowFar(thisDistances.get(counter)) < getHowFar(smallest)){
       smallest = thisDistances.get(counter);
       print("\nFound smaller! The smallest distance now is: \n");
       print_distance(smallest);
    }
    if(getHowFar(thisDistances.get(counter)) > getHowFar(smallest)){
       print("\nStill the smallest. The smallest distance now is: \n");
       print_distance(smallest);
       smallest = smallest;
    }
    if(getHowFar(thisDistances.get(counter)) == getHowFar(smallest)){
       print("\nEqual smallest. The  smallest distance now is: \n");
       print_distance(smallest);
       smallest = thisDistances.get(counter);
    }
  }
  return smallest;
}

ArrayList<Distance> findDistancesToCurrentRoot(Animal rootCluster){
  ArrayList<Distance> iterative_distances = new ArrayList<Distance>();
  int distanceToRoot1 = 0;
  int distanceToRoot2 = 0;
  int average = 0;
  for(int counter = 0; counter < animals.size(); counter++){
        distanceToRoot1 = findDistance(rootCluster.child1, animals.get(counter));
        distanceToRoot2 = findDistance(rootCluster.child2, animals.get(counter));
        print("Found distances for current loop distance finder");
        print("\nCurrent root cluster is: \n");
        print_animal(rootCluster);
        average = ((distanceToRoot1 + distanceToRoot2)/2);
        if(rootCluster != animals.get(counter)){
          print("\nAdding new distance to new_distances: \n");
          print_distance(new Distance(rootCluster, animals.get(counter), average));
          new_distances.add(new Distance(rootCluster, animals.get(counter), average));
        }
    }
  iterative_distances = new_distances;
  return iterative_distances;
}
    
void draw(){
  String firstString = getAnimalName(root.get(0));
  String secondString = getAnimalName(root.get(1));
  
  text(firstString + "  and  " + secondString, 500, 30);
  text("Something", 5, 5);
}

PFont font;
  
void setup() 
{  //setup function called initially, only once
  addAnimals();
  findInitialDistances();
  makeClusters();
  size(1000, 400);
  background(255);  //set background white
  colorMode(RGB);   //set colors to Hue, Saturation, Brightness mode
  font = createFont("Arial",14,true);
  noLoop();
 // fill(#FFFFFF);
}
  
