package expression;

public class OperatorTraits {
    public final int priority;
    public final boolean commutativityAmongPriorityClass;
    public final boolean associativityAmongPriorityClass;
    public final String operatorSymbol;


    public OperatorTraits(int priority, boolean commutativityAmongPriorityClass, boolean associativityAmongPriorityClass, String operatorSymbol) {
        this.priority = priority;
        this.commutativityAmongPriorityClass = commutativityAmongPriorityClass;
        this.associativityAmongPriorityClass = associativityAmongPriorityClass;
        this.operatorSymbol = operatorSymbol;
    }
}
