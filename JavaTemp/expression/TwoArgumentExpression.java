package expression;

import java.util.Optional;

public abstract class TwoArgumentExpression extends ParenthesesTrackingExpression {
    abstract int reductionOperation(int leftResult, int rightResult);

    ////////////////////////////////////////////////////////////////////////////////////
    private final ParenthesesTrackingExpression left;
    private final ParenthesesTrackingExpression right;

    private final OperatorTraits operatorInfo;
    private Optional<ParenthesesElisionTrackingInfo> cachedPriorityInfo = Optional.empty();

    public TwoArgumentExpression(Expression left, Expression right, OperatorTraits operatorInfo) {
        this(new SafestParenthesesTrackingExpressionWrapper(left), new SafestParenthesesTrackingExpressionWrapper(right), operatorInfo);
    }


    public TwoArgumentExpression(ParenthesesTrackingExpression left, ParenthesesTrackingExpression right, OperatorTraits operatorInfo) {
        this.left = left;
        this.right = right;
        this.operatorInfo = operatorInfo;
    }

    @Override
    public int evaluate(int x) {
        return this.reductionOperation(left.evaluate(x), right.evaluate(x));
    }

    /////////////////////////////////////////////////////////



    @Override
    void resetCachedPriorityInfo() {
        cachedPriorityInfo = Optional.empty();
    }


    /**
     *  Make decision if parentheses are necessary for children or not
     *  (It's easy to prove that greedy algorithm makes sense)
     *  — Decisions are made separately for left and right
     *  — If priority of smth is higher => don't have PS
     *  — If priority of smth is lower => have PS
     *  — If priority of smth is the same, for left don't have PS, but for right it becomes more interesting…
     *  — So, for right with same priorities it is removed if: ……………
     */
    @Override
    ParenthesesElisionTrackingInfo getCachedPriorityInfo() {
        if (cachedPriorityInfo.isPresent()) {
            return cachedPriorityInfo.get();
        }

        ParenthesesElisionTrackingInfo leftInfo = left.getCachedPriorityInfo();
        ParenthesesElisionTrackingInfo rightInfo = right.getCachedPriorityInfo();

        cachedPriorityInfo = Optional.of(ParenthesesElisionTrackingInfo.neutralElement());
        ParenthesesElisionTrackingInfo cachingInfo = cachedPriorityInfo.get();


        cachingInfo.lowestPriorityAfterParentheses = this.operatorInfo.priority;
        cachingInfo.containsNonAssociativeLowestPriorityAfterParentheses = !this.operatorInfo.associativityAmongPriorityClass;

        if (leftInfo.lowestPriorityAfterParentheses < this.operatorInfo.priority) {
            leftInfo.performParenthesesApplicationDecision(true);
        } else {
            cachingInfo.includeInParenthesesLessGroup(leftInfo);
        }

        if (rightInfo.lowestPriorityAfterParentheses < this.operatorInfo.priority
            || (
                rightInfo.lowestPriorityAfterParentheses == this.operatorInfo.priority
                && this.operatorInfo.commutativityAmongPriorityClass
                && !rightInfo.containsNonAssociativeLowestPriorityAfterParentheses
            )
        ) {
            rightInfo.performParenthesesApplicationDecision(true);
        } else {
            cachingInfo.includeInParenthesesLessGroup(rightInfo);
        }

        return cachingInfo;
    }

    /////////////////////////////////////////////////////////

    private void toParenthesesLessStringBuilder(StringBuilder builder) {
        left.toStringBuilder(builder);

        builder
            .append(" ")
            .append(operatorInfo.operatorSymbol)
            .append(" ");

        right.toStringBuilder(builder);
    }

    @Override
    public void toMiniStringBuilder(StringBuilder builder) {
        ParenthesesElisionTrackingInfo thisInfo = getCachedPriorityInfo();

        if (thisInfo.parenthesesApplied) {
            builder.append("(");
        }

        toParenthesesLessStringBuilder(builder);

        if (thisInfo.parenthesesApplied) {
            builder.append(")");
        }
    }

    @Override
    public void toStringBuilder(StringBuilder builder) {
        builder.append("(");
        toParenthesesLessStringBuilder(builder);
        builder.append(")");
    }
}
