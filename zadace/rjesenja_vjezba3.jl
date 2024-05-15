## parametri koji su globalni ( da ih možemo koristiti unutar funkcija)
global m=70
global cd=0.25
global g=9.81

function deriva(v)
    dv=g-((cd/m)*v*abs(v))
    return dv
end

function brzina2(v0,dt,tp,tk) # v0-početna vrijednost brzine (ovisne varijable),dt-vremenski korak, tp-početno vrijeme, tk-konačno vrijeme 
    vi=v0
    ti=tp
    s=dt # unosimo ovu varijablu da bi po potrebi negdje drugdje kasnije znali vrijednost dt
    br=zeros(0) # vektor za spremanje brzine svakog intervala (ovaj put želimo vratiti brzinu u svakoj točci, ne samo onu na kraju intervala)
    vrijeme=zeros(0) # 
    put=zeros(0) # ako želimo prijeđeni put u svakom koraku radimo ovaj vektor
    p=0 # za izračun puta
    total_p=0
    while true
        if ti+dt>tk # testiranje da ne idemo preko konačnog intervala
            s=tk-ti # ako idemo preko intervala onda skraćujemo vrijeme koraka - time garantiramo da će korak završiti na tk
        end
        dvdt= deriva(vi)
        append!(br,vi) # da bi imali brzinu u svakom intervalu
        append!(vrijeme, ti)
        append!(put,p)
        p=p-vi*s 
        vi=vi+dvdt*s
        ti=ti+s
        if ti>=tk # kada je vrijeme ti veće od konačnog vremena intervala prekidamo petlju
            break
        end
        #println("$i")
    end
    append!(br,vi) # da bi imali brzinu u svakom intervalu
    append!(vrijeme, ti)
    append!(put,p)
    # računanje ukpunog prijeđenog puta 
    for i in 1:length(put)-1
        total_p+=abs(put[i]-put[i+1])
    end
    return vi, br, vrijeme, put, total_p, v
end
## pozivanje funkcije
rez, brzi, vrijeme, put, ukupni_put, v=brzina2(0,0.5,0,15)
#Ukupni prijeđeni put
display(ukupni_put)

## ANALITIČKO RJEŠENJE ZA TERMINALNU BRZINU I OVISNOST BRZINE O VREMENU
## parametri i varijable koje znamo
m=70
cd=0.25
t=0:0.5:15
#t=collect(t)
g=9.81
## jednadžba brzine ovisne o vremenu - analitičko rješenje
v=sqrt((g*m)/cd).*tanh.(sqrt.((g*cd)/m).*t)

#Ispis relativne pogreške
display(abs.(v-brzi))

##
##
##napravimo sliku

using Plots

plot(vrijeme, brzi, label="Brzina ovisno o vremenu", legend = :bottomright) # osnovna naredba za plot
plot!(xlab="t [s]", ylab="v [m/s]")
savefig("numeričko_rješenje.png")
plot!(vrijeme, put, label="Put ovisno o vremenu", legend = :bottomright) # osnovna naredba za plot

plot!(t, v, label="Brzina ovisno o vremenu_ analitičko", color=:red, legend = :bottomright) # osnovna naredba za plot osnovna naredba za plot
savefig("usporedba.png")


## a što ako unesemo step size veći od intervala tk-tp. Npr tk-tp=5, dt=20
## možete se poigrati s kodom i unijeti dodatnu provjeru koja za navedeno izbacuje grešku

println("Dobivamo bitno drugačije rezultate brzine i puta, ako maknemo abs(v) iz deriv funkcije. 
Bez abs(v) iz grafa vidimo kako krivulja brzine ima vijugavo kretanje, različito od parabole koju dobijemo s abs(v).
Bez abs(v) ako stavimo negativnu brzinu, vidimo da put prijelazi u negativne vrijednosti puno kasnije nego li u grafu funkcije s abs(v).")