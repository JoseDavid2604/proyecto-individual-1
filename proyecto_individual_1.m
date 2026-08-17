%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Tecnologico de Costa Rica
% Escuela de Ingenieria Electronica
% EL-5409 Laboratorio de Control Automatico
%
% Estudiante: Jose David Luna Herrera
% Carne: 2020114728
%
% Profesor: Ing. Luis C. Rosales
% II Semestre 2026
% Proyecto individual 1
%
% Simulacion de un motor de CD de primer orden

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clc;
close all;

%% Encabezado del programa

fprintf('=============================================\n');
fprintf('       SIMULACION DE UN MOTOR DE CD\n');
fprintf('          Proyecto Individual 1\n');
fprintf('=============================================\n\n');

%% Entrada de los parametros

% Se solicitan los parametros necesarios para obtener
% la funcion de transferencia del motor.

fprintf('Ingrese los parametros del motor:\n\n');

Kt = input('Kt [N*m/A]: ');
Ra = input('Ra [Ohm]: ');
b  = input('b [N*m*s/rad]: ');
Kb = input('Kb [V*s/rad]: ');
J  = input('J [kg*m^2]: ');

%% Validacion de los parametros

% Se verifica que los valores ingresados sean numeros
% validos y que tengan valores adecuados.

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

%% Calculo de KM y tau

% Ecuaciones utilizadas para el modelo del motor:
%
% KM = Kt/(Ra*b + Kt*Kb)
%
% tau = (J*Ra)/(Ra*b + Kt*Kb)

denominador = Ra*b + Kt*Kb;

KM = Kt / denominador;

tau = (J*Ra) / denominador;

%% Mostrar la funcion de transferencia

fprintf('\n=============================================\n');
fprintf('             RESULTADOS\n');
fprintf('=============================================\n\n');

fprintf('KM  = %.6f\n', KM);
fprintf('tau = %.6f s\n\n', tau);

fprintf('Funcion de transferencia:\n');
fprintf('             %.6f\n', KM);
fprintf('G(s) = -------------------------\n');
fprintf('          %.6f s + 1\n\n', tau);

%% Tiempo de simulacion

% Se utiliza un tiempo de simulacion de cinco
% constantes de tiempo.

t_final = 5*tau;

% Se generan 1000 puntos para obtener una curva suave.

t = linspace(0, t_final, 1000);

%% Respuesta al escalon unitario

% Para un sistema de primer orden:
%
%             KM
% G(s) = -------------
%          tau*s + 1
%
% La respuesta ante un escalon unitario es:
%
% y(t) = KM*(1-exp(-t/tau))

y = KM * (1 - exp(-t/tau));

%% Calculo de las caracteristicas de la respuesta

% Valor final teorico del sistema.

valor_final = KM;

% Respuesta cuando t = tau.

valor_tau = KM * (1 - exp(-1));

% Tiempo correspondiente a cinco constantes de tiempo.

tiempo_5tau = 5*tau;

% Respuesta cuando t = 5*tau.

valor_5tau = KM * (1 - exp(-5));

% Error de estado estacionario para una entrada escalon unitario.

error_estacionario = abs(1 - valor_final);

% Error de estado estacionario expresado como porcentaje.

error_estacionario_porcentaje = error_estacionario * 100;

% Tiempo de asentamiento utilizando el criterio del 2%.

tiempo_asentamiento = -tau * log(0.02);

%% Mostrar las caracteristicas de la respuesta

fprintf('=============================================\n');
fprintf('       CARACTERISTICAS DE LA RESPUESTA\n');
fprintf('=============================================\n\n');

fprintf('Valor final teorico          = %.6f\n', valor_final);

fprintf('Respuesta en t = tau         = %.6f\n', valor_tau);

fprintf('Tiempo t = 5*tau             = %.6f s\n', tiempo_5tau);

fprintf('Respuesta en t = 5*tau       = %.6f\n', valor_5tau);

fprintf('Error de estado estacionario = %.6f\n', error_estacionario);

fprintf('Error de estado estacionario = %.2f %%\n', ...
    error_estacionario_porcentaje);

fprintf('Tiempo de asentamiento 2%%    = %.6f s\n', ...
    tiempo_asentamiento);

%% Grafica de la respuesta

figure;

plot(t, y, 'LineWidth', 2);
hold on;
grid on;

% Valor final esperado.

yline(valor_final, '--', 'Valor final');

% Limites del 2% alrededor del valor final.

yline(valor_final * 1.02, ':', '+2%');

yline(valor_final * 0.98, ':', '-2%');

% Linea correspondiente a una constante de tiempo.

xline(tau, '--', 't = tau');

% Linea correspondiente a cinco constantes de tiempo.

xline(tiempo_5tau, '--', 't = 5tau');

% Linea correspondiente al tiempo de asentamiento.

xline(tiempo_asentamiento, '--', 'ts (2%)');

% Punto correspondiente a t = tau.

plot(tau, valor_tau, 'o', ...
    'MarkerSize', 6, ...
    'LineWidth', 1.5);

% Punto correspondiente a t = 5*tau.

plot(tiempo_5tau, valor_5tau, 'o', ...
    'MarkerSize', 6, ...
    'LineWidth', 1.5);

% Punto correspondiente al valor final.

plot(t(end), valor_final, 'o', ...
    'MarkerSize', 6, ...
    'LineWidth', 1.5);

%% Etiquetas de la grafica

xlabel('Tiempo [s]');
ylabel('Salida');

title('Respuesta al escalon unitario');

legend('Respuesta del sistema', ...
       'Valor final', ...
       '+2%', ...
       '-2%', ...
       't = tau', ...
       't = 5tau', ...
       'Tiempo de asentamiento', ...
       'Respuesta en t = tau', ...
       'Respuesta en t = 5tau', ...
       'Valor final teorico', ...
       'Location', 'southeast');

hold off;