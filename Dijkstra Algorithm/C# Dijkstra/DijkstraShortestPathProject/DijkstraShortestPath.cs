/* A C# Program to compute the Shortest Path using Dijkstra Algorithm
 * This is a Class name: DijkstraShortestPath.cs
 * Project Developed by:
 */
using System;

namespace DijkstraShortestPathProject
{
    class DijkstraShortestPath
    {
           private const int MAXNODE = 10;
	       private const int TRUE = 1;
	       private const int FALSE = 0;
	       private const int INFINTY = 9999;
		   private const int VISITED = 1;
		   private const int UNVISITED = 0;

		   private int[ , ]  Weight;
	       public int noOfNodes;
	       private char[] Node;
		            
	       			      
	       public DijkstraShortestPath(int N)
	       {
	           setNoOfNodes(N);
	           Weight = new int[N,N];
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
	           Console.WriteLine("Wrong Input! Please, Read in correct digit from 1 to 10:");      
	        }
	        else
	        {
	            ReadNodes(Node); // Read in N nodes
				ReadWeight(Weight, Node); //Read in weight/cost of each edges
				DisplayWeight(Weight); // Display Matrix of Weight 
	            Console.WriteLine("\n Do you wish to find Shortest Path between two Vertices/Nodes in  the Graph:\n ");
	            Console.WriteLine("Press 1 -> Yes \n Press 0 or any other digit -> No\n");
	            ch = Convert.ToInt32(Console.ReadLine());
	            if(ch == 1) 
				{
					Console.Write("\nRead in the Source Node/Vertex: ");
					char source = Convert.ToChar(Console.ReadLine());
					Console.Write("\nRead in the Target Node/Vertex: ");
                    char target = Convert.ToChar(Console.ReadLine());
					FindShortestPath(Node, Weight, source, target);
				}
	        }    
	  
	    }

	       private void ReadNodes(char[] Nodes)
	       {     
	         int i;
	         Console.WriteLine("Read in the names of all Nodes/Vertices in the graph");
	         for(i = 0; i < Nodes.Length; i++)
	          {
	        	 Console.Write("\nRead in the names of Node/Vertex " + (i+1) + ":\t" );
                 Nodes[i] = Convert.ToChar(Console.ReadLine());
	          }
	          
	       }

	       private void ReadWeight(int[,] W, char[] Nodes)
	       {     
	        int i, j;
	        Console.Write("\nRead in the weights/costs of all edges between 2 Vertices in the graph:\n");
	          for(i = 0; i < W.GetLength(0); i++)
	          {
	        	  Console.WriteLine();
	              for (j = 0; j < W.GetLength(1); j++)
	             {
	            	Console.Write("Read in the weight/cost of edge between Node "+ Nodes[i] 
	                  + " and Node " + Nodes[j] + ": ");
					W[i,j] = Convert.ToInt32(Console.ReadLine());
					if (W[i,j] == 0) W[i,j] = INFINTY;
	             } 
	             
	          }    
	       }

	       private void DisplayWeight(int[,] W)
	       {     
	    	   int i, j;
	    	   Console.Write("\nThe weights/costs Table of all edges between 2 Vertices in the graph:\n");
	    	   for (i = 0; i < W.GetLength(0); i++)
	    	   {
	            for (j = 0; j < W.GetLength(1); j++)
	             {
	            	if(W[i,j] == INFINTY) Console.Write("   INF");
					else
					Console.Write("{0,6}", W[i,j]);
	             } 
	            Console.WriteLine();
	    	   }
	       
	      }

	    private void FindShortestPath(char[] Nodes, int[,] length, char source, char target)
	    {
	    	    int souce = 0, j, u, v, taget = 0, alt, undefined = -1;
				int[] dist, prev, Q, visited, S; 
				int found = FALSE; 
				/* Dynamically Allocate Array */        
				dist = new int[Nodes.Length]; 
				prev = new int[Nodes.Length]; 
				Q = new int[Nodes.Length];
				visited = new int[Nodes.Length];
				S = new int[Nodes.Length];    
			   
   	    	 /* Verify source */
	    	 for (j = 0; j < Nodes.Length; j++)
	    	 {
	    		 if(source == Nodes[j])
	    		 {
	                souce = j; 
	                found = TRUE;
	                break;
	    		 }        
	    	 }

	    	 if (found == FALSE) 
	    	  { Console.Write("\nWrong Input! Source Node not found; No path found: "); return;}
	    	 
			 found = FALSE;
	    	 /* Verify target */        
	    	 for(j = 0; j < Nodes.Length; j++)
	    	 {
	    		 if(target == Nodes[j])
	    		 {
	                taget = j; 
	                found = TRUE;
	                break;
	    		 }        
	    	 }

			if (found == FALSE) 
			{ Console.Write("\nWrong Input! Target Node not found; No path found: "); return;  }	     
			
			 dist[souce] = 0; //distance from source to source
			 prev[souce] = undefined; //previous node in optimal path initialization
			 
			 for(v = 0; v < Nodes.Length; v++)
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
				   for(v = 0; v < Nodes.Length; v++)
				   {           
					   alt = dist[u] + length[u,v];
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
			 Console.Write("\nDistance table: \n");
			 for(v = 0; v < Nodes.Length; v++) 
			 {
				   if(dist[v] == INFINTY) Console.Write("INF\t");
				   else 
				   Console.Write(dist[v] + " \t");
						 
			 }
			 
			 Console.Write("\nPrev table: \n");
			 for(v = 0; v < Nodes.Length; v++) Console.Write(prev[v]+1 + " \t");
			 
			 //getting the shortest path
			 j = 0;
			 u = taget;
			 while(prev[u] != undefined) //construct the shortest path with a stack S
			 {
				 S[j++] = u;             //Push the vertex onto the stack
				 u = prev[u];            //Traverse from target to source
			 }
				  //display shortest path
				Console.Write("\n\nSuccessful, A Path Found!!! \nThe Shortest Path between " +
				 source + " and " + target + " is:\n " + source + "--->");
				for(v = j-1; v > 0; v--) Console.Write(Nodes[S[v]]+ "--->");
				Console.Write(Nodes[S[0]]+ "\n");
				Console.Write("\nThe weight/cost of the shortest path between Node: " +
				 source + " and Node: " + target + " is " + dist[taget] + "\n");
	    }

        private int minDist(int[] Dist, int[] visit)
		{ 
			int v, temp = INFINTY, n = -1;
			for(v = 0; v < Dist.Length; v++)
			{           
				if((temp > Dist[v])&& (visit[v] == UNVISITED)) {temp = Dist[v]; n = v; }        
			}
			return n;    
		}
		
    }
}
