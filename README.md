# Fraud Detection
Proyecto desarrollado por Santiago Torres y Victor Munera como proyecto para la clase de Inteligencia Artificial en la Pontificia Universidad Javeriana.

# Introducción
Este proyecto busca continuar la invitación hecha en https://bit.ly/2zjyIwv [1] un reto de kaggle.com y Vesta Corportation para mejorar los algoritmos de prevención de fraude financiero. El ejercicio ilustra que los algoritmos de machine learning que normalmente se utilizan, si bien efectivos, no siempre son perfectos. EL problema propone hacer la revisión de diferentes algoritmos para obtener cuál es el mejor. Sin embargo, nuestra propuesta es desarrollar un nuevo algoritmo de prevención basado en machine learning a partir de la base de datos propuesta por Vesta Corportation. La base de datos contiene 591 datos de tipo de transacción, si la transacción fue fraude, tipo de tarjeta, dominio del cuál proviene la solicitud de transacción, entre otros.

# Problema a solucionar
El problema a solucionar es el de fraude electrónico en donde se genera comportamiento anómalo en las compras o transacciones que utilizan medios digitales, tal es el caso de las compras utilizando tarjetas de crédito.

De acuerdo con una investigación realizada por la multilatina Digiware, que monitoreó más de 13.000 dispositivos en Latinoamérica, en Colombia son generados en promedio 542.465 ataques informáticos diarios, de los cuales 39,56% los sufre el sector financiero.

Así mismo, la clonación de tarjetas de crédito en Colombia sucede en un 30% en los cajeros electrónicos y 70% en las plataformas de comercio que no cuentan con suficientes procesos de verificación y generalmente estos fraudes se hacen para compras de tiquetes aéreos.

Adicional a esto, el más reciente estudio de la compañía internacional experta en seguridad informática, Kaspersky, señala que un incidente cibernético puede llegar a costarle a una entidad bancaria hasta 1,8 millones de dólares, pues el 61% de esos generan costos adicionales para las entidades como pérdida de datos o de reputación.

Es por esto, que se considera importante la implementación en software que cumpla con observar y controlar el comportamiento financiero de los clientes de una entidad bancaria, con el objetivo de detectar de manera rápida y eficaz comportamientos que no sean propios del cliente y poder mitigar las acciones de los ciber-delincuentes.

# Camino de solución propuesto hasta la fecha
Se propone entonces realizar al menos cuatro algoritmos de clasificación a partir de un modelo de entrenamiento supervisado. El sistema deberá reconocer dos clases, si la transacción fue fraudulenta o si la transacción no lo fue. En ese orden de ideas, el sistema se utilizaría los datos provistos en la base de datos en cuestión, estos son: tipo de transacción, si la transacción fue fraude, tipo de tarjeta, dominio del cuál proviene la solicitud de transacción, entre otros.

# Referencias utilizadas para este proyecto
[1] I. C. I. Society. (2019). IEEE-CIS Fraud Detection, Vesta, dirección: https://www.kaggle.com/c/ieee-fraud-detection/overview

[2] Portafolio. (2017). El fraude electrónico, el principal problema del sistema financiero, Portafolio,
dirección: https://www.portafolio.co/economia/finanzas/fraude-electronico-el-principal-problema-del-sistema-financiero-511655
