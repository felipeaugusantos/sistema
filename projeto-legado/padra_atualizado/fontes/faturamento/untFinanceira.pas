unit untFinanceira;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Forms, UniClientDataSet, ComCtrls, Controls,
{$ENDIF}
  DB, Uni, SysUtils, Classes,  Math,
  untTypesSistema, untIFinanceira;

Type
  TValGer = Record
    strCodFin: String;
    fltValFin: Double;
    fltValAdt: Double;
  End;

  TArrayValFin = array of TValGer;

Type
  TFinanceira = Class(TComponent, IFinanceira)
  private
    //Utilizado como backup das informacoes
    FMovTmp: TUniClientDataSet;
    FArrTmp: TCartoesFinanceira;

    FArrVal: TArrayValFin;

    FMovFin: TUniClientDataSet;
    FArrCar: TCartoesFinanceira;

    Function fCalulaTaxaRetorno(fltValFin, fltTaxRet: Double): Double;
    Function fTabMovToTabFin(strNomTab: String): String;
    Function fTotalCartao(arrCartao: TCartoesResumoCaixaArray): Double;

    Procedure pCriaClient;
    Procedure pCopiaArrCartoesFin(arrOriCar: TCartoesFinanceira; Var arrDesCar: TCartoesFinanceira);
    Procedure pCopiaArrCartoes(arrCarOri: TCartoesResumoCaixaArray;
                               Var arrCarDes: TCartoesResumoCaixaArray);

    function GetFMovFin: TUniClientDataSet;
    procedure SetFMovFin(Value: TUniClientDataSet);
    function fRetIndiceFinanceira(strCodFin: String): Integer;

    function  fRetValorDesmembrado(strCodFin: String): Double;
    function  fRetValorOriginal(strCodFin: String): Double;

  Public
    property cdsMovFin: TUniClientDataSet Read GetFMovFin Write SetFMovFin;

    Function fRetValFin: Double;
    Function fRetValFinPorFinanceira(strCodFin: String): Double;
    Function fRetTotalOperacao: Double;
    Function fRetTotalFinanciado: Double;
    Function fRetTotalAdiantado: Double;
    Function fRetDespesasAcessorias: Double;
    Function fRetCartaoFinanceira(strCodFin: String; intQtdPar: Integer): String;
    Function fValidaCartoes(arrDesCar: TCartoesFinanceira; cdsSelFin: TUniClientDataSet): Boolean;
    Function fRetArrCartoes(strCodFin: String; Var arrCarFin: TCartoesFinanceira): TCartoesResumoCaixaArray;
    Function fRetArrCartaoFinanc(strCodFin: String): TCartoesResumoCaixaArray;
    Function fRecalculaFinanceira(fltTotFin: Double): Boolean;
    Function fValorRestante(cdsSelFin: TUniClientDataSet; fltTotFin: Double): Double;
    Function fRetIndiceFin(strCodFin: String; intQtdPar: Integer): Double;
    Function fValorParcela(fltTotFin, fltTaxRet, fltTaxCad, fltIndFin, fltTaxBol: Double; intQtdParc: Integer): Double;
    Function fValorOperacao(fltParFin: Double; intQtdPar: Integer): Double;
    Function fParcelasFinanc(qryCadFin: TUniQuery; strCodFin: String): String;
    Function fRetTaxasFin(strCodFin: String; intQtdFin: Integer;
               Var fltTaxRet, fltTaxCad, fltIndFin, fltTaxBol: Double;
               Var strCliFin, strCodCar, strTipRet, strDesAce: String; Var intDiaFin: Integer): Boolean;
    Function fGravaFinanciamento(strNomTab, strAutInc: String): Boolean;
    Function fValidaCartao(fltValFin: Double; arrCartao: TCartoesResumoCaixaArray): Boolean;

    Procedure pCarregaFinanciamento(strNomTab, strSeqGer: String);
    Procedure pAtualizaClient(fltFator: Double = 1);

    //Procedure pMostraDadosPedido(strSeqGer: String);

    Procedure pCarregaDados(Var arrDesCar: TCartoesFinanceira; cdsSelFin: TUniClientDataSet);
    Procedure pSalvaDados(arrDesCar: TCartoesFinanceira; cdsSelFin: TUniClientDataSet);

    Procedure pRegistraItem(cdsSelFin: TUniClientDataSet;
                            strCodFin,
                            strCodCar,
                            strTipRet,
                            strDesAce: String;
                            fltValFin: Double;
                            intQtdPar: Integer;
                            fltValOpe,
                            fltValPar: Double;
                            strCliFin: String;
                            intDiaFin: Integer;
                            fltValAdt: Double);

    Procedure pCopiaArrCartoesDig(strCodFin: String;
                                  arrCarOri: TCartoesResumoCaixaArray;
                                  Var arrDesCar: TCartoesFinanceira);

    procedure pDeleteCartoesNaoEncontrados(Var arrDesCar: TCartoesFinanceira; cdsSelFin: TUniClientDataSet);

    Procedure pCopiaSeguranca;
    Procedure pRestaurarCopiaSeguranca;

    Procedure pSalvaCartoes(var arrCartoes: TCartoesResumoCaixaArray);

    Procedure pLimpaDados;
    procedure pAtualizaDiferencaDesmembramento;
    procedure pAtualizaDiferencaDocumento(fltDifere: Double);

    procedure pSalvaValoresDesmembrados;
    procedure pLimpaValoresDesmembrados;

    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; Reintroduce;

  End;

implementation

uses
{$IFDEF LINUX}

{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  StrUtils;

Constructor TFinanceira.Create(AOwner: TComponent);
Begin
  Inherited Create(AOwner);

  SetLength(FArrCar, 0);
  SetLength(FArrTmp, 0);
  SetLength(FArrVal, 0);
  pCriaClient;
End;

Destructor TFinanceira.Destroy;
Begin
  pLimpaDados;
  FreeAndNil(FMovFin);
  FreeAndNil(FMovTmp);
End;

Procedure TFinanceira.pCriaClient;
Begin
  FMovFin := TUniClientDataSet.Create(Self);

  With FMovFin, FieldDefs Do
  Begin
    AggregatesActive := True;

    With AddFieldDef Do Begin Name := 'FIN_CODFIN'; DataType := ftString; Size := 5; Required := False; End;
    With AddFieldDef Do Begin Name := 'FIN_VALFIN'; DataType := ftFloat;             Required := False; End;
    With AddFieldDef Do Begin Name := 'FIN_VALADT'; DataType := ftFloat;             Required := False; End;
    With AddFieldDef Do Begin Name := 'FIN_QTDPAR'; DataType := ftInteger;           Required := False; End;

    With AddFieldDef Do Begin Name := 'FIN_VALPAR'; DataType := ftFloat;             Required := False; End;

    With AddFieldDef Do Begin Name := 'FIN_VALOPE'; DataType := ftFloat;             Required := False; End;
    With AddFieldDef Do Begin Name := 'FIN_VALTAX'; DataType := ftFloat;             Required := False; End;

    With AddFieldDef Do Begin Name := 'FIN_DESACE'; DataType := ftString; Size := 1; Required := False; End;

    With AddFieldDef Do Begin Name := 'FIN_DIAFIN'; DataType := ftInteger;           Required := False; End;
    With AddFieldDef Do Begin Name := 'FIN_CLIFIN'; DataType := ftString; Size := 8; Required := False; End;
    With AddFieldDef Do Begin Name := 'FIN_TIPRET'; DataType := ftString; Size := 1; Required := False; End;
    With AddFieldDef Do Begin Name := 'FIN_DIGCAR'; DataType := ftString; Size := 1; Required := False; End;
    With AddFieldDef Do Begin Name := 'FIN_CODCAR'; DataType := ftString; Size := 5; Required := False; End;

    With TAggregateField.Create(Self) Do
    Begin
      FieldName := 'FIN_TOTFIN'; DataSet := FMovFin; DisplayFormat := '#,##0.00';
      Expression := 'SUM(FIN_VALFIN)'; Active := True;
    End;

    With TAggregateField.Create(Self) Do
    Begin
      FieldName := 'FIN_TOTADT'; DataSet := FMovFin; DisplayFormat := '#,##0.00';
      Expression := 'SUM(FIN_VALADT)'; Active := True;
    End;

    With TAggregateField.Create(Self) Do
    Begin
      FieldName := 'FIN_TOTOPE'; DataSet := FMovFin; DisplayFormat := '#,##0.00';
      Expression := 'SUM(FIN_VALOPE)'; Active := True;
    End;

    CreateDataSet;
    OPen;
  End;

  FMovTmp := TUniClientDataSet.Create(Self);
  pCloneDataSet(FMovTmp, FMovFin);
End;

Function TFinanceira.fRetIndiceFin(strCodFin: String; intQtdPar: Integer): Double;
  Var
    qryIndFin: TUniQuery;
Begin
  qryIndFin := fCriaQuery(Nil);
  With qryIndFin, SQL Do
  Begin
    Clear;
    Add('SELECT IND_INDFIN');
    Add('FROM INDFIN');
    Add('WHERE');
    Add('  IND_CODFIN = :CODFIN AND ');
    Add('  IND_QTDPAR = :QTDPAR     ');

    ParamByName('CODFIN').AsString  := strCodFin;
    ParamByName('QTDPAR').AsInteger := intQtdPar;

    Open;

    If IsEmpty Then
      Result := 0
    Else
      Result := FieldByName('IND_INDFIN').AsFloat;
  End;

  FreeAndNil(qryIndFin);
End;

Function TFinanceira.fValorParcela(fltTotFin, fltTaxRet, fltTaxCad, fltIndFin, fltTaxBol: Double; intQtdParc: Integer): Double;
Begin
  Result := RoundTo(((fltTotFin * (1 + (fltTaxRet/100))) +  fltTaxCad) * fltIndFin + fltTaxBol, -2);

  If (intQtdParc <> 0) Then
    Result := RoundTo(Result / intQtdParc, -2);
End;

Function TFinanceira.fValorOperacao(fltParFin: Double; intQtdPar: Integer): Double;
Begin
  Result := fltParFin * intQtdPar;
End;

Function TFinanceira.fParcelasFinanc(qryCadFin: TUniQuery; strCodFin: String): String;
Begin
  With qryCadFin, SQL Do
  Begin
    Clear;
    Add('SELECT CADFIN.*, GROUP_CONCAT(IND_QTDPAR SEPARATOR ",") AS QTDPAR');
    Add('FROM CADFIN');
    Add('INNER JOIN INDFIN ON FIN_CODIGO = IND_CODFIN ');
    Add('WHERE');
    Add('  IND_CODFIN = ' + QuotedStr(strCodFin));
    Add('GROUP BY IND_CODFIN');

    Open;

    Result := FieldByName('QTDPAR').AsString;
  End;

End;

Function TFinanceira.fRetTaxasFin(strCodFin: String; intQtdFin: Integer;
  Var fltTaxRet, fltTaxCad, fltIndFin, fltTaxBol: Double;
  Var strCliFin, strCodCar, strTipRet, strDesAce: String; Var intDiaFin: Integer): Boolean;
  Var
    qryCadFin: TUniQuery;
Begin
  qryCadFin := fCriaQuery;

  With qryCadFin, SQL Do
  Begin
    Clear;
    Add('SELECT * ');
    Add('FROM CADFIN');
    Add('INNER JOIN INDFIN ON FIN_CODIGO = IND_CODFIN ');
    Add('WHERE');
    Add('  IND_CODFIN = :CODFIN AND ');
    Add('  IND_QTDPAR = :QTDPAR     ');

    ParamByName('CODFIN').AsString  := strCodFin;
    ParamByName('QTDPAR').AsInteger := intQtdFin;

    Open;

    Result := Not IsEmpty;

    If Result Then
    Begin
      fltTaxRet := FieldByName('FIN_TAXRET').AsFloat;
      fltTaxCad := FieldByName('FIN_TAXCAD').AsFloat;
      fltTaxBol := FieldByName('FIN_TAXBOL').AsFloat;
      intDiaFin := FieldByName('FIN_DIAREC').AsInteger;
      strCliFin := FieldByName('FIN_CODCLI').AsString;
      strTipRet := FieldByName('FIN_TIPRET').AsString;
      strDesAce := FieldByName('FIN_DESACE').AsString;

      fltIndFin := FieldByName('IND_INDFIN').AsFloat;
      strCodCar := FieldByName('IND_CODCAR').AsString;
    End Else
    Begin
      fltTaxRet := 0;
      fltTaxCad := 0;
      fltIndFin := 0;
      fltTaxBol := 0;
      intDiaFin := 0;
      strCliFin := '';
      strTipRet := '';
    End;

    Close;
  End;

  FreeAndNil(qryCadFin);
End;

Procedure TFinanceira.pAtualizaClient(fltFator: Double = 1);
  Var
    fltTaxRet, fltTaxCad, fltIndFin, fltTaxBol: Double;
    strCliFin, strCodCar, strTipRet, strDesAce: String;
    intDiaFin: Integer;
Begin
  With FMovFin Do
  Begin
    DisableControls;
    First;

    While Not Eof Do
    Begin

      If fRetTaxasFin(FieldByName('FIN_CODFIN').AsString,
                      FieldByName('FIN_QTDPAR').AsInteger,
                      fltTaxRet, fltTaxCad, fltIndFin, fltTaxBol,
                      strCliFin, strCodCar, strTipRet, strDesAce, intDiaFin) Then
      Begin
        Edit;

        FieldByName('FIN_CODCAR').AsString  := strCodCar;
        FieldByName('FIN_TIPRET').AsString  := strTipRet;
        FieldByName('FIN_DESACE').AsString  := strDesAce;

        FieldByName('FIN_DIGCAR').AsString  := IfThen(strTipRet = 'P', 'S', 'N');
        FieldByName('FIN_CLIFIN').AsString  := strCliFin;
        FieldByName('FIN_DIAFIN').AsInteger := intDiaFin;

        FieldByName('FIN_VALFIN').AsFloat   := fFormataFloat(FieldByName('FIN_VALFIN').AsFloat * fltFator, 2);

        FieldByName('FIN_VALPAR').AsFloat :=
          fValorParcela(FieldByName('FIN_VALFIN').AsFloat, fltTaxRet, fltTaxCad, fltIndFin, fltTaxBol, FieldByName('FIN_QTDPAR').AsInteger);

        FieldByName('FIN_VALOPE').AsFloat := fValorOperacao(FieldByName('FIN_VALPAR').AsFloat,
                                               FieldByName('FIN_QTDPAR').AsInteger);

        FieldByName('FIN_VALTAX').AsFloat := fCalulaTaxaRetorno(FieldByName('FIN_VALFIN').AsFloat, fltTaxRet);

        Post;
      End;

      Next;
    End;

    EnableControls;
  End;
End;

Procedure TFinanceira.pRegistraItem(cdsSelFin: TUniClientDataSet;
                                    strCodFin,
                                    strCodCar,
                                    strTipRet,
                                    strDesAce: String;
                                    fltValFin: Double;
                                    intQtdPar: Integer;
                                    fltValOpe,
                                    fltValPar: Double;
                                    strCliFin: String;
                                    intDiaFin: Integer;
                                    fltValAdt: Double);
Begin
  With cdsSelFin Do
  Begin
    If Locate('FIN_CODFIN', strCodFin, []) Then
      Edit
    Else
      Insert;

    FieldByName('FIN_CODFIN').AsString  := strCodFin;
    FieldByName('FIN_VALFIN').AsFloat   := fltValFin;
    FieldByName('FIN_VALADT').AsFloat   := fltValAdt;
    FieldByName('FIN_QTDPAR').AsInteger := intQtdPar;
    FieldByName('FIN_VALOPE').AsFloat   := fltValOpe;
    FieldByName('FIN_VALPAR').AsFloat   := fltValPar;
    FieldByName('FIN_CLIFIN').AsString  := strCliFin;
    FieldByName('FIN_CODCAR').AsString  := strCodCar;
    FieldByName('FIN_TIPRET').AsString  := strTipRet;
    FieldByName('FIN_DESACE').AsString  := strDesAce;
    FieldByName('FIN_DIGCAR').AsString  := IfThen(strTipRet = 'P', 'S', 'N');
    FieldByName('FIN_DIAFIN').AsInteger := intDiaFin;

    Post;
  End;

End;

procedure TFinanceira.pRestaurarCopiaSeguranca;
begin
  pSalvaDados(FArrTmp, FMovTmp);
end;

Function TFinanceira.fValorRestante(cdsSelFin: TUniClientDataSet; fltTotFin: Double): Double;
Begin
  Result := RoundTo(fltTotFin - (fDoubleAggregate(cdsSelFin, 'FIN_TOTFIN') + fDoubleAggregate(cdsSelFin, 'FIN_TOTADT')), -2);
End;

function TFinanceira.GetFMovFin: TUniClientDataSet;
begin
  Result := FMovFin;
end;

Function TFinanceira.fRecalculaFinanceira(fltTotFin: Double): Boolean;
Begin
  With FMovFin Do
  Begin

    If RecordCount = 1 Then
    Begin
      Edit;
      FieldByName('FIN_VALFIN').AsFloat := fltTotFin;
      Post;
    End;

    If fValorRestante(FMovFin, fltTotFin) <> 0 Then
    Begin
      pMensagemOk('Valor total a ser financiado diferente do cadastrado!');
      Result := False;
    End Else
    Begin
      pAtualizaClient;
      Result := True;
    End;
  End;
End;

Function TFinanceira.fTabMovToTabFin(strNomTab: String): String;
Begin
  If (SameText(strNomTab, 'FATGOR')) or (SameText(strNomTab, 'DEL_FATGOR')) Then
    Result := 'FATFIN'

  Else If (SameText(strNomTab, 'MOVGER')) or (SameText(strNomTab, 'DEL_MOVGER'))Then
    Result := 'MOVFIN'

  Else If (SameText(strNomTab, 'NOTGER')) or (SameText(strNomTab, 'DEL_NOTGER')) Then
  Begin
    fInsereProCod('NOTFIN');
    Result := 'NOTFIN';
  End

  Else
    Result := '';
End;

Function TFinanceira.fGravaFinanciamento(strNomTab, strAutInc: String): Boolean;
  Var
    qryMovFin: TUniQuery;
    strTabFin: String;
Begin
  strTabFin := fTabMovToTabFin(strNomTab);

  qryMovFin := fCriaQuery;
  With qryMovFin, SQL Do
  Begin
    Clear;
    Add('DELETE FROM');
    Add(strTabFin);
    Add('WHERE ');
    Add('  FIN_SEQGER = :SEQGER');
    ParamByName('SEQGER').AsString := strAutInc;
    ExecSQL;
    Close;

    Clear;
    Add('SELECT * FROM');
    Add(strTabFin);
    Add('WHERE FALSE');
    Open;

    FMovFin.First;
    While Not FMovFin.Eof Do
    Begin

      qryMovFin.Insert;

      FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem(strTabFin, VS_strCodEmp);
      FieldByName('FIN_SEQGER').AsString  := strAutInc;
      FieldByName('FIN_VALFIN').AsFloat   := FMovFin.FieldByName('FIN_VALFIN').AsFloat;
      FieldByName('FIN_VALADT').AsFloat   := FMovFin.FieldByName('FIN_VALADT').AsFloat;
      FieldByName('FIN_CODIGO').AsString  := FMovFin.FieldByName('FIN_CODFIN').AsString;
      FieldByName('FIN_QTDPAR').AsInteger := FMovFin.FieldByName('FIN_QTDPAR').AsInteger;

      Post;

      FMovFin.Next;
    End;

    Close;
  End;
  FreeAndNil(qryMovFin);

  Result := True;
End;

Procedure TFinanceira.pCarregaFinanciamento(strNomTab, strSeqGer: String);
  Var
    qryMovFin: TUniQuery;
    strTabFin: String;
Begin
  strTabFin := fTabMovToTabFin(strNomTab);

  If (fEmptyStr(strTabFin)) Then
    Exit;

  Try
    qryMovFin := fCriaQuery;

    With qryMovFin, SQL Do Begin

      Add('SELECT M.*, C.* ');
      Add('FROM');
      Add(strTabFin + ' M');
      Add('INNER JOIN CADFIN C ON C.FIN_CODIGO = M.FIN_CODIGO');
      Add('WHERE');
      Add('  FIN_SEQGER = :SEQGER');

      ParamByName('SEQGER').AsString := strSeqGer;

      Open;

      While Not Eof Do Begin

        FMovFin.Insert;
        FMovFin.FieldByName('FIN_VALFIN').AsFloat   := FieldByName('FIN_VALFIN').AsFloat;
        FMovFin.FieldByName('FIN_VALADT').AsFloat   := FieldByName('FIN_VALADT').AsFloat;
        FMovFin.FieldByName('FIN_CODFIN').AsString  := FieldByName('FIN_CODIGO').AsString;
        FMovFin.FieldByName('FIN_TIPRET').AsString  := FieldByName('FIN_TIPRET').AsString;
        FMovFin.FieldByName('FIN_DESACE').AsString  := FieldByName('FIN_DESACE').AsString;
        FMovFin.FieldByName('FIN_QTDPAR').AsInteger := FieldByName('FIN_QTDPAR').AsInteger;
        FMovFin.Post;

        Next;
      End;

      Close;

      pAtualizaClient;
    End;
  Finally
    FreeAndNil(qryMovFin);
  End;
End;

Function TFinanceira.fRetArrCartoes(strCodFin: String; Var arrCarFin: TCartoesFinanceira): TCartoesResumoCaixaArray;
  Var
    intIndice: Integer;
Begin
  For intIndice := Low(arrCarFin) To High(arrCarFin) Do
  If arrCarFin[intIndice].strCodFin = strCodFin Then
  Begin
    Result := arrCarFin[intIndice].arrCartao;
    Exit;
  End;

  Setlength(arrCarFin, Succ(Length(arrCarFin)));
  arrCarFin[High(arrCarFin)].strCodFin := strCodFin;
  Setlength(arrCarFin[High(arrCarFin)].arrCartao, 0);
  Result := arrCarFin[High(arrCarFin)].arrCartao;
End;

Function TFinanceira.fRetArrCartaoFinanc(strCodFin: String): TCartoesResumoCaixaArray;
Begin
  Result := fRetArrCartoes(strCodFin, FArrCar);
End;

Procedure TFinanceira.pCopiaArrCartoesFin(arrOriCar: TCartoesFinanceira; Var arrDesCar: TCartoesFinanceira);
  Var
    intIndice: Integer;
Begin
  For intIndice := Low(arrDesCar) To High(arrDesCar) Do
    Setlength(arrDesCar[intIndice].arrCartao, 0);

  Setlength(arrDesCar, Length(arrOriCar));
  For intIndice := Low(arrOriCar) To High(arrOriCar) Do
  Begin
    arrDesCar[intIndice].strCodFin := arrOriCar[intIndice].strCodFin;
    pCopiaArrCartoes(arrOriCar[intIndice].arrCartao , arrDesCar[intIndice].arrCartao);
  End;

End;

Procedure TFinanceira.pCopiaArrCartoes(arrCarOri: TCartoesResumoCaixaArray;
                                       Var arrCarDes: TCartoesResumoCaixaArray);
  Var
    intIndice: Integer;
Begin
  Setlength(arrCarDes, Length(arrCarOri));

  For intIndice := Low(arrCarOri) To High(arrCarOri) Do
    arrCarDes[intIndice] := arrCarOri[intIndice];
End;

Procedure TFinanceira.pCopiaArrCartoesDig(strCodFin: String;
                                          arrCarOri: TCartoesResumoCaixaArray;
                                          Var arrDesCar: TCartoesFinanceira);
  Var
    intIndice: Integer;
Begin
  For intIndice := Low(arrDesCar) To High(arrDesCar) Do
  If arrDesCar[intIndice].strCodFin = strCodFin Then
  Begin
    pCopiaArrCartoes(arrCarOri, arrDesCar[intIndice].arrCartao);
    Exit;
  End;
End;

Procedure TFinanceira.pCarregaDados(Var arrDesCar: TCartoesFinanceira; cdsSelFin: TUniClientDataSet);
Begin
  pAtualizaClient;
  pCloneDataSet(cdsSelFin, FMovFin);
  pCopiaArrCartoesFin(FArrCar, arrDesCar);

  With cdsSelFin Do
  Begin
    TFloatField(FieldByName('FIN_VALFIN')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIN_VALADT')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIN_VALOPE')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIN_VALPAR')).DisplayFormat := '#,##0.00';
    FieldByName('FIN_DIGCAR').Alignment := taCenter;
  End;
End;

Procedure TFinanceira.pSalvaDados(arrDesCar: TCartoesFinanceira; cdsSelFin: TUniClientDataSet);
Begin
  pCloneDataSet(FMovFin, cdsSelFin);
  pDeleteCartoesNaoEncontrados(arrDesCar, cdsSelFin);
  pCopiaArrCartoesFin(arrDesCar, FArrCar);
End;

procedure TFinanceira.pSalvaValoresDesmembrados;
Var
  intIndice: Integer;
begin

  With FMovFin Do
  Begin
    First;

    While Not Eof Do
    Begin
      intIndice := fRetIndiceFinanceira(FieldByName('FIN_CODFIN').AsString);

      If (intIndice = -1) Then
      Begin
        intIndice := Length(FArrVal);

        SetLength(FArrVal, intIndice + 1);
        FArrVal[intIndice].strCodFin := FieldByName('FIN_CODFIN').AsString;
        FArrVal[intIndice].fltValFin := FieldByName('FIN_VALFIN').AsFloat;
        FArrVal[intIndice].fltValAdt := FieldByName('FIN_VALADT').AsFloat;
      End
      Else
      Begin
        FArrVal[intIndice].fltValFin := FArrVal[intIndice].fltValFin + FieldByName('FIN_VALFIN').AsFloat;
        FArrVal[intIndice].fltValAdt := FArrVal[intIndice].fltValAdt + FieldByName('FIN_VALADT').AsFloat;
      End;

      Next;
    End;

  End;

end;

procedure TFinanceira.SetFMovFin(Value: TUniClientDataSet);
begin
  FMovFin := Value;
end;

procedure TFinanceira.pCopiaSeguranca;
begin
  pCarregaDados(FArrTmp, FMovTmp);
end;

procedure TFinanceira.pDeleteCartoesNaoEncontrados(Var arrDesCar: TCartoesFinanceira; cdsSelFin: TUniClientDataSet);
  Var
    intIndice: Integer;
Begin
  For intIndice := Low(arrDesCar) To High(arrDesCar) Do
  With arrDesCar[intIndice] Do
  If Not cdsSelFin.Locate('FIN_CODFIN', strCodFin, []) Then
  Begin
    strCodFin := '';
    SetLength(arrCartao, 0);
  End;
End;

Function TFinanceira.fTotalCartao(arrCartao: TCartoesResumoCaixaArray): Double;
  Var
    intIndice: Integer;
Begin
  Result := 0;
  For intIndice := Low(arrCartao) To High(arrCartao) Do
    Result := Result + arrCartao[intIndice].fltValDig;
End;

Function TFinanceira.fValidaCartao(fltValFin: Double; arrCartao: TCartoesResumoCaixaArray): Boolean;
Begin
  If RoundTo(fltValFin, -2) <> RoundTo(fTotalCartao(arrCartao), -2) Then
  Begin
    pMensagemOk('Total do Cartão dever ser igual a ' + FormatFloat('#0.00', fltValFin));
    Result := False;
  End

  Else Result := True;
End;

Function TFinanceira.fValidaCartoes(arrDesCar: TCartoesFinanceira; cdsSelFin: TUniClientDataSet): Boolean;
Begin
  Result := True;
  With cdsSelFin Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      If FieldByName('FIN_TIPRET').AsString = 'P' Then
        Result := fValidaCartao(IfThen(FieldByName('FIN_DESACE').AsString = 'S',
                                    FieldByName('FIN_VALOPE').AsFloat,
                                    FieldByName('FIN_VALFIN').AsFloat),
                    fRetArrCartoes(FieldByName('FIN_CODFIN').AsString, arrDesCar));

      If Not Result Then
        Break;
      Next;
    End;

    EnableControls;
  End;
End;

Procedure TFinanceira.pLimpaDados;
  Var
    arrOriCar: TCartoesFinanceira;
Begin
  FMovFin.EmptyDataSet;

  SetLength(arrOriCar, 0);
  pCopiaArrCartoesFin(arrOriCar, FArrCar);
End;

procedure TFinanceira.pLimpaValoresDesmembrados;
begin
  SetLength(FArrVal, 0);
end;

procedure TFinanceira.pAtualizaDiferencaDesmembramento;
Var
  fltValDes: Double;
  fltValOri: Double;
  fltDifere: Double;
begin

  With FMovFin Do
  Begin
    First;

    While Not Eof Do
    Begin
      fltValDes := fFormataFloat(fRetValorDesmembrado(FieldByName('FIN_CODFIN').AsString), 2);
      fltValOri := fFormataFloat(fRetValorOriginal(FieldByName('FIN_CODFIN').AsString), 2);
      fltDifere := fFormataFloat(fFormataFloat(fltValOri, 2) - fFormataFloat(fltValDes, 2), 2);

      If (fltDifere <> 0) And ((FieldByName('FIN_VALFIN').AsFloat + fltDifere) <> 0) Then
      Begin
        Edit;
        FieldByName('FIN_VALFIN').AsFloat := FieldByName('FIN_VALFIN').AsFloat + fltDifere;
        Post;
      End;

      Next;
    End;

    First;

    pAtualizaClient;
  End;

end;

procedure TFinanceira.pAtualizaDiferencaDocumento(fltDifere: Double);
begin

  With FMovFin Do
  Begin
    Last;
    Edit;
    FieldByName('FIN_VALFIN').AsFloat := FieldByName('FIN_VALFIN').AsFloat + fltDifere;
    Post;
    First;
  End;

  pAtualizaClient;
end;

Procedure TFinanceira.pSalvaCartoes(var arrCartoes: TCartoesResumoCaixaArray);
  Var
    arrCarFin: TCartoesResumoCaixaArray;
Begin
  With FMovFin Do
  Begin
    First;
    While Not Eof Do
    Begin

      If FieldByName('FIN_TIPRET').AsString = 'P' Then
      Begin
        // APENAS UM CARTÃO POR FINANCEIRA
        arrCarFin := fRetArrCartaoFinanc(FieldByName('FIN_CODFIN').AsString);
        SetLength(arrCartoes, Succ(Length(arrCartoes))); // APENAS UM CARTÃO POR FINANCEIRA
        arrCartoes[High(arrCartoes)] := arrCarFin[0];
      End;

      Next;
    End;
  End;
End;

{Procedure TFinanceira.pMostraDadosPedido(strSeqGer: String);
Begin
  pCriarFormularios(TfrmDigFinanceira, frmDigFinanceira);
  With frmDigFinanceira Do
  Begin
    pCarregaFinanciamento('FATGOR', strSeqGer);
    pCarregaDados(arrCarFin, cdsSelFin);
    pnlDados.Visible    := False;
    btnConfirma.Visible := False;
    btnExcluir.Visible  := False;
    ShowModal;
  End;
  FreeAndNil(frmDigFinanceira);
End;}

Function TFinanceira.fCalulaTaxaRetorno(fltValFin, fltTaxRet: Double): Double;
Begin
  Result := RoundTo((fltValFin * fltTaxRet) / 100, -2);
End;

function TFinanceira.fRetIndiceFinanceira(strCodFin: String): Integer;
Var
  intContador: Integer;
begin
  Result := -1;

  For intContador := 0 To Length(FArrVal) - 1 Do
  Begin
    If (FArrVal[intContador].strCodFin = strCodFin) Then
    Begin
      Result := intContador;
      Break;
    End;
  End;

end;

Function TFinanceira.fRetCartaoFinanceira(strCodFin: String; intQtdPar: Integer): String;
  Var
    qryIndFin: TUniQuery;
Begin
  qryIndFin := fCriaQuery(Nil);
  With qryIndFin, SQL Do
  Begin
    Clear;
    Add('SELECT IND_CODCAR');
    Add('FROM INDFIN');
    Add('WHERE');
    Add('  IND_CODFIN = :CODFIN AND ');
    Add('  IND_QTDPAR = :QTDPAR     ');

    ParamByName('CODFIN').AsString  := strCodFin;
    ParamByName('QTDPAR').AsInteger := intQtdPar;

    Open;

    If IsEmpty Then
      Result := ''
    Else
      Result := FieldByName('IND_CODCAR').AsString;
  End;

  FreeAndNil(qryIndFin);
End;

Function TFinanceira.fRetDespesasAcessorias: Double;
Begin
  Result := 0;

  With FMovFin Do
  Begin
    If IsEmpty Then
      Exit;

    pAtualizaClient;

    If (FieldByName('FIN_DESACE').AsString = 'S') Then
      Result := fDoubleAggregate(FMovFin, 'FIN_TOTOPE') -
                fDoubleAggregate(FMovFin, 'FIN_TOTFIN');

    If Result < 0 Then
      Result := 0;
  End;
End;

Function TFinanceira.fRetTotalOperacao: Double;
Begin
  Result := fDoubleAggregate(FMovFin, 'FIN_TOTOPE');
End;

Function TFinanceira.fRetTotalFinanciado: Double;
Begin
  Result := fDoubleAggregate(FMovFin, 'FIN_TOTFIN');
End;

Function TFinanceira.fRetTotalAdiantado: Double;
Begin
  Result := fDoubleAggregate(FMovFin, 'FIN_TOTADT');
End;

Function TFinanceira.fRetValFin: Double;
Begin
  With FMovFin Do
  If (FieldByName('FIN_DESACE').AsString = 'S') Then
    Result := fRetTotalOperacao
  Else
    Result := fRetTotalFinanciado;

End;

function TFinanceira.fRetValFinPorFinanceira(strCodFin: String): Double;
begin
  With FMovFin Do
  Begin
    If (FieldByName('FIN_DESACE').AsString = 'S') Then
      Result := fRetTotalOperacao
    Else
      Result := fRetTotalFinanciado;

end;
End;

function TFinanceira.fRetValorDesmembrado(strCodFin: String): Double;
Var
  intContador: Integer;
begin

  Result := 0;

  For intContador := 0 To Length(FArrVal) - 1 Do
  Begin
    If (FArrVal[intContador].strCodFin = strCodFin) Then
      Result := Result + FArrVal[intContador].fltValFin;
  End;

end;

function TFinanceira.fRetValorOriginal(strCodFin: String): Double;
begin

  Result := 0;

  With FMovTmp Do
  Begin
    First;

    While Not Eof Do
    Begin
      If (FieldByName('FIN_CODFIN').AsString = strCodFin) Then
        Result := Result + FieldByName('FIN_VALFIN').AsFloat;

      Next;
    End;

    First;
  End;

end;

end.
