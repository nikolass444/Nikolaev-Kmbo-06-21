function count_square_barriers(r)
    counters = move_to_corner!(r)         #запоминаем начальное положение робота
    move_forward!(r, Sud)                 #спускаемся в нижний угол
    row_length = move_forward!(r, Ost)    #первый проход
    move!(r, Nord)
    count_barriers = move_by_snake!(r, row_length)
    move_to_corner!(r)
    return_to_start!(r, counters)
    return count_barriers
end



function move_by_snake!(r, counter)            #двигаемся так называемой "змейкой"
    direction = 1
    c = 0
    while true 
        i = 0
        while i != counter                      #обходим все поле змейкой и ищем перегородки
            if !isborder(r, HorizonSide(direction))  
                move!(r, HorizonSide(direction))
                i += 1
            else                                #если встречаем преграду, обходим ее
                i1 = i
                i += move_through_barrier!(r, direction)
                i+=1
                c+=1                            #увеличиваем счетчик кол-ва перегородок
            end
        end
        if !isborder(r,Nord)
            move!(r, Nord)
        else
            return c
        end
        direction = (direction+2)%4
    end    
end



function move_forward!(r, side)          #двигаемся по прямой
    c = 0
    while !isborder(r, side)
        move!(r, side)
        c+=1
    end
    return c
end


function move_through_barrier!(r, side)   #обходим преграду
    counter = 0
    counter1 = 0
    while isborder(r, HorizonSide(side))
        move!(r, Nord)
        counter+=1
    end
    move!(r, HorizonSide(side))
    while isborder(r, Sud)
        move!(r, HorizonSide(side))
        counter1 += 1
    end
    for i in 0:counter-1
        move!(r, Sud)
    end
    return(counter1)
end




function move_to_corner!(r)           #идем в левый верхний угол
    counters = []
    while !(isborder(r,Nord) && isborder(r,West))
        counter_N = 0
        while !isborder(r,Nord)
            move!(r, Nord)
            counter_N+=1
        end
        pushfirst!(counters, counter_N)
        counter_W = 0
        while !isborder(r,West)
            move!(r, West)
            counter_W+=1
        end
        pushfirst!(counters, counter_W)
    end     
    return counters
end


function return_to_start!(r, counters)   #возвращаемся в исходное положение
    for i in 1:size(counters, 1)
        if i%2==0
            for j in 0:counters[i]-1
                move!(r, Sud)
            end

        end
        if i%2==1
            for j in 0:counters[i]-1
                move!(r, Ost)
            end
        end
    end
end


count_square_barriers(r)