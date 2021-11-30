package game;

import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class PrettyFormatter {
    static <T> String formatNumberedTable(T[][] table) {
        int rows = table.length;
        int cols = table[0].length;


        // Determine max number width:
        int maxWidth = Integer.max(
            Integer.toString(table.length).length(),
            Integer.toString(table[0].length).length()
        );
        StringBuilder builder = new StringBuilder();

        String formattingString = ("%" + (maxWidth + 1) + "d").repeat(table[0].length);

//        Stream<String> firstLine = IntStream.range(0, 1);

        return Arrays.stream(table).map((T[] line) -> String.format(formattingString,
            Arrays.stream(line).map(Object::toString).toArray()
        )).collect(Collectors.joining("\n"));

//        for (T[] ts : table) {
//            builder.append(String.format(formattingString,
//                Arrays.stream(ts).map(T::toString).toArray()
//            )).append("\n");
//        }
//
//        return builder.toString();
    }
}
