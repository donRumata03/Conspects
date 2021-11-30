package expression;

import expression.common.BaseTester;
import expression.common.Selector;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;
import java.util.function.IntFunction;

/**
 * @author Georgiy Korneev (kgeorgiy@kgeorgiy.info)
 */
public final class ExpressionTest extends BaseTester {
    private final List<IntFunction<? extends ExpressionTester<?, ?, ?>>> testers = new ArrayList<>();

    private ExpressionTest(final int mode) {
        super(mode);
    }

    @Override
    protected void test() {
        testers.forEach(tester -> tester.apply(mode).run(counter));
    }

    private static Consumer<? super ExpressionTest> v(final IntFunction<? extends ExpressionTester<?, ?, ?>> tester) {
        return t -> t.testers.add(tester);
    }

    public static void main(final String... args) {
        Selector.create(ExpressionTest.class, ExpressionTest::new, "easy", "hard")
                .variant("Base", v(Expression::tester))
                .main(args);
    }
}
