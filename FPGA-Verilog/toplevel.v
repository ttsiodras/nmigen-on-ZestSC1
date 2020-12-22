/*
 * Based on Orange Tree's ZestSC1 Example1.
 * We just integrate the nMigen-generated module.
 */

module toplevel (
        input USB_StreamCLK,
        output [1:0] USB_StreamFIFOADDR,
        output USB_StreamPKTEND_n,
        input [2:0] USB_StreamFlags_n,
        output USB_StreamSLOE_n,
        output USB_StreamSLRD_n,
        output USB_StreamSLWR_n,
        inout [15:0] USB_StreamData,
        input USB_StreamFX2Rdy,

        input USB_RegCLK,
        input [15:0] USB_RegAddr,
        inout [7:0] USB_RegData,
        input USB_RegOE_n,
        input USB_RegRD_n,
        input USB_RegWR_n,
        input USB_RegCS_n,

        output USB_Interrupt,

        inout [7:0] User_Signals,

        output S_CLK,
        output [22:0] S_A,
        inout [8:0] S_DA,
        inout [8:0] S_DB,
        output S_ADV_LD_N,
        output S_BWA_N,
        output S_BWB_N,
        output S_OE_N,
        output S_WE_N,

        inout IO_CLK_N,
        inout IO_CLK_P,
        inout [46:0] IO
    );

    // Declare signals
    wire CLK;
    wire RST;
    reg [21:0] Count;
    wire [7:0] LEDs;
    reg Dir;

    // Tie unused signals
    assign User_Signals = 8'hZ;
    assign IO_CLK_N = 1'bZ;
    assign IO_CLK_P = 1'bZ;
    assign IO = {LEDs[7:2], 39'hZ, LEDs[1:0]};

    // Clock divider
    always @ (posedge RST or posedge CLK)
        if (RST==1)
            Count <= 0;
        else
            Count <= Count + 1;

    // Instantiate nMigen top-level
    Nmigen nmigen(
            .clk(CLK),
            .rst(RST),
            .leds(LEDs)
        );

    // Instantiate interfaces component
    ZestSC1_Interfaces Interfaces (
            .USB_StreamCLK (USB_StreamCLK),
            .USB_StreamFIFOADDR (USB_StreamFIFOADDR),
            .USB_StreamPKTEND_n (USB_StreamPKTEND_n),
            .USB_StreamFlags_n (USB_StreamFlags_n),
            .USB_StreamSLOE_n (USB_StreamSLOE_n),
            .USB_StreamSLRD_n (USB_StreamSLRD_n),
            .USB_StreamSLWR_n (USB_StreamSLWR_n),
            .USB_StreamData (USB_StreamData),
            .USB_StreamFX2Rdy (USB_StreamFX2Rdy),

            .USB_RegCLK (USB_RegCLK),
            .USB_RegAddr (USB_RegAddr),
            .USB_RegData (USB_RegData),
            .USB_RegOE_n (USB_RegOE_n),
            .USB_RegRD_n (USB_RegRD_n),
            .USB_RegWR_n (USB_RegWR_n),
            .USB_RegCS_n (USB_RegCS_n),

            .USB_Interrupt (USB_Interrupt),

            .S_CLK (S_CLK),
            .S_A (S_A),
            .S_ADV_LD_N (S_ADV_LD_N),
            .S_BWA_N (S_BWA_N),
            .S_BWB_N (S_BWB_N),
            .S_DA (S_DA),
            .S_DB (S_DB),
            .S_OE_N (S_OE_N),
            .S_WE_N (S_WE_N),

            // User connections
            // Streaming interface
            .User_CLK (CLK),
            .User_RST (RST),

            .User_StreamBusGrantLength (12'b0),

            //.User_StreamDataIn
            //.User_StreamDataInWE
            .User_StreamDataInBusy (1'b1),

            .User_StreamDataOut (16'b0),
            .User_StreamDataOutWE (1'b0),
            //.User_StreamDataOutBusy

            // Register interface
            //.User_RegAddr
            //.User_RegDataIn
            .User_RegDataOut (8'b0),
            //.User_RegWE
            //.User_RegRE

            // Signals and interrupts
            .User_Interrupt (1'b0),

            // SRAM interface
            .User_SRAM_A (23'b0),
            .User_SRAM_W (1'b0),
            .User_SRAM_R (1'b0),
            //.User_SRAM_DR_VALID
            .User_SRAM_DW (18'b0)
            //.User_SRAM_DR
        );

endmodule
