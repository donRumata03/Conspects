package expression;

public abstract class AtomicParenthesesTrackingExpression extends ParenthesesTrackingExpression {
    @Override
    ParenthesesElisionTrackingInfo getCachedPriorityInfo() {
        return ParenthesesElisionTrackingInfo.generateAtomicExpressionInfo();
    }

    @Override
    void resetCachedPriorityInfo() {}

    @Override
    void toMiniStringBuilder(StringBuilder builder) {
        toStringBuilder(builder);
    }
}
