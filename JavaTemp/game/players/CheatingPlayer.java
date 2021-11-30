package game.players;

import game.Discrete2dMove;
import game.Player;
import game.UnmodifiableBoardView;
import game.TicTacToeBoard;


public class CheatingPlayer implements Player {
    @Override
    public Discrete2dMove makeMove(UnmodifiableBoardView view) {
        final TicTacToeBoard board = (TicTacToeBoard) view;
        Discrete2dMove first = null;
        for (int r = 0; r < 3; r++) {
            for (int c = 0; c < 3; c++) {
                final Discrete2dMove move = new Discrete2dMove(r, c, view.getNextPlayerIndex());
                if (view.isValid(move)) {
                    if (first == null) {
                        first = move;
                    } else {
                        board.makeMove(move);
                    }
                }
            }
        }
        return first;
    }
}
