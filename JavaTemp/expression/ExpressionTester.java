package expression;

import base.ExtendedRandom;
import base.Pair;
import expression.common.*;

import java.lang.reflect.Constructor;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.function.BiFunction;
import java.util.function.BinaryOperator;
import java.util.function.Function;

/**
 * @author Georgiy Korneev (kgeorgiy@kgeorgiy.info)
 */
public class ExpressionTester<E extends ToMiniString, V, C> extends BaseTester {
    private final List<Pair<ToMiniString, String>> prev = new ArrayList<>();
    private final BiFunction<E, V, Object> evaluate;
    private final List<V> values;
    private final Function<ExtendedRandom, C> randomValue;
    private final Function<ExtendedRandom, V> randomVars;
    private final Pair<Function<C, E>, Function<C, E>> constant;
    private final Binary<C, E> binary;
    private final BinaryOperator<C> add;
    private final BinaryOperator<C> sub;
    private final BinaryOperator<C> mul;
    private final BinaryOperator<C> div;
    private final List<Op<E>> vars;

    private final List<Test> basic = new ArrayList<>();
    private final List<Test> advanced = new ArrayList<>();

    @SafeVarargs
    protected ExpressionTester(
            final int mode,
            final BiFunction<E, V, Object> evaluate,
            final List<V> values,
            final Function<ExtendedRandom, C> randomValue,
            final Function<ExtendedRandom, V> randomVars,
            final Pair<Function<C, E>, Function<C, E>> constant,
            final Binary<C, E> binary, final BinaryOperator<C> add,
            final BinaryOperator<C> sub,
            final BinaryOperator<C> mul,
            final BinaryOperator<C> div,
            final Op<E>... vars
    ) {
        super(mode);
        this.evaluate = evaluate;
        this.values = values;
        this.randomValue = randomValue;
        this.randomVars = randomVars;
        this.constant = constant;
        this.binary = binary;
        this.add = add;
        this.sub = sub;
        this.mul = mul;
        this.div = div;
        this.vars = List.of(vars);
    }

    @Override
    protected void test() {
        counter.scope("Basic tests", () -> basic.forEach(Test::test));
        counter.scope("Advanced tests", () -> advanced.forEach(Test::test));
        counter.scope("Random tests", this::random);
    }

    protected void random() {
        final class Generators {
            private final Generator<C> generator = new Generator<>(random, () -> randomValue.apply(random));
            private final FullRenderer<C> full = new FullRenderer<>();
            private final MiniRenderer<C> mini = new MiniRenderer<>();
            private final Renderer<C, E> expected = new Renderer<>(constant.first);
            private final Renderer<C, E> actual = new Renderer<>(constant.second);
            private final Renderer<C, E> copy = new Renderer<>(constant.second);

            private Generators() {
                mini.binary("+",  200);
                mini.binary("-", -200);
                mini.binary("*",  301);
                mini.binary("/", -300);
            }

            @SuppressWarnings("unchecked")
            private void variable(final Op<E> variable) {
                final String name = variable.name;
                generator.add(name, 0);
                full.nullary(name);
                mini.nullary(name);

                expected.nullary(name, variable.value);
                actual.nullary(name, (E) new Variable(name));
                copy.nullary(name, (E) new Variable(name));
            }

            private void bin(final String name, final BinaryOperator<C> op, final Class<?> type) {
                generator.add(name, 2);
                full.binary(name);

                expected.binary(name, (a, b) -> binary.apply(op, a, b));

                @SuppressWarnings("unchecked") final Constructor<? extends E> constructor = (Constructor<? extends E>) Arrays.stream(type.getConstructors())
                        .filter(cons -> Modifier.isPublic(cons.getModifiers()))
                        .filter(cons -> cons.getParameterCount() == 2)
                        .findFirst()
                        .orElseGet(() -> counter.fail("%s(..., ...) constructor not found", type.getSimpleName()));
                final BinaryOperator<E> actual = (a, b) -> {
                    try {
                        return constructor.newInstance(a, b);
                    } catch (final Exception e) {
                        return counter.fail(e);
                    }
                };
                this.actual.binary(name, actual);
                copy.binary(name, actual);
            }

            private void testRandom() {
                generator.testRandom(1, counter, test -> {
                    final String full = this.full.render(test);
                    final String mini = this.mini.render(test);
                    final E expected = this.expected.render(test);
                    final E actual = this.actual.render(test);

                    checkEqualsAndToString(full, mini, actual, copy.render(test));
                    check(full, expected, actual, randomVars.apply(random));
                });
            }
        }

        final Generators generators = new Generators();
        vars.forEach(generators::variable);
        generators.bin("+", add, Add.class);
        generators.bin("-", sub, Subtract.class);
        generators.bin("*", mul, Multiply.class);
        generators.bin("/", div, Divide.class);
        generators.testRandom();
    }

    private void checkEqualsAndToString(final String full, final String mini, final ToMiniString expression, final ToMiniString copy) {
        checkToString("toString", full, expression.toString());
        if (mode > 0) {
            checkToString("toMiniString", mini, expression.toMiniString());
        }

        counter.test(() -> {
            assertTrue("Equals to this", expression.equals(expression));
            assertTrue("Equals to copy", expression.equals(copy));
            assertTrue("Equals to null", !expression.equals(null));
            assertTrue("Copy equals to null", !copy.equals(null));
        });

        final String expressionToString = Objects.requireNonNull(expression.toString());
        for (final Pair<ToMiniString, String> pair : prev) {
            counter.test(() -> {
                final ToMiniString prev = pair.first;
                final String prevToString = pair.second;
                final boolean equals = prevToString.equals(expressionToString);
                assertTrue("Equals to " + prevToString, prev.equals(expression) == equals);
                assertTrue("Equals to " + prevToString, expression.equals(prev) == equals);
                assertTrue("Inconsistent hashCode", (prev.hashCode() == expression.hashCode()) == equals);
            });
        }
    }

    private void checkToString(final String method, final String expected, final String actual) {
        counter.test(() -> assertTrue(String.format("Invalid %s\n     expected: %s\n       actual: %s", method, expected, actual), expected.equals(actual)));
    }

    protected void check(final String full, final E expected, final E actual, final V v) {
        counter.test(() -> assertEquals(String.format("f(%s)\n%s", v, full), evaluate(expected, v), evaluate(actual, v)));
    }

    private Object evaluate(final E expression, final V value) {
        try {
            return evaluate.apply(expression, value);
        } catch (final Exception e) {
            return e.getClass().getName();
        }
    }

    protected ExpressionTester<E, V, C> basic(final String full, final String mini, final E expected, final E actual) {
        basic.add(new Test(full, mini, expected, actual));
        return this;
    }

    protected ExpressionTester<E, V, C> advanced(final String full, final String mini, final E expected, final E actual) {
        advanced.add(new Test(full, mini, expected, actual));
        return this;
    }

    protected static <C, E> Pair<Function<C, E>, Function<C, E>> constant(final Function<C, E> expected, final Function<C, E> actual) {
        return Pair.of(expected, actual);
    }

    protected static <E> Op<E> variable(final String name, final E expected) {
        return Op.of(name, expected);
    }

    @FunctionalInterface
    public interface Binary<C, E> {
        E apply(BinaryOperator<C> op, E a, E b);
    }

    private final class Test {
        private final String full;
        private final String mini;
        private final E expected;
        private final E actual;

        private Test(final String full, final String mini, final E expected, final E actual) {
            this.full = full;
            this.mini = mini;
            this.expected = expected;
            this.actual = actual;
        }

        private void test() {
            counter.scope(mini, () -> {
                for (final V value : values) {
                    check(mini, expected, actual, value);
                }
                checkEqualsAndToString(full, mini, actual, actual);
                prev.add(Pair.of(actual, full));
            });
        }
    }
}
