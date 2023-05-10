function addVectors(u, v)
    return {x = u.x + v.x, y = u.y + v.y}
end

function multiplyVector(c, v)
    return {x = c * v.x, y = c * v.y}
end


function normsq(u)
    return u.x * u.x + u.y * u.y
end

function norm(u)
    return math.sqrt(normsq(u))
end
