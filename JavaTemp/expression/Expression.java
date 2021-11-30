package expression;

import base.Asserts;
import base.ExtendedRandom;

import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 * One-argument arithmetic expression over integers.
 *
 * @author Georgiy Korneev (kgeorgiy@kgeorgiy.info)
 */
@FunctionalInterface
@SuppressWarnings("ClassReferencesSubclass")
public interface Expression extends ToMiniString {
    int evaluate(int x);

    private static Const c(final Integer c) {
        return new Const(c);
    }

    static ExpressionTester<?, ?, ?> tester(final int mode) {
        final Variable vx = new Variable("x");
        final Const c1 = c(1);
        final Const c2 = c(2);
        final Subtract example = new Subtract(
                new Multiply(new Const(2), new Variable("x")),
                new Const(3)
        );
        Asserts.assertEquals("Example at 5", 7, example.evaluate(5));
        Asserts.assertEquals("Example toString", "((2 * x) - 3)", example.toString());
        Asserts.assertTrue("Example equals 1", example.equals(new Subtract(
                new Multiply(new Const(2), new Variable("x")),
                new Const(3)
        )));
        Asserts.assertTrue("Example equals 2", !example.equals(new Subtract(
                new Const(3),
                new Multiply(new Const(2), new Variable("x"))
        )));

        //noinspection Convert2MethodRef
        return new ExpressionTester<Expression, Integer, Integer>(
                mode,
                Expression::evaluate,
                IntStream.rangeClosed(0, 10).boxed().collect(Collectors.toList()),
                ExtendedRandom::nextInt,
                ExtendedRandom::nextInt,
                ExpressionTester.constant(c -> x -> c, Expression::c),
                (op, a, b) -> x -> op.apply(a.evaluate(x), b.evaluate(x)),
                (a, b) -> a + b, (a, b) -> a - b, (a, b) -> a * b, (a, b) -> a / b,
                ExpressionTester.variable("x", x -> x)
        )
                .basic("10", "10", x -> 10, c(10))
                .basic("x", "x", x -> x, vx)
                .basic("(x + 2)", "x + 2", x -> x + 2, new Add(vx, c(2)))
                .basic("(2 - x)", "2 - x", x -> 2 - x, new Subtract(c(2), vx))
                .basic("(3 * x)", "3 * x", x -> 3*x, new Multiply(c(3), vx))
                .basic("(x + x)", "x + x", x -> x + x, new Add(vx, vx))
                .basic("(x / -2)", "x / -2", x -> -x / 2, new Divide(vx, c(-2)))
                .basic("(x + x)", "x + x", x -> x + x, new Add(vx, vx))
                .basic("(2 + x)", "2 + x", x -> 2 + x, new Add(c(2), vx))
                .basic("(x + 2)", "x + 2", x -> x + 2, new Add(vx, c(2)))
                .basic("((1 + 2) + 3)", "1 + 2 + 3", x -> 6, new Add(new Add(c(1), c(2)), c(3)))
                .basic("(1 + (2 + 3))", "1 + 2 + 3", x -> 6, new Add(c(1), new Add(c(2), c(3))))
                .basic("((1 - 2) - 3)", "1 - 2 - 3", x -> -4, new Subtract(new Subtract(c(1), c(2)), c(3)))
                .basic("(1 - (2 - 3))", "1 - (2 - 3)", x -> 2, new Subtract(c(1), new Subtract(c(2), c(3))))
                .basic("((1 * 2) * 3)", "1 * 2 * 3", x -> 6, new Multiply(new Multiply(c(1), c(2)), c(3)))
                .basic("(1 * (2 * 3))", "1 * 2 * 3", x -> 6, new Multiply(c(1), new Multiply(c(2), c(3))))
                .basic("((10 / 2) / 3)", "10 / 2 / 3", x -> 10 / 2 / 3, new Divide(new Divide(c(10), c(2)), c(3)))
                .basic("(10 / (3 / 2))", "10 / (3 / 2)", x -> 10 / (3 / 2), new Divide(c(10), new Divide(c(3), c(2))))
                .basic("(10 * (3 / 2))", "10 * (3 / 2)", x -> 10 * (3 / 2), new Multiply(c(10), new Divide(c(3), c(2))))
                .basic("(10 + (3 - 2))", "10 + 3 - 2", x -> 10 + (3 - 2), new Add(c(10), new Subtract(c(3), c(2))))
                .basic("((x * x) + ((x - 1) / 10))", "x * x + (x - 1) / 10", x -> x * x + (x - 1) / 10, new Add(
                        new Multiply(vx, vx),
                        new Divide(new Subtract(vx, c(1)), c(10))
                ))
                .basic("(x * -1000000000)", "x * -1000000000", x -> x * -1_000_000_000, new Multiply(vx, c(-1_000_000_000)))
                .basic("(10 / x)", "10 / x", x -> 10 / x, new Divide(c(10), vx))
                //noinspection PointlessArithmeticExpression
                .basic("(x / x)", "x / x", x -> x / x, new Divide(vx, vx))

                .advanced("(2 + 1)", "2 + 1", x -> 2 + 1, new Add(c2, c1))
                .advanced("(x - 1)", "x - 1", x -> x - 1, new Subtract(vx, c1))
                .advanced("(1 * 2)", "1 * 2", x -> 1 * 2, new Multiply(c1, c2))
                .advanced("(x / 1)", "x / 1", x -> x / 1, new Divide(vx, c1))
                .advanced("(1 + (2 + 1))", "1 + 2 + 1", x -> 1 + 2 + 1, new Add(c1, new Add(c2, c1)))
                .advanced("(x - (x - 1))", "x - (x - 1)", x -> x - (x - 1), new Subtract(vx, new Subtract(vx, c1)))
                .advanced("(2 * (x / 1))", "2 * (x / 1)", x -> 2 * (x / 1), new Multiply(c2, new Divide(vx, c1)))
                .advanced("(2 / (x - 1))", "2 / (x - 1)", x -> 2 / (x - 1), new Divide(c2, new Subtract(vx, c1)))
                .advanced("((1 * 2) + x)", "1 * 2 + x", x -> 1 * 2 + x, new Add(new Multiply(c1, c2), vx))
                .advanced("((x - 1) - 2)", "x - 1 - 2", x -> x - 1 - 2, new Subtract(new Subtract(vx, c1), c2))
                .advanced("((x / 1) * 2)", "x / 1 * 2", x -> x / 1 * 2, new Multiply(new Divide(vx, c1), c2))
                .advanced("((2 + 1) / 1)", "(2 + 1) / 1", x -> (2 + 1) / 1, new Divide(new Add(c2, c1), c1))
                .advanced("(1 + (1 + (2 + 1)))", "1 + 1 + 2 + 1", x -> 1 + 1 + 2 + 1, new Add(c1, new Add(c1, new Add(c2, c1))))
                .advanced("(x - ((1 * 2) + x))", "x - (1 * 2 + x)", x -> x - (1 * 2 + x), new Subtract(vx, new Add(new Multiply(c1, c2), vx)))
                .advanced("(x * (2 / (x - 1)))", "x * (2 / (x - 1))", x -> x * (2 / (x - 1)), new Multiply(vx, new Divide(c2, new Subtract(vx, c1))))
                .advanced("(x / (1 + (2 + 1)))", "x / (1 + 2 + 1)", x -> x / (1 + 2 + 1), new Divide(vx, new Add(c1, new Add(c2, c1))))
                .advanced("((1 * 2) + (2 + 1))", "1 * 2 + 2 + 1", x -> 1 * 2 + 2 + 1, new Add(new Multiply(c1, c2), new Add(c2, c1)))
                .advanced("((2 + 1) - (2 + 1))", "2 + 1 - (2 + 1)", x -> 2 + 1 - (2 + 1), new Subtract(new Add(c2, c1), new Add(c2, c1)))
                .advanced("((x - 1) * (x / 1))", "(x - 1) * (x / 1)", x -> (x - 1) * (x / 1), new Multiply(new Subtract(vx, c1), new Divide(vx, c1)))
                .advanced("((x - 1) / (1 * 2))", "(x - 1) / (1 * 2)", x -> (x - 1) / (1 * 2), new Divide(new Subtract(vx, c1), new Multiply(c1, c2)))
                .advanced("(((x - 1) - 2) + x)", "x - 1 - 2 + x", x -> x - 1 - 2 + x, new Add(new Subtract(new Subtract(vx, c1), c2), vx))
                .advanced("(((1 * 2) + x) - 1)", "1 * 2 + x - 1", x -> 1 * 2 + x - 1, new Subtract(new Add(new Multiply(c1, c2), vx), c1))
                .advanced("(((2 + 1) / 1) * x)", "(2 + 1) / 1 * x", x -> (2 + 1) / 1 * x, new Multiply(new Divide(new Add(c2, c1), c1), vx))
                .advanced("((2 / (x - 1)) / 2)", "2 / (x - 1) / 2", x -> 2 / (x - 1) / 2, new Divide(new Divide(c2, new Subtract(vx, c1)), c2));
    }
}
