package expression;

public class Add extends TwoArgumentExpression {
    public Add(ParenthesesTrackingExpression left, ParenthesesTrackingExpression right) {
        super(left, right, new OperatorTraits(
            1,
            true,
            true,
            "+"
        ));
    }

    @Override
    int reductionOperation(int leftResult, int rightResult) {
        return leftResult + rightResult;
    }
}
