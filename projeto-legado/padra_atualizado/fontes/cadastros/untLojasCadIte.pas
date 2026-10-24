unit untLojasCadIte;

interface

uses
  Classes, SysUtils, Controls, ComCtrls, DB, Forms,
  untZClient, Uni, untTPontoExposicao;

Type
  TAfterScrollDo = procedure (AstrCodEmp: String) of Object;

  TLojasCadIte = Class(TZClient)
  Private
    blnUsaPontoDeExposicao: Boolean;
    blnInclusao,
    blnMinDig,
    blnCprInd,
    blnInfMat,
    blnEmpGer: Boolean;
    blnPerVdaITEGER: Boolean;

    qryCadEmp,
    qrySitPro: TUniQuery;
    qryCommand: TUniQuery;

    PontosExposicoes: TPontosExposicoes;
    intSitPro: Integer;
    FAfterScrollDo: TAfterScrollDo;

    Function fSQLEmpresas: String;

    Function fSQLLojas: String;

    Function fSQLSituacao: String;

    Procedure pBeforePost(dataSet: TDataSet);
    Procedure pAfterScroll(dataSet: TDataSet);
    Procedure pAfterPost(dataSet: TDataSet);

    procedure pSetText_APERET(Sender: TField; const Text: string);
    procedure pSetText_APEENT(Sender: TField; const Text: string);

    Procedure pAlteraTodasAsLojas(strCprCen, strEmpCen: String);
    function fPodeAlterar(DataSet: TDataSet; blnInfMat,blnEmpGer: Boolean): Boolean;


  Public

    blnReadOnly: Boolean;

    dtsCadEmp,
    dtsSitPro: TDataSource;

    property AfterScrollDo: TAfterScrollDo read FAfterScrollDo write FAfterScrollDo;

    constructor Create(Owner: TComponent); Reintroduce;


    Destructor Destroy; override;

    Function fCarregaInfoLojas(qryIteger: TUniQuery): Boolean;

    procedure pGravaInfoLojas(strForm: TForm; strCodIte: String);

    Procedure pSetDadosInclusaoIgualParaTodasAsEmpresas(strCodEmp: String; qryIteger: TUniQuery);

    Procedure pSetDadosInclusaoIndividual(qryIteger: TUniQuery);

    Procedure pIniciaDadosInclusao(strCodEmp: String);

    Procedure pHabilitaLojas(blnHabilita: Boolean);

    Procedure pPost;

    procedure pGeraLogPontoExposicao;
    procedure pAtualizaPontoExposicoes;


    procedure pCarregaPontoExposicao;

    Function fValidaEstMinEstMax: Boolean;

   // Function fValidaEmpresas: Boolean;

  End;

implementation

Uses
  untFuncoesSimples, untAltEst, untIFatReservaSaldo, untTFatReservaSaldo,
  untIFatEntregaFutura, untTFatEntregaFutura;

constructor TLojasCadIte.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLLojas);
  blnUsaPontoDeExposicao := fCfgSis('PONEXP', varBoolean);
  intSitPro := fCfgSis('SITEMP', varInteger);
  blnReadOnly := True;

  blnInfMat := fCfgSis('INFMAT', varBoolean);
  blnEmpGer := fCfgSis('EMPGER', varBoolean);
  blnCprInd := fCfgSis('CPRIND', varBoolean);
  blnMinDig := fCfgSis('MINDIG', varBoolean);
  blnPerVdaITEGER := (fCfgSisL('PERVDA', varString) = '2');

  qryCadEmp := fCriaQuery(Self);
  qryCadEmp.SQL.Text := fSQLEmpresas;
  qryCadEmp.Open;
  dtsCadEmp := TDataSource.Create(Self);
  dtsCadEmp.DataSet := qryCadEmp;

  qrySitPro := fCriaQuery(Self);
  qrySitPro.SQL.Text := fSQLSituacao;
  qrySitPro.Open;
  dtsSitPro := TDataSource.Create(Self);
  dtsSitPro.DataSet := qrySitPro;
  qryCommand := fCriaQuery(Self);
End;

Destructor TLojasCadIte.Destroy;
Begin
  Inherited;
End;

Function TLojasCadIte.fSQLEmpresas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(3)) AS CODEMP, ';
  strSQL := strSQL + '   "Compra não centralizada" AS NOMEMP ';

  strSQL := strSQL + '  UNION ALL ';

  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   EMP_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   CONCAT(EMP_CODEMP, "-", EMP_NOMEMP) AS NOMEMP ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADEMP ';
  strSQL := strSQL + ' ORDER BY CODEMP ';

  Result := strSQL;
End;

Function TLojasCadIte.fSQLLojas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   I.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   EMP_CODEMP   AS CODEMP, ';
  strSQL := strSQL + '   EMP_NOMEMP   AS NOMEMP, ';
  strSQL := strSQL + '   EMP_CODMAT   AS CODMAT, ';
  strSQL := strSQL + '   SIS_VALCFG   AS EMPMAT, ';
  strSQL := strSQL + '   I.ITE_DTABAL AS DTABAL, ';
  strSQL := strSQL + '   I.ITE_SALBAL AS SALBAL, ';
  strSQL := strSQL + '   I.ITE_ML_BAL AS ML_BAL, ';
  strSQL := strSQL + '   I.ITE_DTAAJU AS DTAAJU, ';
  strSQL := strSQL + '   I.ITE_QTDAJU AS QTDAJU, ';
  strSQL := strSQL + '   I.ITE_SALDOS AS SALDOS, ';
  strSQL := strSQL + '   I.ITE_SAL_ML AS SAL_ML, ';
  strSQL := strSQL + '   I.ITE_NIVCRI AS NIVCRI, ';
  strSQL := strSQL + '   0.0000       AS SALRES, ';
  strSQL := strSQL + '   IFNULL(I.ITE_ESTMIN, 0) AS ESTMIN, ';
  strSQL := strSQL + '   IFNULL(I.ITE_ESTMAX, 0) AS ESTMAX, ';

  strSQL := strSQL + '   IFNULL(I.ITE_MAXDIG, 0) AS MAXDIG, ';
  strSQL := strSQL + '   IFNULL(I.ITE_MINDIG, 0) AS MINDIG, ';
  strSQL := strSQL + '   IFNULL(I.ITE_PONPED, 0) AS PONPED, ';

  strSQL := strSQL + '   IFNULL(I.ITE_NIVGIR, "C") AS NIVGIR, ';
  strSQL := strSQL + '   IFNULL(I.ITE_IMPLIS, "S") AS IMPLIS, ';
  strSQL := strSQL + '   IFNULL(I.ITE_APERET, "N") AS APERET, ';
  strSQL := strSQL + '   IFNULL(I.ITE_APEENT, "N") AS APEENT, ';
  strSQL := strSQL + '   IFNULL(I.ITE_CPRCEN, "N") AS CPRCEN, ';
  strSQL := strSQL + '   I.ITE_EMPCEN              AS EMPCEN, ';
  strSQL := strSQL + '   I.ITE_SITPRO              AS SITPRO, ';
  strSQL := strSQL + '   I.ITE_PONEXP              AS PONEXP, ';
  strSQL := strSQL + '   IFNULL(I.ITE_ESMIDG, "G") AS ESMIDG, ';
  strSQL := strSQL + '   IFNULL(I.ITE_TPESTM, "")  AS TPESTM, ';
  strSQL := strSQL + '   IFNULL(I.ITE_PEVNDA, "T") AS PEVNDA  ';

  strSQL := strSQL + ' FROM CADEMP  ';

  strSQL := strSQL + ' LEFT JOIN ITEGER I ON I.ITE_CODEMP = EMP_CODEMP ';
  strSQL := strSQL + '                   AND I.ITE_CODITE = :CODITE    ';

  strSQL := strSQL + ' LEFT JOIN CFGSIS   ON SIS_CODEMP = EMP_CODEMP  ';
  strSQL := strSQL + '                    AND SIS_CODCFG = "CFG_EMPMAT"';

  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   IF(EMP_CODEMP = :EMPLOG, "000", EMP_CODEMP) ';

  Result := strSQL;
End;

function TLojasCadIte.fSQLSituacao: String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   SIT_CODIGO AS SITCOD, ';
  strSQL := strSQL + '   CONCAT(SIT_CODIGO, "-", SIT_DESCRI) AS SITDES  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   SITPRO ';
  Result := strSQL;
end;

function TLojasCadIte.fValidaEstMinEstMax: Boolean;
begin
  Try
    Result := False;
    First;
    While Not Eof Do
    Begin
      If FieldByName('ESTMIN').IsNull Or fEmptyStr(FieldByName('ESTMIN').AsString) Then
      Begin
        pMensagemOk('O estoque mínimo não pode ficar sem informação!');
        Exit(True);
      End;

      If FieldByName('ESTMAX').IsNull Or fEmptyStr(FieldByName('ESTMAX').AsString) Then
      Begin
        pMensagemOk('O estoque máximo não pode ficar sem informação!');
        Exit(True);
      End;

      If FieldByName('ESTMIN').AsFloat < 0 Then
      Begin
        pMensagemOk('O estoque mínimo não pode ser menor zero');
        Exit(True);
      End;

      If FieldByName('ESTMAX').AsFloat < 0 Then
      Begin
        pMensagemOk('O estoque máximo não pode ser menor zero');
        Exit(True);
      End;

      If ((FieldByName('ESTMAX').AsFloat > 0) Or (FieldByName('ESTMIN').AsFloat > 0)) And
         (FieldByName('ESTMAX').AsFloat < FieldByName('ESTMIN').AsFloat) Then
      Begin
        pMensagemOk('O estoque máximo não pode ser menor que o estoque mínimo!');
        Exit(True);
      End;

     Next;
    End;
  Finally
    First;
  End;
end;

Function TLojasCadIte.fCarregaInfoLojas(qryIteger: TUniQuery): Boolean;
Begin
  ReadOnly    := False;
  BeforePost  := Nil;
  AfterScroll := Nil;
  AfterPost   := Nil;

  blnInclusao := qryIteger.State = dsInsert;

  With qryQuery Do
  Begin
    ParamByName('CODITE').AsString := qryIteGer.FieldByName('ITE_CODITE').AsString;
    ParamByName('EMPLOG').AsString := VS_strCodEmp;

    Result := fAbreClient(True, 'TLojasCadIte.fCarregaInfoLojas');

    pAlinhaCampoCentro('CODEMP');
    pAlinhaCampoCentro('DTABAL');
    pAlinhaCampoCentro('DTAAJU');
    pAlinhaCampoCentro('NIVGIR');
    pAlinhaCampoCentro('NIVCRI');

    If Not Result Then
      Exit;
  End;

  If Not fEmptyStr(qryIteGer.FieldByName('ITE_CODITE').AsString) Then
  Begin
    First;

    While Not Eof Do
    Begin
      Edit;

      If fUsaQtdPendenteEntregaFutura Then
        FieldByName('SALDOS').AsFloat := FieldByName('SALDOS').AsFloat +
                                          TEntregaFutura.New(
                                            TParamEF.New()
                                              .CodIte(FieldByName('CODITE').AsString)
                                              .CodEmp(FieldByName('CODEMP').AsString)
                                              .TipoTE(tteTodas)
                                            ).Total();

      If fEmptyStr(FieldByName('CODITE').AsString) Then
        FieldByName('SALRES').AsFloat := 0
      Else
        FieldByName('SALRES').AsFloat := TSaldoReservado.New(
                                           TReservaParametros.New()
                                             .EmpresaItem(FieldByName('CODEMP').AsString)
                                             .CodigoItem(FieldByName('CODITE').AsString)
                                             .CodEmpresa(FieldByName('CODEMP').AsString)
                                             .ConverterML(True)
                                           ).fGetQuantidade();

      Post;

      Next;
    End;
  End;

  BeforePost  := pBeforePost;
  AfterPost   := pAfterPost;
  AfterScroll := pAfterScroll;

  FieldByName('APERET').OnSetText := pSetText_APERET;
  FieldByName('APEENT').OnSetText := pSetText_APEENT;

  ReadOnly := blnReadOnly;
End;

Procedure TLojasCadIte.pPost;
  Var
    blnReadSav: Boolean;
Begin
  If State = dsEdit Then
  Begin
    blnReadSav := ReadOnly;

    ReadOnly := False;
    Post;

    ReadOnly := blnReadSav;
  End;
End;

Procedure TLojasCadIte.pBeforePost(dataSet: TDataSet);
Begin
  With dataSet Do
  Begin
    If fEmptyStr(FieldByName('EMPCEN').AsString) Then
      FieldByName('CPRCEN').AsString := 'N'
    Else
      FieldByName('CPRCEN').AsString := 'S';

    If FieldByName('MINDIG').IsNull Then
      FieldByName('MINDIG').AsFloat := 0;

    If FieldByName('MAXDIG').IsNull Then
      FieldByName('MAXDIG').AsFloat := 0;

    If blnMinDig And
      (FieldByName('MINDIG').AsFloat > 0) And
      (FieldByName('MAXDIG').AsFloat > 0) And
      (FieldByName('MAXDIG').AsFloat < FieldByName('MINDIG').AsFloat) Then
    Begin
      pMensagemOk('O estoque máximo (se maior que zero) não pode ser menor que o estoque mínimo!');
      Cancel;
    End;

  End;
End;

procedure TLojasCadIte.pCarregaPontoExposicao;
begin
  If Not blnUsaPontoDeExposicao Then
    Exit;

  SetLength(PontosExposicoes, RecordCount);
  First;
  While Not Eof Do
  Begin
    PontosExposicoes[RecNo -1].strCodEmp   := FieldByName('CODEMP').AsString;
    PontosExposicoes[RecNo -1].fltOldValue := FieldByName('PONEXP').AsFloat;
    Next;
  End;
  First;

end;

Procedure TLojasCadIte.pAfterPost(dataSet: TDataSet);
Begin

  If Not blnCprInd Then
  With dataSet Do
  Begin
    Self.AfterPost := Nil;

    pAlteraTodasAsLojas(FieldByName('CPRCEN').AsString,
                        FieldByName('EMPCEN').AsString);

    Self.AfterPost := pAfterPost;
  End;

End;

Procedure TLojasCadIte.pAlteraTodasAsLojas(strCprCen, strEmpCen: String);
  Var
    intRecNo: Integer;
    blnReadSav: Boolean;
Begin
  Try
    DisableControls;

    AfterScroll := Nil;

    blnReadSav := ReadOnly;

    ReadOnly := False;

    intRecNo := RecNo;

    First;
    While Not Eof Do
    Begin
      Edit;

      FieldByName('CPRCEN').AsString := strCprCen;

      If FieldByName('CPRCEN').AsString = 'S' Then
        FieldByName('EMPCEN').AsString := strEmpCen
      Else
        FieldByName('EMPCEN').Clear;

      Post;

      Next;
    End;

    RecNo := intRecNo;

    ReadOnly := blnReadSav;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TLojasCadIte.pAlteraTodasAsLojas]');
    End;
  End;

  AfterScroll := pAfterScroll;

  EnableControls;
End;

function TLojasCadIte.fPodeAlterar(DataSet: TDataSet; blnInfMat,blnEmpGer: Boolean ): Boolean;
Begin
  Result := False;
  If blnEmpGer Then
  Begin
    If blnInfMat Then
      Result := (dataSet.FieldByName('CODMAT').AsString = VS_strCodEmp) Or
                (dataSet.FieldByName('EMPMAT').AsString = VS_strCodEmp)
    Else
    Begin
      If VS_StrCodEmp <> dataSet.FieldByName('CODEMP').AsString Then
        Result  := Not (fCfgSis('INFMAT', varBoolean, dataSet.FieldByName('CODEMP').AsString))
      Else
        Result := True;
    End;
  End;
End;

Procedure TLojasCadIte.pAfterScroll(dataSet: TDataSet);
Begin
  With dataSet Do
  Begin
    If blnReadOnly Then
      ReadOnly := True
    Else
      ReadOnly := Not fPodeAlterar(DataSet, blnInfMat, blnEmpGer);

    If ReadOnly Then
      ReadOnly := (Not (blnInclusao And SameText(FieldByName('CODEMP').AsString, VS_strCodEmp)));

    If Not ReadOnly Then
    Begin
      FieldByName('SALBAL').ReadOnly := Not (blnInclusao And SameText(FieldByName('CODEMP').AsString, VS_strCodEmp));
      FieldByName('DTABAL').ReadOnly := Not (blnInclusao And SameText(FieldByName('CODEMP').AsString, VS_strCodEmp));
      FieldByName('ML_BAL').ReadOnly := Not (blnInclusao And SameText(FieldByName('CODEMP').AsString, VS_strCodEmp));
    End;

    If blnInclusao And (Not ReadOnly) then
    Begin
      FieldByName('ESTMIN').ReadOnly := Not (SameText(FieldByName('CODEMP').AsString, VS_strCodEmp));
      FieldByName('ESTMAX').ReadOnly := Not (SameText(FieldByName('CODEMP').AsString, VS_strCodEmp));
      FieldByName('SITPRO').ReadOnly := Not (SameText(FieldByName('CODEMP').AsString, VS_strCodEmp));
    End;
  End;

  If Assigned(FAfterScrollDo) Then
     FAfterScrollDo(FieldByName('CODEMP').AsString);
End;

procedure TLojasCadIte.pGeraLogPontoExposicao;
var
  PontoExposicao: TPontoExposicao;
begin
  If Not blnUsaPontoDeExposicao Then
    Exit;

  First;
  While not Eof Do
  Begin

    PontoExposicao := fLocalizaPontoExposicao(PontosExposicoes, FieldByName('CODEMP').AsString);

    If PontoExposicao.fltOldValue <> FieldByName('PONEXP').AsFloat Then
       pGravaLogPontoExposicao(qryCommand,
                               FieldByName('CODITE').AsString,
                               strLoginUsuarioLogado,
                               FieldByName('CODEMP').AsString,
                               PontoExposicao.fltOldValue,
                               FieldByName('PONEXP').AsFloat);
    Next;
  End;
end;

procedure TLojasCadIte.pAtualizaPontoExposicoes;
var
  PontoExposicao: TPontoExposicao;
begin
  If Not blnUsaPontoDeExposicao Then
    Exit;
  First;
  While not Eof Do
  Begin
    PontoExposicao := fLocalizaPontoExposicao(PontosExposicoes, FieldByName('CODEMP').AsString);
    If PontoExposicao.fltOldValue <> FieldByName('PONEXP').AsFloat Then
      pAtualizaPontoExposicao(nil,
                              FieldByName('CODITE').AsString,
                              strLoginUsuarioLogado,
                              FieldByName('CODEMP').AsString,
                              PontoExposicao.fltOldValue,
                              FieldByName('PONEXP').AsFloat);
    Next;
  End;

End;


procedure TLojasCadIte.pGravaInfoLojas(strForm: TForm; strCodIte: String);
var
  qrySald : TUniQuery;
  strSQL  : String;

  blnExecUpd,
  blnImpLis : Boolean;
  blnApeRet : Boolean;
  blnApeEnt : Boolean;
  blnEstMin : Boolean;
  blnMinPro : Boolean;
  PontoExposicao: TPontoExposicao;

begin

  blnImpLis := fCfgSisL('ILIEMP', varBoolean);
  blnApeRet := fCfgSis('APERET', varBoolean) And (fCfgSis('RETITE') = 'E');
  blnApeEnt := fCfgSis('APERET', varBoolean) And (fCfgSis('APNENT') = 'E');
  blnEstMin := Not fCfgSis('ESMILJ', varBoolean);
  blnMinPro := fCfgSis('MINPRO', varBoolean);

  qrySald    := fCriaQuery;

  pPost;
  First;
  While Not Eof Do
  Begin

    If (blnInfMat And (Not SameText(FieldByName('CODMAT').AsString, VS_strCodEmp))) Then
      If(SameText(FieldByName('EMPMAT').AsString, VS_strCodEmp)) Then
        blnExecUpd := True
      Else
        blnExecUpd := False
    Else
      blnExecUpd := True;

    If blnExecUpd Then
    Begin

      If TAltEst.fGravaLog(strForm,
                           strCodIte,
                           FieldByName('CODEMP').AsString,
                           FieldByName('ESTMIN').AsFloat,
                           FieldByName('ESTMAX').AsFloat) Then
      Begin
        strSQL     := '';
        strSQL := strSQL + ' UPDATE ';
        strSQL := strSQL + '  ITEGER SET ';

        If blnImpLis Then
          strSQL := strSQL + '   ITE_IMPLIS = :IMPLIS, ';

        If Self.blnPerVdaITEGER Then
          strSQL := strSQL + '   ITE_PEVNDA = :PEVNDA, ';

        If blnApeRet Then
          strSQL := strSQL + '   ITE_APERET = :APERET, ';

        If blnApeEnt Then
          strSQL := strSQL + '   ITE_APEENT = :APEENT, ';

        strSQL := strSQL + '   ITE_NIVCRI = :NIVCRI, ';

        strSQL := strSQL + '   ITE_ESTMAX = :ESTMAX, ';
        strSQL := strSQL + '   ITE_ESTMIN = :ESTMIN, ';

        strSQL := strSQL + '   ITE_MAXDIG = :MAXDIG, ';
        strSQL := strSQL + '   ITE_MINDIG = :MINDIG, ';
        strSQL := strSQL + '   ITE_PONPED = :PONPED, ';

        strSQL := strSQL + '   ITE_NIVGIR = :NIVGIR, ';
        strSQL := strSQL + '   ITE_CPRCEN = :CPRCEN, ';
        strSQL := strSQL + '   ITE_PONEXP = :PONEXP, ';
        strSQL := strSQL + '   ITE_EMPCEN = :EMPCEN ';

        If intSitPro = 2 Then
          strSQL := strSQL + ' ,ITE_SITPRO = :SITPRO ';

        If blnEstMin Then
          strSQL := strSQL + ' ,ITE_ESMIDG = :ESMIDG ';

         If blnMinPro Then
          strSQL := strSQL + ' ,ITE_TPESTM = :TPESTM ';


        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '  ITE_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '  ITE_CODITE = :CODITE ';

        qrySald.SQL.Text := strSQL;
        qrySald.ParamByName('ESTMAX').AsFloat  := FieldByName('ESTMAX').AsFloat;
        qrySald.ParamByName('ESTMIN').AsFloat  := FieldByName('ESTMIN').AsFloat;

        qrySald.ParamByName('MAXDIG').AsFloat  := FieldByName('MAXDIG').AsFloat;
        qrySald.ParamByName('MINDIG').AsFloat  := FieldByName('MINDIG').AsFloat;
        qrySald.ParamByName('PONPED').AsFloat  := FieldByName('PONPED').AsFloat;

        qrySald.ParamByName('PONEXP').AsFloat  := FieldByName('PONEXP').AsFloat;

        qrySald.ParamByName('NIVGIR').AsString := FieldByName('NIVGIR').AsString;
        qrySald.ParamByName('CODEMP').AsString := FieldByName('CODEMP').AsString;
        qrySald.ParamByName('NIVCRI').AsString := FieldByName('NIVCRI').AsString;

        qrySald.ParamByName('CODITE').AsString := strCodIte;

        If blnImpLis Then
          qrySald.ParamByName('IMPLIS').AsString := FieldByName('IMPLIS').AsString;

        If Self.blnPerVdaITEGER Then
          qrySald.ParamByName('PEVNDA').AsString := FieldByName('PEVNDA').AsString;

        If blnApeRet Then
          qrySald.ParamByName('APERET').AsString := FieldByName('APERET').AsString;

        If blnApeEnt Then
          qrySald.ParamByName('APEENT').AsString := FieldByName('APEENT').AsString;

        If fEmptyStr(FieldByName('EMPCEN').AsString) Then
        Begin
          qrySald.ParamByName('CPRCEN').AsString := 'N';
          qrySald.ParamByName('EMPCEN').Clear;
        End Else
        Begin
          qrySald.ParamByName('CPRCEN').AsString := 'S';
          qrySald.ParamByName('EMPCEN').AsString := FieldByName('EMPCEN').AsString;
        End;

        If intSitPro = 2 Then
        Begin
          If fEmptyStr(FieldByName('SITPRO').AsString) Then
            qrySald.ParamByName('SITPRO').Clear
          Else
            qrySald.ParamByName('SITPRO').AsString := FieldByName('SITPRO').AsString;
        End;

        If blnEstMin Then
          qrySald.ParamByName('ESMIDG').AsString := FieldByName('ESMIDG').AsString;

        If blnMinPro Then
          qrySald.ParamByName('TPESTM').AsString := FieldByName('TPESTM').AsString;

        qrySald.ExecSQL;

      End;

    End
    Else
    begin
      If blnUsaPontoDeExposicao Then
      begin
        PontoExposicao := fLocalizaPontoExposicao(PontosExposicoes, FieldByName('CODEMP').AsString);
        If PontoExposicao.fltOldValue <> FieldByName('PONEXP').AsFloat Then
          pAtualizaPontoExposicao(nil,
                                  FieldByName('CODITE').AsString,
                                  strLoginUsuarioLogado,
                                  FieldByName('CODEMP').AsString,
                                  PontoExposicao.fltOldValue,
                                  FieldByName('PONEXP').AsFloat,
                                  False);
      End;
    End;
    Next;
  End;

  FreeAndNil(qrySald);
end;

Procedure TLojasCadIte.pSetDadosInclusaoIgualParaTodasAsEmpresas(strCodEmp: String; qryIteger: TUniQuery);
Begin
  pPost;

  If Locate('CODEMP', strCodEmp, []) And (qryIteGer.State In dsEditModes) Then
  Begin
    qryIteGer.FieldByName('ITE_SALBAL').Value := FieldByName('SALBAL').Value;
    qryIteGer.FieldByName('ITE_ML_BAL').Value := FieldByName('ML_BAL').Value;
    qryIteGer.FieldByName('ITE_DTABAL').Value := FieldByName('DTABAL').Value;
    qryIteGer.FieldByName('ITE_SITPRO').Value := FieldByName('SITPRO').Value;
    qryIteGer.FieldByName('ITE_ESTMIN').Value := FieldByName('ESTMIN').Value;
    qryIteGer.FieldByName('ITE_ESTMAX').Value := FieldByName('ESTMAX').Value;
    qryIteGer.FieldByName('ITE_SALDOS').Value := FieldByName('SALBAL').Value;
    qryIteGer.FieldByName('ITE_SAL_ML').Value := FieldByName('ML_BAL').Value;
    qryIteGer.FieldByName('ITE_PEVNDA').Value := FieldByName('PEVNDA').Value;
  End;

End;

Procedure TLojasCadIte.pSetDadosInclusaoIndividual(qryIteger: TUniQuery);
Begin
  pPost;

  If Locate('CODEMP', qryIteGer.FieldByName('ITE_CODEMP').AsString , []) And (qryIteGer.State In dsEditModes) Then
  Begin
    If Not FieldByName('NIVGIR').IsNull Then
      qryIteGer.FieldByName('ITE_NIVGIR').Value := FieldByName('NIVGIR').Value;

    If Not FieldByName('NIVCRI').IsNull Then
      qryIteGer.FieldByName('ITE_NIVCRI').Value := FieldByName('NIVCRI').Value;

    If Not FieldByName('MINDIG').IsNull Then
      qryIteGer.FieldByName('ITE_MINDIG').Value := FieldByName('MINDIG').Value;

    If Not FieldByName('MAXDIG').IsNull Then
      qryIteGer.FieldByName('ITE_MAXDIG').Value := FieldByName('MAXDIG').Value;

    If Not FieldByName('IMPLIS').IsNull Then
      qryIteGer.FieldByName('ITE_IMPLIS').Value := FieldByName('IMPLIS').Value;

    If Not FieldByName('APERET').IsNull Then
      qryIteGer.FieldByName('ITE_APERET').Value := FieldByName('APERET').Value;

    If Not FieldByName('APEENT').IsNull Then
      qryIteGer.FieldByName('ITE_APEENT').Value := FieldByName('APEENT').Value;

    If Not FieldByName('PONPED').IsNull Then
      qryIteGer.FieldByName('ITE_PONPED').Value := FieldByName('PONPED').Value;

    If Not FieldByName('CPRCEN').IsNull Then
      qryIteGer.FieldByName('ITE_CPRCEN').Value := FieldByName('CPRCEN').Value;

    If Not FieldByName('EMPCEN').IsNull Then
      qryIteGer.FieldByName('ITE_EMPCEN').Value := FieldByName('EMPCEN').Value;

    If Not FieldByName('PEVNDA').IsNull Then
      qryIteGer.FieldByName('ITE_PEVNDA').Value := FieldByName('PEVNDA').Value;
  End;

End;

procedure TLojasCadIte.pSetText_APERET(Sender: TField; const Text: string);
begin
  If (Text = 'S') Then
  Begin
    FieldByName('APERET').AsString := 'S';
    FieldByName('APEENT').AsString := 'N';
  End;
end;

procedure TLojasCadIte.pSetText_APEENT(Sender: TField; const Text: string);
begin
  If (Text = 'S') Then
  Begin
    FieldByName('APEENT').AsString := 'S';
    FieldByName('APERET').AsString := 'N';
  End;
end;

Procedure TLojasCadIte.pIniciaDadosInclusao(strCodEmp: String);
  Var
    blnSavReadOnly: Boolean;
Begin
  pPost;

  If Locate('CODEMP', strCodEmp, []) Then
  Begin
    blnSavReadOnly := ReadOnly;

    ReadOnly := False;
    Edit;
    FieldByName('DTABAL').Value := VS_Date - 1;
    FieldByName('SALBAL').Value := 0;
    FieldByName('ML_BAL').Value := 0;
    FieldByName('SALDOS').Value := 0;
    Post;

    ReadOnly := blnSavReadOnly;
  End;

End;

Procedure TLojasCadIte.pHabilitaLojas(blnHabilita: Boolean);
Begin
  blnReadOnly := Not blnHabilita;
  pAfterScroll(Self);
End;

(*
Function TLojasCadIte.fValidaEmpresas: Boolean;
Begin
  Result := True;

  If (Not fCfgSis('CPRIND', varBoolean)) And
     Locate('CPRCEN', 'S', []) And
     Locate('CPRCEN', 'N', []) Then
  Begin
    pMensagemOk('A configuração "[CFG_CPRIND] Compra centralizada individual para cada loja?" está "Não".' + #13#10 +
                'Portanto se uma loja tem compra centralizada, todas devem ter um empresa centralizadora!');

    Result := False;
  End;

End;
*)

end.
