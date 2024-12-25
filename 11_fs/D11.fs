open System

let setOrAdd (map: Map<int64, int64>) key value =
    match map.TryFind key with
    | Some existingCount -> map.Add(key, existingCount + value)
    | None -> map.Add(key, value)

let replaceInts (data: Map<int64, int64>) : Map<int64, int64> =
    let mutable result = Map.empty

    for kvp in data do
        if kvp.Key = 0L then
            result <- setOrAdd result 1L kvp.Value
        elif (string kvp.Key).Length % 2 = 0 then
            let half = (string kvp.Key).Length / 2
            result <- setOrAdd result (int64 ((string kvp.Key).Substring(0, half))) kvp.Value
            result <- setOrAdd result (int64 ((string kvp.Key).Substring(half))) kvp.Value
        else
            result <- setOrAdd result (kvp.Key * 2024L) kvp.Value

    result

// Test function
let test11 (data: int64 list) (level: bool) =
    let mutable data =
        data
        |> List.countBy id
        |> List.map (fun (key, count) -> (key, int64 count))
        |> Map.ofList

    for _ in 1..(if level then 75 else 25) do
        data <- replaceInts data

    data |> Map.toList |> List.sumBy snd

// Example usage
let exampleData = [ 125L; 17L; ]

printfn "Result (25 iterations): %d" (test11 exampleData false)
printfn "Result (75 iterations): %d" (test11 exampleData true)
