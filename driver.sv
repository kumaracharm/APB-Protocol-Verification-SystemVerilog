class apb_driver;

virtual apb_if vif;

function new(virtual apb_if vif);

this.vif=vif;

endfunction


task drive(apb_transaction tr);

bit inject_error;

inject_error=($urandom_range(0,4)==0);

@(posedge vif.pclk);

vif.psel<=1;
vif.penable<=0;

vif.paddr<=tr.addr;
vif.pwdata<=tr.data;
vif.pwrite<=tr.write;

@(posedge vif.pclk);

if(inject_error)

begin

$display(
"[DRV] RANDOM PROTOCOL ERROR"
);

vif.psel<=0;
vif.penable<=1;

end

else

begin

vif.penable<=1;

end


@(posedge vif.pclk);

vif.psel<=0;
vif.penable<=0;

endtask

endclass
