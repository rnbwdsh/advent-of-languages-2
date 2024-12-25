import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

public class Main {
    Map<Integer, List<Integer>> cmp = new HashMap<>();
    List<List<Integer>> lines = new ArrayList<>();

    public Main() throws FileNotFoundException {
        Scanner sc = new Scanner(new File("05.in"));
        while(sc.hasNext()) {
            String[] lineSplit;
            String line = sc.nextLine();
            if(line.isEmpty()) {
                continue;
            }
            else if (line.contains("|")) {
                lineSplit = line.split("\\|");
                int a = Integer.parseInt(lineSplit[0]);
                int b = Integer.parseInt(lineSplit[1]);
                if (!cmp.containsKey(a)) {
                    List<Integer> list = new ArrayList<>();
                    list.add(b);
                    cmp.put(a, list);
                }
                cmp.get(a).add(b);
            } else if (line.contains(",")) {
                lineSplit = line.split(",");
                lines.add(Arrays.stream(lineSplit).map(Integer::parseInt).toList());
            }
        }
        sc.close();
    }

    public void solve(boolean levelB) {
        int total = 0;
        for(List<Integer> list : lines) {
            ArrayList<Integer> cpy = new ArrayList<>(list);
            cpy.sort(new Comparator<Integer>() {
                @Override
                public int compare(Integer o1, Integer o2) {
                    if(cmp.containsKey(o1) && cmp.get(o1).contains(o2)) {
                        return -1;
                    } else if(cmp.containsKey(o2) && cmp.get(o2).contains(o1)) {
                        return 1;
                    }
                    return 0;
                }
            });
            if(levelB && !list.equals(cpy)) {
                total += cpy.get(cpy.size() / 2);
            }
            else if(!levelB && list.equals(cpy)) {
                total += cpy.get(cpy.size() / 2);
            }
        }
        System.out.println(total);
    }

    public static void main(String[] args) throws FileNotFoundException {
        Main m = new Main();
        m.solve(false);
        m.solve(true);
    }
}