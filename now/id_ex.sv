
`include"defines.svh"

module id_ex(

	input	logic										clk,
	input logic										rst,

	input logic[5:0]			stall,

	//从译码阶段传递的信息
	input AluOp_t         id_aluop,
	input AluSel_t        id_alusel,
	input Reg_t           id_reg1,
	input Reg_t           id_reg2,
	input RegAddr_t       id_wd,
	input logic                    id_wreg,	
	
	//传递到执行阶段的信息
	output AluOp_t         ex_aluop,
	output AluSel_t        ex_alusel,
	output Reg_t           ex_reg1,
	output Reg_t           ex_reg2,
	output RegAddr_t       ex_wd,
	output logic                    ex_wreg
	
);

	always @ (posedge clk) begin
		if (rst == `RstEnable) begin
			ex_aluop <= `EXE_NOP_OP;
			ex_alusel <= `EXE_RES_NOP;
			ex_reg1 <= `ZeroWord;
			ex_reg2 <= `ZeroWord;
			ex_wd <= `NOPRegAddr;
			ex_wreg <= `WriteDisable;
		end else if(stall[2] == `Stop && stall[3] == `NoStop) begin
			ex_aluop <= `EXE_NOP_OP;
			ex_alusel <= `EXE_RES_NOP;
			ex_reg1 <= `ZeroWord;
			ex_reg2 <= `ZeroWord;
			ex_wd <= `NOPRegAddr;
			ex_wreg <= `WriteDisable;			
		end else if(stall[2] == `NoStop)  begin		
			ex_aluop <= id_aluop;
			ex_alusel <= id_alusel;
			ex_reg1 <= id_reg1;
			ex_reg2 <= id_reg2;
			ex_wd <= id_wd;
			ex_wreg <= id_wreg;		
		end
	end
	
endmodule