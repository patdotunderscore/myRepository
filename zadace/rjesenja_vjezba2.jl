# konstante 
N=20;
minX=-2
maxX=2
minY=-2
maxY=2
eps0 = 8.854e-12
k = 1/(4*pi*eps0);
#zadajmo poziciju i iznos prvog naboja
#broj točaka
x_coordinates = rand(range(minX, maxX, length=N),20)
y_coordinates = rand(range(minY, maxY, length=N),20)
Qn = x_coordinates = rand(range(-20, +20, length=N),20)
# moramo zadati točke u kojima računamo električno polje pa radimo mrežu od N broja točaka u kojima ćemo to računati
x=range(minX, maxX, length=N)
y=range(minY, maxY, length=N)
## kako bi dobili tu mrežu moramo za svaku točku x i y napraviti array a dih lakše vučemo van (isprobajte display(xG) i display(yG) kako bi provjerili što dobijemo)
xG=x' .* ones(N)
yG=ones(N)' .* y
## Sada možemo pristupiti izračunu
#prvo za prvi naboj računamo udaljenosti i polje
Ex=zeros((20,20)) 
Ey=zeros((20,20)) 
for i in 1:N 
    Rx = xG .- x_coordinates[i]
    Ry = yG .- y_coordinates[i]
    R = sqrt.(Rx.^2 + Ry.^2).^3
    Ex += k .* Qn[i] .* Rx ./ R # na poziciji x koliki je doprinos naboja 
    Ey += k .* Qn[i] .* Ry ./ R # na poziciji y koliki je doprinos naboja
end
display(Ex)
E = sqrt.(Ex.^2 + Ey.^2) # ukupno polje
display(E)

#Izračun x i y kompomenti polja
u = Ex./E # normirana vrijednost
v = Ey./E # normirana vrijednost

#display(v)
##
## VIZUALIZACIJA REZULTATA
## provjerite naredbe scatter i quiver
using Plots
gr()
# prvo crtamo naša dva naboja naredbom scatter
Plots.scatter(x_coordinates, y_coordinates, label="Coordinates", aspect_ratio=:equal)

## zatim možemo crtati polje vektora ( u ovom slučaju ćemo svaku zasebno naredbu za svaku od 20 točaka u gridu)


for i=1:N
    display(quiver!(xG[i,:],yG[i,:],quiver=(u[i,:]/10,v[i,:]/10))) # probajte maknuti /10 pa ćete dobiti dulje strelice
end
#savefig("2tockasta_naboja.png")
## možemo i contour plot
contour!(x,y, E)
#savefig("2tockasta_naboja.png") 
