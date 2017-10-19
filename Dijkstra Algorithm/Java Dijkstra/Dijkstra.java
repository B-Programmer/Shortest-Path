/* A JAVA Program to compute the Shortest Path using Dijkstra Algorithm
 * Class Name: Dijkstra.java
 * Project Developed by
 */
import java.util.Scanner; 

public class Dijkstra {
	
	       private final int MAXNODE = 10;
	       private final int TRUE = 1;
	       private final int FALSE = 0;
	       private final int INFINTY = 9999;
		   private final int VISITED = 1;
		   private final int UNVISITED = 0;

		   private int[][]  Weight;
	       public int noOfNodes;
	       private char[] Node;
		            
	       Scanner scanInput = new Scanner(System.in);
				      
	       public Dijkstra(int N)
	       {
	           setNoOfNodes(N);
	           Weight = new int[N][N];
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
					FindShortestPath(Node, Weight, source, target);
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

	    private void FindShortestPath(char Nodes[], int Length[][], char source, char target)
	    {
	    	    int souce = 0, j, u, v, taget = 0, alt, undefined = -1;
				int[] dist, prev, Q, visited, S; 
				int found = FALSE; 
				/* Dynamically Allocate Array */        
				dist = new int[Nodes.length]; 
				prev = new int[Nodes.length]; 
				Q = new int[Nodes.length];
				visited = new int[Nodes.length];
				S = new int[Nodes.length];    
			   
   	    	 /* Verify source */
	    	 for (j = 0; j < Nodes.length; j++)
	    	 {
	    		 if(source == Nodes[j])
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
	    	 for(j = 0; j < Nodes.length; j++)
	    	 {
	    		 if(target == Nodes[j])
	    		 {
	                taget = j; 
	                found = TRUE;
	                break;
	    		 }        
	    	 }

			if (found == FALSE) 
			{ System.out.print("\nWrong Input! Target Node not found; No path found: "); return;  }	     
			
			 dist[souce] = 0; //distance from source to source
			 prev[souce] = undefined; //previous node in optimal path initialization
			 
			 for(v = 0; v < Nodes.length; v++)
			 {
			   if(v != souce)
			   {
					dist[v] = INFINTY; //unknown distance function from source to v
					prev[v] = undefined; //previous node in optimal path from source 
			   }
			   Q[v] = v;
			   visited[v] = UNVISITED; 
			 }
			 
			 u = Q[minDist(dist, visited)]; //vertex u in Q with min dist[u]
			 visited[u] = VISITED;
			 while (visited[taget] == UNVISITED) //While (Q is not empty)
			 {
				   for(v = 0; v < Nodes.length; v++)
				   {           
					   alt = dist[u] + Length[u][v];
					   if((alt < dist[v]) && (visited[v] == UNVISITED))
					   {
							dist[v] = alt;
							prev[v] = u;       
					   }        
				   }
				   u = Q[minDist(dist, visited)]; //vertex u in Q with min dist[u]
				   visited[u] = VISITED;
			 }
			 
			 //return dist[], prev[]
			 System.out.print("\nDistance table: \n");
			 for(v = 0; v < Nodes.length; v++) 
			 {
				   if(dist[v] == INFINTY) System.out.print("INF\t");
				   else 
				   System.out.print(dist[v] + " \t");
						 
			 }
			 
			 System.out.print("\nPrev table: \n");
			 for(v = 0; v < Nodes.length; v++) System.out.print(prev[v]+1 + " \t");
			 
			 //getting the shortest path
			 j = 0;
			 u = taget;
			 while(prev[u] != undefined) //construct the shortest path with a stack S
			 {
				 S[j++] = u;             //Push the vertex onto the stack
				 u = prev[u];            //Traverse from target to source
			 }
				  //display shortest path
				System.out.print("\n\nSuccessful, A Path Found!!! \nThe Shortest Path between " +
				 source + " and " + target + " is:\n " + source + "--->");
				for(v = j-1; v > 0; v--) System.out.print(Nodes[S[v]]+ "--->");
				System.out.print(Nodes[S[0]]+ "\n");
				System.out.print("\nThe weight/cost of the shortest path between Node: " +
				 source + " and Node: " + target + " is " + dist[taget] + "\n");
	    }
		
		private int minDist(int Dist[], int visit[])
		{ 
			int v, temp = INFINTY, n = -1;
			for(v = 0; v < Dist.length; v++)
			{           
				if((temp > Dist[v])&& (visit[v] == UNVISITED)) {temp = Dist[v]; n = v; }        
			}
			return n;    
		}
		
}
