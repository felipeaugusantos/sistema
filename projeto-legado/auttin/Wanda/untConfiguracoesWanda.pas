unit untConfiguracoesWanda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, EditFocus, StrUtils, MaskEditFocus, AppEvnts, Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesWanda = class(TfrmPai)
    pnlCentral: TPanel;
    Label6: TLabel;
    Label17: TLabel;
    Label9: TLabel;
    Label20: TLabel;
    Label11: TLabel;
    edtDesProWan: TEditFocus;
    edtProWan: TEditFocus;
    chkUsaWan: TCheckBox;
    pnlCabecalho: TPanel;
    edtTraWan: TEditFocus;
    edtFatWan: TEditFocus;
    edtDesWanIem: TEditFocus;
    edtDesWanIgl: TEditFocus;
    Label10: TLabel;
    Label7: TLabel;
    edtGalWan: TEditFocus;
    Label16: TLabel;
    edtWanIem: TEditFocus;
    Label1: TLabel;
    edtWanIgl: TEditFocus;
    edtEmbWan: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtTrdWan: TEditFocus;
    edtFadWan: TEditFocus;
    Label5: TLabel;
    mskLinWan: TMaskEditFocus;
    Label8: TLabel;
    edtLd1Wan: TEditFocus;
    Label13: TLabel;
    edtBd1Wan: TEditFocus;
    Label14: TLabel;
    edtFveWan: TEditFocus;
    btnGravarConf: TBitBtnLocked;
    fraPatWan: TfraDirectoryEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure edtProWanKeyPress(Sender: TObject; var Key: Char);
    procedure edtLd1WanKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pRetornaDescricaoItem(edtCodIte: TEdit);
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);

    function fBaseCadastrada(strLinha, strBase: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmConfiguracoesWanda: TfrmConfiguracoesWanda;

implementation

uses
  untModuloTinta, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmConfiguracoesWanda }

procedure TfrmConfiguracoesWanda.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA WANDA              *}
  {**************************************MV*}
  chkUsaWan.Checked := (fArqIniTinta(0, 'WANDA', 'USATIN', '') = 'S');

  edtProWan.Text := fArqIniTinta(0, 'WANDA', 'PROWAN', '');
  edtEmbWan.Text := fArqIniTinta(0, 'WANDA', 'EMBWAN', '');
  edtWanIem.Text := fArqIniTinta(0, 'WANDA', 'WANIEM', '');
  edtGalWan.Text := fArqIniTinta(0, 'WANDA', 'GALWAN', '');
  edtWanIgl.Text := fArqIniTinta(0, 'WANDA', 'WANIGL', '');
  edtFveWan.Text := fArqIniTinta(0, 'WANDA', 'FVEWAN', '');
  edtTraWan.Text := fArqIniTinta(0, 'WANDA', 'TRAWAN', '');
  edtFatWan.Text := fArqIniTinta(0, 'WANDA', 'FATWAN', '');
  edtTrdWan.Text := fArqIniTinta(0, 'WANDA', 'TRDWAN', '');
  edtFadWan.Text := fArqIniTinta(0, 'WANDA', 'FADWAN', '');
  mskLinWan.Text := fArqIniTinta(0, 'WANDA', 'LINWAN', '');
  edtLd1Wan.Text := fArqIniTinta(0, 'WANDA', 'LD1WAN', '');
  edtBd1Wan.Text := fArqIniTinta(0, 'WANDA', 'BD1WAN', '');
  fraPatWan.edtDirectory.text := fArqIniTinta(0, 'WANDA', 'PATWAN', '');

end;

procedure TfrmConfiguracoesWanda.pGravaArqIni;
  Var
    strUsaTin: String;
begin
  {*****************************************}
  {* GRAVA DADOS DA WANDA                *}
  {**************************************MV*}
  If chkUsaWan.Checked Then
    strUsaTin := 'S'
  Else
    strUsaTin := 'N';

  fArqIniTinta(1, 'WANDA', 'USATIN', strUsaTin);

  fArqIniTinta(1, 'WANDA', 'PROWAN', edtProWan.Text);
  fArqIniTinta(1, 'WANDA', 'EMBWAN', edtEmbWan.Text);
  fArqIniTinta(1, 'WANDA', 'WANIEM', edtWanIem.Text);
  fArqIniTinta(1, 'WANDA', 'GALWAN', edtGalWan.Text);
  fArqIniTinta(1, 'WANDA', 'WANIGL', edtWanIgl.Text);
  fArqIniTinta(1, 'WANDA', 'FVEWAN', edtFveWan.Text);
  fArqIniTinta(1, 'WANDA', 'TRAWAN', edtTraWan.Text);
  fArqIniTinta(1, 'WANDA', 'FATWAN', edtFatWan.Text);
  fArqIniTinta(1, 'WANDA', 'TRDWAN', edtTrdWan.Text);
  fArqIniTinta(1, 'WANDA', 'FADWAN', edtFadWan.Text);
  fArqIniTinta(1, 'WANDA', 'LINWAN', mskLinWan.Text);
  fArqIniTinta(1, 'WANDA', 'LD1WAN', edtLd1Wan.Text);
  fArqIniTinta(1, 'WANDA', 'BD1WAN', edtBd1Wan.Text);
  fArqIniTinta(1, 'WANDA', 'PATWAN', fraPatWan.edtDirectory.text);

end;

procedure TfrmConfiguracoesWanda.pRetornaDescricaoItem(edtCodIte: TEdit);
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
begin
  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, 6);
  edtDesIte := TEdit(fComponentByName(pnlCentral, strNomEdt));

  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesWanda.pConsultaItem(edtItem, edtDesIte: TEdit);
  var
    arrSel: TConsultasArray;
    key: Char;
begin
  key := '/';
  If fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesWanda.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(chkUsaWan);
end;

procedure TfrmConfiguracoesWanda.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
end;

procedure TfrmConfiguracoesWanda.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    pGravaArqIni;
    Close;
  End;
end;

procedure TfrmConfiguracoesWanda.edtProWanKeyPress(Sender: TObject;
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

function TfrmConfiguracoesWanda.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  //#Asimov# inherited fValidaCampos
  If not (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Exit(False);
  //

  Result := True;

  If (Sender = edtProWan) Then
  Begin
    If (fEmptyStr(edtProWan.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para venda deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtProWan);
      If (fEmptyStr(edtDesProWan.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtEmbWan) Then
  Begin
    If (fEmptyStr(edtEmbWan.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço da embalagem (Litro) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtEmbWan.Text) <= 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço da embalagem (Litro) deve ser maior que zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtWanIem) Then
  Begin
    If (fEmptyStr(edtWanIem.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para embalagem (Litro) deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtWanIem);
      If (fEmptyStr(edtDesWanIem.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtGalWan) Then
  Begin
    If (fEmptyStr(edtGalWan.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço da embalagem (Galão) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtGalWan.Text) <= 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço da embalagem (Galão) deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtWanIgl) Then
  Begin
    If (fEmptyStr(edtWanIgl.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para embalagem (Galão) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtWanIgl);
      If (fEmptyStr(edtDesWanIgl.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtFveWan) Then
  Begin
    If (fEmptyStr(edtFveWan.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para geração Preço de Venda deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtFveWan.Text) <= 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para geração Preço de Venda deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtTraWan) Then
  Begin
    If (fEmptyStr(edtTraWan.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A trava para valor de venda (concentrado) deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Length(edtTraWan.Text) <> 3 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo da trava (concentrado) deve ter exatamente 3 caracteres!', ['&Ok']);
      Result := False;
    End
    Else If Pos(edtTraWan.Text, 'VEN_CUS_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFatWan) Then
  Begin
    If (fEmptyStr(edtFatWan.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para trava de venda (concentrado) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtFatWan.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava de venda (concentrado) deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtTrdWan) Then
  Begin
    If (fEmptyStr(edtTrdWan.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A trava para valor de venda (diluido) deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Length(edtTrdWan.Text) <> 3 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo da trava (diluido) deve ter exatamente 3 caracteres!', ['&Ok']);
      Result := False;
    End
    Else If Pos(edtTrdWan.Text, 'VEN_CUS_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFadWan) Then
  Begin
    If (fEmptyStr(edtFadWan.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para trava de venda (diluido) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtFadWan.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava de venda (diluido) deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtLd1Wan) Then
  Begin


  End

  Else If (Sender = edtBd1Wan) Then
  Begin

    If (Not fEmptyStr(edtBd1Wan.Text)) Or (Not fEmptyStr(edtLd1Wan.Text)) Then
    Begin

      If (Not fBaseCadastrada(edtLd1Wan.Text, edtBd1Wan.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa base não está cadastrada!', ['&Ok']);
        Result := False;
      End;

    End;

  End

  Else If (Sender = fraPatWan) Then
  Begin
    If (fEmptyStr(fraPatWan.edtDirectory.text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O path para os arquivos Txt deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      fraPatWan.edtDirectory.text := fGetPath(fraPatWan.edtDirectory.text);
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmConfiguracoesWanda.fBaseCadastrada(strLinha,
  strBase: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  WAN_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_LINHA_ = :LINHA AND ';
  strSQL := strSQL + '  BAS_CODBAS = :CODBAS ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('LINHA').AsString  := strLinha;
    ParamByName('CODBAS').AsString := strBase;
    Open;
    Result := Fields[0].AsInteger > 0;
    Close;
  End;


end;

procedure TfrmConfiguracoesWanda.edtLd1WanKeyPress(Sender: TObject; var Key: Char);
  Var
    qryAux: TUniQuery;
    arrSel: TConsultasArray;
begin
  inherited;
  Try
    qryAux := fCriaQuery;
    key := '/';
    If fPesqBaseTinta(Self, conWandaLinha, edtBd1Wan,  nil, qryAux, key,  arrSel) Then
    Begin
      edtLd1Wan.Text := qryAux.FieldByName('BAS_LINHA_').AsString;
      pSetFocus(fraPatWan);
    End;
  Finally
    FreeAndNil(qryAux);
  End;

end;

end.

