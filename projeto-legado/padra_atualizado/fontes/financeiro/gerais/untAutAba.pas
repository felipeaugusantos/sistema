{********************************************}
{* CLASSE PARA AUTORIZAÇÃO DE ABASTECIMENTO *}
{* DATA......: 19/03/2012                   *}
{*****************************************RN*}
unit untAutAba;

interface

uses Classes, DB, untFuncoesSimples, Uni,
     frxClass, untRelCadAutAba;

Type TAutAba = Class (TComponent)
  Private
    FCodSeq: String;
    FCodFor: String;
    FDtaEmi: String;
    FPlaVei: String;
    FCombus: String;
    FQtdLts: Double;
    FVlrAbs: Double;
    FCodMot: String;
    FCodEmp: String;
    FKm_Vei: String;
    FModulo: TfrmRelCadAutAba;
    procedure pAfterOpen(Dataset: TDataSet);
    procedure SetCodFor(const Value: String);
    procedure SetCodMot(const Value: String);
    procedure SetCodSeq(const Value: String);
    procedure SetCombus(const Value: String);
    procedure SetDtaEmi(const Value: String);
    procedure SetPlaVei(const Value: String);
    procedure SetQtdLts(const Value: Double);
    procedure SetVlrAbs(const Value: Double);
    procedure SetCodEmp(const Value: String);
    procedure SetKm_Vei(const Value: String);
  Public
    qryTabela: TUniQuery;
    arrDefCam: TArrDefCam;

    Property strCodSeq: String Read FCodSeq Write SetCodSeq;
    Property strCodFor: String Read FCodFor Write SetCodFor;
    Property strDtaEmi: String Read FDtaEmi Write SetDtaEmi;
    Property strPlaVei: String Read FPlaVei Write SetPlaVei;
    Property strCombus: String Read FCombus Write SetCombus;
    Property fltQtdLts: Double Read FQtdLts Write SetQtdLts;
    Property fltVlrAbs: Double Read FVlrAbs Write SetVlrAbs;
    Property strCodMot: String Read FCodMot Write SetCodMot;
    Property strCodEmp: String Read FCodEmp Write SetCodEmp;
    Property strKm_Vei: String Read FKm_Vei Write SetKm_Vei;
    procedure pImprimeAutorizacao(strSeq, strEmp, strNomFor: String);
    Constructor Create(Owner: TComponent); Reintroduce;
  end;

Const

  arrCampos   : Array[0..9] Of String = ( 'ABA_SEQABA','ABA_PLAVEI','ABA_DTAEMI','AUTOINCREM','ABA_CODMOT',
                                          'ABA_COMBUS','ABA_VLRABA','ABA_QTDLTS', 'ABA_CODFOR', 'ABA_KM_VEI');

  arrDescricao: Array[0..9] Of String = ( 'Sequencia','Veiculo','Dt.Emissão','AUTOINCREM','Motorista',
                                          'Combustivel','Vlr.Abst.','Qtd.Litros', 'Fornecedor', 'Km Atual do Veículo');

  arrTipo     : Array[0..9] Of TFieldType = ( ftString, ftString, ftDate, ftString, ftString,
                                              ftString, ftFloat, ftFloat, ftString, ftString);

  arrTamanhos : Array[0..9] Of Integer    = ( 6, 7, 10, 20, 5, 10, 15, 20, 8, 7);

  arrVisible  : Array[0..9] Of Boolean    = ( True, True, True, True, True, True, True, True, True, True );

  arrFormat   : Array[0..9] Of String     = ( '', '', 'DD/MM/YYYY', '', '', '', '#,##0.00', '#,##0.000', '', '');

implementation

uses  SysUtils, StrUtils, untConstantes, untCfgRel, untTypesSistema;

{ TAutAba }

constructor TAutAba.Create(Owner: TComponent);
  Var
    IntContador: Integer;
begin

  Try
    FModulo := TfrmRelCadAutAba.Create(Self);

    SetLength(arrDefCam, 9);

    For intContador := 0 To Length(arrDefCam)-1 Do
    Begin
      arrDefCam[intContador].strNomCam  := arrCampos[intContador];
      arrDefCam[intContador].strDesCri  := arrDescricao[intContador];
      arrDefCam[intContador].ftpTipCam  := arrTipo[intContador];
      arrDefCam[intContador].intTamCam  := arrTamanhos[intContador];
      arrDefCam[intContador].blnVisible := arrVisible[intContador];
      arrDefCam[intContador].strFormat  := arrFormat[intContador];
    End;

    qryTabela := fCriaQuery(Self);
    qryTabela.AfterOpen := pAfterOpen;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM AUTABA WHERE FALSE');
    qryTabela.Open;

    FCodSeq := '';
    FCodFor := '';
    FDtaEmi := '';
    FPlaVei := '';
    FCombus := '';
    FQtdLts := 0;
    FVlrAbs := 0;
    FCodMot := '';
    FCodEmp := '';
    FKm_Vei := '';

  Except

    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto AutAba!' + #13 + E.Message);

  End;

End;

procedure TAutAba.pAfterOpen(Dataset: TDataSet);
begin
  Dataset.FieldByName('ABA_DTAEMI').EditMask := '99/99/9999';
  TFloatField(Dataset.FieldByName('ABA_VLRABA')).currency := True;
end;

procedure TAutAba.pImprimeAutorizacao(strSeq, strEmp, strNomFor: String);
  Var
    strNomeFila,
    strTipImp : String;
    frxReport : TfrxReport;
    qryImp    : TUniQuery;
    qryCfg    : TUniQuery;
begin
  qryImp := fCriaQuery(Nil);
  qryCfg := fCriaQuery(Nil);
  qryImp.AfterOpen := pAfterOpen;

  Try
    qryImp.SQL.Add('SELECT * ');
    qryImp.SQL.Add('FROM AUTABA ');
    qryImp.SQL.Add('WHERE ABA_SEQABA = '+QuotedStr(strSeq));
    qryImp.SQL.Add('  AND ABA_CODEMP = '+QuotedStr(strEmp));
    qryImp.Open;


    pCarregaConfImpr(qryCfg, strNomFor);
    strNomeFila := qryCfg.FieldByName('REL_NOMFIL').AsString;
    strTipImp   := qryCfg.FieldByName('REL_IDEIMP').AsString;
    fPreImpressao(qryCfg, strNomeFila, strTipImp, False);
    FreeAndNil(qryCfg);

    FModulo.frxDBAutAba.DataSource := Nil;
    FModulo.frxDBAutAba.DataSet    := qryImp;

    If (strTipImp = 'J') Then
      frxReport := FModulo.frxReportJato
    Else
      frxReport := FModulo.frxReportMatricial;

    frxReport.PrintOptions.ShowDialog := fEmptyStr(strNomeFila);
    frxReport.PrintOptions.Printer := AnsiReplaceText(strNomeFila,'\\' + fRetNomeRede + '\','');

    If frxReport.PrepareReport Then
      pPrintReport(strNomFor, 'Autorização de Abastecimento', strNomeFila, frxReport);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TAutAba.pImprimeAutorizacao]');
  End;

  FreeAndNil(qryImp);
end;

procedure TAutAba.SetCodEmp(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('A empresa deve ser preechida!');

  If (fEmptyStr(fRetNomeEmpresaSelec(Value))) Then
    Raise ExceptionAutCom.Create('Empresa não cadastrada!');

  FCodEmp := Value;
end;

procedure TAutAba.SetCodFor(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O fornecedor deve ser preenchido!');

  If fEmptyStr(fRetNomFornecedor(Value)) Then
    Raise ExceptionAutCom.Create('Fornecedor não encontrado!');

  If (FCodFor <> Value) Then
    FCodFor := Value;
end;

procedure TAutAba.SetCodMot(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O motorista deve ser preenchido!');

  If fEmptyStr(fRetNomeMotorista(Value, True)) Then
    Raise ExceptionAutCom.Create('Motorista não encontrado!');

  If (FCodMot <> Value) Then
    FCodMot := Value;
end;

procedure TAutAba.SetCodSeq(const Value: String);
begin
  FCodSeq := Value;
end;

procedure TAutAba.SetCombus(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O combustível deve ser preenchido!');

  If (FCombus <> Value) Then
    FCombus := Value;
end;

procedure TAutAba.SetDtaEmi(const Value: String);
begin
  If (fEmptyDate(Value)) Then
    Raise ExceptionAutCom.Create('A data de emissão deve ser preenchida!');

  If (FDtaEmi <> Value) Then
    FDtaEmi := Value;
end;

procedure TAutAba.SetKm_Vei(const Value: String);
begin
  If Not fEmptyStr(Value) Then
  Begin
    If StrToInt(Value) <= 0 Then
      Raise ExceptionAutCom.Create('Km Atual do Veículo informado deve ser maior que zero!');
  End;

  FKm_Vei := Value;
end;

procedure TAutAba.SetPlaVei(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O veículo deve ser preenchida!');

  If fEmptyStr(fRetornaDescricaoVeic(fTiraCaracEspeciais(Value))) Then
    Raise ExceptionAutCom.Create('Veículo não econtrado!');

  If (FPlaVei <> Value) Then
    FPlaVei := fTiraCaracEspeciais(Value);
end;

procedure TAutAba.SetQtdLts(const Value: Double);
begin
  If (Value < 0) Then
    Raise ExceptionAutCom.Create('O valor deve ser positivo!');

  If (FQtdLts <> Value) Then
    FQtdLts := Value;
end;

procedure TAutAba.SetVlrAbs(const Value: Double);
begin
  If (Value < 0) Then
    Raise ExceptionAutCom.Create('O valor deve ser positivo!');

  If (FVlrAbs <> Value) Then
    FVlrAbs := Value;
end;

end.
