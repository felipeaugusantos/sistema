unit untImportarPlanilhaBocaCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, StrUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxLookAndFeels, Data.DB,
  cxLookAndFeelPainters, cxControls, cxContainer, cxEdit, cxProgressBar,
  cxTextEdit, cxMaskEdit, cxButtonEdit, FilenameEditFocus, cxButtons,
  Uni, UniClientDataSet, untTValidaExcel, Vcl.Mask, MaskEditFocus,
  cxGridDBTableView, untConfirmaImportacaoBocaCaixa;

type
  TfrmImportarPlanilhaBocaCaixa = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    btnHlpImp: TcxButton;
    pnlfundo: TPanel;
    lblPathArquivo: TLabel;
    edtPath: TFilenameEditFocus;
    pgbGeral: TcxProgressBar;
    frxHelp: TfrxReport;
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FCdsFormBocaCaixa : TUniClientDataSet;
    objValidaExcel: TValidadorExcel;
    procedure pCriaDataSet;
    procedure pExibeTela;
    procedure pProcessaItens;
    procedure pInsereItensCDS(intLinha: integer);
  public
    { Public declarations }
    cdsArqv : TUniClientDataSet;
    property cdsFormBocaCaixa : TUniClientDataSet read FCdsFormBocaCaixa write FCdsFormBocaCaixa;
  end;

  const
    QTD_COLUNAS = 3;
    arrDescColunasGrid : array of String = ['COD.ITEM', 'PR. MINIMO', 'COMISSÃO', 'INCONSISTÊNCIAS'];
implementation

uses
  untFuncoesSimples, untBocaCaixa;

{$R *.dfm}


Procedure TfrmImportarPlanilhaBocaCaixa.pCriaDataSet;
Begin
  cdsArqv := TUniClientDataSet.Create(Self);

  cdsArqv.FieldDefs.Add('CODITE', ftString, fTamCodIte, True);
  cdsArqv.FieldDefs.Add('PREMIN', ftFloat, 0, False);
  cdsArqv.FieldDefs.Add('COMVAR', ftFloat, 0, False);
  cdsArqv.FieldDefs.Add('INCONSISTENCIA', ftString, 250, False);
  cdsArqv.CreateDataSet;

  (cdsArqv.FieldByName('PREMIN') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (cdsArqv.FieldByName('COMVAR') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

  cdsArqv.IndexFieldNames := 'CODITE';
End;

procedure TfrmImportarPlanilhaBocaCaixa.pProcessaItens;
  Var
    intValIni : Integer;
    intContador : Integer;
begin
  pgbGeral.Properties.Max := objValidaExcel.ArquivoCSV.Count -1;
  pgbGeral.Position := 0;

  If cdsArqv.Active Then
    cdsArqv.EmptyDataSet;

  intValIni := IIf(objValidaExcel.fTemTitulo('B', True), 1, 0);
  pgbGeral.Position := 0;

  For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
  Begin
    pnlInfo.Caption := 'Importando itens...'+ IntToStr(intContador) +'/' +IntToStr(objValidaExcel.ArquivoCSV.Count-intValIni);

    If intContador > objValidaExcel.ArquivoCSV.Count Then
      Continue;

    pInsereItensCDS(intContador);
    pgbGeral.Position := pgbGeral.Position + 1;
    Application.ProcessMessages;
  End;
  pExibeTela;
end;

procedure TfrmImportarPlanilhaBocaCaixa.pInsereItensCDS(intLinha: integer);
var
  intContador : Integer;
  strInconsist, strValueArqv : String;
  lstInconsist : TStringList;
begin
  strInconsist := '';
  lstInconsist := TStringList.Create;
  lstInconsist.Delimiter := ';';
  try
    cdsArqv.Append;
    for intContador := 0 to Pred(cdsArqv.FieldCount) do
    begin
      if cdsArqv.FieldDefList[intContador].Name = 'INCONSISTENCIA' then
        Continue;

      strInconsist := EmptyStr;
      cdsArqv.Fields[intContador].AsString := '0';
      strValueArqv := objValidaExcel.fGetValueCSV(intLinha, arrColunas[intContador]);
      strValueArqv := IIF(strValueArqv.IsEmpty, '0', strValueArqv);

      strInconsist := TInconsistencia.fValidaInconsistencia(intLinha,
                                            arrColunas[intContador],
                                            strValueArqv,
                                            cdsArqv.Fields[intContador].DataType,
                                            cdsArqv.Fields[intContador].Required);

      if strInconsist.IsEmpty then
      begin
        cdsArqv.Fields[intContador].AsString := strValueArqv;
        If (cdsArqv.Fields[intContador].FieldName  = 'CODITE') then
          cdsArqv.Fields[intContador].AsString := FormatFloat('00000', StrToInt(strValueArqv));
      end
      else
        lstInconsist.Add(strInconsist);
    end;
    cdsArqv.FieldByName('INCONSISTENCIA').AsString := lstInconsist.Text;
    cdsArqv.Post;
  finally
    FreeAndNil(lstInconsist);
  end;
end;

procedure TfrmImportarPlanilhaBocaCaixa.pExibeTela;
var
  frmConfirmImport : TfrmConfirmaImportacaoBocaCaixa;
  objColumn : TcxGridDBColumn;
  intContador : integer;
begin
  If Not cdsArqv.IsEmpty Then
  Begin
    pCriarFormularios(TfrmConfirmaImportacaoBocaCaixa, frmConfirmImport);
    Try
      frmConfirmImport.cdsArqv    := cdsArqv;
      frmConfirmImport.cdsFormBocaCaixa:= Self.cdsFormBocaCaixa;
      for intContador := 0 to cdsArqv.FieldCount -1 do
      begin
        objColumn := frmConfirmImport.cxgProdutosImportadosDBTableView1.CreateColumn;
        objColumn.DataBinding.FieldName := cdsArqv.FieldDefList[intContador].Name;
        objColumn.Caption := arrDescColunasGrid[intContador];

        if cdsArqv.FieldDefList[intContador].Name = 'INCONSISTENCIA' then
          objColumn.Options.Editing := False;
      end;

      if frmConfirmImport.ShowModal = mrOk then
      begin
        ModalResult := mrOk;
        CloseModal;
      end;
    Finally
      pFreeAndNil(frmConfirmImport);
    End;
  End;
end;

procedure TfrmImportarPlanilhaBocaCaixa.btnGravarClick(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(edtPath.Text)) Then
  Begin
    pMensagemOk('Selecione um arquivo!');
    Exit;
  End
  Else If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado: ' + edtPath.Text + ' !', ['&O K']);
    Exit;
  End;

  try
    objValidaExcel := TValidadorExcel.Create(edtPath.text, QTD_COLUNAS, '', '', 0);

    btnHlpImp.Enabled     := False;
    btnGravar.Enabled     := False;
    btnSair.Enabled       := False;
    edtPath.Enabled       := False;

    Mouse.SettingChanged(10);
    pgbGeral.Visible := True;
    Application.ProcessMessages;
    edtPath.Text := AnsiReplaceStr(edtPath.Text,'"','');

    Try
      pProcessaItens;

      SetForegroundWindow(Handle);
      edtPath.Clear;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmImportarPlanilhaAjusteEstoque.btnGravarClick]');
      End;
    End;
  Finally
    btnSair.Enabled       := True;
    edtPath.Enabled       := True;

    btnHlpImp.Enabled := True;
    btnGravar.Enabled := True;
    pnlInfo.Caption := '';
    FreeAndNil(objValidaExcel);
    pgbGeral.Position     := 0;
    pgbGeral.Visible := False;
    pSetFocus(btnSair);
  End;
end;

procedure TfrmImportarPlanilhaBocaCaixa.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmImportarPlanilhaBocaCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSet;
end;

end.
