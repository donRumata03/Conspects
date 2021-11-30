package game;

public class UnmodifiableMNKBoardView implements UnmodifiableBoardView {
    private final CellState[][] field;
    private final int nextTurnIndex;

    public UnmodifiableMNKBoardView(CellState[][] field, int nextTurnIndex) {
        this.field = field;
        this.nextTurnIndex = nextTurnIndex;
    }


    @Override
    public int getNextTurnIndex() {
        return nextTurnIndex;
    }

    @Override
    public CellState cellStateAt(Position2d position) {
        // Specific enum type isn't a reference one => there are no security issues here
        return field[position.row][position.col];
    }
}
