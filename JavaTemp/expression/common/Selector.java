package expression.common;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Consumer;
import java.util.function.IntFunction;
import java.util.function.Predicate;
import java.util.stream.Collectors;

/**
 * @author Georgiy Korneev (kgeorgiy@kgeorgiy.info)
 */
public final class Selector<T extends BaseTester> {
    private final Class<?> owner;
    private final IntFunction<T> tester;
    private final List<String> modes;
    private final Consumer<T> freezer;

    private final Map<String, List<Consumer<? super T>>> variants = new HashMap<>();

    private Selector(final Class<?> owner, final IntFunction<T> tester, final Consumer<T> freezer, final String... modes) {
        this.owner = owner;
        this.tester = tester;
        this.freezer = freezer;
        this.modes = List.of(modes);
    }

    public static <T extends BaseTester> Selector<T> create(final Class<?> owner, final IntFunction<T> tester, final Consumer<T> freezer, final String... modes) {
        return new Selector<>(owner, tester, freezer, modes);
    }

    public static <T extends BaseTester> Selector<T> create(final Class<?> owner, final IntFunction<T> tester, final String... modes) {
        return create(owner, tester, null, modes);
    }

    @SafeVarargs
    public final Selector<T> variant(final String name, final Consumer<? super T>... operations) {
        variants.put(name, List.of(operations));
        return this;
    }

    @SuppressWarnings("UseOfSystemOutOrSystemErr")
    private void check(final boolean condition, final String format, final Object... args) {
        if (!condition) {
            System.err.println("ERROR: " + String.format(format, args));
            System.err.println("Usage: " + owner.getName() + " MODE VARIANT...");
            System.err.println("Modes: " + modes.stream().filter(Predicate.not(String::isEmpty)).collect(Collectors.joining(", ")));
            System.err.println("Variants: " + String.join(", ", variants.keySet()));
            System.exit(1);
        }
    }

    public void main(final String[] args) {
        check(args.length >= 2, "At least two arguments expected, found %s", args.length);
        final String mod = args[0];
        final List<String> vars = Arrays.stream(args).skip(1).collect(Collectors.toList());
        if (!vars.contains("Base")) {
            vars.add(0, "Base");
        }

        final int mode = modes.indexOf(mod);
        check(mode >= 0, "Unknown mode '%s'", mod);

        vars.forEach(var -> check(variants.containsKey(var), "Unknown variant '%s'", var));

        final T test = tester.apply(mode);
        vars.forEach(var -> variants.get(var).forEach(v -> v.accept(test)));
        if (freezer != null) {
            freezer.accept(test);
        }
        test.run(Map.of("variant", String.join("&", vars), "mode", mod));
    }
}
