package expression.common;

import base.Asserts;
import base.ExtendedRandom;
import base.TestCounter;

import java.util.*;

/**
 * @author Georgiy Korneev (kgeorgiy@kgeorgiy.info)
 */
public abstract class BaseTester extends Asserts {
    protected final ExtendedRandom random = new ExtendedRandom();
    protected TestCounter counter = new TestCounter();
    protected final int mode;

    protected BaseTester(final int mode) {
        this.mode = mode;
        Locale.setDefault(Locale.US);
        checkAssert(getClass());
    }

    public void run(final TestCounter counter) {
        this.counter = counter;
        run(Map.of());
    }

    public void run(final Map<String, Object> properties) {
        counter.test(getClass(), properties, this::test);
    }

    protected abstract void test();

    @SafeVarargs
    protected static <T> List<T> list(final T... items) {
        return new ArrayList<>(Arrays.asList(items));
    }

    protected static void addRange(final List<Integer> values, final int d, final int c) {
        for (int i = -d; i <= d; i++) {
            values.add(c + i);
        }
    }

    public static int mode(final String[] args, final String... modes) {
        if (args.length != 1) {
            throw error("Single argument expected. Supported modes: %s", Arrays.asList(modes));
        }
        final int index = List.of(modes).indexOf(args[0]);
        if (index < 0) {
            throw error("Invalid mode '%s'. Supported moves: %s", args[0], Arrays.asList(modes));
        }
        return index;
    }

    public static int mode(final String[] args) {
        return mode(args, "easy", "hard");
    }
}
