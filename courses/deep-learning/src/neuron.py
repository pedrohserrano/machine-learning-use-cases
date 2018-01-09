# coding: utf-8

import numpy as np


## En este caso estamos suponiendo que el vector de pesos es 1d
## Y el bias es un número

class Neuron:
    def __init__(self, pesos, bias, function):
        self.w = pesos
        self.b = bias
        self.function = function

    def forward(self, entradas):
        logit = np.dot(entradas, self.w) + self.b

        salida = self.function(logit)

        return output
