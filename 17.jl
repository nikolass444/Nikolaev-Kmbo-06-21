function mark_Ost_field_with_barriers!(r)
    counters = move_to_corner!(r)         # запомним исходное положение
    move_forward!(r, Sud)                 # спустимся в нижний угол
    putmarker!(r)
    row_length = move_forward!(r, Ost)    # первый проход
    move!(r, Nord)
    move_by_snake!(r, row_length)
    move_to_corner!(r)
    return_to_start!(r, counters)
end



function move_by_snake!(r, counter)            # двигаемся "змейкой"
    direction = 1
    counter+=1
    counter1 = counter-1
    while counter1!=0 
        i = 0
        if direction == 1                      # если начинаем с конца строки
            while i != counter - counter1
                if !isborder(r, HorizonSide(1))
                    move!(r, HorizonSide(1))
                    i+=1
                else
                    i += move_through_barrier!(r, direction)
                    i+=1
                end
            end
            putmarker!(r)
        else                                     # если начинаем с начала строки
            putmarker!(r)
        end
        while i != counter-1                     # помечаем необохлдимое количество клеток
            if !isborder(r, HorizonSide(direction))
                move!(r, HorizonSide(direction))
                i += 1
                if direction==1
                    putmarker!(r)
                end
            else                                # если встречается преграда - огибаем
                i += move_through_barrier!(r, direction)
                i+=1
                if i<=counter1+1
                    putmarker!(r)
                end
            end
            if i<counter1   
                putmarker!(r)
            end
        end
        if !isborder(r,Nord)                     # переходим на следующий ряд
            move!(r, Nord)
        else                                     # если невозможно - прерываем работу для
            return 0                             # возвращения в исходное положение
        end
        direction = (direction+2)%4
        counter1 -= 1
    end    
end



function move_forward!(r, side)          # движение в сторону
    c = 0
    while !isborder(r, side)
        move!(r, side)
        c+=1
        if side==Ost                     # если ряд нижний - маркируем
            putmarker!(r)
        end
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


function return_to_start!(r, counters)   # возвращаемся в начало
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


mark_Ost_field_with_barriers!(r)