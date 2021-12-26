#ходим "змейкой", ищем маркеры и насчитываем сумму температур их положения
#в конце делим сумму температур на кол-во пройденных строчек (для точности значения)
function temp(r::Robot)
    sum=0 
    count=0
    side=Ost
    while isborder(r,Nord)==false
        s,c=moves!(r,side)
        sum+=s
        count+=c
        side=inverse(side)
    end
    s,c=moves!(r,side)
    sum+=s
    count+=c
    return (sum/count)
end
#ходим в определённую сторону, ищем маркеры и насчитываем температуру клеток с маркерами
#в конце поднимаемся на одну клеточку вверх
function moves!(r::Robot,side::HorizonSide)
    sum=0 
    count=0
    while isborder(r,side)==false
        if ismarker(r)==true
            count+=1
            sum+=temperature(r)
        end
        move!(r,side)
    end
    if isborder(r,Nord)==false
        move!(r,Nord)
    end
    return sum,count
end
#заменям направление на 180 градусов
function inverse(side::HorizonSide) 
    side=HorizonSide(mod(Int(side)+2,4)) 
end