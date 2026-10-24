unit untHerancaCadEqu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, EditFocus,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Uni, untTypesSistema, cadastro.Model.EquipamentoLocacao,
  cadastro.Model.AcessorioLocacao, untTypesLocEqu;

type
  TfrmHerancaCadEqu = class(TfrmPaiConfirma)
    lblCodigo: TLabel;
    edtCodEqu: TEditFocus;
    edtDesEqu: TEditFocus;
    procedure edtCodEquKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryCadEqL: TUniQuery;
    arrCadEql: TConsultasArray;
    qryCadAcL: TUniQuery;
    arrCadAcl: TConsultasArray;

    function fCarregarEquipamento(const strCodEql: String): Boolean;
    function fCarregarAcessorio(const strCodAcl: String): Boolean;
    function fHerancaCadEqu: Boolean;
  public
    { Public declarations }
    objHerEqu: THerancaCadEquLoc;
    objHerAce: THerancaCadAceLoc;

    blnConfirma: Boolean;
    tipoEquipamento: TTpEquipamentoLocacao;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure edtCodEquLocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAclLocKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untFuncoesSimples, untConsultas,
  untPnlDadosEquLocacao, untPanelCxInfoEquLocacao,
  untObservacao;

{$R *.dfm}

procedure TfrmHerancaCadEqu.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  blnConfirma := fHerancaCadEqu;

  Close;
end;

procedure TfrmHerancaCadEqu.edtCodEquLocKeyPress(Sender: TObject; var Key: Char);
Var
  objfrmPnl : TPanelCxInfoEquLocacao;
begin
  Try
    objfrmPnl := TPanelCxInfoEquLocacao.Create(TfrmPnlDadosEquLocacao);
    objfrmPnl.strNomForm := self.name;

    If fPesqCadastroEquipLocacao(Self, edtCodEqu, edtDesEqu, qryCadEqL, Key, arrCadEql, False, '', 0, 0, objfrmPnl) Then
    Begin
      If fValidaCampos(edtCodEqu, False) Then
        Self.SelectNext(ActiveControl, True, True);
    End;

  Finally
    FreeAndNil(objfrmPnl);
  End;
end;

procedure TfrmHerancaCadEqu.edtCodAclLocKeyPress(Sender: TObject; var Key: Char);
Begin
  If fPesqAcessorioLocacao(Self, edtCodEqu, edtDesEqu, qryCadAcl, Key, arrCadAcl, False) Then
  Begin
    If fValidaCampos(edtCodEqu, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
End;

procedure TfrmHerancaCadEqu.edtCodEquKeyPress(Sender: TObject; var Key: Char);
Begin
  inherited;

  Case tipoEquipamento Of
    tpPrincipal : edtCodEquLocKeyPress(Sender, Key);
    tpAcessorio : edtCodAclLocKeyPress(Sender, Key);
  End;
End;

function TfrmHerancaCadEqu.fCarregarAcessorio(const strCodAcl: String): Boolean;
var
  objAcl: TEquipamentoLocacaoAcessorio;
begin
  objAcl := TEquipamentoLocacaoAcessorio.Create;
  Try
    objAcl.pCarregaEquipamento('', strCodAcl);
    edtDesEqu.Text := objAcl.Descricao;

    Result := objAcl.fValidaAcessorio(True);

    If Not Result  Then
    Begin
      pCriarFormularios(TfrmObservacao, frmObservacao);
      Try
        frmObservacao.Caption := 'Equipamento ' + objAcl.Codigo + ' - ' + objAcl.Descricao +' com restrições: ';
        frmObservacao.lblMensagem.Visible := False;
        frmObservacao.memObs.Texto := objAcl.Mensagem;
        frmObservacao.memObs.SelStart := 0;
        frmObservacao.ShowModal;

        edtCodEqu.Clear;
        pSetFocus(edtCodEqu);
        Exit;
      Finally
        pFreeAndNil(frmObservacao);
      End;
    End;
  Finally
    FreeAndNil(objAcl);
  End;
end;

function TfrmHerancaCadEqu.fCarregarEquipamento(const strCodEql: String): Boolean;
var
  objEquipamento: TEquipamentoLocacaoPrincipal;
begin
  objEquipamento := TEquipamentoLocacaoPrincipal.Create;
  Try
    objEquipamento.pCarregaEquipamento('', strCodEql);
    edtDesEqu.Text := objEquipamento.Descricao;

    Result := objEquipamento.fValidarEquipamento;

    If Not Result Then
    Begin
      If objEquipamento.TravaInclusao Then
      Begin
        pCriarFormularios(TfrmObservacao, frmObservacao);
        Try
          frmObservacao.Caption := 'Equipamento ' + objEquipamento.Codigo + ' - ' + objEquipamento.Descricao +' com restrições: ';
          frmObservacao.lblMensagem.Visible := False;
          frmObservacao.memObs.Texto := objEquipamento.MensagemTravaInclusao;
          frmObservacao.memObs.SelStart := 0;
          frmObservacao.ShowModal;

          edtCodEqu.Clear;
          pSetFocus(edtCodEqu);
          Exit;
        Finally
          pFreeAndNil(frmObservacao);
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', objEquipamento.Mensagem, ['&O k']);
        Exit;
      End;
    End
  Finally
    FreeAndNil(objEquipamento);
  End;
end;

function TfrmHerancaCadEqu.fHerancaCadEqu: Boolean;
begin
  Try
    Case tipoEquipamento Of
      tpAcessorio : Result := objHerAce.fHerdarCadAceLoc(edtCodEqu.Text)
      Else
        Result := objHerEqu.fHerdarCadEquLoc(edtCodEqu.Text);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmHerancaCadEqu.fHerancaCadEqu]');
    End;
  End;
end;

procedure TfrmHerancaCadEqu.FormCreate(Sender: TObject);
begin
  inherited;

  objHerEqu := THerancaCadEquLoc.Create;
  objHerAce := THerancaCadAceLoc.Create;
end;

procedure TfrmHerancaCadEqu.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(objHerEqu);
  FreeAndNil(objHerAce);
end;

procedure TfrmHerancaCadEqu.FormShow(Sender: TObject);
begin
  inherited;

  Case tipoEquipamento Of
    tpAcessorio   : Self.Caption := 'Herança de Cadastro de Acessório de Equipamento de Locação'
    Else
      Self.Caption := 'Herança de Cadastro de Equipamento de Locação';
  End;
  pSetFocus(edtCodEqu);
end;

function TfrmHerancaCadEqu.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodEqu) Then
    Begin
      If fEmptyStr(edtCodEqu.Text) Then
      Begin
        edtDesEqu.Clear;
      End
      Else
      Begin

        Case tipoEquipamento Of
          tpPrincipal : Result := fCarregarEquipamento(edtCodEqu.Text);
          tpAcessorio : Result := fCarregarAcessorio(edtCodEqu.Text);
        End;

        If Not Result Then
         pSetFocus(edtCodEqu);
      End;
    End
  End;

end;

end.
