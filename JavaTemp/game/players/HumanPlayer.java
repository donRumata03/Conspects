package game.players;

import game.Discrete2dMove;
import game.Player;
import game.UnmodifiableBoardView;
import java.util.Scanner;

public class HumanPlayer implements Player {
    private final Scanner in;

    public HumanPlayer(Scanner in) {
        this.in = in;
    }

    @Override
    public Discrete2dMove makeMove(UnmodifiableBoardView view) {
        System.out.println();
        System.out.println("Current position");
        System.out.println(view);
        System.out.println("Enter you move for " + view.getNextPlayerIndex());
        return new Discrete2dMove(in.nextInt() - 1, in.nextInt() - 1, view.getNextPlayerIndex());
    }
}
