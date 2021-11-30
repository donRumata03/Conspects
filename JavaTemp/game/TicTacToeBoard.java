package game;

import java.util.Arrays;
import java.util.Map;

public class TicTacToeBoard implements Board {
    private static final Map<CellState, String> CELL_TO_STRING = Map.of(
            CellState.E, ".",
            CellState.X, "X",
            CellState.O, "0"
    );

    private final CellState[][] field;
    private CellState nextTurn;

    public TicTacToeBoard() {
        field = new CellState[3][3];
        for (CellState[] row : field) {
            Arrays.fill(row, CellState.E);
        }
        nextTurn = CellState.X;
    }

    @Override
    public CellState getNextPlayerIndex() {
        return nextTurn;
    }

    @Override
    public UnmodifiableBoardView getPosition() {
        return this;
    }

    @Override
    public TwoPlayerGameState makeMove(Discrete2dMove move) {
        if (!isValid(move)) {
            return TwoPlayerGameState.LOOSE;
        }

        field[move.getPosition().row()][move.getCol()] = move.getValue();
        if (checkWin()) {
            return TwoPlayerGameState.WIN;
        }

        if (checkDraw()) {
            return TwoPlayerGameState.DRAW;
        }

        nextTurn = nextTurn == CellState.X ? CellState.O : CellState.X;
        return TwoPlayerGameState.UNKNOWN;
    }

    private boolean checkDraw() {
        int count = 0;
        for (int r = 0; r < 3; r++) {
            for (int c = 0; c < 3; c++) {
                if (field[r][c] == CellState.E) {
                    count++;
                }
            }
        }
        if (count == 0) {
            return true;
        }
        return false;
    }

    private boolean checkWin() {
        for (int r = 0; r < 3; r++) {
            int count = 0;
            for (int c = 0; c < 3; c++) {
                if (field[r][c] == nextTurn) {
                    count++;
                }
            }
            if (count == 3) {
                return true;
            }
        }
        for (int c = 0; c < 3; c++) {
            int count = 0;
            for (int r = 0; r < 3; r++) {
                if (field[r][c] == nextTurn) {
                    count++;
                }
            }
            if (count == 3) {
                return true;
            }
        }
        return field[0][0] == nextTurn && field[1][1] == nextTurn && field[2][2] == nextTurn
                || field[0][2] == nextTurn && field[1][1] == nextTurn && field[2][0] == nextTurn;
    }

    public boolean isValid(final Discrete2dMove move) {
        return 0 <= move.getRow() && move.getRow() < 3
                && 0 <= move.getCol() && move.getCol() < 3
                && field[move.getRow()][move.getCol()] == CellState.E
                && nextTurn == move.getValue();
    }

    @Override
    public CellState getCell(int row, int column) {
        return field[row][column];
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder(" 123").append(System.lineSeparator());
        for (int r = 0; r < 3; r++) {
            sb.append(r + 1);
            for (CellState cellState : field[r]) {
                sb.append(CELL_TO_STRING.get(cellState));
            }
            sb.append(System.lineSeparator());
        }
        sb.setLength(sb.length() - System.lineSeparator().length());
        return sb.toString();
    }
}
