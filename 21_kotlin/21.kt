import kotlin.io.path.Path
import kotlin.io.path.readLines
import kotlin.math.max

open class Keypad(var pos: Pair<Int, Int> = Pair(3, 2), var soFar: String = "") {
    protected open val layout: List<String> = listOf("789", "456", "123", " 0A")
    open fun copy() = Keypad(pos, soFar)

    fun buttonAt(): Char = layout.getOrElse(pos.first) { " " }.getOrElse(pos.second) { ' ' }

    fun solve(press: String): Set<String> {
        val directions = mapOf('^' to Pair(-1, 0), 'v' to Pair(1, 0), '<' to Pair(0, -1), '>' to Pair(0, 1))
        if (press == "A") {
            return setOf("A")
        }
        var current = listOf(this)
        var pressRemaining = press
        while (pressRemaining.isNotEmpty()) {
            var success = 0
            val nextCurrent = current.flatMap { c ->
                directions.mapNotNull { (k, v) ->
                    val cc = c.copy().moveKeypad(k, v) ?: return@mapNotNull null
                    if (cc.buttonAt() == pressRemaining[0]) {
                        val count = pressRemaining.takeWhile { it == pressRemaining[0] }.length
                        cc.soFar += "A".repeat(count)
                        success = max(success, count)
                    }
                    cc
                }
            }.toMutableList()
            if (success > 0) {
                nextCurrent.removeIf { !it.soFar.endsWith("A") }
                pressRemaining = pressRemaining.substring(success)
            }
            current = nextCurrent
        }
        return current.map { it.soFar }.toSet()
    }

    fun moveKeypad(letter: Char, direction: Pair<Int, Int>): Keypad? {
        pos = Pair(pos.first + direction.first, pos.second + direction.second)
        soFar += letter
        return if (buttonAt() != ' ') this else null // Only check for ' '
    }
}

class Dpad(pos: Pair<Int, Int> = Pair(0, 2), soFar: String = "") : Keypad(pos, soFar) {
    override val layout: List<String> = listOf(" ^A", "<v>")
    override fun copy() = Dpad(pos, soFar)

    companion object {
        private val cache: MutableMap<String, Set<String>> = mutableMapOf()
        fun dpad(s: String): Set<String> = cache.getOrPut(s) { Dpad().solve(s) }
    }
}

object TreeReplaceCache {
    private val cache: MutableMap<String, Long> = mutableMapOf()

    fun treeReplaceResolve(s: String, depth: Int = 2): Long =
        if (depth == 0) s.length.toLong()
        else cache.getOrPut("$s-$depth") {
            s.split("A").map { it + "A" }.dropLast(1).sumOf { chunk ->
                Dpad.dpad(chunk).minOf { treeReplaceResolve(it, depth - 1) }
            }
        }
}

fun main() {
    listOf(2, 25).forEach { repeat ->
        val result = Path("21.in").readLines().sumOf { line ->
            val number = line.substring(0, 3).toLong()
            val minSteps = Keypad().solve(line).minOf { TreeReplaceCache.treeReplaceResolve(it, repeat) }
            number * minSteps
        }
        println(result)
    }
}