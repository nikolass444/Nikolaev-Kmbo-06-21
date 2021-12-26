# шагаем туда-обратно n-ое кол-во раз, пока не найдём проход сверху, при этом увеличиваем шаг на 1
# когда нашли "дверьку", останавливаемся
function door!(rob::Robot)
    flag=false
    num_steps=1
    while flag==false
        moves!(rob,West,num_steps)
        if (isborder(rob,Nord)==false)
            flag=true
            break
        end
        moves!(rob,Ost,num_steps)

        moves!(rob,Ost,num_steps)
        if (isborder(rob,Nord)==false)
            flag=true
            break
        end
        moves!(rob,West,num_steps)

        num_steps+=1
    end
end
#идём определённое кол-во шагов
function moves!(rob::Robot, side::HorizonSide, num_step::Int)
    for _ in 1:num_step
        move!(rob, side)
    end
end