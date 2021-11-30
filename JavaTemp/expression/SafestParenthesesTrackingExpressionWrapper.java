package expression;

public class SafestParenthesesTrackingExpressionWrapper extends ParenthesesTrackingExpression {

    private final Expression inner;

    SafestParenthesesTrackingExpressionWrapper(Expression wrapped) {
        this.inner = wrapped;
    }


    @Override
    ParenthesesElisionTrackingInfo getCachedPriorityInfo() {
        return ParenthesesElisionTrackingInfo.generateSafestExpressionInfo();
    }

    @Override
    void resetCachedPriorityInfo() {}

    @Override
    void toStringBuilder(StringBuilder builder) {
        builder.append(inner.toString());
    }

    @Override
    void toMiniStringBuilder(StringBuilder builder) {
        builder.append(inner.toMiniString());
    }

    @Override
    public int evaluate(int x) {
        return inner.evaluate(x);
    }
}
