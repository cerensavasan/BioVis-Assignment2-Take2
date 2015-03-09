#Biovisualization - CS4802 - Assignment2

###How does this program perform hierarchical clustering?
There are two main classes that I have used to create the clustering algorithm. The "Animal" class holds the actual attributes and the name of the animal being processed into nodes. The "Node" class holds any animals that have been clustered together in an array of Animals. When finding the distance between two animals, the algorithm simply compares the attributes array of each animal and counts the differences. When calculating the distance between two nodes, the algorithm finds the average of distances between the two Animal arrays of the two nodes. The "updateNodes" function then iterates through the whole list of nodes and clusters the closest ones together.

###How does this program draw the tree of life?
In its current state, it only draws the base of the tree.

###Biological significance of the additions I have made:
I used the zoo data provided in a previous assignment. This allows me to use a semi-large data set of different animals and compare them based on their different qualities. The result is a tree that can shine some light into which of these animals are closest genetically, and can help me determine which animals are evolutionarily tied to one another.

###Technical significance of the additions I have made:
I have reduced the time it takes to run the algorithm significantly by introducing helper functions and not running everything within multiple for-loops and instead pooling everything together when possible.

###How do I run the program?
1. Download the Assignment2.pde and the zoo.data files into the same folder.
2. Launch the Assignment2.pde in Processing.
3. Press the play button to execute the program.
