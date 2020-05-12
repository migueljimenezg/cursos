library(jrvFinance)

duracion = bond.durations(settle = "2020-04-01", mature = "2022-05-04", coupon = 0.07, freq = 1, yield = 0.054, convention = "ACT/ACT", modified = F, redemption_value = 100)
duracion

duracion_modificada = bond.durations(settle = "2020-04-01", mature = "2022-05-04", coupon = 0.07, freq = 1, yield = 0.0534, convention = "ACT/ACT", modified = T, redemption_value = 100)
duracion_modificada

duracion = bond.durations(settle = "2020-04-01", mature = "2028-04-28", coupon = 0.06, freq = 1,yield = 0.072, convention = "ACT/ACT", modified = F, redemption_value = 100)
duracion

duracion_modificada = bond.durations(settle = "2020-04-01", mature = "2028-04-28", coupon = 0.06, freq = 1, yield = 0.072, convention = "ACT/ACT", modified = T, redemption_value = 100)
duracion_modificada
