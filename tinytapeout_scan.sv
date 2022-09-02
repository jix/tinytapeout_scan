module top(input clk_in, data_in, latch_enable_in, scan_select_in);

(* gclk *) wire gclk;

// Count the first few clock cycles.
reg [2:0] counter = 0;
wire ready = counter[2];
wire clk_in_past;
always @(posedge gclk) begin
    clk_in_past <= clk_in;
    if (!ready && clk_in_past != clk_in)
        counter <= counter + 1;
end;

// For the first few clock cycles, assert scan_select_in so the chain for both
// scan_wrapper_one and scan_wrapper_zero has a defined value.
always @* assume (ready || scan_select_in);


wire clk_out_one;
wire data_out_one;
wire latch_enable_out_one;
wire scan_select_out_one;

scan_wrapper_one one (.clk_in(clk_in),
    .clk_out(clk_out_one),
    .data_in(data_in),
    .data_out(data_out_one),
    .latch_enable_in(latch_enable_in),
    .latch_enable_out(latch_enable_out_one),
    .scan_select_in(scan_select_in),
    .scan_select_out(scan_select_out_one),
    .vccd1(1'b1),
    .vssd1(1'b0));


wire clk_out_zero;
wire data_out_zero;
wire latch_enable_out_zero;
wire scan_select_out_zero;

scan_wrapper_zero zero (.clk_in(clk_in),
    .clk_out(clk_out_zero),
    .data_in(data_in),
    .data_out(data_out_zero),
    .latch_enable_in(latch_enable_in),
    .latch_enable_out(latch_enable_out_zero),
    .scan_select_in(scan_select_in),
    .scan_select_out(scan_select_out_zero),
    .vccd1(1'b1),
    .vssd1(1'b0));

wire clk_out_uut;
wire data_out_uut;
wire latch_enable_out_uut;
wire scan_select_out_uut;

`MODULE uut (.clk_in(clk_in),
    .clk_out(clk_out_uut),
    .data_in(data_in),
    .data_out(data_out_uut),
    .latch_enable_in(latch_enable_in),
    .latch_enable_out(latch_enable_out_uut),
    .scan_select_in(scan_select_in),
    .scan_select_out(scan_select_out_uut),
    .vccd1(1'b1),
    .vssd1(1'b0));


// Outputs must match for all 3 modules
(* keep *) wire cmp_clk_out = clk_out_uut == clk_out_one && clk_out_uut == clk_out_zero;
(* keep *) wire cmp_latch_enable_out = latch_enable_out_uut == latch_enable_out_one && latch_enable_out_uut == latch_enable_out_zero;
(* keep *) wire cmp_scan_select_out = scan_select_out_uut == scan_select_out_one && scan_select_out_uut == scan_select_out_zero;

// Output for uut must match either scan_wrapper_one or scan_wrapper_zero
(* keep *) wire cmp_data_out = data_out_uut == data_out_one || data_out_uut == data_out_zero;

// After the first few cycles passed, all comparisons must hold forever.
always @* assert (!ready || cmp_clk_out);
always @* assert (!ready || cmp_data_out);
always @* assert (!ready || cmp_latch_enable_out);
always @* assert (!ready || cmp_scan_select_out);

// Useful to get debug traces, not actually valid for all uuts.
// always @* cover (ready && data_out_uut != data_out_one);
// always @* cover (ready && data_out_uut != data_out_zero);

endmodule
