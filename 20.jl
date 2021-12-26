function num_borders(r::Robot)#функция отвечает за подсчет горизонтальных перегородок
    side = Ost
    num=0
    while !isborder(r,Nord)
        while !isborder(r,side)
            if pass_the_borders(r,side)
                num += 1
                walk_by(r,side)
            end
        end
        move!(r,Nord)
        side = inverse(side)
    end
    return num
end
function pass_the_borders(r::Robot,side::HorizonSide)#отвечает за обход перегород, когда они встречаются на пути
    while !isborder(r,Nord) 
        if isborder(r,side)
            return false
        end
        move!(r,side) 
    end
    return true
end

function walk_by(r::Robot,side::HorizonSide) #отвечает за то, что, пока перегород нет, робот двигается по прямой
    while isborder(r,Nord)
        move!(r,side)
    end
end

function inverse(side::HorizonSide)#меняет сторону своего движения на противоположную
    return HorizonSide(mod(Int(side) +2, 4))
end

num_borders(r)