function recieve(msg)
    for x in 4:length(msg)
        group = msg[x-3:x]
        if length(unique(group))==4
            return(x)
            break
        end
    end
end

function message(msg)
    for x in 14:length(msg)
        group = msg[x-13:x]
        if length(unique(group))==14
            return(x)
            break
        end
    end
end


recieve("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")
message("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")
input = readline("data/06-input.txt")
recieve(input)
message(input)