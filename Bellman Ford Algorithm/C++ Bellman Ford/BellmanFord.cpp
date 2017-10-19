/* A C++ Program to compute the Shortest Path using Bellman Ford Algorithm
 * Project Developed by
 */
#include <cstdlib>
#include <iostream>
#include <conio.h>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>
#define MAXNODE 10
#define TRUE 1
#define FALSE 0
#define INFINTY 9999

using std::cout;
using std::cin;

class BellmanFord {
    private:  
              int Edges[MAXNODE][MAXNODE], n, ch;
              char Vertices[MAXNODE];
    public:
              void ReadNodes(char Nodes[], int N);
              void ReadWeight(int W[][MAXNODE], int N, char Nodes[]);
              void DisplayWeight(int W[][MAXNODE], int N);
              void BellmanFordShortestPath(char Vertices[], int Edges[][MAXNODE], int M, char source, char target);
              void ShortestPath();
};             

int main()
{
    BellmanFord bellmanFord;
    bellmanFord.ShortestPath();
    system("PAUSE");	
    return 0;
}

void BellmanFord::ShortestPath()
{
  char source, target;
  cout<<"Welcome to C++ Program developed to implement Bellman Ford Algorithm:";
  cout<<"\n================================================================\n";
  cout<<"Read in Number of Vertices/Nodes in Graph: ";
  cin>> n;
  if (n <= 0 || n > MAXNODE)
  {
    cout<<"\nWrong Input! Please, Read in correct digit from 1 to 10:";      
  }
  else
  {
       ReadNodes(Vertices, n); // Read in N nodes
       ReadWeight(Edges, n, Vertices); //Read in weight/cost of each edges
       DisplayWeight(Edges, n); // Display Matrix of Weight 
       cout<<"\n Do you wish to find Shortest Path between two Vertices/Nodes in  the Graph:\n ";
       cout<<"Press 1 -> Yes \n Press 0 or any other digit -> No\n";
       cin>>ch;
       if(ch == 1) 
       {
             cout<<"\nRead in the Source Node/Vertex: ";     cin>>source;
             cout<<"\nRead in the Target Node/Vertex: ";     cin>>target;
             BellmanFordShortestPath(Vertices, Edges, n, source, target);
       } //end if
  } //end else
  
}

void BellmanFord::ReadNodes(char Nodes[], int N)
{     
       int i;
       cout<<"Read in the names of all Nodes/Vertices in the graph\n";
       for(i = 0; i < N; i++)
       {
             cout<<"\nRead in the names of Node/Vertex "<<i+1<<":\t";
             cin>>Nodes[i];
       }
       Nodes[i] = '\0';
}       

void BellmanFord::ReadWeight(int W[][MAXNODE], int N, char Nodes[])
{     
       int i, j;
       cout<<"\nRead in the weights/costs of all edges between 2 Vertices in the graph:\n";
       for(i = 0; i < N; i++)
       {
             cout<<"\n";
             for(j = 0; j < N; j++)
             {
              cout<<"Read in the weight/cost of edge between Node "<<Nodes[i]<<" and Node "<<Nodes[j]<<": ";
              cin>>W[i][j];
              if (W[i][j] == 0) W[i][j] = INFINTY;
             } 
             
       }
       
}

void BellmanFord::DisplayWeight(int W[][MAXNODE], int N)
{     
       int i, j;
       cout<<"\nThe weights/costs Table of all edges between 2 Vertices in the graph:\n";
       for(i = 0; i < N; i++)
       {
             for(j = 0; j < N; j++)
             {
               if(W[i][j] == INFINTY) cout<<"INF\t";
               else
               cout<<W[i][j]<<"\t";
             } 
             cout<<"\n";
       }
       
}

void BellmanFord::BellmanFordShortestPath(char Vertices[], int Edges[][MAXNODE], int M, char source, char target)
{
   int souce, j, alt, u, v, taget, i, w;
   int *distance, *predecessor, *S; 
   int found = FALSE, null = -1;
   /* Dynamically Allocate Array */        
   distance = (int *) (malloc(M * sizeof(int))); 
   predecessor = (int *) (malloc(M * sizeof(int))); 
   S = (int *) (malloc(M * sizeof(int)));    
     /* Verify source */        
     for(j = 0; j < M; j++)
     {
        if(source == Vertices[j])
        {
                souce = j; //get the index position of source from the Node
                found = TRUE;
                break;
        }        
     }
     
     if (found == FALSE) 
     { cout<<"\nWrong Input! Source Node not found; No path found: "; exit(0);}
    
     found = FALSE;
     /* Verify target */        
     for(j = 0; j < M; j++)
     {
        if(target == Vertices[j])
        {
                taget = j; 
                found = TRUE;
                break;
        }        
     }

     if (found == FALSE) 
    { cout<<"\nWrong Input! Target Node not found; No path found: "; exit(0);  }
    //Implementing Bellman Ford Algorithm
    //Step 1: initialize graph
     for(v = 0; v < M; v++)
     {
       if(v == souce) distance[v] = 0; //distance from source to source
       else
            distance[v] = INFINTY; //unknown distance function from source to v
       predecessor[v] = null; //predecessor node in optimal path from source 
     }
     //Step 2: relax edges repeatedly
     for(i = 0; i < M-1; i++)
     {
        for(u = 0; u < M; u++)
        {   
           for(v = 0; v < M; v++)
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
     cout << "\nDistance table: \n" ;
     for(v = 0; v < M; v++) 
     {
           if(distance[v] == INFINTY) cout<<"INF\t";
           else 
           cout<<distance[v]<<" \t";
                 
     }
     
     cout<<"\nPredecessor table: \n";
     for(v = 0; v < M; v++) cout<<predecessor[v]+1<<" \t";
   
    
     //getting the shortest path
     j = 0;
     u = taget;
     while(predecessor[u] != null) //construct the shortest path with a stack S
     {
         S[j++] = u;             //Push the vertex onto the stack
         u = predecessor[u];            //Traverse from target to source
     }
      
     //display shortest path
     cout<<"\n\nSuccessful, A Path Found!!! \nThe Shortest Path between "
     <<source<<" and "<<target<<" is: "<<"\n  "<<source<<"--->";
     for(v = j-1; v > 0; v--) cout<<Vertices[S[v]]<<"--->";
     cout<<Vertices[S[0]]<<"\n";
     cout<<"The weight/cost of the shortest path between Node: "<<source<<" and Node: "
     <<target<<" is: "<<distance[taget]<<"\n";
     
}
