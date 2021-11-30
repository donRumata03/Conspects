package game;

public interface Player {
    Discrete2dMove makeMove(UnmodifiableBoardView view);
}
