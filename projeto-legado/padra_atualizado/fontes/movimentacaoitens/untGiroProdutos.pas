unit untGiroProdutos;

interface

uses
  SysUtils, Classes, DB, Uni, Variants, StrUtils, Math, UniClientDataSet,
  Provider;

Type

  TGiroItem = class(TObject)
    private
      FCodIte: String;
      FCodEmp: String;

      FDesM01: String;
      FDesM02: String;
      FDesM03: String;
      FDesM04: String;
      FDesM05: String;
      FDesM06: String;
      FDesM07: String;
      FDesM08: String;
      FDesM09: String;
      FDesM10: String;
      FDesM11: String;
      FDesM12: String;

      FQtdM01: Double;
      FQtdM02: Double;
      FQtdM03: Double;
      FQtdM04: Double;
      FQtdM05: Double;
      FQtdM06: Double;
      FQtdM07: Double;
      FQtdM08: Double;
      FQtdM09: Double;
      FQtdM10: Double;
      FQtdM11: Double;
      FQtdM12: Double;
      FSugest: Double;
      FMedia_: Double;
      FSaldos: Double;
      FQtdMes: Integer;

      FMaiorQtdSai: Double;
      FMaiorDtaSai: TDateTime;
    protected
    public
      Constructor Create(const strCodIte, strCodEmp: String;
        intQtdMes, intDiaCom: Integer; blnConsMCom, blnArredSug: Boolean); overload;

      Constructor Create(const fltMedia, fltSaldos, fltSujestao: Double;
                         const strCodIte, strCodEmp: String;
                         Const intQtdMes: Integer;
                               qryTmpEmp: TUniQuery);                        overload;

      property strCodIte: String  Read FCodIte;
      property strCodEmp: String  Read FCodEmp;

      property strDesM01: String  Read FDesM01;
      property strDesM02: String  Read FDesM02;
      property strDesM03: String  Read FDesM03;
      property strDesM04: String  Read FDesM04;
      property strDesM05: String  Read FDesM05;
      property strDesM06: String  Read FDesM06;
      property strDesM07: String  Read FDesM07;
      property strDesM08: String  Read FDesM08;
      property strDesM09: String  Read FDesM09;
      property strDesM10: String  Read FDesM10;
      property strDesM11: String  Read FDesM11;
      property strDesM12: String  Read FDesM12;

      property fltQtdM01: Double  Read FQtdM01;
      property fltQtdM02: Double  Read FQtdM02;
      property fltQtdM03: Double  Read FQtdM03;
      property fltQtdM04: Double  Read FQtdM04;
      property fltQtdM05: Double  Read FQtdM05;
      property fltQtdM06: Double  Read FQtdM06;
      property fltQtdM07: Double  Read FQtdM07;
      property fltQtdM08: Double  Read FQtdM08;
      property fltQtdM09: Double  Read FQtdM09;
      property fltQtdM10: Double  Read FQtdM10;
      property fltQtdM11: Double  Read FQtdM11;
      property fltQtdM12: Double  Read FQtdM12;
      property fltSugest: Double  Read FSugest;
      property fltMedia_: Double  Read FMedia_;
      property fltSaldos: Double  Read FSaldos;
      property intQtdMes: Integer Read FQtdMes;

      property fltMaiorQtdSai: Double Read FMaiorQtdSai;
      property dtaMaiorDtaSai: TDateTime Read FMaiorDtaSai;
  End;

  function fGravaGirIte(strAnoGir,
                        strCodIte: String;
                        intMes: Integer;
                        fltQtdEnt,
                        fltQtdSai,
                        fltMaiorQtdSai: Double;
                        dtaMaiorDtaSai: TDateTime;
                        blnSaida: Boolean;
                        strEmpGiro: String): Boolean;


  function fCalculaGiroAnalitico(strCodIte, strCodEmp: String;
    intQtdMes: Integer): TUniClientDataSet;


implementation

uses untConstantes, untfuncoesSimples, DateUtils;

{*****************************************}
{* INSERE UM REGISTRO NO GIRITE, EM DE-  *}
{* TERMINADA COLUNA DE MES. SE O REGIS-  *}
{* TRO JA EXISTIR, A FUNÇÃO ATUALIZA O   *}
{* MESMO.                                *}
{**************************************MV*}
function fCalculaGiroAnalitico(strCodIte,
  strCodEmp: String; intQtdMes: Integer): TUniClientDataSet;
  Var
    strSQL: String;
    dtaBase: TDateTime;
    intMesAtu: Integer;
    dtaDtaAtu: TDateTime;
    fltQtdIte: Double;
    fltQtdMl: Double;
    fltQtdGer: Double;

    fltCnvMl: Double;

    qryGiro: TUniQuery;
begin

//  ERRO PROPROSITAL. REMOVER ESSA FUNCAO.

  dtaBase := EndOfTheMonth(IncMonth(VS_Date, -1));
  Dec(intQtdMes);

  qryGiro     := fCriaQuery(Nil);
  Result      := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DET_DTAENT';
    DataType := ftDate;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DET_NUMDOC';
    DataType := ftString;
    Size := 12;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DET_ESPDOC';
    DataType := ftString;
    Size := 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DET_CODEMP';
    DataType := ftString;
    Size := 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DET_NOMCLI';
    DataType := ftString;
    Size := 50;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DET_CODITE';
    DataType := ftString;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DET_DESCRI';
    DataType := ftString;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DET_QTDITE';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_CNV_ML';
    DataType := ftFloat;
  End;

  Result.CreateDataSet;
  TFloatField(Result.FieldByname('DET_QTDITE')).DisplayFormat := '#,##0.00';

  strSQL := '';
  strSQL := strSQL + '(SELECT ';
  strSQL := strSQL + '  DET_NUMDOC, ';
  strSQL := strSQL + '  DET_ESPDOC, ';
  strSQL := strSQL + '  DET_CODEMP, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  DET_QTDITE, ';
  strSQL := strSQL + '  DET_DESCRI, ';
  strSQL := strSQL + '  DET_DTAENT, ';
  strSQL := strSQL + '  MONTH(DET_DTAENT) DET_MESENT, ';
  strSQL := strSQL + '  DET_CLAFIS, ';
  strSQL := strSQL + '  IF(GER_NOMCON = "" OR GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON) AS DET_NOMCLI, ';
  strSQL := strSQL + '  ITE_CNV_ML ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + '  JOIN MOVGER ON MOVGER.AUTOINCREM = DET_SEQGER ';
  strSQL := strSQL + '  JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';
  strSQL := strSQL + '  JOIN CADITE ON DET_CODITE = ITE_CODITE  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + ' DET_CODITE = :CODITE AND ';

  If Not fEmptyStr(strCodEmp) Then
    strSQL := strSQL + ' DET_CODEMP = :CODEMP AND ';

  strSQL := strSQL + ' ( ';
  strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAGIR) > 0) AND (LOCATE(DET_ESPDOC, :ESPGIR) > 0)) OR ';
  strSQL := strSQL + '   (DET_ESPDOC = "ML") ) AND ';
  strSQL := strSQL + '  ';
  strSQL := strSQL + ' DET_DTAENT BETWEEN :DTAINI AND :DTAFIN) ';

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + ' DET_DTAENT ';

  qryGiro.SQL.Add(strSQL);
  qryGiro.ParamByName('CODITE').AsString := strCodIte;
  If Not fEmptyStr(strCodEmp) Then
    qryGiro.ParamByName('CODEMP').AsString := strCodEmp;

  qryGiro.ParamByName('CLAGIR').AsString   := VS_strClaGir;
  qryGiro.ParamByName('ESPGIR').AsString   := VS_strEspGir;
  qryGiro.ParamByName('DTAFIN').AsDateTime := dtaBase;
  qryGiro.ParamByName('DTAINI').AsDateTime := StartOfTheMonth(IncMonth(dtaBase, -intQtdMes));
  qryGiro.Open;

  fltQtdGer := 0.0;

  While (Not qryGiro.Eof) Do
  Begin

    intMesAtu := qryGiro.FieldByName('DET_MESENT').AsInteger;
    dtaDtaAtu := qryGiro.FieldByName('DET_DTAENT').AsDateTime;
    fltCnvMl  := qryGiro.FieldByName('ITE_CNV_ML').AsFloat;

    If fltCnvMl <= 0 Then
      fltCnvMl := 1;

    fltQtdIte := 0.0;
    fltQtdMl  := 0.0;

    While (Not qryGiro.Eof) And
          (qryGiro.FieldByName('DET_MESENT').AsInteger = intMesAtu) Do
    Begin
      Result.Append;
      Result.FieldByName('DET_DTAENT').AsDateTime := qryGiro.FieldByName('DET_DTAENT').AsDateTime;
      Result.FieldByName('DET_NUMDOC').AsString   := qryGiro.FieldByName('DET_NUMDOC').AsString;
      Result.FieldByName('DET_ESPDOC').AsString   := qryGiro.FieldByName('DET_ESPDOC').AsString;
      Result.FieldByName('DET_CODEMP').AsString   := qryGiro.FieldByName('DET_CODEMP').AsString;
      Result.FieldByName('DET_NOMCLI').AsString   := qryGiro.FieldByName('DET_NOMCLI').AsString;
      Result.FieldByName('DET_CODITE').AsString   := qryGiro.FieldByName('DET_CODITE').AsString;
      Result.FieldByName('DET_DESCRI').AsString   := qryGiro.FieldByName('DET_DESCRI').AsString;

      If qryGiro.FieldByName('DET_ESPDOC').AsString = 'ML' Then
        Result.FieldByName('DET_QTDITE').AsFloat  := qryGiro.FieldByName('DET_QTDITE').AsFloat
      Else
        Result.FieldByName('DET_QTDITE').AsFloat  := qryGiro.FieldByName('DET_QTDITE').AsFloat * fltCnvMl;

      Result.FieldByName('ITE_CNV_ML').AsFloat := fltCnvMl;

      Result.Post;

      If qryGiro.FieldByName('DET_ESPDOC').AsString <> 'ML' Then
      Begin
        fltQtdIte := fltQtdIte + qryGiro.FieldByName('DET_QTDITE').AsFloat;
        fltQtdGer := fltQtdGer + qryGiro.FieldByName('DET_QTDITE').AsFloat;
      End
      Else
      Begin
        fltQtdMl := fltQtdMl + qryGiro.FieldByName('DET_QTDITE').AsFloat;
      End;
      qryGiro.Next;
    End;

    If fltQtdMl > 0 Then
    Begin
      fltQtdMl := fFormataFloat(fltQtdMl / fltCnvMl, 3);
      fltQtdIte := fltQtdIte + fltQtdMl;
      fltQtdGer := fltQtdGer + fltQtdMl;
    End;

    Result.Append;
    Result.FieldByName('DET_NOMCLI').AsString := 'TOTAL DO MÊS ' + FormatDateTime('mm/yyyyy', dtaDtaAtu) + ':';
    Result.FieldByName('DET_QTDITE').AsFloat  := fltQtdIte;
    Result.Post;
  End;

  Result.Append;
  Result.FieldByName('DET_NOMCLI').AsString := 'TOTAL GERAL: ';
  Result.FieldByName('DET_QTDITE').AsFloat  := fltQtdGer;
  Result.Post;


end;

function fGravaGirIte(strAnoGir,
                      strCodIte: String;
                      intMes: Integer;
                      fltQtdEnt,
                      fltQtdSai,
                      fltMaiorQtdSai: Double;
                      dtaMaiorDtaSai: TDateTime;
                      blnSaida: Boolean;
                      strEmpGiro: String): Boolean;
  Var
    strSQL   : String;
    blnInsere: Boolean;
    qryGenIte: TUniQuery;

begin
  If intMes <= 0 Then
    intMes := MonthOf(VS_Date);

  qryGenIte := fCriaQuery(nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(GIR_CODITE) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  GIRITE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GIR_A_N_O_ = :ANOGIR AND ';
  strSQL := strSQL + '  GIR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  GIR_CODITE = :CODITE ';

  With qryGenIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    {*****************************************}
    {* DADOS DO FILTRO                       *}
    {**************************************MV*}
    ParamByName('ANOGIR').AsString := strAnoGir;
    ParamByName('CODEMP').AsString := IIF(fEmptyStr(strEmpGiro), VS_strCodEmp, strEmpGiro);
    ParamByName('CODITE').AsString := strCodIte;
    Open;
    blnInsere := FieldByName('QTD').AsInteger <= 0;
    Close;
  End;

  If blnInsere Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + '  GIRITE ';
    strSQL := strSQL + '(GIR_A_N_O_, ';
    strSQL := strSQL + ' GIR_CODITE, ';

    If (Not blnSaida) Then
    Begin
      strSQL := strSQL + '  %COLENT, ';
    End
    Else
    Begin
      strSQL := strSQL + '  %COLSAI, ';
      strSQL := strSQL + '  %MADTSA, ';
      strSQL := strSQL + '  %MAQTSA, ';
    End;
    
    strSQL := strSQL + ' GIR_CODEMP, ';
    strSQL := strSQL + ' AUTOINCREM ) ';
    strSQL := strSQL + 'VALUES ( ';
    strSQL := strSQL + '  :ANOGIR, ';
    strSQL := strSQL + '  :CODITE, ';
    If (Not blnSaida) Then
    Begin
      strSQL := strSQL + '  :QTDENT, ';
    End
    Else
    Begin
      strSQL := strSQL + '  :QTDSAI, ';
      strSQL := strSQL + '  :MADTSA, ';
      strSQL := strSQL + '  :MAQTSA, ';
    End;
    strSQL := strSQL + '  :CODEMP, ';
    strSQL := strSQL + '  :AUTINC) ';

  End
  Else
  Begin

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  GIRITE ';
    strSQL := strSQL + 'SET ';
    If (Not blnSaida) Then
    Begin
      strSQL := strSQL + '  %COLENT = :QTDENT ';
    End
    Else
    Begin
      strSQL := strSQL + '  %COLSAI = :QTDSAI, ';
      strSQL := strSQL + '  %MADTSA = :MADTSA, ';
      strSQL := strSQL + '  %MAQTSA = :MAQTSA ';
    End;
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GIR_A_N_O_ = :ANOGIR AND ';
    strSQL := strSQL + '  GIR_CODITE = :CODITE AND ';
    strSQL := strSQL + '  GIR_CODEMP = :CODEMP ';

  End;

  strSQL := AnsiReplaceStr(strSQL, '%COLENT', 'GIR_QENT' + fStrZero(IntToStr(intMes), 2));
  strSQL := AnsiReplaceStr(strSQL, '%COLSAI', 'GIR_QSAI' + fStrZero(IntToStr(intMes), 2));
  strSQL := AnsiReplaceStr(strSQL, '%MADTSA', 'GIR_MDSA' + fStrZero(IntToStr(intMes), 2));
  strSQL := AnsiReplaceStr(strSQL, '%MAQTSA', 'GIR_MQSA' + fStrZero(IntToStr(intMes), 2));

  Try

    With qryGenIte Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      {*****************************************}
      {* DADOS QUE SERÃO ATUALIZADOS           *}
      {**************************************MV*}
      If (Not blnSaida) Then
      Begin
        ParamByName('QTDENT').AsFloat    := fltQtdEnt;
      End
      Else
      Begin
        ParamByName('QTDSAI').AsFloat    := fltQtdSai;
        If fltMaiorQtdSai < 0 Then
        Begin
          ParamByName('MAQTSA').Value := Null;
        End
        Else
        Begin
          ParamByName('MAQTSA').AsFloat    := fltMaiorQtdSai;
        End;

        If dtaMaiorDtaSai <= 0 Then
          ParamByName('MADTSA').Value := Null
        Else
          ParamByName('MADTSA').AsDateTime := dtaMaiorDtaSai;
      End;

      {*****************************************}
      {* DADOS DO FILTRO                       *}
      {**************************************MV*}
      ParamByName('ANOGIR').AsString := strAnoGir;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := IIF(fEmptyStr(strEmpGiro), VS_strCodEmp, strEmpGiro);

      {*****************************************}
      {* AUTO INCREMENTO                       *}
      {**************************************MV*}
      If blnInsere Then
        ParamByName('AUTINC').AsString := fRetAutoIncrem('GIRITE', ParamByName('CODEMP').AsString);

      ExecSQL;
      Close;

    End;

    Result := True;
  Except
    On E: EUniError Do
    Begin
      {*******************************************************}
      {* ESPECÍFICO DO GIRO DE ESTOQUE:                      *}
      {* POR CONTA DE MOVIMENTAÇÕES ANTIGAS (CONVERTIDAS     *}
      {* ALGUNS ITENS QUE ESTÃO GRAVADOS NOS ARQUIVOS DE     *}
      {* FATURAMENTO NÃO ESTÃO MAIS CADASTRADOS NOS DBFS     *}
      {* ENTÃO, CASO HAJA UM ERRO DE INSERÇÃO É IGNORADO TAL *}
      {* REGISTRO.                                           *}
      {****************************************************MV*}
      If (E.ErrorCode = ERROR_FOREIGN_KEY_INSERT) Then
      Begin
        Result := True;
      End
      Else
      Begin
        Result := False;
        pMensagensErro(E.Message + #13#10 + 'Erro Nro: ' + IntToStr(E.ErrorCode), '[ fGravaGirIte ]');
      End;
    End;

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[ fGravaGirIte ]');
    End;
  End;

  FreeAndNil(qryGenIte);

end;

constructor TGiroItem.Create(const fltMedia, fltSaldos, fltSujestao: Double;
                             const strCodIte, strCodEmp: String;
                             Const intQtdMes: Integer;
                                   qryTmpEmp: TUniQuery);
  Var
    wrdDia, wrdMes, wrdAno: Word;
    intContador: Integer;
Begin
  inherited Create;

  FDesM01 := '';
  FDesM02 := '';
  FDesM03 := '';
  FDesM04 := '';
  FDesM05 := '';
  FDesM06 := '';
  FDesM07 := '';
  FDesM08 := '';
  FDesM09 := '';
  FDesM10 := '';
  FDesM11 := '';
  FDesM12 := '';

  FQtdM01 := 0.0;
  FQtdM02 := 0.0;
  FQtdM03 := 0.0;
  FQtdM04 := 0.0;
  FQtdM05 := 0.0;
  FQtdM06 := 0.0;
  FQtdM07 := 0.0;
  FQtdM08 := 0.0;
  FQtdM09 := 0.0;
  FQtdM10 := 0.0;
  FQtdM11 := 0.0;
  FQtdM12 := 0.0;

  FMaiorQtdSai := -1;
  FMaiorDtaSai := 0;

  FCodIte := strCodIte;
  FCodEmp := strCodEmp;
  FQtdMes := intQtdMes;

  FMedia_ := fltMedia;
  FSaldos := fltSaldos;
  FSugest := fltSujestao;

  DecodeDate(VS_date, wrdAno, wrdMes, wrdDia);
  Dec(wrdMes);
  If (wrdMes = 0) Then
  Begin
    wrdMes := 12;
    Dec(wrdAno);
  End;

  For intContador := 1 To intQtdMes Do
  Begin
    Case intContador Of
      01: FDesM01 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      02: FDesM02 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      03: FDesM03 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      04: FDesM04 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      05: FDesM05 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      06: FDesM06 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      07: FDesM07 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      08: FDesM08 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      09: FDesM09 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      10: FDesM10 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      11: FDesM11 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      12: FDesM12 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
    End;

    Dec(wrdMes);
    If (wrdMes = 0) Then
    Begin
      wrdMes := 12;
      Dec(wrdAno);
    End;
  End;

  For intContador := 1 To intQtdMes Do
  Begin
    With qryTmpEmp Do
    Case intContador Of
      01: FQtdM01 := FieldByName('ITE_Q_V_' + fStrZero(intContador, 2)).AsFloat;
      02: FQtdM02 := FieldByName('ITE_Q_V_' + fStrZero(intContador, 2)).AsFloat;
      03: FQtdM03 := FieldByName('ITE_Q_V_' + fStrZero(intContador, 2)).AsFloat;
      04: FQtdM04 := FieldByName('ITE_Q_V_' + fStrZero(intContador, 2)).AsFloat;
      05: FQtdM05 := FieldByName('ITE_Q_V_' + fStrZero(intContador, 2)).AsFloat;
      06: FQtdM06 := FieldByName('ITE_Q_V_' + fStrZero(intContador, 2)).AsFloat;
      07: FQtdM07 := FieldByName('ITE_Q_V_' + fStrZero(intContador, 2)).AsFloat;
      08: FQtdM08 := FieldByName('ITE_Q_V_' + fStrZero(intContador, 2)).AsFloat;
      09: FQtdM09 := FieldByName('ITE_Q_V_' + fStrZero(intContador, 2)).AsFloat;
      10: FQtdM10 := FieldByName('ITE_Q_V_' + fStrZero(intContador, 2)).AsFloat;
      11: FQtdM11 := FieldByName('ITE_Q_V_' + fStrZero(intContador, 2)).AsFloat;
      12: FQtdM12 := FieldByName('ITE_Q_V_' + fStrZero(intContador, 2)).AsFloat;
    End;

    If qryTmpEmp.FieldByName('ITE_MQSA' + fStrZero(intContador, 2)).AsFloat > FMaiorQtdSai Then
    Begin
      FMaiorQtdSai := qryTmpEmp.FieldByName('ITE_MQSA' + fStrZero(intContador, 2)).AsFloat;
      If (Not fEmptyStr(qryTmpEmp.FieldByName('ITE_MDSA' + fStrZero(intContador, 2)).AsString)) And
         (qryTmpEmp.FieldByName('ITE_MDSA' + fStrZero(intContador, 2)).AsString <> '0')          Then
        FMaiorDtaSai :=  qryTmpEmp.FieldByName('ITE_MDSA' + fStrZero(intContador, 2)).AsDateTime;
    End;

  End;
  
End;

constructor TGiroItem.Create(const strCodIte, strCodEmp: String;
  intQtdMes, intDiaCom: Integer; blnConsMCom, blnArredSug: Boolean);
  Var
    intContador: Integer;
    wrdDia, wrdMes, wrdAno: Word;
    qryAux: TUniQuery;
    fltSugMult: Double;
    strSQL : String;
begin

  inherited Create;

  qryAux := fCriaQuery(Nil);

  If (intQtdMes = 0) Then
    intQtdMes := 3;

  FCodIte := strCodIte;
  FCodEmp := strCodEmp;
  FQtdMes := intQtdMes;

  FDesM01 := '';
  FDesM02 := '';
  FDesM03 := '';
  FDesM04 := '';
  FDesM05 := '';
  FDesM06 := '';
  FDesM07 := '';
  FDesM08 := '';
  FDesM09 := '';
  FDesM10 := '';
  FDesM11 := '';
  FDesM12 := '';

  FQtdM01 := 0.0;
  FQtdM02 := 0.0;
  FQtdM03 := 0.0;
  FQtdM04 := 0.0;
  FQtdM05 := 0.0;
  FQtdM06 := 0.0;
  FQtdM07 := 0.0;
  FQtdM08 := 0.0;
  FQtdM09 := 0.0;
  FQtdM10 := 0.0;
  FQtdM11 := 0.0;
  FQtdM12 := 0.0;
  FSugest := 0.0;
  FMedia_ := 0.0;
  FSaldos := 0.0;

  DecodeDate(VS_date, wrdAno, wrdMes, wrdDia);
  Dec(wrdMes);
  If (wrdMes = 0) Then
  Begin
    wrdMes := 12;
    Dec(wrdAno);
  End;

  qryAux.SQL.Add('SELECT ');

  For intContador := 1 To intQtdMes Do
  Begin
    qryAux.SQL.Add(Format('(SELECT ' +
                          '   SUM(IFNULL(GIR_QSAI' + fStrZero(wrdMes, 2) + ', 0)) AS QSAI' + fStrZero(wrdMes, 2) + ' ' +
                          'FROM ' +
                          '   GIRITE ' +
                          'WHERE ' +
                          '   GIR_CODITE = :CODITE AND ' +
                          '   GIR_CODEMP LIKE :CODEMP AND ' +
                          '   GIR_A_N_O_ = %d) AS QSAI' + fStrZero(intContador, 2), [wrdAno]));

    qryAux.SQL.Add(', ');

    qryAux.SQL.Add(Format('(SELECT ' +
                          '   SUM(IFNULL(GIR_MQSA' + fStrZero(wrdMes, 2) + ', 0)) AS MQSA' + fStrZero(wrdMes, 2) + ' ' +
                          'FROM ' +
                          '   GIRITE ' +
                          'WHERE ' +
                          '   GIR_CODITE = :CODITE AND ' +
                          '   GIR_CODEMP LIKE :CODEMP AND ' +
                          '   GIR_A_N_O_ = %d) AS MQSA' + fStrZero(intContador, 2), [wrdAno]));

    qryAux.SQL.Add(', ');

    qryAux.SQL.Add(Format('CAST((SELECT ' +
                          '   GIR_MDSA' + fStrZero(wrdMes, 2) + ' AS MDSA' + fStrZero(wrdMes, 2) + ' ' +
                          'FROM ' +
                          '   GIRITE ' +
                          'WHERE ' +
                          '   GIR_CODITE = :CODITE AND ' +
                          '   GIR_CODEMP LIKE :CODEMP AND ' +
                          '   GIR_A_N_O_ = %d) AS DATE) AS MDSA' + fStrZero(intContador, 2), [wrdAno]));

    qryAux.SQL.Add(', ');



    Case intContador Of
      01: FDesM01 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      02: FDesM02 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      03: FDesM03 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      04: FDesM04 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      05: FDesM05 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      06: FDesM06 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      07: FDesM07 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      08: FDesM08 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      09: FDesM09 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      10: FDesM10 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      11: FDesM11 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
      12: FDesM12 := fStrZero(wrdMes, 2) + '/' + IntToStr(wrdAno);
    End;

    Dec(wrdMes);
    If (wrdMes = 0) Then
    Begin
      wrdMes := 12;
      Dec(wrdAno);
    End;
  End;

  qryAux.SQL.Add('  G.ITE_SALDOS,                   ');
  qryAux.SQL.Add('  I.ITE_MLTCOM                    ');
  qryAux.SQL.Add('FROM                              ');
  qryAux.SQL.Add('  ITEGER G,                       ');
  qryAux.SQL.Add('  CADITE I                        ');
  qryAux.SQL.Add('WHERE                             ');
  qryAux.SQL.Add('  I.ITE_CODITE = G.ITE_CODITE AND ');
  qryAux.SQL.Add('  G.ITE_CODITE = :CODITE AND      ');
  qryAux.SQL.Add('  G.ITE_CODEMP LIKE :CODEMP       ');

  strSQL := qryAux.SQL.Text;

  qryAux.ParamByName('CODITE').AsString := strCodIte;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.Open;

  FMaiorQtdSai := -1;
  FMaiorDtaSai := 0.0;

  For intContador := 1 To intQtdMes Do
  Begin

    FMedia_ := FMedia_ + qryAux.FieldByName('QSAI' + fStrZero(intContador, 2)).AsFloat;
    Case intContador Of
      01: FQtdM01 := qryAux.FieldByName('QSAI' + fStrZero(intContador, 2)).AsFloat;
      02: FQtdM02 := qryAux.FieldByName('QSAI' + fStrZero(intContador, 2)).AsFloat;
      03: FQtdM03 := qryAux.FieldByName('QSAI' + fStrZero(intContador, 2)).AsFloat;
      04: FQtdM04 := qryAux.FieldByName('QSAI' + fStrZero(intContador, 2)).AsFloat;
      05: FQtdM05 := qryAux.FieldByName('QSAI' + fStrZero(intContador, 2)).AsFloat;
      06: FQtdM06 := qryAux.FieldByName('QSAI' + fStrZero(intContador, 2)).AsFloat;
      07: FQtdM07 := qryAux.FieldByName('QSAI' + fStrZero(intContador, 2)).AsFloat;
      08: FQtdM08 := qryAux.FieldByName('QSAI' + fStrZero(intContador, 2)).AsFloat;
      09: FQtdM09 := qryAux.FieldByName('QSAI' + fStrZero(intContador, 2)).AsFloat;
      10: FQtdM10 := qryAux.FieldByName('QSAI' + fStrZero(intContador, 2)).AsFloat;
      11: FQtdM11 := qryAux.FieldByName('QSAI' + fStrZero(intContador, 2)).AsFloat;
      12: FQtdM12 := qryAux.FieldByName('QSAI' + fStrZero(intContador, 2)).AsFloat;
    End;

    If qryAux.FieldByName('MQSA' + fStrZero(intContador, 2)).AsFloat > FMaiorQtdSai Then
    Begin
      FMaiorQtdSai := qryAux.FieldByName('MQSA' + fStrZero(intContador, 2)).AsFloat;
      If (Not fEmptyStr(qryAux.FieldByName('MDSA' + fStrZero(intContador, 2)).AsString)) And
         (qryAux.FieldByName('MDSA' + fStrZero(intContador, 2)).AsString <> '0')       Then
        FMaiorDtaSai := qryAux.FieldByName('MDSA' + fStrZero(intContador, 2)).AsDateTime;
    End;

  End;

  FMedia_ := FMedia_ / intQtdMes;
  FSaldos := qryAux.FieldByName('ITE_SALDOS').AsFloat;

  FSugest := ((FMedia_ / 30.0) * intDiaCom) - FSaldos;
  If (FSugest < 0.0) Then
    FSugest := 0.0;

  If (blnConsMCom) Then
  Begin

    fltSugMult :=  (round(FSugest / qryAux.fieldbyname('ITE_MLTCOM').asfloat)) * qryAux.fieldbyname('ITE_MLTCOM').asfloat;

    If fltSugMult < FSugest Then
      FSugest := (round(FSugest / qryAux.fieldbyname('ITE_MLTCOM').asfloat) + 1) * qryAux.fieldbyname('ITE_MLTCOM').asfloat
    Else
      FSugest := fltSugMult;

    FSugest := Ceil(FSugest);
  End
  Else If (blnArredSug) Then
    FSugest := Ceil(FSugest);
  
end;


end.
