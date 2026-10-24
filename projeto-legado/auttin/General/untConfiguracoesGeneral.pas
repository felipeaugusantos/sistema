unit untConfiguracoesGeneral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, AppEvnts, Menus, Buttons, ExtCtrls, Mask,
  FilenameEditFocus, EditFocus, Uni, StrUtils, ComCtrls,
  untIConsultaTinta, untIConfTinta, untConfConsulta,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmConfiguracoesGeneral = class(TfrmPai)
    pnlCabecalho: TPanel;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    tbsConfCampos: TTabSheet;
    lblPath: TLabel;
    lblTrava: TLabel;
    lblFator: TLabel;
    lblProximoCodigo: TLabel;
    grpProdutos: TGroupBox;
    lblLitro: TLabel;
    lblGalao: TLabel;
    lblCopo: TLabel;
    lblSpray: TLabel;
    edtLitro: TEditFocus;
    edtDesLitro: TEditFocus;
    edtDesGalao: TEditFocus;
    edtGalao: TEditFocus;
    edtDesCopo: TEditFocus;
    edtCopo: TEditFocus;
    edtDesSpray: TEditFocus;
    edtSpray: TEditFocus;
    chkUsaTin: TCheckBox;
    edtCampoTrava: TEditFocus;
    edtFator: TEditFocus;
    edtProCodNfm: TEditFocus;
    grpProdVen: TGroupBox;
    edtProGen: TEditFocus;
    edtProGenVen: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    edtPath: TFilenameEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtLitroKeyPress(Sender: TObject; var Key: Char);
    procedure edtGalaoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCopoKeyPress(Sender: TObject; var Key: Char);
    procedure edtSprayKeyPress(Sender: TObject; var Key: Char);
    procedure edtProGenKeyPress(Sender: TObject; var Key: Char);
    procedure pgcDadosChange(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
  private
    { Private declarations }

    consulta: IConsultaTinta;
    conf: IConfTinta;
    frmConfConsultaGeneral: TfrmConfConsulta;

    procedure pCarregarConfiguracoes;
    procedure pSalvarConfiguracoes;
    procedure pCarregarIte(edtCodIte, edtDesIte: TEdit);
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
  protected
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesGeneral: TfrmConfiguracoesGeneral;

implementation

uses untFuncoesSimples, untFuncTinta, DB, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmConfiguracoesGeneral }

procedure TfrmConfiguracoesGeneral.pCarregarConfiguracoes;
begin
{
  edtLitro.Text := fArqIniTinta(0, 'GENERAL', 'GENLIT', '');
  edtGalao.Text := fArqIniTinta(0, 'GENERAL', 'GENGAL', '');
  edtCopo.Text := fArqIniTinta(0, 'GENERAL', 'GENCOP', '');
  edtSpray.Text := fArqIniTinta(0, 'GENERAL', 'GENSPR', '');

  edtPath.Text := fArqIniTinta(0, 'GENERAL', 'GENPAT', '');
  edtCampoTrava.Text := fArqIniTinta(0, 'GENERAL', 'GENTRV', '');
  edtFator.Text := fArqIniTinta(0, 'GENERAL', 'GENFAT', '');
  edtProCodNfm.Text := fArqIniTinta(0, 'GENERAL', 'GENNFM', '');
  edtProGen.Text := fArqIniTinta(0, 'GENERAL', 'GENPRO', '');

  chkUsaTin.Checked := fArqIniTinta(0, 'GENERAL', 'USATIN', 'N') = 'S';
}

  edtLitro.Text := conf.fGet('GENLIT'); //fArqIniTinta(0, 'GENERAL', 'GENLIT', '');
  edtGalao.Text := conf.fGet('GENGAL'); //fArqIniTinta(0, 'GENERAL', 'GENGAL', '');
  edtCopo.Text  := conf.fGet('GENCOP'); //fArqIniTinta(0, 'GENERAL', 'GENCOP', '');
  edtSpray.Text := conf.fGet('GENSPR'); //fArqIniTinta(0, 'GENERAL', 'GENSPR', '');

  edtPath.Text       := conf.fGet('GENPAT'); //fArqIniTinta(0, 'GENERAL', 'GENPAT', '');
  edtCampoTrava.Text := conf.fGet('GENTRV'); //fArqIniTinta(0, 'GENERAL', 'GENTRV', '');
  edtFator.Text      := conf.fGet('GENFAT'); //fArqIniTinta(0, 'GENERAL', 'GENFAT', '');
  edtProCodNfm.Text  := conf.fGet('GENNFM'); //fArqIniTinta(0, 'GENERAL', 'GENNFM', '');
  edtProGen.Text     := conf.fGet('GENPRO'); //fArqIniTinta(0, 'GENERAL', 'GENPRO', '');

  chkUsaTin.Checked  := conf.fGetBoolean('USATIN'); //fArqIniTinta(0, 'GENERAL', 'USATIN', 'N') = 'S';

  pCarregarIte(edtLitro, edtDesLitro);
  pCarregarIte(edtGalao, edtDesGalao);
  pCarregarIte(edtCopo, edtDesCopo);
  pCarregarIte(edtSpray, edtDesSpray);
  pCarregarIte(edtProGen, edtProGenVen);

end;

procedure TfrmConfiguracoesGeneral.pSalvarConfiguracoes;
begin
{
  fArqIniTinta(1, 'GENERAL', 'GENLIT', edtLitro.Text);
  fArqIniTinta(1, 'GENERAL', 'GENGAL', edtGalao.Text);
  fArqIniTinta(1, 'GENERAL', 'GENCOP', edtCopo.Text);
  fArqIniTinta(1, 'GENERAL', 'GENSPR', edtSpray.Text);

  fArqIniTinta(1, 'GENERAL', 'GENPAT', edtPath.Text);
  fArqIniTinta(1, 'GENERAL', 'GENTRV', edtCampoTrava.Text);
  fArqIniTinta(1, 'GENERAL', 'GENFAT', edtFator.Text);
  fArqIniTinta(1, 'GENERAL', 'GENNFM', edtProCodNfm.Text);

  fArqIniTinta(1, 'GENERAL', 'USATIN', IfThen(chkUsaTin.Checked, 'S', 'N'));

  fArqIniTinta(1, 'GENERAL', 'GENPRO', edtProGen.Text);
}
  conf.pSet('GENLIT', edtLitro.Text); //fArqIniTinta(1, 'GENERAL', 'GENLIT', edtLitro.Text);
  conf.pSet('GENGAL', edtGalao.Text); //fArqIniTinta(1, 'GENERAL', 'GENGAL', edtGalao.Text);
  conf.pSet('GENCOP', edtCopo.Text);  //fArqIniTinta(1, 'GENERAL', 'GENCOP', edtCopo.Text);
  conf.pSet('GENSPR', edtSpray.Text);  //fArqIniTinta(1, 'GENERAL', 'GENSPR', edtSpray.Text);

  conf.pSet('GENPAT', edtPath.Text);  //fArqIniTinta(1, 'GENERAL', 'GENPAT', edtPath.Text);
  conf.pSet('GENTRV', edtCampoTrava.Text);  //fArqIniTinta(1, 'GENERAL', 'GENTRV', edtCampoTrava.Text);
  conf.pSet('GENFAT', edtFator.Text);  //fArqIniTinta(1, 'GENERAL', 'GENFAT', edtFator.Text);
  conf.pSet('GENNFM', edtProCodNfm.Text);  //fArqIniTinta(1, 'GENERAL', 'GENNFM', edtProCodNfm.Text);

  conf.pSetBoolean('USATIN', chkUsaTin.Checked); //fArqIniTinta(1, 'GENERAL', 'USATIN', IfThen(chkUsaTin.Checked, 'S', 'N'));

  conf.pSet('GENPRO', edtProGen.Text); //fArqIniTinta(1, 'GENERAL', 'GENPRO', edtProGen.Text);

  frmConfConsultaGeneral.pSalvarConfs;
end;

procedure TfrmConfiguracoesGeneral.FormCreate(Sender: TObject);
begin
  inherited;
  consulta := fGetConsultaTinta('GEN');
  conf     := fGetConfTinta('GEN');

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'GENERAL', 'USATIN', 'N'));
  conf.pInsereCodigo('GENLIT', 'Item embalagem Litro', fArqIniTinta(0, 'GENERAL', 'GENLIT', ''));
  conf.pInsereCodigo('GENGAL', 'Item embalagem Galão', fArqIniTinta(0, 'GENERAL', 'GENGAL', ''));
  conf.pInsereCodigo('GENCOP', 'Item embalagem Copo', fArqIniTinta(0, 'GENERAL', 'GENCOP', ''));
  conf.pInsereCodigo('GENSPR', 'Item embalagem Spray', fArqIniTinta(0, 'GENERAL', 'GENSPR', ''));
  conf.pInsereCodigo('GENPAT', 'Path', fArqIniTinta(0, 'GENERAL', 'GENPAT', ''));
  conf.pInsereCodigo('GENTRV', 'Trava valor de Venda GEN_PRE', fArqIniTinta(0, 'GENERAL', 'GENTRV', ''));
  conf.pInsereCodigo('GENFAT', 'Fator', fArqIniTinta(0, 'GENERAL', 'GENFAT', ''));
  conf.pInsereCodigo('GENNFM', 'Próximo Código Novas Fórmulas', fArqIniTinta(0, 'GENERAL', 'GENNFM', ''));
  conf.pInsereCodigo('GENPRO', 'Produto para Venda', fArqIniTinta(0, 'GENERAL', 'GENPRO', ''));


  pCarregarConfiguracoes;
  frmConfConsultaGeneral := TfrmConfConsulta.Create(Self, tbsConfCampos, Self.Canvas, consulta);
  pgcDados.ActivePageIndex := 0;

  edtPath.Dialog.Dialog.Filter := 'All files (*.mdb)|*.mdb';
end;

procedure TfrmConfiguracoesGeneral.btnConfirmaClick(
  Sender: TObject);
begin
  If (fVerificaCampos) Then
  Begin
    If (fMensagem('', 'Confirma dados?', ['&Sim', '&Não']) = 1) Then
    Begin
      pSalvarConfiguracoes;
      Close;
    End;
  End;
end;

function TfrmConfiguracoesGeneral.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If Sender = edtPath Then
    Begin
      If Not fEmptyStr(edtPath.Text) Then
      Begin
        If Not FileExists(edtPath.Text) Then
        Begin
          Result :=  fMensagem('ATENÇÃO', 'O path especificado não é válido!', ['OK']) = -1;
        End;
      End;
    End
    Else If Sender = edtCampoTrava Then
    Begin
      If fEmptyStr(edtCampoTrava.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O Campo trava deve ser preenchido!', ['OK']) = -1;
      End
      Else If Pos(edtCampoTrava.Text, '_CUS_VEN_') < 0 Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O campo deve ser CUS ou VEN', ['OK']) = -1;
      End;
    End
    Else If Sender = edtFator Then
    Begin
      If fEmptyStr(edtFator.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O Fator da trava deve ser preenchido!', ['OK']) = -1;
      End
      Else If fStrToFloat(edtFator.Text) <= 0 Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O fator da trava deve ser maior que zero!', ['OK']) = -1;
      End;
    End
    Else If Sender = edtProCodNfm Then
    Begin
      If fEmptyStr(edtProCodNfm.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O Próximo código deve ser preenchido!', ['OK']) = -1;
      End;
    End
    Else If Sender = edtLitro Then
    Begin
      pCarregarIte(edtLitro, edtDesLitro);

      If fEmptyStr(edtDesLitro.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O produto não está cadastrado!', ['OK']) = -1;
      End
    End
    Else If Sender = edtGalao Then
    Begin
      pCarregarIte(edtGalao, edtDesGalao);

      If fEmptyStr(edtDesGalao.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O produto não está cadastrado!', ['OK']) = -1;
      End;
    End
    Else If Sender = edtCopo Then
    Begin
      pCarregarIte(edtCopo, edtDesCopo);

      If fEmptyStr(edtDesCopo.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O produto não está cadastrado!', ['OK']) = -1;
      End;
    End
    Else If Sender = edtSpray Then
    Begin
      pCarregarIte(edtSpray, edtDesSpray);

      If fEmptyStr(edtDesSpray.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O produto não está cadastrado!', ['OK']) = -1;
      End;
    End
    Else If Sender = edtProGen Then
    Begin
      pCarregarIte(edtProGen, edtProGenVen);

      If fEmptyStr(edtProGen.Text) Then
        Result := fMensagem('ATENÇÃO', 'O produto para vende deve ser associado!', ['OK']) = -1
      Else If fEmptyStr(edtProGenVen.Text) Then
        Result := fMensagem('ATENÇÃO', 'O produto não está cadastrado!', ['OK']) = -1;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmConfiguracoesGeneral.pCarregarIte(edtCodIte,
  edtDesIte: TEdit);
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE';
  qryGen.ParamByName('CODITE').AsString := edtCodIte.Text;
  qryGen.Open;

  edtDesIte.Text := qryGen.FieldbyName('ITE_DESITE').AsString;
  FreeAndNil(qryGen);
end;

procedure TfrmConfiguracoesGeneral.pConsultaItem(edtItem, edtDesIte: TEdit);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesGeneral.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesGeneral.edtLitroKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    pConsultaItem(edtLitro, edtDesLitro);
  End;
end;

procedure TfrmConfiguracoesGeneral.edtGalaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    pConsultaItem(edtGalao, edtDesGalao);
  End;
end;

procedure TfrmConfiguracoesGeneral.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaGeneral.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesGeneral.Destroy;
begin
  if Assigned(frmConfConsultaGeneral) then FreeAndNil(frmConfConsultaGeneral);
  inherited;
end;

procedure TfrmConfiguracoesGeneral.edtCopoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    pConsultaItem(edtCopo, edtDesCopo);
  End;
end;

procedure TfrmConfiguracoesGeneral.edtSprayKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    pConsultaItem(edtSpray, edtDesSpray);
  End;
end;

procedure TfrmConfiguracoesGeneral.edtProGenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    pConsultaItem(edtProGen, edtProGenVen);
  End;
end;

end.
