package expression;

public final class Const extends AtomicParenthesesTrackingExpression {
    private final int value;

    public Const(int value) {
        this.value = value;
    }

    @Override
    public int evaluate(int x) {
        return value;
    }


    @Override
    void toStringBuilder(StringBuilder builder) {
        builder.append(value);
    }
}
