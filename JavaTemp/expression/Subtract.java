package expression;

public final class Subtract extends TwoArgumentExpression {
    public Subtract(ParenthesesTrackingExpression left, ParenthesesTrackingExpression right) {
        super(left, right, new OperatorTraits(
            1,
            false,
            true,
            "-"
        ));
    }

    @Override
    int reductionOperation(int leftResult, int rightResult) {
        return leftResult - rightResult;
    }
}
