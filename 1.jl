# из исходной точки ходим по 4 разным сторонам, расставляя маркеры
# но исходную точку оставляем свободной (как флаг)
function krest(r::Robot) 
    for side in (Nord, Sud, West, Ost) 
        moves(side) 
        reverse(side) 
    end 
    putmarker!(r) 
end 
#идём в определённую сторону до тех пор, пока нет перегородки и ставим маркеры
function moves(side) 
    while isborder(r,side)==false 
        move!(r,side) 
        putmarker!(r) 
    end 
end 
#возвращаемся в начальную точку
function reverse(side) 
    while ismarker(r) 
        move!(r,inverse(side)) 
    end 
end   
#заменям направление на 180 градусов
function inverse(side) 
    side=HorizonSide(mod(Int(side)+2,4)) 
end