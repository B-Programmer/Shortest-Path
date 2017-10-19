/* A C# Program to compute the Shortest Path using Bellman Ford Algorithm
 * This is a main Class name: BellmanFordShortestPathMain.cs
 * Project Developed by
 */
using System;


namespace BellmanFordShortestPathProject
{
    class BellmanFordShortestPathMain
    {
        static void Main(string[] args)
        {
            int n;
            Console.WriteLine("Welcome to C# Program developed to implement Bellman Ford Algorithm:");
            Console.WriteLine("=================================================================\n");
            Console.Write("Read in Number of Vertices/Nodes in Graph: ");
            n = Convert.ToInt32(Console.ReadLine());
            BellmanFordShortestPath bellmanFord = new BellmanFordShortestPath(n);
            bellmanFord.ShortestPath();
        }
    }
}
