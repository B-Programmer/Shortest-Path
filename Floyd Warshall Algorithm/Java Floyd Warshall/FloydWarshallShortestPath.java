/* A Java Program to compute the Shortest Path using Floyd Warshall Algorithm
 * This is a main Class name: FloydWarshallShortestPath.java
 * Project Developed by
 */
import java.util.Scanner; 

public class FloydWarshallShortestPath {

	public static void main(String[] args)
    {
        Scanner scanInput = new Scanner(System.in);
		int n;
        System.out.println("Welcome to Java Program developed to implement Floyd Warshall Algorithm:");
        System.out.println("=================================================================\n");
        System.out.print("Read in Number of Vertices/Nodes in Graph: ");
        n = scanInput.nextInt();
        FloydWarshall floydWarshall = new FloydWarshall(n);
        floydWarshall.ShortestPath();

    }
}