# Energía constante

E_total = 6
N = E_total
E_niveles = [i for i in 0:6]

configuraciones = [ [i0,i1,i2,i3,i4,i5,i6] for i0 in 0:6 for i1 in 0:6 for i2 in 0:6 for i3 in 0:6 for i4 in 0:6 for i5 in 0:6 for i6 in 0:6]

configuraciones = configuraciones[(sum.(configuraciones).==6)]
configuraciones = configuraciones[sum.([ c.*E_niveles for c in configuraciones]) .== 6]


function sorted_income(configuracion)
    income = []
    for i in 1:7
        j = 1
        while j <= configuracion[i]
            push!(income, i-1)
            j = j + 1
        end
    end
    return income
end

function gini_index(incomes)
    n = length(incomes)
    total = sum(incomes)
    diffs_sum = sum(abs.(broadcast(-, incomes, incomes')))
    return (diffs_sum / (2 * n * total)) / 0.833333333333333
end

unique(gini_index.(sorted_income.(configuraciones)))



