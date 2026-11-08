### Order of Operations

**INPUT state** (on reset OR execute_btn press in WRITEBACK) 
assign *result_padded* signal to *a* signal
*we* signal set to 0 (disabled)

**EXECUTE state** (on execute_btn press)
*we* signal set to 0 (disabled)
*addr* signal increment by 1
assign *result_padded* signal to *alu_out*

**WRITEBACK state** (one clock after RESULT)
*we* signal set to 1 (enabled)
assign *result_padded* signal to *a* signal

On reset press (async): clear  entire memory to 0, set addr to 0, and move to INPUT.
