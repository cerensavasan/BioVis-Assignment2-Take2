//Assignment 2
//by Ceren Savasan
//username: csavasan

//Holds all of the nodes in the tree
Node[] listOfNodes = new Node[101];

//-------------------------------CLASS DECLERATIONS--------------------------------------//
class Node{
  Animal[] nodeOf;
  int level;
}

class Animal{
  String name;
  int[] attributes;
 
  //Use this to create a new animal with custom attributes
  Animal(String new_name, int[] new_attributes){
    name = new_name;
    attributes = new_attributes;
  }
}
//-------------------------------THE DISTANCE BETWEEN TWO ANIMALS---------------------------------------//
int getAnimalDistance(Animal a1, Animal a2){
  int count = 0;
  for(int i = 0; i < 16; i++){
    if(a1.attributes[i] != a2.attributes[i]){
      count++;
    }
  }
  return count;
}
//-------------------------------THE DISTANCE BETWEEN TWO NODES---------------------------------------//
int getNodeDistance(Node n1, Node n2){
  int count = 0;
  for(int i = 0; i < n1.nodeOf.length; i++){
    for(int j = 0; j < n2.nodeOf.length; j++){
      count = count + getAnimalDistance(n1.nodeOf[i], n2.nodeOf[j]);
    }
  }
  //get average
  count = count / (n1.nodeOf.length * n2.nodeOf.length);
  return count;
}
//-------------------------------PARSE OUT ZOO TABLE INTO LIST---------------------------------------//
Node[] parseTable(){
  String[] zooData = loadStrings("zoo.data");
  int level = 1;
  for(int i = 0; i < zooData.length; i++){
    int[] temporary = new int[16]; //number of attributes
    String[] temporary2 = split(zooData[i],",");
    for(int j = 0; j < 16; j++){     
      temporary[j] = int(temporary2[j+1]);
    }
    Node cluster = new Node();
    cluster.nodeOf = new Animal[1];
    cluster.nodeOf[0] = new Animal(temporary2[0], temporary);
    cluster.level = level;
    listOfNodes[i] = cluster;
  }
  return listOfNodes;
}
//-----------------------------------MERGE NODES---------------------------------------//
Node mergeNodes(Node n1, Node n2, int lengthOf, int heightOf){
  String saveName = null;
  Node n3 = new Node();
  for(int i = 0; i < n2.nodeOf.length; i++) {
    n1.nodeOf = (Animal[])append(n1.nodeOf, n2.nodeOf[i]);
    saveName = n2.nodeOf[i].name;
  }
  n3.nodeOf = n1.nodeOf;
  n3.level = lengthOf + 1;
  return n3;
}
//-------------------------------UPDATE NODES---------------------------------------//
void updateNodes(){
  int count = 1;
  int textPos = 1;
  float min = getNodeDistance(listOfNodes[0], listOfNodes[1]);
  int x = 0;
  int y = 1;
  // clustering
  for(int a = 0; a < 98; a++) {
    Node[] listOfNodes2 = new Node[0];
    //find minimum distance    
    for(int i = 0; i < listOfNodes.length; i++){
      for(int j = 0; j < listOfNodes.length; j++){
        if(i != j && (min > getNodeDistance(listOfNodes[i],listOfNodes[j]))){
          min = getNodeDistance(listOfNodes[i],listOfNodes[j]);
          x=i;
          y=j;
          println("Minimum is: " + min);
        }
      }
    }
    
    if(listOfNodes[x].nodeOf.length == 1 || listOfNodes[y].nodeOf.length == 1){
         textPos = textPos + 3;
       }
    listOfNodes2 = (Node[])append(listOfNodes2, mergeNodes(listOfNodes[x], listOfNodes[y], count, textPos));  
    count++;
    for(int b = 0; b < listOfNodes.length; b++) {
      if(b != x && b != y){
        listOfNodes2 = (Node[])append(listOfNodes2,listOfNodes[b]);
      }
    }
    listOfNodes = listOfNodes2;
  }
}
//-------------------------------SETUP AND DRAW TREE---------------------------------------//
void setup() {
  size(1000,800);
  stroke(0);
  background(255);
  
  parseTable();  
  println("Length of list after parse: " + listOfNodes.length);
  updateNodes();
  println("Length of list after update: " + listOfNodes.length);
  
  stroke(0);
  fill(50);
  
  for(int i=0; i<listOfNodes.length; i++){
    println("Length of end list is: " + listOfNodes.length);
    println(listOfNodes[i].nodeOf[0].name);
  }
  
  int levelCount = 1;
  int hasDouble = 0;
  for(int i=0; i<listOfNodes.length; i++){
    println("current level count is: " + levelCount);
    if(listOfNodes[i].level == levelCount) {
      println(listOfNodes[i].nodeOf[0].name);
      println(listOfNodes[i].level);
      textSize(12);
      text(listOfNodes[i].nodeOf[0].name, 350 + 100*i, 20 * levelCount);
      hasDouble++;
    }
   if(hasDouble == 2){
     println("Incrementing level count");
     levelCount++; 
   } 
  }
}
