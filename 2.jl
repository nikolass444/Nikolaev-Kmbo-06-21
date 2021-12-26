#идём в угол и просчитываем кол-во шагов вниз и влево
#от угла идём по всем четырём сторонам, проставляем маркеры по периметру
# возвращаемся в начальное положение по изначально просчитанным шагам
function perimetr!(r::Robot)
    vertical=moves!(r,Sud)
    horizontally=moves!(r,West)
    for side in (Nord,Ost,Sud,West)
        while isborder(r,side)==false
            putmarkers!(r,side)
        end
    end
    moves!(r,Nord,vertical)
    moves!(r,Ost,horizontally)
end

# просчитываем кол-во клеток в определённую сторону от начального положения
function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

# идём и ставим маркеры до тех пор, пока нет перегородки
# если дошли до стенки, ставим последний маркер
function putmarkers!(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
    if isborder(r,side)==true
        putmarker!(r)
    end
end

# идём определённое кол-во шагов (это чтобы вернуться в начальную позицию)
function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps 
        move!(r,side)
    end
end