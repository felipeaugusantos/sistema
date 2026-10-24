unit TestController.Faturamento.Impostos.Generic;

interface

uses
  TestFramework,
  System.SysUtils,
  Data.DB,
  untFuncoes,
  untFuncFatTypes,
  UniClientDataSet,
  untTestObjMyCampoTabela,
  Shared.Functions.Configuracoes,
  TestShared.Functions.Conexao.ClientDataSet,
  Faturamento.Impostos.Interfaces.IcmsSt,
  Faturamento.Impostos.Tipos.IcmsSt,
  Shared.Functions.Types,
  Controller.Faturamento.Impostos.Generic,
  Controller.Faturamento.Interfaces.Impostos.IcmsSt,
  Controller.Faturamento.Interfaces.Impostos.IcmsEfetivo,
  Controller.Faturamento.Interfaces.Impostos.FcpDifal,
  Controller.Faturamento.Interfaces.Impostos.Ipi,
  Controller.Faturamento.Tipos.Impostos.Ipi,
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Interfaces.Ipi,
  Faturamento.Impostos.Tipos.Ipi,
  Faturamento.Impostos.Tipos.Model,
  Controller.Faturamento.Tipos.Impostos.IcmsSt,
  Controller.Faturamento.Interfaces.Impostos.Parametros.Comum,
  Controller.Faturamento.Tipos.Impostos.Parametros.Comum,
  Faturamento.Impostos.Interfaces.FcpDifal,
  Faturamento.Impostos.Tipos.FcpDifal;

Type
  TTestControllerFatImpostosGeneric = class(TTestCase)
  Public
    procedure SetUp; override;
    procedure TearDown; override;
  Private

    Const
      LISTA_FORNECEDORES_FILIAL = '00000001,00000009,00000011,00000014,00000015,00000020,'+
                                  '00000030,00000033,00000035,00000036,00000040,00000045,'+
                                  '00000070,00000083,00000137,00000141,00000153,00000221,'+
                                  '00000239,00000310,00000454,00000455,00000520,00000524,'+
                                  '00000529,00000529,00000551,00000588,00000736,00000781,'+
                                  '00000844,00001016,00008171,00008174,00008228,00008231,'+
                                  '00008236,00008504,00008505,00009817,00009819,00009841,'+
                                  '00009849,00009852,00009894,03333333,04444444,15315315,'+
                                  '15415415,50000000,90690600,99992433';
    procedure SetarValoresTabelaECfg(const ATipoDaAbreviacaoFiscal: String);
    procedure PreencherMatrizIcmsSt;
    procedure SetarConfiguracoesIcmsSt;
    procedure SetarValoresModelsIcmsSt;
    procedure SetarValoresModelAbreviacaoIcmsSt(
      const ATipoDaAbreviacaoFiscal: String);

    Var
    FMatItens: TMatrizFechamento;
    FDadosDocumentos : TUniClientDataSet;
    FUltNfCodIte : Array of String;
    FUltNfCodEmp : Array of String;
    FUltNfDtaUlt : Array of String;
    FUltNfNotUlt : Array of String;

    FDocNumDoc : Array of String;
    FDocEspDoc : Array of String;
    FDocCodEmp : Array of String;
    FDocSerie_ : Array of String;
    FDocCodFor : Array of String;
    FDocQtdIte : Array of String;
    FDocDtaEnt : Array of String;
    FDocBaeRet : Array of String;
    FDocVaeRet : Array of String;
    FDocPerRde : Array of String;
    FDocValIcm : Array of String;

    FDocComLiqIpiFreteIvaAbf :Array of String;
    FDocComLiqIpiFreteIva    : Array of String;

    FSemUltNfComLiqIpiFreteIvaAbf : Array of Double;
    FSemUltNfComLiqIpiFreteIva    : Array of Double;

    procedure IniciandoModels(const ATipoDaAbreviacaoFiscal: String);
    procedure ModelCliente;
    procedure ModelEmpresa;
    procedure ModelFornecedor;
    procedure ModelProduto;
    procedure ModelAbreviacaoIcms(const ATipoDaAbreviacaoFiscal: String);
    procedure SetarDataSetDocumentos;
    procedure SetarConfiguracoes;
    procedure CriarDataSetDocumentos;
    procedure DadosDocumentoApenasUmItem_Open;
    procedure SetarListaFornecedores;


  Published

    {
    function Ipi: IImpostosFatControllerIpi;
    function IcmsSt: IImpostosFatControllerIcmsSt;
    function IcmsEfetivo : IImpostosFatControllerIcmsEfetivo;
    function FcpDifal: IImpostosFatControllerFcpDifal;

    function SetarMatrizItens(var AMatItens: TMatrizFechamento): IImpostosFatControllerGeneric;
    function SetarPosicaoMatriz(const APosicao: Integer): IImpostosFatControllerGeneric;
    function SetarDadosFechamento(var ADadosFechamento: TDadosFechamento): IImpostosFatControllerGeneric;}

    // TImpostosFatControllerGeneric

    procedure TestIpi;
    procedure TestIcmsSt;
    procedure TestIcmsEfetivo;
    procedure TestFcpDifal;

//    procedure TestSetarMatrizItens;
//    procedure TestSetarPosicaoMatriz;
//    procedure TestSetarDadosFechamento;
  end;



implementation


{ TTestControllerFatImpostosGeneric }

procedure TTestControllerFatImpostosGeneric.CriarDataSetDocumentos;
begin
  FDadosDocumentos := TUniClientDataSet.Create(Nil);
  FDadosDocumentos.Close;

  FDadosDocumentos.FieldDefs.Clear;
  FDadosDocumentos.FieldDefs.add('DET_NUMDOC',ftString,100);
  FDadosDocumentos.FieldDefs.add('DET_ESPDOC',ftString,100);

  FDadosDocumentos.FieldDefs.add('DET_CODEMP',ftString,100);
  FDadosDocumentos.FieldDefs.add('DET_SERIE_',ftString,100);
  FDadosDocumentos.FieldDefs.add('DET_CODFOR',ftString,100);

  FDadosDocumentos.FieldDefs.add('DET_QTDITE',ftString,100);
  FDadosDocumentos.FieldDefs.add('DET_DTAENT',ftString,100);
  FDadosDocumentos.FieldDefs.add('DET_BAERET',ftFloat);

  FDadosDocumentos.FieldDefs.add('DET_VAERET',ftFloat);
  FDadosDocumentos.FieldDefs.add('DET_PERRED',ftFloat);
  FDadosDocumentos.FieldDefs.add('DET_VALICM',ftFloat);

  FDadosDocumentos.FieldDefs.add('COMLIQ_IPI_FRETE_IVA_ABF',ftFloat);
  FDadosDocumentos.FieldDefs.add('COMLIQ_IPI_FRETE_IVA',ftFloat);

  FDadosDocumentos.FieldDefs.add('ITE_CODITE', ftString,100);
  FDadosDocumentos.FieldDefs.add('ITE_CODEMP', ftString,100);
  FDadosDocumentos.FieldDefs.add('ITE_DTAULT', ftString,100);
  FDadosDocumentos.FieldDefs.add('ITE_NOTULT', ftString,100);

  FDadosDocumentos.FieldDefs.add('BASE'    , ftFloat);
  FDadosDocumentos.FieldDefs.add('ALIQUOTA', ftFloat);
  FDadosDocumentos.FieldDefs.add('VALOR'   , ftFloat);

  FDadosDocumentos.Params.CreateParam(ftstring,'NUMDOC',ptinput);
  FDadosDocumentos.Params.CreateParam(ftstring,'ESPDOC',ptinput);
  FDadosDocumentos.Params.CreateParam(ftstring,'CODEMP',ptinput);
  FDadosDocumentos.Params.CreateParam(ftstring,'SERIE_',ptinput);
  FDadosDocumentos.Params.CreateParam(ftstring,'CODFOR',ptinput);
  FDadosDocumentos.Params.CreateParam(ftstring,'CODITE',ptinput);
  FDadosDocumentos.Params.CreateParam(ftFloat ,'COMLIQ',ptinput);

  FDadosDocumentos.CreateDataSet;

end;

procedure TTestControllerFatImpostosGeneric.DadosDocumentoApenasUmItem_Open;
begin
  CriarDataSetDocumentos;

  SetLength(FUltNfCodIte, 1);
  SetLength(FUltNfCodEmp, 1);
  SetLength(FUltNfDtaUlt, 1);
  SetLength(FUltNfNotUlt, 1);

  FUltNfCodIte[0] := '40304';
  FUltNfCodEmp[0] := '112';
  FUltNfDtaUlt[0] := '2019-04-09';
  FUltNfNotUlt[0] := '000000303030NF0121  00000003';

  SetLength(FSemUltNfComLiqIpiFreteIva, 1);
  SetLength(FSemUltNfComLiqIpiFreteIvaAbf, 1);

  FSemUltNfComLiqIpiFreteIva[0]    := 27;
  FSemUltNfComLiqIpiFreteIvaAbf[0] := 150;

  SetLength(FDocNumDoc,1);
  SetLength(FDocEspDoc,1);
  SetLength(FDocCodEmp,1);
  SetLength(FDocSerie_,1);
  SetLength(FDocCodFor,1);
  SetLength(FDocQtdIte,1);
  SetLength(FDocDtaEnt,1);
  SetLength(FDocBaeRet,1);
  SetLength(FDocVaeRet,1);
  SetLength(FDocPerRde,1);
  SetLength(FDocValIcm,1);
  SetLength(FDocComLiqIpiFreteIvaAbf,1);
  SetLength(FDocComLiqIpiFreteIva,1);

  FDocNumDoc[0] := '000011200876';
  FDocEspDoc[0] := 'NF';
  FDocCodEmp[0] := '112';
  FDocSerie_[0] := '001';
  FDocCodFor[0] := '';
  FDocQtdIte[0] := '1';
  FDocDtaEnt[0] := '2019-11-06';
  FDocBaeRet[0] := '0';
  FDocVaeRet[0] := '0';
  FDocPerRde[0] := '0';
  FDocValIcm[0] := '0';
  FDocComLiqIpiFreteIvaAbf[0]:='27';
  FDocComLiqIpiFreteIva[0]   :='150';

//  ZerarValoresMatriz;

  SetarDataSetDocumentos;

end;

procedure TTestControllerFatImpostosGeneric.IniciandoModels(
  const ATipoDaAbreviacaoFiscal: String);
begin
  ModelCliente;
  ModelEmpresa;
  ModelProduto;
  ModelFornecedor;
  ModelAbreviacaoIcms(ATipoDaAbreviacaoFiscal);
end;

procedure TTestControllerFatImpostosGeneric.ModelAbreviacaoIcms(
  const ATipoDaAbreviacaoFiscal: String);
begin
  objMyCampoTabelaAdd.Add('ABF_ALQICM' + ATipoDaAbreviacaoFiscal, 18);
  objMyCampoTabelaAdd.Add('ABF_ALQRET' + ATipoDaAbreviacaoFiscal, 18);
  objMyCampoTabelaAdd.Add('ABF_BASICM' + ATipoDaAbreviacaoFiscal, 100);
  objMyCampoTabelaAdd.Add('ABF_CODSIT' + ATipoDaAbreviacaoFiscal, '000');

  objMyCampoTabelaAdd.Add('ABF_CAL_ST_SAI_CCO','666');

  objMyCampoTabelaAdd.Add('ABF_IVA_ST'+ ATipoDaAbreviacaoFiscal, '15');
  objMyCampoTabelaAdd.Add('ABF_BASRET'+ ATipoDaAbreviacaoFiscal, '060');
  objMyCampoTabelaAdd.Add('ABF_CAL_ST', '666');
  objMyCampoTabelaAdd.Add('ABF_CODABF', '040');
  objMyCampoTabelaAdd.Add('ABF_ALQFCP'+ ATipoDaAbreviacaoFiscal, '090');


  objMyCampoTabelaAdd.Add('ABF_ALQICM'+ ATipoDaAbreviacaoFiscal, 18);
  objMyCampoTabelaAdd.Add('ABF_BASICM'+ ATipoDaAbreviacaoFiscal, 100);
  objMyCampoTabelaAdd.Add('ABF_CODSIT'+ ATipoDaAbreviacaoFiscal, '010');
  objMyCampoTabelaAdd.Add('ABF_ALQRET'+ ATipoDaAbreviacaoFiscal, 12);
  objMyCampoTabelaAdd.Add('ABF_IVA_ST'+ ATipoDaAbreviacaoFiscal, 15);
  objMyCampoTabelaAdd.Add('ABF_BASRET'+ ATipoDaAbreviacaoFiscal, 60);
  objMyCampoTabelaAdd.Add('ABF_CODABF'+ ATipoDaAbreviacaoFiscal, '040');
  objMyCampoTabelaAdd.Add('ABF_ALQFCP'+ ATipoDaAbreviacaoFiscal, 90);
  objMyCampoTabelaAdd.Add('ABF_CAL_ST'+ ATipoDaAbreviacaoFiscal, '666');
  objMyCampoTabelaAdd.Add('ABF_ALQIED'+ ATipoDaAbreviacaoFiscal, 18);
  objMyCampoTabelaAdd.Add('ABF_BASDOR'+ ATipoDaAbreviacaoFiscal, 30);
  objMyCampoTabelaAdd.Add('ABF_BASDDS'+ ATipoDaAbreviacaoFiscal, 20);
  objMyCampoTabelaAdd.Add('ABF_ALQEFO'+ ATipoDaAbreviacaoFiscal, 14);
end;

procedure TTestControllerFatImpostosGeneric.ModelCliente;
CONST
  EMPCLI_FIL = '00000002,00000003,00000007,00000010,00000014,00000048,'+
               '00000112,00000153,00000229,00000268,00000333,00000612,'+
               '00000777,00000938,00000950,00002510,00002817,00002818,'+
               '00003119,00003244,00006465,00007812,00008011,00008800,'+
               '00008801,00023603,00023613,00023614,00044444,00222222,'+
               '04444444,10152708,12345678,12345678,15315315,15415415,'+
               '50000001,90090005,98991177,99990008,99990031,99990036,'+
               '99990049';
begin
  objMyCampoTabelaAdd.Add('CLI_SITIPI', 'T');
  objMyCampoTabelaAdd.Add('CLI_ZONFRA', 'N');
  objMyCampoTabelaAdd.Add('CLI_SUFRAM', 'N');
  objMyCampoTabelaAdd.Add('CLI_DESZON', 'N');
  objMyCampoTabelaAdd.Add('CLI_ORGPUB', 'N');
  objMyCampoTabelaAdd.Add('CLI_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('CLI_CONSUM', 'N');
  objMyCampoTabelaAdd.Add('CLI_CODATI', '002');
  objMyCampoTabelaAdd.Add('CLI_REGFIS', '1');
  objMyCampoTabelaAdd.Add('CLI_I_E_S_', '105006071117');
  objMyCampoTabelaAdd.Add('CLI_MICEMP', 'N');
  objMyCampoTabelaAdd.Add('CLI_CALICM', 'N');
  objMyCampoTabelaAdd.Add('CLI_INDCOM', 'C');
  objMyCampoTabelaAdd.Add('CLI_IVAESP', 0);
  objMyCampoTabelaAdd.Add('CLI_IVASIM', 0);
  objMyCampoTabelaAdd.Add('CLI_IVANAC', 0);
  objMyCampoTabelaAdd.Add('CLI_DESPIS', 'N');

  objMyCampoTabelaAdd.Add('ATI_CODATI', '004');

  objMyCampoTabelaAdd.Add('COUNT(*)', 0);

  objMyCampoTabelaAdd.Add('ENT_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('ENT_COIBGE', '3543402');

  objMyCampoTabelaAdd.Add('CLI_SIBICM', 'N');
  objMyCampoTabelaAdd.Add('CLI_STREES', 'N');
  objMyCampoTabelaAdd.Add('CLI_REDICM', 0);
  objMyCampoTabelaAdd.Add('CLI_DIF_ST', 'N');
  objMyCampoTabelaAdd.Add('CLI_ORPURD', 'N');

  objMyCampoTabelaAdd.Add('CONSUM', 'N');
  objMyCampoTabelaAdd.Add('PRORUR','N');
  objMyCampoTabelaAdd.Add('MICEMP','N');
  objMyCampoTabelaAdd.Add('INDUST','N');
  objMyCampoTabelaAdd.Add('REGTRI', 'P');

  objMyCampoTabelaAdd.Add('CLI_BENREI','N');
  objMyCampoTabelaAdd.Add('CLI_ICMREI','S');

  objMyCampoTabelaAdd.Add('CLI_PRORUR','N');
  objMyCampoTabelaAdd.Add('CLI_IESUNI','');
  objMyCampoTabelaAdd.Add('CLI_ORPUDF','N');
  objMyCampoTabelaAdd.Add('CODATI', '002');

  objMyCampoTabelaAdd.Add('GROUP_CONCAT(EMP_CLIFIL)', EMPCLI_FIL);

end;

procedure TTestControllerFatImpostosGeneric.ModelEmpresa;
begin
  objMyCampoTabelaAdd.Add('EMP_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('EMP_COIBGE', '3543402');
end;

procedure TTestControllerFatImpostosGeneric.ModelFornecedor;
begin
  objMyCampoTabelaAdd.Add('FOR_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('FOR_I_E_S_', '');
end;

procedure TTestControllerFatImpostosGeneric.ModelProduto;
begin
  objMyCampoTabelaAdd.Add('ITE_IPISAI', 0);
  objMyCampoTabelaAdd.Add('ITE_ITECCR', 'N');
  objMyCampoTabelaAdd.Add('ITEGER_CODABF', '004');
  objMyCampoTabelaAdd.Add('CADITE_CODABF', '002');
  objMyCampoTabelaAdd.Add('ITEGER_IMPDIR', 'N');
  objMyCampoTabelaAdd.Add('CADITE_IMPDIR', 'N');
  objMyCampoTabelaAdd.Add('ITE_UTIAMP', 'S');

  objMyCampoTabelaAdd.Add('CADITE_IMPDIR', 'N');
  objMyCampoTabelaAdd.Add('ITEGER_IMPDIR', 'N');

  objMyCampoTabelaAdd.Add('CADITE_INDREV','R');
  objMyCampoTabelaAdd.Add('ITEGER_INDREV','R');
end;

procedure TTestControllerFatImpostosGeneric.SetarConfiguracoes;
Const
  CLASSIFICACAO_VENDA = '110121011403240311022102141'+
                        '124112103291123531353590919'+
                        '09193219112401111719212921';
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NORMATIVA_48_ESTORNO_ICMS, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NORMATIVA_48_ICMS_EFETIVO, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_IMPORTACAO_DIRETA_PRODUTOS, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_INDUSTRIALIZACAO_OU_REVENDA, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_VENDA_PRESENCIAL_UTILIZAR_CFOP, 'D');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_DECRETO_5141_2001_REDUCAO_33_33_RICM_PR, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NFCE, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_DISTRIBUIDORA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_COMPRA, CLASSIFICACAO_VENDA);
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
end;

procedure TTestControllerFatImpostosGeneric.SetarDataSetDocumentos;
Var
  LContador : Integer;
begin
  For LContador := Low(FDocNumDoc) To High(FDocNumDoc) Do
  begin
    FDadosDocumentos.Append;
    FDadosDocumentos.FieldByName('DET_NUMDOC').AsString := FDocNumDoc[LContador];
    FDadosDocumentos.FieldByName('DET_ESPDOC').AsString := FDocEspDoc[LContador];
    FDadosDocumentos.FieldByName('DET_CODEMP').AsString := FDocCodEmp[LContador];

    FDadosDocumentos.FieldByName('DET_SERIE_').AsString := FDocSerie_[LContador];
    FDadosDocumentos.FieldByName('DET_CODFOR').AsString := FDocCodFor[LContador];
    FDadosDocumentos.FieldByName('DET_QTDITE').AsString := FDocQtdIte[LContador];
    FDadosDocumentos.FieldByName('DET_DTAENT').AsString := FDocDtaEnt[LContador];

    FDadosDocumentos.FieldByName('DET_BAERET').AsString := FDocBaeRet[LContador];
    FDadosDocumentos.FieldByName('DET_VAERET').AsString := FDocVaeRet[LContador];
    FDadosDocumentos.FieldByName('DET_PERRED').AsString := FDocPerRde[LContador];
    FDadosDocumentos.FieldByName('DET_VALICM').AsString := FDocValIcm[LContador];

    FDadosDocumentos.FieldByName('COMLIQ_IPI_FRETE_IVA_ABF').AsFloat := StrToFloat(FDocComLiqIpiFreteIvaAbf[LContador]);
    FDadosDocumentos.FieldByName('COMLIQ_IPI_FRETE_IVA').AsFloat     := StrToFloat(FDocComLiqIpiFreteIva[LContador]);

    FDadosDocumentos.FieldByName('ITE_CODITE').AsString := FUltNfCodIte[LContador];
    FDadosDocumentos.FieldByName('ITE_CODEMP').AsString := FUltNfCodEmp[LContador];
    FDadosDocumentos.FieldByName('ITE_DTAULT').AsString := FUltNfDtaUlt[LContador];
    FDadosDocumentos.FieldByName('ITE_NOTULT').AsString := FUltNfNotUlt[LContador];

    FDadosDocumentos.FieldByName('BASE'    ).AsFloat := 100;
    FDadosDocumentos.FieldByName('ALIQUOTA').AsFloat := 18;
    FDadosDocumentos.FieldByName('VALOR'   ).AsFloat := 18;

    FDadosDocumentos.Post;

  end;

  FUQuery := FDadosDocumentos;
end;

procedure TTestControllerFatImpostosGeneric.SetarListaFornecedores;
begin
  objMyCampoTabelaAdd.Add('GROUP_CONCAT(EMP_FORFIL)', LISTA_FORNECEDORES_FILIAL);
end;

procedure TTestControllerFatImpostosGeneric.SetUp;
begin
  inherited;

end;

procedure TTestControllerFatImpostosGeneric.TearDown;
begin
  inherited;

end;

procedure TTestControllerFatImpostosGeneric.TestFcpDifal;
Var
  LRecDifalFCP   : TRecDifalFCP;
  LMatFechamento : Array Of TDadosFechamento;
//  LMatFechamento : TMatrizFechamento;
  ReturnValue    : IResultadoCalculoFcpDifalFinal;
begin

  SetarValoresTabelaECfg('_SAI_CNC');

  SetLength(LMatFechamento, Length(LMatFechamento) + 1);
  LMatFechamento[0].strIteAbf   := '00001';
  LMatFechamento[0].strCodAbf   := '004';
  LMatFechamento[0].strCodSit   := '000';
  LMatFechamento[0].fltBasIcm   := 100;
  LMatFechamento[0].strDocDev   := '';
  LMatFechamento[0].strCodFis   := '';
  LMatFechamento[0].recDifalFCP := LRecDifalFCP;
  LMatFechamento[0].strIndRev   := 'R';
  LMatFechamento[0].strClaFis   := '5402';
  LMatFechamento[0].strEntFut   := 'N';
  LMatFechamento[0].strDocDev   := '';
  LMatFechamento[0].strEspDev   := '';
  LMatFechamento[0].strEmpDev   := '';
  LMatFechamento[0].strCodIte   := '45350';
  LMatFechamento[0].fltQtdIte   := 1;
  LMatFechamento[0].opcINFesp   := opcVazio;
  LMatFechamento[0].fltValRet   := 100;
  LMatFechamento[0].fltAlqIcm   := 100;
  LMatFechamento[0].fltBasRet   := 10;
  LMatFechamento[0].fltValIpi   := 10;
  LMatFechamento[0].fltValFre   := 10;
  LMatFechamento[0].fltTotIte   := 10;
  LMatFechamento[0].fltDesEsp   := 10;
  LMatFechamento[0].fltDesAce   := 10;
  LMatFechamento[0].fltBas__S   := 10;

  SetImpostosFatParametrosComumFcpDifal(
    TImpostosFatParametrosComumFcpDifal.New
      .CodigoDoCliente('10001000')
      .SequencialEnderecoEntrega('')
      .VendaPresencial(false)
      .OpcaoDoDocumento('VN')
      .CodigoDoFornecedor('000000001')
      .NotaComplementoFornecedor(False)
      .NotaEspecialFornecedor(False)
      .ClienteConsumidorFinal(False)
      .ParametrosClienteConsumidor(Nil)
      .TipoDaAbreviacaoFiscal('_SAI_CNC')
      .ClienteFilial(false)
      .DiferencaFCPST(False)
      .CodigoDaEmpresa('777')
      .CodigoDaEmpresaTE('')
      .ClienteIndustria(false)
      .ClassificacaoFiscalRecebimentoGarantia('')
      .AliquotaFCPST(0)
      .BaixaDeEntregaFutura(False)
      .EspecieDoDocumento('VN'));

  ReturnValue :=
    TImpostosFatControllerGeneric.New
     .SetarDadosFechamento(LMatFechamento[0])
     .SetarPosicaoMatriz(0)
     .FcpDifal.CalcularValorFcpDifalFinal;


  CheckTrue
  ( ( ReturnValue.BaseDestino = 0 ) And
    ( ReturnValue.IcmsDestino = 0)  And
    ( ReturnValue.IcmsOrigem = 0)   And
    ( ReturnValue.AlqInterestadualCalc = 12)    And
    ( ReturnValue.RecordDifalFCP.fltAlDifa = 0) And
    ( ReturnValue.RecordDifalFCP.fltDifDes = 0) And
    ( ReturnValue.RecordDifalFCP.fltDifOri = 0) And
    ( ReturnValue.RecordDifalFCP.fltValFcp = 0) And
    ( ReturnValue.RecordDifalFCP.fltPerFcp = 0) And
    ( ReturnValue.RecordDifalFCP.fltAlqIne = 0) And
    ( ReturnValue.RecordDifalFCP.fltAlqUfd = 0) And
    ( ReturnValue.RecordDifalFCP.fltBcuFde = 0) And
    ( ReturnValue.RecordDifalFCP.fltPerPar = 0) And
    ( ReturnValue.RecordDifalFCP.fltBasFcp = 0) And
    ( ReturnValue.RecordDifalFCP.blnGrvInf = false));


end;

procedure TTestControllerFatImpostosGeneric.SetarValoresTabelaECfg(Const ATipoDaAbreviacaoFiscal : String);
begin

  objMyCampoTabelaAdd.Add('CLI_ORGPUB', 'S');
  objMyCampoTabelaAdd.Add('EMP_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('EMP_COIBGE', '3543402');
  objMyCampoTabelaAdd.Add('CLI_ESTADO', 'SP');

  objMyCampoTabelaAdd.Add('ABF_ALQICM', 18);
  objMyCampoTabelaAdd.Add('ABF_ALQRET', 18);
  objMyCampoTabelaAdd.Add('ABF_BASICM', 100);
  objMyCampoTabelaAdd.Add('ABF_CODSIT', '000');

  objMyCampoTabelaAdd.Add('ABF_CAL_ST','666');
  objMyCampoTabelaAdd.Add('ATI_CODATI', '001');

  objMyCampoTabelaAdd.Add('ABF_IVA_ST' + ATipoDaAbreviacaoFiscal, '15');
  objMyCampoTabelaAdd.Add('ABF_BASRET' + ATipoDaAbreviacaoFiscal, '060');
  objMyCampoTabelaAdd.Add('ABF_CAL_ST' + ATipoDaAbreviacaoFiscal, '666');
  objMyCampoTabelaAdd.Add('ABF_CODABF' + ATipoDaAbreviacaoFiscal, '040');
  objMyCampoTabelaAdd.Add('ABF_ALQFCP' + ATipoDaAbreviacaoFiscal, '090');
  objMyCampoTabelaAdd.Add('ABF_ALQIED' + ATipoDaAbreviacaoFiscal, 17);
  objMyCampoTabelaAdd.Add('ABF_BASDOR' + ATipoDaAbreviacaoFiscal, 30);
  objMyCampoTabelaAdd.Add('ABF_BASDDS' + ATipoDaAbreviacaoFiscal, 20);
  objMyCampoTabelaAdd.Add('ABF_ALQEFO' + ATipoDaAbreviacaoFiscal, 12);

  objMyCampoTabelaAdd.Add('ABF_ALQICM' + ATipoDaAbreviacaoFiscal, 18);
  objMyCampoTabelaAdd.Add('ABF_ALQRET' + ATipoDaAbreviacaoFiscal, 18);
  objMyCampoTabelaAdd.Add('ABF_BASICM' + ATipoDaAbreviacaoFiscal, 100);
  objMyCampoTabelaAdd.Add('ABF_CODSIT' + ATipoDaAbreviacaoFiscal, '000');

  objMyCampoTabelaAdd.Add('ABF_CAL_ST' + ATipoDaAbreviacaoFiscal,'666');

  objMyCampoTabelaAdd.Add('ABF_CAL_ST_SAI_CCO','666');

  objMyCampoTabelaAdd.Add('ABF_IVA_ST'+ ATipoDaAbreviacaoFiscal, '15');
  objMyCampoTabelaAdd.Add('ABF_BASRET'+ ATipoDaAbreviacaoFiscal, '060');
  objMyCampoTabelaAdd.Add('ABF_CAL_ST', '666');
  objMyCampoTabelaAdd.Add('ABF_CODABF', '040');
  objMyCampoTabelaAdd.Add('ABF_ALQFCP'+ ATipoDaAbreviacaoFiscal, '090');
  objMyCampoTabelaAdd.Add('ABF_ALQIED'+ ATipoDaAbreviacaoFiscal, 17);
  objMyCampoTabelaAdd.Add('ABF_BASDOR'+ ATipoDaAbreviacaoFiscal, 30);
  objMyCampoTabelaAdd.Add('ABF_BASDDS'+ ATipoDaAbreviacaoFiscal, 20);
  objMyCampoTabelaAdd.Add('ABF_ALQEFO'+ ATipoDaAbreviacaoFiscal, 12);

  objMyCampoTabelaAdd.Add('FISJUR', 'F');
  objMyCampoTabelaAdd.Add('I_E_S_', '12345678');
  objMyCampoTabelaAdd.Add('CONSUM', 'S');
  objMyCampoTabelaAdd.Add('CODATI', '002');
  objMyCampoTabelaAdd.Add('PRORUR', 'N');
  objMyCampoTabelaAdd.Add('MICEMP', 'N');
  objMyCampoTabelaAdd.Add('REGTRI', 'N');
  objMyCampoTabelaAdd.Add('INDUST', 'C');
  objMyCampoTabelaAdd.Add('CLI_CGCCPF', 2);

  objMyCampoTabelaAdd.Add('GROUP_CONCAT(EMP_CLIFIL)', '00000002,00000003,00000007,00000010,00000014,00000048');

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERFIL_ICMS_CCO_CONTRIBUINTE_CONSUMIDOR_CALCULO_NORMAL_E_CALCULO_POR_DENTRO, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_LEGISLACAO_AMPARA_VENDA_PARA_OS_ESTADOS_MG_RS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_FRETE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_IMPORTACAO_DIRETA_PRODUTOS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_DISTRIBUIDORA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NFCE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_DE_VENDA, '5204');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_DECRETO_5141_2001_REDUCAO_33_33_RICM_PR, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_DECRETO_REDUCAO_BASE_IMPOSTOS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DEDUZIR_DESCONTO_ICMS_ZONA_FRANCA_BASE_CALCULO_ST_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CAMPO_PRECO_DECRETO_44498_2013_REDUCAO_BASE_CALCULO_IMPOSTOS, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERCENTUAL_MINIMO_DECRETO_44498_2013_REDUCAO_BASE_CALCULO_IMPOSTOS, '2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOMENTE_PARA_NAO_CONSUMIDOR_FINAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_REDUCAO_BASE_CALCULO_SUBSTITUICAO_TRIBUTARIA_NA_VENDA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_DESPESAS_ACESSORIA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DIRETORIO_PARA_OPCOES_FISCAIS_INI, '');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_VENDA_FORA_ESTADO_NAO_CONTRIBUINTE_TRIBUTAR_ALIQUOTA_INTERNA_ESTADO, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ISENCAO_ICMS_VENDAS_ZONA_FRANCA_SOMENTE_PARA_PRODUTOS_NACIONAIS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_MENSAGEM_IMPOSTO_RETIDO_INDUSTRIA_MODELO_CALCULO_SUBST_OPERACOES_PROPRIAS, '2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_INDUSTRIALIZACAO_OU_REVENDA, '1');

end;


procedure TTestControllerFatImpostosGeneric.TestIcmsEfetivo;
var
  LParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor;
  LMatrizResultado             : TMatrizFechamentoIcmsEfetivo;
  ReturnValue                  : TMatrizFechamentoIcmsEfetivo;
//  FMatItens                    : TMatrizFechamento;
begin
  IniciandoModels('_SAI_NCO');

  SetarConfiguracoes;

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NORMATIVA_48_ESTORNO_ICMS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NORMATIVA_48_ICMS_EFETIVO, 'S');

  SetarListaFornecedores;

	DadosDocumentoApenasUmItem_Open;

  SetLength(FMatItens, 1);
  FMatItens[0].strIdePro := 'NOR';
  FMatItens[0].strCodFis := '060';
  FMatItens[0].strCodSit := '060';
  FMatItens[0].strCodIte := '10992';
  FMatItens[0].strClaFis := '5405';
  FMatItens[0].intOrdem  := 1;
  FMatItens[0].strNotUlt := '';
  FMatItens[0].fltTotIte := 100.00;
  FMatItens[0].fltAlqIcm := 12;
  FMatItens[0].fltQtdIte := 1;
  FMatItens[0].opcINFesp := opcVazio;

  LParametrosClienteConsumidor :=
    TParametrosFaturamentoImpostosClienteConsumidor.New
      .ClienteEstado('SP')
      .ClienteFisicoOuJuridico('F')
      .ClienteInscricaoEstadual('35487586810')
      .ClienteAtividade('')
      .CalcularDescontoIcmsOrgaoPublico(false);

  SetImpostosFatParametrosComum(
    TImpostosFatParametrosComum.New
      .NotaComplementoFornecedor(false)
      .NotaEspecialFornecedor(false)
      .CodigoDoFornecedor('00007083')
      .ParametrosClienteConsumidor(LParametrosClienteConsumidor)
      .CodigoDoCliente('00007083')
      .ClienteConsumidorFinal(false)
      .CodigoDaEmpresa('112')
      .SequencialEnderecoEntrega('')
      .VendaPresencial(true)
      .EspecieDoDocumento('NF')
      .DesmembrarNotaProdutosServicos(false)
      .OpcaoDoDocumento('VN')
      .DesmembrarMeiaNotaComNotaNormal(false)
      .BaixaDeEntregaFutura(false)
      .EntregaFutura(false));

  ReturnValue :=
    TImpostosFatControllerGeneric.New
     .SetarMatrizItens(FMatItens)
     .SetarPosicaoMatriz(0)
     .IcmsEfetivo.CalcularValorIcmsEfetivo;



  SetLength(LMatrizResultado,1);
  LMatrizResultado[0].strNotUlt := '';
  LMatrizResultado[0].fltPICMEF := 0;
  LMatrizResultado[0].fltBICMEF := 0;
  LMatrizResultado[0].fltAICMEF := 0;
  LMatrizResultado[0].fltVICMEF := 0;
  LMatrizResultado[0].fltSICMEF := 0;
  LMatrizResultado[0].fltBSTANT := 150;
  LMatrizResultado[0].fltVSTANT := 27;

  CheckTrue(
    (ReturnValue[0].strNotUlt = LMatrizResultado[0].strNotUlt )and
    (ReturnValue[0].fltPICMEF = LMatrizResultado[0].fltPICMEF) and
    (ReturnValue[0].fltBICMEF = LMatrizResultado[0].fltBICMEF) and
    (ReturnValue[0].fltAICMEF = LMatrizResultado[0].fltAICMEF) and
    (ReturnValue[0].fltVICMEF = LMatrizResultado[0].fltVICMEF) and
    (ReturnValue[0].fltSICMEF = LMatrizResultado[0].fltSICMEF) and
    (ReturnValue[0].fltBSTANT = LMatrizResultado[0].fltBSTANT) and
    (ReturnValue[0].fltVSTANT = LMatrizResultado[0].fltVSTANT));
end;


procedure TTestControllerFatImpostosGeneric.PreencherMatrizIcmsSt;
begin
  SetLength(FMatItens, Length(FMatItens) + 1);

  FMatItens[0].strCodIte := '40294';
  FMatItens[0].opcINFesp := opcVazio;
  FMatItens[0].strEntFut := 'N';
  FMatItens[0].fltTotIte := 150;
  FMatItens[0].fltValFre := 0;
  FMatItens[0].fltDesAce := 0;
  FMatItens[0].fltDesEsp := 0;
  FMatItens[0].strCodFor := '';
  FMatItens[0].strClaFis := '5102';
//  FMatItens[0].strCodSit := '000';
  FMatItens[0].strCodSit := '610';

  FMatItens[0].fltAlq__S := 0;
  FMatItens[0].fltUniTar := 50;
  FMatItens[0].fltQtdIte := 3;
  FMatItens[0].strEspDev := '';
  FMatItens[0].blnMeiaNotaFatorExpedicao:= false;
  FMatItens[0].fltPreCus := 0;
  FMatItens[0].fltPreUlt := 0;
  FMatItens[0].fltImpUlt := 0;
  FMatItens[0].recDifalFCP.fltPerFcp := 0;
  FMatItens[0].recDifalFCP.fltValFcp := 0;
  FMatItens[0].strIdePro := 'NOR';
  FMatItens[0].fltPrcTin := 0;
  FMatItens[0].fltCusIte := 0;
  FMatItens[0].strClaIpi := '';
  FMatItens[0].strRICMPR := 'N';

end;

procedure TTestControllerFatImpostosGeneric.SetarConfiguracoesIcmsSt;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERFIL_ICMS_CCO_CONTRIBUINTE_CONSUMIDOR_CALCULO_NORMAL_E_CALCULO_POR_DENTRO, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_LEGISLACAO_AMPARA_VENDA_PARA_OS_ESTADOS_MG_RS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_DISTRIBUIDORA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NFCE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_DE_VENDA, '5204');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_DECRETO_REDUCAO_BASE_IMPOSTOS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DEDUZIR_DESCONTO_ICMS_ZONA_FRANCA_BASE_CALCULO_ST_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOMENTE_PARA_NAO_CONSUMIDOR_FINAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_REDUCAO_BASE_CALCULO_SUBSTITUICAO_TRIBUTARIA_NA_VENDA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ISENCAO_ICMS_VENDAS_ZONA_FRANCA_SOMENTE_PARA_PRODUTOS_NACIONAIS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_MENSAGEM_IMPOSTO_RETIDO_INDUSTRIA_PRECO_UTILIZADO_CALCULO_SUBST_OPERACOES_PROPRIAS, '2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_FATURAR_ORCAMENTOS_OUTRAS_LOJAS_QUANTO_UTILIZAR_F11, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_VIDRO_PRODUTO_PARA_VENDA_DE_ESTRUTURAS, '');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_INDUSTRIALIZACAO_OU_REVENDA, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_DECRETO_5141_2001_REDUCAO_33_33_RICM_PR,'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_DECRETO_5141_2001_REDUCAO_33_33_RICMS_DA_ABREVIACAO_FISCAL,'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_QUANDO_SIMPLES_NACIONAL_DENTRO_ESTADO_CALCULAR_VALOR_ST_COM_ALIQUOTA_INTERNA_SIMPLES_NACIONAL,'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_SIMPLES_NACIONAL_CST41_PRODUTOS_TRIBUTADOS_E_VALOR_ICMS_ZERO, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASES_ICMS_E_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_IMPORTACAO_DIRETA_PRODUTOS, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_DESPESAS_ACESSORIA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_FRETE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NOTA_FISCAL_CONCRETO, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PROCEDIMENTO_IMPRESSAO_NOTA_FISCAL, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CAMPO_PRECO_DECRETO_44498_2013_REDUCAO_BASE_CALCULO_IMPOSTOS, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERCENTUAL_MINIMO_DECRETO_44498_2013_REDUCAO_BASE_CALCULO_IMPOSTOS, '2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DIRETORIO_PARA_OPCOES_FISCAIS_INI, '');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_VENDA_FORA_ESTADO_NAO_CONTRIBUINTE_TRIBUTAR_ALIQUOTA_INTERNA_ESTADO, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_MENSAGEM_IMPOSTO_RETIDO_INDUSTRIA_MODELO_CALCULO_SUBST_OPERACOES_PROPRIAS, '2');

end;

procedure TTestControllerFatImpostosGeneric.SetarValoresModelsIcmsSt;
begin
  objMyCampoTabelaAdd.Add('CLI_SITIPI', 'T');
  objMyCampoTabelaAdd.Add('CLI_ZONFRA', 'N');
  objMyCampoTabelaAdd.Add('CLI_SUFRAM', 'N');
  objMyCampoTabelaAdd.Add('CLI_DESZON', 'N');
  objMyCampoTabelaAdd.Add('CLI_ORGPUB', 'N');
  objMyCampoTabelaAdd.Add('CLI_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('CLI_CONSUM', 'N');
  objMyCampoTabelaAdd.Add('CLI_CODATI', '002');
  objMyCampoTabelaAdd.Add('CLI_REGFIS', '1');
  objMyCampoTabelaAdd.Add('CLI_I_E_S_', '105006071117');
  objMyCampoTabelaAdd.Add('CLI_MICEMP', 'N');
  objMyCampoTabelaAdd.Add('CLI_CALICM', 'N');
  objMyCampoTabelaAdd.Add('CLI_INDCOM', 'C');
  objMyCampoTabelaAdd.Add('CLI_IVAESP', 0);
  objMyCampoTabelaAdd.Add('CLI_IVASIM', 0);
  objMyCampoTabelaAdd.Add('CLI_IVANAC', 0);

  objMyCampoTabelaAdd.Add('COUNT(*)', 0);
  objMyCampoTabelaAdd.Add('ENT_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('ENT_COIBGE', '3543402');

  objMyCampoTabelaAdd.Add('CLI_SIBICM', 'N');
  objMyCampoTabelaAdd.Add('CLI_STREES', 'N');
  objMyCampoTabelaAdd.Add('CLI_REDICM', 0);
  objMyCampoTabelaAdd.Add('CLI_DIF_ST', 'N');
  objMyCampoTabelaAdd.Add('CLI_ORPURD', 'N');

  objMyCampoTabelaAdd.Add('CLI_DESPIS', 'N');
  objMyCampoTabelaAdd.Add('CLI_BENREI', 'N');
  objMyCampoTabelaAdd.Add('CLI_ICMREI', 'N');
  objMyCampoTabelaAdd.Add('CLI_PRORUR', 'N');
  objMyCampoTabelaAdd.Add('CLI_IESUNI', 'N');
  objMyCampoTabelaAdd.Add('CLI_ORPUDF', 'N');

  objMyCampoTabelaAdd.Add('FISJUR', 'F');
  objMyCampoTabelaAdd.Add('I_E_S_', '12345678');
  objMyCampoTabelaAdd.Add('CONSUM', 'S');
  objMyCampoTabelaAdd.Add('CODATI', '002');
  objMyCampoTabelaAdd.Add('PRORUR', 'N');
  objMyCampoTabelaAdd.Add('MICEMP', 'N');
  objMyCampoTabelaAdd.Add('REGTRI', 'N');
  objMyCampoTabelaAdd.Add('INDUST', 'C');
  objMyCampoTabelaAdd.Add('CLI_CGCCPF', 2);

  objMyCampoTabelaAdd.Add('EMP_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('EMP_COIBGE', '3543402');

  objMyCampoTabelaAdd.Add('ITE_IPISAI', 0);
  objMyCampoTabelaAdd.Add('ITE_ITECCR', 'N');
  objMyCampoTabelaAdd.Add('ITEGER_CODABF', '004');
  objMyCampoTabelaAdd.Add('CADITE_CODABF', '002');
  objMyCampoTabelaAdd.Add('ITEGER_IMPDIR', 'N');
  objMyCampoTabelaAdd.Add('CADITE_IMPDIR', 'N');
  objMyCampoTabelaAdd.Add('ITE_UTIAMP', 'S');

  objMyCampoTabelaAdd.Add('FOR_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('FOR_I_E_S_', '');

  objMyCampoTabelaAdd.Add('CODATI', '002');

  objMyCampoTabelaAdd.Add('GROUP_CONCAT(EMP_CLIFIL)', '00000002,00000003,00000007,00000010,00000014,00000048');

  objMyCampoTabelaAdd.Add('ATI_CODATI', '001');

  objMyCampoTabelaAdd.Add('ITE_PREULT', 110);
  objMyCampoTabelaAdd.Add('ITE_PRECOM', 111);
  objMyCampoTabelaAdd.Add('ITE_DESF01', 10);
  objMyCampoTabelaAdd.Add('ITE_DESF02', 20);
  objMyCampoTabelaAdd.Add('ITE_DESF03', 30);
  objMyCampoTabelaAdd.Add('ITE_DESF04', 40);
  objMyCampoTabelaAdd.Add('ITE_DESF05', 50);
  objMyCampoTabelaAdd.Add('ITE_DESF06', 60);
end;


procedure TTestControllerFatImpostosGeneric.SetarValoresModelAbreviacaoIcmsSt(
  const ATipoDaAbreviacaoFiscal: String);
begin
  objMyCampoTabelaAdd.Add('ABF_ALQICM' + ATipoDaAbreviacaoFiscal, 18);
  objMyCampoTabelaAdd.Add('ABF_ALQRET' + ATipoDaAbreviacaoFiscal, 18);
  objMyCampoTabelaAdd.Add('ABF_BASICM' + ATipoDaAbreviacaoFiscal, 100);
  objMyCampoTabelaAdd.Add('ABF_CODSIT' + ATipoDaAbreviacaoFiscal, '000');

  objMyCampoTabelaAdd.Add('ABF_CAL_ST_SAI_CCO','666');

  objMyCampoTabelaAdd.Add('ABF_IVA_ST'+ ATipoDaAbreviacaoFiscal, '15');
  objMyCampoTabelaAdd.Add('ABF_BASRET'+ ATipoDaAbreviacaoFiscal, '060');
  objMyCampoTabelaAdd.Add('ABF_CAL_ST', '666');
  objMyCampoTabelaAdd.Add('ABF_CODABF', '040');
  objMyCampoTabelaAdd.Add('ABF_ALQFCP'+ ATipoDaAbreviacaoFiscal, '090');
  objMyCampoTabelaAdd.Add('ABF_ALQIED'+ ATipoDaAbreviacaoFiscal, 17);
  objMyCampoTabelaAdd.Add('ABF_BASDOR'+ ATipoDaAbreviacaoFiscal, 30);
  objMyCampoTabelaAdd.Add('ABF_BASDDS'+ ATipoDaAbreviacaoFiscal, 20);
  objMyCampoTabelaAdd.Add('ABF_ALQEFO'+ ATipoDaAbreviacaoFiscal, 12);

  objMyCampoTabelaAdd.Add('ABF_ALQICM_SAI_CNC',18);
end;




procedure TTestControllerFatImpostosGeneric.TestIcmsSt;
Var
//  FMatItens   : TMatrizFechamento;
//  FMatItens : Array Of TDadosFechamento;

  ReturnValue : IResultadoImpostosFatControllerIcmsSt;
begin
  PreencherMatrizIcmsSt;

  SetarConfiguracoesIcmsSt;
  SetarValoresModelsIcmsSt;
  SetarValoresModelAbreviacaoIcmsSt('_SAI_NCO');
  SetarValoresModelAbreviacaoIcmsSt('_SAI_CNC');
  ModelAbreviacaoIcms('_ENT_PEF');

{  objMyCampoTabelaAdd.Add('FISJUR', 'F');
  objMyCampoTabelaAdd.Add('I_E_S_', '12345678');
  objMyCampoTabelaAdd.Add('CONSUM', 'S');
  objMyCampoTabelaAdd.Add('CODATI', '002');
  objMyCampoTabelaAdd.Add('PRORUR', 'N');
  objMyCampoTabelaAdd.Add('MICEMP', 'N');
  objMyCampoTabelaAdd.Add('REGTRI', 'N');
  objMyCampoTabelaAdd.Add('INDUST', 'C');

  objMyCampoTabelaAdd.Add('GROUP_CONCAT(EMP_CLIFIL)', '00000002,00000003,00000007,00000010,00000014,00000048');

  objMyCampoTabelaAdd.Add('ATI_CODATI', '001');

  }

  SetImpostosFatParametrosComum(
      TImpostosFatParametrosComum.New
        .CodigoDoCliente('90090000')
        .ClienteConsumidorFinal(false)
        .CodigoDaEmpresa('001')
        .TaxaBombeamentoPedidoOrcamento(false)
        .BaixaDeEntregaFutura(false)
        .NotaComplementoFornecedor(false)
        .NotaEspecialFornecedor(false)
        .CodigoDoFornecedor('')
        .SequencialEnderecoEntrega('')
        .OpcaoDoDocumento('VN')
        .EspecieDoDocumento('NF')
        .VendaPresencial(false)
        .CodigoDaEmpresaTE('')
        .TipoOperacaoPedidoVenda('V')
        .ClienteIndustria(false)
        .ClienteComercializacao(false)
        .UtilizaSat(false)
        .CalcularSatEcf(false)
        .DesmembrarNotaProdutosServicos(false)
        .DesmembrarMeiaNotaComNotaNormal(false)
        .TipoDePedidoFaturamento('')
        .OrigemF11(false)
        .CodigoDaEmpresaOriginal('001')
        .NumeroDoOrcamento('')
        .ParametrosClienteConsumidor(Nil));

//  FMatItens[0].strCodSit := '610';

	objMyCampoTabelaAdd.Add('ABF_CODSIT_SAI_NCO', '610');
	objMyCampoTabelaAdd.Add('ABF_CODSIT_SAI_CNC', '610');
  objMyCampoTabelaAdd.Add('ABF_CODSIT_ENT_PEF', '610');

  ReturnValue :=
    TImpostosFatControllerGeneric.New
     .SetarMatrizItens(FMatItens)
     .SetarPosicaoMatriz(0)
     .IcmsSt.CalcularValorIcmsStFinal;

  CheckTrue(
    (CompararValores(ReturnValue.BaseDaSubstituicaoTributariaSimulada , 1350)) And
    (CompararValores(ReturnValue.AliquotaDaSubstituicaoTributariaSimulada ,18)) And
    (CompararValores(ReturnValue.ValorDaSubstituicaoTributariaSimulada, 216))And
    (CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem , 0)) And
    (CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem ,0)) And
    (CompararValores(ReturnValue.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao, 0)) And
    (CompararValores(ReturnValue.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao, 0)) And
    (CompararValores(ReturnValue.BaseDaSTCustoAquisicao , 2970)) And
    (CompararValores(ReturnValue.ValorDaSTCustoAquisicao , 534.6)) And
    (CompararValores(ReturnValue.FatorPositivo , 534.6)) And
    (ReturnValue.FatorNegativo = 0));

end;

procedure TTestControllerFatImpostosGeneric.TestIpi;
Var
  ReturnValue : IResultadoCalculoIPI;
  LParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor;

begin
  objMyCampoTabelaAdd.Add('CLI_SITIPI', 'T');
  objMyCampoTabelaAdd.Add('CLI_ZONFRA', 'N');
  objMyCampoTabelaAdd.Add('CLI_SUFRAM', 'N');
  objMyCampoTabelaAdd.Add('CLI_DESZON', 'N');
  objMyCampoTabelaAdd.Add('CLI_CODATI', '002');
  objMyCampoTabelaAdd.Add('CLI_REGFIS', '1');
  objMyCampoTabelaAdd.Add('CLI_ORGPUB', 'N');
  objMyCampoTabelaAdd.Add('CLI_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('CLI_CONSUM', 'S');
  objMyCampoTabelaAdd.Add('ITE_IPISAI', 18);
  objMyCampoTabelaAdd.Add('CLI_IVANAC', 0.0000);
  objMyCampoTabelaAdd.Add('CLI_DESPIS', 'S');
  objMyCampoTabelaAdd.Add('CLI_BENREI', 'S');
  objMyCampoTabelaAdd.Add('CLI_ICMREI', 'S');
  objMyCampoTabelaAdd.Add('CLI_PRORUR', 'N');
  objMyCampoTabelaAdd.Add('CLI_IESUNI', 'N');
  objMyCampoTabelaAdd.Add('CLI_ORPUDF', 'N');

  objMyCampoTabelaAdd.Add('ATI_CODATI', '002');
  objMyCampoTabelaAdd.Add('COUNT(*)', 0);
  objMyCampoTabelaAdd.Add('ITE_ITECCR', 'N');
  objMyCampoTabelaAdd.Add('ITE_UTIAMP', 'S');

  objMyCampoTabelaAdd.Add('CADITE_INDREV', 'I');
  objMyCampoTabelaAdd.Add('ITEGER_INDREV', 'I');

  objMyCampoTabelaAdd.Add('BASE', 70);
  objMyCampoTabelaAdd.Add('ALQ', 12);


  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_PIS_COFINS_IPI, '2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DEDUZIR_DESCONTO_ICMS_ZONA_FRANCA_BASE_CALCULO_ST_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_DESPESAS_ACESSORIA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_FRETE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_IPI_SOBRE_FRETE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_DE_VENDA, '5204');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_IMPORTACAO_DIRETA_PRODUTOS, 'N');


  SetLength(FMatItens, Length(FMatItens) + 1 );

  FMatItens[0].blnMeiaNotaFatorExpedicao := False;
  FMatItens[0].strCodIte := '10000';
  FMatItens[0].strClaFis := '5204';
  FMatItens[0].opcINFesp := opcVazio;
  FMatItens[0].fltTotIte := 150;
  FMatItens[0].fltValFre := 0;
  FMatItens[0].fltDesAce := 0;
  FMatItens[0].fltDesEsp := 0;
  FMatItens[0].strEspDev := '';


  LParametrosClienteConsumidor :=
    TParametrosFaturamentoImpostosClienteConsumidor.New
      .ClienteEstado('SP')
      .ClienteFisicoOuJuridico('F')
      .ClienteInscricaoEstadual('35487586810')
      .ClienteAtividade('')
      .CalcularDescontoIcmsOrgaoPublico(false);

  SetImpostosFatParametrosComum(
    TImpostosFatParametrosComum.New
      .NotaComplementoFornecedor(false)
      .NotaEspecialFornecedor(false)
      .CodigoDoFornecedor('000080000')
      .ParametrosClienteConsumidor(LParametrosClienteConsumidor)
      .CodigoDoCliente('000080000')
      .ClienteConsumidorFinal(false)
      .CodigoDaEmpresa('001')
      .SequencialEnderecoEntrega('')
      .VendaPresencial(true)
      .EspecieDoDocumento('NF')
      .DesmembrarNotaProdutosServicos(false)
      .OpcaoDoDocumento('VN')
      .DesmembrarMeiaNotaComNotaNormal(false)
      .BaixaDeEntregaFutura(false)
      .EntregaFutura(false));

  ReturnValue :=
    TImpostosFatControllerGeneric.New
     .SetarMatrizItens(FMatItens)
     .SetarPosicaoMatriz(0)
     .Ipi.CalcularValorIpi;


  CheckTrue(
    (returnValue.ValorCalculadoIPI = 27)  And
    (returnValue.BaseDeCalculoIPI = 150) And
    (returnValue.AliquotaDeCalculoIPI = 18));

end;

{procedure TTestControllerFatImpostosGeneric.TestSetarDadosFechamento;
begin

end;

procedure TTestControllerFatImpostosGeneric.TestSetarMatrizItens;
begin

end;

procedure TTestControllerFatImpostosGeneric.TestSetarPosicaoMatriz;
begin

end;
}

initialization
  RegisterTest(TTestControllerFatImpostosGeneric.Suite);
end.
