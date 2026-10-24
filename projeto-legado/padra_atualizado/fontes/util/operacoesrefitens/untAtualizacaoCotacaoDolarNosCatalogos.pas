unit untAtualizacaoCotacaoDolarNosCatalogos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.ComCtrls, untTAtualizacaoCotacaoDolarNosCatalogos;

type
  TfrmAtualizacaoCotacaoDolarNosCatalogos = class(TfrmPai)
    gpbRecalcular: TGroupBox;
    rdbMargem: TRadioButton;
    rdbPreVen: TRadioButton;
    pnlProgress: TPanel;
    prgProgress: TProgressBar;
    lblInf: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    lbl1: TLabel;
    edtCodUni: TEditFocus;
    edtDesUni: TEditFocus;
    Label10: TLabel;
    Label4: TLabel;
    rdgSituacao: TRadioGroup;
    btnGravar: TBitBtnLocked;
    Label2: TLabel;
    lblDolar: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniExit(Sender: TObject);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure rdgSituacaoClick(Sender: TObject);
  private
    tsSituacao : TSituacao;
    objAtualizacao: TAtualizacaoCotacaoDolarNosCatalogos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAtualizacaoCotacaoDolarNosCatalogos: TfrmAtualizacaoCotacaoDolarNosCatalogos;

implementation

uses
  untFuncoesConsulta, untFuncoesSimples, untConsultas, untTypesSistema;



{$R *.dfm}

procedure TfrmAtualizacaoCotacaoDolarNosCatalogos.btnGravarClick(
  Sender: TObject);
begin
  inherited;

  If Not objAtualizacao.fCarregar(edtCodFor.Text, edtCodMar.Text, edtCodUni.Text, tsSituacao) Then
  Begin
    pMensagemOk('Sem catálogos para processar.');
    Exit;
  end;
  pnlProgress.Visible := True;
  Try
    If objAtualizacao.fCalcular(IIf(rdbPreVen.Checked, tcPrecoVenda, tcPrecoMargem)) Then
    Begin
      pnlProgress.Visible := False;
      objAtualizacao.pChamaTelaConfirmarCalculo;
    End;
  Finally
    pnlProgress.Visible := False;
  End;
end;

procedure TfrmAtualizacaoCotacaoDolarNosCatalogos.edtCodForExit(
  Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, objAtualizacao.arrLinFor, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmAtualizacaoCotacaoDolarNosCatalogos.edtCodForKeyPress(
  Sender: TObject; var Key: Char);
begin
  Inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, objAtualizacao.arrLinFor, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAtualizacaoCotacaoDolarNosCatalogos.edtCodMarExit(
  Sender: TObject);
begin
  pEdtCodSelectExit(edtCodMar, edtDesMar ,objAtualizacao.arrLinMar, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmAtualizacaoCotacaoDolarNosCatalogos.edtCodMarKeyPress(
  Sender: TObject; var Key: Char);
begin
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, objAtualizacao.arrLinMar, False) Then
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAtualizacaoCotacaoDolarNosCatalogos.edtCodUniExit(
  Sender: TObject);
begin
  pEdtCodSelectExit(edtCodUni, edtDesUni ,objAtualizacao.arrLinUni, fRetNomUnidade, nil, 'da Unidade');
end;

procedure TfrmAtualizacaoCotacaoDolarNosCatalogos.edtCodUniKeyPress(
  Sender: TObject; var Key: Char);
begin
  If fPesqUnidade(Self, edtCodUni, edtDesUni, nil, nil, Key, objAtualizacao.arrLinUni) Then
    If fValidaCampos(edtCodUni, False) Then
      Self.SelectNext(ActiveControl, True, True);

end;

procedure TfrmAtualizacaoCotacaoDolarNosCatalogos.FormCreate(Sender: TObject);
begin
  inherited;
  objAtualizacao := TAtualizacaoCotacaoDolarNosCatalogos.Create();
  lblDolar.Caption := FormatFloat('#0.0000', objAtualizacao.ValorDolar);
  tsSituacao := stTodos;
  pSetFocus(edtCodFor);

end;

procedure TfrmAtualizacaoCotacaoDolarNosCatalogos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objAtualizacao);
  inherited;

end;

procedure TfrmAtualizacaoCotacaoDolarNosCatalogos.rdgSituacaoClick(
  Sender: TObject);
begin
  inherited;
  case rdgSituacao.ItemIndex of
    0: tsSituacao := stAtivo;
    1: tsSituacao := stInativo;
  Else
    tsSituacao := stTodos;
  End;


end;

end.
