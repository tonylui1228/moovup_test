package com.moovup.test.q1;

import java.util.ArrayList;
import java.util.List;

public class Path {

    private List<Node> nodes;

    public Path(Path path) {
        this.nodes = new ArrayList<>(path.getNodes());
    }

    public Path() {
        this.nodes = new ArrayList<>();
    }

    public void addNode(Node node) {
        nodes.add(node);
    }

    public List<Node> getNodes() {
        return nodes;
    }

    public boolean containsNode(Node node) {
        return nodes.contains(node);
    }

    @Override
    public String toString() {
        return String.join(" => ", getNodes().stream().map(node -> node.getName()).toList());
    }
}
