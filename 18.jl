#робот идёт в нижний левый угол, оттуда направляется по 4 сторонам и проставляет маркеры (последний маркер в левом нижнем углу)
#из левого нижнего угла возвращается в исходное положение по просчитанным шагам
function mark_angle!(r::Robot)
    vertical,horizontally=angle(r)
    for side in (Nord,Ost,Sud,West)
        moves!(r,side)
        putmarker!(r)
    end
    moves!(r,Ost,horizontally)
    moves1!(r,Nord,vertical)
end

#робот направляется в левый нижний угол и просчитывает кол-во пройденных шагов
function angle(r::Robot)
    vertical=0
    horizontally=0
    while (isborder(r,Sud)==false || isborder(r,West)==false)
        vertical+=moves!(r,Sud)
        horizontally+=moves!(r,West)
        repeat
    end
    return vertical,horizontally
end

#если нет перегородки, то мы делаем шаг в заданном направлении и насчитываем кол-во шагов
function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

#идём определённое кол-во шагов в определённую сторону
function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps 
        move!(r,side)
    end
end

#идём определённое кол-во шагов в сторону, но избегаем стенки (обходим их справа)
function moves1!(r::Robot,side::HorizonSide,num_steps::Int)
    q=0
    while q<num_steps 
        if isborder(r,Nord)==true
            while isborder(r,side)==true
                move!(r,Ost)
            end
            move!(r,Nord)
            q+=1
            if isborder(r,West)==true
                while isborder(r,West)==true
                    move!(r,Nord)
                    q+=1
                end
            end
            move!(r,West)
        end
        if q<num_steps
        move!(r,side)
        q+=1
        end
    end
end

#идём в сторону и проставялем маркеры на всём пути
function putmarkers!(r::Robot, side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
    if isborder(r,side)==true
        putmarker!(r)
    end
end