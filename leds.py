"""
An nMigen-driven Blinky example, running on a ZestSC1.
"""

from typing import List, Tuple
from nmigen import Elaboratable, Signal, Module, ResetSignal
from nmigen.hdl.ast import Assert, Cover, Assume
from nmigen.build.plat import Platform

from util import main

class Blinky(Elaboratable):
    """
    Blink the LEDs on the ZestSC1 via a counter.
    """
    def __init__(self):
        # # Inputs
        # self.my_input = Signal()

        # Outputs. These will be generated in the Verilog
        # module's signature (see FPGA-Verilog/nmigen.v)
        self.leds = Signal(8)
        self.timer = Signal(29)

        self.ports = [self.leds]

    def elaborate(self, _: Platform) -> Module:
        """
        Generate the circuit.
        """
        mod = Module()
        mod.d.sync += self.timer.eq(self.timer + 1)
        mod.d.sync += self.leds.eq(self.timer[-9:])
        return mod

    @classmethod
    def formal(cls) -> Tuple[Module, List[Signal]]:
        """Formal verification for my module."""
        mod = Module()
        mod.submodules.my_class = my_class = cls()

        # Make sure that the output is always less than 100M
        mod.d.comb += Assert(my_class.timer < 100_000_000)

        # Cover this case - i.e. show me that it can happen!
        mod.d.comb += Cover(my_class.timer == 5)

        # Don't want to test what happens when we reset.
        sync_rst = ResetSignal("sync")
        mod.d.comb += Assume(~sync_rst)

        return mod, [my_class.leds, my_class.timer]


if __name__ == "__main__":
    main(Blinky, "formal_verification/toplevel.il")
