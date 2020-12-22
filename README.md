I am experimenting with nMigen on my ZestSC1 FPGA board.
Sadly, in my attempt to quickly create a ZestSC1 `Platform` class,
I reached this:

    NotImplementedError: Spartan 3 family is not supported as a nMigen platform

Oh well - no matter. It is interesting anyway to see how I can use nMigen
without throwing away the usual Xilinx workflow. First step: to create Verilog
out of my nMigen Python code, and run it on the board.

- 2020/12/22 16:00: First achievement reached, nice blinking LEDs on my
SpartanXC3S1000 driven from Python. Yay! Next step: to try formal verification.

- 2020/12/22 17:25: Second achievement reached: successfully used both 
  Assert and Cover - and the nice 'make waves' rule inside folder
  `formal_verification/` demonstrated why I could cover `timer` reaching 7,
  but could not do the same for `leds` (hint: upper bits!)

Well, that was much easier than I thought! Love it.

P.S. None of this would have happened were it not for the excellent
tutorials and live-streaming sessions from Robert Baruch - who made
me aware of this very interesting new technology.
