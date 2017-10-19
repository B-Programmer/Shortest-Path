/* A C++ Program to compute the Shortest Path using Floyd Warshall Algorithm
 * Project Developed by
 */

#include <iostream>
#include <conio.h>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>
#define MAXNODE 10
#define TRUE 1
#define FALSE 0
#define Null -1
#define INFINTY 9999

using std::cout;
using std::cin;

class FloydWarshall {
    private:  
              int Weight[MAXNODE][MAXNODE], Dist[MAXNODE][MAXNODE], Next[MAXNODE][MAXNODE], n, ch;
              char Node[MAXNODE];
    public:
              void ReadNodes(char Nodes[], int N);
              void ReadWeight(int W[][MAXNODE], int N, char Nodes[]);
              void DisplayWeight(int W[][MAXNODE], int N);
              void ComputeShortestPath(int W[][MAXNODE], int M, int dist[][MAXNODE], int next[][MAXNODE]);
              void DisplayShortestPath(int dist[][MAXNODE], int M);
              void FindShortestPath(int dist[][MAXNODE], int M, char Nodes[], int next[][MAXNODE]);
              void ShortestPath();
};             

int main()
{
    FloydWarshall floydWarshall;
    floydWarshall.ShortestPath();
    system("PAUSE");	
    return 0;
}

void FloydWarshall::ShortestPath()
{
  
  cout<<"Welcome to C++ Program developed to implement Floyd Warshall Algorithm:";
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
       ComputeShortestPath(Weight, n, Dist, Next);
       DisplayShortestPath(Dist, n);
       cout<<"\n Do you wish to find Shortest Path between two Vertices/Nodes in  the Graph:\n ";
       cout<<"Press 1 -> Yes \n Press 0 or any other digit -> No\n";
       cin>>ch;
       if(ch == 1) FindShortestPath(Dist, n , Node, Next);
  }    
  
}

void FloydWarshall::ReadNodes(char Nodes[], int N)
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

void FloydWarshall::ReadWeight(int W[][MAXNODE], int N, char Nodes[])
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
             } 
             
       }
       
}

void FloydWarshall::DisplayWeight(int W[][MAXNODE], int N)
{     
       int i, j;
       cout<<"\nThe weights/costs Table of all edges between 2 Vertices in the graph:\n";
       for(i = 0; i < N; i++)
       {
             for(j = 0; j < N; j++)
             {
               cout<<W[i][j]<<"\t";
             } 
             cout<<"\n";
       }
       
}
     
void FloydWarshall::ComputeShortestPath(int edge[][MAXNODE], int M, int dist[][MAXNODE], int next[][MAXNODE])
{     
       int i, j, k, u, v;
       /* initialize dist */
       for(u = 0; u < M; u++)
       {
             for(v = 0; v < M; v++)
             {
                if (edge[u][v] == 0) { dist[u][v] = INFINTY; next[u][v] = Null; }
                else 
                { dist[u][v] = edge[u][v]; next[u][v] = v; }
             } 
             
       }
       /* Update dist with standard Floyd-Warshall implementation */
       for(k = 0; k < M; k++)
       {
         for(i = 0; i < M; i++)
         {
             for(j = 0; j < M; j++)
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

void FloydWarshall::DisplayShortestPath(int dist[][MAXNODE], int M)
{     
       int i, j;
       cout<<"\nThe Shortest Distance Table of all paths between 2 Vertices in the graph:\n";
       for(i = 0; i < M; i++)
       {
             for(j = 0; j < M; j++)
             {
               if(dist[i][j] == INFINTY) cout<<"INF\t";
               else
               cout<<dist[i][j]<<'\t';
             } 
             cout<<"\n";
       }
       
}

void FloydWarshall::FindShortestPath(int dist[][MAXNODE], int M, char Nodes[], int next[][MAXNODE])
{
     char source, target;
     int u, j, v, k = 0, cost;
     int *path; 
     int found = FALSE;
     path = (int*)(malloc(M * sizeof(int)));
     cout<<"\nRead in the Source Node/Vertex: ";
             cin>>source;
     cout<<"\nRead in the Target Node/Vertex: ";
            cin>>target;
     /* Verify source */        
     for(j = 0; j < M; j++)
     {
        if(source == Nodes[j])
        {
                u = j; 
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
                v = j; 
                found = TRUE;
                break;
        }        
     }

     if (found == FALSE) 
    { cout<<"\nWrong Input! Target Node not found; No path found: "; exit(0);  }
     
     cost = dist[u][v]; //get the shortest distance between source and target
     //procedure to construct path
     if(next[u][v] == Null)
     { cout<<"\n Failure, No path found! "; exit(0); }
     path[k] = u;
     while(u != v)
     {
        u = next[u][v];
        path[++k] = u;
     }      
     //display shortest path
     cout<<"\n\nSuccessful, A Path Found!!! \nThe Shortest Path between "
     <<source<<" and "<<target<<" is: "<<"\n  "<<source<<"--->";
     for(j = 1; j < k; j++) cout<<Node[path[j]]<<"--->";
     cout<<Node[path[k]]<<"\n";
     cout<<"The weight/cost of the shortest path between Node: "<<source<<" and Node: "
     <<target<<" is: "<<cost<<"\n";
          
}
