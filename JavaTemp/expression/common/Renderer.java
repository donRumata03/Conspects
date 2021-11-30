package expression.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.function.BinaryOperator;
import java.util.function.Function;
import java.util.function.UnaryOperator;

/**
 * @author Georgiy Korneev (kgeorgiy@kgeorgiy.info)
 */
public class Renderer<C, T> {
    private final Function<C, T> constant;
    private final Map<String, Function<List<T>, T>> renderers = new HashMap<>();

    public Renderer(final Function<C, T> constant) {
        this.constant = constant;
    }

    public void add(final String name, final int arity, final Function<List<T>, T> renderer) {
        any(Node.id(name, arity), renderer);
    }

    public void any(final String id, final Function<List<T>, T> renderer) {
        renderers.put(id, renderer);
    }

    public void nullary(final String name, final T value) {
        add(name, 0, args -> value);
    }

    public void unary(final String name, final UnaryOperator<T> op) {
        add(name, 1, args -> op.apply(args.get(0)));
    }

    public void binary(final String name, final BinaryOperator<T> op) {
        add(name, 2, args -> op.apply(args.get(0), args.get(1)));
    }

    public T render(final Node<C> node) {
        return node.cata(constant, (name, args) -> Objects.requireNonNull(renderers.get(name), name).apply(args));
    }
}
