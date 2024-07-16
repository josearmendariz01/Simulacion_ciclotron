clear
clc
close all


posicion_proton=[0,0,0]; %Declaramos la posición del proton
velocidad_proton=[0,0,0]; %Declaramos la velocidad del proton
vel_norm=[0]; %Creamos una lista en la que se almacenaran las velocidades (magnitud)
Ek=[0]; %Creamos una lista en la que se almacenará la energía potencial 
posicionx=posicion_proton(1); %Determinamos la posición x del proton
posiciony=posicion_proton(2); %Determinamos la posición y del proton

%Declaramos nuestros valores

q=1.602e-19; %Carga del proton (C)
m=1.67e-27; %Masa del proton (kg)
V=4000; %Voltaje entre las placas (V)
d=0.001; %Distancia de separación entre las placas (m)
Eo=V/d; %Campo electrico basado en el potencial y distancia que existe entre las placas

B=[0,0,0.3]; %Campo Magnetico (T)
r=0.2; %Radio del ciclotron (m)

%Modelamos el movimiento

t=0; %Inicializamos el tiempo en 0
dt=1e-12; %Declaramos un tamaño de paso pequeño
i=1; %Inicializamos contador para almacenar los datos en una lista
while ((abs(posicionx(end)) < r) && (abs(posiciony(end)) < r)) %Creamos un ciclo que se repita siempre y cuando el protón no salga del ciclotron
    
    Fneta=[0,0,0];  %Declaramos nuestro vector fuerza que se irá actualizando con cada iteración

    if (((posiciony(end)) >= 0) && (abs(posicionx(end))<d)) %Si el proton se encuentra entre las dos placas, y se encuentra en el origen o arriba del origen en direccion y, la fuerza que actuara sobre el proton será fuerza electrica negativa (hacia la izquierda)
        Fneta(1)=-q*Eo;                                      

    elseif (((posiciony(end)) < 0) && (abs(posicionx(end))<d))  %Si el proton se encuentra entre las dos placas, y se encuentra abajo del origen en direccion y, la fuerza que actuara sobre el proton será fuerza electrica positiva (hacia la derecha)
        Fneta(1)=q*Eo;

    else
        Fneta=-q*cross(velocidad_proton,B); %Si el proton no se encuentra entre las placas (se encuentra en el semicirculo) actuara la fuerza magnetica
    end
    velocidad_proton=velocidad_proton+Fneta*dt/m; %Aqui utilizo euler para actualizar la velocidad del proton con la aceleracion
    posicion_proton=posicion_proton+velocidad_proton*dt; %Aqui utilizo euler para actualizar la posicion del proton con la velocidad
    posicionx(i)=posicion_proton(1);%Aqui encuentro la coordenada x de la posicion del proton y la almaceno
    posiciony(i)=posicion_proton(2);%Aqui encuentro la coordenada y de la posicion del proton y la almaceno
    t=t+dt; %Paso al siguiente tiempo
    vel_norm(i)=norm(velocidad_proton); %Aqui hago una lista con las magnitudes de las velocidades del proton
    Ek(i)=((1/2)*m*norm(velocidad_proton)^2)*6.241506e18; %Aqui hago una lista con las energias cineticas del proton
    i=i+1;

end
t_grafica=0:dt:t; %Aqui hago el tiempo en un vector para poder graficar la velocidad y la energia cinetica
disp(vel_norm(end)); %Desplego la magnitud de la velocidad final del proton
disp(Ek(end))
figure(1)
hold on
xlabel('Posición en x (m)');
ylabel('Posición en y (m)');
xlim([-0.21,0.21]);
ylim([-0.21,0.17]);
title('Figura 5. Posición del protón');
axis equal
plot(-d+0*(-100:100),-100:100); hold on;
plot(d+0*(-100:100),-100:100); hold on;
plot(posicionx,posiciony,'.');   %Grafica del movimiento del proton
hold off

figure(2)
hold on
xlabel('Tiempo (s)'); 
ylabel('Energia (eV)'); 
title('Figura 7. Energía cinetica conforme al tiempo'); %Grafica de la energia cinetica del proton
plot(t_grafica(1:end-1),Ek,'.');
hold off

figure(3)
hold on
xlabel('Tiempo (s)'); 
ylabel('Velocidad (m/s)'); 
title('Figura 6. Velocidad conforme al tiempo'); %Grafica de la velocidad del proton
plot(t_grafica(1:end-1),vel_norm,'.');
hold off