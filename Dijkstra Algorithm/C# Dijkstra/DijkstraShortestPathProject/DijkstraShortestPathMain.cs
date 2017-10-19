/* A C# Program to compute the Shortest Path using Dijkstra Algorithm
 * This is a main Class name: DijkstraShortestPathMain.cs
 * Project Developed by:
 */
using System;


namespace DijkstraShortestPathProject
{
    class DijkstraShortestPathMain
    {
        static void Main(string[] args)
        {
            int n;
            Console.WriteLine("Welcome to C# Program developed to implement Dijkstra Algorithm:");
            Console.WriteLine("=================================================================\n");
            Console.Write("Read in Number of Vertices/Nodes in Graph: ");
            n = Convert.ToInt32(Console.ReadLine());
            DijkstraShortestPath dijkstra = new DijkstraShortestPath(n);
            dijkstra.ShortestPath();
        }
    }
}
