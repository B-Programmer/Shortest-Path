/* A Java Program to compute the Shortest Path using Dijkstra Algorithm
 * This is a main Class name: DijkstraShortestPath.java
 * Project Developed by
 */
import java.util.Scanner; 

public class DijkstraShortestPath {

	public static void main(String[] args)
    {
        Scanner scanInput = new Scanner(System.in);
		int n;
        System.out.println("Welcome to Java Program developed to implement Dijkstra Algorithm:");
        System.out.println("=================================================================\n");
        System.out.print("Read in Number of Vertices/Nodes in Graph: ");
        n = scanInput.nextInt();
        Dijkstra dijkstra = new Dijkstra(n);
        dijkstra.ShortestPath();
    }
}