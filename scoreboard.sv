class scoreboard;

mailbox mon2sb;

apb_transaction tr;

logic [7:0] sb_mem[0:255];

function new(mailbox mon2sb);

this.mon2sb=mon2sb;

endfunction


task run();

logic [7:0] expected;

forever

begin

mon2sb.get(tr);

if(tr.write)

begin

sb_mem[tr.addr]=tr.data;

$display(
"[SB STORE] ADDR=%0d DATA=%0d",
tr.addr,
tr.data
);

end

else

begin

expected=sb_mem[tr.addr];

if(expected===tr.data)

$display(
"[SB PASS] ADDR=%0d DATA=%0d",
tr.addr,
tr.data
);

else

$display(
"[SB FAIL] ADDR=%0d EXPECTED=%0d ACTUAL=%0d",
tr.addr,
expected,
tr.data
);

end

end

endtask

endclass
