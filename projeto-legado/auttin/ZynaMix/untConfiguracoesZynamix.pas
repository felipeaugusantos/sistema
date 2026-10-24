unit untConfiguracoesZynamix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, EditFocus, StrUtils, AppEvnts, Uni,
  untConfConsulta, untIConfTinta, untIConsultaTinta,  ComCtrls,
  BitBtnLockedIncrem, JvExMask, JvToolEdit, frxClass, frxExportCSVTestabilidade, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesZynamix = class(TfrmPai)
    pnlCabecalho: TPanel;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    tbsConfCampos: TTabSheet;
    pnlCentral: TPanel;
    Label6: TLabel;
    Label17: TLabel;
    lblEmbGal: TLabel;
    lblZynGdf: TLabel;
    lblZynGdt: TLabel;
    lblZynGom: TLabel;
    lblZynLdf: TLabel;
    lblZynLdt: TLabel;
    lblZynLom: TLabel;
    lblEmbLit: TLabel;
    Label9: TLabel;
    Label20: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label7: TLabel;
    lblMarZyn: TLabel;
    lblZynVcd: TLabel;
    lblZynVvd: TLabel;
    lblZynLzy: TLabel;
    lblZynGzy: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    edtDesProZyn: TEditFocus;
    edtProZyn: TEditFocus;
    edtDesZynGdu: TEditFocus;
    edtDesZynLdu: TEditFocus;
    edtZynGdu: TEditFocus;
    edtZynLdu: TEditFocus;
    chkUsaZyn: TCheckBox;
    edtDesZynGdf: TEditFocus;
    edtZynGdf: TEditFocus;
    edtDesZynGdt: TEditFocus;
    edtZynGdt: TEditFocus;
    edtDesZynGom: TEditFocus;
    edtZynGom: TEditFocus;
    edtDesZynLdf: TEditFocus;
    edtZynLdf: TEditFocus;
    edtDesZynLdt: TEditFocus;
    edtZynLdt: TEditFocus;
    edtDesZynLom: TEditFocus;
    edtZynLom: TEditFocus;
    edtTraZyn: TEditFocus;
    edtFatZyn: TEditFocus;
    edtGalZyn: TEditFocus;
    edtEmbZyn: TEditFocus;
    fraPatZyn: TfraDirectoryEditFocus;
    edtMarZyn: TEditFocus;
    edtZynVcd: TEditFocus;
    edtZynVvd: TEditFocus;
    edtDesZynLzy: TEditFocus;
    edtZynLzy: TEditFocus;
    edtDesZynGzy: TEditFocus;
    edtZynGzy: TEditFocus;
    edtZynCop: TEditFocus;
    edtDesZynCop: TEditFocus;
    edtZynSpr: TEditFocus;
    edtDesZynSpr: TEditFocus;
    Label1: TLabel;
    edtNfmZyn: TEditFocus;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure edtZynGduKeyPress(Sender: TObject; var Key: Char);
    procedure edtProZynKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    { Private declarations }

    qryCadIte: TUniQuery;

    frmConfConsultaZynamix: TfrmConfConsulta;
    tinta: IConsultaTinta;
    conf: IConfTinta;
    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pRetornaDescricaoItem(edtCodIte: TEdit);
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesZynamix: TfrmConfiguracoesZynamix;

implementation

uses
    untFuncTinta,  untFuncoesSimples;

{$R *.dfm}

{ TfrmConfiguracoesZynamix }

function TfrmConfiguracoesZynamix.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    edtDesIte: TEdit;
begin
  //#Asimov# inherited fValidaCampos
  If not (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Exit(False);
  //

  Result := True;

  If (Sender = edtProZyn) Then
  Begin
    If (fEmptyStr(edtProZyn.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para venda deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtProZyn);
      If (fEmptyStr(edtDesProZyn.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está preenchido!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtTraZyn) Then
  Begin
    If (fEmptyStr(edtTraZyn.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A trava para valor de venda deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Length(edtTraZyn.Text) <> 3 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
      Result := False;
    End
    Else If Pos(edtTraZyn.Text, 'VEN_CUS_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFatZyn) Then
  Begin
    If (fEmptyStr(edtFatZyn.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para trava deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtFatZyn.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtEmbZyn) Then
  Begin
    If (fEmptyStr(edtEmbZyn.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço de Embalagem deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If (fStrToFloat(edtEmbZyn.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço de Embalagem deve ser maior ou igual a Zero!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtGalZyn) Then
  Begin
    If (fEmptyStr(edtGalZyn.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço do Galão deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If (fStrToFloat(edtGalZyn.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço do Galão deve ser maior ou igual a Zero!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtMarZyn) And (edtMarZyn.Enabled) Then
  Begin
    If (fEmptyStr(edtMarZyn.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para trava deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtMarZyn.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'A margem para cálculo do preço de custo deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = fraPatZyn) Then
  Begin
    If (fEmptyStr(fraPatZyn.edtDirectory.text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O path para os arquivos LST deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      fraPatZyn.edtDirectory.text := fGetPath(fraPatZyn.edtDirectory.text);
    End;
  End

  Else If (Sender = edtZynVvd) And (edtZynVvd.Enabled) Then
  Begin
    If (fEmptyStr(edtZynVvd.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor de venda litro diluente deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If (fStrToFloat(edtZynVvd.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor de venda litro diluente deve ser maior ou igual a Zero!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtZynVcd) And (edtZynVcd.Enabled) Then
  Begin
    If (fEmptyStr(edtZynVcd.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor de custo litro diluente deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If (fStrToFloat(edtZynVcd.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor de custo litro diluente deve ser maior ou igual a Zero!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtZynGdu) Or
          (Sender = edtZynGdf) Or
          (Sender = edtZynGdt) Or
          (Sender = edtZynGom) Or
          (Sender = edtZynGzy) Or
          (Sender = edtZynLdu) Or
          (Sender = edtZynLdf) Or
          (Sender = edtZynLdt) Or
          (Sender = edtZynLom) Or
          (Sender = edtZynLzy) Or
          (Sender = edtZynCop) Or
          (Sender = edtZynSpr) Then
  Begin
    if Sender.Enabled then
    begin
      If (fEmptyStr(TEdit(Sender).Text)) Then
      Begin
        If ((TEdit(Sender).Enabled)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Todos os itens devem ser preenchidos!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        pRetornaDescricaoItem(TEdit(Sender));
        edtDesIte := TEdit(fComponentByName(pnlCentral, 'edtDes' + RightStr(TEdit(Sender).Name, 6)));
        If (fEmptyStr(edtDesIte.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    end;
  End
  Else If (Sender = edtNfmZyn) Then
  Begin
    If (fEmptyStr(edtNfmZyn.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código das novas fórmulas deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmConfiguracoesZynamix.pCarregaArqIni;
begin
  {*****************************************}
  {* GRAVA DADOS DA BRASIMIX AUTOMOTIVA    *}
  {**************************************MV*}
{
  chkUsaZyn.Checked := (fArqIniTinta(0, 'ZYNAMIX', 'USATIN', '') = 'S');

  edtProZyn.Text := fArqIniTinta(0, 'ZYNAMIX', 'PROZYN', '');
  edtTraZyn.Text := fArqIniTinta(0, 'ZYNAMIX', 'TRAZYN', '');
  edtFatZyn.Text := fArqIniTinta(0, 'ZYNAMIX', 'FATZYN', '');
  edtEmbZyn.Text := fArqIniTinta(0, 'ZYNAMIX', 'EMBZYN', '');
  edtGalZyn.Text := fArqIniTinta(0, 'ZYNAMIX', 'GALZYN', '');
  edtMarZyn.Text := fArqIniTinta(0, 'ZYNAMIX', 'MARZYN', '');
  fraPatZyn.edtDirectory.text := fArqIniTinta(0, 'ZYNAMIX', 'PATZYN', '');
  edtZynGdu.Text := fArqIniTinta(0, 'ZYNAMIX', 'ZYNGDU', '');
  edtZynGdf.Text := fArqIniTinta(0, 'ZYNAMIX', 'ZYNGDF', '');
  edtZynGdt.Text := fArqIniTinta(0, 'ZYNAMIX', 'ZYNGDT', '');
  edtZynGom.Text := fArqIniTinta(0, 'ZYNAMIX', 'ZYNGOM', '');
  edtZynGzy.Text := fArqIniTinta(0, 'ZYNAMIX', 'ZYNGZY', '');
  edtZynLdu.Text := fArqIniTinta(0, 'ZYNAMIX', 'ZYNLDU', '');
  edtZynLdf.Text := fArqIniTinta(0, 'ZYNAMIX', 'ZYNLDF', '');
  edtZynLdt.Text := fArqIniTinta(0, 'ZYNAMIX', 'ZYNLDT', '');
  edtZynLom.Text := fArqIniTinta(0, 'ZYNAMIX', 'ZYNLOM', '');
  edtZynLzy.Text := fArqIniTinta(0, 'ZYNAMIX', 'ZYNLZY', '');
  fraPatZyn.edtDirectory.text := fArqIniTinta(0, 'ZYNAMIX', 'PATZYN', '');
  edtZynVvd.Text := fArqIniTinta(0, 'ZYNAMIX', 'PATVVD', '');
  edtZynVcd.Text := fArqIniTinta(0, 'ZYNAMIX', 'PATVCD', '');

  edtZynCop.Text := fArqIniTinta(0, 'ZYNAMIX', 'ZYNCOP', '');
  edtZynSpr.Text := fArqIniTinta(0, 'ZYNAMIX', 'ZYNSPR', '');
}

  chkUsaZyn.Checked  := conf.fGetBoolean('USATIN'); //(fArqIniTinta(0, 'ZYNAMIX', 'USATIN', '') = 'S');

  edtProZyn.Text     := conf.fGet('PROZYN'); //fArqIniTinta(0, 'ZYNAMIX', 'PROZYN', '');
  edtTraZyn.Text     := conf.fGet('TRAZYN'); //fArqIniTinta(0, 'ZYNAMIX', 'TRAZYN', '');
  edtFatZyn.Text     := conf.fGet('FATZYN'); //fArqIniTinta(0, 'ZYNAMIX', 'FATZYN', '');
  edtEmbZyn.Text     := conf.fGet('EMBZYN'); //fArqIniTinta(0, 'ZYNAMIX', 'EMBZYN', '');
  edtGalZyn.Text     := conf.fGet('GALZYN'); //fArqIniTinta(0, 'ZYNAMIX', 'GALZYN', '');
  edtMarZyn.Text     := conf.fGet('MARZYN'); //fArqIniTinta(0, 'ZYNAMIX', 'MARZYN', '');
  fraPatZyn.edtDirectory.text     := conf.fGet('PATZYN'); //fArqIniTinta(0, 'ZYNAMIX', 'PATZYN', '');
  edtZynGdu.Text     := conf.fGet('ZYNGDU'); //fArqIniTinta(0, 'ZYNAMIX', 'ZYNGDU', '');
  edtZynGdf.Text     := conf.fGet('ZYNGDF'); //fArqIniTinta(0, 'ZYNAMIX', 'ZYNGDF', '');
  edtZynGdt.Text     := conf.fGet('ZYNGDT'); //fArqIniTinta(0, 'ZYNAMIX', 'ZYNGDT', '');
  edtZynGom.Text     := conf.fGet('ZYNGOM'); //fArqIniTinta(0, 'ZYNAMIX', 'ZYNGOM', '');
  edtZynGzy.Text     := conf.fGet('ZYNGZY'); //fArqIniTinta(0, 'ZYNAMIX', 'ZYNGZY', '');
  edtZynLdu.Text     := conf.fGet('ZYNLDU'); //fArqIniTinta(0, 'ZYNAMIX', 'ZYNLDU', '');
  edtZynLdf.Text     := conf.fGet('ZYNLDF'); //fArqIniTinta(0, 'ZYNAMIX', 'ZYNLDF', '');
  edtZynLdt.Text     := conf.fGet('ZYNLDT'); //fArqIniTinta(0, 'ZYNAMIX', 'ZYNLDT', '');
  edtZynLom.Text     := conf.fGet('ZYNLOM'); //fArqIniTinta(0, 'ZYNAMIX', 'ZYNLOM', '');
  edtZynLzy.Text     := conf.fGet('ZYNLZY'); //fArqIniTinta(0, 'ZYNAMIX', 'ZYNLZY', '');
  fraPatZyn.edtDirectory.text     := conf.fGet('PATZYN'); //fArqIniTinta(0, 'ZYNAMIX', 'PATZYN', '');
  edtZynVvd.Text     := conf.fGet('PATVVD'); //fArqIniTinta(0, 'ZYNAMIX', 'PATVVD', '');
  edtZynVcd.Text     := conf.fGet('PATVCD'); //fArqIniTinta(0, 'ZYNAMIX', 'PATVCD', '');

  edtZynCop.Text     := conf.fGet('ZYNCOP'); //fArqIniTinta(0, 'ZYNAMIX', 'ZYNCOP', '');
  edtZynSpr.Text     := conf.fGet('ZYNSPR'); //fArqIniTinta(0, 'ZYNAMIX', 'ZYNSPR', '');
  
  edtNfmZyn.Text     := conf.fGet('NFMZYN'); //fArqIniTinta(0, 'ZYNAMIX', 'NFMZYN', '');

  pRetornaDescricaoItem(edtProZyn);
  pRetornaDescricaoItem(edtZynGdu);
  pRetornaDescricaoItem(edtZynGdf);
  pRetornaDescricaoItem(edtZynGdt);
  pRetornaDescricaoItem(edtZynGom);
  pRetornaDescricaoItem(edtZynGzy);
  pRetornaDescricaoItem(edtZynLdu);
  pRetornaDescricaoItem(edtZynLdf);
  pRetornaDescricaoItem(edtZynLdt);
  pRetornaDescricaoItem(edtZynLom);
  pRetornaDescricaoItem(edtZynLzy);

  pRetornaDescricaoItem(edtZynCop);
  pRetornaDescricaoItem(edtZynSpr);
end;

procedure TfrmConfiguracoesZynamix.pConsultaItem(edtItem, edtDesIte: TEdit);
  Var
    strSQL: String;
    stlCamIndIte: TStringList;
    stlDesIndIte: TStringList;
begin
  inherited;

  stlCamIndIte := TStringList.Create;
  stlDesIndIte := TStringList.Create;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_CODITE AS "Codigo", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "Descrição", ';
  strSQL := strSQL + '  I.ITE_REFERE AS "Referência", ';
  strSQL := strSQL + '  I.ITE_CODUNI AS "Unidade", ';
  strSQL := strSQL + '  G.ITE_PREVE1 AS "Preço de Venda", ';
  strSQL := strSQL + '  I.ITE_CODMAR As "Cód. Marca", ';
  strSQL := strSQL + '  M.MAR_DESMAR As "Marca", ';
  strSQL := strSQL + '  I.AUTOINCREM AS "AUTOINCREM", ';
  strSQL := strSQL + '  IF(I.ITE_ITEATI = "S", "ATIVO", "INATIVO") AS ITE_ITEATI, ';
  strSQL := strSQL + '  I.ITE_CODSIM, ';
  strSQL := strSQL + '  G.ITE_SALDOS, ';
  strSQL := strSQL + '  ITE_PRECUS, ';
  strSQL := strSQL + '  DATEDIFF(CURRENT_DATE, ITE_DTAUVE) ULTVEN ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I, ';
  strSQL := strSQL + '  ITEGER G, ';
  strSQL := strSQL + '  CADMAR M ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
  strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
  strSQL := strSQL + '  G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

  stlCamIndIte.Add('ITE_DESITE');
  stlCamIndIte.Add('ITE_REFERE');
  stlCamIndIte.Add('ITE_CODITE');
  stlCamIndIte.Add('ITE_CODBAR');

  stlDesIndIte.Add('Descrição');
  stlDesIndIte.Add('Referência');
  stlDesIndIte.Add('Código');
  stlDesIndIte.Add('Cód. Barra');

  If pConsultaComp(Self, qryCadIte, 'CADITE', strSQL, stlCamIndIte, stlDesIndIte) Then
  Begin

    edtItem.Text   := qryCadIte.FieldByName('ITE_CODITE').AsString;
    edtDesIte.Text := fRetNomProduto(edtItem.Text);
    SelectNext(ActiveControl, True, True);

  End;

  FreeAndNil(stlCamIndIte);
  FreeAndNil(stlDesIndIte);
end;

procedure TfrmConfiguracoesZynamix.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesZynamix.pGravaArqIni;
begin
  {*****************************************}
  {* GRAVA DADOS DA BRASIMIX AUTOMOTIVA    *}
  {**************************************MV*}
{
  If chkUsaZyn.Checked Then
    strUsaTin := 'S'
  Else
    strUsaTin := 'N';

  fArqIniTinta(1, 'ZYNAMIX', 'USATIN', strUsaTin);
  fArqIniTinta(1, 'ZYNAMIX', 'PROZYN', edtProZyn.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'TRAZYN', edtTraZyn.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'FATZYN', edtFatZyn.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'EMBZYN', edtEmbZyn.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'GALZYN', edtGalZyn.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'MARZYN', edtMarZyn.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'PATZYN', fraPatZyn.edtDirectory.text);
  fArqIniTinta(1, 'ZYNAMIX', 'ZYNGDU', edtZynGdu.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'ZYNGDF', edtZynGdf.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'ZYNGDT', edtZynGdt.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'ZYNGOM', edtZynGom.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'ZYNGZY', edtZynGzy.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'ZYNLDU', edtZynLdu.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'ZYNLDF', edtZynLdf.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'ZYNLDT', edtZynLdt.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'ZYNLOM', edtZynLom.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'ZYNLZY', edtZynLzy.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'PATZYN', fraPatZyn.edtDirectory.text);
  fArqIniTinta(1, 'ZYNAMIX', 'PATVVD', edtZynVvd.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'PATVCD', edtZynVcd.Text);

  fArqIniTinta(1, 'ZYNAMIX', 'ZYNCOP', edtZynCop.Text);
  fArqIniTinta(1, 'ZYNAMIX', 'ZYNSPR', edtZynSpr.Text);
}

  conf.pSetBoolean('USATIN', chkUsaZyn.Checked); //fArqIniTinta(1, 'ZYNAMIX', 'USATIN', strUsaTin);

  conf.pSet('PROZYN', edtProZyn.Text); //fArqIniTinta(1, 'ZYNAMIX', 'PROZYN', edtProZyn.Text);
  conf.pSet('TRAZYN', edtTraZyn.Text); //fArqIniTinta(1, 'ZYNAMIX', 'TRAZYN', edtTraZyn.Text);
  conf.pSet('FATZYN', edtFatZyn.Text); //fArqIniTinta(1, 'ZYNAMIX', 'FATZYN', edtFatZyn.Text);
  conf.pSet('EMBZYN', edtEmbZyn.Text); //fArqIniTinta(1, 'ZYNAMIX', 'EMBZYN', edtEmbZyn.Text);
  conf.pSet('GALZYN', edtGalZyn.Text); //fArqIniTinta(1, 'ZYNAMIX', 'GALZYN', edtGalZyn.Text);
  conf.pSet('MARZYN', edtMarZyn.Text); //fArqIniTinta(1, 'ZYNAMIX', 'MARZYN', edtMarZyn.Text);
  conf.pSet('PATZYN', fraPatZyn.edtDirectory.text); //fArqIniTinta(1, 'ZYNAMIX', 'PATZYN', fraPatZyn.edtDirectory.text);
  conf.pSet('ZYNGDU', edtZynGdu.Text); //fArqIniTinta(1, 'ZYNAMIX', 'ZYNGDU', edtZynGdu.Text);
  conf.pSet('ZYNGDF', edtZynGdf.Text); //fArqIniTinta(1, 'ZYNAMIX', 'ZYNGDF', edtZynGdf.Text);
  conf.pSet('ZYNGDT', edtZynGdt.Text); //fArqIniTinta(1, 'ZYNAMIX', 'ZYNGDT', edtZynGdt.Text);
  conf.pSet('ZYNGOM', edtZynGom.Text); //fArqIniTinta(1, 'ZYNAMIX', 'ZYNGOM', edtZynGom.Text);
  conf.pSet('ZYNGZY', edtZynGzy.Text); //fArqIniTinta(1, 'ZYNAMIX', 'ZYNGZY', edtZynGzy.Text);
  conf.pSet('ZYNLDU', edtZynLdu.Text); //fArqIniTinta(1, 'ZYNAMIX', 'ZYNLDU', edtZynLdu.Text);
  conf.pSet('ZYNLDF', edtZynLdf.Text); //fArqIniTinta(1, 'ZYNAMIX', 'ZYNLDF', edtZynLdf.Text);
  conf.pSet('ZYNLDT', edtZynLdt.Text); //fArqIniTinta(1, 'ZYNAMIX', 'ZYNLDT', edtZynLdt.Text);
  conf.pSet('ZYNLOM', edtZynLom.Text); //fArqIniTinta(1, 'ZYNAMIX', 'ZYNLOM', edtZynLom.Text);
  conf.pSet('ZYNLZY', edtZynLzy.Text); //fArqIniTinta(1, 'ZYNAMIX', 'ZYNLZY', edtZynLzy.Text);
  conf.pSet('PATZYN', fraPatZyn.edtDirectory.text); //fArqIniTinta(1, 'ZYNAMIX', 'PATZYN', fraPatZyn.edtDirectory.text);
  conf.pSet('PATVVD', edtZynVvd.Text); //fArqIniTinta(1, 'ZYNAMIX', 'PATVVD', edtZynVvd.Text);
  conf.pSet('PATVCD', edtZynVcd.Text); //fArqIniTinta(1, 'ZYNAMIX', 'PATVCD', edtZynVcd.Text);

  conf.pSet('ZYNCOP', edtZynCop.Text); //fArqIniTinta(1, 'ZYNAMIX', 'ZYNCOP', edtZynCop.Text);
  conf.pSet('ZYNSPR', edtZynSpr.Text); //fArqIniTinta(1, 'ZYNAMIX', 'ZYNSPR', edtZynSpr.Text);

  conf.pSet('NFMZYN', edtNfmZyn.Text); //fArqIniTinta(1, 'ZYNAMIX', 'NFMZYN', edtNfmZyn.Text);

  frmConfConsultaZynamix.pSalvarConfs;
end;

procedure TfrmConfiguracoesZynamix.pRetornaDescricaoItem(edtCodIte: TEdit);
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
begin
  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, 6);
  edtDesIte := TEdit(fComponentByName(pnlCentral, strNomEdt));

  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesZynamix.FormCreate(Sender: TObject);
begin
  inherited;
  conf  := fGetConfTinta('ZYN');
  tinta := fGetConsultaTinta('ZYN');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}
  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'ZYNAMIX', 'USATIN', ''));
  conf.pInsereCodigo('PROZYN', 'Produto para venda', fArqIniTinta(0, 'ZYNAMIX', 'PROZYN', ''));
  conf.pInsereCodigo('TRAZYN', 'Trava para valor de venda ZYN_PRE', fArqIniTinta(0, 'ZYNAMIX', 'TRAZYN', ''));
  conf.pInsereCodigo('FATZYN', 'Fator', fArqIniTinta(0, 'ZYNAMIX', 'FATZYN', ''));
  conf.pInsereCodigo('EMBZYN', 'Preço de embalagem', fArqIniTinta(0, 'ZYNAMIX', 'EMBZYN', ''));
  conf.pInsereCodigo('GALZYN', 'Preço de galão', fArqIniTinta(0, 'ZYNAMIX', 'GALZYN', ''));
  conf.pInsereCodigo('MARZYN', 'Margem para calculo preço de custo', fArqIniTinta(0, 'ZYNAMIX', 'MARZYN', ''));
  conf.pInsereCodigo('PATZYN', 'Path para arquivos (*.txt)', fArqIniTinta(0, 'ZYNAMIX', 'PATZYN', ''));
  conf.pInsereCodigo('ZYNGDU', 'Produto baixa embalagem GL DULON', fArqIniTinta(0, 'ZYNAMIX', 'ZYNGDU', ''));
  conf.pInsereCodigo('ZYNGDF', 'Produto baixa embalagem GL DELFLEET', fArqIniTinta(0, 'ZYNAMIX', 'ZYNGDF', ''));
  conf.pInsereCodigo('ZYNGDT', 'Produto baixa embalagem GL DELTRON', fArqIniTinta(0, 'ZYNAMIX', 'ZYNGDT', ''));
  conf.pInsereCodigo('ZYNGOM', 'Produto baixa embalagem GL OMNI', fArqIniTinta(0, 'ZYNAMIX', 'ZYNGOM', ''));
  conf.pInsereCodigo('ZYNGZY', 'Produto baixa embalagem GL ZYNAMIX', fArqIniTinta(0, 'ZYNAMIX', 'ZYNGZY', ''));
  conf.pInsereCodigo('ZYNLDU', 'Produto baixa embalagem LT DULON', fArqIniTinta(0, 'ZYNAMIX', 'ZYNLDU', ''));
  conf.pInsereCodigo('ZYNLDF', 'Produto baixa embalagem LT DELFLEET', fArqIniTinta(0, 'ZYNAMIX', 'ZYNLDF', ''));
  conf.pInsereCodigo('ZYNLDT', 'Produto baixa embalagem LT DELTRON', fArqIniTinta(0, 'ZYNAMIX', 'ZYNLDT', ''));
  conf.pInsereCodigo('ZYNLOM', 'Produto baixa embalagem LT OMNI', fArqIniTinta(0, 'ZYNAMIX', 'ZYNLOM', ''));
  conf.pInsereCodigo('ZYNLZY', 'Produto baixa embalagem LT ZYNAMIX', fArqIniTinta(0, 'ZYNAMIX', 'ZYNLZY', ''));
  conf.pInsereCodigo('PATZYN', 'Path para arquivos (*.txt)', fArqIniTinta(0, 'ZYNAMIX', 'PATZYN', ''));
  conf.pInsereCodigo('PATVVD', 'Valor de venda litro diluente', fArqIniTinta(0, 'ZYNAMIX', 'PATVVD', ''));
  conf.pInsereCodigo('PATVCD', 'Valor de custo litro diluente', fArqIniTinta(0, 'ZYNAMIX', 'PATVCD', ''));
  conf.pInsereCodigo('ZYNCOP', 'Produto baixa embalagem Copo', fArqIniTinta(0, 'ZYNAMIX', 'ZYNCOP', ''));
  conf.pInsereCodigo('ZYNSPR', 'Produto baixa embalagem Spray', fArqIniTinta(0, 'ZYNAMIX', 'ZYNSPR', ''));
  conf.pInsereCodigo('NFMZYN', 'Próximo código novas fórmulas', fArqIniTinta(0, 'ZYNAMIX', 'NFMZYN', ''));  

  pgcDados.ActivePageIndex := 0;
  frmConfConsultaZynamix := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);  
end;

procedure TfrmConfiguracoesZynamix.FormShow(Sender: TObject);
begin
  inherited;
  lblEmbGal.Caption := 'Produto baixa embalagem GL:';
  lblEmbLit.Caption := 'Produto baixa embalagem LT:';

  lblZynGdf.Enabled := False;
  edtZynGdf.Enabled := False;

  lblZynGdt.Enabled := False;
  edtZynGdt.Enabled := False;

  lblZynGom.Enabled := False;
  edtZynGom.Enabled := False;

  lblZynGzy.Enabled := False;
  edtZynGzy.Enabled := False;

  lblZynLdf.Enabled := False;
  edtZynLdf.Enabled := False;

  lblZynLdt.Enabled := False;
  edtZynLdt.Enabled := False;

  lblZynLom.Enabled := False;
  edtZynLom.Enabled := False;

  lblZynLzy.Enabled := False;
  edtZynLzy.Enabled := False;

  lblMarZyn.Enabled := False;
  edtMarZyn.Enabled := False;

  lblZynVvd.Enabled := False;
  edtZynVvd.Enabled := False;

  lblZynVcd.Enabled := False;
  edtZynVcd.Enabled := False;

  pCarregaArqIni;
  qryCadIte := fCriaQuery(Self);
end;

procedure TfrmConfiguracoesZynamix.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    pGravaArqIni;
    Close;
  End;
end;

procedure TfrmConfiguracoesZynamix.edtZynGduKeyPress(Sender: TObject;
  var Key: Char);
var
  edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(fComponentByName(pnlCentral, 'edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesZynamix.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaZynamix.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesZynamix.Destroy;
begin
  if Assigned(frmConfConsultaZynamix) then FreeAndNil(frmConfConsultaZynamix);
  inherited;
end;

procedure TfrmConfiguracoesZynamix.edtProZynKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(TEdit(Sender), edtDesProZyn);
  End;

end;

end.

