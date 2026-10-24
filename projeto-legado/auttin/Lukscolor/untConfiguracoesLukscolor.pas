unit untConfiguracoesLukscolor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, FilenameEditFocus, Menus, MaskEditFocus,
  DirectoryEditFocus, AppEvnts, Uni, Math,
  untIConfTinta, untConfConsulta, untIConsultaTinta, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesLukscolor = class(TfrmPaiSimples)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label20: TLabel;
    chkUsaLks: TCheckBox;
    edtTraLks: TEditFocus;
    edtFatLks: TEditFocus;
    edtNfmLks: TEditFocus;
    pnlBotoesConf: TPanel;
    pnlFundo: TPanel;
    chkUsaFor: TCheckBox;
    Label1: TLabel;
    edtFatCalc: TEditFocus;
    Label6: TLabel;
    edtCodIte: TEdit;
    edtDesIte: TEditFocus;
    chkPrism: TCheckBox;
    Label7: TLabel;
    tbsConfCampos: TTabSheet;
    pnlCabecalho: TPanel;
    edtDtaAtu: TMaskEditFocus;
    lblDtaAtu: TLabel;
    lblVersao: TLabel;
    edtVersao: TEditFocus;
    btnSairConf: TBitBtnLocked;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label8: TLabel;
    edtDesOpe: TEditFocus;
    Label50: TLabel;
    edtApreve: TEditFocus;
    edtPatLks: TfraDirectoryEditFocus;
    edtPatPri: TFilenameEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairConfClick(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
  private
    { Private declarations }
    frmConfConsultaLukscolor: TfrmConfConsulta;
    tinta: IConsultaTinta;
    conf: IConfTinta;
    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pAtualizaVariaveisGlobais;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    procedure pCarregaItem;
    procedure pPesquisaCadIte(qryTabOri, qryTabela: TUniQuery; strCodIte: String; blnBuscaCodBar: Boolean = False; blnBuscaCodFab: Boolean = False);
    destructor Destroy; override;
  end;

var
  frmConfiguracoesLukscolor: TfrmConfiguracoesLukscolor;

implementation

uses  untFuncoesSimples,
  untPesqAux, StrUtils, untFuncTinta, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmConfiguracoesLukscolor }

procedure TfrmConfiguracoesLukscolor.pAtualizaVariaveisGlobais;
begin

end;

procedure TfrmConfiguracoesLukscolor.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA Lukscolor              *}
  {**************************************MV*}
  conf := fGetConfTinta('LKS');

  chkUsaLks.Checked := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
  edtTraLks.Text    := conf.fGet('TRALKS');
  edtFatLks.Text    := conf.fGet('FATLKS');
  edtNfmLks.Text    := conf.fGet('NFMLKS');
  edtPatLks.Text    := conf.fGet('PATLKS');
  edtFatCalc.Text   := conf.fGet('FATCALC');
  edtCodIte.Text    := conf.fGet('CODITE');
  edtDesIte.Text    := conf.fGet('DESITE');
  chkPrism.Checked := conf.fGetBoolean('LKSPRI');
  edtPatPri.Text := conf.fGet('PATPRI');

  edtDtaAtu.Text := conf.fGet('DTAATU');
  edtVersao.Text := conf.fGet('VERSAO');
  edtDesOpe.Text := conf.fGet('DESOPE');
  edtApreve.Text := conf.fGet('APREVE');
end;

procedure TfrmConfiguracoesLukscolor.pGravaArqIni;
begin
  conf.pSetBoolean('USATIN', chkUsaLks.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);
  conf.pSet('TRALKS', edtTraLks.Text);
  conf.pSet('FATLKS', edtFatLks.Text);
  conf.pSet('NFMLKS', edtNfmLks.Text);
  conf.pSet('PATLKS', edtPatLks.Text);
  conf.pSet('FATCALC', edtFatCalc.Text);
  conf.pSet('CODITE', edtCodIte.Text);
  conf.pSet('DESITE', edtDesIte.Text);
  conf.pSetBoolean('LKSPRI', chkPrism.Checked);
  conf.pSet('PATPRI', edtPatPri.Text);

  conf.pSet('DTAATU', edtDtaAtu.Text);
  conf.pSet('VERSAO', edtVersao.Text);
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaLukscolor.pSalvarConfs;
end;

procedure TfrmConfiguracoesLukscolor.btnGravarConfClick(Sender: TObject);
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

procedure TfrmConfiguracoesLukscolor.FormCreate(Sender: TObject);
begin
  inherited;

  conf := fGetConfTinta('LKS');
  tinta := fGetConsultaTinta('LKS');

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', 'S');
  conf.pInsereCodigo('USAFOR', 'Utilizar Formulação', 'S');
  conf.pInsereCodigo('PATLKS', 'Path para os arquivos', '');
  conf.pInsereCodigo('NFMLKS', 'Próximo Código Nova Fórmulas', '1');
  conf.pInsereCodigo('TRALKS', 'Trava de Preço', 'VEN');
  conf.pInsereCodigo('FATLKS', 'Fator da Trava', '1,00');
  conf.pInsereCodigo('FATCALC', 'Fator de Calculo de Preço de Custo', '1,00');
  conf.pInsereCodigo('CODITE', 'Código do Produto Base', '');
  conf.pInsereCodigo('LKSPRI', 'Sistema Prisma', 'N');
  conf.pInsereCodigo('PATPRI', 'Path Prisma', '');

  conf.pInsereCodigo('VERSAO', 'Versão da máquina', '');
  conf.pInsereCodigo('DTAATU', 'Data da Ultima Atualização', '');
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  frmConfConsultaLukscolor := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
  pCarregaArqIni;
  pgcDados.ActivePageIndex := 0;

  edtPatPri.Dialog.Dialog.Filter := 'LucksColor (*.mdb)|*.mdb';
end;

function TfrmConfiguracoesLukscolor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA CAMPOS DA Lukscolor            *}
    {**************************************MV*}
    If (Sender = edtTraLks) Then
    Begin

      If fEmptyStr(edtTraLks.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If Length(edtTraLks.Text) <> 3 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
        Result := False;
      End
      Else If Pos(edtTraLks.Text, 'VEN_CUS_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtFatLks) Then
    Begin

      If fEmptyStr(edtFatLks.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFatLks.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtFatCalc) Then
    Begin

      If fEmptyStr(edtFatCalc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator de cálculo de preço de custo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFatCalc.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator de cálculo de preço de custo deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtNfmLks) Then
    Begin

      If (fEmptyStr(edtNfmLks.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O próximo código de novas fórmulas deve ser preenchido!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtPatPri) And (chkPrism.Checked) Then
    Begin
      If Not (fEmptyStr(edtPatPri.Text)) Then
      Begin
        edtPatPri.Text := AnsiReplaceStr(edtPatPri.Text, '"', '');
        If Not FileExists(edtPatPri.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'O arquivo de fórmulas Prisma não existe!', ['OK']);
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
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmConfiguracoesLukscolor.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmConfiguracoesLukscolor.pCarregaItem;
begin
  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesLukscolor.pPesquisaCadIte(qryTabOri,
  qryTabela: TUniQuery; strCodIte: String; blnBuscaCodBar,
  blnBuscaCodFab: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  I.* ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '                     AND G.ITE_CODEMP = :CODEMP      ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  I.ITE_ITEATI = "S" AND ';

  If Not (fCfgSis('EXILIS', varBoolean)) Then
  Begin
    strSQL := strSQL + '  G.ITE_IMPLIS = "S" AND ';
  End;

  If blnBuscaCodBar Then
    strSQL := strSQL + '  I.ITE_CODBAR = :CODITE '
  Else If blnBuscaCodFab Then
    strSQL := strSQL + '  I.ITE_CODFAB = :CODITE '
  Else
    strSQL := strSQL + '  I.ITE_CODITE = :CODITE ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := vs_strCodEmp;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;


procedure TfrmConfiguracoesLukscolor.edtCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
End;

destructor TfrmConfiguracoesLukscolor.Destroy;
begin
  if Assigned(frmConfConsultaLukscolor) then FreeAndNil(frmConfConsultaLukscolor);
  inherited;
end;

procedure TfrmConfiguracoesLukscolor.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaLukscolor.pRestaurarPadrao;
end;

procedure TfrmConfiguracoesLukscolor.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesLukscolor.ApplicationEventsMessage(
  var Msg: tagMSG; var Handled: Boolean);
begin
  inherited;
  If Msg.message = WM_KEYFIRST Then
    If Msg.wParam = 27 then
      btnSair.Click;
end;

end.
