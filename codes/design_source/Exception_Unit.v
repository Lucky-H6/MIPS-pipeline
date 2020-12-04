module Exception_Unit(
    input Irq,
    input BadOp,
    output IrqPCSrc,
    output ExceptPCSrc,
    output PCBackup,
    output ExpFlush
);

    assign IrqPCSrc = Irq;
    assign ExceptPCSrc = BadOp;
    assign PCBackup = BadOp;
    assign ExpFlush = BadOp;

endmodule : Exception_Unit
