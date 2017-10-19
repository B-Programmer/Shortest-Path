/* A JAVA Program to compute the Shortest Path using Bellman Ford Algorithm
 * Class Name: BellmanFord.java
 * Project Developed by
 */
import java.util.Scanner; 

public class BellmanFord {
	
	       private final int MAXNODE = 10;
	       private final int TRUE = 1;
	       private final int FALSE = 0;
	       private final int INFINTY = 9999;
		   
	       private int[][]  Edges;
	       public int noOfNodes;
	       private char[] Vertices;
		                
	       Scanner scanInput = new Scanner(System.in);
				      
	       public BellmanFord(int N)
	       {
	           setNoOfNodes(N);
	           Edges = new int[N][N];
	           Vertices = new char[N];
	       }

	       private int getNoOfNodes(){
	    	    return noOfNodes;
	       }   
	       
	       private void setNoOfNodes(int Nnodes){
	    	   noOfNodes = Nnodes;
	       }  
	    
		public void ShortestPath()
	    {
	           int ch;
	         
	        if (noOfNodes <= 0 || noOfNodes > MAXNODE)
	        {
	           System.out.println("Wrong Input! Please, Read in correct digit from 1 to 10:");      
	        }
	        else
	        {
	            ReadNodes(Vertices); // Read in N nodes
				ReadWeight(Edges, Vertices); //Read in weight/cost of each edges
				DisplayWeight(Edges); // Display Matrix of Weight 
	            System.out.println("\n Do you wish to find Shortest Path between two Vertices/Nodes in  the Graph:\n ");
	            System.out.println("Press 1 -> Yes \n Press 0 or any other digit -> No\n");
	            ch = scanInput.nextInt();
	            if(ch == 1) 
				{
					System.out.print("\nRead in the Source Node/Vertex: ");
					String str = scanInput.next();
					char source = str.charAt(0);
					System.out.print("\nRead in the Target Node/Vertex: ");
					str = scanInput.next();
					char target = str.charAt(0);
					FindShortestPath(Vertices, Edges, source, target);
				}
	        }    
	  
	    }

	       private void ReadNodes(char[] Nodes)
	       {     
	         int i;
	         System.out.println("Read in the names of all Nodes/Vertices in the graph");
	         for(i = 0; i < Nodes.length; i++)
	          {
	        	 System.out.print("\nRead in the names of Node/Vertex " + (i+1) + ":\t" );
	        	 String Str = scanInput.next();
	        	 Nodes[i] = Str.charAt(0);
	          }
	          
	       }

	       private void ReadWeight(int[][] W, char[] Nodes)
	       {     
	        int i, j;
	        System.out.print("\nRead in the weights/costs of all edges between 2 Vertices in the graph:\n");
	          for(i = 0; i < W.length; i++)
	          {
	        	  System.out.println();
	              for (j = 0; j < W[i].length; j++)
	             {
	            	System.out.print("Read in the weight/cost of edge between Node "+ Nodes[i] 
	                  + " and Node " + Nodes[j] + ": ");
					W[i][j] = scanInput.nextInt();
					if (W[i][j] == 0) W[i][j] = INFINTY;
	             } 
	             
	          }    
	       }

	       private void DisplayWeight(int[][] W)
	       {     
	    	   int i, j;
	    	   System.out.print("\nThe weights/costs Table of all edges between 2 Vertices in the graph:\n");
	    	   for (i = 0; i < W.length; i++)
	    	   {
	            for (j = 0; j < W[i].length; j++)
	             {
	            	if(W[i][j] == INFINTY) System.out.printf("   INF");
					else
					System.out.printf("%6d", W[i][j]);
	             } 
	            System.out.print("\n");
	    	   }
	       
	      }

	    private void FindShortestPath(char Vertices[], int Edges[][], char source, char target)
	    {
	    	    int souce = 0, j, u, v, taget = 0, i, w, Null = -1;
				int[] distance, predecessor, S; 
				int found = FALSE; 
				/* Dynamically Allocate Array */        
				distance = new int[Vertices.length]; 
				predecessor = new int[Vertices.length]; 
				S = new int[Vertices.length];    
			 
	    	 /* Verify source */
	    	 for (j = 0; j < Vertices.length; j++)
	    	 {
	    		 if(source == Vertices[j])
	    		 {
	                souce = j; 
	                found = TRUE;
	                break;
	    		 }        
	    	 }

	    	 if (found == FALSE) 
	    	  { System.out.print("\nWrong Input! Source Node not found; No path found: "); return;}
	    	 	found = FALSE;
	    	 	/* Verify target */        
	    	 for(j = 0; j < Vertices.length; j++)
	    	 {
	    		 if(target == Vertices[j])
	    		 {
	                taget = j; 
	                found = TRUE;
	                break;
	    		 }        
	    	 }

			if (found == FALSE) 
			{ System.out.print("\nWrong Input! Target Node not found; No path found: "); return;  }	     
			
			//Implementing Bellman Ford Algorithm
				//Step 1: initialize graph
				 for(v = 0; v < Vertices.length; v++)
				 {
				   if(v == souce) distance[v] = 0; //distance from source to source
				   else
						distance[v] = INFINTY; //unknown distance function from source to v
				   predecessor[v] = Null; //predecessor node in optimal path from source 
				 }
				 //Step 2: relax edges repeatedly
				 for(i = 0; i < Vertices.length-1; i++)
				 {
					for(u = 0; u < Vertices.length; u++)
					{   
					   for(v = 0; v < Vertices.length; v++)
					   {           
						   w = Edges[u][v];
						   if((distance[u] + w) < distance[v])
						   {
								  distance[v] = distance[u] + w;
								  predecessor[v] = u;       
						   }        
					   }
					}  
				 }
				 
				 //return distance[], predecessor[]
				 System.out.print("\nDistance table: \n") ;
				 for(v = 0; v < Vertices.length; v++) 
				 {
					   if(distance[v] == INFINTY) System.out.print("INF\t");
					   else 
					   System.out.print(distance[v]+" \t");
							 
				 }
				 
				 System.out.print("\nPredecessor table: \n");
				 for(v = 0; v < Vertices.length; v++) System.out.print(predecessor[v]+1 + " \t");
			   
				
				 //getting the shortest path
				 j = 0;
				 u = taget;
				 while(predecessor[u] != Null) //construct the shortest path with a stack S
				 {
					S[j++] = u;             //Push the vertex onto the stack
					u = predecessor[u];    //Traverse from target to source
				 }
				  //display shortest path
				System.out.print("\n\nSuccessful, A Path Found!!! \nThe Shortest Path between " +
				 source + " and " + target + " is:\n " + source + "--->");
				for(v = j-1; v > 0; v--) System.out.print(Vertices[S[v]]+ "--->");
				System.out.print(Vertices[S[0]]+ "\n");
				System.out.print("\nThe weight/cost of the shortest path between Node: " +
				 source + " and Node: " + target + " is " + distance[taget] + "\n");
	    }
		
}
