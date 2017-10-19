/* A JAVA Program to compute the Shortest Path using Floyd Warshall Algorithm
 * Class Name: FloydWarshall.java
 * Project Developed by
 */
import java.util.Scanner; 

public class FloydWarshall {
	
	       private final int MAXNODE = 10;
	       private final int TRUE = 1;
	       private final int FALSE = 0;
	       private final int INFINTY = 9999;
		   private final int NULL = -1;

	       private int[][]  Weight;
	       private int[][] Dist ;
		   private int[][] Next ;
	       public int noOfNodes;
	       private char[] Node;
	       
	       Scanner scanInput = new Scanner(System.in);

	      
	       public FloydWarshall(int N)
	       {
	           setNoOfNodes(N);
	           Weight = new int[N][N];
	           Dist = new int[N][N];
			   Next = new int[N][N];
	           Node = new char[N];
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
	            ReadNodes(Node); // Read in N nodes
	            ReadWeight(Weight, Node); //Read in weight/cost of each edges
	            DisplayWeight(Weight); // Display Matrix of Weight
	            ComputeShortestPath(Weight, Dist, Next);
				DisplayShortestPath(Dist);
	            System.out.println("\n Do you wish to find Shortest Path between two Vertices/Nodes in  the Graph:\n ");
	            System.out.println("Press 1 -> Yes \n Press 0 or any other digit -> No\n");
	            ch = scanInput.nextInt();
	            if(ch == 1) FindShortestPath(Dist, Node, Next);
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
	            	System.out.printf("%6d", W[i][j]);
	             } 
	            System.out.print("\n");
	    	   }
	       
	      }

	      private void ComputeShortestPath(int edge[][], int dist[][], int next[][])
	      {     
					  int i, j, k, u, v;
			   /* initialize dist */
			   for(u = 0; u < edge.length; u++)
			   {
					 for(v = 0; v < edge[u].length; v++)
					 {
						if (edge[u][v] == 0) { dist[u][v] = INFINTY; next[u][v] = NULL; }
						else 
						{ dist[u][v] = edge[u][v]; next[u][v] = v; }
					 } 
					 
			   }
			   /* Update dist with standard Floyd-Warshall implementation */
			   for(k = 0; k < dist.length; k++)
			   {
				 for(i = 0; i < dist.length; i++)
				 {
					for(j = 0; j < dist.length; j++)
					{
						if(dist[i][j] > dist[i][k] + dist[k][j])
						{ 
							dist[i][j] = dist[i][k] + dist[k][j]; 
							next[i][j] = next[i][k];
						}
					} 
					 
				 }
			   }
	      }

	     private void DisplayShortestPath(int[][] dist)
	     {     
	       int i, j;
	       System.out.print("\nThe Shortest Path Table of all path between 2 Vertices in the graph:\n");
	       for (i = 0; i < dist.length; i++)
	       {
	           for (j = 0; j < dist[i].length; j++)
	             {
	               if(dist[i][j] == INFINTY) System.out.print("   INF");
	               else
	            	   System.out.printf("%6d", dist[i][j]);
	             } 
	           System.out.print("\n");
	       }
	       
	     }

	    private void FindShortestPath(int[][] dist, char Nodes[], int[][] next)
	    {
	    	 char source, target;
	    	 int u = 0, j, v = 0, k = 0, cost;
			 int[] path = new int[Nodes.length];
	    	 int found;
	    	 found = FALSE;
	    	 System.out.print("\nRead in the Source Node/Vertex: ");
	    	 String str = scanInput.next();
	    	 source = str.charAt(0);
	    	 System.out.print("\nRead in the Target Node/Vertex: ");
	    	 str = scanInput.next();
	    	 target = str.charAt(0);
	    	 
	    	 /* Verify source */
	    	 for (j = 0; j < Nodes.length; j++)
	    	 {
	    		 if(source == Nodes[j])
	    		 {
	                u = j; 
	                found = TRUE;
	                break;
	    		 }        
	    	 }

	    	 if (found == FALSE) 
	    	  { System.out.print("\nWrong Input! Source Node not found; No path found: "); return;}
	    	 	found = FALSE;
	    	 	/* Verify target */        
	    	 for(j = 0; j < Nodes.length; j++)
	    	 {
	    		 if(target == Nodes[j])
	    		 {
	                v = j; 
	                found = TRUE;
	                break;
	    		 }        
	    	 }

			if (found == FALSE) 
			{ System.out.print("\nWrong Input! Target Node not found; No path found: "); return;  }	     
			
			cost = dist[u][v]; //get the shortest distance between source and target
			 //procedure to construct path
			 if(next[u][v] == NULL)
			 { System.out.print("\n Failure, No path found! "); return; }
			 path[k] = u;
			 while(u != v)
			 {
				u = next[u][v];
				path[++k] = u;
			 }      
			 //display shortest path
			 System.out.print("\n\nSuccessful, A Path Found!!! \nThe Shortest Path between " +
				 source + " and " + target + " is:\n " + source + "--->");
			 for(j = 1; j < k; j++) System.out.print(Node[path[j]]+ "--->");
			 System.out.print(Node[path[k]]+ "\n");
			 System.out.print("\nThe weight/cost of the shortest path between Node: " +
				 source + " and Node: " + target + " is " + cost + "\n");
	    }
		
}


