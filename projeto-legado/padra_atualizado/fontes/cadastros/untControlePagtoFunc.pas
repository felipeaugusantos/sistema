unit untControlePagtoFunc;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, UniClientDataSet,
  Provider, untIControlePagtoFunc;

Type TCadFun = Class(TComponent, ICadFun)

  Private
    FcdsVerbas: TUniClientDataSet;

    procedure pAfterOpen(Dataset: TDataSet);
    procedure pInsereVerbasFuncionario(qryVerbas: TUniQuery);
  Public
    qryCadFun: TUniQuery;
    qryGenFun: TUniQuery;

    cdsResumo: TUniClientDataSet;

    function fRetornaSalarioBase(strCodFun: String; strCodEmp: String): Double;
    function fRetornaSalarioBasePeloAutoIncrem(AAutoincremFuncionario: String): Double;

    function fGeraRelatorio(strCodEmp,
                            strMesBas,
                            strTipMov,
                            strCodVen: String;
                            fltTotCom: Double = 0;
                            strCodVer: String = ''): Boolean;

    class function ExistemFuncoesCadastradasNaFormaAntiga: Boolean;
    class procedure CriaNovosRegistrosDeFuncoes;
    class procedure CorrigeCadastroDeFuncoes;
    class procedure RemoveFuncoesDuplicatasENaoUtilizadas;
    class procedure ReplicarTodasAsFuncoes(ARegistros: TDataset);

    class procedure AtualizaCadFncQueSeraUtilizado(AAutoIncrem: String);
    class function AtualizaCadastrosComOAutoincremDaFuncao(AAutoincrem, ACodigo, ARegistros: String): Boolean;

    procedure pGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure pSetText(Sender: TField; const Text: string);
    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; Override;

    function getCdsVerbas: TUniClientDataSet;
    procedure setCdsVerbas(Value: TUniClientDataSet);

    property cdsVerbas: TUniClientDataSet Read getCdsVerbas Write setCdsVerbas;
End;

Type TCadVer = Class(TComponent)

  Private

  Public
    qryCadVer: TUniQuery;
    qryGenVer: TUniQuery;

    function fMontaGrid(strMesBas, strCodEmp, ATipMov: String; blnVerbasUtilizadas : Boolean = False): TUniQuery;
    function fGravaVerbaSalBase: Boolean;
    function fRetornaSQLSelect : String;
    function fRetornaVerbasUtilizadas(strMesBas, strCodEmp: String): String;

    procedure AtualizaDadosDeVersoesAnteriores(AMesBas, ACodEmp, ATipMov: String);

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; Override;
End;

Type TCtrPag = Class(TComponent)

  Private

  Public
    qryCtrPag: TUniQuery;
    qryGenPag: TUniQuery;

    function fVerificaLancamento(AAutFun, strCodVer, strTipMov,
                                 strCodEmp: String; dtaMesBas: TDateTime; Var fltValLan: Double;
                                 var strAutCtp: String): Boolean;

    function fEhPlanilhaNova(AAutFun, strTipMov,strCodEmp: String;
                             dtaMesBas: TDateTime): Boolean;

    function fGravaLancamentos(strCodFun, strCodEmp, strCodVer, strDebCre,
      strTipMov: String; fltValLan: Double; dtaMesBas: TDateTime;
      AAutoIncremFuncionario: String): Boolean;
    function fApagaLancamento(strCodFun, strCodEmp, strCodVer, strTipMov: String; dtaMesBas: TDateTime; AAutoIncremFuncionario: String): Boolean;
    function fRetornaSQLInsert: String;
    function fRetornaSQLUpdate: String;
    function fRetornaSQLSelect: String;
    function fExcluiPlanilha(strMesBas, strTipMov, strCodEmp: String): Boolean;
    function ExcluiLancamentoPlanilha(AMesBas, ATipMov, ACodEmp, ACodFun, AAutFun: String): Boolean;
    function fRetValorLiquidoAntecipacaoFuncionario(AAutFun: String; AdtaMesBas: TDateTime; ACodEmp: String): Double;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; Override;

End;

type TMonQdr = Class(TComponent)

  private

  public
    qryGenQdr: TUniQuery;
    strAutoIn: String;

    function fExcluiQuadro(strCodEve: String): Boolean;
    function fGravarQuadro(strCodEve: String;
                           fltVlrTot: Double;
                           strCodEmp: String;
                           strCodFun: String;
                           strCodFnc: String;
                           intNroGer: Integer;
                           intNroFnc: Integer;
                           fltVlrFun: Double;
                           strOnibus: String;
                           intSeqGra: Integer;
                           AAutFun: String;
                           AAutFnc: String;
                           ADtaIni: TDateTime;
                           ADtaFim: TDateTime;
                           AGerCtr: String): Boolean;
    function fSQLSelect: String;
    function fSQLInsertGer: String;
    function fSQLInsertDet: String;
    function fSQLUpdateDet: String;

    procedure AtualizaDadosDeVersoesAnteriores(ACodEve, ACodEmp: String);

    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
End;

implementation

uses untFuncoesSimples, DateUtils;

{ TCadFun }

class function TCadFun.AtualizaCadastrosComOAutoincremDaFuncao(AAutoincrem,
  ACodigo, ARegistros: String): Boolean;
  Var
    LSQL: String;

    LExecutarScript: TUniQuery;
begin
  Try
    LExecutarScript := fCriaQuery;

    LSQL := '';
    LSQL := LSQL + 'UPDATE CADFUN SET ';
    LSQL := LSQL + '   FUN_FUNATU="' + ACodigo + '", ';
    LSQL := LSQL + '   FUN_AUTFNC="' + AAutoincrem + '" ';
    LSQL := LSQL + 'WHERE (FUN_FUNATU, FUN_CODEMP) IN (' + ARegistros + ') AND ';
    LSQL := LSQL + '       FUN_AUTFNC IS NULL ';

    LExecutarScript.SQL.Text := LSQL;
    LExecutarScript.ExecSQL;

    Result := LExecutarScript.RowsAffected > 0;

    LSQL := '';
    LSQL := LSQL + 'UPDATE EVEDET SET ';
    LSQL := LSQL + '   DET_CODFNC="' + ACodigo + '", ';
    LSQL := LSQL + '   DET_AUTFNC="' + AAutoincrem + '" ';
    LSQL := LSQL + 'WHERE (DET_CODFNC, DET_CODEMP) IN (' + ARegistros + ') AND ';
    LSQL := LSQL + '       DET_AUTFNC IS NULL ';

    LExecutarScript.Close;
    LExecutarScript.SQL.Text := LSQL;
    LExecutarScript.ExecSQL;

    If Not Result Then
      Result := LExecutarScript.RowsAffected > 0;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao atualizar os cadastros com a função. ' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

class procedure TCadFun.AtualizaCadFncQueSeraUtilizado(AAutoIncrem: String);
  Var
    LSQL: String;
begin
  Try
    LSQL := '';
    LSQL := LSQL + 'UPDATE CADFNC SET ';
    LSQL := LSQL + '   FNC_ATUALI="S" ';
    LSQL := LSQL + 'WHERE             ';
    LSQL := LSQL + '   AUTOINCREM="' + AAutoIncrem + '"';

    fExecutaSQL(LSQL);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao atualizar a função que será utilizada. ' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

class procedure TCadFun.CorrigeCadastroDeFuncoes;
  Var
    LConsulta,
    LFuncoesAtualizar: TUniQuery;

    LAutoIncrem,
    LCodigo,
    LRegistrosAtualizar: String;
begin
  Try
    LConsulta := fCriarQuery('SELECT FNC_NOMFNC FROM CADFNC WHERE       ' +
                             '   FNC_ATUALI="N"                         ' +
                             'GROUP BY FNC_NOMFNC                       ');
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    Try
      fStartTransaction;
      While Not LConsulta.Eof Do
      Begin
        LFuncoesAtualizar := fCriarQuery('SELECT * FROM CADFNC WHERE FNC_NOMFNC="' + LConsulta.FieldByName('FNC_NOMFNC').AsString + '" ' +
                                         'ORDER BY AUTOINCREM');
        LFuncoesAtualizar.Open;

        ReplicarTodasAsFuncoes(LFuncoesAtualizar);

        If Not LFuncoesAtualizar.Locate('FNC_ATUALI', 'S', []) Then
          LFuncoesAtualizar.First;

        LAutoIncrem := LFuncoesAtualizar.FieldByName('AUTOINCREM').AsString;
        LCodigo     := LFuncoesAtualizar.FieldByName('FNC_CODFNC').AsString;

        LRegistrosAtualizar := '("' + LFuncoesAtualizar.FieldByName('FNC_CODFNC').AsString + '",' +
                                '"' + LFuncoesAtualizar.FieldByName('FNC_CODEMP').AsString + '"),';

        LFuncoesAtualizar.First;

        While Not LFuncoesAtualizar.Eof Do
        Begin
          If LFuncoesAtualizar.FieldByName('AUTOINCREM').AsString <> LAutoIncrem Then
            LRegistrosAtualizar := LRegistrosAtualizar +
                                  '("' + LFuncoesAtualizar.FieldByName('FNC_CODFNC').AsString + '",' +
                                   '"' + LFuncoesAtualizar.FieldByName('FNC_CODEMP').AsString + '"),';
          LFuncoesAtualizar.Next;
        End;

        LRegistrosAtualizar := LeftStr(LRegistrosAtualizar, LRegistrosAtualizar.Length - 1);

        If AtualizaCadastrosComOAutoincremDaFuncao(LAutoIncrem, LCodigo, LRegistrosAtualizar) Then
          AtualizaCadFncQueSeraUtilizado(LAutoIncrem);

        LConsulta.Next;
      End;

      RemoveFuncoesDuplicatasENaoUtilizadas;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollback;

        pMensagensErro(E.Message, '[TCadFun.CorrigeCadastroDeFuncoesDuplicados]');
      End;
    End;
  Finally
    FreeAndNil(LConsulta);

    If Assigned(LFuncoesAtualizar) Then
      FreeAndNil(LFuncoesAtualizar);
  End;
end;

constructor TCadFun.Create(Owner: TComponent);
begin
  Inherited Create(Owner);
  qryCadFun := fCriaQuery(Self);
  qryCadFun.AfterOpen := pAfterOpen;

  qryCadFun.Close;
  qryCadFun.SQL.Clear;
  qryCadFun.SQL.Add('SELECT * FROM CADFUN WHERE FALSE');
  qryCadFun.Open;
  pSetaClient(qryCadFun);

  cdsVerbas := TUniClientDataSet.Create(Self);

  With cdsVerbas.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESVER';
    DataType := ftString;
    Size     := 50;
  End;

  With cdsVerbas.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NOMFUN';
    DataType := ftString;
    Size     := 50;
  End;

  With cdsVerbas.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODVER';
    DataType := ftString;
    Size     := 3;
  End;

  With cdsVerbas.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALLAN';
    DataType := ftFloat;
  End;

  With cdsVerbas.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODFUN';
    DataType := ftString;
    Size     := 6;
  End;

  With cdsVerbas.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VER_CODVER';
    DataType := ftString;
    Size     := 3;
  End;

  With cdsVerbas.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DEBCRE';
    DataType := ftString;
    Size     := 1;
  End;

  With cdsVerbas.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VER_DESVER';
    DataType := ftString;
    Size     := 50;
  End;

  With cdsVerbas.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'FUN_NOMFUN';
    DataType := ftString;
    Size     := 50;
  End;

  With cdsVerbas.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODDEB';
    DataType := ftString;
    Size     := 3;
  End;

  With cdsVerbas.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESDEB';
    DataType := ftString;
    Size     := 20;
  End;

  With cdsVerbas.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALDEB';
    DataType := ftFloat;
  End;

  With cdsVerbas.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'AUTFUN';
    DataType := ftString;
    Size     := 20;
  End;

  cdsVerbas.CreateDataSet;

  cdsResumo := TUniClientDataSet.Create(Self);

  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DEBCRE';
    DataType := ftString;
    Size     := 1;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESCRE';
    DataType := ftString;
    Size     := 20;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'TOTCRE';
    DataType := ftFloat;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESDEB';
    DataType := ftString;
    Size     := 20;
  End;

  With cdsResumo.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'TOTDEB';
    DataType := ftFloat;
  End;

  cdsResumo.CreateDataSet;

end;

destructor TCadFun.Destroy;
begin
  FreeAndNil(qryCadFun);
  inherited Destroy;
end;

function TCadFun.fGeraRelatorio(strCodEmp,
                                strMesBas,
                                strTipMov,
                                strCodVen: String;
                                fltTotCom: Double = 0;
                                strCodVer: String = ''): Boolean;
Var
  qryRelat   : TUniQuery;

  intQtdCre  : Integer;
  intPosDeb  : Integer;
  intIndFunc : Integer;

  stlFuncionarios: TStringList;

  function fRetSQLSelect: String;
  begin
    Result := '';
    Result := Result + 'SELECT   ';
    Result := Result + '  CONCAT(VER_CODVER, " - ", VER_DESVER) AS DESVER, ';
    Result := Result + '  CONCAT(PAG_CODFUN, " - ", FUN_NOMFUN) AS NOMFUN, ';
    Result := Result + '  PAG_CODVER     AS CODVER, ';
    Result := Result + '  PAG_VALLAN     AS VALLAN, ';
    Result := Result + '  PAG_CODFUN     AS CODFUN, ';
    Result := Result + '  VER_CODVER              , ';
    Result := Result + '  VER_DEBCRE     AS DEBCRE, ';
    Result := Result + '  VER_DESVER,               ';
    Result := Result + '  FUN_NOMFUN,               ';
    Result := Result + '  "   "          AS CODDEB, ';
    Result := Result + '  REPEAT(" ",20) AS DESDEB, ';
    Result := Result + '  0.00           AS VALDEB, ';
    Result := Result + '  PAG_AUTFUN     AS AUTFUN  ';
    Result := Result + 'FROM     ';
    Result := Result + '  CTRPAG ';
    Result := Result + '  LEFT JOIN CADFUN ON CADFUN.AUTOINCREM = PAG_AUTFUN ';
    Result := Result + '  LEFT JOIN CADVER ON VER_CODVER = PAG_CODVER     ';
    Result := Result + 'WHERE                                             ';

    If Not fEmptyStr(strCodVen) Then
      Result := Result + '  FUN_CODVEN = :CODVEN AND  ';

    If Not fEmptyStr(strCodVer) Then
      Result := Result + '  PAG_CODVER = :CODVER AND  ';

    Result := Result + '  PAG_MESBAS = :MESBAS AND  ';
    Result := Result + '  PAG_TIPMOV = :TIPMOV AND  ';
    Result := Result + '  PAG_CODEMP = :CODEMP AND  ';
    Result := Result + '  IF(FUN_DTADEM IS NOT NULL AND FUN_DTADEM <= :MESBAS, FALSE, TRUE) ';
    Result := Result + 'ORDER BY                    ';
    Result := Result + '  FUN_CODFUN,               ';
    Result := Result + '  VER_DEBCRE,               ';
    Result := Result + '  VER_CODVER                ';
  end;

  function fRetSQLResumo(strOpcSel: String): String;
  begin
    If (strOpcSel = 'C') Then
    Begin
      Result := '';
      Result := Result + 'SELECT   ';
      Result := Result + '  VER_DEBCRE                            AS DEBCRE, ';
      Result := Result + '  CONCAT(PAG_CODVER, " - ", VER_DESVER) AS DESCRE, ';
      Result := Result + '  SUM(IF(VER_DEBCRE = "D",PAG_VALLAN * (-1), PAG_VALLAN)) AS TOTCRE, ';
      Result := Result + '  REPEAT(" ",20)                        AS DESDEB, ';
      Result := Result + '  0.00                                  AS TOTDEB  ';
      Result := Result + 'FROM     ';
      Result := Result + '  CTRPAG ';
      Result := Result + '  LEFT JOIN CADVER ON VER_CODVER = PAG_CODVER     ';
      Result := Result + '  LEFT JOIN CADFUN ON CADFUN.AUTOINCREM = PAG_AUTFUN ';
      Result := Result + 'WHERE                                             ';
      Result := Result + '  PAG_MESBAS = :MESBAS AND  ';
      Result := Result + '  PAG_TIPMOV = :TIPMOV AND  ';

      If Not fEmptyStr(strCodVer) Then
        Result := Result + '  PAG_CODVER = :CODVER AND  ';

      Result := Result + '  PAG_CODEMP = :CODEMP AND  ';
      Result := Result + '  IF(FUN_DTADEM IS NOT NULL AND FUN_DTADEM <= :MESBAS, FALSE, TRUE) ';
      Result := Result + 'GROUP BY                    ';
      Result := Result + '  DESCRE,                   ';
      Result := Result + '  DEBCRE                    ';
      Result := Result + 'ORDER BY                    ';
      Result := Result + '  DESCRE,                   ';
      Result := Result + '  DEBCRE                    ';
    End
    Else
    Begin
      Result := Result + 'SELECT   ';
      Result := Result + '  VER_DEBCRE AS DEBCRE, ';
      Result := Result + '  VER_DESVER AS DESCRE, ';
      Result := Result + '  PAG_VALLAN AS TOTCRE, ';
      Result := Result + '  VER_DESVER AS DESDEB, ';
      Result := Result + '  PAG_VALLAN AS TOTDEB  ';
      Result := Result + 'FROM     ';
      Result := Result + '  CTRPAG ';
      Result := Result + '  LEFT JOIN CADVER ON VER_CODVER = PAG_CODVER     ';
      Result := Result + 'WHERE                                             ';
      Result := Result + '  FALSE                                           ';
    End;
  end;

begin
  inherited;

  Result := False;

  Try

    stlFuncionarios := TStringList.Create;
    stlFuncionarios.Sorted := True;
    stlFuncionarios.Duplicates := dupIgnore;

    qryRelat := fCriaQuery(Self);
   {*****************************}
   {* CARREGA OS DADOS DA FOLHA *}
   {**************************PZ*}
    With qryRelat Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetSQLSelect);

      If Not fEmptyStr(strCodVen) Then
        ParamByName('CODVEN').AsString := strCodVen;

      If Not fEmptyStr(strCodVer) Then
        ParamByName('CODVER').AsString := strCodVer;

      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('MESBAS').AsDate   := strToDate('01/' + strMesBas);
      ParamByName('TIPMOV').AsString := strTipMov;

      Open;
      pSetaClient(qryRelat);
    End;
    {*********************************************}
    {* AQUI IRÁ INTERCALAR OS CRÉDITOS E DÉBITOS *}
    {* PARA SER POSSÍVEL IMPRIMIR OS CRÉDITOS E  *}
    {* DEBITOS EM COLUNAS SEPARADAS.             *}
    {******************************************PZ*}
    With qryRelat Do
    Begin
      cdsVerbas.EmptyDataSet;
      cdsVerbas.IndexFieldNames := '';

      First;

      While Not Eof Do
      Begin
        stlFuncionarios.Add(FieldByName('AUTFUN').AsString);
        Next;
      End;

      For intIndFunc := 0 To stlFuncionarios.Count -1 Do
      Begin
        Filtered := False;
        Filter   := 'AUTFUN = ' + QuotedStr(stlFuncionarios[intIndFunc]);
        Filtered := True;

        pInsereVerbasFuncionario(qryRelat);
      End;

      Filter   := '';
      Filtered := False;

      If (fltTotCom <> 0) Then
      Begin
        cdsVerbas.Append;

        If (fltTotCom > 0) Then
        Begin
          cdsVerbas.FieldByName('VER_DESVER').AsString := '000 - COMISSAO';
          cdsVerbas.FieldByName('VER_CODVER').AsString := '000';
          cdsVerbas.FieldByName('FUN_NOMFUN').AsString := FieldByName('FUN_NOMFUN').AsString;

          cdsVerbas.FieldByName('CODVER').AsString := '000';
          cdsVerbas.FieldByName('DESVER').AsString := '000 - COMISSAO';
          cdsVerbas.FieldByName('VALLAN').AsFloat  := fltTotCom;
          cdsVerbas.FieldByName('CODFUN').AsString := FieldByName('CODFUN').AsString;
          cdsVerbas.FieldByName('NOMFUN').AsString := FieldByName('NOMFUN').AsString;
          cdsVerbas.FieldByName('DEBCRE').AsString := 'C';

          cdsVerbas.FieldByName('CODDEB').AsString := '.';
          cdsVerbas.FieldByName('DESDEB').AsString := '.';
          cdsVerbas.FieldByName('VALDEB').AsFloat  := 0;
          cdsVerbas.FieldByName('AUTFUN').AsString := FieldByName('AUTFUN').AsString;
          cdsVerbas.Post;
        End
        Else
        Begin
          cdsVerbas.FieldByName('CODFUN').AsString := FieldByName('CODFUN').AsString;
          cdsVerbas.FieldByName('NOMFUN').AsString := FieldByName('NOMFUN').AsString;
          cdsVerbas.FieldByName('DEBCRE').AsString := 'D';

          cdsVerbas.FieldByName('CODDEB').AsString := '000';
          cdsVerbas.FieldByName('DESDEB').AsString := '000 - COMISSAO';
          cdsVerbas.FieldByName('VALDEB').AsFloat  := fltTotCom;
          cdsVerbas.Post;
        End;
      End;

    End;

    {**********************************}
    {* CARREGA OS DADOS PARA O RESUMO *}
    {*******************************PZ*}
    With qryRelat Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetSQLResumo('C'));

      If Not fEmptyStr(strCodVer) Then
        ParamByName('CODVER').AsString := strCodVer;

      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('MESBAS').AsDate   := strToDate('01/' + strMesBas);
      ParamByName('TIPMOV').AsString := strTipMov;
      Open;
      pSetaClient(qryRelat);
      First;

      intQtdCre := 0;
      cdsResumo.EmptyDataSet;

      {************************************}
      {* GRAVA TODAS AS VERBAS DE CRÉDITO *}
      {*********************************PZ*}
      While Not Eof Do
      Begin
        If (FieldByName('DEBCRE').AsString = 'C') Then
        Begin
          cdsResumo.Append;
          cdsResumo.FieldByName('DEBCRE').AsString := FieldByName('DEBCRE').AsString;
          cdsResumo.FieldByName('DESCRE').AsString := FieldByName('DESCRE').AsString;
          cdsResumo.FieldByName('TOTCRE').AsFloat  := FieldByName('TOTCRE').AsFloat;
          cdsResumo.FieldByName('DESDEB').AsString := '.';
          cdsResumo.FieldByName('TOTDEB').AsFloat  := 0;
          Inc(intQtdCre);
          cdsResumo.Post;
        End;
        Next;
      End;

      First;
      intPosDeb := 1;

      {*****************************}
      {* GRAVA AS VERBAS DE DÉBITO *}
      {**************************PZ*}
      While Not Eof Do
      Begin
        If (FieldByName('DEBCRE').AsString = 'D') Then
        Begin
          {*********************************************}
          {* CONTROLA SE IRÁ GRAVAR O DEBITO NA MESMA  *}
          {* LINHA DO CRÉDITO OU SE INSERE NOVA LINHA. *}
          {* ISSO SERVE PARA MOSTRAR AS COLUNAS DE     *}
          {* CREDITO E DEBITO SEPARADAS NO RELATORIO.  *}
          {******************************************PZ*}
          If (intQtdCre >= intPosDeb) Then
          Begin
            cdsResumo.RecNo := intPosDeb;
            cdsResumo.Edit;
            cdsResumo.FieldByName('DESDEB').AsString := FieldByName('DESCRE').AsString;
            cdsResumo.FieldByName('TOTDEB').AsFloat  := FieldByName('TOTCRE').AsFloat;
          End
          Else
          Begin
            cdsResumo.Append;
            cdsResumo.FieldByName('DEBCRE').AsString := FieldByName('DEBCRE').AsString;
            cdsResumo.FieldByName('DESCRE').AsString := '.';
            cdsResumo.FieldByName('TOTCRE').AsFloat  := 0;
            cdsResumo.FieldByName('DESDEB').AsString := FieldByName('DESCRE').AsString;
            cdsResumo.FieldByName('TOTDEB').AsFloat  := FieldByName('TOTCRE').AsFloat;
          End;
          Inc(intPosDeb);
          cdsResumo.Post;
        End;
        Next;
      End;
    End;

    cdsVerbas.IndexFieldNames := 'FUN_NOMFUN;VER_CODVER';

    Result := Not cdsVerbas.IsEmpty;

    FreeAndNil(stlFuncionarios);

  Except
    On E: Exception Do
    Begin
      fMensagem('',E.Message,['&OK']);
    End;
  End;
  
end;

function TCadFun.fRetornaSalarioBase(strCodFun: String; strCodEmp: String): Double;
Var
  strSQL: String;
begin
  Result := 0.0;
  Try
    qryGenFun := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  FUN_SALBAS AS SALBAS ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADFUN ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  FUN_CODFUN = :CODFUN ';
    strSQL := strSQL + '  AND FUN_CODEMP = :CODEMP ';

    With qryGenFun Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFUN').AsString := strCodFun;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      pSetaClient(qryGenFun);

      Result := FieldByName('SALBAS').AsFloat;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TCadFun.fRetornaSalarioBase]');
  End;
  freeAndNil(qryGenFun);
end;

function TCadFun.fRetornaSalarioBasePeloAutoIncrem(
  AAutoincremFuncionario: String): Double;
  Var
    LSQL: String;
begin
  Result := 0.0;
  Try
    qryGenFun := fCriaQuery(Nil);

    LSQL := '';
    LSQL := LSQL + 'SELECT   ';
    LSQL := LSQL + '  FUN_SALBAS AS SALBAS ';
    LSQL := LSQL + 'FROM     ';
    LSQL := LSQL + '  CADFUN ';
    LSQL := LSQL + 'WHERE    ';
    LSQL := LSQL + '  AUTOINCREM = :AUTFUN ';

    qryGenFun.Close;
    qryGenFun.SQL.Clear;
    qryGenFun.SQL.Text := LSQL;
    qryGenFun.ParamByName('AUTFUN').AsString := AAutoincremFuncionario;
    qryGenFun.Open;
    pSetaClient(qryGenFun);

    Result := qryGenFun.FieldByName('SALBAS').AsFloat;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TCadFun.fRetornaSalarioBase]');
  End;
  freeAndNil(qryGenFun);
end;

class procedure TCadFun.CriaNovosRegistrosDeFuncoes;
  Var
    LRegistrosFuncoes,
    LConsulta: TUniQuery;
begin
  Try
    LRegistrosFuncoes := fCriarQuery('SELECT * FROM CADFNC');
    LRegistrosFuncoes.Open;

    If Not LRegistrosFuncoes.IsEmpty Then
      Exit;

    fRetAutoIncrem('CADFNC', VS_strCodEmp);


    LConsulta := fCriarQuery('SELECT fRetAutoIncrem("CADFNC", "' + VS_strCodEmp + '") AS AUTINC, ' +
                             '       FUN_FUNCAO FROM CADFUN ' +
                             'WHERE FUN_FUNCAO IS NOT NULL AND ' +
                             '      FUN_FUNCAO <> "" GROUP BY FUN_FUNCAO');
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    fStartTransaction;

    While Not LConsulta.Eof Do
    Begin
      LRegistrosFuncoes.Append;
      LRegistrosFuncoes.FieldByName('AUTOINCREM').AsString := LConsulta.FieldByName('AUTINC').AsString;
      LRegistrosFuncoes.FieldByName('FNC_CODFNC').AsString := fAtualizaProCod('CADFNC', 'FNC_CODFNC');
      LRegistrosFuncoes.FieldByName('FNC_NOMFNC').AsString := LConsulta.FieldByName('FUN_FUNCAO').AsString;
      LRegistrosFuncoes.FieldByName('FNC_CODEMP').AsString := fRetEmpresaFisica;
      LRegistrosFuncoes.FieldByName('FNC_ATUALI').AsString := 'S';
      LRegistrosFuncoes.Post;

      fExecutaSQL('UPDATE CADFUN SET FUN_AUTFNC="' + LRegistrosFuncoes.FieldByName('AUTOINCREM').AsString + '", ' +
                  '                  FUN_FUNATU="' + LRegistrosFuncoes.FieldByName('FNC_CODFNC').AsString + '" ' +
                  'WHERE FUN_FUNCAO="' + LConsulta.FieldByName('FUN_FUNCAO').AsString + '"');

      LConsulta.Next;
    End;

    fCommit;
  Finally
    FreeAndNil(LRegistrosFuncoes);

    If Assigned(LConsulta) Then
      FreeAndNil(LConsulta);
  End;
end;

function TCadFun.getCdsVerbas: TUniClientDataSet;
begin
  Result := FcdsVerbas;
end;

procedure TCadFun.pAfterOpen(Dataset: TDataSet);
  Const
    cTimeMsk = '99:99';
  Var
    intCnt: Integer;
begin
  TDateField(qryCadFun.FieldByName('FUN_DTAADM')).EditMask       := '99/99/9999;1;_';
  TDateField(qryCadFun.FieldByName('FUN_DTADEM')).EditMask       := '99/99/9999;1;_';
  TDateField(qryCadFun.FieldByName('FUN_VALHAB')).EditMask       := '99/99/9999;1;_';
  TFloatField(qryCadFun.FieldByname('FUN_SALBAS')).DisplayFormat := '#,##0.00';

  TDateField(qryCadFun.FieldByName('FUN_DTANAS')).EditMask       := '99/99/9999;1;_';
  TStringField(qryCadFun.FieldByName('FUN_C_P_F_')).EditMask     := '999.999.999-99;0;';

  For intCnt:= 1 To 4 Do
  Begin
    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'DOM')).EditMask := cTimeMsk;
    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'DOM')).OnGetText := pGetText;
    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'DOM')).OnSetText := pSetText;

    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'SEG')).EditMask := cTimeMsk;
    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'SEG')).OnGetText := pGetText;
    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'SEG')).OnSetText := pSetText;

    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'TER')).EditMask := cTimeMsk;
    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'TER')).OnGetText := pGetText;
    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'TER')).OnSetText := pSetText;

    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'QUA')).EditMask := cTimeMsk;
    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'QUA')).OnGetText := pGetText;
    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'QUA')).OnSetText := pSetText;

    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'QUI')).EditMask := cTimeMsk;
    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'QUI')).OnGetText := pGetText;
    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'QUI')).OnSetText := pSetText;

    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'SEX')).EditMask := cTimeMsk;
    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'SEX')).OnGetText := pGetText;
    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'SEX')).OnSetText := pSetText;

    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'SAB')).EditMask := cTimeMsk;
    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'SAB')).OnGetText := pGetText;
    TTimeField(qryCadFun.FieldByname('FUN_HT'+IntToStr(intCnt)+'SAB')).OnSetText := pSetText;
  End;


end;

procedure TCadFun.pGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  If Not Sender.IsNull Then
    Text := FormatDateTime('hh:nn:ss', Sender.AsDateTime)
  Else
    Text := '';
end;

procedure TCadFun.pSetText(Sender: TField; const Text: string);
begin
  If Trim(Text) = ':' Then
    Sender.Clear
  Else
  Begin
    If Length(Trim(Text)) = 3 Then
      Sender.AsString := Text + '00'
    Else
      Sender.AsString := Text;
  End;
end;

class procedure TCadFun.RemoveFuncoesDuplicatasENaoUtilizadas;
  Var
    LSQL: String;
begin
  Try
    LSQL := '';
    LSQL := LSQL + 'DELETE FROM CADFNC ';
    LSQL := LSQL + 'WHERE FNC_ATUALI="N" ';
    LSQL := LSQL + '  AND AUTOINCREM NOT IN ( ';

    LSQL := LSQL + '      SELECT IFNULL(FUN_AUTFNC, "") FROM CADFUN GROUP BY FUN_AUTFNC ';
    LSQL := LSQL + '      UNION ';
    LSQL := LSQL + '      SELECT IFNULL(DET_AUTFNC, "") FROM EVEDET GROUP BY DET_AUTFNC ';
    LSQL := LSQL + ')';

    fExecutaSQL(LSQL);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao remover as funções inutilizadas. ' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

class procedure TCadFun.ReplicarTodasAsFuncoes(ARegistros: TDataset);
  Var
    LSQL: String;
begin
  {***************************************}
  {* É NECESSÁRIO PARA REPLICAR A FUNÇÃO *}
  {* COM O AUTOINCREM UTILIZADO          *}
  {************************************AJ*}

  If ARegistros.IsEmpty Then
    Exit;

  Try
    ARegistros.First;
    While Not ARegistros.Eof Do
    Begin
      If ARegistros.FieldByName('FNC_ATUALI').AsString <> 'S' Then
      Begin
        LSQL := '';
        LSQL := LSQL + 'REPLACE INTO CADFNC (';
        LSQL := LSQL + '   AUTOINCREM,       ';
        LSQL := LSQL + '   FNC_CODFNC,       ';
        LSQL := LSQL + '   FNC_CODEMP,       ';
        LSQL := LSQL + '   FNC_NOMFNC,       ';
        LSQL := LSQL + '   FNC_ATUALI        ';
        LSQL := LSQL + ') VALUES (           ';
        LSQL := LSQL + '  "' + ARegistros.FieldByName('AUTOINCREM').AsString + '", ';
        LSQL := LSQL + '  "' + ARegistros.FieldByName('FNC_CODFNC').AsString + '", ';
        LSQL := LSQL + '  "' + ARegistros.FieldByName('FNC_CODEMP').AsString + '", ';
        LSQL := LSQL + '  "' + ARegistros.FieldByName('FNC_NOMFNC').AsString + '", ';
        LSQL := LSQL + '  "' + ARegistros.FieldByName('FNC_ATUALI').AsString + '")';

        fExecutaSQL(LSQL);
      End;

      ARegistros.Next;
    End;

    Sleep(800);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao replicar as funções. ' + #13 +
                             'Erro gerado: ' + E.Message);
  End;

  ARegistros.First;
end;

procedure TCadFun.setCdsVerbas(Value: TUniClientDataSet);
begin
  FcdsVerbas := Value;
end;

{ TCadVer }

procedure TCadVer.AtualizaDadosDeVersoesAnteriores(AMesBas, ACodEmp,
  ATipMov: String);
  Var
    LSQL: String;
begin
  If fRetSomenteNumeros(AMesBas).IsEmpty Then
    Exit;

  Try
    LSQL := 'UPDATE CTRPAG SET PAG_AUTFUN=(              ';
    LSQL := LSQL + 'SELECT CADFUN.AUTOINCREM FROM CADFUN ';
    LSQL := LSQL + '      WHERE FUN_CODFUN=PAG_CODFUN    ';
    LSQL := LSQL + '        AND FUN_CODEMP=PAG_CODEMP    ';
    LSQL := LSQL + '        LIMIT 1)                     ';
    LSQL := LSQL + ' WHERE                               ';
    LSQL := LSQL + '   PAG_MESBAS = "' + FormatDateTime('yyyy/mm/dd', StrToDate('01/' + AMesBas)) + '" AND ';
    LSQL := LSQL + '   PAG_CODEMP = "' + ACodEmp + '" AND ';
    LSQL := LSQL + '   PAG_TIPMOV = "' + ATipMov + '" AND ';
    LSQL := LSQL + '   PAG_AUTFUN IS NULL                 ';

    fExecutaSQL(LSQL);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

constructor TCadVer.Create(Owner: TComponent);
begin
  Inherited Create(Owner);
  qryGenVer := fCriaQuery(Self);
  qryCadVer := fCriaQuery(Self);

  qryCadVer.Close;
  qryCadVer.SQL.Clear;
  qryCadVer.SQL.Add('SELECT * FROM CADVER WHERE FALSE');
  qryCadVer.Open;
  pSetaClient(qryCadVer);
end;

destructor TCadVer.Destroy;
begin
  FreeAndNil(qryCadVer);
  FreeAndNil(qryGenVer);
  inherited Destroy;
end;

function TCadVer.fMontaGrid(strMesBas, strCodEmp, ATipMov: String; blnVerbasUtilizadas : Boolean = False): TUniQuery;
Var
  strSQL   : String;
  strNomCol: String;
  intNumCol: Integer;
begin
  Result := nil;
  Try
    AtualizaDadosDeVersoesAnteriores(strMesBas, strCodEmp, ATipMov);

    strSQL := '';
    strSQL := strSQL + 'SELECT        ';
    strSQL := strSQL + '  VER_CODVER, ';
    strSQL := strSQL + '  VER_DESVER, ';
    strSQL := strSQL + '  VER_DEBCRE  ';
    strSQL := strSQL + 'FROM          ';
    strSQL := strSQL + '  CADVER      ';
    strSQL := strSQL + 'WHERE         ';
    strSQL := strSQL + '  VER_CODVER <> :CODVER AND ((VER_SALBAS = "N") OR (VER_SALBAS IS NULL))';
    strSQL := strSQL + '  AND VER_STATUS = "S"  ';
    If blnVerbasUtilizadas Then
      strSQL := strSQL + fRetornaVerbasUtilizadas(strMesBas,strCodEmp);
    strSQL := strSQL + 'ORDER BY      ';
    strSQL := strSQL + '  VER_DEBCRE, ';
    strSQL := strSQL + '  VER_DESVER  ';

    With qryGenVer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODVER').AsString := '001';

      Open;
      pSetaClient(qryGenVer);

      intNumCol := 1;
      First;

      While Not Eof Do
      Begin
        If (intNumCol = 1) Then
        Begin
          strNomCol := '0.00 AS ' + QuotedStr(FieldByName('VER_CODVER').AsString + '-'   +
                                              FieldByName('VER_DEBCRE').AsString + ' - ' +
                                              AnsiReplaceStr(FieldByName('VER_DESVER').AsString,'.','_'));
        End
        Else
        Begin
          strNomCol := strNomCol + ',' + '0.00 AS ' +
                       QuotedStr(FieldByName('VER_CODVER').AsString + '-'   +
                                 FieldByName('VER_DEBCRE').AsString + ' - ' +
                                 AnsiReplaceStr(FieldByName('VER_DESVER').AsString,'.','_'));

        End;

        Inc(intNumCol);
        Next;
      End;

      If (Not fEmptyStr(strNomCol)) Then
        strNomCol := strNomCol + ' ,0.00 AS "LIQUIDO_RECEBER"'
      Else
        strNomCol := strNomCol + ' 0.00 AS "LIQUIDO_RECEBER"';


      strNomCol := strNomCol + ', "" AS CTAPAG, "" AS STATUS, "" AS HISTORICO ';
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT        ';
    strSQL := strSQL + '  FUN_CODFUN, FUN_NOMFUN, ';
    strSQL := strSQL + '  FUN_SALBAS AS "001-C - SALARIO BASE", ';
    strSQL := strSQL + strNomCol + ', ';
    strSQL := strSQL + ' AUTOINCREM AS AUTFUN ';
    strSQL := strSQL + 'FROM          ';
    strSQL := strSQL + '  CADFUN      ';
    strSQL := strSQL + 'WHERE         ';
    strSQL := strSQL + '  FUN_CODEMP = :CODEMP AND   ';
    strSQL := strSQL + '  FUN_DTAADM <= :DTABAS AND ';

    If Not (fEmptyStr(fTiraCaracEspeciais(strMesBas))) Then
    Begin
      strSQL := strSQL + '  IF(FUN_DTADEM IS NOT NULL, ';
      strSQL := strSQL + '     FUN_DTADEM >= :DTABAS,  ';
      strSQL := strSQL + '     TRUE)    ';

      //Pegando dados de registros já criados na CTRPAG
      strSQL := strSQL + ' UNION        ';
      strSQL := strSQL + 'SELECT        ';
      strSQL := strSQL + '  FUN_CODFUN, FUN_NOMFUN, ';
      strSQL := strSQL + '  FUN_SALBAS AS "001-C - SALARIO BASE", ';
      strSQL := strSQL + strNomCol + ', ';
      strSQL := strSQL + ' PAG_AUTFUN AS AUTFUN ';
      strSQL := strSQL + 'FROM          ';
      strSQL := strSQL + '  CTRPAG      ';
      strSQL := strSQL + '  JOIN CADFUN ON CADFUN.AUTOINCREM=PAG_AUTFUN ';
      strSQL := strSQL + 'WHERE         ';
      strSQL := strSQL + '     PAG_MESBAS = "' + FormatDateTime('yyyy/mm/dd', StrToDate('01/' + strMesBas)) + '" AND ';
      strSQL := strSQL + '     PAG_TIPMOV = "' + ATipMov + '" AND ';
      strSQL := strSQL + '     PAG_CODEMP = :CODEMP     ';
    End
    Else
      strSQL := strSQL + '  IF(FUN_DTADEM IS NULL,"",FUN_DTADEM) = :DTADEM  ';

    strSQL := strSQL + 'ORDER BY      ';
    strSQL := strSQL + '  FUN_NOMFUN  ';

    With qryGenVer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODEMP').AsString := strCodEmp;

      If (fEmptyStr(fTiraCaracEspeciais(strMesBas))) Then
      Begin
        ParamByName('DTADEM').Value := '';
      End
      Else
      Begin
        ParamByName('DTABAS').AsDate := StrToDate(DaysInMonth(strToDate('01/' + strMesBas)).ToString + '/' + strMesBas);
      End;

      Open;
      pSetaClient(qryGenVer);
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TCadVer.fMontaGrid]');
  End;
end;

function TCadVer.fGravaVerbaSalBase: Boolean;
Var
  strSQL: String;
begin
  Result := True;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  VER_CODVER ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADVER ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  VER_CODVER = :CODVER ';

    With qryGenVer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODVER').AsString := '001';
      Open;
      pSetaClient(qryGenVer);
    End;

    If (qryGenVer.IsEmpty) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO ';
      strSQL := strSQL + '  CADVER(AUTOINCREM,  ';
      strSQL := strSQL + '         VER_CODEMP,  ';
      strSQL := strSQL + '         VER_CODVER,  ';
      strSQL := strSQL + '         VER_DESVER,  ';
      strSQL := strSQL + '         VER_DEBCRE)  ';
      strSQL := strSQL + '  VALUES(:AUTOIN,     ';
      strSQL := strSQL + '         :CODEMP,     ';
      strSQL := strSQL + '         :CODVER,     ';
      strSQL := strSQL + '         :DESVER,     ';
      strSQL := strSQL + '         :DEBCRE)     ';

      With qryGenVer Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTOIN').AsString := fRetAutoIncrem('CADVER',VS_strCodEmp);
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODVER').AsString := '001';
        ParamByName('DESVER').AsString := 'SALARIO BASE';
        ParamByName('DEBCRE').AsString := 'C';
        ExecSQL;
      End;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TCadVer.fGravaVerbaSalBase]');
  End;
end;

function TCadVer.fRetornaSQLSelect: String;
Var
  strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT   ';
  strSQL := strSQL + '  VER_CODVER, ';
  strSQL := strSQL + '  VER_DESVER  ';
  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  CADVER ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  VER_DEBCRE, ';
  strSQL := strSQL + '  VER_CODVER  ';

  Result := strSQL;
end;

class function TCadFun.ExistemFuncoesCadastradasNaFormaAntiga: Boolean;
  Var
    LRegistros: TUniQuery;
begin
  Try
    LRegistros := fCriarQuery('SELECT * FROM CADFNC WHERE FNC_ATUALI="N"');
    LRegistros.Open;

    Result := Not LRegistros.IsEmpty;
  Finally
    FreeAndNil(LRegistros);
  End;
end;

function TCadVer.fRetornaVerbasUtilizadas(strMesBas, strCodEmp: String): String;
  Var qryAux : TUniQuery;
       strSQL,
       strVerbas: String;
       intCount: Integer;
begin
  Result := '';
  intCount := 1;
  qryAux := fCriaQuery;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + ' DISTINCT PAG_CODVER  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CTRPAG A ';
    strSQL := strSQL + '  INNER JOIN CADVER B ON B.VER_CODVER = A.PAG_CODVER  ';
    strSQL := strSQL + 'WHERE PAG_CODEMP = :CODEMP   ';
    strSQL := strSQL + '  AND PAG_MESBAS = :MESBAS   ';
    strSQL := strSQL + '  AND B.VER_SALBAS <> "S"    ';
    strSQL := strSQL + '  AND PAG_CODVER <> 001      ';

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('MESBAS').AsDate   := strToDate('01/' + strMesBas);
      Open;
      qryAux.First;
      strVerbas := ' OR  ';
      While Not Eof Do
      Begin
          strVerbas := strVerbas +'  VER_CODVER =   '+  qryAux.FieldByName('PAG_CODVER').AsString +' ' ;
        If (RecordCount > 1) And (intCount <> RecordCount) Then
        Begin
          Inc(intCount);
          strVerbas := strVerbas + ' OR ';
        End;
        Next;
      End;
      If IsEmpty Then
        Result := ''
      Else
        Result := strVerbas;
    End;
  Finally
    Begin
      FreeAndNil(qryAux);
    End;
  End;
end;


{ TCtrPag }

constructor TCtrPag.Create(Owner: TComponent);
begin
  Inherited Create(Owner);
  qryCtrPag := fCriaQuery(Self);
end;

destructor TCtrPag.Destroy;
begin
  FreeAndNil(qryCtrPag);
  inherited Destroy;
end;

function TCtrPag.fApagaLancamento(strCodFun, strCodEmp, strCodVer,
  strTipMov: String; dtaMesBas: TDateTime; AAutoIncremFuncionario: String): Boolean;
Var
  strSQL: String;
begin
  Result := False;
  Try
    qryGenPag := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  CTRPAG    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  PAG_MESBAS = :MESBAS AND ';
    strSQL := strSQL + '  PAG_TIPMOV = :TIPMOV AND ';
    strSQL := strSQL + '  PAG_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PAG_CODFUN = :CODFUN AND ';
    strSQL := strSQL + '  PAG_CODVER = :CODVER AND ';
    strSQL := strSQL + '  PAG_AUTFUN = :AUTFUN     ';

    With qryGenPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('MESBAS').AsDate   := dtaMesBas;
      ParamByName('TIPMOV').AsString := strTipMov;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODFUN').AsString := strCodFun;
      ParamByName('CODVER').AsString := strCodVer;
      ParamByName('AUTFUN').AsString := AAutoIncremFuncionario;
      ExecSQL;
      Result := True;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TCtrPag.fExcluiPlanilha]');
  End;
  FreeAndNil(qryGenPag);
end;

function TCtrPag.fEhPlanilhaNova(AAutFun, strTipMov, strCodEmp: String;
                                 dtaMesBas: TDateTime): Boolean;
Var
  strSQL: String;
begin
  Result := False;
  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  PAG_VALLAN, ';
    strSQL := strSQL + '  PAG_AUTCTP  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CTRPAG ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  PAG_AUTFUN = :AUTFUN AND ';
    strSQL := strSQL + '  PAG_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PAG_MESBAS = :MESBAS AND ';
    strSQL := strSQL + '  PAG_TIPMOV = :TIPMOV     ';
    strSQL := strSQL + '  LIMIT 1                  ';

    With qryCtrPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AUTFUN').AsString := AAutFun;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('MESBAS').AsDate   := dtaMesBas;
      ParamByName('TIPMOV').AsString := strTipMov;

      Open;
      pSetaClient(qryCtrPag);
    End;

    Result := (qryCtrPag.RecordCount = 0);

  Except
    On E:Exception Do
      pMensagensErro(E.Message,'[TCtrPag.fEhPlanilhaNova]');
  End;

end;

function TCtrPag.fExcluiPlanilha(strMesBas, strTipMov, strCodEmp: String): Boolean;
Var
  strSQL: String;
begin
  Result := False;
  Try
    qryGenPag := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  CTRPAG    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  PAG_MESBAS = :MESBAS AND   ';
    strSQL := strSQL + '  PAG_TIPMOV = :TIPMOV AND   ';
    strSQL := strSQL + '  PAG_CODEMP = :CODEMP       ';

    With qryGenPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('MESBAS').AsDate   := strToDate('01/'+ strMesBas);
      ParamByName('TIPMOV').AsString := strTipMov;
      ParamByName('CODEMP').AsString := strCodEmp;
      ExecSQL;
      Result := True;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TCtrPag.fExcluiPlanilha]');
  End;
  FreeAndNil(qryGenPag);
end;

function TCtrPag.ExcluiLancamentoPlanilha(AMesBas, ATipMov, ACodEmp, ACodFun, AAutFun: String): Boolean;
  Var
    LSQL: String;

    LRegistro: TUniQuery;
begin
  Result := True;
  Try
    LRegistro := fCriaQuery;

    LSQL := '';
    LSQL := LSQL + 'DELETE FROM ';
    LSQL := LSQL + '  CTRPAG    ';
    LSQL := LSQL + 'WHERE       ';
    LSQL := LSQL + '  PAG_MESBAS = :MESBAS AND ';
    LSQL := LSQL + '  PAG_TIPMOV = :TIPMOV AND ';
    LSQL := LSQL + '  PAG_CODEMP = :CODEMP AND ';
    LSQL := LSQL + '  PAG_CODFUN = :CODFUN AND ';
    LSQL := LSQL + '  PAG_AUTFUN = :AUTFUN     ';

    LRegistro.SQL.Text := LSQL;
    LRegistro.ParamByName('MESBAS').AsDate   := strToDate('01/'+ AMesBas);
    LRegistro.ParamByName('TIPMOV').AsString := ATipMov;
    LRegistro.ParamByName('CODEMP').AsString := ACodEmp;
    LRegistro.ParamByName('CODFUN').AsString := ACodFun;
    LRegistro.ParamByName('AUTFUN').AsString := AAutFun;
    LRegistro.ExecSQL;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao excluir o lançamento da planilha. ' + #13 +
                             'Erro gerado: ' + E.Message);
  End;

  FreeAndNil(LRegistro);
end;

function TCtrPag.fGravaLancamentos(strCodFun, strCodEmp, strCodVer, strDebCre,
  strTipMov: String; fltValLan: Double; dtaMesBas: TDateTime;
  AAutoIncremFuncionario: String): Boolean;
Var
  strSQL   : String;
  fltValVer: Double;
  blnUpdate: Boolean;
  strAutCtp: String;
begin
  blnUpdate := False;
  fltValVer := 0;
  If fVerificaLancamento(AAutoIncremFuncionario, strCodVer, strTipMov, strCodEmp, dtaMesBas, fltValVer, strAutCtp) Then
    blnUpdate := True;

  Result := False;
  Try
    If Not blnUpdate Then
      strSQL    := fRetornaSQLInsert
    Else
      strSQL    := fRetornaSQLUpdate;

    With qryCtrPag do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not blnUpdate Then
        ParamByName('AUTOIN').AsString := fRetAutoIncrem('CTRPAG', VS_strCodEmp);

      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODFUN').AsString := strCodFun;
      ParamByName('CODVER').AsString := strCodVer;
      ParamByName('VALLAN').AsFloat  := IIF(strDebCre = 'C', fltValLan, (-1) * fltValLan);
      ParamByName('MESBAS').AsDate   := dtaMesBas;
      ParamByName('TIPMOV').AsString := strTipMov;
      ParamByName('AUTFUN').AsString := AAutoIncremFuncionario;

      ExecSQL;
    End;

    Result := True;

  Except
    On E:Exception Do
      pMensagensErro(E.Message,'[TCtrPag.fGravaLancamentos]');
  End;
end;

function TCtrPag.fRetornaSQLInsert: String;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'INSERT INTO            ';
  strSQL := strSQL + '  CTRPAG(AUTOINCREM,   ';
  strSQL := strSQL + '         PAG_CODEMP,   ';
  strSQL := strSQL + '         PAG_CODFUN,   ';
  strSQL := strSQL + '         PAG_CODVER,   ';
  strSQL := strSQL + '         PAG_VALLAN,   ';
  strSQL := strSQL + '         PAG_MESBAS,   ';
  strSQL := strSQL + '         PAG_TIPMOV,   ';
  strSQL := strSQL + '         PAG_AUTFUN)   ';
  strSQL := strSQL + '  VALUES(:AUTOIN,      ';
  strSQL := strSQL + '         :CODEMP,      ';
  strSQL := strSQL + '         :CODFUN,      ';
  strSQL := strSQL + '         :CODVER,      ';
  strSQL := strSQL + '         :VALLAN,      ';
  strSQL := strSQL + '         :MESBAS,      ';
  strSQL := strSQL + '         :TIPMOV,      ';
  strSQL := strSQL + '         :AUTFUN)      ';

  Result := strSQL;
end;

function TCtrPag.fRetornaSQLSelect: String;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT    ';
  strSQL := strSQL + '  PAG_CODVER AS CODVER, ';
  strSQL := strSQL + '  VER_DESVER AS DESVER, ';
  strSQL := strSQL + '  PAG_VALLAN AS VALLAN, ';
  strSQL := strSQL + '  PAG_CODFUN AS CODFUN, ';
  strSQL := strSQL + '  FUN_NOMFUN AS NOMFUN  ';
  strSQL := strSQL + 'FROM      ';
  strSQL := strSQL + '  CTRPAG  ';
  strSQL := strSQL + '  LEFT JOIN CADFUN ON CADFUN.AUTOINCREM = PAG_AUTFUN ';
  strSQL := strSQL + '  LEFT JOIN CADVER ON VER_CODVER = PAG_CODVER     ';
  strSQL := strSQL + 'WHERE     ';
  strSQL := strSQL + '  PAG_MESBAS = :MESBAS AND ';
  strSQL := strSQL + '  PAG_TIPMOV = :TIPMOV AND ';
  strSQL := strSQL + '  PAG_CODEMP = :CODEMP     ';
  strSQL := strSQL + 'ORDER BY  ';
  strSQL := strSQL + '  FUN_NOMFUN,  ';
  strSQL := strSQL + '  VER_DEBCRE,  ';
  strSQL := strSQL + '  VER_CODVER   ';

  Result := strSQL;
end;

function TCtrPag.fRetornaSQLUpdate: String;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE CTRPAG               ';
  strSQL := strSQL + '  SET PAG_VALLAN = :VALLAN, ';
  strSQL := strSQL + '      PAG_AUTFUN = :AUTFUN  ';
  strSQL := strSQL + 'WHERE                       ';
  strSQL := strSQL + '  PAG_CODFUN = :CODFUN AND  ';
  strSQL := strSQL + '  PAG_CODEMP = :CODEMP AND  ';
  strSQL := strSQL + '  PAG_CODVER = :CODVER AND  ';
  strSQL := strSQL + '  PAG_MESBAS = :MESBAS AND  ';
  strSQL := strSQL + '  PAG_TIPMOV = :TIPMOV AND  ';
  strSQL := strSQL + '  PAG_AUTFUN = :AUTFUN      ';

  Result := strSQL;
end;

function TCtrPag.fRetValorLiquidoAntecipacaoFuncionario(AAutFun: String;
  AdtaMesBas: TDateTime; ACodEmp: String): Double;
Var
  strSQL: String;
begin
  Result := 0.0;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  SUM(PAG_VALLAN) AS VALOR_LIQUIDO  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CTRPAG ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  PAG_AUTFUN = :AUTFUN AND ';
    strSQL := strSQL + '  PAG_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PAG_MESBAS = :MESBAS AND ';
    strSQL := strSQL + '  PAG_TIPMOV = :TIPMOV     ';
    strSQL := strSQL + 'GROUP BY PAG_CODFUN        ';

    qryCtrPag.Close;
    qryCtrPag.SQL.Clear;
    qryCtrPag.SQL.Add(strSQL);
    qryCtrPag.ParamByName('AUTFUN').AsString := AAutFun;
    qryCtrPag.ParamByName('CODEMP').AsString := ACodEmp;
    qryCtrPag.ParamByName('MESBAS').AsDate   := AdtaMesBas;
    qryCtrPag.ParamByName('TIPMOV').AsString := 'A';
    qryCtrPag.Open;

    Result := qryCtrPag.FieldByName('VALOR_LIQUIDO').AsFloat;
  Except
    On E:Exception Do
      pMensagensErro(E.Message,'[TCtrPag.fRetValorLiquidoAntecipacaoFuncionario]');
  End;
end;

function TCtrPag.fVerificaLancamento(AAutFun, strCodVer, strTipMov,
                                     strCodEmp: String; dtaMesBas: TDateTime; Var fltValLan: Double;
                                     var strAutCtp: String): Boolean;
Var
  strSQL: String;
begin
  Result := False;
  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  PAG_VALLAN, ';
    strSQL := strSQL + '  PAG_AUTCTP  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CTRPAG ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  PAG_AUTFUN = :AUTFUN AND ';
    strSQL := strSQL + '  PAG_CODVER = :CODVER AND ';
    strSQL := strSQL + '  PAG_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PAG_MESBAS = :MESBAS AND ';
    strSQL := strSQL + '  PAG_TIPMOV = :TIPMOV     ';

    With qryCtrPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AUTFUN').AsString := AAutFun;
      ParamByName('CODVER').AsString := strCodVer;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('MESBAS').AsDate   := dtaMesBas;
      ParamByName('TIPMOV').AsString := strTipMov;

      Open;
      pSetaClient(qryCtrPag);
    End;

    Result := (qryCtrPag.RecordCount > 0);

    If (Result) Then
    Begin
      fltValLan := qryCtrPag.FieldByName('PAG_VALLAN').AsFloat;
      strAutCtp := qryCtrPag.FieldByName('PAG_AUTCTP').AsString;
    End;

  Except
    On E:Exception Do
      pMensagensErro(E.Message,'[TCtrPag.fRetornaValorLancamento]');
  End;

end;
procedure TCadFun.pInsereVerbasFuncionario(qryVerbas: TUniQuery);
Var
  strFunAnt  : String;

  intQtdDeb  : Integer;
  intPosDeb  : Integer;
  intContad  : Integer;
  intPosNov  : Integer;
  intPosAtu  : Integer;

  blnGraCre  : Boolean;
  blnGraDeb  : Boolean;

  stlCodDeb  : TStringList;
  stlDesDeb  : TStringList;
  stlValDeb  : TStringList;

begin
  intQtdDeb := 0;

  stlCodDeb := TStringList.Create;
  stlDesDeb := TStringList.Create;
  stlValDeb := TStringList.Create;

  With qryVerbas Do
  Begin
    First;

    strFunAnt := '';
    blnGraCre := False;
    blnGraDeb := False;
    intPosDeb := 0;

    While Not Eof Do
    Begin
      {***********************************}
      {* VERIFICA SE MUDOU O FUNCIONÁRIO *}
      {********************************PZ*}
      If (strFunAnt <> FieldByName('CODFUN').AsString + FieldByName('AUTFUN').AsString) Then
      Begin
        stlCodDeb.Clear;
        stlDesDeb.Clear;
        stlValDeb.Clear;
        intPosDeb := 0;
        intPosAtu := RecNo;
        strFunAnt := FieldByName('CODFUN').AsString + FieldByName('AUTFUN').AsString;
        First;
        {***************************************}
        {* CARREGA TODOS OS DÉBITOS EXISTENTES *}
        {* DE UM FUNCIONÁRIO.                  *}
        {************************************PZ*}
        While Not Eof Do
        Begin
          If (FieldByName('CODFUN').AsString + FieldByName('AUTFUN').AsString = strFunAnt) And (FieldByName('DEBCRE').AsString = 'D') Then
          Begin
            stlCodDeb.Add(FieldByName('CODVER').AsString);
            stlDesDeb.Add(FieldByName('DESVER').AsString);
            stlValDeb.Add(FormatFloat('#,##0.00', FieldByName('VALLAN').AsFloat * (-1)));
          End;
          Next;
        End;

        intQtdDeb := stlCodDeb.Count;

        RecNo := intPosAtu;
      End;

      {****************************}
      {* VERIFICA SE É UM CRÉDITO *}
      {* SE FOR GRAVA NO CLIENT.  *}
      {*************************PZ*}
      If (FieldByName('DEBCRE').AsString = 'C') Then
      Begin
        cdsVerbas.Append;

        cdsVerbas.FieldByName('VER_DESVER').AsString := FieldByName('VER_DESVER').AsString;
        cdsVerbas.FieldByName('VER_CODVER').AsString := FieldByName('VER_CODVER').AsString;
        cdsVerbas.FieldByName('FUN_NOMFUN').AsString := FieldByName('FUN_NOMFUN').AsString;

        cdsVerbas.FieldByName('CODVER').AsString := FieldByName('CODVER').AsString;
        cdsVerbas.FieldByName('DESVER').AsString := FieldByName('DESVER').AsString;
        cdsVerbas.FieldByName('VALLAN').AsFloat  := FieldByName('VALLAN').AsFloat;
        cdsVerbas.FieldByName('CODFUN').AsString := FieldByName('CODFUN').AsString;
        cdsVerbas.FieldByName('NOMFUN').AsString := FieldByName('NOMFUN').AsString;
        cdsVerbas.FieldByName('DEBCRE').AsString := FieldByName('DEBCRE').AsString;
        cdsVerbas.FieldByName('CODDEB').AsString := '.';
        cdsVerbas.FieldByName('DESDEB').AsString := '.';
        cdsVerbas.FieldByName('VALDEB').AsFloat  := 0;
        cdsVerbas.FieldByName('AUTFUN').AsString := FieldByName('AUTFUN').AsString;
        cdsVerbas.Post;
        blnGraCre := True;
      End;

      {******************************************}
      {* POSICIONA NO PROXIMO REGISTRO DA QUERY *}
      {***************************************PZ*}
      intPosNov := RecNo + 1;
      RecNo     := RecNo + 1;

      {*****************************************}
      {* VERIFICA SE O PROXIMO REGISTRO SE     *}
      {* REFERE AO MESMO FUNCIONÁRIO. SE FOR   *}
      {* O MESMO E POSSUIR VERBAS DE DEBITO,   *}
      {* E HOUVE GRAVAÇÃO DE UM CRÉDITO, GRAVA *}
      {* O DEBITO NA MESMA LINHA DO CREDITO.    *}
      {**************************************PZ*}
      If (FieldByName('CODFUN').AsString + FieldByName('AUTFUN').AsString = strFunAnt) And (intQtdDeb > intPosDeb) And (blnGraCre) Then
      Begin
        If ((intPosNov - 1) < RecordCount) Then
          RecNo := RecNo - 1;

        cdsVerbas.Edit;
        cdsVerbas.FieldByName('CODDEB').AsString := stlCodDeb[intPosDeb];
        cdsVerbas.FieldByName('DESDEB').AsString := stlDesDeb[intPosDeb];
        cdsVerbas.FieldByName('VALDEB').AsFloat  := fStrToFloat(stlValDeb[intPosDeb]);
        cdsVerbas.Post;
        blnGraDeb := True;
        Inc(intPosDeb);
      End
      {*******************************************}
      {* SE FOR O MESMO FUNCIONARIO E SE POSSUIR *}
      {* DEBITOS E NÃO HOUVE GRAVAÇÃO DE CRÉDITO *}
      {* IRÁ GRAVAR TODOS OS DÉBITOS.            *}
      {****************************************PZ*}
      Else If (FieldByName('CODFUN').AsString + FieldByName('AUTFUN').AsString = strFunAnt) And
              (intQtdDeb > intPosDeb)                      And
              (Not blnGraCre)                              Then
      Begin
        If ((intPosNov - 1) < RecordCount) Then
          RecNo := RecNo - 1;

        For intContad := intPosDeb To stlCodDeb.Count - 1 Do
        Begin
          cdsVerbas.Append;
          cdsVerbas.FieldByName('CODVER').AsString := '.';
          cdsVerbas.FieldByName('DESVER').AsString := '.';
          cdsVerbas.FieldByName('VALLAN').AsFloat  := 0;
          cdsVerbas.FieldByName('CODFUN').AsString := FieldByName('CODFUN').AsString;
          cdsVerbas.FieldByName('NOMFUN').AsString := FieldByName('NOMFUN').AsString;
          cdsVerbas.FieldByName('DEBCRE').AsString := FieldByName('DEBCRE').AsString;
          cdsVerbas.FieldByName('CODDEB').AsString := stlCodDeb[intPosDeb];
          cdsVerbas.FieldByName('DESDEB').AsString := stlDesDeb[intPosDeb];
          cdsVerbas.FieldByName('VALDEB').AsFloat  := fStrToFloat(stlValDeb[intPosDeb]);

          cdsVerbas.FieldByName('VER_CODVER').AsString := '999';
          cdsVerbas.FieldByName('VER_DESVER').AsString := FieldByName('VER_DESVER').AsString;
          cdsVerbas.FieldByName('FUN_NOMFUN').AsString := FieldByName('FUN_NOMFUN').AsString;
          cdsVerbas.FieldByName('AUTFUN').AsString := FieldByName('AUTFUN').AsString;

          cdsVerbas.Post;
          blnGraDeb := True;
          Inc(intPosDeb);
        End;
      End;

      If (Not blnGraDeb) Then
      Begin
        If ((intPosNov - 1) < RecordCount) Then
          RecNo := RecNo - 1;
      End;

      blnGraDeb := False;
      blnGraCre := False;
      Next;
    End;
  End;

  FreeAndNil(stlCodDeb);
  FreeAndNil(stlDesDeb);
  FreeAndNil(stlValDeb);
end;


{ TMonQdr }

procedure TMonQdr.AtualizaDadosDeVersoesAnteriores(ACodEve, ACodEmp: String);
  Var
    LSQL: String;
begin
  If ACodEve.IsEmpty Then
    Exit;

  Try
    LSQL := 'UPDATE EVEDET SET DET_AUTFUN=(              ';
    LSQL := LSQL + 'SELECT CADFUN.AUTOINCREM FROM CADFUN ';
    LSQL := LSQL + '      WHERE FUN_CODFUN=DET_CODFUN    ';
    LSQL := LSQL + '        AND FUN_CODEMP=DET_CODEMP    ';
    LSQL := LSQL + '        LIMIT 1)                     ';
    LSQL := LSQL + ' WHERE                               ';
    LSQL := LSQL + '   DET_SEQGER = (SELECT AUTOINCREM   ';
    LSQL := LSQL + '      FROM EVEGER WHERE              ';
    LSQL := LSQL + '   GER_CODEVE= "' + ACodEve + '" AND ';
    LSQL := LSQL + '   GER_CODEMP="' + ACodEmp + '") AND ';
    LSQL := LSQL + '   DET_AUTFUN IS NULL                ';

    fExecutaSQL(LSQL);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

constructor TMonQdr.Create(Owner: TComponent);
begin
  inherited Create(Owner);
end;

destructor TMonQdr.Destroy;
begin
  inherited Destroy;
end;

function TMonQdr.fExcluiQuadro(strCodEve: String): Boolean;
  Var
    strSQL: String;
begin
  Result := False;
  Try
    qryGenQdr := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  EVEGER    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  GER_CODEVE = :CODEVE AND   ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP       ';

    With qryGenQdr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEVE').AsString := strCodEve;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
      Result := True;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TMonQdr.fExcluiQuadro]');
  End;
  FreeAndNil(qryGenQdr);
end;

function TMonQdr.fGravarQuadro(strCodEve: String;
                               fltVlrTot: Double;
                               strCodEmp: String;
                               strCodFun: String;
                               strCodFnc: String;
                               intNroGer: Integer;
                               intNroFnc: Integer;
                               fltVlrFun: Double;
                               strOnibus: String;
                               intSeqGra: Integer;
                               AAutFun: String;
                               AAutFnc: String;
                               ADtaIni: TDateTime;
                               ADtaFim: TDateTime;
                               AGerCtr: String): Boolean;
  Var
    strSQL: String;
    qryAuxDet: TUniQuery;
    qryAuxGer: TUniQuery;
    blnInsGer: Boolean;
    blnInsDet: Boolean;
begin
  Result := False;
  qryGenQdr := Nil;
  qryAuxDet := Nil;
  qryAuxGer := Nil;
  Try
    Try
      qryGenQdr := fCriaQuery(Nil);
      qryAuxDet := fCriaQuery(Nil);
      qryAuxGer := fCriaQuery(Nil);

      qryAuxGer.Close;
      qryAuxGer.SQL.Clear;
      qryAuxGer.SQL.Add('SELECT * FROM EVEGER');
      qryAuxGer.SQL.Add('WHERE GER_CODEVE = :CODEVE');
      qryAuxGer.SQL.Add('AND GER_CODEMP = :CODEMP');
      qryAuxGer.ParamByName('CODEVE').AsString := strCodEve;
      qryAuxGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAuxGer.Open;
      blnInsGer := qryAuxGer.IsEmpty;

      If (intSeqGra = 1) And
         (blnInsGer)     Then
      Begin
        strSQL    := fSQLInsertGer;
        strAutoIn := fRetAutoIncrem('EVEGER', VS_strCodEmp);

        qryGenQdr.Close;
        qryGenQdr.SQL.Clear;
        qryGenQdr.SQL.Add(strSQL);
        qryGenQdr.ParamByName('AUTOIN').AsString := strAutoIn;
        qryGenQdr.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryGenQdr.ParamByName('CODEVE').AsString := strCodEve;
        qryGenQdr.ParamByName('VLRTOT').AsFloat  := fltVlrTot;
        qryGenQdr.ExecSQL;
      End;

      qryAuxDet.Close;
      qryAuxDet.SQL.Clear;
      qryAuxDet.SQL.Add(' SELECT * FROM EVEDET WHERE DET_SEQGER = :SEQGER ');
      qryAuxDet.ParamByName('SEQGER').AsString := strAutoIn;
      qryAuxDet.Open;
      If Not qryAuxDet.IsEmpty And qryAuxDet.Locate('DET_SEQGER;DET_NROGER', VarArrayOf([strAutoIn, intNroGer]), []) Then
        blnInsDet := False
      Else
        blnInsDet := True;

      If blnInsDet Then
        strSQL := fSQLInsertDet
      Else
        strSQL := fSQLUpdateDet;

      qryGenQdr.Close;
      qryGenQdr.SQL.Clear;
      qryGenQdr.SQL.Add(strSQL);
      If blnInsDet Then
        qryGenQdr.ParamByName('AUTOIN').AsString  := fRetAutoIncrem('EVEDET', VS_strCodEmp);
      qryGenQdr.ParamByName('SEQGER').AsString  := strAutoIn;
      qryGenQdr.ParamByName('CODEMP').AsString  := strCodEmp;
      qryGenQdr.ParamByName('CODEVE').AsString  := strCodEve;
      qryGenQdr.ParamByName('CODFUN').AsString  := strCodFun;
      qryGenQdr.ParamByName('CODFNC').AsString  := strCodFnc;
      qryGenQdr.ParamByName('NROGER').AsInteger := intNroGer;
      qryGenQdr.ParamByName('NROFNC').AsInteger := intNroFnc;
      qryGenQdr.ParamByName('VLRFUN').AsFloat   := fltVlrFun;
      qryGenQdr.ParamByName('ONIBUS').AsString  := strOnibus;
      qryGenQdr.ParamByName('AUTFUN').AsString  := AAutFun;
      qryGenQdr.ParamByName('AUTFNC').AsString  := AAutFnc;
      If fEmptyStr(strOnibus) Then
        qryGenQdr.ParamByName('ONIBUS').Clear;
      If ADtaIni > 0 Then
        qryGenQdr.ParamByName('DTAINI').AsDateTime := ADtaIni
      Else
        qryGenQdr.ParamByName('DTAINI').Clear;
      If ADtaFim > 0 Then
        qryGenQdr.ParamByName('DTAFIM').AsDateTime := ADtaFim
      Else
        qryGenQdr.ParamByName('DTAFIM').Clear;
      qryGenQdr.ParamByName('GERCTR').AsString := IIF(fEmptyStr(AGerCtr), 'N', AGerCtr);
      qryGenQdr.ExecSQL;

      Result := True;
    Except
      On E:Exception Do
        pMensagensErro(E.Message,'[TMonQdr.fGravarQuadro]');
    End;
  Finally
    FreeAndNil(qryGenQdr);
    FreeAndNil(qryAuxDet);
    FreeAndNil(qryAuxGer);
  End;
end;

function TMonQdr.fSQLInsertDet: String;
begin
  Result := '';
  Result := Result + 'INSERT INTO ';
  Result := Result + '  EVEDET(AUTOINCREM, ';
  Result := Result + '         DET_SEQGER, ';
  Result := Result + '         DET_CODEMP, ';
  Result := Result + '         DET_CODEVE, ';
  Result := Result + '         DET_CODFUN, ';
  Result := Result + '         DET_CODFNC, ';
  Result := Result + '         DET_NROGER, ';
  Result := Result + '         DET_NROFNC, ';
  Result := Result + '         DET_VLRFUN, ';
  Result := Result + '         DET_ONIBUS, ';
  Result := Result + '         DET_AUTFUN, ';
  Result := Result + '         DET_AUTFNC, ';
  Result := Result + '         DET_DTAINI, ';
  Result := Result + '         DET_DTAFIM, ';
  Result := Result + '         DET_GERCTR) ';
  Result := Result + '  VALUES(:AUTOIN,    ';
  Result := Result + '         :SEQGER,    ';
  Result := Result + '         :CODEMP,    ';
  Result := Result + '         :CODEVE,    ';
  Result := Result + '         :CODFUN,    ';
  Result := Result + '         :CODFNC,    ';
  Result := Result + '         :NROGER,    ';
  Result := Result + '         :NROFNC,    ';
  Result := Result + '         :VLRFUN,    ';
  Result := Result + '         :ONIBUS,    ';
  Result := Result + '         :AUTFUN,    ';
  Result := Result + '         :AUTFNC,    ';
  Result := Result + '         :DTAINI,    ';
  Result := Result + '         :DTAFIM,    ';
  Result := Result + '         :GERCTR)    ';
end;

function TMonQdr.fSQLInsertGer: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'INSERT INTO ';
  strSQL := strSQL + '  EVEGER(AUTOINCREM, ';
  strSQL := strSQL + '         GER_CODEMP, ';
  strSQL := strSQL + '         GER_CODEVE, ';
  strSQL := strSQL + '         GER_VLRTOT) ';
  strSQL := strSQL + '  VALUES(:AUTOIN,    ';
  strSQL := strSQL + '         :CODEMP,    ';
  strSQL := strSQL + '         :CODEVE,    ';
  strSQL := strSQL + '         :VLRTOT)    ';
  Result := strSQL;
end;

function TMonQdr.fSQLSelect: String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '  G.GER_CODEVE AS CODEVE, ';
  Result := Result + '  D.DET_NROGER AS NROGER, ';
  Result := Result + '  D.DET_NROFNC AS NROFNC, ';
  Result := Result + '  D.DET_CODFUN AS CODFUN, ';
  Result := Result + '  U.FUN_NOMFUN AS NOMFUN, ';
  Result := Result + '  D.DET_CODFNC AS CODFNC, ';
  Result := Result + '  F.FNC_NOMFNC AS FUNCAO, ';
  Result := Result + '  D.DET_VLRFUN AS VLRFUN, ';
  Result := Result + '  G.GER_VLRTOT AS VLRTOT, ';
  Result := Result + '  D.DET_ONIBUS AS ONIBUS, ';
  Result := Result + '  D.DET_CODEMP AS CODEMP, ';
  Result := Result + '  D.DET_AUTFUN AS AUTFUN, ';
  Result := Result + '  D.DET_AUTFNC AS AUTFNC, ';
  Result := Result + '  D.DET_DTAINI AS DTAINI, ';
  Result := Result + '  D.DET_DTAFIM AS DTAFIM, ';
  Result := Result + '  D.DET_GERCTR AS GERCTR  ';
  Result := Result + 'FROM ';
  Result := Result + '  EVEDET D ';
  Result := Result + '  INNER JOIN EVEGER G ON G.AUTOINCREM = D.DET_SEQGER ';
  Result := Result + '  INNER JOIN CADFUN U ON U.AUTOINCREM = D.DET_AUTFUN ';
  Result := Result + '  LEFT  JOIN CADFNC F ON F.AUTOINCREM = D.DET_AUTFNC ';
  Result := Result + 'WHERE ';
  Result := Result + '  G.GER_CODEMP = :CODEMP AND ';
  Result := Result + '  G.GER_CODEVE = :CODEVE ';
end;

function TMonQdr.fSQLUpdateDet: String;
begin
  Result := '';
  Result := Result + ' UPDATE                   ';
  Result := Result + '   EVEDET                 ';
  Result := Result + ' SET                      ';
  Result := Result + '   DET_CODEVE = :CODEVE,  ';
  Result := Result + '   DET_CODFUN = :CODFUN,  ';
  Result := Result + '   DET_CODFNC = :CODFNC,  ';
  Result := Result + '   DET_NROGER = :NROGER,  ';
  Result := Result + '   DET_NROFNC = :NROFNC,  ';
  Result := Result + '   DET_VLRFUN = :VLRFUN,  ';
  Result := Result + '   DET_ONIBUS = :ONIBUS,  ';
  Result := Result + '   DET_AUTFUN = :AUTFUN,  ';
  Result := Result + '   DET_AUTFNC = :AUTFNC,  ';
  Result := Result + '   DET_DTAINI = :DTAINI,  ';
  Result := Result + '   DET_DTAFIM = :DTAFIM,  ';
  Result := Result + '   DET_GERCTR = :GERCTR   ';
  Result := Result + ' WHERE                    ';
  Result := Result + '     DET_SEQGER = :SEQGER ';
  Result := Result + ' AND DET_CODEMP = :CODEMP ';
end;

end.
