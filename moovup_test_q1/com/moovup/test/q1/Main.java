package com.moovup.test.q1;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class Main {

    public static void main(String[] args) {
        Node nodeA = new Node("A");
        Node nodeB = new Node("B");
        Node nodeC = new Node("C");
        Node nodeD = new Node("D");
        Node nodeE = new Node("E");
        Node nodeF = new Node("F");
        Node nodeG = new Node("G");
        Node nodeH = new Node("H");

        nodeA.addAdjacentNode(nodeB, nodeD, nodeH);
        nodeB.addAdjacentNode(nodeA, nodeD, nodeC);
        nodeC.addAdjacentNode(nodeB, nodeD, nodeF);
        nodeD.addAdjacentNode(nodeA, nodeB, nodeC, nodeE);
        nodeE.addAdjacentNode(nodeD, nodeF, nodeH);
        nodeF.addAdjacentNode(nodeC, nodeE, nodeG);
        nodeG.addAdjacentNode(nodeF, nodeH);
        nodeH.addAdjacentNode(nodeA, nodeE, nodeG);

        // Question A
        List<Path> possiblePathList = findPossiblePathBetween(nodeA, nodeH, new Path());
        System.out.println("Question A result:");
        for (Path path : possiblePathList) {
            System.out.println(path);
        }
        System.out.println("==================================");

        // Question B
        List<Path> shortestPathList = findShortestPathBetween(nodeA, nodeH);
        System.out.println("Question B result:");
        for (Path path : shortestPathList) {
            System.out.println(path);
        }
    }

    public static List<Path> findPossiblePathBetween(Node startNode, Node endNode, Path path) {
        List<Path> possiblePathList = new ArrayList<>();
        for (Node adjacentNode : startNode.getAdjacentNodes()) {
            Path newPath = new Path(path);
            newPath.addNode(startNode);

            if (startNode == endNode) { // reached destination
                possiblePathList.add(newPath);
                return possiblePathList;
            }
            if (!newPath.containsNode(adjacentNode)) {
                possiblePathList.addAll(findPossiblePathBetween(adjacentNode, endNode, newPath));
            }
        }
        return possiblePathList;
    }

    public static List<Path> findShortestPathBetween(Node startNode, Node endNode) {
        List<Path> possiblePathList = findPossiblePathBetween(startNode, endNode, new Path());
        List<Path> shortestPathList = possiblePathList.stream().min(Comparator.comparing(path -> Integer.valueOf(path.getNodes().size())))
                .stream().toList();
        return shortestPathList;
    }

}