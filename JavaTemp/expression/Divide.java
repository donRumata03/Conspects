package expression;

public class Divide extends TwoArgumentExpression {
    public Divide(ParenthesesTrackingExpression left, ParenthesesTrackingExpression right) {
        super(left, right, new OperatorTraits(
            2,
            false,
            false,
            "/"
        ));
    }

    @Override
    int reductionOperation(int leftResult, int rightResult) {
        return leftResult / rightResult;
    }
}
