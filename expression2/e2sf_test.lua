_strict()
_name("E2SF test")
_inputs({EGP='wirelink', User='entity', A='number'})
_outputs({B='number'})
_persist({N='number', S='string'})
if first() ~= 0 then
	print("N", N)
	print("S", S)
	print("A", A)
	print("B", B)
	B = A
	interval(100)
elseif clk() ~= 0 then
	print("clkName()", clkName())
end
