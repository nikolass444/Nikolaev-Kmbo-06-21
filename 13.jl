#идём в угол, проставляем маркеры, возвращемся по этим маркерам в исходную точку и так посторяем со всеми 4 углами
#в конце ставим маркер в начальной позиции
function cross!(r::Robot)
    for side in((Nord,Ost),(West,Sud),(Nord,West),(Sud,Ost))
        markers!(r,side)
        move_marker!(r,side)
    end
putmarker!(r)
end
#идём наискосок до стенки и проставляем маркеры
function markers!(r::Robot,side::NTuple{2,HorizonSide})
    while isborder(r,side[1])==false && isborder(r,side[2])==false
        move!(r,side[1])
        move!(r,side[2])
        putmarker!(r)
    end
end
#возвращаемся (наискосок) по проставленным маркерам в начальную точку
function move_marker!(r::Robot,side::NTuple{2,HorizonSide})
    while ismarker(r)==true
        move!(r,inverse(side[1]))
        move!(r,inverse(side[2]))
    end
end
#заменям направление на 180 градусов
function inverse(side::HorizonSide) 
    side=HorizonSide(mod(Int(side)+2,4)) 
end