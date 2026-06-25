module apb_slave(apb_if intf);

logic [7:0] mem[0:255];

always_ff @(posedge intf.pclk)

begin

if(!intf.presetn)

begin

for(int i=0;i<256;i++)

mem[i]<=0;

intf.prdata<=0;

end


else if(intf.psel && intf.penable)

begin

if(intf.pwrite)

begin

mem[intf.paddr]<=intf.pwdata;

$display(
"[DUT WRITE] ADDR=%0d DATA=%0d",
intf.paddr,
intf.pwdata
);

end


else

begin

intf.prdata<=mem[intf.paddr];

$display(
"[DUT READ] ADDR=%0d DATA=%0d",
intf.paddr,
mem[intf.paddr]
);

end

end

end

endmodule
