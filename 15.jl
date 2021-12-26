function solve(r::Robot)
    mvs = []
    go_to_corner!(r, mvs) #занимает угол
    mark_corners!(r) #красит углы
    return_back!(r, mvs) #возвращает робота в начальное положение
end

function moveIfPossible!(r::Robot, mvs::AbstractArray, side::HorizonSide)
    if !isborder(r, side)
        move!(r, side)
        push!(mvs, side)
    end
end

function go_to_corner!(r::Robot, mvs::AbstractArray)
    while isborder(r, Nord) == false || isborder(r, Ost) == false
        moveIfPossible!(r, mvs, Nord)
        moveIfPossible!(r, mvs, Ost)
    end
    #после выполнения данной функции, робот достигает правого верхнего угла
end

function mark_corners!(r::Robot)
    for side in (Sud, West, Nord, Ost)
        putmarkers!(r, side)
    end
end

function inverse(side::HorizonSide) #принимает сторону полученную сторону и возвращает противоположную
    return HorizonSide(mod(Int(side) +2, 4))
end 

function return_back!(r::Robot, mvs::AbstractArray)#возвращает робота в исходное положение
    while length(mvs) > 0
        last_move = pop!(mvs)
        move!(r, inverse(last_move))
    end  
end

function putmarkers!(r::Robot, side::HorizonSide)#расставляет маркеры
    while !isborder(r,side)
        move!(r,side)
        putmarker!(r)
    end
end

solve(r)