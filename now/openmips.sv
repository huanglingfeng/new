`include"defines.svh"

module openmips(

	input	logic										clk,
	input logic										rst,
	output Reg_t out,
 
	input Reg_t           rom_data_i,
	output Reg_t           rom_addr_o,
	output logic                    rom_ce_o
	
);

	InstAddr_t pc;
	InstAddr_t id_pc_i;
	Inst_t id_inst_i;
	
	//��������׶�IDģ��������ID/EXģ�������
	AluOp_t id_aluop_o;
	AluSel_t id_alusel_o;
	Reg_t id_reg1_o;
	Reg_t id_reg2_o;
	logic id_wreg_o;
	RegAddr_t id_wd_o;
	
	//����ID/EXģ��������ִ�н׶�EXģ�������
	AluOp_t ex_aluop_i;
	AluSel_t ex_alusel_i;
	Reg_t ex_reg1_i;
	Reg_t ex_reg2_i;
	logic ex_wreg_i;
	RegAddr_t ex_wd_i;
	
	//����ִ�н׶�EXģ��������EX/MEMģ�������
	logic ex_wreg_o;
	RegAddr_t ex_wd_o;
	Reg_t ex_wdata_o;
	Reg_t ex_hi_o;
	Reg_t ex_lo_o;
	logic ex_whilo_o;

	//����EX/MEMģ��������ô�׶�MEMģ�������
	logic mem_wreg_i;
	RegAddr_t mem_wd_i;
	Reg_t mem_wdata_i;
	Reg_t mem_hi_i;
	Reg_t mem_lo_i;
	logic mem_whilo_i;		

	//���ӷô�׶�MEMģ��������MEM/WBģ�������
	logic mem_wreg_o;
	RegAddr_t mem_wd_o;
	Reg_t mem_wdata_o;
	Reg_t mem_hi_o;
	Reg_t mem_lo_o;
	logic mem_whilo_o;		
	
	//����MEM/WBģ���������д�׶ε�����	
	logic wb_wreg_i;
	RegAddr_t wb_wd_i;
	Reg_t wb_wdata_i;
	Reg_t wb_hi_i;
	Reg_t wb_lo_i;
	logic wb_whilo_i;	
	
	//��������׶�IDģ����ͨ�üĴ���Regfileģ��
  logic reg1_read;
  logic reg2_read;
  Reg_t reg1_data;
  Reg_t reg2_data;
  RegAddr_t reg1_addr;
  RegAddr_t reg2_addr;

	//����ִ�н׶���hiloģ����������ȡHI��LO�Ĵ���
	Reg_t 	hi;
	Reg_t   lo;

	//����ִ�н׶���ex_regģ�飬���ڶ����ڵ�MADD��MADDU��MSUB��MSUBUָ��
	DoubleReg_t hilo_temp_o;
	logic[1:0] cnt_o;
	
	DoubleReg_t hilo_temp_i;
	logic[1:0] cnt_i;

	DoubleReg_t div_result;
	logic div_ready;
	Reg_t div_opdata1;
	Reg_t div_opdata2;
	logic div_start;
	logic div_annul;
	logic signed_div;

	logic[5:0] stall;
	logic stallreq_from_id;	
	logic stallreq_from_ex;
    assign out=wb_wdata_i;
  //pc_reg����
	pc_reg pc_reg0(
		.clk(clk),
		.rst(rst),
		.stall(stall),
		.pc(pc),
		.ce(rom_ce_o)		
			
	);
	
  assign rom_addr_o = pc;

  //IF/IDģ������
	if_id if_id0(
		.clk(clk),
		.rst(rst),
		.stall(stall),
		.if_pc(pc),
		.if_inst(rom_data_i),
		.id_pc(id_pc_i),
		.id_inst(id_inst_i)      	
	);
	
	//����׶�IDģ��
	id id0(
		.rst(rst),
		.pc_i(id_pc_i),
		.inst_i(id_inst_i),

		.reg1_data_i(reg1_data),
		.reg2_data_i(reg2_data),

	  //����ִ�н׶ε�ָ��Ҫд���Ŀ�ļĴ�����Ϣ
		.ex_wreg_i(ex_wreg_o),
		.ex_wdata_i(ex_wdata_o),
		.ex_wd_i(ex_wd_o),

	  //���ڷô�׶ε�ָ��Ҫд���Ŀ�ļĴ�����Ϣ
		.mem_wreg_i(mem_wreg_o),
		.mem_wdata_i(mem_wdata_o),
		.mem_wd_i(mem_wd_o),

		//�͵�regfile����Ϣ
		.reg1_read_o(reg1_read),
		.reg2_read_o(reg2_read), 	  

		.reg1_addr_o(reg1_addr),
		.reg2_addr_o(reg2_addr), 
	  
		//�͵�ID/EXģ�����Ϣ
		.aluop_o(id_aluop_o),
		.alusel_o(id_alusel_o),
		.reg1_o(id_reg1_o),
		.reg2_o(id_reg2_o),
		.wd_o(id_wd_o),
		.wreg_o(id_wreg_o),
		
		.stallreq(stallreq_from_id)		
	);

  //ͨ�üĴ���Regfile����
	regfile regfile1(
		.clk (clk),
		.rst (rst),
		.we	(wb_wreg_i),
		.waddr (wb_wd_i),
		.wdata (wb_wdata_i),
		.re1 (reg1_read),
		.raddr1 (reg1_addr),
		.rdata1 (reg1_data),
		.re2 (reg2_read),
		.raddr2 (reg2_addr),
		.rdata2 (reg2_data)
	);

	//ID/EXģ��
	id_ex id_ex0(
		.clk(clk),
		.rst(rst),
		
		.stall(stall),
		
		//������׶�IDģ�鴫�ݵ���Ϣ
		.id_aluop(id_aluop_o),
		.id_alusel(id_alusel_o),
		.id_reg1(id_reg1_o),
		.id_reg2(id_reg2_o),
		.id_wd(id_wd_o),
		.id_wreg(id_wreg_o),
	
		//���ݵ�ִ�н׶�EXģ�����Ϣ
		.ex_aluop(ex_aluop_i),
		.ex_alusel(ex_alusel_i),
		.ex_reg1(ex_reg1_i),
		.ex_reg2(ex_reg2_i),
		.ex_wd(ex_wd_i),
		.ex_wreg(ex_wreg_i)
	);		
	
	//EXģ��
	ex ex0(
		.rst(rst),
	
		//�͵�ִ�н׶�EXģ�����Ϣ
		.aluop_i(ex_aluop_i),
		.alusel_i(ex_alusel_i),
		.reg1_i(ex_reg1_i),
		.reg2_i(ex_reg2_i),
		.wd_i(ex_wd_i),
		.wreg_i(ex_wreg_i),
		.hi_i(hi),
		.lo_i(lo),

	  .wb_hi_i(wb_hi_i),
	  .wb_lo_i(wb_lo_i),
	  .wb_whilo_i(wb_whilo_i),
	  .mem_hi_i(mem_hi_o),
	  .mem_lo_i(mem_lo_o),
	  .mem_whilo_i(mem_whilo_o),

	  .hilo_temp_i(hilo_temp_i),
	  .cnt_i(cnt_i),
	  .div_result_i(div_result),
	  .div_ready_i(div_ready), 

	  //EXģ��������EX/MEMģ����Ϣ
		.wd_o(ex_wd_o),
		.wreg_o(ex_wreg_o),
		.wdata_o(ex_wdata_o),

		.hi_o(ex_hi_o),
		.lo_o(ex_lo_o),
		.whilo_o(ex_whilo_o),

		.hilo_temp_o(hilo_temp_o),
		.cnt_o(cnt_o),

		.div_opdata1_o(div_opdata1),
		.div_opdata2_o(div_opdata2),
		.div_start_o(div_start),
		.signed_div_o(signed_div),	
		

		.stallreq(stallreq_from_ex)     				
		
	);

  //EX/MEMģ��
  ex_mem ex_mem0(
		.clk(clk),
		.rst(rst),
	  
	  .stall(stall),
	  
		//����ִ�н׶�EXģ�����Ϣ	
		.ex_wd(ex_wd_o),
		.ex_wreg(ex_wreg_o),
		.ex_wdata(ex_wdata_o),
		.ex_hi(ex_hi_o),
		.ex_lo(ex_lo_o),
		.ex_whilo(ex_whilo_o),		

		.hilo_i(hilo_temp_o),
		.cnt_i(cnt_o),	

		//�͵��ô�׶�MEMģ�����Ϣ
		.mem_wd(mem_wd_i),
		.mem_wreg(mem_wreg_i),
		.mem_wdata(mem_wdata_i),
		.mem_hi(mem_hi_i),
		.mem_lo(mem_lo_i),
		.mem_whilo(mem_whilo_i),
				
		.hilo_o(hilo_temp_i),
		.cnt_o(cnt_i)
						       	
	);
	
  //MEMģ������
	mem mem0(
		.rst(rst),
	
		//����EX/MEMģ�����Ϣ	
		.wd_i(mem_wd_i),
		.wreg_i(mem_wreg_i),
		.wdata_i(mem_wdata_i),
		.hi_i(mem_hi_i),
		.lo_i(mem_lo_i),
		.whilo_i(mem_whilo_i),		
	  
		//�͵�MEM/WBģ�����Ϣ
		.wd_o(mem_wd_o),
		.wreg_o(mem_wreg_o),
		.wdata_o(mem_wdata_o),
		.hi_o(mem_hi_o),
		.lo_o(mem_lo_o),
		.whilo_o(mem_whilo_o)		
	);

  //MEM/WBģ��
	mem_wb mem_wb0(
		.clk(clk),
		.rst(rst),

    .stall(stall),

		//���Էô�׶�MEMģ�����Ϣ	
		.mem_wd(mem_wd_o),
		.mem_wreg(mem_wreg_o),
		.mem_wdata(mem_wdata_o),
		.mem_hi(mem_hi_o),
		.mem_lo(mem_lo_o),
		.mem_whilo(mem_whilo_o),		
	
		//�͵���д�׶ε���Ϣ
		.wb_wd(wb_wd_i),
		.wb_wreg(wb_wreg_i),
		.wb_wdata(wb_wdata_i),
		.wb_hi(wb_hi_i),
		.wb_lo(wb_lo_i),
		.wb_whilo(wb_whilo_i)		
									       	
	);

	hilo_reg hilo_reg0(
		.clk(clk),
		.rst(rst),
	
		//д�˿�
		.we(wb_whilo_i),
		.hi_i(wb_hi_i),
		.lo_i(wb_lo_i),
	
		//���˿�1
		.hi_o(hi),
		.lo_o(lo)	
	);
	
	ctrl ctrl0(
		.rst(rst),
	
		.stallreq_from_id(stallreq_from_id),
	
  	//����ִ�н׶ε���ͣ����
		.stallreq_from_ex(stallreq_from_ex),

		.stall(stall)       	
	);
	
		div div0(
		.clk(clk),
		.rst(rst),
	
		.signed_div_i(signed_div),
		.opdata1_i(div_opdata1),
		.opdata2_i(div_opdata2),
		.start_i(div_start),
		.annul_i(1'b0),
	
		.result_o(div_result),
		.ready_o(div_ready)
	);


endmodule