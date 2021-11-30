package expression;

public final class Variable extends AtomicParenthesesTrackingExpression {
    private final String varName;

    public Variable(String varName) {
        this.varName = varName;
    }

    @Override
    public int evaluate(int x) {
        return x;
    }

    @Override
    void toStringBuilder(StringBuilder builder) {
        builder.append(varName);
    }
}
