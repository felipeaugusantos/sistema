unit untDirAcessoTotal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel, cxGrid,
  cxImageComboBox, System.ImageList, Vcl.ImgList, cxContainer, dxGDIPlusClasses,
  cxImage, untTypesSistema, untIGravaDireitoAcesso,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList,
  cxGroupBox;

type
  TfrmDirAcessoTotal = class(TfrmPaiConfirma)
    pnlDirOpe: TPanel;
    pnlDirGpo: TPanel;
    cxgCadOpeLevel1: TcxGridLevel;
    tbvCadOpe: TcxGridDBTableViewCitel;
    cxgCadOpe: TcxGridCitel;
    cxgCadGpo: TcxGridCitel;
    tbvCadGpo: TcxGridDBTableViewCitel;
    cxGridLevel1: TcxGridLevel;
    OPE_CODOPE: TcxGridDBColumn;
    OPE_NOMOPE: TcxGridDBColumn;
    OPE_MARDES: TcxGridDBColumn;
    dtsCadOpe: TDataSource;
    GPO_CODGPO: TcxGridDBColumn;
    GPO_DESCRI: TcxGridDBColumn;
    GPO_MARDES: TcxGridDBColumn;
    dtsCadGpo: TDataSource;
    cxImageList: TcxImageList;
    Panel3: TPanel;
    lblAltGrd: TLabel;
    Label7: TLabel;
    cxImage3: TcxImage;
    Panel1: TPanel;
    btnMarOpe: TBitBtnLocked;
    btnMarOpeTot: TBitBtnLocked;
    btnDesOpeTot: TBitBtnLocked;
    Panel2: TPanel;
    btnMarGru: TBitBtnLocked;
    btnMarGruTot: TBitBtnLocked;
    btnDesGruTot: TBitBtnLocked;
    Panel4: TPanel;
    Panel5: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Styles: TcxStyleRepository;
    cxsFoco: TcxStyle;
    cxsSemFoco: TcxStyle;
    pnlPesqOperador: TPanel;
    Image1: TImage;
    edtPesqOperador: TEdit;
    pnlPesqGrupo: TPanel;
    Image2: TImage;
    edtPesqGrupo: TEdit;
    tmrPesquisar: TTimer;
    Shape1: TShape;
    Shape2: TShape;
    procedure FormShow(Sender: TObject);
    procedure tbvCadOpeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbvCadGpoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDesOpeClick(Sender: TObject);
    procedure btnMarOpeTotClick(Sender: TObject);
    procedure btnDesOpeTotClick(Sender: TObject);
    procedure btnDesGruClick(Sender: TObject);
    procedure btnMarGruTotClick(Sender: TObject);
    procedure btnDesGruTotClick(Sender: TObject);
    procedure btnMarGruClick(Sender: TObject);
    procedure btnMarOpeClick(Sender: TObject);
    procedure tbvCadOpeDblClick(Sender: TObject);
    procedure tbvCadGpoDblClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure tbvCadOpeStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure tmrPesquisarTimer(Sender: TObject);
    procedure edtPesqOperadorChange(Sender: TObject);
    procedure edtPesqOperadorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbvCadOpeCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure tbvCadGpoCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure edtPesqOperadorEnter(Sender: TObject);
    procedure edtPesqOperadorExit(Sender: TObject);
  private
    procedure pAjustaTela;
    procedure pGravar;
  public
    objAceTot: IGravaDireitoAcesso;
    blnMostraGrupo: Boolean;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untHighlightGrid;

Const
  INFO_PESQUISA = 'Ctrl+L Pesquisar';

procedure TfrmDirAcessoTotal.btnConfirmaClick(Sender: TObject);
begin
  If (objAceTot.fTemRegistroSelecionado) Then
    fExecutarModal(pGravar, 'Gravando direitos de acesso, Aguarde ...', '')
  Else
    fMensagem('ATENÇÃO!', 'Nenhum registro foi selecionado.', ['&O k']);
end;

procedure TfrmDirAcessoTotal.btnDesGruClick(Sender: TObject);
begin
  inherited;
  objAceTot.pMarcaDesmarcaGrupo(False);
end;

procedure TfrmDirAcessoTotal.btnDesGruTotClick(Sender: TObject);
begin
  inherited;
  If (pnlDirGpo.Visible) Then
    objAceTot.pMarcaDesmarcaTotalGrupo(False);
end;

procedure TfrmDirAcessoTotal.btnDesOpeClick(Sender: TObject);
begin
  inherited;
  objAceTot.pMarcaDesmarcaOperador(False)
end;

procedure TfrmDirAcessoTotal.btnDesOpeTotClick(Sender: TObject);
begin
  inherited;
  objAceTot.pMarcaDesmarcaTotalOperador(False);
end;

procedure TfrmDirAcessoTotal.btnMarGruClick(Sender: TObject);
begin
  inherited;

  If (objAceTot.getTipoOperacao = tdiAutcomRemocao) Then
  Begin
    If objAceTot.fVerificaSeExisteDireitoDeAcessoVinculadoAoGrupo(objAceTot.getCdsGpo.FieldByName('GPO_CODGPO').AsString) Then
      objAceTot.pMarcaDesmarcaGrupo(objAceTot.getMarcarGpo)
    Else
      pMensagemOk('Não há direito de acesso vinculado ao Grupo!');
  End
  Else
    objAceTot.pMarcaDesmarcaGrupo(objAceTot.getMarcarGpo);
end;

procedure TfrmDirAcessoTotal.btnMarGruTotClick(Sender: TObject);
begin
  inherited;
  If (pnlDirGpo.Visible) Then
    objAceTot.pMarcaDesmarcaTotalGrupo(True);
end;

procedure TfrmDirAcessoTotal.btnMarOpeClick(Sender: TObject);
begin
  inherited;

  If (objAceTot.getTipoOperacao = tdiAutcomRemocao) Then
  Begin
    If objAceTot.fVerificaSeExisteDireitoDeAcessoVinculadoAoOperador(objAceTot.getCdsOpe.FieldByName('OPE_CODOPE').AsString) Then
      objAceTot.pMarcaDesmarcaOperador(objAceTot.getMarcarOpe)
    Else
      pMensagemOk('Não há direito de acesso vinculado ao Operador!');
  End
  Else
    objAceTot.pMarcaDesmarcaOperador(objAceTot.getMarcarOpe);
end;

procedure TfrmDirAcessoTotal.btnMarOpeTotClick(Sender: TObject);
begin
  inherited;
  objAceTot.pMarcaDesmarcaTotalOperador(True);
end;

procedure TfrmDirAcessoTotal.edtPesqOperadorChange(Sender: TObject);
begin
  inherited;
  tmrPesquisar.Enabled := False;
  tmrPesquisar.Enabled := True;
end;

procedure TfrmDirAcessoTotal.edtPesqOperadorEnter(Sender: TObject);
begin
  inherited;
  If TEdit(Sender).Text = INFO_PESQUISA Then
    TEdit(Sender).Clear;
end;

procedure TfrmDirAcessoTotal.edtPesqOperadorExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(TEdit(Sender).Text) Then
    TEdit(Sender).Text := INFO_PESQUISA;
end;

procedure TfrmDirAcessoTotal.edtPesqOperadorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_DOWN, VK_RETURN:
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDirAcessoTotal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F4) Then
    btnMarOpeTot.Click
  Else If (Key = VK_F5) Then
    btnDesOpeTot.Click
  Else If (Key = VK_F7) Then
    btnMarGruTot.Click
  Else If (Key = VK_F8) Then
    btnDesGruTot.Click
  Else If (Key = VK_F10) Then
    btnConfirma.Click
  Else If (Key = VK_F11) And (lblAltGrd.Visible) Then
  Begin
    If (cxgCadOpe.IsFocused) Then
      pSetFocus(cxgCadGpo)
    Else
      pSetFocus(cxgCadOpe);
  End;

end;

procedure TfrmDirAcessoTotal.FormShow(Sender: TObject);
begin
  inherited;
  pAjustaTela;

  dtsCadOpe.DataSet := objAceTot.getCdsOpe;
  dtsCadGpo.DataSet := objAceTot.getCdsGpo;

  dtsCadOpe.DataSet.FieldByName('OPE_CODOPE').Alignment := taCenter;
  dtsCadGpo.DataSet.FieldByName('GPO_CODGPO').Alignment := taCenter;

  If objAceTot.TemPesquisa() Then
  Begin
    objAceTot.SetPesqOperador(edtPesqOperador);
    objAceTot.SetPesqGrupo(edtPesqGrupo);

    edtPesqOperador.Text := INFO_PESQUISA;
    edtPesqGrupo.Text := INFO_PESQUISA;

    pSetFocus(edtPesqOperador);
  End
  Else
  Begin
    pnlPesqOperador.Visible := False;
    pnlPesqGrupo.Visible := False;

    tbvCadOpe.FilterRow.Visible := True;
    tbvCadGpo.FilterRow.Visible := True;

    tbvCadOpe.OptionsView.Header := True;
    tbvCadGpo.OptionsView.Header := True;

    pSetFocus(cxgCadOpe);
  End;
end;

procedure TfrmDirAcessoTotal.pAjustaTela;
begin
  If (Not blnMostraGrupo) Then
  Begin
    pnlDirGpo.Visible := False;
    lblAltGrd.Visible := False;
    Self.Width := Self.Width - pnlDirGpo.Width;
  End;
end;

procedure TfrmDirAcessoTotal.pGravar;
begin
  If (objAceTot.fGravar) Then
      btnSair.Click;
end;

procedure TfrmDirAcessoTotal.tbvCadGpoCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var
  LLista: TStringList;
  LArray: TArray<String>;
  I: Integer;
begin
  inherited;
  If (edtPesqGrupo.Text <> INFO_PESQUISA) And
     (AViewInfo.Item.Index > 0) And objAceTot.TemPesquisa() Then
  Begin
    LLista := fGetPalavras(edtPesqGrupo);
    Try
      SetLength(LArray, LLista.Count);
      For I := 0 To LLista.Count - 1 Do
        LArray[I] := LLista[I];
      pHighlightCxGrid(ACanvas, AViewInfo, LArray);
      ADone := LLista.Count > 0;
    Finally
      FreeAndNil(LLista);
    End;
  End;
end;

procedure TfrmDirAcessoTotal.tbvCadGpoDblClick(Sender: TObject);
begin
  inherited;
  btnMarGru.Click;
end;

procedure TfrmDirAcessoTotal.tbvCadGpoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Or (Key = VK_SPACE) Then
    btnMarGru.Click;

  If objAceTot.TemPesquisa And (Key = VK_UP) Then
    If tbvCadGpo.DataController.RecNo <= 1 Then
      pSetFocus(edtPesqGrupo);

  If (Shift = ([ssCtrl])) And ((Key = Ord('l')) Or (Key = Ord('L'))) Then
  Begin
    If objAceTot.TemPesquisa Then
      pSetFocus(edtPesqGrupo);
  End;
end;

procedure TfrmDirAcessoTotal.tbvCadOpeCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var
  LLista: TStringList;
  LArray: TArray<String>;
  I: Integer;
begin
  inherited;
  If (edtPesqOperador.Text <> INFO_PESQUISA) And
     (AViewInfo.Item.Index > 0) And objAceTot.TemPesquisa() Then
  Begin
    LLista := fGetPalavras(edtPesqOperador);
    Try
      SetLength(LArray, LLista.Count);
      For I := 0 To LLista.Count - 1 Do
        LArray[I] := LLista[I];
      pHighlightCxGrid(ACanvas, AViewInfo, LArray);
      ADone := LLista.Count > 0;
    Finally
      FreeAndNil(LLista);
    End;
  End;
end;

procedure TfrmDirAcessoTotal.tbvCadOpeDblClick(Sender: TObject);
begin
  inherited;
  btnMarOpe.Click;
end;

procedure TfrmDirAcessoTotal.tbvCadOpeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Or (Key = VK_SPACE) Then
    btnMarOpe.Click;

  If objAceTot.TemPesquisa And (Key = VK_UP) Then
    If tbvCadOpe.DataController.RecNo <= 1 Then
      pSetFocus(edtPesqOperador);

  If (Shift = ([ssCtrl])) And ((Key = Ord('l')) Or (Key = Ord('L'))) Then
  Begin
    If objAceTot.TemPesquisa Then
      pSetFocus(edtPesqOperador);
  End;
end;

procedure TfrmDirAcessoTotal.tbvCadOpeStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
  If ARecord.Index = TcxGridDBTableView(Sender).DataController.FocusedRowIndex Then
    AStyle := cxsFoco
  Else
    AStyle := cxsSemFoco
end;

procedure TfrmDirAcessoTotal.tmrPesquisarTimer(Sender: TObject);
begin
  inherited;
  tmrPesquisar.Enabled := False;

  dtsCadOpe.DataSet.Filtered := False;
  dtsCadOpe.DataSet.Filtered := True;

  dtsCadGpo.DataSet.Filtered := False;
  dtsCadGpo.DataSet.Filtered := True;
end;

end.
