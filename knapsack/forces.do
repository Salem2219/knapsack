force -freeze sim:/test/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/test/rst 1 0
force -freeze sim:/test/rst 0 100
force -freeze sim:/test/start 1 0
force -freeze sim:/test/start 0 500
force -freeze sim:/test/n 10 0
force -freeze sim:/test/w2 00110010 0