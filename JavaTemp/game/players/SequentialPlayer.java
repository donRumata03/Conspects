package game.players;

import game.Discrete2dMove;
import game.Player;
import game.UnmodifiableBoardView;

public class SequentialPlayer implements Player {
    @Override
    public Discrete2dMove makeMove(UnmodifiableBoardView view) {
        for (int r = 0; r < 3; r++) {
            for (int c = 0; c < 3; c++) {
                final Discrete2dMove move = new Discrete2dMove(r, c, view.getNextPlayerIndex());
                if (view.isValid(move)) {
                    return move;
                }
            }
        }
        throw new AssertionError("No valid moves");
    }
}
