import sqlite3

import numpy as np
import pytest


@pytest.mark.data(("""............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............"""), 14, 34)
def test_08(data: np.array, level):
    # setup db
    db = sqlite3.connect(":memory:")
    cursor = db.cursor()
    cursor.execute("CREATE TABLE lookup (x INT, y INT, val TEXT)")

    # Insert data into lookup table
    mask = np.logical_or(np.char.isalpha(data), np.char.isdigit(data))
    data_to_insert = [(int(i), int(j), data[j, i]) for (j, i) in np.argwhere(mask)]
    cursor.executemany("INSERT INTO lookup VALUES (?, ?, ?)", data_to_insert)

    # Query to find antinodes
    gen100 = 'WITH RECURSIVE s(n) AS (SELECT 0 UNION ALL SELECT n + 1 FROM s WHERE n + 1 < 100)' if level else ''
    mul = 'n' if level else 2
    num_tab = ', s' if level else ''

    r = cursor.execute(f"""SELECT COUNT() FROM ({gen100}
            SELECT DISTINCT (l1.x + (l2.x - l1.x) * {mul}) as a, (l1.y + (l2.y - l1.y) * {mul}) as b
            FROM lookup l1, lookup l2{num_tab}
            WHERE l1.val = l2.val AND l1.ROWID != l2.ROWID
            AND a BETWEEN 0 AND ?-1 AND b BETWEEN 0 AND ?-1)""", data.shape).fetchone()[0]
    print(r)
    return r