unit untImportarPlanilhaVendedorMarca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, StrUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxLookAndFeels, Data.DB,
  cxLookAndFeelPainters, cxControls, cxContainer, cxEdit, cxProgressBar,
  cxTextEdit, cxMaskEdit, cxButtonEdit, FilenameEditFocus, cxButtons,
  Uni, UniClientDataSet, untTValidaExcel, untCadLote;

type
  TfrmImportarPlanilhaVendedorMarca = class(TfrmPai)
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
    objValidaExcel: TValidadorExcel;
    procedure pInsereErro(intLinha: Integer; strColuna, strMensagem: String; out blnErro: Boolean);

    const QTD_COLUNAS = 4;
          CODCLI = 'A';
          CODVEN = 'B';
          CODMAR = 'C';
          OPERAC = 'D';

    procedure pCriaDataSets;
    procedure pExibeTela;
    procedure pInsereRegistro(intLinha: integer);
    procedure pProcessaRegistros;
    function fRetornaLinhaAposTitulo : Integer;
  public
    { Public declarations }
    blnOk : Boolean;
    cdsRegistros : TUniClientDataSet;
    cdsErros     : TUniClientDataSet;
  end;

implementation

uses
  untConfirmaImportacaoVendedorMarca,
  untFuncoesSimples;

{$R *.dfm}

Procedure TfrmImportarPlanilhaVendedorMarca.pCriaDataSets;
Begin
  cdsRegistros := TUniClientDataSet.Create(Self);

  With cdsRegistros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODCLI';
    DataType := ftString;
    Size     := 8;
  End;

  With cdsRegistros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NOMCLI';
    DataType := ftString;
    Size     := 60;
  End;

  With cdsRegistros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODVEN';
    DataType := ftString;
    Size     := 3;
  End;

  With cdsRegistros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODMAR';
    DataType := ftString;
    Size     := 6;
  End;

  With cdsRegistros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESMAR';
    DataType := ftString;
    Size     := 30;
  End;

  With cdsRegistros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'OPERAC';
    DataType := ftString;
    Size     := 1;
  End;

  cdsRegistros.CreateDataSet;

  cdsErros     := TUniClientDataSet.Create(Self);

  With cdsErros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'LINHA';
    DataType := ftInteger;
    Required := True;
  End;

  With cdsErros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'COLUNA';
    DataType := ftString;
    Size     := 1;
    Required := True;
  End;

  With cdsErros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'MENSAG';
    DataType := ftString;
    Size     := 150;
    Required := True;
  End;

  cdsErros.CreateDataSet;
End;

procedure TfrmImportarPlanilhaVendedorMarca.pInsereErro(intLinha: Integer; strColuna: String; strMensagem: String; out blnErro: Boolean);
begin
  cdsErros.Open;
  cdsErros.Insert;
  cdsErros.FieldByName('LINHA').AsInteger := intLinha;
  cdsErros.FieldByName('COLUNA').AsString := strColuna;
  cdsErros.FieldByName('MENSAG').AsString := strMensagem;
  cdsErros.Post;

  blnErro := True;
end;

procedure TfrmImportarPlanilhaVendedorMarca.pInsereRegistro(intLinha: integer);
  Var
    blnErro : Boolean;
begin
  blnErro := False;

  cdsRegistros.Open;
  cdsRegistros.Insert;
  cdsRegistros.FieldByName('CODCLI').AsString    := objValidaExcel.fGetValueCSV(intLinha, CODCLI);
  cdsRegistros.FieldByName('CODVEN').AsString    := objValidaExcel.fGetValueCSV(intLinha, CODVEN);
  cdsRegistros.FieldByName('CODMAR').AsString    := objValidaExcel.fGetValueCSV(intLinha, CODMAR);
  cdsRegistros.FieldByName('OPERAC').AsString    := objValidaExcel.fGetValueCSV(intLinha, OPERAC);
  cdsRegistros.FieldByName('NOMCLI').AsString    := '';
  cdsRegistros.FieldByName('DESMAR').AsString    := '';

  If Not fEmptyStr(cdsRegistros.FieldByName('CODCLI').AsString) Then
  Begin
    cdsRegistros.FieldByName('NOMCLI').AsString := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [cdsRegistros.FieldByName('CODCLI').AsString], False);
    If fEmptyStr(cdsRegistros.FieldByName('NOMCLI').AsString) Then
      pInsereErro(Succ(intLinha), 'A', 'Código não encontrado!', blnErro);
  End
  Else
    pInsereErro(Succ(intLinha), 'A', 'Campo obrigatório!', blnErro);

  If fEmptyStr(cdsRegistros.FieldByName('CODVEN').AsString) Then
    pInsereErro(Succ(intLinha), 'B', 'Campo obrigatório!', blnErro)
  Else If fEmptyStr(fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [cdsRegistros.FieldByName('CODVEN').AsString], False)) Then
      pInsereErro(Succ(intLinha), 'B', 'Código não encontrado!', blnErro);

  If Not fEmptyStr(cdsRegistros.FieldByName('CODMAR').AsString) Then
  Begin
    cdsRegistros.FieldByName('DESMAR').AsString := fCampoTabela('MAR_DESMAR', 'CADMAR', ['MAR_CODMAR'], [cdsRegistros.FieldByName('CODMAR').AsString], False);
    If fEmptyStr(cdsRegistros.FieldByName('DESMAR').AsString) Then
      pInsereErro(Succ(intLinha), 'C', 'Código não encontrado!', blnErro);
  End
  Else
    pInsereErro(Succ(intLinha), 'C', 'Campo obrigatório!', blnErro);

  If fEmptyStr(cdsRegistros.FieldByName('OPERAC').AsString) Then
    pInsereErro(Succ(intLinha), 'D', 'Campo obrigatório!', blnErro)
  Else If (Not fInArray(cdsRegistros.FieldByName('OPERAC').AsString, ['I', 'E'])) Then
    pInsereErro(Succ(intLinha), 'D', 'Valor inválido para a Operação (I/E)!', blnErro);

  If blnErro Then
    cdsRegistros.Cancel
  Else
    cdsRegistros.Post;
end;

procedure TfrmImportarPlanilhaVendedorMarca.pProcessaRegistros;
  Var
    intValIni : Integer;
    intContador : Integer;
begin
  pgbGeral.Properties.Max := objValidaExcel.ArquivoCSV.Count -1;
  pgbGeral.Position := 0;

  If cdsRegistros.Active Then
    cdsRegistros.EmptyDataSet;

  If cdsErros.Active Then
    cdsErros.EmptyDataSet;

  intValIni := fRetornaLinhaAposTitulo;
  pgbGeral.Position := 0;
  For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
  Begin
    pnlInfo.Caption := 'Importando registros...'+ IntToStr(intContador) +'/' +IntToStr(objValidaExcel.ArquivoCSV.Count-intValIni);

    If intContador > objValidaExcel.ArquivoCSV.Count Then
      Continue;

    pInsereRegistro(intContador);
    pgbGeral.Position := pgbGeral.Position + 1;
    Application.ProcessMessages;
  End;

  pExibeTela;
end;

procedure TfrmImportarPlanilhaVendedorMarca.pExibeTela;
  Var
    frmConfirmaImportacaoVendedorMarca : TfrmConfirmaImportacaoVendedorMarca;
begin
  pCriarFormularios(TfrmConfirmaImportacaoVendedorMarca, frmConfirmaImportacaoVendedorMarca);
  Try
    frmConfirmaImportacaoVendedorMarca.cdsDados := cdsRegistros;
    frmConfirmaImportacaoVendedorMarca.cdsErros := cdsErros;
    frmConfirmaImportacaoVendedorMarca.ShowModal;
    blnOk := frmConfirmaImportacaoVendedorMarca.blnOk;
  Finally
    pFreeAndNil(frmConfirmaImportacaoVendedorMarca);
  End;
end;

procedure TfrmImportarPlanilhaVendedorMarca.btnGravarClick(Sender: TObject);
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

  Try
    Try
      objValidaExcel := TValidadorExcel.Create(edtPath.text, QTD_COLUNAS, '', '', 0);

      btnHlpImp.Enabled     := False;
      btnGravar.Enabled     := False;
      btnSair.Enabled       := False;
      edtPath.Enabled       := False;

      Mouse.SettingChanged(10);
      pgbGeral.Visible := True;
      Application.ProcessMessages;
      edtPath.Text := AnsiReplaceStr(edtPath.Text,'"','');

      pProcessaRegistros;

      SetForegroundWindow(Handle);
      edtPath.Clear;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmImportarPlanilhaVendedorMarca.btnGravarClick]');
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

  If blnOk Then
    Close;
end;

procedure TfrmImportarPlanilhaVendedorMarca.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmImportarPlanilhaVendedorMarca.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
end;

function TfrmImportarPlanilhaVendedorMarca.fRetornaLinhaAposTitulo: Integer;
  var
    intTestedor : Integer;
    intContador : Integer;
begin
  Result := 0;
  For intContador := 0 To Pred(objValidaExcel.ArquivoCSV.Count) Do
  Begin
    If TryStrToInt(Trim(objValidaExcel.fGetValueCSV(intContador, CODCLI)), intTestedor) Then
      Exit(intContador);
  End;
end;

end.
