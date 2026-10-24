unit untFuncoesPrecoCusto;

interface

Uses
  fs_iinterpreter,
  System.StrUtils,
  System.SysUtils,
  Shared.Functions.Interfaces,
  Core.Funcoes,
  Shared.Functions.Tipos,
  untZClient,
  System.Classes,
  Shared.Functions.Configuracoes,
  Shared.Functions.Core;

  procedure SetarValoresFscScript(Var AfsScript: TObject; AParametrosFormulaPrecoCusto : IParametrosFormulaPrecoCustoSetarValores );

  function RetornarSQLFormulaPrecoCusto(Const AEmpresa : String; Const ANumeroFormula : Integer) : String;

  function RetornarTipoDoCusto : String;

  function RetornarCampoDoCusto : String;

  procedure InicializaFastScript(Var AfsScript: TObject);

  function ValidaCampoPrecoCusto(Var AZQuery : TObject; Var AIncluirRegistro : Boolean; Const AParametrosValidaCampoPrecoCusto: IParametrosValidaCampoPrecoCusto; AblnGeraAutoIncrem: Boolean = True ): Boolean;

  function CarregarTabelaFormulaDeCusto(Var AZQuery : TObject; Var AIncluirRegistros : Boolean ;Const AParametrosValidaCampoPrecoCusto : IParametrosValidaCampoPrecoCusto; AblnGeraAutoIncrem: Boolean = True) : Boolean;

  function RetornarDescricaoDescontosAdicionais : String;
  function RetornarOperadorAdicional : String;
  function RetornarDescricaoValorFrete : String;

  function ValidarMatrizDeRegistrosMarkup(Var AZQuery : TObject): Boolean;

  procedure AlinhaCampoCentro(Var AZQuery : TObject; Const ANomeCampo : String);

  function MontarExpressaoCusto(Var AZQuery : TObject): String;

  function ExecutarExpressao(Var AfsScript: TObject; AExpressao: String): Double;

  function RetonarValorCalculoPrecoCustoOpcao_04(Const AParametrosFormulaPrecoCusto : IParametrosFormulaPrecoCustoSetarValores) : Double;

  Const
    ARRAY_MARKUP : Array[0..21] Of Array[0..6] of String =
    (('PRECOM', 'Preço de Compra',         '',      '',                                                    '',       '', 'ITE_PRECOM'),
    ('DESF01', 'Desconto Fornecedor 1',   '-',     'PRECOM',                                              'DesF01', '', 'ITE_DESF01'),
    ('DESF02', 'Desconto Fornecedor 2',   '-',     'PRECOM - DESF01',                                     'DesF02', '', 'ITE_DESF02'),
    ('DESF03', 'Desconto Fornecedor 3',   '-',     'PRECOM - DESF01 - DESF02',                            'DesF03', '', 'ITE_DESF03'),
    ('DESF04', 'Desconto Fornecedor 4',   '-',     'PRECOM - DESF01 - DESF02 - DESF03',                   'DesF04', '', 'ITE_DESF04'),
    ('DESF05', 'Desconto Fornecedor 5',   '-',     'PRECOM - DESF01 - DESF02 - DESF03 - DESF04',          'DesF05', '', 'ITE_DESF05'),
    ('DESF06', 'Desconto Fornecedor 6',   '-',     'PRECOM - DESF01 - DESF02 - DESF03 - DESF04 - DESF05', 'DesF06', '', 'ITE_DESF06'),
    ('COMLIQ', 'Preço de Compra Líquido', '',      '', '',      'PRECOM - DESF01 - DESF02 - DESF03 - DESF04 - DESF05 - DESF06', ''),
    ('ICMENT', 'ICMS Entrada',            '-',     '', 'IcmEnt', '',       'ITE_ICMENT'),
    ('SUBFED', 'Impostos Federais',       '-',     '', 'SubFed', '',       'ITE_SUBFED'),
    ('IPIENT', 'IPI Entrada ',            '+',     '', 'IpiEnt', '',       'ITE_IPIENT'),
    ('FREENT', 'Frete',                   '+',     '', 'FreEnt', '',       'ITE_FREENT'),
    ('VALFRE', '/*CFG_DESCRICAO_FRETE*/',  '+',     '', '',       'VALFRE', 'ITE_VALFRE'),
    ('ACRFIN', 'Acréscimo Financeiro',    '+',     '', 'AcrFin', '',       'ITE_ACRFIN'),
    ('SUBSTI', 'Substituição Tributária', '+',     '', 'Substi', '',       'ITE_SUBSTI'),
    ('DESADB', '/*CFG_DESCRICAO_DESCONTO*/', '/*OPERADOR*/', '', 'DesAdb', '',       'ITE_DESADB'),
    ('TCIFCU', 'TCIF',                    '+',     '', 'TCIFCu', '',       'ITE_TCIFCU'),
    ('TSCUST', 'TS',                      '+',     '', 'TSCust', '',       'ITE_TSCUST'),
    ('DEPICO', 'Desconto PIS/COFINS',     '-',     '', 'DePiCo', '',       'ITE_DEPICO'),
    ('DEICMS', 'Desconto ICM',            '-',     '', 'DeICMS', '',       'ITE_DEICMS'),
    ('FATREG', 'Fator Regional',          '+',     '', 'FatReg', '',       'ITE_FATREG'),
    ('PRECUS', 'Preço de Custo',          '',      '', '',       'COMLIQ - ICMENT - SUBFED + IPIENT + FREENT + VALFRE + ACRFIN + SUBSTI ' + '/*OPERADOR*/'+ ' DESADB + TCIFCU + TSCUST - DEPICO - DEICMS + FATREG', 'ITE_PRECUS'));

implementation

function ExecutarExpressao(Var AfsScript: TObject; AExpressao: String): Double;
begin
  Result := TfsScript(AfsScript).Evaluate(Trim(AExpressao));
end;

function RetornarOperadorAdicional: String;
begin
  Result := objConfiguracoes.fGetValorConfiguracao(CFG_OPERACAO_COMPOSICAO_PRECO_PRODUTO, varString);
end;

function RetornarDescricaoDescontosAdicionais: String;
begin
  Result :=  objConfiguracoes.fGetValorConfiguracao(CFG_DESCONTOS_ADICIONAIS_DESCRICAO_COMPOSICAO_PRECO_DO_PRODUTO, varString);
end;

function RetornarDescricaoValorFrete: String;
begin
  Result :=  objConfiguracoes.fGetValorConfiguracao(CFG_VALOR_FRETE_DESCRICAO_COMPOSICAO_PRECO_DO_PRODUTO, varString);
end;

procedure AlinhaCampoCentro(Var AZQuery : TObject; Const ANomeCampo : String);
begin
  If TZClient(AZQuery).Fields.FindField(ANomeCampo) <> Nil Then
  Begin
    TZClient(AZQuery).FieldByName(ANomeCampo).Alignment := taCenter;
  End
end;

function MontarExpressaoCusto(Var AZQuery : TObject): String;
  Var
    strExpressao,
    strExpAnt: String;
begin
  TZClient(AZQuery).First;

  While Not TZClient(AZQuery).Eof Do
  Begin
    If Pos(TZClient(AZQuery).FieldByName('FOR_CODCAM').AsString, 'ICMENT_SUBFED_IPIENT_FREENT_ACRFIN_SUBSTI_DESADB_DESF01_DESF02_DESF03_DESF04_DESF05_DESF06_TCIFCU_TSCUST_DEPICO_DEICMS_FATREG') > 0 Then
    Begin
      TZClient(AZQuery).Edit;

      If TCoreFuncoes.fEmptyStr(TZClient(AZQuery).FieldByName('FOR_BASCAL').AsString) Then
        TZClient(AZQuery).FieldByName('EXPVAL').AsString :=  '0'
      Else
        TZClient(AZQuery).FieldByName('EXPVAL').AsString := '((' + TZClient(AZQuery).FieldByName('FOR_BASCAL').AsString + ' ) * ' + TZClient(AZQuery).FieldByName('NOMALQ').AsString + ' / 100)';

      TZClient(AZQuery).Post;
    End;

    TZClient(AZQuery).Next;
  End;


  strExpressao := 'COMLIQ - ICMENT - SUBFED + IPIENT + FREENT + VALFRE + ACRFIN + SUBSTI ' + RetornarOperadorAdicional + ' DESADB + TCIFCU + TSCUST - DEPICO - DEICMS + FATREG';

  Repeat

    strExpAnt := strExpressao;

    TZClient(AZQuery).First;

    While Not TZClient(AZQuery).Eof Do
    Begin

      If Pos(TZClient(AZQuery).FieldByName('FOR_CODCAM').AsString, 'ICMENT_SUBFED_IPIENT_FREENT_ACRFIN_SUBSTI_DESADB_TCIFCU_TSCUST_DEPICO_DEICMS_FATREG') > 0 Then
        strExpressao := AnsiReplaceStr(strExpressao, TZClient(AZQuery).FieldByName('FOR_CODCAM').AsString, TZClient(AZQuery).FieldByName('EXPVAL').AsString);

      TZClient(AZQuery).Next;
    End;

  Until strExpAnt = strExpressao;

  Result := strExpressao;
end;

function ValidarMatrizDeRegistrosMarkup(Var AZQuery : TObject): Boolean;
Var
  LContador : Integer;
  LIncluirRegistro : Boolean;
  LParametrosValidaCampoPrecoCusto : IParametrosValidaCampoPrecoCusto;
  LResult : Boolean;
begin
  LIncluirRegistro := false;
  LResult := true;

  For LContador := Low(ARRAY_MARKUP) To High(ARRAY_MARKUP) Do
  Begin
    LParametrosValidaCampoPrecoCusto :=
      TParametrosValidaCampoPrecoCusto.New
        .PosicaoCampo(LContador + 1)
        .CodigoCampo(ARRAY_MARKUP[LContador][0])
        .DescricaoCampo(AnsiReplaceStr(
                          AnsiReplaceStr(ARRAY_MARKUP[LContador][1], '/*CFG_DESCRICAO_DESCONTO*/', RetornarDescricaoDescontosAdicionais),
                          '/*CFG_DESCRICAO_FRETE*/', RetornarDescricaoValorFrete))
        .Operador(AnsiReplaceStr(ARRAY_MARKUP[LContador][2], '/*OPERADOR*/', RetornarOperadorAdicional ))
        .FormulaBaseCalculo(ARRAY_MARKUP[LContador][3])
        .NomeDaAliquota(ARRAY_MARKUP[LContador][4])
        .ValorDaExpressao(ARRAY_MARKUP[LContador][5])
        .NomeDoCampo(ARRAY_MARKUP[LContador][6]);

    Try
      ValidaCampoPrecoCusto(AZQuery, LIncluirRegistro, LParametrosValidaCampoPrecoCusto);
    Except
      LResult := False;
    End;

    //If Not Result Then
    //  LResult := False;
  End;

  If LIncluirRegistro Then
    Result := LResult And TZClient(AZQuery).fSalva
  Else
   Result := LResult;
end;

function RetonarValorCalculoPrecoCustoOpcao_04(Const AParametrosFormulaPrecoCusto : IParametrosFormulaPrecoCustoSetarValores) : Double;
Var
  LSQL        : String;
  LQuery      : TZClient;
  LfsScript   : TfsScript;
  LExpressao  : String;
  LResultado  : Double;
begin
  LSQL   := RetornarSQLFormulaPrecoCusto(objCore.fCodigoDaEmpresa, 0);
  LQuery := TZClient.Create(Nil, LSQL);

  Try
    InicializaFastScript(TObject(LfsScript));

    LResultado  := 0;

    If LQuery.fAbreClient(True) Then
    begin
      LQuery.IndexFieldNames := 'FOR_CODCAM';

      ValidarMatrizDeRegistrosMarkup(TObject(LQuery));
      AlinhaCampoCentro(TObject(LQuery), 'FOR_CODCAM');
      AlinhaCampoCentro(TObject(LQuery), 'OPERAD');

      LExpressao := MontarExpressaoCusto(TObject(LQuery));

      untFuncoesPrecoCusto.SetarValoresFscScript(TObject(LfsScript), AParametrosFormulaPrecoCusto);

      LResultado := ExecutarExpressao(TObject(LfsScript), LExpressao);
    end;
  Finally
    If Assigned(LQuery) Then
      FreeAndNil(LQuery);

    If Assigned(LfsScript) Then
      FreeAndNil(LfsScript);
  End;

  Result := LResultado;
end;

function CarregarTabelaFormulaDeCusto(Var AZQuery : TObject; Var AIncluirRegistros : Boolean; Const AParametrosValidaCampoPrecoCusto : IParametrosValidaCampoPrecoCusto; AblnGeraAutoIncrem: Boolean = True) : Boolean;
begin

  If TZClient(AZQuery).FindKey([AParametrosValidaCampoPrecoCusto.CodigoCampo]) Then
  Begin
    TZClient(AZQuery).Edit;
  End
  Else
  Begin
    TZClient(AZQuery).Append;
    If AblnGeraAutoIncrem Then
      TZClient(AZQuery).FieldByName('AUTOINCREM').AsString := objCore.fRetAutoIncrem('FORCUS', objCore.fCodigoDaEmpresa)
    Else
      TZClient(AZQuery).FieldByName('AUTOINCREM').Clear;

    TZClient(AZQuery).FieldByName('FOR_CODCAM').AsString := AParametrosValidaCampoPrecoCusto.CodigoCampo;
    TZClient(AZQuery).FieldByName('FOR_CODEMP').AsString := objCore.fCodigoDaEmpresa;

    AIncluirRegistros := True;
  End;

  TZClient(AZQuery).FieldByName('POSCAM').AsInteger := AParametrosValidaCampoPrecoCusto.PosicaoCampo ;
  TZClient(AZQuery).FieldByName('DESCAM').AsString  := AParametrosValidaCampoPrecoCusto.DescricaoCampo;
  TZClient(AZQuery).FieldByName('OPERAD').AsString  := AParametrosValidaCampoPrecoCusto.Operador;
  TZClient(AZQuery).FieldByName('NOMALQ').AsString  := AParametrosValidaCampoPrecoCusto.NomeDaAliquota;
  TZClient(AZQuery).FieldByName('EXPVAL').AsString  := AParametrosValidaCampoPrecoCusto.ValorDaExpressao;

  If Not TCoreFuncoes.fEmptyStr(AParametrosValidaCampoPrecoCusto.FormulaBaseCalculo) Then
    TZClient(AZQuery).FieldByName('FOR_BASCAL').AsString  := AParametrosValidaCampoPrecoCusto.FormulaBaseCalculo;

  TZClient(AZQuery).FieldByName('NOMCAM').AsString  := AParametrosValidaCampoPrecoCusto.NomeDoCampo;
  TZClient(AZQuery).Post;

  Result := True;
end;



function ValidaCampoPrecoCusto(Var AZQuery : TObject; Var AIncluirRegistro : Boolean;  Const AParametrosValidaCampoPrecoCusto : IParametrosValidaCampoPrecoCusto; AblnGeraAutoIncrem: Boolean = True): Boolean;
begin
  Result :=
    CarregarTabelaFormulaDeCusto(
      AZQuery,
      AIncluirRegistro,
      AParametrosValidaCampoPrecoCusto,
      AblnGeraAutoIncrem);
end;

procedure InicializaFastScript(Var AfsScript: TObject);
begin
  TfsScript(AfsScript):= TfsScript.Create(Nil);
end;


function RetornarCampoDoCusto : String;
begin
  Result := 'MARBR';

  If Pos(objConfiguracoes.fGetValorConfiguracao(CFG_CONFIGURACAO_PARA_MARGEM_MARKUP, varString), '1_5_') <> 0 Then
    Exit;

  Result := 'MARKP';
end;


function RetornarTipoDoCusto : String;
begin
  Result := 'Margem';

  If Pos(objConfiguracoes.fGetValorConfiguracao(CFG_CONFIGURACAO_PARA_MARGEM_MARKUP, varString), '1_5_') <> 0 Then
    Exit;

  Result := 'Markup';
end;


function RetornarSQLFormulaPrecoCusto(Const AEmpresa : String; Const ANumeroFormula : Integer) : String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                              ';
  strSQL := strSQL + '   F.*,                              ';
  strSQL := strSQL + '   0                      AS POSCAM, ';
  strSQL := strSQL + '   CAST("" AS CHAR(0080)) AS DESCAM, ';
  strSQL := strSQL + '   CAST("" AS CHAR(0020)) AS OPERAD, ';
  strSQL := strSQL + '   CAST("" AS CHAR(0020)) AS NOMALQ, ';

  strSQL := strSQL + '   CAST("" AS CHAR(0500)) AS EXPVAL, ';
  strSQL := strSQL + '   CAST("" AS CHAR(5000)) AS EXPFUL, ';

  strSQL := strSQL + '   CAST("" AS CHAR(5000)) AS EXPUSU, ';

  strSQL := strSQL + '   CAST("" AS CHAR(0020)) AS NOMCAM, ';
  strSQL := strSQL + '   CAST("" AS CHAR(0001)) AS TABELA, ';
  strSQL := strSQL + '   CAST("" AS CHAR(0255)) AS TABFOR, ';
  strSQL := strSQL + '   CAST("" AS CHAR(0255)) AS DESITE, ';
  strSQL := strSQL + '   0.00000000             AS VALCAD, ';
  strSQL := strSQL + '   0.00000000             AS VALCAL  ';

  strSQL := strSQL + ' FROM                                ';
  strSQL := strSQL + '   FORCUS F                          ';
  strSQL := strSQL + ' WHERE                               ';
  strSQL := strSQL + '   FOR_CODEMP = ' + QuotedStr(AEmpresa);

  If ANumeroFormula > 0 Then
    strSQL := strSQL + ' AND FALSE ';

  Result := strSQL;
end;


procedure SetarValoresFscScript(Var AfsScript: TObject; AParametrosFormulaPrecoCusto: IParametrosFormulaPrecoCustoSetarValores);
begin
  TfsScript(AfsScript).Clear;
  TfsScript(AfsScript).SyntaxType := 'PascalScript';
  TfsScript(AfsScript).AddType('Integer', fvtInt);
  TfsScript(AfsScript).AddType('Boolean', fvtBool);
  TfsScript(AfsScript).AddType('Double' , fvtFloat);
  TfsScript(AfsScript).AddType('Char',    fvtChar);
  TfsScript(AfsScript).AddType('String',  fvtString);
  TfsScript(AfsScript).AddType('Variant', fvtVariant);

  TfsScript(AfsScript).AddConst('COMLIQ', 'Double',  AParametrosFormulaPrecoCusto.PrecoDeCompraLiquido );
  TfsScript(AfsScript).AddConst('ICMENT', 'Double',  AParametrosFormulaPrecoCusto.IcmEntrada );
  TfsScript(AfsScript).AddConst('SUBFED', 'Double',  AParametrosFormulaPrecoCusto.ImpostosFederaisEntrada );
  TfsScript(AfsScript).AddConst('IPIENT', 'Double',  AParametrosFormulaPrecoCusto.IpiEntrada );
  TfsScript(AfsScript).AddConst('FREENT', 'Double',  AParametrosFormulaPrecoCusto.FreteEntrada );
  TfsScript(AfsScript).AddConst('VALFRE', 'Double',  AParametrosFormulaPrecoCusto.ValorFrete );
  TfsScript(AfsScript).AddConst('ACRFIN', 'Double',  AParametrosFormulaPrecoCusto.AcrescimoFinal );
  TfsScript(AfsScript).AddConst('SUBSTI', 'Double',  AParametrosFormulaPrecoCusto.Substituicao );
  TfsScript(AfsScript).AddConst('DESADB', 'Double',  AParametrosFormulaPrecoCusto.DescontoAdicionalBoleto );

  TfsScript(AfsScript).AddConst('OUTVAL', 'Double',  AParametrosFormulaPrecoCusto.OutrosValores );
  TfsScript(AfsScript).AddConst('ICMSAI', 'Double',  AParametrosFormulaPrecoCusto.IcmSaida );
  TfsScript(AfsScript).AddConst('IMPFED', 'Double',  AParametrosFormulaPrecoCusto.ImpostosFederaisSaida );
  TfsScript(AfsScript).AddConst('DESOPE', 'Double',  AParametrosFormulaPrecoCusto.DespesaOperacional );

  TfsScript(AfsScript).AddConst('TCIFCU', 'Double',  AParametrosFormulaPrecoCusto.TaxaDeControleDeIncentivosFiscaisSuframa);
  TfsScript(AfsScript).AddConst('TSCUST', 'Double',  AParametrosFormulaPrecoCusto.TaxaDeServicoSuframa);
  TfsScript(AfsScript).AddConst('DEPICO', 'Double',  AParametrosFormulaPrecoCusto.DescontoPisCofins);
  TfsScript(AfsScript).AddConst('DEICMS', 'Double',  AParametrosFormulaPrecoCusto.DescontoICMS);
  TfsScript(AfsScript).AddConst('FATREG', 'Double',  AParametrosFormulaPrecoCusto.FatorRegional);

end;


end.

