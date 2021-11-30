package game;

import java.util.Map;

public enum CellState {
    E, X, O;

    static Map<CellState, String> cellStateToString = Map.of(
        E, ".",
        X, "×",
        O, "⭕"
    );

    @Override
    public String toString() {
        return cellStateToString.get(this);
    }
}
