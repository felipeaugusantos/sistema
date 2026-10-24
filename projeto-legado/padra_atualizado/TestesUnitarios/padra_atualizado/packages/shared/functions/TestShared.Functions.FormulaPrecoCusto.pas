unit TestShared.Functions.FormulaPrecoCusto;

interface

Uses

  TestFramework,
  untFormulaPrecoCusto,
  untFuncoes,
  Shared.Functions.FormulaPrecoCusto,
  Shared.Functions.Interfaces,
  Shared.Functions.Tipos,
  fs_iinterpreter,
  UniClientDataSet,
  untZClient,
  Data.DB,
  fs_ipascal,
  System.SysUtils,
  Shared.Functions.Configuracoes;

Type

  TestIFormulaPrecoCusto = class(TTestCase)
  strict private

  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestSetarValoresFscScript; // TestSetarValoresFscScript(Var AfsScript: TObject; AParametrosFormulaPrecoCusto : IParametrosFormulaPrecoCustoSetarValores );

    procedure TestRetornarSQLFormulaPrecoCustoTrue; // function RetornarSQLFormulaPrecoCusto(Const AEmpresa : String; Const ANumeroFormula : Integer) : String;
    procedure TestRetornarSQLFormulaPrecoCustoFalse; // function RetornarSQLFormulaPrecoCusto(Const AEmpresa : String; Const ANumeroFormula : Integer) : String;

    procedure TestRetornarTipoDoCusto_CFG_1; // function RetornarTipoDoCusto : String;
    procedure TestRetornarTipoDoCusto_CFG_5; // function RetornarTipoDoCusto : String;
    procedure TestRetornarTipoDoCusto_CFG_4; // function RetornarTipoDoCusto : String;

    procedure TestRetornarCampoDoCusto_CFG_1;  // function RetornarCampoDoCusto : String;
    procedure TestRetornarCampoDoCusto_CFG_5;  // function RetornarCampoDoCusto : String;

    procedure TestRetornarCampoDoCusto_CFG_4;  // function RetornarCampoDoCusto : String;

    procedure TestInicializaFastScript;  // procedure InicializaFastScript(Var AfsScript: TObject);
    procedure TestMontarExpressaoCusto; // function MontarExpressaoCusto(Var AZQuery : TObject): String;
    procedure TestExecutarExpressao;   //function ExecutarExpressao(Var AfsScript: TObject; AExpressao: String): Double;
    procedure TestRetonarValorCalculoPrecoCustoOpcao_04; // function RetonarValorCalculoPrecoCustoOpcao_04(const AParametrosFormulaPrecoCusto: IParametrosFormulaPrecoCustoSetarValores) : Double;
  Private
    function RetornarFsScript : TfsScript;
    procedure TestCriarClientDataSet(var cdsDados: TUniClientDataSet);
  end;


implementation

{ TestSharedFunctionsFormulaPrecoCusto }

procedure TestIFormulaPrecoCusto.SetUp;
begin
  inherited;

end;

procedure TestIFormulaPrecoCusto.TearDown;
begin
  inherited;

end;


procedure TestIFormulaPrecoCusto.TestExecutarExpressao;
var
  LExpressao  : String;
  LfsScript   : TfsScript;
  ReturnValue : Double;
begin
  LExpressao :=
    'COMLIQ - ((COMLIQ ) * IcmEnt / 100) - ((COMLIQ+((COMLIQ ) * IpiEnt / 100) ) * SubFed / 100) + '+
    '((COMLIQ ) * IpiEnt / 100) + ((COMLIQ + ((COMLIQ ) * IpiEnt / 100) + '+
    '((COMLIQ ) * Substi / 100) ) * FreEnt / 100) + VALFRE + ((COMLIQ + ((COMLIQ ) * IpiEnt / 100) + '+
    '((COMLIQ ) * Substi / 100) ) * AcrFin / 100) + ((COMLIQ ) * Substi / 100) - ((COMLIQ - ((COMLIQ ) '+
    '* IcmEnt / 100) - ((COMLIQ +((COMLIQ ) * IpiEnt / 100) ) * SubFed / 100) + ((COMLIQ ) * IpiEnt / 100) +'+
    ' ((COMLIQ + ((COMLIQ ) * IpiEnt / 100) + ((COMLIQ ) * Substi / 100) ) * FreEnt / 100) + VALFRE + '+
    '((COMLIQ + ((COMLIQ ) * IpiEnt / 100) + ((COMLIQ ) * Substi / 100) ) * AcrFin / 100) + '+
    '((COMLIQ ) * Substi / 100) ) * DesAdb / 100) + ((COMLIQ ) * TCIFCu / 100) + ((COMLIQ ) * TSCust / 100) - '+
    '((COMLIQ ) * DePiCo / 100) - ((COMLIQ ) * DeICMS / 100) + ((COMLIQ ) * FatReg / 100)';

  LfsScript  := TfsScript.Create(Nil);
  LfsScript.Clear;
  LfsScript.SyntaxType := 'PascalScript';
  LfsScript.AddType('Integer', fvtInt);
  LfsScript.AddType('Boolean', fvtBool);
  LfsScript.AddType('Double' , fvtFloat);
  LfsScript.AddType('Char',    fvtChar);
  LfsScript.AddType('String',  fvtString);
  LfsScript.AddType('Variant', fvtVariant);

  LfsScript.AddConst('COMLIQ', 'Double',  87.217);
  LfsScript.AddConst('ICMENT', 'Double',  12);
  LfsScript.AddConst('SUBFED', 'Double',  1);
  LfsScript.AddConst('IPIENT', 'Double',  2 );
  LfsScript.AddConst('FREENT', 'Double',  3 );
  LfsScript.AddConst('VALFRE', 'Double',  4 );
  LfsScript.AddConst('ACRFIN', 'Double',  1 );
  LfsScript.AddConst('SUBSTI', 'Double',  2 );
  LfsScript.AddConst('DESADB', 'Double',  20 );

  LfsScript.AddConst('OUTVAL', 'Double',  0);
  LfsScript.AddConst('ICMSAI', 'Double',  0 );
  LfsScript.AddConst('IMPFED', 'Double',  0 );
  LfsScript.AddConst('DESOPE', 'Double',  0 );

  LfsScript.AddConst('TCIFCU', 'Double',  0);
  LfsScript.AddConst('TSCUST', 'Double',  0);
  LfsScript.AddConst('DEPICO', 'Double',  0);
  LfsScript.AddConst('DEICMS', 'Double',  0);
  LfsScript.AddConst('FATREG', 'Double',  0);


 {ESTÁ OCORRENDO ERRO NO FASTSCRIPT}

 ReturnValue := TFormulaPrecoCusto.New.ExecutarExpressao(TObject(LfsScript), LExpressao);

  CheckTrue(CompararValores(ReturnValue, 69.58));

  FreeAndNil(LfsScript);

end;

procedure TestIFormulaPrecoCusto.TestInicializaFastScript;
var
  LfsScript : TfsScript;
begin
  TFormulaPrecoCusto.New.InicializaFastScript(TObject(LfsScript));

  CheckTrue(LfsScript <> Nil);

  FreeAndNil(LfsScript);
end;


procedure TestIFormulaPrecoCusto.TestCriarClientDataSet(Var cdsDados : TUniClientDataSet);
begin
  cdsDados := TUniClientDataSet.Create(Nil);
  cdsDados.Close;
  cdsDados.FieldDefs.Clear;
  cdsDados.FieldDefs.add('FOR_CODCAM', ftString, 100);
  cdsDados.FieldDefs.add('FOR_BASCAL', ftString, 200);
  cdsDados.FieldDefs.add('EXPVAL',     ftString, 100);
  cdsDados.FieldDefs.add('NOMALQ',     ftString, 100);
  cdsDados.FieldDefs.add('OPERAD',     ftString, 100);

  cdsDados.CreateDataSet;
end;

procedure TestIFormulaPrecoCusto.TestMontarExpressaoCusto;
Var
  cdsDados : TUniClientDataSet;
  LExpressao : String;
  ReturnValue : String;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_OPERACAO_COMPOSICAO_PRECO_PRODUTO, '-');

  LExpressao := 'COMLIQ - 0 - 0 + 0 + 0 + VALFRE + 0 + 0 - 0 + 0 + 0 - 0 - 0 + 0';

  TestCriarClientDataSet(cdsDados);

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString := 'PRECOM';
  cdsDados.FieldByName('FOR_BASCAL').AsString := '';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := '';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='DESF01';
  cdsDados.FieldByName('FOR_BASCAL').AsString := 'PRECOM';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'DesF01';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='DESF02';
  cdsDados.FieldByName('FOR_BASCAL').AsString := 'PRECOM - DESF01';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'DesF02';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='DESF03';
  cdsDados.FieldByName('FOR_BASCAL').AsString := 'PRECOM - DESF01 - DESF02';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'DesF03';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='DESF04';
  cdsDados.FieldByName('FOR_BASCAL').AsString := 'PRECOM - DESF01 - DESF02 - DESF03';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'DesF04';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='DESF05';
  cdsDados.FieldByName('FOR_BASCAL').AsString := 'PRECOM - DESF01 - DESF02 - DESF03 - DESF04';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'DesF05';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='DESF06';
  cdsDados.FieldByName('FOR_BASCAL').AsString := 'PRECOM - DESF01 - DESF02 - DESF03 - DESF04 - DESF05';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'DesF06';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='COMLIQ';
  cdsDados.FieldByName('FOR_BASCAL').AsString := '';
  cdsDados.FieldByName('EXPVAL').AsString     := 'PRECOM - DESF01 - DESF02 - DESF03 - DESF04 - DESF05 - DESF06';
  cdsDados.FieldByName('NOMALQ').AsString := '';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='ICMENT';
  cdsDados.FieldByName('FOR_BASCAL').AsString := '';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'IcmEnt';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='SUBFED';
  cdsDados.FieldByName('FOR_BASCAL').AsString := '';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'SubFed';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='IPIENT';
  cdsDados.FieldByName('FOR_BASCAL').AsString := '';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'IpiEnt';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='FREENT';
  cdsDados.FieldByName('FOR_BASCAL').AsString := '';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'FreEnt';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='VALFRE';
  cdsDados.FieldByName('FOR_BASCAL').AsString := '';
  cdsDados.FieldByName('EXPVAL').AsString     := 'VALFRE';
  cdsDados.FieldByName('NOMALQ').AsString := '';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='ACRFIN';
  cdsDados.FieldByName('FOR_BASCAL').AsString := '';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'AcrFin';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='SUBSTI';
  cdsDados.FieldByName('FOR_BASCAL').AsString := '';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'Substi';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='DESADB';
  cdsDados.FieldByName('FOR_BASCAL').AsString := '';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'DesAdb';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='TCIFCU';
  cdsDados.FieldByName('FOR_BASCAL').AsString := '';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'TCIFCu';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='TSCUST';
  cdsDados.FieldByName('FOR_BASCAL').AsString := '';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'TSCust';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='DEPICO';
  cdsDados.FieldByName('FOR_BASCAL').AsString := '';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'DePiCo';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='DEICMS';
  cdsDados.FieldByName('FOR_BASCAL').AsString := '';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'DeICMS';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='FATREG';
  cdsDados.FieldByName('FOR_BASCAL').AsString := '';
  cdsDados.FieldByName('EXPVAL').AsString     := '';
  cdsDados.FieldByName('NOMALQ').AsString := 'FatReg';
  cdsDados.Post;

  cdsDados.Append;
  cdsDados.FieldByName('FOR_CODCAM').AsString :='PRECUS';
  cdsDados.FieldByName('FOR_BASCAL').AsString := '';
  cdsDados.FieldByName('EXPVAL').AsString :=  'COMLIQ - ICMENT - SUBFED + IPIENT + FREENT + VALFRE + ACRFIN + SUBSTI - DESADB + TCIFCU + TSCUST - DEPICO - DEICMS + FATREG';
  cdsDados.FieldByName('NOMALQ').AsString := '';
  cdsDados.Post;

  { ESTÁ OCORRENDO ERRO AO EXECUTAR O FASTSCRIPT }

  ReturnValue := TFormulaPrecoCusto.New.MontarExpressaoCusto(TObject(cdsDados));

  CheckTrue(ReturnValue = LExpressao);


  FreeAndNil(cdsDados);

end;

procedure TestIFormulaPrecoCusto.TestRetonarValorCalculoPrecoCustoOpcao_04;
Var
  LParametrosFormulaPrecoCusto : IParametrosFormulaPrecoCustoSetarValores;
  ReturnValue : Double;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DESCONTOS_ADICIONAIS_DESCRICAO_COMPOSICAO_PRECO_DO_PRODUTO, '-');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_VALOR_FRETE_DESCRICAO_COMPOSICAO_PRECO_DO_PRODUTO, '-');

  LParametrosFormulaPrecoCusto :=
    TParametrosFormulaPrecoCustoSetarValores.New
      .PrecoDeCompraLiquido(10)
      .IcmEntrada(20)
      .ImpostosFederaisEntrada(30)
      .IpiEntrada(40)
      .FreteEntrada(50)
      .ValorFrete(60)
      .AcrescimoFinal(70)
      .Substituicao(80)
      .DescontoAdicionalBoleto(90)
      .OutrosValores(100)
      .IcmSaida(110)
      .ImpostosFederaisSaida(120)
      .DespesaOperacional(130)
      .TaxaDeControleDeIncentivosFiscaisSuframa(140)
      .TaxaDeServicoSuframa(150)
      .DescontoPisCofins(160)
      .DescontoICMS(170)
      .FatorRegional(180);

  ReturnValue := TFormulaPrecoCusto.New.RetonarValorCalculoPrecoCustoOpcao_04(LParametrosFormulaPrecoCusto);

  CheckTrue(CompararValores(ReturnValue, 70));
end;

procedure TestIFormulaPrecoCusto.TestRetornarCampoDoCusto_CFG_1;
Var
  ReturnValue : String;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONFIGURACAO_PARA_MARGEM_MARKUP, '1');

  ReturnValue := TFormulaPrecoCusto.New.RetornarCampoDoCusto;

  CheckTrue(ReturnValue = 'MARBR');
end;

procedure TestIFormulaPrecoCusto.TestRetornarCampoDoCusto_CFG_4;
Var
  ReturnValue : String;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONFIGURACAO_PARA_MARGEM_MARKUP, '4');

  ReturnValue := TFormulaPrecoCusto.New.RetornarCampoDoCusto;

  CheckTrue(ReturnValue = 'MARKP');
end;

procedure TestIFormulaPrecoCusto.TestRetornarCampoDoCusto_CFG_5;
Var
  ReturnValue : String;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONFIGURACAO_PARA_MARGEM_MARKUP, '5');

  ReturnValue := TFormulaPrecoCusto.New.RetornarCampoDoCusto;

  CheckTrue(ReturnValue = 'MARBR');
end;

procedure TestIFormulaPrecoCusto.TestRetornarSQLFormulaPrecoCustoFalse;
Var
  ReturnValue : String;
  LSQL : String;
begin
  LSQL := 'SELECT'+
          '  F.*,'+
          '  0 AS POSCAM,'+
          '  CAST("" AS CHAR(0080)) AS DESCAM,'+
          '  CAST("" AS CHAR(0020)) AS OPERAD,'+
          '  CAST("" AS CHAR(0020)) AS NOMALQ,'+
          '  CAST("" AS CHAR(0500)) AS EXPVAL,'+
          '  CAST("" AS CHAR(5000)) AS EXPFUL,'+
          '  CAST("" AS CHAR(5000)) AS EXPUSU,'+
          '  CAST("" AS CHAR(0020)) AS NOMCAM,'+
          '  CAST("" AS CHAR(0001)) AS TABELA,'+
          '  CAST("" AS CHAR(0255)) AS TABFOR,'+
          '  CAST("" AS CHAR(0255)) AS DESITE,'+
          '  0.00000000 AS VALCAD,'+
          '  0.00000000 AS VALCAL'+
          'FROM'+
          '  FORCUS F'+
          'WHERE FOR_CODEMP = '' 777 '''+
          '  AND FALSE';

  ReturnValue := StringReplace(TFormulaPrecoCusto.New.RetornarSQLFormulaPrecoCusto('777',1), ' ', EmptyStr, [rfReplaceAll]);
  LSQL := StringReplace(LSQL, ' ', EmptyStr,[rfReplaceAll]);

  CheckTrue(Trim(LSQL) = Trim(ReturnValue));
end;

procedure TestIFormulaPrecoCusto.TestRetornarSQLFormulaPrecoCustoTrue;
Var
  ReturnValue : String;
  LSQL : String;
begin

  LSQL := 'SELECT'+
          '  F.*,'+
          '  0 AS POSCAM,'+
          '  CAST("" AS CHAR(0080)) AS DESCAM,'+
          '  CAST("" AS CHAR(0020)) AS OPERAD,'+
          '  CAST("" AS CHAR(0020)) AS NOMALQ,'+
          '  CAST("" AS CHAR(0500)) AS EXPVAL,'+
          '  CAST("" AS CHAR(5000)) AS EXPFUL,'+
          '  CAST("" AS CHAR(5000)) AS EXPUSU,'+
          '  CAST("" AS CHAR(0020)) AS NOMCAM,'+
          '  CAST("" AS CHAR(0001)) AS TABELA,'+
          '  CAST("" AS CHAR(0255)) AS TABFOR,'+
          '  CAST("" AS CHAR(0255)) AS DESITE,'+
          '  0.00000000 AS VALCAD,'+
          '  0.00000000 AS VALCAL'+
          'FROM'+
          '  FORCUS F'+
          'WHERE FOR_CODEMP = '' 777 ''';

  ReturnValue := StringReplace(TFormulaPrecoCusto.New.RetornarSQLFormulaPrecoCusto('777',0), ' ', EmptyStr, [rfReplaceAll]);
  LSQL := StringReplace(LSQL, ' ', EmptyStr,[rfReplaceAll]);

  CheckTrue(Trim(LSQL) = Trim(ReturnValue));
end;

procedure TestIFormulaPrecoCusto.TestRetornarTipoDoCusto_CFG_1; // function RetornarTipoDoCusto : String;
Var
  ReturnValue : String;
begin

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONFIGURACAO_PARA_MARGEM_MARKUP, '1');

  ReturnValue := TFormulaPrecoCusto.New.RetornarTipoDoCusto;

  CheckTrue(ReturnValue = 'Margem');
end;

procedure TestIFormulaPrecoCusto.TestRetornarTipoDoCusto_CFG_4;
Var
  ReturnValue : String;
begin

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONFIGURACAO_PARA_MARGEM_MARKUP, '4');

  ReturnValue := TFormulaPrecoCusto.New.RetornarTipoDoCusto;

  CheckTrue(ReturnValue = 'Markup');
end;

procedure TestIFormulaPrecoCusto.TestRetornarTipoDoCusto_CFG_5;
Var
  ReturnValue : String;
begin

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONFIGURACAO_PARA_MARGEM_MARKUP, '5');

  ReturnValue := TFormulaPrecoCusto.New.RetornarTipoDoCusto;

  CheckTrue(ReturnValue = 'Margem');
end;

function TestIFormulaPrecoCusto.RetornarFsScript : TfsScript;
Var
  LfsScript : TfsScript;
begin
  LfsScript  := TfsScript.Create(Nil);
  LfsScript.Clear;
  LfsScript.SyntaxType := 'PascalScript';
  LfsScript.AddType('Integer', fvtInt);
  LfsScript.AddType('Boolean', fvtBool);
  LfsScript.AddType('Double' , fvtFloat);
  LfsScript.AddType('Char',    fvtChar);
  LfsScript.AddType('String',  fvtString);
  LfsScript.AddType('Variant', fvtVariant);

  LfsScript.AddConst('COMLIQ', 'Double',  10);
  LfsScript.AddConst('ICMENT', 'Double',  20);
  LfsScript.AddConst('SUBFED', 'Double',  30);
  LfsScript.AddConst('IPIENT', 'Double',  40 );
  LfsScript.AddConst('FREENT', 'Double',  50 );
  LfsScript.AddConst('VALFRE', 'Double',  60 );
  LfsScript.AddConst('ACRFIN', 'Double',  70 );
  LfsScript.AddConst('SUBSTI', 'Double',  80 );
  LfsScript.AddConst('DESADB', 'Double',  90 );

  LfsScript.AddConst('OUTVAL', 'Double',  100);
  LfsScript.AddConst('ICMSAI', 'Double',  110 );
  LfsScript.AddConst('IMPFED', 'Double',  120 );
  LfsScript.AddConst('DESOPE', 'Double',  130 );

  LfsScript.AddConst('TCIFCU', 'Double',  140);
  LfsScript.AddConst('TSCUST', 'Double',  150);
  LfsScript.AddConst('DEPICO', 'Double',  160);
  LfsScript.AddConst('DEICMS', 'Double',  170);
  LfsScript.AddConst('FATREG', 'Double',  180);

  Result := LfsScript;
end;

procedure TestIFormulaPrecoCusto.TestSetarValoresFscScript;
Var
  LParametros: IParametrosFormulaPrecoCustoSetarValores;
  LfsScriptResultado: TfsScript;
  LfsScript  : TfsScript;
  LContador  : Integer;
  LCheckTrue : Boolean;
begin
  LParametros :=
    TParametrosFormulaPrecoCustoSetarValores.New
      .PrecoDeCompraLiquido(10)
      .IcmEntrada(20)
      .ImpostosFederaisEntrada(30)
      .IpiEntrada(40)
      .FreteEntrada(50)
      .ValorFrete(60)
      .AcrescimoFinal(70)
      .Substituicao(80)
      .DescontoAdicionalBoleto(90)
      .OutrosValores(100)
      .IcmSaida(110)
      .ImpostosFederaisSaida(120)
      .DespesaOperacional(130)
      .TaxaDeControleDeIncentivosFiscaisSuframa(140)
      .TaxaDeServicoSuframa(150)
      .DescontoPisCofins(160)
      .DescontoICMS(170)
      .FatorRegional(180);

  LfsScriptResultado := TfsScript.Create(Nil);

  TFormulaPrecoCusto.New.SetarValoresFscScript(TObject(LfsScriptResultado), LParametros);

  LfsScript := RetornarFsScript;

  LCheckTrue := true;

  For LContador := 0 To LfsScriptResultado.Count -1 Do
  begin
    LCheckTrue := (LfsScript.Items[LContador].Value = LfsScriptResultado.Items[LContador].Value);

    If Not LCheckTrue Then
     Break;
  end;

  CheckTrue(LCheckTrue);

  FreeAndNil(LfsScriptResultado);
  FreeAndNil(LfsScript);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestIFormulaPrecoCusto.Suite);

end.

