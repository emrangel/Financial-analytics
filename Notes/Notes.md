1. Métricas para un buen ajuste

Es fundamental evaluar el ajuste del modelo utilizando métricas adecuadas que eviten la sobreespecificación. Algunas métricas útiles incluyen:

R² (coeficiente de determinación): Indica qué proporción de la varianza de la variable dependiente se explica por el modelo. Sin embargo, un R² alto no siempre significa que el modelo es bueno; es crucial complementarlo con otras métricas.

AIC (Criterio de Información de Akaike) y BIC (Criterio de Información Bayesiano): Estas métricas penalizan la complejidad del modelo, ayudando a evitar la sobreespecificación. Un AIC o BIC más bajo indica un modelo preferible.

2. Comportamiento de los residuales

Los residuales (las diferencias entre los valores observados y los pronosticados) deben comportarse de manera aleatoria. Esto significa que:

No deben mostrar patrones: Si hay patrones en los residuales, puede indicar que el modelo no está capturando toda la información relevante.

Deben tener una varianza constante (homocedasticidad): La variabilidad de los residuales debe ser consistente a lo largo de todas las predicciones. Si la varianza cambia (heterocedasticidad), esto puede comprometer la validez del modelo.

3. Métricas para evaluar el desempeño del pronóstico

Para evaluar el desempeño del modelo en la generación de pronósticos, se pueden utilizar varias métricas, entre ellas:

MAE (Error Absoluto Medio): Mide el promedio de los errores absolutos, proporcionando una idea clara del tamaño de los errores.

RMSE (Raíz del Error Cuadrático Medio): Penaliza más los errores grandes y es útil para medir la precisión de las predicciones.

MAPE (Error Porcentual Absoluto Medio): Indica el error porcentual medio de las predicciones, lo que facilita la comparación entre diferentes modelos o series temporales.