library verilog;
use verilog.vl_types.all;
entity myStack is
    generic(
        n               : integer := 4
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        opcode          : in     vl_logic_vector(2 downto 0);
        input_data      : in     vl_logic_vector;
        output_data     : out    vl_logic_vector;
        overflow        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
end myStack;
