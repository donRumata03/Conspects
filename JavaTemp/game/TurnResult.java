package game;

enum TurnResult {
    GAME_NOT_FINISHED,
    WIN,
    LOOSE,
    DRAW;

    public TwoPlayerGameState toAbsoluteResult(int playerIndex) {
        return switch (this) {
            case GAME_NOT_FINISHED -> TwoPlayerGameState.GAME_NOT_FINISHED;
            case WIN -> playerIndex == 0 ? TwoPlayerGameState.FIRST_WINS : TwoPlayerGameState.SECOND_WINS;
            case LOOSE -> playerIndex == 0 ? TwoPlayerGameState.SECOND_WINS : TwoPlayerGameState.FIRST_WINS;
            case DRAW -> TwoPlayerGameState.DRAW;
        };
    }

}