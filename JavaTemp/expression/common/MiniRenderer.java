package expression.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.BiPredicate;
import java.util.function.UnaryOperator;

/**
 * @author Georgiy Korneev (kgeorgiy@kgeorgiy.info)
 */
public class MiniRenderer<C> {
    private static final String PAREN = "(";
    private static final String SPACE = "_";

    private final Renderer<C, Node<C>> nodeRenderer = new Renderer<>(Node::constant);
    private final Renderer<C, String> stringRenderer = new Renderer<>(String::valueOf);
    private final Map<String, Integer> priorities = new HashMap<>();

    public MiniRenderer() {
        nodeRenderer.unary("(", arg -> Node.op(PAREN, arg));
        stringRenderer.unary("(", arg -> "(" + arg + ")");
        stringRenderer.unary("_", " "::concat);
    }

    public void nullary(final String name) {
        nodeRenderer.nullary(name, Node.op(name));
        stringRenderer.nullary(name, name);
    }

    public void unary(final String name) {
        nodeRenderer.unary(name, a -> Node.op(name, parensIf(a, (n, children) -> children.size() > 1, b -> Node.op(SPACE, b))));
        stringRenderer.unary(name, name::concat);
    }

    private Node<C> parensIf(final Node<C> node, final BiPredicate<String, List<Node<C>>> predicate) {
        return parensIf(node, predicate, UnaryOperator.identity());
    }

    private Node<C> parensIf(final Node<C> node, final BiPredicate<String, List<Node<C>>> predicate, final UnaryOperator<Node<C>> otherwise) {
        return node.get(
                c -> otherwise.apply(Node.constant(c)),
                (n, children) -> predicate.test(n, children)
                        ? Node.op(PAREN, Node.op(n, children))
                        : otherwise.apply(Node.op(n, children))
        );
    }

    public void unary(final String name, final UnaryOperator<String> op) {
        nodeRenderer.unary(name, UnaryOperator.identity());
        stringRenderer.unary(name, op);
    }

    private int priority(final String name) {
        return priorities.getOrDefault(name, Integer.MAX_VALUE);
    }

    public void binary(final String name, final int priority) {
        priorities.put(Node.id(name, 2), priority);

        nodeRenderer.binary(name, (a, b) -> {
            final int ab = Math.abs(priority);
            final Node<C> ap = parensIf(a, (n, c) -> Math.abs(priority(n)) / 2 < ab / 2);
            final Node<C> bp = parensIf(b, (n, c) -> {
                final int bap = Math.abs(priority(n));
                // :NOTE: Especially ugly bit-fiddling, do not replicate
                return bap / 2 < ab / 2 || bap <= (priority < 0 ? -priority | 1 : priority - 1);
            });
            return Node.op(name, ap, bp);
        });

        stringRenderer.binary(name, (a, b) -> a + " " + name + " " + b);
    }

    public String render(final Node<C> test) {
        return stringRenderer.render(nodeRenderer.render(test));
    }
}
