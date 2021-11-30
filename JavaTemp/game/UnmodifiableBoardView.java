package game;

public interface UnmodifiableBoardView {
    int getNextTurnIndex();
    default int getNextPlayerIndex() {
        return getNextTurnIndex() % 2;
    }

    CellState cellStateAt(Position2d position);
}
