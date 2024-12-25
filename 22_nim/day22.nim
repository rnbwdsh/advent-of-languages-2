import std/[math, strutils, sequtils, tables, algorithm]

proc mix_prune(secret: int, value: int): int =
  secret xor (value mod 16_777_216)

proc process(secret: int): int =
  let s1 = mix_prune(secret, secret * 64)
  let s2 = mix_prune(s1, s1 div 32)
  mix_prune(s2, s2 * 2048)

proc simulate(buy_indicator: int, diffs: seq[seq[int]], sequences: seq[seq[int]]): int =
  # legacy code, not used except for test
  for seq_id in 0..<sequences.len:
    let diff = diffs[seq_id]
    var i = diff.find(buy_indicator)
    if i != -1:
      result += sequences[seq_id][i + 3]

proc to_base20(n: seq[int]): int =
  n[0] + n[1] * 20 + n[2] * 400 + n[3] * 8000

proc gen_sequence(secret: int): seq[int] =
  result = @[secret]
  for _ in 1..2000:
    result.add(process(result[^1]))
  result.delete(0)  # Remove the first element

proc gen_diff(seq: seq[int]): seq[int] =
  var diff = newSeq[int](seq.len - 1)
  for i in 1..<seq.len:
    diff[i - 1] = seq[i] - seq[i - 1]
  for i in 0..diff.len - 4:
    let window = @[diff[i], diff[i + 1], diff[i + 2], diff[i + 3]]
    result.add(to_base20(window))

proc buildLookupTable(diffs, seqs: seq[seq[int]]): CountTable[int] =
  result = initCountTable[int]()
  for seq_id in 0..<seqs.len:
    let diff = diffs[seq_id]
    let seq = seqs[seq_id]
    var seqTable = initCountTable[int]()
    for i in 0..<diff.len:
      let buy_indicator = diff[i]
      if buy_indicator notin seqTable:
        seqTable.inc(buy_indicator, seq[i + 3])
    result.merge(seqTable)  # Merge the current sequence's table into the global table

proc test_22(data: seq[int], level: bool): int =
  if not level:
    var sum: int = 0
    for num in data:
      let seq = gen_sequence(num)
      sum += seq[^1]  # Use the last element of the sequence
    return sum
  else:
    # build seqs + diffs table
    var seqs = newSeq[seq[int]]()
    for num in data:
      let seq = gen_sequence(num)
      seqs.add(seq.mapIt(it mod 10))
    var diffs = newSeq[seq[int]]()
    for seq in seqs:
      diffs.add(gen_diff(seq))
    for i in 0..<seqs.len:
      seqs[i].delete(0)

    return buildLookupTable(diffs, seqs).values.toSeq.max

proc test_numbers_123() =
  var curr: int = 123
  let exp = @[1_588_7950, 1_649_5136, 527_345, 704_524, 1_553_684, 12_683_156, 11_100_544, 12_249_484, 7_753_432, 5_908_254]
  for number in exp:
    curr = process(curr)
    assert curr == number

proc test_simulate() =
  var seqs = @[@[3, 0, 6, 5, 4, 4, 6, 4, 4, 2]]
  let diffs = @[gen_diff(seqs[0])]
  seqs[0].delete(0)
  assert simulate(to_base20(@[-1, -1, 0, 2]), diffs, seqs) == 6

when isMainModule:
  test_numbers_123()
  test_simulate()

  assert test_22(@[1, 10, 100, 2024], false) == 37327623
  assert test_22(@[1, 2, 3, 2024], true) == 23
  let data = readFile("22.in").strip().splitLines().mapIt(it.parseInt)
  echo "a: ", test_22(data, false)
  echo "b: ", test_22(data, true)