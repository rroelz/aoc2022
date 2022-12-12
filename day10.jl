mutable struct Monkey
    id
    items
    opaction
    opnr
    testnr
end

function processmonkeys(lines)
    id = match(r"^Monkey (\d+)", lines[1])
    id = parse(Int, id.captures)
    
    items = matchall(r"[/d]+", lines[2])
    opaction = lines[3]
    opnr = lines[3]
    testnr = lines[4]
    truedest = lines[5]
    falsedest = lines[6]

    println(id)
end

function loadmonkeys(file)
    monkeys = []
    monkeylns = []
    for line in eachline(file)
        if isempty(line)
            #monkey = processmonkey()
            #append!(monkeys, prosessmnky())
            #print(monkeylns)
        else
            push!(monkeylns, line)
        end
    end
end

monkeys = loadmonkeys("test/10-input.txt")