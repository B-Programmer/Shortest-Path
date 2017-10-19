/* A C# Program to compute the Shortest Path using Bellman Ford Algorithm
 * This is a Class name: BellmanFordShortestPath.cs
 * Project Developed by
 */
using System;

namespace BellmanFordShortestPathProject
{
    class BellmanFordShortestPath
    {
           private const int MAXNODE = 10;
	       private const int TRUE = 1;
	       private const int FALSE = 0;
	       private const int INFINTY = 9999;
		   
	       private int[,]  Edge;
	       public int noOfNodes;
	       private char[] Vertice;
		                
	       		      
	       public BellmanFordShortestPath(int N)
	       {
	           setNoOfNodes(N);
	           Edge = new int[N,N];
	           Vertice = new char[N];
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
	            ReadNodes(Vertice); // Read in N nodes
				ReadWeight(Edge, Vertice); //Read in weight/cost of each edges
				DisplayWeight(Edge); // Display Matrix of Weight 
	            Console.WriteLine("\n Do you wish to find Shortest Path between two Vertices/Nodes in  the Graph:\n ");
	            Console.WriteLine("Press 1 -> Yes \n Press 0 or any other digit -> No\n");
	            ch = Convert.ToInt32(Console.ReadLine());
	            if(ch == 1) 
				{
					Console.Write("\nRead in the Source Node/Vertex: ");
					char source = Convert.ToChar(Console.ReadLine());
					Console.Write("\nRead in the Target Node/Vertex: ");
					char target = Convert.ToChar(Console.ReadLine());
					FindShortestPath(Vertice, Edge, source, target);
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
               for (i = 0; i < W.GetLength(0); i++)
               {
                   Console.WriteLine();
                   for (j = 0; j < W.GetLength(1); j++)
                   {
                       Console.Write("Read in the weight/cost of edge between Node " + Nodes[i]
                         + " and Node " + Nodes[j] + ": ");
                       W[i, j] = Convert.ToInt32(Console.ReadLine());
                       if (W[i, j] == 0) W[i, j] = INFINTY;
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
                       if (W[i, j] == INFINTY) Console.Write("   INF");
                       else
                           Console.Write("{0,6}", W[i, j]);
                   }
                   Console.WriteLine();
               }

           }

	    private void FindShortestPath(char[] Vertices, int[,] Edges, char source, char target)
	    {
	    	    int souce = 0, j, u, v, taget = 0, i, w, Null = -1;
				int[] distance, predecessor, S; 
				int found = FALSE; 
				/* Dynamically Allocate Array */        
				distance = new int[Vertices.Length]; 
				predecessor = new int[Vertices.Length]; 
				S = new int[Vertices.Length];    
			 
	    	 /* Verify source */
	    	 for (j = 0; j < Vertices.Length; j++)
	    	 {
	    		 if(source == Vertices[j])
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
	    	 for(j = 0; j < Vertices.Length; j++)
	    	 {
	    		 if(target == Vertices[j])
	    		 {
	                taget = j; 
	                found = TRUE;
	                break;
	    		 }        
	    	 }

			if (found == FALSE) 
			{ Console.Write("\nWrong Input! Target Node not found; No path found: "); return;  }	     
			
			//Implementing Bellman Ford Algorithm
				//Step 1: initialize graph
				 for(v = 0; v < Vertices.Length; v++)
				 {
				   if(v == souce) distance[v] = 0; //distance from source to source
				   else
						distance[v] = INFINTY; //unknown distance function from source to v
				   predecessor[v] = Null; //predecessor node in optimal path from source 
				 }
				 //Step 2: relax edges repeatedly
				 for(i = 0; i < Vertices.Length-1; i++)
				 {
					for(u = 0; u < Vertices.Length; u++)
					{   
					   for(v = 0; v < Vertices.Length; v++)
					   {           
						   w = Edges[u,v];
						   if((distance[u] + w) < distance[v])
						   {
								  distance[v] = distance[u] + w;
								  predecessor[v] = u;       
						   }        
					   }
					}  
				 }
				 
				 //return distance[], predecessor[]
				 Console.Write("\nDistance table: \n") ;
				 for(v = 0; v < Vertices.Length; v++) 
				 {
					   if(distance[v] == INFINTY) Console.Write("INF\t");
					   else 
					   Console.Write(distance[v]+" \t");
							 
				 }
				 
				 Console.Write("\nPredecessor table: \n");
				 for(v = 0; v < Vertices.Length; v++) Console.Write(predecessor[v]+1 + " \t");
			   
				
				 //getting the shortest path
				 j = 0;
				 u = taget;
				 while(predecessor[u] != Null) //construct the shortest path with a stack S
				 {
                    S[j++] = u;             //Push the vertex onto the stack
					u = predecessor[u];    //Traverse from target to source
				 }
				  //display shortest path
				Console.Write("\n\nSuccessful, A Path Found!!! \nThe Shortest Path between " +
				 source + " and " + target + " is:\n " + source + "--->");
				for(v = j-1; v > 0; v--) Console.Write(Vertices[S[v]]+ "--->");
				Console.Write(Vertices[S[0]]+ "\n");
                Console.Write("\nThe weight/cost of the shortest path between Node: " +
				 source + " and Node: " + target + " is " + distance[taget] + "\n");
	    }
		
    }
}
