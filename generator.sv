class generator;

mailbox mbx;

function new(mailbox mbx);

this.mbx=mbx;

endfunction


task run();

apb_transaction tr;

repeat(10)

begin

tr=new();

assert(tr.randomize());

$display(
"[GEN] ADDR=%0d DATA=%0d WRITE=%0d",
tr.addr,
tr.data,
tr.write
);

mbx.put(tr);

end

endtask

endclass
