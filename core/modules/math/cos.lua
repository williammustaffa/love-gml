function math.fact(b)
    if(b==1)or(b==0) then
        return 1
    end
    local e=1
    for c=b,1,-1 do
        e=e*c
    end
    return e
end

function math.pow(b, p)
    local e=b
    if(p==0) then
        return 1
    end
    if(p<0) then
        p=p*(-1)
    end
    for c=p,2,-1 do
        e=e*b
    end
    return e
end
function math.cos(b, p)
    local e=1 
    b = math.correctRadians(b) 
    p=p or 10
    for i=1,p do
        e=e+(math.pow(-1,i)*math.pow(b,2*i)/math.fact(2*i))
    end
    return e
end

function math.correctRadians(value)
    while value > math.pi*2 do
        value = value - math.pi * 2
    end           
    while value < -math.pi*2 do
        value = value + math.pi * 2
    end 
    return value
end 