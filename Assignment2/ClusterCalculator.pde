//Assignment 2
//by Ceren Savasan
//username: csavasan

PrintWriter

public ArrayList<Node> clusterKeeper = new ArrayList<Node>();

int largeMinimum = 999;

abstract class Node{
  Node parent;
  ArrayList<Integer> distances;
}


class Cluster extends Node{
  Node node1;
  Node node2;
  int distance;
  
  Cluster(Node node1, Node node2, int thisDistance){
    this.node1 = node1;
    this.node2 = node2;
    distance = thisDistance;
  }
}

class Animal extends Node{
  String name;
  String[] attributes;
 
  //Use this to create a new animal with custom attributes
  Animal(String new_name, String new_h, String new_feat, String new_e, String new_m, String new_a, String new_aqua, String new_p, String new_tooth, String new_back, String new_brea, String new_ven, String new_fin, String new_leg, String new_tail, String new_dom, String new_cat, String new_type){
    name = new_name;
    distances = new ArrayList<Integer>();
    attributes[0] = new_name;
    attributes[1] = new_h;
    attributes[2] = new_feat;
    attributes[3] = new_e;
    attributes[4] = new_m;
    attributes[5] = new_a;
    attributes[6] = new_aqua;
    attributes[7] = new_p;
    attributes[8] = new_tooth;
    attributes[9] = new_back;
    attributes[10] = new_brea;
    attributes[11] = new_ven;
    attributes[12] = new_fin;
    attributes[13] = new_leg;
    attributes[14] = new_tail;
    attributes[15] = new_dom;
    attributes[16] = new_cat;
    attributes[17] = new_type;
  }
}

//initalize clusters list as one animal in each cluster
void populateNodes(){
  for(int counter = 0; counter < animals.size(); counter++){
    clusterKeeper.add(animals.get(counter));
  }
}

void initializeFirstDistances(){
  for(int counter = 0; counter < animals.size(); counter++){
    for(int counter2 = 0; counter2 < animals.size() ; counter2++){
      int difference = 0;
      for(int attrCount = 1; attrCount < 18; attrCount++){
        if(((animals.get(counter).attributes[attrCount]) == (animals.get(counter2).attributes[attrCount])) == false){
          difference++;
          //WAT DO weight[attrCount];
        }
      }
      animals.get(counter).distances.add(difference);
      print(animals.get(counter).distances.get(counter2) + ", ");
    }
    println();
  }
}

void makeClusters(){
  int currentMinDistance;
  //indexes of node1 and node2
  int i1;
  int i2;
  
  //eventually we will only have 1 node in that list
  while((clusterKeeper.size() > 1) && (clusterKeeper.size() != 1)){
    currentMinDistance = 999; //some arbitrary large number to check against
    i1 = 0;
    i2 = 0;
    for(int counter = 0; counter < clusterKeeper.size(); counter++){
      for(int counter2 = counter + 1; counter2 < clusterKeeper.size(); counter2++){
        if((counter < counter2) && (clusterKeeper.get(counter).distances.get(counter2) < currentMinDistance)){
          currentMinDistance = clusterKeeper.get(counter).distances.get(counter2);
          i1 = counter;  //we have now decided what nodes need to get clustered together
          i2 = counter2;
        }
      }
    }
  
   //calculate new distances for them
  for(int counter = 0; counter < clusterKeeper.size(); counter++){
    if(counter != i1){ //check that we are not checking it with itself
      //set new distances
      clusterKeeper.get(i1).distances.set(counter, clusterKeeper.get(counter).distances.get(i1));
      clusterKeeper.get(counter).distances.set(i1 , min(clusterKeeper.get(counter).distances.get(i2), clusterKeeper.get(counter).distances.get(i1)));
     
      //now remove current second cluster
      clusterKeeper.get(counter).distances.remove(i2);
    }
  }
  
  //get the first cluster's distances
  ArrayList<Integer> new_distances = clusterKeeper.get(i1).distances;
  
  //remove that distance from first cluster's
  clusterKeeper.get(i1).distances.remove(i2);
  
   //so now we will actually cluster them and add that new cluster to the list
  //remove them from the list
  Node new_node1 = clusterKeeper.get(i1);
  Node new_node2 = clusterKeeper.get(i2-1); //-1 because removing first node removed 1 from that list
  
  clusterKeeper.remove(i1);
  clusterKeeper.remove(i2-1);
  
  //add to list of clusters this new cluster
  clusterKeeper.add(i1, new Cluster(new_node1, new_node2, currentMinDistance));
  
  //set those new distances
  clusterKeeper.get(i1).distances = new_distances;
 }
}

void setup() 
{  //setup function called initially, only once
  addAnimals();
  print("about to populate nodes");
  populateNodes();
  initializeFirstDistances();
  makeClusters();
  size(1000, 400);
  background(255);  //set background white
  colorMode(RGB);   //set colors to Hue, Saturation, Brightness mode
}
  
