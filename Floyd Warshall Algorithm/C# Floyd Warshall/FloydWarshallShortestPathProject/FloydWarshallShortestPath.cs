/* A C# Program to compute the Shortest Path using Floyd Warshall Algorithm
 * This is a Class name: FloydWarshallShortestPath.cs
 * Project Developed by
 */
using System;

namespace FloydWarshallShortestPathProject
{
    class FloydWarshallShortestPath
    {
           private const int MAXNODE = 10;
	       private const int TRUE = 1;
	       private const int FALSE = 0;
	       private const int INFINTY = 9999;
		   private const int NULL = -1;

	       private int[,]  Weight;
	       private int[,] Dist ;
		   private int[,] Next ;
	       public int noOfNodes;
	       private char[] Node;
	       
	       	      
	       public FloydWarshallShortestPath(int N)
	       {
	           setNoOfNodes(N);
	           Weight = new int[N,N];
	           Dist = new int[N,N];
			   Next = new int[N,N];
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
	            ComputeShortestPath(Weight, Dist, Next);
				DisplayShortestPath(Dist);
	            Console.WriteLine("\n Do you wish to find Shortest Path between two Vertices/Nodes in  the Graph:\n ");
	            Console.WriteLine("Press 1 -> Yes \n Press 0 or any other digit -> No\n");
	            ch = Convert.ToInt32(Console.ReadLine());
	            if(ch == 1) FindShortestPath(Dist, Node, Next);
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
	            	Console.Write("{0,6}", W[i,j]);
	             } 
	            Console.WriteLine();
	    	   }
	       
	      }

	      private void ComputeShortestPath(int[,] edge, int[,] dist, int[,] next)
	      {     
					  int i, j, k, u, v;
			   /* initialize dist */
			   for(u = 0; u < edge.GetLength(0); u++)
			   {
					 for(v = 0; v < edge.GetLength(1); v++)
					 {
						if (edge[u,v] == 0) { dist[u,v] = INFINTY; next[u,v] = NULL; }
						else 
						{ dist[u,v] = edge[u,v]; next[u,v] = v; }
					 } 
					 
			   }
			   /* Update dist with standard Floyd-Warshall implementation */
			   for(k = 0; k < dist.GetLength(0); k++)
			   {
				 for(i = 0; i < dist.GetLength(1); i++)
				 {
					for(j = 0; j < dist.GetLength(0); j++)
					{
						if(dist[i,j] > dist[i,k] + dist[k,j])
						{ 
							dist[i,j] = dist[i,k] + dist[k,j]; 
							next[i,j] = next[i,k];
						}
					} 
					 
				 }
			   }
	      }

	     private void DisplayShortestPath(int[,] dist)
	     {     
	       int i, j;
	       Console.Write("\nThe Shortest Path Table of all path between 2 Vertices in the graph:\n");
	       for (i = 0; i < dist.GetLength(0); i++)
	       {
	           for (j = 0; j < dist.GetLength(1); j++)
	             {
	               if(dist[i,j] == INFINTY) Console.Write("   INF");
	               else
	            	   Console.Write("{0,6}", dist[i,j]);
	             } 
	           Console.Write("\n");
	       }
	       
	     }

	    private void FindShortestPath(int[,] dist, char[] Nodes, int[,] next)
	    {
	    	 char source, target;
	    	 int u = 0, j, v = 0, k = 0, cost;
			 int[] path = new int[Nodes.Length];
	    	 int found;
	    	 found = FALSE;
	    	 Console.Write("\nRead in the Source Node/Vertex: ");
	    	 source = Convert.ToChar(Console.ReadLine());
	    	 Console.Write("\nRead in the Target Node/Vertex: ");
	    	 target = Convert.ToChar(Console.ReadLine());
	    	 
	    	 /* Verify source */
	    	 for (j = 0; j < Nodes.Length; j++)
	    	 {
	    		 if(source == Nodes[j])
	    		 {
	                u = j; 
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
	                v = j; 
	                found = TRUE;
	                break;
	    		 }        
	    	 }

			if (found == FALSE) 
			{ Console.Write("\nWrong Input! Target Node not found; No path found: "); return;  }	     
			
			cost = dist[u,v]; //get the shortest distance between source and target
			 //procedure to construct path
			 if(next[u,v] == NULL)
			 { Console.Write("\n Failure, No path found! "); return; }
			 path[k] = u;
			 while(u != v)
			 {
				u = next[u,v];
				path[++k] = u;
			 }      
			 //display shortest path
			 Console.Write("\n\nSuccessful, A Path Found!!! \nThe Shortest Path between " +
				 source + " and " + target + " is:\n " + source + "--->");
			 for(j = 1; j < k; j++) Console.Write(Node[path[j]]+ "--->");
			 Console.Write(Node[path[k]]+ "\n");
             Console.Write("\nThe weight/cost of the shortest path between Node: " +
				 source + " and Node: " + target + " is " + cost + "\n");
	    }
		
    }

}
