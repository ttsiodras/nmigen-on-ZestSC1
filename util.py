# Disable pylint's "your name is too short" warning.
# pylint: disable=C0103
"""
This module provides various global utilities.
"""
import sys

from nmigen.back import rtlil
from nmigen.hdl import Fragment
from nmigen.back import verilog

if sys.version_info < (3, 8):
    print("Python 3.8 or above is required")
    sys.exit(1)


def main(cls, filename="toplevel.il"):
    """Runs a file in simulate or generate mode.

    Add this to your file:

        from util import main

        if __name__ == "__main__":
            main(YourClass)

    Then, you can run the file in simulate or generate mode:

    python <file.py> sim will run YourClass.sim and output to whatever vcd
        file you wrote to.
    python <file.py> gen will run YourClass.formal and output in RTLIL format
        to toplevel.il. You can then formally verify using
        sby -f <file.sby>.
    """

    if len(sys.argv) != 2 or sys.argv[1] not in ["sim", "gen", "ver"]:
        print(f"Usage: python3 {sys.argv[0]} sim|gen|ver")
        sys.exit(1)

    if sys.argv[1] == "sim":
        cls.sim()
    elif sys.argv[1] == "gen":
        design, ports = cls.formal()
        fragment = Fragment.get(design, None)
        output = rtlil.convert(fragment, ports=ports)
        with open(filename, "w") as f:
            f.write(output)
    else:
        f = open("FPGA-Verilog/nmigen.v", "w")
        top = cls()
        f.write(
            verilog.convert(
                top, name='Nmigen', strip_internal_attrs=True,
                ports=top.ports))
