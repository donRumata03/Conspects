package expression.common;

import java.util.function.UnaryOperator;

/**
 * @author Georgiy Korneev (kgeorgiy@kgeorgiy.info)
 */
public class FullRenderer<C> {
    private final Renderer<C, String> renderer = new Renderer<>(String::valueOf);

    public void nullary(final String name) {
        renderer.nullary(name, name);
    }

    public void unary(final String name) {
        renderer.unary(name, a -> name + "(" + a + ")");
    }

    public void unary(final String name, final UnaryOperator<String> op) {
        renderer.unary(name, op);
    }

    public void binary(final String name) {
        renderer.binary(name, (a, b) -> "(" + a + " " + name + " " + b + ")");
    }

    public String render(final Node<C> test) {
        return renderer.render(test);
    }
}
