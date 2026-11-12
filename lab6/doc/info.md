### Order of Operations

**INPUT state** (on reset OR execute_btn press in WRITEBACK) 
assign **result_padded** signal to **a** signal (left-pad with 4 zeroes)
**we** signal set to 0 (disabled)

**EXECUTE state** (on execute_btn press)
**we** signal set to 0 (disabled)
**addr** signal increment by 1 (via a clocked process)
assign **result_padded** signal to **alu_out** left-padded with 4 zeroes (sends result to the displays)

**WRITEBACK state** (one clock after RESULT)
**we** signal set to 1 (enabled)
assign **result_padded** signal to **alu_out** (continue showing the result)

On reset press (async): clear  entire memory to 0, set addr to 0, and move to INPUT.
