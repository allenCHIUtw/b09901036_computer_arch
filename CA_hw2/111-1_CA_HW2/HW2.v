module ALU(
    clk,
    rst_n,
    valid,
    ready,
    mode,
    in_A,
    in_B,
    out
);

    // Definition of ports
    input         clk, rst_n;
    input         valid;
    input  [1:0]  mode; // mode: 0: mulu, 1: divu, 2: shift, 3: avg
    output        ready;
    input  [31:0] in_A, in_B;
    output [63:0] out;

    // Definition of states
    parameter IDLE = 3'd0;
    parameter MUL  = 3'd1;
    parameter DIV  = 3'd2;
    parameter SHIFT = 3'd3;
    parameter AVG = 3'd4;
    parameter OUT  = 3'd5;

    // Todo: Wire and reg if needed
    reg  [ 2:0] state, state_nxt;
    reg  [ 4:0] counter, counter_nxt;
    reg  [63:0] shreg, shreg_nxt;
    reg  [31:0] alu_in, alu_in_nxt;
    reg  [32:0] alu_out;

    // Todo: Instatiate any primitives if needed

    // Todo 5: Wire assignments
    
    // Combinational always block
    // Todo 1: Next-state logic of state machine
    always @(*) begin
        case(state)
            IDLE:
            begin  
                if(valid=0)
                begin state_nxt = IDLE; end
                else 
                begin 
                case(mode)
                   2'b00: begin state_nxt = MUL; end
                   2'b01: begin state_nxt = DIV; end
                   2'b10: begin state_nxt = SHIFT; end
                   2'b11: begin state_nxt = AVG; end
                endcase
            
              state_nxt=MUL;
             end
             MUL :
             begin  
              if(counter!=5'b11111)
              begin 
                counter_nxt=counter+1;
                state_nxt = MUL;
              end
              else
               begin
                   state_nxt =OUT;
               end
             end
             end
             DIV :
             begin  
               
             end
             SHIFT :
             begin  
              
             end
             AVG : 
             begin  
              
             end
            OUT : state_nxt = IDLE;
            default : state_nxt = IDLE;
            end
        endcase
    end
    // Todo 2: Counter
    always @(*)
    // ALU input
    always @(*) begin
        case(state)
            IDLE: begin
                if (valid) alu_in_nxt = in_B;
                else       alu_in_nxt = 0;
            end
            OUT : alu_in_nxt = 0;
            default: alu_in_nxt = alu_in;
        endcase
    end

    // Todo 3: ALU output
    always @(*) begin
       case(state)
       endcase
    end
    // Todo 4: Shift register

    // Todo: Sequential always block
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
        end
        else begin
            state <= state_nxt;
        end
    end

endmodule