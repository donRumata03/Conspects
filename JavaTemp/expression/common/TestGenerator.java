package expression.common;

import base.ExtendedRandom;
import base.TestCounter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.function.Consumer;
import java.util.function.Supplier;
import java.util.stream.Collectors;

/**
 * @author Georgiy Korneev (kgeorgiy@kgeorgiy.info)
 */
public class TestGenerator<C> {
    private final TestCounter counter;
    private final ExtendedRandom random;

    private final Generator<C> generator;
    private final FullRenderer<C> full = new FullRenderer<>();
    private final MiniRenderer<C> mini = new MiniRenderer<>();

    private final List<Node<C>> args;
    private final List<Node<C>> basicTests;
    private final List<Node<C>> variables = new ArrayList<>();
    private final List<Node<C>> consts;
    private final boolean vebose;

    public TestGenerator(
            final TestCounter counter,
            final ExtendedRandom random,
            final Supplier<C> constant,
            final List<C> constants,
            final boolean vebose) {
        this.counter = counter;
        this.random = random;
        this.vebose = vebose;

        generator = new Generator<>(random, constant);
        full.unary("(", a -> "(" + a + ")");

        consts = constants.stream().map(Node::constant).collect(Collectors.toUnmodifiableList());
        args = new ArrayList<>(consts);
        basicTests = new ArrayList<>(consts);
    }

    private void test(final Node<C> node, final Consumer<Test<C>> consumer) {
        consumer.accept(new Test<>(full.render(node), mini.render(node), node));
    }

    private Node<C> c() {
        return random.randomItem(consts);
    }

    private Node<C> v() {
        return random.randomItem(variables);
    }

    @SafeVarargs
    private static <C> Node<C> f(final String name, final Node<C>... arg) {
        return Node.op(name, arg);
    }

    @SafeVarargs
    private void basicTests(final Node<C>... tests) {
        basicTests.addAll(Arrays.asList(tests));
    }

    public void variable(final String name) {
        generator.add(name, 0);
        full.nullary(name);
        mini.nullary(name);
        basicTests(f(name));
        args.add(f(name));
        variables.add(f(name));
    }

    public void unary(final String name) {
        generator.add(name, 1);
        full.unary(name);
        mini.unary(name);

        if (vebose) {
            args.stream().map(a -> f(name, a)).forEachOrdered(basicTests::add);
        } else {
            basicTests(
                    f(name, c()),
                    f(name, v())
            );
        }

        final Node<C> p1 = f(name, f(name, f("+", v(), c())));
        final Node<C> p2 = f("*", v(), f("*", v(), f(name, c())));
        basicTests(
                f(name, f("+", v(), v())),
                f(name, f(name, v())),
                f(name, f("/", f(name, v()), f("+", v(), v()))),
                p1,
                p2,
                f("+", p1, p2)
        );
    }

    public void binary(final String name, final int priority) {
        generator.add(name, 2);
        full.binary(name);
        mini.binary(name, priority);

        if (vebose) {
            args.stream().flatMap(a -> args.stream().map(b -> f(name, a, b))).forEachOrdered(basicTests::add);
        } else {
            basicTests(
                    f(name, c(), c()),
                    f(name, v(), c()),
                    f(name, c(), v()),
                    f(name, v(), v())
            );
        }

        final Node<C> p1 = f(name, f(name, f("+", v(), c()), v()), v());
        final Node<C> p2 = f("*", v(), f("*", v(), f(name, c(), v())));

        basicTests(
                f(name, f(name, v(), v()), v()),
                f(name, v(), f(name, v(), v())),
                f(name, f(name, v(), v()), f(name, v(), v())),
                f(name, f("-", f(name, v(), v()), c()), f("+", v(), v())),
                p1,
                p2,
                f("+", p1, p2)
        );
    }

    public void testBasic(final Consumer<Test<C>> consumer) {
        basicTests.forEach(test -> {
            counter.println(full.render(test));
            test(test, consumer);
        });
    }

    public void testRandom(final int denominator, final Consumer<Test<C>> consumer) {
        generator.testRandom(denominator, counter, node -> test(node, consumer));
    }

    public String full(final Node<C> node) {
        return full.render(node);
    }

    public static class Test<C> {
        public final String full;
        public final String mini;
        public final Node<C> node;

        public Test(final String full, final String mini, final Node<C> node) {
            this.full = full;
            this.mini = mini;
            this.node = node;
        }
    }
}
