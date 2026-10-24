unit untQckReimpCtaPagar;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, frxDMPExport, Uni,
  strUtils, DB, UniClientDataSet, frxDMPClass, Forms, untIFuncoes;

type
  TfrmQckReimpCtaPagar = class(TForm)
    frxMatricial: TfrxDotMatrixExport;
    frxGen: TfrxUserDataSet;
    frxDataset: TfrxDBDataset;
    frxReciboM: TfrxReport;
    frxDatasetChqEmi: TfrxDBDataset;
    frxReciboJ: TfrxReport;
    function frxReciboMUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure frxGenGetValue(const VarName: string; var Value: Variant);
    procedure DataModuleCreate(Sender: TObject);
    procedure SetTextMemo(AMemo : TfrxMemoView; AText: String);
    procedure SetVisibleMemo(AMemo : TfrxMemoView; AVisible: Boolean);
    procedure SetVisibleShapeView(AShapeView : TfrxShapeView; AVisible: Boolean);
  private
    { Private declarations }
    frxRecibo : TfrxReport;
  public
    { Public declarations }
    strTipImp : String;
    intQtdReg : Integer;

    procedure pImprimeRecibo(blnVideo,
                             blnDialogo: Boolean;
                             strNomFrm,
                             strTipImp,
                             strNomFil,
                             strSeqCon: String;
                             DataSet: TDataSet;
                             intQtdVias: Integer = 1;
                             qryChqPre: TDataSet = Nil;
                             qryChqVis: TDataSet = Nil);

    function fFormataFoneInterna(strFone: String): String;
    function fRetNomBanco(Const strCodBco: String): String;

  end;


implementation

uses untFuncoesGenerica, untFuncoesSimples;

{$R *.dfm}

{ TfrmQckReimpCtaPagar }

procedure TfrmQckReimpCtaPagar.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

  frxReciboJ.AddFunction('function fFormataFoneInterna(strFone: String): String');
  frxReciboM.AddFunction('function fFormataFoneInterna(strFone: String): String');

  frxReciboM.AddFunction('procedure pDecrementaQtdReg');
  frxReciboJ.AddFunction('procedure pDecrementaQtdReg');

end;

function TfrmQckReimpCtaPagar.fFormataFoneInterna(strFone: String): String;
begin
  Result := fFormataFone(strFone);
end;

function TfrmQckReimpCtaPagar.fRetNomBanco(const strCodBco: String): String;
Begin

  Result := '';

  If fEmptyStr(strCodBco) Then
    Exit;

  Result := fCampoTabela('BCO_NOMBCO', 'CADBCO', ['BCO_CODBCO'], [strCodBco], False);

end;

procedure TfrmQckReimpCtaPagar.frxGenGetValue(const VarName: string;
  var Value: Variant);
begin
  If AnsiUpperCase(VarName) = AnsiUpperCase('intQtdReg') Then
  Begin
    Value := intQtdReg;
  End;
end;

function TfrmQckReimpCtaPagar.frxReciboMUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  If AnsiUpperCase(MethodName) = AnsiUpperCase('pDecrementaQtdReg') Then
  Begin
    If (strTipImp = 'M') Then
      Dec(intQtdReg, 17)
    Else
      Dec(intQtdReg, 70);
  End
  Else If (SameText(MethodName, 'fFormataFoneInterna')) Then
    Result := fFormataFoneInterna(Trim(Params[0]));
end;

procedure TfrmQckReimpCtaPagar.pImprimeRecibo(blnVideo,
                                              blnDialogo: Boolean;
                                              strNomFrm,
                                              strTipImp,
                                              strNomFil,
                                              strSeqCon: String;
                                              DataSet: TDataSet;
                                              intQtdVias: Integer = 1;
                                              qryChqPre: TDataSet = Nil;
                                              qryChqVis: TDataSet = Nil);
Var
  intContador      : Integer;
  qryChq_Emi_Baixa : TUniQuery;
  qryDinheiro      : TUniQuery;
  strSQL           : String;
begin

  If strTipImp = 'M' Then
    frxRecibo := frxReciboM
  Else
  Begin
    frxRecibo := frxReciboJ;
    frxRecibo.DotMatrixReport := False;
    frxRecibo.PrintOptions.PrintMode    := pmScale;
    frxRecibo.PrintOptions.PrintOnSheet := 9; //A4
  End;

  frxDataset.DataSet := DataSet;

  frxRecibo.PrintOptions.Printer := AnsiReplaceText(strNomFil, '\\' + fRetNomeRede + '\', '');
  frxRecibo.PrintOptions.ShowDialog := blnDialogo;
  frxRecibo.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
  If Dataset.FieldByName('RCX_CODCAX').AsString <> '' Then
    frxRecibo.Script.Variables['CAIXA'] := 'CAIXA: ' + Dataset.FieldByName('RCX_CODCAX').AsString
  Else
    frxRecibo.Script.Variables['CAIXA'] := '';

  {Impressão dos cheques vinculados a baixa!}
  qryChq_Emi_Baixa := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + ' SELECT                    ';
  strSQL := strSQL + '   A.*,               ';
  strSQL := strSQL + '   CONCAT(A.EMI_CODBCO, " - ", (SELECT BCO_NOMBCO FROM CADBCO WHERE BCO_CODBCO = A.EMI_CODBCO)) AS BANCO, ';

  {Devido a demonstração do valor do cheque em relatório e o seu rateio nas baixas em CHQEMI...
   foi necessário "agrupar" os valores}
  strSQL := strSQL + '   (                                  ';
  strSQL := strSQL + '    SELECT                            ';
  strSQL := strSQL + '      SUM(B.EMI_VALBAI)               ';
  strSQL := strSQL + '    FROM                              ';
  strSQL := strSQL + '      CHQEMI B                        ';
  strSQL := strSQL + '    WHERE                             ';
  strSQL := strSQL + '      B.EMI_CODEMP = A.EMI_CODEMP AND ';
  strSQL := strSQL + '      B.EMI_CODBCO = A.EMI_CODBCO AND ';
  strSQL := strSQL + '      B.EMI_NUMAGE = A.EMI_NUMAGE AND ';
  strSQL := strSQL + '      B.EMI_CONCOR = A.EMI_CONCOR AND ';
  strSQL := strSQL + '      B.EMI_NUMCHQ = A.EMI_NUMCHQ AND ';
  strSQL := strSQL + '      B.EMI_CODFOR = A.EMI_CODFOR     ';
  strSQL := strSQL + '   ) AS VALOR_AGRUPADO                ';

  strSQL := strSQL + ' FROM                        ';
  strSQL := strSQL + '   CHQEMI A                  ';
  strSQL := strSQL + ' WHERE                       ';
  strSQL := strSQL + '  A.EMI_CODFOR = :CODFOR AND ';
  strSQL := strSQL + '  A.EMI_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  A.EMI_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '  A.EMI_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  A.EMI_SEQBAI = :SEQBAI AND ';
  strSQL := strSQL + '  A.EMI_SERIE_ = :SERIE_     ';

  With qryChq_Emi_Baixa Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFOR').AsString := DataSet.FieldByName('CODFOR').AsString;
    ParamByName('NUMDUP').AsString := DataSet.FieldByName('CTP_NUMDUP').AsString;
    ParamByName('PARCEL').AsString := DataSet.FieldByName('CTP_PARCEL').AsString;
    ParamByName('CODEMP').AsString := DataSet.FieldByName('CTP_CODEMP').AsString;
    ParamByName('SEQBAI').AsString := DataSet.FieldByName('CTP_SEQBAI').AsString;
    ParamByName('SERIE_').AsString := DataSet.FieldByName('CTP_SERIE_').AsString;
    Open;

    frxDatasetChqEmi.DataSet := qryChq_Emi_Baixa;
    frxRecibo.FindObject('CUmCheque').Visible      := False;
    frxRecibo.FindObject('CVariosCheques').Visible := True;

  End;
  {Dinheiro}

  strSQL := '';
  strSQL := strSQL + 'SELECT SUM(CADPAG.CTP_DINHEI) AS TOTAL, CADPAG.CTP_PORBAI, CADPOR.POR_NOMPOR ';
  strSQL := strSQL + 'FROM CADPAG ';
  strSQL := strSQL + 'INNER JOIN CADPOR ON (CADPOR.POR_CODPOR = CADPAG.CTP_PORBAI) ';
  strSQL := strSQL + ' WHERE                       ';
  strSQL := strSQL + '  CADPAG.CTP_CODFOR = :CODFOR AND ';
  strSQL := strSQL + '  CADPAG.CTP_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  CADPAG.CTP_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '  CADPAG.CTP_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  CADPAG.CTP_SEQBAI = :SEQBAI AND ';
  strSQL := strSQL + '  CADPAG.CTP_SERIE_ = :SERIE_     ';

  qryDinheiro := fCriaQuery(Nil);

  try

    qryDinheiro.Close;
    qryDinheiro.SQL.Clear;
    qryDinheiro.SQL.Add(strSQL);
    qryDinheiro.ParamByName('CODFOR').AsString := DataSet.FieldByName('CODFOR').AsString;
    qryDinheiro.ParamByName('NUMDUP').AsString := DataSet.FieldByName('CTP_NUMDUP').AsString;
    qryDinheiro.ParamByName('PARCEL').AsString := DataSet.FieldByName('CTP_PARCEL').AsString;
    qryDinheiro.ParamByName('CODEMP').AsString := DataSet.FieldByName('CTP_CODEMP').AsString;
    qryDinheiro.ParamByName('SEQBAI').AsString := DataSet.FieldByName('CTP_SEQBAI').AsString;
    qryDinheiro.ParamByName('SERIE_').AsString := DataSet.FieldByName('CTP_SERIE_').AsString;
    qryDinheiro.Open;

      if (not qryDinheiro.IsEmpty) and (qryDinheiro.FieldByName('TOTAL').AsFloat > 0) then
      begin
        SetTextMemo(TfrxMemoView(frxRecibo.FindObject('memVlrDinheiro')),FormatFloat('#,##0.00', qryDinheiro.FieldByName('TOTAL').AsFloat));
        SetTextMemo(TfrxMemoView(frxRecibo.FindObject('memPortDinheiro')),qryDinheiro.FieldByName('POR_NOMPOR').AsString);
      end
      else
      begin
        SetVisibleMemo(TfrxMemoView(frxRecibo.FindObject('memVlrDinheiro'))  , False);
        SetVisibleMemo(TfrxMemoView(frxRecibo.FindObject('memPortDinheiro')) , False);
        SetVisibleMemo(TfrxMemoView(frxRecibo.FindObject('mdinheiro1'))      , False);
        SetVisibleMemo(TfrxMemoView(frxRecibo.FindObject('mdinheiro2'))      , False);
        SetVisibleShapeView(TfrxShapeView(frxRecibo.FindObject('sdinheiro3')), False);
        SetVisibleShapeView(TfrxShapeView(frxRecibo.FindObject('sdinheiro4')), False);
        SetVisibleMemo(TfrxMemoView(frxRecibo.FindObject('mportador1'))      , False);
        SetVisibleShapeView(TfrxShapeView(frxRecibo.FindObject('sportador3')), False);
        SetVisibleMemo(TfrxMemoView(frxRecibo.FindObject('mvalor1'))         , False);
        SetVisibleShapeView(TfrxShapeView(frxRecibo.FindObject('svalor3'))   , False);
      end;
    finally
      FreeAndNil(qryDinheiro);
  end;


  frxRecibo.PrepareReport;

  For intContador := 1 To intQtdVias Do
  Begin
    If (blnVideo) Or fEmptyStr(strNomFil) Then
      pPreviewReport(strNomFrm, 'Reimpressão de contas a pagar - Recibo', frxRecibo)
    Else
      pPrintReport(strNomFrm, 'Reimpressão de contas a pagar - Recibo', strNomFil, frxRecibo);
  End;

end;

procedure TfrmQckReimpCtaPagar.SetTextMemo( AMemo: TfrxMemoView;
  AText: String);
begin
  If Assigned(AMemo) Then
    AMemo.Memo.Text :=  AText;
end;

procedure TfrmQckReimpCtaPagar.SetVisibleMemo( AMemo: TfrxMemoView;
  AVisible: Boolean);
begin
  If Assigned(AMemo) Then
    AMemo.Visible :=  AVisible;
end;

procedure TfrmQckReimpCtaPagar.SetVisibleShapeView(
   AShapeView: TfrxShapeView; AVisible: Boolean);
begin
  If Assigned(AShapeView) Then
    AShapeView.Visible :=  AVisible;
end;

end.
