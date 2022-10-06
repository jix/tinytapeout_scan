// Based on primitives.v, see primitives.v for license

module \pullup (output D);
    assign D = 1;
endmodule


module \pulldown (output D);
    assign D = 0;
endmodule

module sky130_fd_sc_hd__udp_mux_2to1_N (
    Y ,
    A0,
    A1,
    S
);

    output Y ;
    input  A0;
    input  A1;
    input  S ;


    assign Y = S ? !A1 : !A0;
endmodule

module sky130_fd_sc_hd__udp_dff$PS_pp$PG$N (
    Q       ,
    D       ,
    CLK     ,
    SET     ,
    NOTIFIER,
    VPWR    ,
    VGND
);

    output Q       ;
    input  D       ;
    input  CLK     ;
    input  SET     ;
    input  NOTIFIER;
    input  VPWR    ;
    input  VGND    ;

    reg Q;

    always @(posedge CLK, posedge SET) begin
        if (SET)
            Q <= 1;
        else
            Q <= D;
    end
endmodule

module sky130_fd_sc_hd__udp_mux_4to2 (
    X ,
    A0,
    A1,
    A2,
    A3,
    S0,
    S1
);

    output X ;
    input  A0;
    input  A1;
    input  A2;
    input  A3;
    input  S0;
    input  S1;

    reg X;

    always @* casez ({A0, A1, A2, A3, S0, S1})
         6'b0???00: X <= 0;
         6'b1???00: X <= 1;
         6'b?0??10: X <= 0;
         6'b?1??10: X <= 1;
         6'b??0?01: X <= 0;
         6'b??1?01: X <= 1;
         6'b???011: X <= 0;
         6'b???111: X <= 1;
         6'b0000??: X <= 0;
         6'b1111??: X <= 1;
         6'b00???0: X <= 0;
         6'b11???0: X <= 1;
         6'b??00?1: X <= 0;
         6'b??11?1: X <= 1;
         6'b0?0?0?: X <= 0;
         6'b1?1?0?: X <= 1;
         6'b?0?01?: X <= 0;
         6'b?1?11?: X <= 1;
    endcase;
endmodule

module sky130_fd_sc_hd__udp_mux_2to1 (
    X ,
    A0,
    A1,
    S
);

    output X ;
    input  A0;
    input  A1;
    input  S ;

    assign X = S ? A1 : A0;
endmodule

module sky130_fd_sc_hd__udp_dff$P_pp$PG$N (
    Q       ,
    D       ,
    CLK     ,
    NOTIFIER,
    VPWR    ,
    VGND
);

    output Q       ;
    input  D       ;
    input  CLK     ;
    input  NOTIFIER;
    input  VPWR    ;
    input  VGND    ;

    reg Q;

    always @(posedge CLK)
        Q <= D;
endmodule


module sky130_fd_sc_hd__udp_dff$PR_pp$PG$N (
    Q       ,
    D       ,
    CLK     ,
    RESET   ,
    NOTIFIER,
    VPWR    ,
    VGND
);

    output Q       ;
    input  D       ;
    input  CLK     ;
    input  RESET   ;
    input  NOTIFIER;
    input  VPWR    ;
    input  VGND    ;

    reg Q;

    always @(posedge CLK, posedge RESET) begin
        if (RESET)
            Q <= 0;
        else
            Q <= D;
    end
endmodule


module sky130_fd_sc_hd__udp_dlatch$P_pp$PG$N (
    Q       ,
    D       ,
    GATE    ,
    NOTIFIER,
    VPWR    ,
    VGND
);

    output Q       ;
    input  D       ;
    input  GATE    ;
    input  NOTIFIER;
    input  VPWR    ;
    input  VGND    ;

    reg Q;

    always @(GATE, D) begin
        if (GATE)
            Q <= D;
    end
endmodule

module sky130_fd_sc_hd__udp_pwrgood_pp$PG (
    UDP_OUT,
    UDP_IN ,
    VPWR   ,
    VGND
);

    output UDP_OUT;
    input  UDP_IN ;
    input  VPWR   ;
    input  VGND   ;

    assign UDP_OUT = UDP_IN;
endmodule

module sky130_fd_sc_hd__udp_pwrgood_pp$G (
    UDP_OUT,
    UDP_IN ,
    VGND
);

    output UDP_OUT;
    input  UDP_IN ;
    input  VGND   ;

    assign UDP_OUT = UDP_IN;
endmodule

module sky130_fd_sc_hd__udp_pwrgood_pp$P (
    UDP_OUT,
    UDP_IN ,
    VPWR
);

    output UDP_OUT;
    input  UDP_IN ;
    input  VPWR   ;

    assign UDP_OUT = UDP_IN;
endmodule
