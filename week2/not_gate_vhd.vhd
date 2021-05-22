library ieee;
    use ieee.std_logic_1164.all;
	 use ieee.std_logic_arith.all;
	 use ieee.std_logic_unsigned.all;
	

entity not_gate_vhd is
	port(
		A : in std_logic;
		Y : out std_logic
	);
end not_gate_vhd;

  
architecture dataflow of not_gate_vhd is
begin
	Y <= not A;
end dataflow; 