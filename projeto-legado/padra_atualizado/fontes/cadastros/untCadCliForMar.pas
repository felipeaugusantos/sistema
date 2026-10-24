unit untCadCliForMar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Vcl.ExtCtrls, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Vcl.StdCtrls,
  EditFocus, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, Datasnap.DBClient, UniClientDataSet;

type
  TfrmCadCliForMar = class(TfrmPai)
    pnlMarca: TPanel;
    Panel1: TPanel;
    lbDesMar: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    btnAddMarca: TBitBtnLocked;
    btnCancelarMarca: TBitBtnLocked;
    grdMarca: TcxGridCitel;
    grdMarcaTv: TcxGridDBTableViewCitel;
    grdMarcaLvl: TcxGridLevel;
    pnlFornecedor: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtCodFor: TEditFocus;
    edtDesFor: TEditFocus;
    grdFornecedor: TcxGridCitel;
    grdFornecedorTv: TcxGridDBTableViewCitel;
    grdFornecedorLvl: TcxGridLevel;
    Splitter1: TSplitter;
    btnAddFornecedor: TBitBtnLocked;
    btnCancelarFornecedor: TBitBtnLocked;
    cdsCliFNP: TUniClientDataSet;
    cdsCliMNP: TUniClientDataSet;
    dtsCliFNP: TDataSource;
    dtsCliMNP: TDataSource;
    pnlCabecalho: TPanel;
    lblCliFor: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    btnConfirma: TBitBtnLocked;
    grdFornecedorTvCODFOR: TcxGridDBColumn;
    grdFornecedorTvNOMFOR: TcxGridDBColumn;
    grdMarcaTvCODMAR: TcxGridDBColumn;
    grdMarcaTvDESMAR: TcxGridDBColumn;
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddFornecedorClick(Sender: TObject);
    procedure btnAddMarcaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelarFornecedorClick(Sender: TObject);
    procedure grdFornecedorTvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdMarcaTvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelarMarcaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure pAddFornecedor;
    procedure pAddMarca;
  public
    { Public declarations }
    procedure pDesativarControles;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas, untGravando;

{$R *.dfm}

procedure TfrmCadCliForMar.btnAddFornecedorClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pAddFornecedor, 'Aguarde, inserindo fornecedor', '');
end;

procedure TfrmCadCliForMar.btnAddMarcaClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pAddMarca, 'Aguarde, inserindo marca', '');
end;

procedure TfrmCadCliForMar.btnCancelarFornecedorClick(Sender: TObject);
begin
  inherited;
  edtCodFor.Clear;
  edtDesFor.Clear;
  pSetFocus(edtCodFor);
end;

procedure TfrmCadCliForMar.btnCancelarMarcaClick(Sender: TObject);
begin
  inherited;
  edtCodMar.Clear;
  edtDesMar.Clear;
  pSetFocus(edtCodMar);
end;

procedure TfrmCadCliForMar.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (Not btnConfirma.Enabled) Then
    Exit;

  Close;
  ModalResult := mrOk;
end;

procedure TfrmCadCliForMar.edtCodForKeyPress(Sender: TObject; var Key: Char);
Var
  arrFornec: TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadCliForMar.edtCodMarKeyPress(Sender: TObject; var Key: Char);
Var
  arrMarca : TConsultasArray;
begin
  inherited;

  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadCliForMar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
  Begin
    btnConfirma.Click;
    Key := 0;
  End;
end;

function TfrmCadCliForMar.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodMar) and blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtCodMar.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Marca deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtDesMar.Text := fRetNomMarca(edtCodMar.Text);
        If fEmptyStr(edtDesMar.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Marca não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End;

    If (Sender = edtCodFor) and blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fornecedor deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtDesFor.Text := fRetNomFornecedor(edtCodFor.Text);
        If fEmptyStr(edtDesFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;


procedure TfrmCadCliForMar.grdFornecedorTvKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
  Begin
    If pnlCabecalho.Enabled And (not cdsCliFNP.IsEmpty) Then
      cdsCliFNP.Delete;
  End;
end;

procedure TfrmCadCliForMar.grdMarcaTvKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
  Begin
    If pnlCabecalho.Enabled And (not cdsCliMNP.IsEmpty) Then
      cdsCliMNP.Delete;
  End;
end;

procedure TfrmCadCliForMar.pAddFornecedor;
begin
  If not (fValidaCampos(edtCodFor, True)) Then
    Exit;

  If cdsCliFNP.Locate('FNP_CODFOR', edtCodFor.Text, []) Then
  Begin
    fMensagem('', 'Fornecedor já informado!', ['&Ok']);
    pSetFocus(edtCodFor);
    Exit;
  End;

  If Not fEmptyStr(fCampoTabela('AUTOINCREM', 'CLIVEN', ['CVE_CODCLI', 'CVE_CODFOR'], [edtCodCli.Text, edtCodFor.Text])) Then
  Begin
    fMensagem('', 'Fornecedor já informado na rotina de Vendedores do Cliente! Não é possível incluir na lista de Fornecedores não permitidos!', ['&Ok']);
    pSetFocus(edtCodFor);
    Exit;
  End;

  cdsCliFNP.Append;
  cdsCliFNP.FieldByName('FNP_CODCLI').AsString := edtCodCli.Text;
  cdsCliFNP.FieldByName('FNP_CODFOR').AsString := edtCodFor.Text;
  cdsCliFNP.FieldByName('FOR_NOMFOR').AsString := edtDesFor.Text;
  cdsCliFNP.Post;

  btnCancelarFornecedor.Click;
end;

procedure TfrmCadCliForMar.pAddMarca;
begin
  If not (fValidaCampos(edtCodMar, True)) Then
    Exit;

  If cdsCliMNP.Locate('MNP_CODMAR', edtCodMar.Text, []) Then
  Begin
    fMensagem('', 'Marca já informada!', ['&Ok']);
    pSetFocus(edtCodMar);
    Exit;
  End;

  If Not fEmptyStr(fCampoTabela('AUTOINCREM', 'CLIVEN', ['CVE_CODCLI', 'CVE_CODMAR'], [edtCodCli.Text, edtCodMar.Text])) Then
  Begin
    fMensagem('', 'Marca já informada na rotina de Vendedores do Cliente! Não é possível incluir na lista de Marcas não permitidas!', ['&Ok']);
    pSetFocus(edtCodMar);
    Exit;
  End;

  cdsCliMNP.Append;
  cdsCliMNP.FieldByName('MNP_CODCLI').AsString := edtCodCli.Text;
  cdsCliMNP.FieldByName('MNP_CODMAR').AsString := edtCodMar.Text;
  cdsCliMNP.FieldByName('MAR_DESMAR').AsString := edtDesMar.Text;
  cdsCliMNP.Post;

  btnCancelarMarca.Click;
end;

procedure TfrmCadCliForMar.pDesativarControles;
begin
  pSetFocus(btnSair);
  btnAddMarca.Enabled           := False;
  btnCancelarMarca.Enabled      := False;
  btnAddFornecedor.Enabled      := False;
  btnCancelarFornecedor.Enabled := False;
  pnlCabecalho.Enabled          := False;
  pnlFornecedor.Enabled         := False;
  pnlMarca.Enabled              := False;
  btnConfirma.Enabled           := False;
end;

end.
