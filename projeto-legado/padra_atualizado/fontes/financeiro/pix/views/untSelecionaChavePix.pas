unit untSelecionaChavePix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, ComboBoxFocus,
  untFrameGerarPixBoleto, Data.DB;

type
  TfrmSelecionaChavePix = class(TfrmPaiConfirma)
    grpDadosChavePix: TGroupBox;
    lblDadosChavePix: TLabel;
    pnlChavePixCadastrada: TPanel;
    pnlChavePixNaoCadastrada: TPanel;
    chkChavePix: TCheckBox;
    lblTipoPix: TLabel;
    cmbTipoDoPix: TComboBoxFocus;
    lblChave: TLabel;
    edtCPFCNPJPix: TEditFocus;
    edtChavePix: TEditFocus;
    fraGerarPixBoleto: TfraGerarPixBoleto;
    procedure chkChavePixClick(Sender: TObject);
    procedure cmbTipoDoPixChange(Sender: TObject);
    procedure edtCPFCNPJPixEnter(Sender: TObject);
    procedure edtCPFCNPJPixExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fraGerarPixBoletocmbChavePixPropertiesEditValueChanged(
      Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    FCodigoBanco,
    FTipoDocumentoAnterior,

    FAutoIncremChavePix,
    FChavePix,
    FEmpresaChavePix: String;
    { Private declarations }
  public
    { Public declarations }
    property CodigoBanco: String read FCodigoBanco write FCodigoBanco;

    property AutoIncremChavePix: String read FAutoIncremChavePix;
    property ChavePix: String read FChavePix;
    property EmpresaChavePix: String read FEmpresaChavePix;
  end;

implementation
Uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmSelecionaChavePix.btnConfirmaClick(Sender: TObject);
  Var
    LDataset: TDataset;
begin
  If chkChavePix.Checked Then
  Begin
    If fraGerarPixBoleto.cmbChavePix.ItemIndex = -1 Then
    Begin
      fMensagem('ATENÇÃO', 'É necessário selecionar uma chave Pix para continuar.', ['&Ok']);
      ModalResult := mrNone;
      Exit;
    End;
  End
  Else
  Begin
    If fEmptyStr(edtChavePix.Text) Then
    Begin
      fMensagem('ATENÇÃO', 'É necessário digitar uma chave Pix para continuar.', ['&Ok']);
      ModalResult := mrNone;
      Exit;
    End;
  End;

  inherited;

  FChavePix := edtChavePix.Text;
  FEmpresaChavePix := VS_strCodEmp;
  If chkChavePix.Checked Then
  Begin
    LDataset := fraGerarPixBoleto.cmbChavePix.Properties.ListSource.Dataset;

    FAutoIncremChavePix := LDataset.FieldByName('AUTOINCREM').AsString;
    FChavePix := LDataset.FieldByName('PIX_CHAVE_').AsString;
    FEmpresaChavePix := LDataset.FieldByName('CCA_CODEMP').AsString;
  End;

  ModalResult := mrOk;
end;

procedure TfrmSelecionaChavePix.btnSairClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmSelecionaChavePix.chkChavePixClick(Sender: TObject);
begin
  inherited;
  pnlChavePixCadastrada.Visible := chkChavePix.Checked;
  pnlChavePixNaoCadastrada.Visible := Not chkChavePix.Checked;

  pnlChavePixCadastrada.SetBounds(8, 8, pnlChavePixCadastrada.Width, pnlChavePixCadastrada.Height);
  pnlChavePixNaoCadastrada.SetBounds(8, 8, pnlChavePixNaoCadastrada.Width, pnlChavePixNaoCadastrada.Height);

  fraGerarPixBoleto.cmbChavePix.ItemIndex := -1;
  lblDadosChavePix.Caption := 'Banco: ' + FCodigoBanco + '-' + untFuncoesSimples.fRetNomBanco(FCodigoBanco);
end;

procedure TfrmSelecionaChavePix.cmbTipoDoPixChange(Sender: TObject);
begin
  inherited;
  edtCPFCNPJPix.Visible := False;
  edtChavePix.Clear;
  edtChavePix.TipoTexto := ttAlfaNumerico;

  Case cmbTipoDoPix.ItemIndex Of
    1: edtChavePix.MaxLength := 15;
    2: edtChavePix.MaxLength := 60;
    3: edtChavePix.MaxLength := 36;
    0:
    Begin
      edtCPFCNPJPix.Visible := True;
      If edtCPFCNPJPix.Text = '' Then
        edtCPFCNPJPix.Text := '1';

      edtChavePix.MaxLength := 14;
      If edtCPFCNPJPix.Text = '2' Then
        edtChavePix.MaxLength := 11;
    End;
  End;

  If cmbTipoDoPix.ItemIndex in [0] Then
    edtChavePix.TipoTexto := ttInteiro;
end;

procedure TfrmSelecionaChavePix.edtCPFCNPJPixEnter(Sender: TObject);
begin
  inherited;
  FTipoDocumentoAnterior := edtCPFCNPJPix.Text;
end;

procedure TfrmSelecionaChavePix.edtCPFCNPJPixExit(Sender: TObject);
begin
  inherited;
  If Not FTipoDocumentoAnterior.Equals(edtCPFCNPJPix.Text) Then
    cmbTipoDoPix.OnChange(cmbTipoDoPix);
end;

procedure TfrmSelecionaChavePix.FormCreate(Sender: TObject);
begin
  inherited;
  FAutoIncremChavePix := EmptyStr;
  FChavePix := EmptyStr;
  FEmpresaChavePix := EmptyStr;
end;

procedure TfrmSelecionaChavePix.FormShow(Sender: TObject);
begin
  inherited;
  chkChavePix.OnClick(chkChavePix);
  fraGerarPixBoleto.CarregarChavesPix(FCodigoBanco);
  fraGerarPixBoleto.edtGerarPix.OnChange(fraGerarPixBoleto.edtGerarPix);
end;

procedure TfrmSelecionaChavePix.fraGerarPixBoletocmbChavePixPropertiesEditValueChanged(
  Sender: TObject);
  Var
    LDataset: TDataset;
begin
  inherited;
  If fraGerarPixBoleto.cmbChavePix.ItemIndex = -1 Then
    Exit;

  LDataset := fraGerarPixBoleto.cmbChavePix.Properties.ListSource.Dataset;

  lblDadosChavePix.Caption := 'Banco: ' + FCodigoBanco + '-' + untFuncoesSimples.fRetNomBanco(FCodigoBanco) + #13 + #13 +
                              'Chave Pix: ' +  LDataset.FieldByName('CHAVE').AsString + #13 +
                              'Agência: ' + LDataset.FieldByName('CCA_AGENCI').AsString + #13 +
                              'Conta: ' + LDataset.FieldByName('CCA_CODCTA').AsString + '-' +
                                          LDataset.FieldByName('CCA_DIGCTA').AsString;
end;

end.
