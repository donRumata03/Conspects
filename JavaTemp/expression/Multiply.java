package expression;

public class Multiply extends TwoArgumentExpression  {
    public Multiply(ParenthesesTrackingExpression left, ParenthesesTrackingExpression right) {
        super(left, right, new OperatorTraits(
            2,
            true,
            true,
            "*"
        ));
    }

    @Override
    int reductionOperation(int leftResult, int rightResult) {
        return leftResult * rightResult;
    }
}
