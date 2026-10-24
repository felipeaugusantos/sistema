unit untDocumentoCRFF;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untTypesSistema, untLeDocumento, untFuncoesSimples, TypesRel, untFuncoesEditorFast,
  untZClient, Uni, System.Variants;

Type

  TLeDocumentoCRFF = Class(TLeDocumento)
  Private
    cdsMovGer: TZClient;
    function fSQLMovGer: String;
    function fInsereClientMovGer(Var regClient: TRegClient): Boolean;
    function fMontaDuplicatasdeCredito(cdsMovGer: TZClient; strNumDup, strCodEmp : String): String;
    function fMontaProdutosDupCredito(strNumDoc, strEspDoc, strCodEmp, strIncDoc : String): String;
    procedure pMontaDuplicatasdeCredito(cdsMovGer: TZClient);
    procedure pMontaDuplicatasdeCreditoComProdutos(cdsMovGer: TZClient);
    procedure pSetaNomeTabela;
  Public
    function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; override;
    constructor Create(Owner: TComponent); Override;
    Destructor  Destroy; Override;
  protected
  End;

implementation

uses untConstantes, Data.DB;

constructor TLeDocumentoCRFF.Create(Owner: TComponent);
begin
  Inherited Create(Owner);
end;

destructor TLeDocumentoCRFF.Destroy;
begin
  Inherited;
end;

procedure TLeDocumentoCRFF.pMontaDuplicatasdeCredito(cdsMovGer: TZClient);
  var
    strSQL: String;
    qryCND: TUniQuery;
    strDupCre, strNumDup, strCodEmp: String;
begin

  if cdsMovGer.IsEmpty then
    Exit;

  cdsMovGer.edit;
  Begin
    strSQL := ' SELECT CONCAT(CTR_NUMDUP,"-",CTR_ESPDOC,"-",CTR_CODEMP) AS DUPCRE, CTR_CODEMP FROM CADREC '+
                'WHERE CTR_SEQCON = :SEQCON                                   '+
                '  AND CTR_CODCLI = :CODCLI                                   '+
                '  AND CTR_VALORI < 0                                         ';

    Try
      qryCND := fCriaQuery;
      qryCND.Close;
      qryCND.SQL.Clear;
      qryCND.SQL.Add(strSQL);
      qryCND.ParamByName('SEQCON').AsString := cdsMovGer.FieldByName('SEQCO1').AsString ;
      qryCND.ParamByName('CODCLI').AsString := recDocume.strCodCli ;
      qryCND.Open;

        While not qryCND.eof do
        Begin
          strDupCre := strDupCre + ' ' + qryCND.FieldByName('DUPCRE').AsString + '-' ;
          strNumDup := Copy(qryCND.FieldByName('DUPCRE').AsString,1,12);
          strCodEmp := qryCND.FieldByName('CTR_CODEMP').AsString;
          strDupCre := strDupCre + fMontaDuplicatasdeCredito(cdsMovGer,strNumDup,strCodEmp) + #13#10 ;
          qryCND.Next;
        End;

        cdsMovGer.FieldByName('DUPCRE').AsString :=  strDupCre;
    Finally
      FreeAndNil(qryCND);
    End;
  End;
end;

procedure TLeDocumentoCRFF.pMontaDuplicatasdeCreditoComProdutos(cdsMovGer: TZClient);
  var
    strSQL, strSQLAd: String;
    qryCND: TUniQuery;
    strCampos, strNumDup, strVariaveis, strMontaVar: String;
    fltTotCre : Double;
begin

  if cdsMovGer.IsEmpty then
    Exit;

  strMontaVar := '';
  cdsMovGer.edit;
  Begin
    fltTotCre := 0;

    strSQL := 'SELECT DISTINCT                                                                               '+
              '   CR2.CTR_NUMDUP AS DUPCRE, CR2.CTR_ESPDOC AS ESPCRE,                                         '+
              '   CR2.CTR_CODEMP AS CODEMP, CR2.CTR_VALORI AS VALORI,                                         '+
              '   CR2.CTR_INCDOC AS INCDOC                                                                    '+
              'FROM MOVGER MG LEFT JOIN CADREC CR1 ON                                                         '+
              '  CR1.CTR_NUMDUP = MG.GER_NUMDOC                                                               '+
              '  AND MG.GER_ESPDOC = CR1.CTR_ESPDOC                                                           '+
              '  AND MG.GER_CODEMP = CR1.CTR_CODEMP                                                           '+
              '  AND MG.GER_CODCLI = CR1.CTR_CODCLI                                                           '+
              '  AND MG.GER_TIP_FC = "C"                                                                      '+
              'LEFT JOIN CADREC CR2 ON                                                                        '+
              '  CR2.CTR_SEQCON = CR1.CTR_SEQCON                                                              '+
              '  AND CR2.CTR_CODCLI = CR1.CTR_CODCLI                                                          '+
              '  AND CR2.CTR_CODEMP = CR1.CTR_CODEMP                                                          '+
              '  AND CR2.CTR_VALORI < 0                                                                       '+
              '  AND CR2.CTR_DTAREC IS NOT NULL                                                               '+
              'WHERE MG.GER_NUMDOC = :NUMDOC                                                                  '+
              '  AND MG.GER_ESPDOC = :ESPDOC                                                                  '+
              '  AND MG.GER_CODEMP = :CODEMP                                                                  '+
              '  AND MG.GER_TIP_FC = "C"                                                                      '+
              '  AND CR1.CTR_SEQCON > 0                                                                       ';

    Try
      qryCND := fCriaQuery;
      qryCND.Close;
      qryCND.SQL.Clear;
      qryCND.SQL.Add(strSQL);
      qryCND.ParamByName('NUMDOC').AsString := cdsMovGer.FieldByName('NUMDOC').AsString ;
      qryCND.ParamByName('ESPDOC').AsString := cdsMovGer.FieldByName('ESPDOC').AsString ;
      qryCND.ParamByName('CODEMP').AsString := cdsMovGer.FieldByName('CODEMP').AsString ;
      qryCND.Open;

      If fEmptyStr(qryCND.FieldByName('DUPCRE').AsString) Then
      Begin
        strSQLAd := ' SELECT DISTINCT                                                                               '+
                    '   CR2.CTR_NUMDUP AS DUPCRE, CR2.CTR_ESPDOC AS ESPCRE,                                         '+
                    '   CR2.CTR_CODEMP AS CODEMP, CR2.CTR_VALORI AS VALORI,                                         '+
                    '   CR2.CTR_INCDOC AS INCDOC                                                                    '+
                    ' FROM MOVGER MG LEFT JOIN FATGOR FG ON                                                          '+
                    '  FG.FGO_NUMFAT = MG.GER_NUMDOC                                                                '+
                    '  AND FG.FGO_TIPFAT = MG.GER_ESPDOC                                                            '+
                    '  AND FG.FGO_EMPFAT = MG.GER_CODEMP                                                            '+
                    '  AND MG.GER_TIP_FC = "C"                                                                      '+
                    ' LEFT JOIN ADTCLI AC ON                                                                         '+
                    '  AC.ADT_NUMDOC = FG.FGO_NUMDOC                                                                '+
                    '  AND AC.ADT_ESPDOC = FG.FGO_ESPDOC                                                            '+
                    '  AND AC.ADT_EMPLAN = FG.FGO_CODEMP                                                            '+
                    '  AND AC.ADT_TIPLAN = "C"                                                                      '+
                    ' LEFT JOIN CADREC CR2 ON                                                                        '+
                    '  CR2.CTR_SEQCON = AC.ADT_SEQCON                                                               '+
                    '  AND CR2.CTR_CODCLI = AC.ADT_CODCLI                                                           '+
                    '  AND CR2.CTR_CODEMP = AC.ADT_CODEMP                                                           '+
                    '  AND CR2.CTR_VALORI < 0                                                                       '+
                    '  AND CR2.CTR_DTAREC IS NOT NULL                                                               '+
                    ' WHERE MG.GER_NUMDOC = :NUMDOC                                                                  '+
                    '  AND MG.GER_ESPDOC = :ESPDOC                                                                  '+
                    '  AND MG.GER_CODEMP = :CODEMP                                                                  '+
                    '  AND MG.GER_TIP_FC = "C"                                                                      ';

        qryCND.Close;
        qryCND.SQL.Clear;
        qryCND.SQL.Add(strSQLAd);
        qryCND.ParamByName('NUMDOC').AsString := cdsMovGer.FieldByName('NUMDOC').AsString ;
        qryCND.ParamByName('ESPDOC').AsString := cdsMovGer.FieldByName('ESPDOC').AsString ;
        qryCND.ParamByName('CODEMP').AsString := cdsMovGer.FieldByName('CODEMP').AsString ;
        qryCND.Open;
      End;

      If Not fEmptyStr(qryCND.FieldByName('DUPCRE').AsString) Then
      Begin
        While not qryCND.eof do
        Begin
          strNumDup := 'DOCUMENTO: ' + qryCND.FieldByName('DUPCRE').AsString + '-' + qryCND.FieldByName('ESPCRE').AsString;
          strCampos := 'CÓD. ITEM | DESCRIÇÃO DO ITEM              | QUANTIDADE |  VALOR  |   DOCUMENTO   |';
          strVariaveis := fMontaProdutosDupCredito(qryCND.FieldByName('DUPCRE').AsString,
                                                   qryCND.FieldByName('ESPCRE').AsString,
                                                   qryCND.FieldByName('CODEMP').AsString,
                                                   qryCND.FieldByName('INCDOC').AsString);
          strMontaVar := strMontaVar + strNumDup + #13#10 + strCampos + #13#10 + strVariaveis + #13#10  + 'TOTAL DE CRÉDITOS UTILIZADOS: R$ ' + FormatFloat('###,##0.00',qryCND.FieldByName('VALORI').asFloat)  + #13#10 + #13#10;
          fltTotCre := fltTotCre + qryCND.FieldByName('VALORI').AsFloat;
          qryCND.Next;
        End;

        cdsMovGer.FieldByName('DUPPRO').AsString :=  strMontaVar;
        cdsMovGer.FieldByName('TOTCRE').AsString :=  FloatToStr(fltTotCre * -1);
      End;
    Finally
      FreeAndNil(qryCND);
    End;
  End;
end;

Function TLeDocumentoCRFF.fSQLMovGer: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE DISTINCT        ';
  strSQL := strSQL + '  GER_SERIE_ AS SERDOC,             ';
  strSQL := strSQL + '  GER_NUMDOC AS NUMDOC,             ';
  strSQL := strSQL + '  GER_ESPDOC AS ESPDOC,             ';
  strSQL := strSQL + '  GER_CODEMP AS CODEMP,             ';
  strSQL := strSQL + '  GER_CODCLI AS CODCLI,             ';
  strSQL := strSQL + '  GER_DTAENT AS DTAENT,             ';
  strSQL := strSQL + '  GER_HORENT AS HORENT,             ';
  strSQL := strSQL + '  GER_DTAFAT AS DTAFAT,             ';
  strSQL := strSQL + '  GER_CODVEN AS CODVEN,             ';
  strSQL := strSQL + '  CAST("" AS CHAR(1)) AS DUPCRE,    ';
  strSQL := strSQL + '  CAST("" AS CHAR(3000)) AS DUPPRO, ';
  strSQL := strSQL + '  0.00 AS TOTCRE                    ';
  strSQL := strSQL + ', CR.CTR_SEQCON AS SEQCO1           ';
  strSQL := strSQL + 'FROM                                ';
  strSQL := strSQL + strTabGer + ' G ';
  strSQL := strSQL + '  LEFT JOIN MOVDET MD ON MD.DET_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN CADREC CR ON ';
  strSQL := strSQL + '        CR.CTR_CODEMP = G.GER_CODEMP AND ';
  strSQL := strSQL + '        CR.CTR_ESPDOC = G.GER_ESPDOC AND ';
  strSQL := strSQL + '        CR.CTR_NUMDUP = G.GER_NUMDOC AND ';
  strSQL := strSQL + '        CR.CTR_CODCLI = G.GER_CODCLI ';
  If (strTabGer = 'MOVGER') Then
  Begin
    strSQL := strSQL + ' LEFT JOIN ASSGER ON ASS_SEQGER = G.AUTOINCREM ';
    strSQL := strSQL + ' LEFT JOIN CADOCO ON CADOCO.OCO_CODOCO = G.GER_CODOCO ';
  End;
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP     ';
  Result := strSQL;
End;

Function TLeDocumentoCRFF.fInsereClientMovGer(Var regClient: TRegClient): Boolean;
Begin

  With regClient Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLMovGer);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxMovger';
    frxDados.UserName := 'frxMovger';
  End;

  With regClient, cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;
    Result := fAbreClient(True, 'fInsereClientMovGer');
  End;

End;

Procedure TLeDocumentoCRFF.pSetaNomeTabela;
Begin
  strTabGer := 'MOVGER';
End;

Function TLeDocumentoCRFF.fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean;
  Var
    regClient: TRegClient;
Begin
  Try
    Result := True;
    pSetaNomeTabela;

    SetLength(arrClients, 1);
    Result         := Result And fInsereClientMovGer(regClient);

    If Not Result Then
      Exit;

    arrClients[0]  := regClient;
    cdsMovGer      := arrClients[0].cdsDados;

    If not fEmptyStr(cdsMovGer.FieldByName('SEQCO1').AsString) Then
    Begin
      pMontaDuplicatasdeCredito(cdsMovGer);
      pMontaDuplicatasdeCreditoComProdutos(cdsMovGer);
    End;
    Result := Result And fPreparaImpressaoDocumentos;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
End;

function TLeDocumentoCRFF.fMontaDuplicatasdeCredito(cdsMovGer: TZClient; strNumDup, strCodEmp : String): String;
  var
    strSQL: String;
    qryCND: TUniQuery;
begin

  if cdsMovGer.IsEmpty then
    Exit;

  cdsMovGer.edit;
  strSQL := strSQL + ' SELECT CTR_HIST01 AS HISDCR ';
  strSQL := strSQL + '      FROM CADREC ';
  strSQL := strSQL + '     WHERE CTR_NUMDUP = :NUMDUP ';
  strSQL := strSQL + '      AND CTR_CODEMP = :CODEMP ';
  strSQL := strSQL + '      AND CTR_CODCLI = :CODCLI ';

  Try
    qryCND := fCriaQuery;
    qryCND.Close;
    qryCND.SQL.Clear;
    qryCND.SQL.Add(strSQL);
    qryCND.ParamByName('NUMDUP').AsString := strNumDup ;
    qryCND.ParamByName('CODEMP').AsString := strCodEmp ;
    qryCND.ParamByName('CODCLI').AsString := recDocume.strCodCli ;
    qryCND.Open;

    Result := qryCND.FieldByName('HISDCR').AsString;
  Finally
    FreeAndNil(qryCND);
  End;
end;

function TLeDocumentoCRFF.fMontaProdutosDupCredito(strNumDoc, strEspDoc, strCodEmp, strIncDoc: String): String;
  var
    strSQL, strMontaVar: String;
    qryCND: TUniQuery;
begin

  if cdsMovGer.IsEmpty then
    Exit;

  cdsMovGer.edit;
  strSQL := strSQL + ' SELECT DET_CODITE AS CODITE,                          ';
  strSQL := strSQL + '    RPAD(DET_DESCRI, 30, " ") AS DESITE,               ';
  strSQL := strSQL + '    LPAD(FORMAT(DET_QTDITE,2), 12, " ") AS QTDITE,     ';
  strSQL := strSQL + '    LPAD(FORMAT(DET_TOTITE,2), 9, " ") AS TOTITE,      ';
  If strIncDoc = '' Then
  Begin
    strSQL := strSQL + '    DET_DOCDEV AS DOCDEV,                              ';
    strSQL := strSQL + '    DET_ESPDEV AS ESPDEV                               ';
  End
  Else If strIncDoc <> '' Then
  Begin
    strSQL := strSQL + '    DET_NUMDOC AS DOCDEV,                              ';
    strSQL := strSQL + '    DET_ESPDOC AS ESPDEV                               ';
  End;

  strSQL := strSQL + '      FROM MOVDET                                      ';
  strSQL := strSQL + '    WHERE TRUE                                         ';

  If strIncDoc = '' Then
  Begin
    strSQL := strSQL + '      AND DET_NUMDOC = :NUMDOC                        ';
    strSQL := strSQL + '      AND DET_ESPDOC = :ESPDOC                        ';
    strSQL := strSQL + '      AND DET_CODEMP = :CODEMP                        ';
  End
  Else If strIncDoc <> '' Then
  Begin
    strSQL := strSQL + '      AND DET_SEQGER = :SEQGER                        ';
  End;

  Try
    qryCND := fCriaQuery;
    qryCND.Close;
    qryCND.SQL.Clear;
    qryCND.SQL.Add(strSQL);

    If strIncDoc = '' Then
    Begin
      qryCND.ParamByName('NUMDOC').AsString := strNumDoc ;
      qryCND.ParamByName('CODEMP').AsString := strCodEmp ;
      qryCND.ParamByName('ESPDOC').AsString := strEspdoc ;
    End
    Else If strIncDoc <> '' Then
    Begin
      qryCND.ParamByName('SEQGER').AsString := strIncDoc ;
    End;

    qryCND.Open;

    While not qryCND.eof do
    Begin
      strMontaVar := strMontaVar + qryCND.FieldByName('CODITE').AsString + '      ' + qryCND.FieldByName('DESITE').AsString + '   ' + qryCND.FieldByName('QTDITE').AsString +
                    ' ' + qryCND.FieldByName('TOTITE').AsString + ' ' + qryCND.FieldByName('DOCDEV').AsString + '-' + qryCND.FieldByName('ESPDEV').AsString + #13#10;
      qryCND.Next;
    End;

    Result := strMontaVar;
  Finally
    FreeAndNil(qryCND);
  End;
end;

end.

