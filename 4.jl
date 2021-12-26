#идём в левый нижний угол, просчитываем кол-во шагов
#насчитываем кол-во клеток по горизонтали
#ставим определённое кол-во маркеров в каждой строчке и поднимаемся наверх до конца
#возвращаемся в левый нижний угол и оттуда в начальную точку
function pyramid(r::Robot)
    x, y=coords!(r)
    n=number(r)
    while isborder(r,Nord)==false
        until!(r,n)
        move!(r,Nord)
        n-=1
        west!(r)
    end
    until!(r,n)
    coords!(r)
    while x>0
        move!(r,Ost)
        x-=1
    end
    while y>0
        move!(r,Nord)
        y-=1
    end
end
#идём в нижний левый угол и запоминаем кол-во шагов
function coords!(r::Robot)
    x, y = 0, 0
    while isborder(r,Sud)==false
        move!(r,Sud)
        y+=1
    end
    while isborder(r,West)==false
        move!(r,West)
        x+=1
    end
    return x, y
end
#просчитываем кол-во клеток по горизонтали и возвращаемся влево
function number(r::Robot)
    cnt=0
    while isborder(r,Ost)==false
        cnt+=1
        move!(r,Ost)
    end
    while isborder(r,West)==false
        move!(r,West)
    end
    return cnt
end
#идём вправо и ставим определённое кол-во маркеров
#в конце уменьшаем кол-во на единицу
function until!(r::Robot,n)
    while n>0
        putmarker!(r)
        move!(r,Ost)
        n-=1
    end
    putmarker!(r)
end
#возвращаемся влево до конца
function west!(r::Robot)
    while isborder(r,West)==false
        move!(r,West)
    end
end
# идём определённое кол-во шагов (это для того, чтобы вернуться в начальную позицию)
function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps 
        move!(r,side)
    end
end