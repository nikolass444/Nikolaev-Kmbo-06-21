function mark_field_with_barriers!(r)
    counters = move_to_corner!(r)         # Запоминаем исходное положение робота
    putmarker!(r)
    move_forward!(r, Sud)                 # спустимся в нижний угол
    row_length = move_forward!(r, Ost)    # Первый проход
    move!(r, Nord)
    move_by_snake!(r, row_length)
    move_to_corner!(r)
    return_to_start!(r, counters)
end



function move_by_snake!(r, counter)            # двигаемся так называемой змейкой
    direction = 1
    while true 
        i = 0
        while i != counter-1                   # отмечаем на одну клетку меньше, потому что
            if !isborder(r, HorizonSide(direction))   # левый столбец уже помечен
                putmarker!(r)
                move!(r, HorizonSide(direction))
                i += 1
                putmarker!(r)
            else                                # если встречается преграда - обходим
                i += move_through_barrier!(r, direction)#ведь умный в гору не пойдет
                i+=1
            end
            if i==counter-1
                putmarker!(r)
            end
        end
        if !isborder(r,Nord)
            move!(r, Nord)
        else
            return 0
        end
        direction = (direction+2)%4
    end    
end



function move_forward!(r, side)          # двигаемся и маркируем все
    c = 0
    while !isborder(r, side)
        move!(r, side)
        c+=1
        putmarker!(r)
    end
    return c
end


function move_through_barrier!(r, side)   # огибаем преграду
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
    putmarker!(r)
    return(counter1)
end




function move_to_corner!(r)           # идем в левый верхний угол
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