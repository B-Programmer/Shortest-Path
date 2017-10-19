/* A C++ Program to compute the Shortest Path using Dijkstra Algorithm
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
#define VISITED 1
#define UNVISITED 0

using std::cout;
using std::cin;

class Dijkstra {
    private:  
              int Weight[MAXNODE][MAXNODE], n, ch;
              char Node[MAXNODE];
    public:
              void ReadNodes(char Nodes[], int N);
              void ReadWeight(int W[][MAXNODE], int N, char Nodes[]);
              void DisplayWeight(int W[][MAXNODE], int N);
              void DijkstraShortestPath(char Nodes[], int Length[][MAXNODE], int M, char source, char target);
              int minDist(int Dist[], int M, int visit[]);
              void ShortestPath();
};             

int main()
{
    Dijkstra dijkstra;
    dijkstra.ShortestPath();
    system("PAUSE");	
    return 0;
}

void Dijkstra::ShortestPath()
{
  char source, target;
  cout<<"Welcome to C++ Program developed to implement Dijkstra Algorithm:";
  cout<<"\n================================================================\n";
  cout<<"Read in Number of Vertices/Nodes in Graph: ";
  cin>> n;
  if (n <= 0 || n > MAXNODE)
  {
    cout<<"\nWrong Input! Please, Read in correct digit from 1 to 10:";      
  }
  else
  {
       ReadNodes(Node, n); // Read in N nodes
       ReadWeight(Weight, n, Node); //Read in weight/cost of each edges
       DisplayWeight(Weight, n); // Display Matrix of Weight 
       cout<<"\n Do you wish to find Shortest Path between two Vertices/Nodes in  the Graph:\n ";
       cout<<"Press 1 -> Yes \n Press 0 or any other digit -> No\n";
       cin>>ch;
       if(ch == 1) 
       {
             cout<<"\nRead in the Source Node/Vertex: ";     cin>>source;
             cout<<"\nRead in the Target Node/Vertex: ";     cin>>target;
             DijkstraShortestPath(Node, Weight, n, source, target);
       } //end if
  } //end else
  
}

void Dijkstra::ReadNodes(char Nodes[], int N)
{     
       int i;
       cout<<"Read in the names of all Nodes/Vertices in the graph\n";
       for(i = 0; i < N; i++)
       {
             cout<<"\nRead in the names of Node/Vertex "<<i+1<<":\t";
             //char c = getch(); cout"%c", c);
             cin>>Nodes[i];
       }
       Nodes[i] = '\0';
}       

void Dijkstra::ReadWeight(int W[][MAXNODE], int N, char Nodes[])
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

void Dijkstra::DisplayWeight(int W[][MAXNODE], int N)
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

void Dijkstra::DijkstraShortestPath(char Nodes[], int Length[][MAXNODE], int M, char source, char target)
{
   int souce, j, alt, u, v, taget;
   int *dist, *prev, *Q, *visited, *S;
   int found = FALSE, undefined = -1;
   /* Dynamically Allocate Array */        
   dist = (int *) (malloc(M * sizeof(int))); 
   prev = (int *) (malloc(M * sizeof(int))); 
   Q = (int *) (malloc(M * sizeof(int))); 
   visited = (int *) (malloc(M * sizeof(int))); 
   S = (int *) (malloc(M * sizeof(int)));
    
     /* Verify source */        
     for(j = 0; j < M; j++)
     {
        if(source == Nodes[j])
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
        if(target == Nodes[j])
        {
                taget = j; 
                found = TRUE;
                break;
        }        
     }

     if (found == FALSE) 
    { cout<<"\nWrong Input! Target Node not found; No path found: "; exit(0);  }

       
     dist[souce] = 0; //distance from source to source
     prev[souce] = undefined; //previous node in optimal path initialization
     
     for(v = 0; v < M; v++)
     {
       if(v != souce)
       {
            dist[v] = INFINTY; //unknown distance function from source to v
            prev[v] = undefined; //previous node in optimal path from source 
       }
       Q[v] = v;
       visited[v] = UNVISITED; 
     }
     
     u = Q[minDist(dist, M, visited)]; //vertex u in Q with min dist[u]
     visited[u] = VISITED;
     while (visited[taget] == UNVISITED) //While (Q is not empty)
     {
           for(v = 0; v < M; v++)
           {           
               alt = dist[u] + Length[u][v];
               if((alt < dist[v]) && (visited[v] == UNVISITED))
               {
                      dist[v] = alt;
                      prev[v] = u;       
               }        
           }
           u = Q[minDist(dist, M, visited)]; //vertex u in Q with min dist[u]
           visited[u] = VISITED;
     }
     
     //return dist[], prev[]
     cout << "\nDistance table: \n" ;
     for(v = 0; v < M; v++) 
     {
           if(dist[v] == INFINTY) cout<<"INF\t";
           else 
           cout<<dist[v]<<" \t";
                 
     }
     
     cout<<"\nPrev table: \n";
     for(v = 0; v < M; v++) cout<<prev[v]+1<<" \t";
     
     //getting the shortest path
     j = 0;
     u = taget;
     while(prev[u] != undefined) //construct the shortest path with a stack S
     {
         S[j++] = u;             //Push the vertex onto the stack
         u = prev[u];            //Traverse from target to source
     }
     
     //display shortest path
     cout<<"\n\nSuccessful, A Path Found!!! \nThe Shortest Path between "
     <<source<<" and "<<target<<" is: "<<"\n  "<<source<<"--->";
     for(v = j-1; v > 0; v--) cout<<Node[S[v]]<<"--->";
     cout<<Node[S[0]]<<"\n";
     cout<<"The weight/cost of the shortest path between Node: "<<source<<" and Node: "
     <<target<<" is: "<<dist[taget]<<"\n";
}

int Dijkstra::minDist(int Dist[], int M, int visit[])
{ 
    int v, temp = INFINTY, n = -1;
    for(v = 0; v < M; v++)
    {           
        if((temp > Dist[v])&& (visit[v] == UNVISITED)) {temp = Dist[v]; n = v; }        
    }
    return n;    
}
