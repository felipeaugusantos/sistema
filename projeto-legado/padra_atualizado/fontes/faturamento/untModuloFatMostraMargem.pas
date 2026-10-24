unit untModuloFatMostraMargem;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxDBSet, Uni, DB, strUtils,
  System.Generics.Collections, Forms, untTypesMargem;

type
  TfrmModuloFatMostraMargem = class(TForm)
    frxImpF4: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    frxGen: TfrxUserDataSet;
    frxImpF4Tinta: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
    procedure frxGenGetValue(const VarName: string; var Value: Variant);
  private
    { Private declarations }
    procedure pHabilitaColunas(frxImp: TfrxReport);
  public
    { Public declarations }
    dicColunas: TDictionary<String, Boolean>;
    blnTinta: Boolean;
    fncUserFunction : TUserFunction;
    stlFunctions : TStringList;
    procedure pImprimir(DataSet: TDataSet; strDestino: String);
  end;

var
  frmModuloFatMostraMargem: TfrmModuloFatMostraMargem;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses untFuncoesSimples, untMargemMinima;

{$R *.dfm}

procedure TfrmModuloFatMostraMargem.DataModuleCreate(Sender: TObject);
  Var
    intContador : Integer;
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
end;

procedure TfrmModuloFatMostraMargem.frxGenGetValue(const VarName: string;
  var Value: Variant);
begin
  inherited;

  If VarName = 'EMP_NOMEMP' Then
    Value := fCampoTabela('EMP_NOMEMP', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False)

  Else If VarName = 'EMP_NOMFAN' Then
    Value := fCampoTabela('EMP_NOMFAN', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False)

  Else If VarName = 'REL_NOMREL' Then
    Value := Self.Name

  Else If VarName = 'EMP_NOMCID' Then
    Value := fCampoTabela('CID_NOMCID', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False);

end;

procedure TfrmModuloFatMostraMargem.pHabilitaColunas(frxImp: TfrxReport);
  Var
    intCnt : Integer;
    strNomeCol : String;
    strChave : String;
begin
  If dicColunas.Count <= 0 Then
    Exit;

  For strChave In dicColunas.Keys Do
  Begin
    For intCnt := 1 To 5 Do
    Begin
      strNomeCol := strChave + intToStr(intCnt);

      If frxImp.FindObject(strNomeCol) <> Nil Then
        TfrxMemoView(frxImp.FindObject(strNomeCol)).Visible := dicColunas[strChave]
      Else
        Break;
    End;
  End;
end;

procedure TfrmModuloFatMostraMargem.pImprimir(DataSet: TDataSet; strDestino: String);
  Var
    frxImp : TfrxReport;
    intCnt : Integer;
    strNomImp: String;
    strTipImp: String;
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery(Self);
  Try
    pCarregaConfImpr(qryCfgRel, 'frmFatMostraMargemNovo');
    strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
    strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  Finally
    FreeAndNil(qryCfgRel);
  End;

  If (blnTinta) Then
    frxImp := frxImpF4Tinta
  Else
  Begin
    frxImp := frxImpF4;
    If frxImp.FindObject('rllQtdIte2') <> Nil Then
      TfrxMemoView(frxImp.FindObject('rllQtdIte2')).DisplayFormat.FormatStr := '%2.' + fCfgSis('DECQTD', varString) + 'n';
    If frxImp.FindObject('rllQtdIte3') <> Nil Then
      TfrxMemoView(frxImp.FindObject('rllQtdIte3')).DisplayFormat.FormatStr := '%2.' + fCfgSis('DECQTD', varString) + 'n';
  End;

  If Assigned(stlFunctions) And (stlFunctions.Count > 0) Then
    For intCnt := 0 To stlFunctions.Count -1 Do
      frxImp.AddFunction(stlFunctions.Strings[intCnt]);

  If (TMargemMinima.UsaPrecoBruto) Then
  Begin
    If frxImp.FindObject('rllPreMed2') <> Nil Then
      TfrxMemoView(frxImp.FindObject('rllPreMed2')).Text := '[frxRelatorio."ITE_PREMED"]';

    If frxImp.FindObject('rllPreMed3') <> Nil Then
      TfrxMemoView(frxImp.FindObject('rllPreMed3')).Text := '[fTotalDouble(''ITE_PREMED'')]';
  End
  Else
  Begin
    If frxImp.FindObject('rllPreMed2') <> Nil Then
      TfrxMemoView(frxImp.FindObject('rllPreMed2')).Text := '[frxRelatorio."ITE_PREMED_LIQ"]';

    If frxImp.FindObject('rllPreMed3') <> Nil Then
      TfrxMemoView(frxImp.FindObject('rllPreMed3')).Text := '[fTotalDouble(''ITE_PREMED_LIQ'')]';
  End;

  If Assigned(fncUserFunction) Then
    frxImp.OnUserFunction := fncUserFunction;

  pHabilitaColunas(frxImp);
  frxRelatorio.DataSet := DataSet;
  frxImp.PrintOptions.Printer := AnsiReplaceText(strNomImp, '\\' + fRetNomeRede + '\', '');
  frxImp.PrintOptions.ShowDialog := frxImp.PrintOptions.Printer.IsEmpty;

  If strDestino = 'V' Then
    pPreviewReport('frmFatMostraMargemNovo', 'Consulta de Custo / Margem de Produtos', frxImp)
  Else
    If frxImp.PrepareReport Then
      pPrintReport('frmFatMostraMargemNovo', 'Consulta de Custo / Margem de Produtos', strNomImp, frxImp);
end;

end.
