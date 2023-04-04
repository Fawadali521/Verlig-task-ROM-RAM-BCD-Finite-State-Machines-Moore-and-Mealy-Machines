--
-- Filename    : store_array.vhd
-- 
-- Designer    : D. K. May
--
-- Description : Register storage for incoming
--               data.

library ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY store IS
   GENERIC (
      counter_size : integer := 5;
      buffer_size : integer := 32
   );
   PORT (
      clock	: IN std_logic;
      reset	: IN std_logic;
      oeenable : IN std_logic;
      txda : IN std_logic;
      ramadrs : IN std_logic_vector((counter_size *2) DOWNTO 0);
      buffers : OUT std_logic_vector((buffer_size-1) DOWNTO 0)
   );
END store;

ARCHITECTURE RTL OF store IS

BEGIN

-- This block produces a n-bit register along
-- with decode logic to load each of the bits
-- in the register.
Storer : PROCESS (clock)
variable address : integer range 0 to (buffer_size - 1); 
BEGIN
  address := conv_integer(ramadrs((counter_size *2) downto (counter_size +1)));
  IF (clock'event AND clock = '1') THEN
    IF reset = '0' THEN
      buffers <= (others => '0');
    ELSIF (oeenable = '0') THEN
      buffers(address) <= txda;
    END IF;
  END IF;
END PROCESS;

END RTL;