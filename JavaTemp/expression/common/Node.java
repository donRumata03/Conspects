package expression.common;

import java.util.Arrays;
import java.util.List;
import java.util.function.BiFunction;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * @author Georgiy Korneev (kgeorgiy@kgeorgiy.info)
 */
public interface Node<T> {
    <R> R get(final Function<T, R> constant, final BiFunction<String, List<Node<T>>, R> op);
    <R> R cata(final Function<T, R> constant, final BiFunction<String, List<R>, R> op);

    default int size() {
        return get(c -> 1, (op, args) -> 1 + args.stream().mapToInt(Node::size).sum());
    }

    @SafeVarargs
    static <T> Node<T> op(final String name, final Node<T>... args) {
        return op(id(name, args.length), Arrays.asList(args));
    }

    static <T> Node<T> op(final String name, final List<Node<T>> args) {
        return new Node<>() {
            @Override
            public <R> R get(final Function<T, R> constant, final BiFunction<String, List<Node<T>>, R> op) {
                return op.apply(name, args);
            }

            @Override
            public <R> R cata(final Function<T, R> constant, final BiFunction<String, List<R>, R> op) {
                return op.apply(name, args.stream().map(arg -> arg.cata(constant, op)).collect(Collectors.toUnmodifiableList()));
            }

            @Override
            public String toString() {
                return name + args;
            }
        };
    }

    static <T> Node<T> constant(final T value) {
        return new Node<>() {
            @Override
            public <R> R get(final Function<T, R> constant, final BiFunction<String, List<Node<T>>, R> op) {
                return constant.apply(value);
            }

            @Override
            public <R> R cata(final Function<T, R> constant, final BiFunction<String, List<R>, R> op) {
                return constant.apply(value);
            }

            @Override
            public String toString() {
                return String.valueOf(value);
            }
        };
    }

    static String id(final String name, final int arity) {
        assert arity >= 0;
        return name + ":" + arity;
    }
}
