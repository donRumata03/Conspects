package expression.common;

import base.ExtendedRandom;
import base.TestCounter;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.function.IntFunction;
import java.util.function.Supplier;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

/**
 * @author Georgiy Korneev (kgeorgiy@kgeorgiy.info)
 */
public class Generator<C> {
    private final ExtendedRandom random;
    private final Supplier<C> constant;

    private final List<Node<C>> nullary = new ArrayList<>();
    private final List<Op<Integer>> ops = new ArrayList<>();

    public Generator(final ExtendedRandom random, final Supplier<C> constant) {
        this.random = random;
        this.constant = constant;
    }

    public void add(final String name, final int arity) {
        if (arity == 0) {
            nullary.add(Node.op(name));
        } else {
            ops.add(Op.of(Node.id(name, arity), arity));
        }
    }

    private Node<C> generate(final boolean nullary, final IntFunction<Stream<Node<C>>> children) {
        if (nullary || ops.isEmpty()) {
            return random.nextBoolean() ? random.randomItem(this.nullary) : Node.constant(constant.get());
        } else {
            final Op<Integer> op = random.randomItem(ops);
            return Node.op(op.name, children.apply(op.value).limit(op.value).collect(Collectors.toUnmodifiableList()));
        }
    }

    private Node<C> generateFullDepth(final int depth) {
        return generate(depth == 0, arity -> Stream.generate(() -> generateFullDepth(depth - 1)));
    }

    private Node<C> generatePartialDepth(final int depth) {
        return generate(depth == 0, arity -> Stream.generate(() -> generatePartialDepth(random.nextInt(depth))));
    }

    private Node<C> generateSize(final int size) {
        return generate(size == 0, arity -> {
            final int[] children = new int[arity];
            final int base = (size - 1) / arity;
            final int extra = (size - 1) % arity;
            for (int i = 0; i < extra; i++) {
                children[random.nextInt(arity)]++;
            }
            return IntStream.of(children).mapToObj(c -> generateSize(base + c));
        });
    }

    public void testRandom(final int denominator, final TestCounter counter, final Consumer<Node<C>> consumer) {
        final int d = Math.max(TestCounter.DENOMINATOR, denominator);
        testRandom(counter, consumer, 1, 1000 / d / d, 1, this::generateSize);
        testRandom(counter, consumer, 2, 12, 100 / d / d, this::generateFullDepth);
        testRandom(counter, consumer, 3, 777 / d, 1, this::generatePartialDepth);
    }

    private static <C> void testRandom(
            final TestCounter counter,
            final Consumer<Node<C>> consumer,
            final int seq,
            final int levels,
            final int perLevel,
            final Function<Integer, Node<C>> generator
    ) {
        counter.scope("Random tests #" + seq, () -> {
            final int total = levels * perLevel;
            int generated = 0;
            for (int level = 0; level < levels; level++) {
                for (int j = 0; j < perLevel; j++) {
                    if (generated % 100 == 0) {
                        progress(counter, total, generated);
                    }
                    generated++;

                    consumer.accept(generator.apply(level));
                }
            }
            progress(counter, generated, total);
        });
    }

    private static void progress(final TestCounter counter, final int total, final int generated) {
        counter.format("Completed %4d out of %d%n", generated, total);
    }
}
