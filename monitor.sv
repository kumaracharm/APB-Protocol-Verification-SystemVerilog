class apb_monitor;

virtual apb_if vif;

mailbox mon2sb;

function new
(
virtual apb_if vif,
mailbox mon2sb
);

this.vif=vif;
this.mon2sb=mon2sb;

endfunction


task run();

apb_transaction tr;

forever

begin

@(posedge vif.pclk);

if(vif.psel && !vif.penable)

begin

tr=new();

tr.addr=vif.paddr;

tr.write=vif.pwrite;


if(vif.pwrite)

tr.data=vif.pwdata;

else

begin

@(posedge vif.pclk);

#1;

tr.data=vif.prdata;

end


$display(
"[MON] ADDR=%0d DATA=%0d WRITE=%0d",
tr.addr,
tr.data,
tr.write
);

mon2sb.put(tr);

end

end

endtask

endclass
