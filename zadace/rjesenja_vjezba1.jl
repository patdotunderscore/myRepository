#1.
x=y=1
x
y
#x=y=1 inicijalizira x i y na 1

#2.
15=a
#ERROR: syntax: invalid assignment location "15"

#3.
xy
#ERROR: UndefVarError: `xy` not defined
x*y
#x*y=1

#4.
function volume(a,oblik)
    if(oblik=="kocka")
        println(a*a*a)
    elseif(oblik=="sfera")
        println(4/3*pi*a*a*a)
    else
        println("Navedeni oblik nije ispravan.")
    end
end


#5.
function absolute(a)
    if(a<0)
        println(-a)
    else
        println(a)
    end
end


#6.
function udaljenost(x1,y1,x2,y2)
    println(sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)))
end


#7.
function counting()
    for i in 1:30 
        println(i)
    end
end


#8.
function brojiA(sentence)
    countA = count(c -> c == 'a', sentence)
    println("Broj slova 'a' u rečenici je: ", countA) 
end

    