
# Proyecto Individual 1

## Laboratorio de Control Automático

**Estudiante:** José David Luna Herrera  
**Carné:** 2020114728  

**Profesor:** Ing. Luis C. Rosales  
**II Semestre 2026**

## Descripción

Este proyecto consiste en la simulación de un motor de corriente
directa utilizando un modelo de primer orden.

La función de transferencia utilizada es:

G(s) = KM / (tau*s + 1)

Los valores de KM y tau se calculan a partir de los parámetros
del motor.

## Parámetros de entrada

El programa solicita los siguientes parámetros:

- Kt: constante de par del motor [N*m/A]
- Ra: resistencia de armadura [Ohm]
- b: coeficiente de fricción [N*m*s/rad]
- Kb: constante de fuerza electromotriz [V*s/rad]
- J: momento de inercia [kg*m^2]

## Uso del programa

Para ejecutar el programa se debe abrir el archivo
`proyecto_individual_1.m` en MATLAB y ejecutarlo.

El programa solicita los valores de los parámetros por medio de
la ventana de comandos.

Después de ingresar los valores, se calculan:

- Ganancia KM
- Constante de tiempo tau
- Función de transferencia
- Valor final esperado
- Error de estado estacionario
- Respuesta en t = tau
- Tiempo de asentamiento al 2%

FY se muestra la respuesta del sistema ante un escalón
unitario.

## Modelo utilizado

La función de transferencia del sistema es:

G(s) = KM / (tau*s + 1)

donde:

KM = Kt / (Ra*b + Kt*Kb)

tau = (J*Ra) / (Ra*b + Kt*Kb)
