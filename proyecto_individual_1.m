%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Tecnológico de Costa Rica
% Escuela de Ingeniería Electrónica
% EL-5409 Laboratorio de Control Automático
%
% Estudiante: José David Luna Herrera
% Carné: 2020114728
%
% Profesor: Ing. Luis C. Rosales
% II Semestre 2026
% Proyecto individual 1
%
% Simulación de un motor de CD de primer orden

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clc;
close all;

%% Encabezado del programa

fprintf('=============================================\n');
fprintf('       SIMULACION DE UN MOTOR DE CD\n');
fprintf('          Proyecto Individual 1\n');
fprintf('=============================================\n\n');

%% Entrada de los parametros

% En esta parte se solicitan los parametros
% necesarios para obtener la funcion de transferencia.

fprintf('Ingrese los parametros del motor:\n\n');

Kt = input('Kt [N*m/A]: ');
Ra = input('Ra [Ohm]: ');
b  = input('b [N*m*s/rad]: ');
Kb = input('Kb [V*s/rad]: ');
J  = input('J [kg*m^2]: ');

%% Validacion de los parametros

% Se revisa que los valores ingresados sean numeros validos
% y que cumplan con las condiciones necesarias para el modelo.

if ~isnumeric(Kt) || ~isscalar(Kt) || ~isfinite(Kt) || Kt <= 0
    error('Kt debe ser un numero positivo.');
end

if ~isnumeric(Ra) || ~isscalar(Ra) || ~isfinite(Ra) || Ra <= 0
    error('Ra debe ser un numero positivo.');
end

if ~isnumeric(b) || ~isscalar(b) || ~isfinite(b) || b < 0
    error('b debe ser un numero mayor o igual que cero.');
end

if ~isnumeric(Kb) || ~isscalar(Kb) || ~isfinite(Kb) || Kb <= 0
    error('Kb debe ser un numero positivo.');
end

if ~isnumeric(J) || ~isscalar(J) || ~isfinite(J) || J <= 0
    error('J debe ser un numero positivo.');
end

%% Calculo de la ganancia y la constante de tiempo

% Primero se calcula el denominador que aparece en las
% ecuaciones del modelo del motor.

denominador = Ra*b + Kt*Kb;

% Ganancia del motor
KM = Kt / denominador;

% Constante de tiempo del motor
tau = (J*Ra) / denominador;

%% Mostrar los resultados obtenidos

fprintf('\n=============================================\n');
fprintf('             RESULTADOS\n');
fprintf('=============================================\n\n');

fprintf('KM  = %.6f\n', KM);
fprintf('tau = %.6f s\n\n', tau);

% Se muestra la funcion de transferencia obtenida
% a partir de los valores calculados.

fprintf('Funcion de transferencia:\n');
fprintf('             %.6f\n', KM);
fprintf('G(s) = -------------------------\n');
fprintf('          %.6f s + 1\n\n', tau);

%% Respuesta al escalon unitario

% Para un sistema de primer orden:
%
%          KM
% G(s) = ---------
%        tau*s + 1
%
% La respuesta ante un escalon unitario es:
%
% y(t) = KM*(1-exp(-t/tau))

% Se utiliza un tiempo de simulacion de cinco constantes
% de tiempo para poder observar como el sistema llega
% al valor final.

t_final = 5*tau;

% Se crean 1000 puntos para obtener una curva suave.

t = linspace(0, t_final, 1000);

% Calculo de la respuesta del sistema

y = KM * (1 - exp(-t/tau));

%% Calculo de las caracteristicas de la respuesta

% Para un escalon unitario, el valor final de la salida
% corresponde a la ganancia KM.

valor_final = KM;

% El error de estado estacionario se obtiene comparando
% la entrada unitaria con el valor final de la salida.

error_estacionario = abs(1 - valor_final);

% Se calcula el valor de la respuesta cuando t = tau.
% En este punto la respuesta alcanza aproximadamente
% el 63.2% del valor final.

valor_tau = KM * (1 - exp(-1));

% Tiempo de asentamiento utilizando el criterio del 2%.
%
% Se obtiene a partir de:
% exp(-t/tau) = 0.02

tiempo_asentamiento = -tau * log(0.02);

%% Mostrar las caracteristicas calculadas

fprintf('=============================================\n');
fprintf('       CARACTERISTICAS DE LA RESPUESTA\n');
fprintf('=============================================\n\n');

fprintf('Valor final esperado         = %.6f\n', ...
    valor_final);

fprintf('Error de estado estacionario = %.6f\n', ...
    error_estacionario);

fprintf('Respuesta en t = tau         = %.6f\n', ...
    valor_tau);

fprintf('Tiempo de asentamiento 2%%    = %.6f s\n', ...
    tiempo_asentamiento);

%% Grafica de la respuesta

% Se crea la figura y se grafica la respuesta al escalon.

figure;

plot(t, y, 'LineWidth', 2);
hold on;
grid on;

% Linea que representa el valor final esperado.

yline(valor_final, '--', ...
    'Valor final');

% Se marca el punto correspondiente a t = tau.

xline(tau, '--', ...
    't = tau');

% Se marca el tiempo de asentamiento al 2%.

xline(tiempo_asentamiento, '--', ...
    't_s (2%)');

% Se agregan las lineas que representan el limite superior
% e inferior del 2% alrededor del valor final.

yline(valor_final*1.02, ':', ...
    '+2%');

yline(valor_final*0.98, ':', ...
    '-2%');

% Nombre de los ejes y titulo de la grafica.

xlabel('Tiempo [s]');
ylabel('Salida');

title('Respuesta al escalon unitario');

% Se agrega una leyenda para identificar las diferentes
% lineas utilizadas en la grafica.

legend('Respuesta del sistema', ...
       'Valor final', ...
       't = tau', ...
       'Tiempo de asentamiento', ...
       '+2%', ...
       '-2%', ...
       'Location', 'southeast');

hold off;