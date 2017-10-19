/* A C# Program to compute the Shortest Path using Floyd Warshall Algorithm
 * This is a main Class name: FloydWarshallShortestPathMain.cs
 * Project Developed by
 */
using System;


namespace FloydWarshallShortestPathProject
{
    class FloydWarshallShortestPathMain
    {
        static void Main(string[] args)
        {
            int n;
            Console.WriteLine("Welcome to C# Program developed to implement Floyd Warshall Algorithm:");
            Console.WriteLine("=================================================================\n");
            Console.Write("Read in Number of Vertices/Nodes in Graph: ");
            n = Convert.ToInt32(Console.ReadLine());
            FloydWarshallShortestPath floydWarshall = new FloydWarshallShortestPath(n);
            floydWarshall.ShortestPath();
        }
    }
}
