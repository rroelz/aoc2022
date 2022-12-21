# extract the costs from a single line
function get_costs(line)
    spliti = split(line," ")
    #ore-ore, ore-clay, ore-obsidian, clay-obsidian, ore-geode, obsidian-geode
    return parse.(Int,spliti[[7,13,19,22,28,31]])
end

#solve all the possible one combination of blueprint parameters
function solve_everything(costs)
    # ore, clay,obsidian, geode, ore_r, caly_r, obsidian_r, geode_r, time
    states = Set([[0,0,0,0,1,0,0,0]])
    #ore-ore, ore-clay, ore-obsidian, clay-obsidian, ore-geode, obsidian-geode
    for t in 1:24
        states = get_new_states(states, costs)
        println("Finished step $t at length ", length(states))
    end
    #get_max_geode(states)
    return maximum([x[4] for x in states])
end

#get all the possible states for all present states
function get_new_states(states, costs)
    new_states = Set{Vector{Int}}()
    for state in states
        c = child_states(state, costs) 
        for s in c
            push!(new_states, s)
        end
    end
    return new_states
end
# extract the costs from a single line
function get_costs(line)
    spliti = split(line," ")
    #ore-ore, ore-clay, ore-obsidian, clay-obsidian, ore-geode, obsidian-geode
    return parse.(Int,spliti[[7,13,19,22,28,31]])
end

#solve all the possible one combination of blueprint parameters
function solve_everything(costs)
    # ore, clay,obsidian, geode, ore_r, caly_r, obsidian_r, geode_r, time
    states = Set([[0,0,0,0,1,0,0,0]])
    #ore-ore, ore-clay, ore-obsidian, clay-obsidian, ore-geode, obsidian-geode
    for t in 1:24
        states = get_new_states(states, costs)
        println("Finished step $t at length ", length(states))
    end
    #get_max_geode(states)
    return maximum([x[4] for x in states])
end

#get all the possible states for all present states
function get_new_states(states, costs)
    new_states = Set{Vector{Int}}()
    for state in states
        c = child_states(state, costs) 
        for s in c
            push!(new_states, s)
        end
    end
    return new_states
end

# get all the possible child states for a single state
function child_states(state::Vector{Int}, costs)
    new_resource = new_resources(state)
    children = [new_resource]
    if (state[1] >= costs[1]) && (state[5] < maximum(costs[[1,2,3,5]])) #can I build this ore robot and am I not producing enough ore for every robot already
        push!(children, new_resource+[-costs[1], 0, 0, 0, 1, 0, 0, 0])
    end
    if state[1] >= costs[2] && (state[5] < costs[6]) #can I build this clay bot and don't I have enough bots for clay already
        push!(children, new_resource+[-costs[2], 0, 0, 0, 0, 1, 0, 0])
    end
    if state[1] >= costs[3] && state[2] >= costs[4] #can I build this obsidian bot
        push!(children, new_resource+[-costs[3], -costs[4], 0, 0, 0, 0, 1, 0])
    end
    if state[1] >= costs[5] && state[3] >= costs[6] #can I build this geode bot
        push!(children, new_resource+[-costs[5], 0, -costs[6], 0, 0, 0, 0, 1])
    end
    return children #returning all possible states
end

#get the new resources from our current state
function new_resources(state)
    return state.+[state[5:end]..., 0,0,0,0]
end
# get all the possible child states for a single state
function child_states(state::Vector{Int}, costs)
    new_resource = new_resources(state)
    children = [new_resource]
    if (state[1] >= costs[1]) && (state[5] < maximum(costs[[1,2,3,5]])) #can I build this ore robot and am I not producing enough ore for every robot already
        push!(children, new_resource+[-costs[1], 0, 0, 0, 1, 0, 0, 0])
    end
    if state[1] >= costs[2] && (state[5] < costs[6]) #can I build this clay bot and don't I have enough bots for clay already
        push!(children, new_resource+[-costs[2], 0, 0, 0, 0, 1, 0, 0])
    end
    if state[1] >= costs[3] && state[2] >= costs[4] #can I build this obsidian bot
        push!(children, new_resource+[-costs[3], -costs[4], 0, 0, 0, 0, 1, 0])
    end
    if state[1] >= costs[5] && state[3] >= costs[6] #can I build this geode bot
        push!(children, new_resource+[-costs[5], 0, -costs[6], 0, 0, 0, 0, 1])
    end
    return children #returning all possible states
end

#get the new resources from our current state
function new_resources(state)
    return state.+[state[5:end]..., 0,0,0,0]
end

input = readlines("data/19-input.txt")
costs = get_costs.(input)

bp1 =  [4,2,3,14,2,7]
bp2 = [2,3,3,8,3,12]

test_state = [4,0,0,0,4,0,0,0]

child_states(test_state, bp1)

solve_everything(bp1)

#solving for part 1
vals = zeros(length(costs))
for i in eachindex(costs)
    vals[i] = i*solve_everything(costs[i])
end
print("The combined quality value of the blueprints is ",sum(vals))
