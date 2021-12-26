#из начальной точки идём в верхний левый угол и насчитываем кол-во шагов в каждую сторону
#до тех пор, пока внизу не будет стенки "змейкой" проставляем маркеры
#возвращаемся обратно в левый верхний угол и оттуда по насчитанным шагам возвращаемся в начальное положение
function all(r::Robot)
    horizontally=0
    vertical=0
    for side in (Nord,West)
        while !isborder(r,side)
            move!(r,side)
            if side==West
                horizontally+=1
            elseif side==Nord
                vertical+=1
            end
        end 
    end
    while !isborder(r,Sud)
        right(r)
        left(r)
    end
    while !isborder(r,Ost)
        putmarker!(r)
        move!(r,Ost)
    end
    putmarker!(r)
    go(r)
    moves!(r,Sud,vertical)
    moves!(r,Ost,horizontally)
end
#идём в правую сторону и проставляем маркеры до тех пор, пока не встретим стенку
#ставим последний маркер у стенки и спускаемся на 1 клеточку вниз
function right(r::Robot)
    while !isborder(r,Ost)
        putmarker!(r)
        move!(r,Ost)
    end
    putmarker!(r)
    move!(r,Sud)
end   
#идём в левую сторону и проставляем маркеры до тех пор, пока не встретим стенку
#ставим последний маркер у стенки и спускаемся на 1 клеточку вниз
function left(r::Robot)
    while !isborder(r,West)
        putmarker!(r)
        move!(r,West)
    end
    putmarker!(r)
    move!(r,Sud)
end
#возвращаемся в левый верхний угол
function go(r::Robot)
    for side in (Nord,West)
        while !isborder(r,side)
            move!(r,side)
        end
    end
end
# идём определённое кол-во шагов (это чтобы вернуться в начальную позицию)
function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps 
        move!(r,side)
    end
end