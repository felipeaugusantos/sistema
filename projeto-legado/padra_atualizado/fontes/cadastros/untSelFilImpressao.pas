unit untSelFilImpressao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls, Winapi.ShlObj, cxShellCommon,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxListView, cxShellListView,
  Printers, WinSpool, System.UITypes, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, Uni, strUtils, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxImageComboBox, cxTextEdit, cxGridLevel, cxGridCustomTableView,
  cxGridCardView, cxGridDBCardView, cxClasses, cxGridCustomView,
  cxGridCustomLayoutView, cxGrid, cxGridCitel, System.ImageList, Vcl.ImgList,
  cxImageList, Datasnap.DBClient, UniClientDataSet, dxGDIPlusClasses;

type
  TfrmSelFilImpressao = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    lblNomPro: TLabel;
    btnConfigurar: TBitBtnLocked;
    cdsImpressoras: TUniClientDataSet;
    cdsImpressorasicone: TIntegerField;
    cdsImpressorasnome_impressora: TStringField;
    dtsImpressoras: TDataSource;
    imgImpressoras: TcxImageList;
    cxgImpressoras: TcxGridCitel;
    cxgImpressorasView: TcxGridDBCardView;
    cxgImpressorasViewicone: TcxGridDBCardViewRow;
    cxgImpressorasViewnome_impressora_exibir: TcxGridDBCardViewRow;
    cxgImpressorasLevel: TcxGridLevel;
    cdsImpressorasnome_impressora_exibir: TStringField;
    cdsImpressorasnome_impressora_pesquisar: TStringField;
    chkNaoPerguntar: TCheckBox;
    Panel1: TPanel;
    pnlFiltroPesquisa: TPanel;
    Image2: TImage;
    edtPesquisar: TEdit;
    Shape1: TShape;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure cxgImpressorasViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure cxgImpressorasEnter(Sender: TObject);
    procedure edtPesquisarEnter(Sender: TObject);
    procedure edtPesquisarExit(Sender: TObject);
    procedure edtPesquisarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure edtPesquisarChange(Sender: TObject);
    procedure edtPesquisarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function fGetPrinterIconIndex(Printer: String): Integer;
    function fPesquisar: Boolean;
    function fGetPalavrasPesquisar: TStringList;
    procedure pLimparPesquisa;
    procedure pCarregarImpressorasInstaladas;
    procedure pCarregarImpressorasCadastradas;
    procedure pCarregarPontosImpressaoCadastrados;
    { Private declarations }
  public
    { Public declarations }
    strUltimaFilaUtilizada: String;
    strImpSelecionada: String;
    strTipoImpSelecionada: String;
    strFiltroNomeImpressora: String;
    blnImpressorasCadastradas: Boolean;
    blnOpcaoNaoImprimir: Boolean;
    strFrm: String;
    strDesFrm: String;
    strAutInc: String;
    strCodOpe: String;
    strNomMaq: String;
  end;

Const
  IMP_MATRICIAL = 'Matricial';
  IMP_JATO_LASER = 'Jato de Tinta/Laser';
  INFO_PESQUISA = 'Ctrl+L Pesquisar';

implementation

{$R *.dfm}

uses untCfgRel, untSpoolImpressao;

{ TfrmSelFilImpressao }

procedure TfrmSelFilImpressao.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  TCfgRel.pConfigurarFilaDeImpressao(Nil, strFrm);
end;

procedure TfrmSelFilImpressao.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not btnConfirma.Enabled Then
  Begin
    If blnImpressorasCadastradas And TCfgRel.VS_SpoolImpressaoCitel Then
      MessageDlg('Selecione um Ponto de Impressão!', mtInformation, [mbOK], 0)
    Else
      MessageDlg('Selecione uma Impressora!', mtInformation, [mbOK], 0);
    Exit;
  End;

  strImpSelecionada := cdsImpressorasnome_impressora.AsString;

  strTipoImpSelecionada := '';

  If Pos('('+ IMP_MATRICIAL + ')', cdsImpressorasnome_impressora_exibir.AsString) > 0 Then
    strTipoImpSelecionada := IMP_MATRICIAL;

  If Pos('('+ IMP_JATO_LASER + ')', cdsImpressorasnome_impressora_exibir.AsString) > 0 Then
    strTipoImpSelecionada := IMP_JATO_LASER;

  If TSpoolImpressaoCitel.PontoNaoImprimir.Equals(cdsImpressorasnome_impressora_exibir.AsString) Then
    strTipoImpSelecionada := IMP_JATO_LASER;

  If TSpoolImpressaoCitel.fGetPontoImpressao(cdsImpressorasnome_impressora_exibir.AsString).ExportacaoPDF Then
    strTipoImpSelecionada := IMP_JATO_LASER;

  If strImpSelecionada.IsEmpty Then
  Begin
    If blnImpressorasCadastradas And TCfgRel.VS_SpoolImpressaoCitel Then
      MessageDlg('Selecione um Ponto de Impressão!', mtInformation, [mbOK], 0)
    Else
      MessageDlg('Selecione uma Impressora!', mtInformation, [mbOK], 0);

    Exit;
  End;

  If blnImpressorasCadastradas And TCfgRel.VS_SpoolImpressaoCitel Then
    If TCfgRel.VerImpressoraONLINE(strImpSelecionada, True) <> 0 Then
      Exit;

  If TCfgRel.fFilaJaExiste(strAutInc, strCodOpe, strNomMaq, strFrm, '', strImpSelecionada) Then
  Begin
    If blnImpressorasCadastradas And TCfgRel.VS_SpoolImpressaoCitel Then
      MessageDlg('O ponto de impressão selecionado já está sendo utilizada por outra fila!', mtInformation, [mbOK], 0)
    Else
      MessageDlg('A impressora selecionada já está sendo utilizada por outra fila!', mtInformation, [mbOK], 0);
    Exit;
  End;

  Close;
end;

procedure TfrmSelFilImpressao.cxgImpressorasEnter(Sender: TObject);
begin
  inherited;
  btnConfirma.Enabled := True;
end;

procedure TfrmSelFilImpressao.cxgImpressorasViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  btnConfirma.Click;
end;

procedure TfrmSelFilImpressao.edtPesquisarChange(Sender: TObject);
begin
  inherited;
  fPesquisar;
end;

procedure TfrmSelFilImpressao.edtPesquisarClick(Sender: TObject);
begin
  inherited;
  edtPesquisarEnter(nil);
end;

procedure TfrmSelFilImpressao.edtPesquisarEnter(Sender: TObject);
begin
  inherited;
  If edtPesquisar.Text = INFO_PESQUISA Then
  Begin
    edtPesquisar.Clear;
    edtPesquisar.Font.Color := clWindowText;
  End;
end;

procedure TfrmSelFilImpressao.edtPesquisarExit(Sender: TObject);
begin
  inherited;
  If TCfgRel.fEmptyStr(edtPesquisar.Text) Then
    pLimparPesquisa;
end;

procedure TfrmSelFilImpressao.edtPesquisarKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  edtPesquisarEnter(nil);
  If (cdsImpressoras.Active And Not cdsImpressoras.IsEmpty) And
     (Key In [VK_DOWN, VK_UP, VK_RETURN]) Then
  Begin
    Case Key Of
      VK_DOWN, VK_RETURN: SelectNext(edtPesquisar, True, True);
    End;
  End;
end;

procedure TfrmSelFilImpressao.edtPesquisarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  edtPesquisarEnter(nil);
end;

function TfrmSelFilImpressao.fGetPrinterIconIndex(Printer: String): Integer;
begin
  Result := 0;
  If UpperCase(TCfgRel.fIdentificarNomeDaImpressora(Printer)).Equals(UpperCase(TCfgRel.fGetImpPadraoWindows)) Then
    Result := 1;
end;

procedure TfrmSelFilImpressao.pCarregarImpressorasCadastradas;
Var
  strFiltro: String;
  strNomeImpressora: String;
  strTipoImpressora: String;
  qryCadImp: TUniQuery;
begin
  inherited;
  cdsImpressoras.CreateDataSet;
  qryCadImp := TCfgRel.fCriaQuery(nil,nil);
  Try
    qryCadImp.SQL.Text := 'SELECT IMP_NOMIMP, IMP_TIPIMP FROM CADIMP ORDER BY 1, 2';
    qryCadImp.Open;

    While Not qryCadImp.Eof Do
    Begin
      strNomeImpressora := qryCadImp.FieldByName('IMP_NOMIMP').AsString;
      strTipoImpressora := qryCadImp.FieldByName('IMP_TIPIMP').AsString;
      strTipoImpressora := IfThen(strTipoImpressora = 'M', IMP_MATRICIAL, IMP_JATO_LASER);
      If strFiltroNomeImpressora.IsEmpty Then
      Begin
        cdsImpressoras.AppendRecord([fGetPrinterIconIndex(strNomeImpressora),
          strNomeImpressora, strNomeImpressora + ' (' + strTipoImpressora + ')',
          TCfgRel.fRemoveAcento(strNomeImpressora)]);
      End
      Else
      Begin
        For strFiltro In strFiltroNomeImpressora.Split(['|']) Do
          If strNomeImpressora.ToLower.Contains(strFiltro.ToLower) Then
          Begin
            cdsImpressoras.AppendRecord([fGetPrinterIconIndex(strNomeImpressora),
              strNomeImpressora, strNomeImpressora + ' (' + strTipoImpressora + ')',
              TCfgRel.fRemoveAcento(strNomeImpressora)]);
            Break;
          End;
      End;
      qryCadImp.Next;
    End;

    if blnOpcaoNaoImprimir then
      cdsImpressoras.AppendRecord([2, TSpoolImpressaoCitel.PontoNaoImprimir, TSpoolImpressaoCitel.PontoNaoImprimir,
        TCfgRel.fRemoveAcento(TSpoolImpressaoCitel.PontoNaoImprimir)]);

    cdsImpressoras.First;
  Finally
    qryCadImp.Free;
  End;
end;

procedure TfrmSelFilImpressao.pCarregarImpressorasInstaladas;
Var
  strFiltro: String;
  strImpressora: String;
begin
  inherited;
  cdsImpressoras.CreateDataSet;
  if (Printer.Printers.Count <= 0) then
    exit;

  Try
    For strImpressora In Printer.Printers Do
      If strFiltroNomeImpressora.IsEmpty Then
      Begin
        cdsImpressoras.AppendRecord([fGetPrinterIconIndex(strImpressora), strImpressora,
          strImpressora, TCfgRel.fRemoveAcento(strImpressora)]);
      End
      Else
      Begin
        For strFiltro In strFiltroNomeImpressora.Split(['|']) Do
          If strImpressora.ToLower.Contains(strFiltro.ToLower) Then
          Begin
            cdsImpressoras.AppendRecord([fGetPrinterIconIndex(strImpressora), strImpressora, strImpressora]);
            Break;
          End;
      End;

    if blnOpcaoNaoImprimir then
      cdsImpressoras.AppendRecord([2, TSpoolImpressaoCitel.PontoNaoImprimir, TSpoolImpressaoCitel.PontoNaoImprimir]);

    cdsImpressoras.First;
  Except
    //do nothing sometimes ocurr access violation
  End;
end;

procedure TfrmSelFilImpressao.pCarregarPontosImpressaoCadastrados;
Var
  intImpIndex: Integer;
  blnPDFLocal: Boolean;
  strFiltro: String;
  LPontoImpressao: TPontoImpressao;
begin
  inherited;
  blnPDFLocal := False;

  Self.Caption := 'Selecione o Ponto de Impressão desejado';
  cxgImpressorasView.OptionsView.NoDataToDisplayInfoText := '<Nenhum ponto de impressão foi encontrado>';

  cdsImpressoras.CreateDataSet;

  For LPontoImpressao In TSpoolImpressaoCitel.fGetPontosImpressao Do
  Begin
    intImpIndex := 0;
    if LPontoImpressao.ExportacaoPDF then
      intImpIndex := 3;
    if LPontoImpressao.ImprimirParaArquivo then
      intImpIndex := 4;
    blnPDFLocal := blnPDFLocal Or (LPontoImpressao.ExportacaoPDF And LPontoImpressao.ExibirSomenteMaquinaServico);
    If strFiltroNomeImpressora.IsEmpty Then
    Begin
      cdsImpressoras.AppendRecord([intImpIndex, LPontoImpressao.NomeFila, LPontoImpressao.NomeFila +
        ' (' + IfThen(LPontoImpressao.TipoImpressora = 'M', IMP_MATRICIAL, IMP_JATO_LASER) + ')',
        TCfgRel.fRemoveAcento(LPontoImpressao.NomeFila)]);
    End
    Else
    Begin
      For strFiltro In strFiltroNomeImpressora.Split(['|']) Do
        If LPontoImpressao.NomeFila.ToLower.Contains(strFiltro.ToLower) Then
        Begin
          cdsImpressoras.AppendRecord([intImpIndex, LPontoImpressao.NomeFila, LPontoImpressao.NomeFila +
            ' (' + IfThen(LPontoImpressao.TipoImpressora = 'M', IMP_MATRICIAL, IMP_JATO_LASER) + ')',
            TCfgRel.fRemoveAcento(LPontoImpressao.NomeFila)]);
          Break;
        End;
    End;
  End;

  if blnOpcaoNaoImprimir then
    cdsImpressoras.AppendRecord([2, TSpoolImpressaoCitel.PontoNaoImprimir, TSpoolImpressaoCitel.PontoNaoImprimir,
      TCfgRel.fRemoveAcento(TSpoolImpressaoCitel.PontoNaoImprimir)]);

  if not blnPDFLocal then
    cdsImpressoras.AppendRecord([3, TSpoolImpressaoCitel.PontoExportarPDF, TSpoolImpressaoCitel.PontoExportarPDF,
      TCfgRel.fRemoveAcento(TSpoolImpressaoCitel.PontoExportarPDF)]);

  cdsImpressoras.First;
end;

procedure TfrmSelFilImpressao.FormCreate(Sender: TObject);
begin
  inherited;
  blnImpressorasCadastradas := False;
  blnOpcaoNaoImprimir       := False;
  strImpSelecionada         := '';
  strTipoImpSelecionada     := '';
  strUltimaFilaUtilizada    := '';
end;

procedure TfrmSelFilImpressao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Shift = ([ssCtrl])) And ((Key = Ord('l')) Or (Key = Ord('L'))) Then
  Begin
    TCfgRel.pSetFocus(edtPesquisar, Self);
  End;

  If (Key = VK_Escape) And (edtPesquisar.Text <> '') And edtPesquisar.Focused Then
  Begin
    Key := 0;
    edtPesquisar.Clear;
  End;

  If (Key = VK_Escape) And TCfgRel.fCheckParent(ActiveControl, cxgImpressoras) Then
  Begin
    Key := 0;
    TCfgRel.pSetFocus(edtPesquisar, Self);
  End;

  If (Key = VK_RETURN) And TCfgRel.fCheckParent(ActiveControl, cxgImpressoras) then
  begin
    Key := 0;
    btnConfirma.Click;
  End;
end;

procedure TfrmSelFilImpressao.FormShow(Sender: TObject);
begin
  inherited;
  If blnImpressorasCadastradas And TCfgRel.VS_SpoolImpressaoCitel Then
    pCarregarPontosImpressaoCadastrados
  Else If blnImpressorasCadastradas And TCfgRel.fCfgSis('CADIMP', VarBoolean) Then
    pCarregarImpressorasCadastradas
  Else
    pCarregarImpressorasInstaladas;

  if not strDesFrm.IsEmpty Then
    Self.Caption := strDesFrm;

  lblNomPro.Caption := strFrm;
  btnConfigurar.Visible := Not strFrm.IsEmpty;

  //ordenar por nome da impressora
  cdsImpressoras.IndexFieldNames := 'nome_impressora_exibir';
  //Posicionar na impressora padrao
  cdsImpressoras.Locate('icone', 1, []);
  //Remover o foco do grid
  TCfgRel.pSetFocus(btnSair, Self);
  //Self.Activecontrol := btnConfirma;
  //Desabilitar o botao, deve selecionar um registro no grid para habilitar novamente
  btnConfirma.Enabled := False;

  chkNaoPerguntar.Visible := False;
  if (TCfgRel.fCfgSis('CADIMP', VarBoolean) or TCfgRel.VS_SpoolImpressaoCitel) then
    chkNaoPerguntar.Visible := strAutInc.IsEmpty And (Not strFrm.IsEmpty) And
      blnImpressorasCadastradas And (Not blnOpcaoNaoImprimir);

  pLimparPesquisa;

  If (Not strUltimaFilaUtilizada.IsEmpty) Then
    cdsImpressoras.Locate('nome_impressora', strUltimaFilaUtilizada, []);

  TCfgRel.pSetFocus(cxgImpressoras, self);
end;

function TfrmSelFilImpressao.fPesquisar: Boolean;
  Var
    strFilter: String;
    strPalavra: String;
    stlPalavras: TStringList;
begin
  inherited;
  strFilter := '';

  stlPalavras := fGetPalavrasPesquisar;

  For strPalavra In stlPalavras Do
  Begin
    If Not TCfgRel.fEmptyStr(strFilter) Then
      strFilter := strFilter + ' AND ';

    strFilter := strFilter + 'UPPER(nome_impressora_pesquisar) LIKE UPPER(' +
      QuotedStr('%' + TCfgRel.fRemoveAcento(strPalavra) + '%') + ')';
  End;

  If TCfgRel.fEmptyStr(strFilter) Then
    strFilter := '1 = 1';

  cdsImpressoras.Filtered := False;
  cdsImpressoras.Filter   := strFilter;
  cdsImpressoras.Filtered := True;

  Result := Not cdsImpressoras.IsEmpty;

  If Result Then
    If Not cdsImpressoras.Locate('icone', 1, []) Then  //1 - impressora padrao
      cdsImpressoras.First;

  FreeAndNil(stlPalavras);
end;

function TfrmSelFilImpressao.fGetPalavrasPesquisar: TStringList;
  Var
    strPalavras: String;
begin
  Result := TStringList.Create;

  strPalavras := Trim(edtPesquisar.Text).Replace(INFO_PESQUISA, EmptyStr);

  While Pos('  ', strPalavras) > 0 Do
    strPalavras := AnsiReplaceStr(strPalavras, '  ', ' ');

  Result.Text := AnsiReplaceStr(strPalavras, ' ', #13#10);
end;

procedure TfrmSelFilImpressao.pLimparPesquisa;
begin
  edtPesquisar.Text       := INFO_PESQUISA;
  edtPesquisar.Font.Color := clGray;
end;

end.
