object Main {
  def main(args: Array[String]): Unit = {
    val src = io.Source.fromFile("15.in")
    val inp = src.mkString
    src.close()

    println(createSolver(inp, false).score())
    println(createSolver(inp, true).score())
  }

  private def createSolver(inp: String, level: Boolean): Solver = {
    val parts = inp.split("\n\n")
    if (level) {
      parts(0) = parts(0).replace("#", "##").replace("O", "[]").replace(".", "..").replace("@", "@.")
    }
    val lines = parts(0).split("\n")
    var x, y = 0;
    val a = Array.ofDim[Char](lines.length, lines(0).length)
    lines.zipWithIndex.foreach { case (line, i) =>
      line.zipWithIndex.foreach { case (c, j) =>
        a(i)(j) = c
        if (c == '@') {
          x = i; y = j
        }
      }
    }
    new Solver(x, y, 0, 0, a).simulate(parts(1))
  }
}

class Solver(var xpos: Int, var ypos: Int, var dx: Int, var dy: Int, var a: Array[Array[Char]]) {
  private val DIR = Map('^' -> (-1, 0), 'v' -> (1, 0), '<' -> (0, -1), '>' -> (0, 1))

  def can_push(px: Int, py: Int): Boolean = {
    val x = px + dx
    val y = py + dy
    if (a(x)(y) == '#') return false
    else if (a(x)(y) == '.') return true
    val modifier = if (a(x)(y) == '[') 1 else -1
    if (dx != 0 && "[]".contains(a(x)(y))) return can_push(x, y) && can_push(x, y + modifier)
    can_push(x, y)
  }

  def push(px: Int, py: Int, prev: Char): Unit = {
    val curr = a(px)(py)
    a(px)(py) = prev
    val x = px + dx
    val y = py + dy
    if (a(x)(y) == '.') {
      a(x)(y) = curr
      return
    }
    if (dx != 0 && a(x)(y) == '[') push(x, y + 1, '.')
    if (dx != 0 && a(x)(y) == ']') push(x, y - 1, '.')
    push(x, y, curr)
  }

  def simulate(moves: String): Solver = {
    for (move <- moves) {
      if (move != '\n') {
        dx = DIR(move)._1
        dy = DIR(move)._2
        if (can_push(xpos, ypos)) {
          push(xpos, ypos, '.')
          xpos += dx
          ypos += dy
        }
      }
    }
    this
  }

  def score(): Int =
    (for {
      (row, i) <- a.zipWithIndex
      (char, j) <- row.zipWithIndex
      if char == 'O' || char == '['
    } yield 100 * i + j).sum
}