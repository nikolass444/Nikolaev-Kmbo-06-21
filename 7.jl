#ставим маркер в начальной клетке и направляемся в верхний левый угол, расставляя маркеры в шахматном порядке
#ходим "змейкой" и расставляем маркеры через одну клеточку в шахматном порядке
function chess(r)
    putmarker!(r)
    check(r,Nord)
    check(r,West)
    dir=Ost
    while !isborder(r,Sud) || !isborder(r,Ost)
        check(r,dir)
        marked=false
        if ismarker(r)
            marked=true
        end
        if !isborder(r,Sud)
            moveStep(r,Sud,!marked,true)
        end
        dir=inverse(dir)
    end
end

#ставим маркеры через одну клетку в определённом направлении используя тип bool
function check(r,side)
    marked=false
    while !isborder(r,side)
        if ismarker(r)
            marked=true
        end
        moveStep(r,side,!marked,true)
        marked=false
    end 
end

function moveStep(r,side,needMark,check=false)
    move!(r,side)
    if needMark
        if check
            if ismarker(r)
                return 0
            end
        end
        putmarker!(r)
    end
end

#заменям направление на 180 градусов
function inverse(side)
    side=HorizonSide(mod(Int(side)+2,4))
end