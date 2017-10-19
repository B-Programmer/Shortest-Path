/* A Java Program to compute the Shortest Path using Bellman Ford Algorithm
 * This is a main Class name: BellmanFordShortestPath.java
 * Project Developed by
 */
import java.util.Scanner; 

public class BellmanFordShortestPath {

	public static void main(String[] args)
    {
        Scanner scanInput = new Scanner(System.in);
		int n;
        System.out.println("Welcome to Java Program developed to implement Bellman Ford Algorithm:");
        System.out.println("=================================================================\n");
        System.out.print("Read in Number of Vertices/Nodes in Graph: ");
        n = scanInput.nextInt();
        BellmanFord bellmanFord = new BellmanFord(n);
        bellmanFord.ShortestPath();

    }
}