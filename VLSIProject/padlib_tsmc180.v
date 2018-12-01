//////////////////////////////////////////////////
//////////////////////////////////////////////////

`timescale 1ns/1ps




`celldefine
module pad_in (DataIn, pad);
    input pad;
    output DataIn;
    buf		(DataIn, pad);
endmodule
`endcelldefine


`celldefine
module pad_out (DataOut, pad);
    input DataOut;
    output pad;
    buf		(pad, DataOut);
endmodule
`endcelldefine

`celldefine
module pad_bidirhe (DataIn, DataOut, pad, EN);
    input DataOut, EN;
    inout pad;
    output DataIn;

  //----- when EN is enabled, the signal is propagated from DataOut to pad (outpad)
  assign DataIn = EN ? 1'bz : pad;
  //----- when EN is disabled, the signal is propagated frompad to DataIn (inpad)
  assign pad = EN ? DataOut : 1'bz;
endmodule
`endcelldefine

`celldefine
module pad_vdd (VDD);
    inout VDD;
endmodule
`endcelldefine

`celldefine
module pad_gnd (VSS);
    inout VSS;
endmodule
`endcelldefine

`celldefine
module pad_corner ();
endmodule
`endcelldefine


`celldefine
module pad_ana (pad);
    inout pad;
endmodule
`endcelldefine




