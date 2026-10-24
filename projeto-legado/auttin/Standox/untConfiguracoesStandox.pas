unit untConfiguracoesStandox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, FilenameEditFocus, Menus, MaskEditFocus,
  DirectoryEditFocus, StrUtils, AppEvnts, QColorLabel, Uni,
  untIConsultaTinta, untIConfTinta, untConfConsulta,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesStandox = class(TfrmPaiSimples)
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label20: TLabel;
    pnlBotoesConf: TPanel;
    pnlCentral: TPanel;
    chkUsaFor: TCheckBox;
    chkUsaDox: TCheckBox;
    edtTraDox: TEditFocus;
    edtFatDox: TEditFocus;
    Label1: TLabel;
    edtFatCus: TEditFocus;
    Label4: TLabel;
    edtNfmDox: TEditFocus;
    Label13: TLabel;
    ColorLabel4: TColorLabel;
    edtAcuAbs: TEditFocus;
    pnlCabecalho: TPanel;
    tbsConfCampos: TTabSheet;
    edtDtaAtu: TMaskEditFocus;
    lblDtaAtu: TLabel;
    lblVersao: TLabel;
    edtVersao: TEditFocus;
    btnSairConf: TBitBtnLocked;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    lblVendaChroma: TLabel;
    edtProLT: TEditFocus;
    edtDesProLT: TEditFocus;
    lblVendaDuxone: TLabel;
    edtProGL: TEditFocus;
    edtDesProGL: TEditFocus;
    Label6: TLabel;
    edtProDox: TEditFocus;
    edtDesProDox: TEditFocus;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label50: TLabel;
    edtApreve: TEditFocus;
    fraPatDox: TfraDirectoryEditFocus;
    rdgArquivos: TRadioGroup;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairConfClick(Sender: TObject);
    procedure edtProDoxKeyPress(Sender: TObject; var Key: Char);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure edtProLTKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    consulta: IConsultaTinta;
    conf: IConfTinta;
    frmConfConsultaStandox: TfrmConfConsulta;

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pAtualizaVariaveisGlobais;
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
    procedure pRetornaDescricaoItem(edtCodIte: TEdit; pnlPainel: TPanel = Nil);
    procedure pRetornaDescricaoItemEsp(edtCodIte: TEdit; pnlPainel: TPanel = Nil);
    function fGetEdtDescri(edtCod: TEdit): TEdit;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    destructor Destroy; override;
  end;

var
  frmConfiguracoesStandox: TfrmConfiguracoesStandox;

implementation

uses
  untFuncoesSimples, Math, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmConfiguracoesStandox }

procedure TfrmConfiguracoesStandox.pAtualizaVariaveisGlobais;
begin


end;

procedure TfrmConfiguracoesStandox.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA Standox               *}
  {**************************************MV*}

  chkUsaDox.Checked     := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked     := conf.fGetBoolean('USAFOR');
  rdgArquivos.ItemIndex := conf.fGetInteger('DOXARQ');

  edtProDox.Text := conf.fGet('PRODOX');
  edtProLt.Text  := conf.fGet('DOXPLT');
  edtProGl.Text  := conf.fGet('DOXPGL');

  edtDesProLt.Text := fRetNomProduto(edtProLt.Text);
  edtDesProGl.Text := fRetNomProduto(edtProGl.Text);

  edtTraDox.Text    := conf.fGet('TRADOX');
  edtFatDox.Text    := conf.fGet('FATDOX');
  edtFatCus.Text    := conf.fGet('FATCUS');
  fraPatDox.edtDirectory.text    := conf.fGet('PATDOX');
  edtNfmDox.Text    := conf.fGet('NFMDOX');

  edtAcuAbs.Text    := conf.fGet('ACUABS');

  edtDtaAtu.Text := conf.fGet('DTAATU');
  edtVersao.Text := conf.fGet('VERSAO');

  edtDesOpe.Text    := conf.fGet('DESOPE');
  edtApreve.Text    := conf.fGet('APREVE');
end;

function TfrmConfiguracoesStandox.fGetEdtDescri(edtCod: TEdit): TEdit;
var
  strNome: string;
begin
  strNome := edtCod.Name;
  Insert('Des', strNome, 4);
  Result := TEdit(FindComponent(strNome));
end;

procedure TfrmConfiguracoesStandox.pGravaArqIni;

begin
  {*****************************************}
  {* GRAVA DADOS DA Standox                 *}
  {**************************************MV*}
  conf.pSetBoolean('USATIN', chkUsaDox.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);
  conf.pSetInteger('DOXARQ', rdgArquivos.ItemIndex);

  conf.pSet('PRODOX', edtProDox.Text);
  conf.pSet('DOXPLT', edtProLt.Text);
  conf.pSet('DOXPGL', edtProGl.Text);

  conf.pSet('TRADOX', edtTraDox.Text);
  conf.pSet('FATDOX', edtFatDox.Text);
  conf.pSet('FATCUS', edtFatCus.Text);
  conf.pSet('PATDOX', fraPatDox.edtDirectory.text);
  conf.pSet('NFMDOX', edtNfmDox.Text);
  conf.pSet('ACUABS', edtAcuAbs.Text);

  conf.pSet('DTAATU', edtDtaAtu.Text);
  conf.pSet('VERSAO', edtVersao.Text);

  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaStandox.pSalvarConfs;

end;

procedure TfrmConfiguracoesStandox.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin

    If (fMensagem('', 'Confirma dados?', ['&Sim', '&Não']) = 1) Then
    Begin
      pGravaArqIni;
      pAtualizaVariaveisGlobais;
      Close;
    End;

  End;
end;

procedure TfrmConfiguracoesStandox.FormCreate(Sender: TObject);
begin
  inherited;
  consulta := fGetConsultaTinta('DOX');
  conf := fGetConfTinta('DOX');

  conf.pInsereCodigo('USATIN', 'Utilizar esta tinta de maquina', 'S');
  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', 'S');
  conf.pInsereCodigo('PRODOX', 'Produto para venda', '');
  conf.pInsereCodigo('DOXARQ', 'Utilizar os seguintes arquivos', '0');

  conf.pInsereCodigo('DOXPLT', 'Produto embalagem Nason litro', '');
  conf.pInsereCodigo('DOXPGL', 'Produto embalagem Nason galão', '');

  conf.pInsereCodigo('TRADOX', 'Trava de preço', 'VEN');
  conf.pInsereCodigo('FATDOX', 'Fator da trava de preço', '1,00');
  conf.pInsereCodigo('FATCUS', 'Fator da trava de preço de custo', '1,00');
  conf.pInsereCodigo('PATDOX', 'Path para a geração dos arquivos', '');
  conf.pInsereCodigo('NFMDOX', 'Próximo código da novas fórmulas', '1');
  conf.pInsereCodigo('ACUABS', 'Acumulado / Absoluto', '1');

  conf.pInsereCodigo('VERSAO', 'Versão da máquina', '');
  conf.pInsereCodigo('DTAATU', 'Data da Ultima Atualização', '');

  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pCarregaArqIni;
  frmConfConsultaStandox := TfrmConfConsulta.Create(Self, tbsConfCampos, Self.Canvas, consulta);
  pgcDados.ActivePageIndex := 0;
end;

function TfrmConfiguracoesStandox.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtProLt) Or (Sender = edtProGl)  Then
    Begin
      If (fEmptyStr(TEditFocus(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto para venda deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pRetornaDescricaoItemEsp(TEditFocus(Sender), pnlCentral);
        If (fEmptyStr(fGetEdtDescri(TEdit(Sender)).Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA CAMPOS DA Standox               *}
    {**************************************MV*}
    Else If (Sender = edtTraDox) Then
    Begin

      If fEmptyStr(edtTraDox.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If Length(edtTraDox.Text) <> 3 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
        Result := False;
      End
      Else If Pos(edtTraDox.Text, 'VEN_CUS_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtFatCus) Then
    Begin

      If fEmptyStr(edtFatCus.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator para preço de Custo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFatCus.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator para preço de Custo deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtFatDox) Then
    Begin

      If fEmptyStr(edtFatDox.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFatDox.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = fraPatDox) Then
    Begin
      If (fEmptyStr(fraPatDox.edtDirectory.text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O path para arquivo de fórmulas deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin

      End;
    End

    Else If (Sender = edtAcuAbs) Then
    Begin
      if not (Pos(edtAcuAbs.Text, '12') > 0) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Só é permitido as opções 1 ou 2!', ['OK']);
      end;
    End

    Else If (Sender = edtProDox) Then
    Begin
      If (fEmptyStr(edtProDox.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto para venda deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pRetornaDescricaoItem(edtProDox);
        If (fEmptyStr(edtDesProDox.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtDesOpe) Then
    Begin
      If fEmptyStr(edtDesOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtDesOpe.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtApreve) Then
    Begin
      If fEmptyStr(edtApreve.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtApreve.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmConfiguracoesStandox.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

destructor TfrmConfiguracoesStandox.Destroy;
begin
  
  if Assigned(frmConfConsultaStandox) then FreeAndNil(frmConfConsultaStandox);  
  inherited;
end;

procedure TfrmConfiguracoesStandox.edtProDoxKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(fComponentByName(pnlCentral, 'edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesStandox.edtProLTKeyPress(Sender: TObject; var Key: Char);
begin
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(TEdit(Sender), fGetEdtDescri(TEdit(Sender)));
  End;
end;

procedure TfrmConfiguracoesStandox.pConsultaItem(edtItem, edtDesIte: TEdit);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesStandox.pRetornaDescricaoItem(edtCodIte: TEdit; pnlPainel: TPanel = Nil);
var
  strNomEdt: String;
  edtDesIte: TEdit;
begin
  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, 6);
  edtDesIte := TEdit(FindComponent(strNomEdt));

  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesStandox.pRetornaDescricaoItemEsp(edtCodIte: TEdit; pnlPainel: TPanel);
begin
  fGetEdtDescri(edtCodIte).Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesStandox.btnRestaurarClick(Sender: TObject);
begin
  frmConfConsultaStandox.pRestaurarPadrao;
end;

procedure TfrmConfiguracoesStandox.pgcDadosChange(Sender: TObject);
begin
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

end.
