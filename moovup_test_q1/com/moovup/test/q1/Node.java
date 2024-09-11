package com.moovup.test.q1;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Node {

    private String name;
    private Set<Node> adjacentNodes = new HashSet<>();

    public Node(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public Set<Node> getAdjacentNodes() {
        return adjacentNodes;
    }

    public void addAdjacentNode(Node... nodes) {
        adjacentNodes.addAll(List.of(nodes));
    }

}
