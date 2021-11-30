package expression;

/**
 * We want to force implementors to be efficient :)
 */
public abstract class StringBuildableExpression implements Expression {
    abstract void toStringBuilder(StringBuilder builder);
    abstract void toMiniStringBuilder(StringBuilder builder);

    @Override
    public String toMiniString() {
        StringBuilder builder = new StringBuilder();
        this.toMiniStringBuilder(builder);
        return builder.toString();
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        this.toStringBuilder(builder);
        return builder.toString();
    }

}
