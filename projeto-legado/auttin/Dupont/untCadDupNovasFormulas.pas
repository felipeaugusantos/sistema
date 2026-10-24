unit untCadDupNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, AppEvnts, Uni, 
  DBComboBoxFocus, BitBtnLockedIncrem, DBMemoFocus, UniClientDataSet, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadDupNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    gpbColorantes: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    dbeForm01: TDBEditFocus;
    dbeQtdC01: TDBEditFocus;
    dbeForm02: TDBEditFocus;
    dbeQtdC02: TDBEditFocus;
    dbeForm03: TDBEditFocus;
    dbeQtdC03: TDBEditFocus;
    dbeForm04: TDBEditFocus;
    dbeQtdC04: TDBEditFocus;
    dbeForm05: TDBEditFocus;
    dbeQtdC05: TDBEditFocus;
    dbeForm06: TDBEditFocus;
    dbeQtdC06: TDBEditFocus;
    dbeForm07: TDBEditFocus;
    dbeQtdC07: TDBEditFocus;
    dbeForm08: TDBEditFocus;
    dbeQtdC08: TDBEditFocus;
    Label2: TLabel;
    dbeDtaCad: TDBEditFocus;
    Label3: TLabel;
    dbeCodDil: TDBEditFocus;
    Label5: TLabel;
    dbeQtdDil: TDBEditFocus;
    Label6: TLabel;
    dbeCodCat: TDBEditFocus;
    Label27: TLabel;
    dbeQtdCat: TDBEditFocus;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label28: TLabel;
    dbeQtdD01: TDBEditFocus;
    dbeQtdD02: TDBEditFocus;
    dbeQtdD03: TDBEditFocus;
    dbeQtdD04: TDBEditFocus;
    dbeQtdD05: TDBEditFocus;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label33: TLabel;
    dbeQtdD06: TDBEditFocus;
    dbeQtdD07: TDBEditFocus;
    dbeQtdD08: TDBEditFocus;
    Label34: TLabel;
    Label35: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    dbeQualid: TDBEditFocus;
    Label40: TLabel;
    dbeAltern: TDBEditFocus;
    Label41: TLabel;
    dbeMontad: TDBEditFocus;
    Label42: TLabel;
    dbeForm09: TDBEditFocus;
    Label43: TLabel;
    dbeQtdC09: TDBEditFocus;
    Label44: TLabel;
    dbeQtdD09: TDBEditFocus;
    Label45: TLabel;
    dbeForm10: TDBEditFocus;
    Label46: TLabel;
    dbeQtdC10: TDBEditFocus;
    Label47: TLabel;
    dbeQtdD10: TDBEditFocus;
    Label48: TLabel;
    dbeForm11: TDBEditFocus;
    Label49: TLabel;
    dbeQtdC11: TDBEditFocus;
    Label50: TLabel;
    dbeQtdD11: TDBEditFocus;
    Label51: TLabel;
    dbeForm12: TDBEditFocus;
    Label52: TLabel;
    dbeQtdC12: TDBEditFocus;
    Label53: TLabel;
    dbeQtdD12: TDBEditFocus;
    Label54: TLabel;
    dbeForm13: TDBEditFocus;
    Label55: TLabel;
    dbeQtdC13: TDBEditFocus;
    Label56: TLabel;
    dbeQtdD13: TDBEditFocus;
    Label57: TLabel;
    dbeForm14: TDBEditFocus;
    Label58: TLabel;
    dbeQtdC14: TDBEditFocus;
    Label59: TLabel;
    dbeQtdD14: TDBEditFocus;
    Label60: TLabel;
    dbeForm15: TDBEditFocus;
    Label61: TLabel;
    dbeQtdC15: TDBEditFocus;
    Label62: TLabel;
    dbeQtdD15: TDBEditFocus;
    Label24: TLabel;
    Label25: TLabel;
    Label23: TLabel;
    Label26: TLabel;
    Label36: TLabel;
    dbeForm16: TDBEditFocus;
    dbeForm17: TDBEditFocus;
    dbeForm18: TDBEditFocus;
    dbeForm19: TDBEditFocus;
    dbeForm20: TDBEditFocus;
    Label37: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    dbeQtdC16: TDBEditFocus;
    dbeQtdC17: TDBEditFocus;
    dbeQtdC18: TDBEditFocus;
    dbeQtdC19: TDBEditFocus;
    dbeQtdC20: TDBEditFocus;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    label71: TLabel;
    dbeQtdD16: TDBEditFocus;
    dbeQtdD17: TDBEditFocus;
    dbeQtdD18: TDBEditFocus;
    dbeQtdD19: TDBEditFocus;
    dbeQtdD20: TDBEditFocus;
    dbeLinha_: TDBComboBoxFocus;
    Label72: TLabel;
    grbCatalise: TGroupBox;
    dbeCatali: TDBMemoFocus;
    btnAtivarNfm: TBitBtnLocked;
    btnAjustarVolume: TBitBtnLocked;
    lblVolumeTotal: TLabel;
    Label73: TLabel;
    dbeAcrMob: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAtivarNfmClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAjustarVolumeClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbeQtdC01Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    cdsBases: TUniClientDataSet;
    fltTotalConcentrado: Double;
    fltTotalDiluido: Double;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pBotaoAtivarNfm;
    procedure pAtivarDesativarNfm;
    procedure pAtivaNfm;
    procedure pAtivaCadDup;
    procedure pCalcularTotalVolume;
    procedure Ajustar;
    function fInformarDiluente : Boolean;
    function fValidarBasePreenchida : Boolean;
    function fInformarBase : Boolean;
    procedure pInserirMascara;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
    procedure pHabilitarBotoes;
    function fRetStatusNfm(strCodigo : String ) : String;

  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    function VerificarNovaFormulaMovimentada: Boolean;
    procedure ConstruirCdsBases;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmCadDupNovasFormulas: TfrmCadDupNovasFormulas;

implementation

uses untModuloTinta, untPai, untDupont, untFuncoesSimples,
     untIConfTinta, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadDupNovasForumulas }

function TfrmCadDupNovasFormulas.fRetStatusNfm(strCodigo: String): String;
var
  QryAux : TUniQuery;
begin
  QryAux := Nil;

  try
    QryAux := fCriaQuery;
    QryAux.SQL.Clear;
    QryAux.Close;
    QryAux.SQL.Text := 'SELECT NFM_ATIVO_ FROM DUP_CADNFM WHERE NFM_CODNFM = ' + QuotedStr(strCodigo);
    QryAux.Open;

    Result := QryAux.Fields[0].AsString;
  Finally
    FreeAndNil(QryAux);
  end;

end;

function TfrmCadDupNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    dbeForm: TDBEdit;
    dbeQtdC: TDBEdit;
    dbeQtdD: TDBEdit;
begin
  Result := True;
  pCalcularTotalVolume;

  If (Sender = dbeCodigo) Then
  Begin
  End

  Else If (Sender = dbeDescri) Then
  Begin
    If (fEmptyStr(dbeDescri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeForm01) Then
  Begin
    If (fEmptyStr(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos uma base!', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaColorante(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base não está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End

  Else If LeftStr(Sender.Name, 7) = 'dbeForm' Then
  Begin
    If (fEmptyStr((TEdit(Sender).Text))) Then
    Begin
      pSetFocus(dbeQtdD20);
    End
    Else If (Not fValidaColorante(TEdit(Sender).Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base não está cadastrada!', ['&Ok']);
      Result := False;
    End

    Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
      Result := False;
    End;

  End

  Else If LeftStr(Sender.Name, 6) = 'dbeQtd' Then
  Begin
    dbeForm := TDBEdit(FindComponent('dbeForm' + RightStr(Sender.Name, 2)));
    dbeQtdC := TDBEdit(FindComponent('dbeQtdC' + RightStr(Sender.Name, 2)));
    dbeQtdD := TDBEdit(FindComponent('dbeQtdD' + RightStr(Sender.Name, 2)));

    If (dbeForm <> nil) And (LeftStr(Sender.Name, 7) = 'dbeQtdD') And (Not fEmptyStr(dbeForm.Text)) Then
    Begin
      If (fEmptyStr(dbeQtdC.Text) And fEmptyStr(dbeQtdD.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade da base!', ['&Ok']);
        Result := False;
      End
      Else If ((fStrToFloat(dbeQtdC.Text) <= 0) And (fStrToFloat(dbeQtdD.Text) <= 0))Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade da base!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = dbeCodDil) Or
          (Sender = dbeCodCat) Then
  Begin
    If (Not fEmptyStr((TEdit(Sender).Text))) Then
    Begin
      If (Not fValidaColorante(TEdit(Sender).Text)) Then
        Result := False;
    End;
  End

  Else If (Sender = dbeQtdDil) Then
  Begin
    If (Not fEmptyStr(dbeCodDil.Text)) Then
    Begin

      If (fEmptyStr(dbeQtdDil.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade do diluente!', ['&Ok']);
        Result := False;
      End;

      If (fStrToFloat(dbeQtdDil.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade do diluente deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

    End;
  End

  Else If (Sender = dbeQtdCat) Then
  Begin
    If (Not fEmptyStr(dbeCodCat.Text)) Then
    Begin

      If (fEmptyStr(dbeQtdCat.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade do catalisador!', ['&Ok']);
        Result := False;
      End;

      If (fStrToFloat(dbeQtdCat.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade do catalisador deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;
      
    End;
  End

  Else If (Sender = dbeAcrMob) Then
  Begin
    If fEmptyStr(dbeAcrMob.Text) Then
    Begin
      dbeAcrMob.Field.AsFloat := 0.00;
    End
    Else If Not fEmptyStr(dbeAcrMob.Text) Then
    Begin
      If (fStrToFloat(dbeAcrMob.Text) < 0) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O Acréscimo de Mão de Obra deve ser maior ou igual a zero', ['OK']) = -1;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmCadDupNovasFormulas.fValidaColorante(
  strCodCol: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DUP_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_CODBAS = :CODBAS ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBAS').AsString := strCodCol;
    Open;
    Result := (FieldByName('QTD').AsInteger > 0);
    Close;
  End;
end;

function TfrmCadDupNovasFormulas.fValidarBasePreenchida: Boolean;
begin
  Result := false;

  if (dbeForm01.text = '') and ((dbeQtdC01.text <> '0,000') or (dbeQtdD01.text <> '0,000')) then result  := true;
  if (dbeForm02.text = '') and ((dbeQtdC02.text <> '0,000') or (dbeQtdD02.text <> '0,000')) then result  := true;
  if (dbeForm03.text = '') and ((dbeQtdC03.text <> '0,000') or (dbeQtdD03.text <> '0,000')) then result  := true;
  if (dbeForm04.text = '') and ((dbeQtdC04.text <> '0,000') or (dbeQtdD04.text <> '0,000')) then result  := true;
  if (dbeForm05.text = '') and ((dbeQtdC05.text <> '0,000') or (dbeQtdD05.text <> '0,000')) then result  := true;
  if (dbeForm06.text = '') and ((dbeQtdC06.text <> '0,000') or (dbeQtdD06.text <> '0,000')) then result  := true;
  if (dbeForm07.text = '') and ((dbeQtdC07.text <> '0,000') or (dbeQtdD07.text <> '0,000')) then result  := true;
  if (dbeForm08.text = '') and ((dbeQtdC08.text <> '0,000') or (dbeQtdD08.text <> '0,000')) then result  := true;
  if (dbeForm09.text = '') and ((dbeQtdC09.text <> '0,000') or (dbeQtdD09.text <> '0,000')) then result  := true;
  if (dbeForm10.text = '') and ((dbeQtdC10.text <> '0,000') or (dbeQtdD10.text <> '0,000')) then result  := true;
  if (dbeForm11.text = '') and ((dbeQtdC11.text <> '0,000') or (dbeQtdD11.text <> '0,000')) then result  := true;
  if (dbeForm12.text = '') and ((dbeQtdC12.text <> '0,000') or (dbeQtdD12.text <> '0,000')) then result  := true;
  if (dbeForm13.text = '') and ((dbeQtdC13.text <> '0,000') or (dbeQtdD13.text <> '0,000')) then result  := true;
  if (dbeForm14.text = '') and ((dbeQtdC14.text <> '0,000') or (dbeQtdD14.text <> '0,000')) then result  := true;
  if (dbeForm15.text = '') and ((dbeQtdC15.text <> '0,000') or (dbeQtdD15.text <> '0,000')) then result  := true;
  if (dbeForm16.text = '') and ((dbeQtdC16.text <> '0,000') or (dbeQtdD16.text <> '0,000')) then result  := true;
  if (dbeForm17.text = '') and ((dbeQtdC17.text <> '0,000') or (dbeQtdD17.text <> '0,000')) then result  := true;
  if (dbeForm18.text = '') and ((dbeQtdC18.text <> '0,000') or (dbeQtdD18.text <> '0,000')) then result  := true;
  if (dbeForm19.text = '') and ((dbeQtdC19.text <> '0,000') or (dbeQtdD18.text <> '0,000')) then result  := true;
  if (dbeForm20.text = '') and ((dbeQtdC20.text <> '0,000') or (dbeQtdD20.text <> '0,000')) then result  := true;
end;

procedure TfrmCadDupNovasFormulas.pAtivaCadDup;
var
  qryUpt: TUniQuery;
begin
  Try
    qryUpt := fCriaQuery(Nil);
    With qryUpt Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE DUP_CADDUP ');
      SQL.Add('    SET DUP_ATIVO_ = :ATIVO_ ');
      SQL.Add('  WHERE DUP_CODNFM = :CODPRO ');
      ParamByName('ATIVO_').AsString := IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','N','S');
      ParamByName('CODPRO').AsString := qryTabela.FieldByName('NFM_CODNFM').AsString;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryUpt);
  End;
end;

procedure TfrmCadDupNovasFormulas.pAtivaNfm;
var
  qryUpt: TUniQuery;
begin
  Try
    qryUpt := fCriaQuery(Nil);
    With qryUpt Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE DUP_CADNFM ');
      SQL.Add('    SET NFM_ATIVO_ = :ATIVO_ ');
      SQL.Add('  WHERE NFM_CODNFM = :CODPRO ');
      ParamByName('ATIVO_').AsString := IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','N','S');
      ParamByName('CODPRO').AsString := qryTabela.FieldByName('NFM_CODNFM').AsString;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryUpt);
  End;
end;

procedure TfrmCadDupNovasFormulas.pAtivarDesativarNfm;
begin
  Try
    fStartTransaction;

    pAtivaNfm;
    pAtivaCadDup;

    fCommit;

    fMensagem('ATENÇÃO!', 'Nova Fórmula ' + IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      fMensagem('ATENÇÃO!', 'Erro na hora de ' + IIF(qryTabela.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TfrmCadDupNovasFormulas.pBotaoAtivarNfm;
begin
  if fRetStatusNfm(dbeCodigo.text) = 'S' then
    btnAtivarNfm.Caption := 'Desativar'
  else
    btnAtivarNfm.Caption := 'Ativar';
end;

procedure TfrmCadDupNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_DESCRI');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadDupNovasFormulas.pInserirMascara;
var
  intContador : Integer;
begin
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin
    If Self.Components[intContador] Is TDBEditFocus Then
    Begin
      if(LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeQtdC')
      and (TDBEditFocus(Self.Components[intContador]).Text = '') then
        TDBEditFocus(Self.Components[intContador]).Field.AsFloat := 0.0;

      if(LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeQtdD')
      and (TDBEditFocus(Self.Components[intContador]).Text = '') then
        TDBEditFocus(Self.Components[intContador]).Field.AsFloat := 0.0;

      if((TDBEditFocus(Self.Components[intContador]).Name) = 'dbeAcrMob')
      and (TDBEditFocus(Self.Components[intContador]).Text = '') then
        TDBEditFocus(Self.Components[intContador]).Field.AsFloat := 0.00;
    End;
  End;
end;

function TfrmCadDupNovasFormulas.VerificarNovaFormulaMovimentada: Boolean;
begin
  Try
    Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD FROM %0:s INNER JOIN DUP_CADDUP ON %1:s_ITETIN = DUP_MD5KEY WHERE DUP_CODNFM = :CODNFM',
              [qryTabela.FieldByName('NFM_CODNFM').AsString]);
  Except
    on E: Exception do raise;
  End;
end;


procedure TfrmCadDupNovasFormulas.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadDupNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  strNomeTabela := 'DUP_CADNFM';
  strNomeCampo  := 'NFM_CODNFM';
  qryTabela := qryCadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  dtsCadNfm.DataSet := qryTabela;

  btnAtivarNfm.Enabled := False;
  btnAjustarVolume.Enabled := not (qryTabela.State in [dsBrowse, dsInactive]);
  pHabilitarBotoes;
end;

procedure TfrmCadDupNovasFormulas.FormShow(Sender: TObject);
begin
  inherited;
  pBotaoAtivarNfm;
end;


procedure TfrmCadDupNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pInserirMascara;

  pHabilitarBotoes;

  blnUsaProCodigo := False;

  dbeCodigo.Enabled := False;
  pSetFocus(dbeDescri);
  dbeDtaCad.Field.AsDateTime := Date;

  qryTabela.fieldByName('NFM_ATIVO_').AsString := 'S';
  pBotaoAtivarNfm;

  btnAjustarVolume.Enabled := not (qryTabela.State in [dsBrowse, dsInactive]);
end;

procedure TfrmCadDupNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conDup, Nil, qryTabela, key, arrSel) Then
  Begin
    pHabilitarBotoes;
    pBotaoAtivarNfm;
    pCalcularTotalVolume;
    btnAjustarVolume.Enabled := not (qryTabela.State in [dsBrowse, dsInactive]);
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadDupNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  if VerificarNovaFormulaMovimentada then
  begin
    fMensagem('ATENÇÃO', 'Já existe movimentação para essa fórmula, por isso não é possivel alterá-la', ['&OK']);
    Exit;
  end;  
  
  inherited;

  pHabilitarBotoes;

  pBotaoAtivarNfm;

  if (qryTabela.State in [dsEdit]) then
    pInserirMascara;

  dbeCodigo.Enabled := False;

  If (dbeDescri.Enabled) Then
    pSetFocus(dbeDescri);

  pCalcularTotalVolume;
  btnAjustarVolume.Enabled := not (qryTabela.State in [dsBrowse, dsInactive]);    
end;

procedure TfrmCadDupNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin
  if not (fInformarBase) then
  begin
    fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos uma base!', ['&Ok']);
    pSetFocus(dbeForm01);
    Exit;
  end;

  if fValidarBasePreenchida then
  begin
    fMensagem('ATENÇÃO!', 'Alguma quantidade "concentrada" ou "diluída" foi preenchida sem que a "base" fosse informada!', ['&Ok']);
    Exit;
  end;

  if (fInformarDiluente) and (dbeCodDil.text = '') then
  begin
    fMensagem('ATENÇÃO!', 'Ao informar uma quantidade diluída, é necessário que o diluente seja preenchido!', ['&Ok']);
    pSetFocus(dbeCodDil);
    Exit;
  end;

  if not(fInformarDiluente) and (dbeCodDil.text <> '') then
  begin
    fMensagem('ATENÇÃO!', 'A Quantidade diluída deve ser preenchida ao informar o diluente!', ['&Ok']);
    Exit;
  end;

  if ((dbeQtdDil.text <> '0,000') and (not fEmptyStr(dbeQtdDil.text))) and (dbeCodDil.text = '') then
  begin
    fMensagem('ATENÇÃO!', 'Preencha o diluente para a quantidade Informada!', ['&Ok']);
    pSetFocus(dbeCodDil);
    Exit;
  end;

  if (dbeCodDil.text <> '') and ((dbeQtdDil.text = '0,000') or fEmptyStr(dbeQtdDil.text)) then
  begin
    fMensagem('ATENÇÃO!', 'Informe a quantidade do diluente!', ['&Ok']);
    pSetFocus(dbeQtdDil);
    Exit;
  end;

  blnInsert := (qryTabela.State = dsInsert);
  conf := fGetConfTinta('DUP');
  
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('NFMDUP');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP' + VS_strCodEmp + fStrZero(strNfmBri, 5);
  End;

  fStartTransaction;
  inherited;

  pHabilitarBotoes;
  pBotaoAtivarNfm;

  Try
    If (blnGravou) Then
    Begin

      Screen.Cursor := crHourGlass;

      If (fGeraNovasFormulas(qryTabela)) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NFMDUP', fStrZero(StrToInt(strNfmBri) + 1, 5));
        End;

        fCommit;
      End
      Else
        fRollBack;

      Screen.Cursor := crDefault;
      blnGravou := False;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;

  btnAjustarVolume.Enabled := not (qryTabela.State in [dsBrowse, dsInactive]);  
end;

procedure TfrmCadDupNovasFormulas.btnAtivarNfmClick(Sender: TObject);
begin
  if qryTabela.IsEmpty Then
    fMensagem('ATENÇÃO', 'Favor escolher um registro para essa operação!', ['&OK'])
  else
  begin
    dbeCodigo.text;

    inherited;

    If fMensagem('QUESTÃO', 'Deseja realmente ' + IIF(fRetStatusNfm(qryTabela.FieldByName('NFM_CODNFM').AsString) = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    begin
      pAtivarDesativarNfm;
      pBotaoAtivarNfm;
    end;

  end;
end;

procedure TfrmCadDupNovasFormulas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pHabilitarBotoes;
  pBotaoAtivarNfm;
  pCalcularTotalVolume;
  btnAjustarVolume.Enabled := not (qryTabela.State in [dsBrowse, dsInactive]);  
end;

procedure TfrmCadDupNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodigo: String;
begin
  if VerificarNovaFormulaMovimentada then
  begin
    fMensagem('ATENÇÃO', 'Já existe movimentação para essa fórmula, por isso não é possivel excluí-la', ['&OK']);
    Exit;
  end;

  strCodigo := qryTabela.FieldByName('NFM_CODNFM').AsString;

  fStartTransaction;
  inherited;

  pHabilitarBotoes;

  Try
    If (blnExcluiu) Then
    Begin
      pDeletaNovaFormula(strCodigo);
      blnExcluiu := False;
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnExcluirClick]');
    End;
  End;

  btnAjustarVolume.Enabled := not (qryTabela.State in [dsBrowse, dsInactive]);  
end;

procedure TfrmCadDupNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqBaseTinta(Self, conDup, TDBEditFocus(Sender), Nil, Nil, Key, arrSel) Then
     Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadDupNovasFormulas.dbeQtdC01Exit(Sender: TObject);
begin
  inherited;
  if fEmptyStr((Sender as TDBEditFocus).Text) Then
    (Sender as TDBEditFocus).Text := '0,000';
end;

destructor TfrmCadDupNovasFormulas.Destroy;
begin
  if Assigned(cdsBases) then FreeAndNil(cdsBases);
  inherited;
end;

function TfrmCadDupNovasFormulas.fInformarBase: Boolean;
var
  intContador : Integer;
begin
  Result := false;
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin
    If Self.Components[intContador] Is TDBEditFocus Then
    Begin
      if(LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeForm')
      and (TDBEditFocus(Self.Components[intContador]).Text <> '') then
        Result := true;
    End;
  End;
end;

function TfrmCadDupNovasFormulas.fInformarDiluente: Boolean;
begin
  Result := False;

  if (fStrToFloat(dbeQtdD01.text) > 0.000) or (fStrToFloat(dbeQtdD02.text) > 0.000) then  Result := true;
  if (fStrToFloat(dbeQtdD03.text) > 0.000) or (fStrToFloat(dbeQtdD04.text) > 0.000) then  Result := true;
  if (fStrToFloat(dbeQtdD05.text) > 0.000) or (fStrToFloat(dbeQtdD06.text) > 0.000) then  Result := true;
  if (fStrToFloat(dbeQtdD07.text) > 0.000) or (fStrToFloat(dbeQtdD08.text) > 0.000) then  Result := true;
  if (fStrToFloat(dbeQtdD09.text) > 0.000) or (fStrToFloat(dbeQtdD10.text) > 0.000) then  Result := true;
  if (fStrToFloat(dbeQtdD11.text) > 0.000) or (fStrToFloat(dbeQtdD12.text) > 0.000) then  Result := true;
  if (fStrToFloat(dbeQtdD13.text) > 0.000) or (fStrToFloat(dbeQtdD14.text) > 0.000) then  Result := true;
  if (fStrToFloat(dbeQtdD15.text) > 0.000) or (fStrToFloat(dbeQtdD16.text) > 0.000) then  Result := true;
  if (fStrToFloat(dbeQtdD17.text) > 0.000) or (fStrToFloat(dbeQtdD18.text) > 0.000) then  Result := true;
  if (fStrToFloat(dbeQtdD19.text) > 0.000) or (fStrToFloat(dbeQtdD20.text) > 0.000) then  Result := true;
end;

function TfrmCadDupNovasFormulas.fJaExisteEssaBaseNaFormulacao(
  strCodBas: String; dbeForm: TObject): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To 20 Do
  Begin
    If (RightStr(TDBEditFocus(dbeForm).Name, 2) <> fStrZero(intCont,2)) And
       (Not fEmptyStr(TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text)) Then
    Begin
      If TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text = strCodBas Then
        Result := True;
    End;
  End;

end;

procedure TfrmCadDupNovasFormulas.pCalcularTotalVolume;
var
  intCont: Integer;
  dbeComponente: TDBEditFocus;
  dbeQtdCon: TDBEditFocus;
  dbeQtdDil: TDBEditFocus;
begin
  fltTotalConcentrado := 0;
  fltTotalDiluido := 0;
  for intCont := 0 to ComponentCount - 1 do
  begin
    if LeftStr(Components[intCont].Name, 7) = 'dbeForm' then
    begin
      dbeComponente := TDBEditFocus(Components[intCont]);
      dbeQtdCon := TDBEditFocus(FindComponent('dbeQtdC' + RightStr(dbeComponente.Name, 2)));
      dbeQtdDil := TDBEditFocus(FindComponent('dbeQtdD' + RightStr(dbeComponente.Name, 2)));

      if cdsBases.FindKey([dbeComponente.Text]) then
      begin

        if dbeQtdCon.Field.AsFloat > 0 Then
          fltTotalConcentrado := fltTotalConcentrado + (fStrToFloat(dbeQtdCon.Text) / fStrToFloat(cdsBases.FieldByName('BAS_PESESP').AsString));

        if dbeQtdDil.Field.AsFloat > 0 Then
          fltTotalDiluido := fltTotalDiluido + (fStrToFloat(dbeQtdDil.Text) / fStrToFloat(cdsBases.FieldByName('BAS_PESESP').AsString));
      end;
    end;
  end;

  lblVolumeTotal.Caption := Format('Volume total: %.2f ml (Concentrado), %.2f ml (Diluído)', [fltTotalConcentrado, fltTotalDiluido]);
end;

procedure TfrmCadDupNovasFormulas.ConstruirCdsBases;
var
  strSql: string;
begin
  strSql :=
    ' SELECT                   ' +
    '   BAS_CODBAS             ' +
    '   , BAS_PESESP           ' +
    ' FROM                     ' +
    '   DUP_CADBAS             ';

  if fCfgSis('EMPBDU', varBoolean) then
    strSql := strSql + ' WHERE BAS_CODEMP = "' + VS_strCodEmp + '" ';

  cdsBases := fGeTUniClientDataSet(strSql, 'BAS_CODBAS', True);
end;

constructor TfrmCadDupNovasFormulas.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ConstruirCdsBases;
end;

procedure TfrmCadDupNovasFormulas.Ajustar;
var
  intCont: Integer;
  dbeComponente: TDBEditFocus;
  dbeQtdCon: TDBEditFocus;
  dbeQtdDil: TDBEditFocus;
begin
  pCalcularTotalVolume;

  for intCont := 0 to ComponentCount - 1 do
  begin
    if LeftStr(Components[intCont].Name, 7) = 'dbeForm' then
    begin
      dbeComponente := TDBEditFocus(Components[intCont]);
      dbeQtdCon := TDBEditFocus(FindComponent('dbeQtdC' + RightStr(dbeComponente.Name, 2)));
      dbeQtdDil := TDBEditFocus(FindComponent('dbeQtdD' + RightStr(dbeComponente.Name, 2)));

      if cdsBases.FindKey([dbeComponente.Text]) then
      begin
        if fltTotalConcentrado > 0 then
          dbeQtdCon.Field.AsFloat := dbeQtdCon.Field.AsFloat * 900 / fltTotalConcentrado;

        if fltTotalDiluido > 0 then
          dbeQtdDil.Field.AsFloat := dbeQtdDil.Field.AsFloat * 900 / fltTotalDiluido;
      end;
    end;
  end;

  pCalcularTotalVolume;
end;

procedure TfrmCadDupNovasFormulas.btnAjustarVolumeClick(Sender: TObject);
begin
  inherited;
  Ajustar;
end;

procedure TfrmCadDupNovasFormulas.pLigaDataSets;
var
  intCont: Integer;
begin

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadNfm;
    End;

    If (Components[intCont] is TDBMemoFocus) Then
    Begin
      (Components[intCont] as TDBMemoFocus).DataSource := dtsCadNfm;
    End;

    If (Components[intCont] is TDBCheckBox) Then
    Begin
      (Components[intCont] as TDBCheckBox).DataSource := dtsCadNfm;
    End;

    If (Components[intCont] is TDBComboBoxFocus) Then
    Begin
      (Components[intCont] as TDBComboBoxFocus).DataSource := dtsCadNfm;
    End;
  End;
end;

procedure TfrmCadDupNovasFormulas.pCriaDataSets;
Var
  intCont: Integer;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}

  qryCadNfm := fCriarQuery('SELECT * FROM DUP_CADNFM', Self);

  qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  qryCadNfm.FieldbyName('NFM_DESCRI').DisplayLabel := 'Descrição';
  qryCadNfm.FieldbyName('NFM_DTACAD').DisplayLabel := 'Data de Cadastro';
  qryCadNfm.FieldbyName('NFM_LINHA_').DisplayLabel := 'Linha';
  qryCadNfm.FieldbyName('NFM_QUALID').DisplayLabel := 'Qualidade';
  qryCadNfm.FieldbyName('NFM_ALTERN').DisplayLabel := 'Alternativa';
  qryCadNfm.FieldbyName('NFM_MONTAD').DisplayLabel := 'Montadora';
  qryCadNfm.FieldbyName('NFM_CODDIL').DisplayLabel := 'Código Diluente';
  qryCadNfm.FieldbyName('NFM_CODCAT').DisplayLabel := 'Código Catalisador';
  qryCadNfm.FieldbyName('NFM_CATALI').DisplayLabel := 'Catalise';
  qryCadNfm.FieldbyName('NFM_ATIVO_').DisplayLabel := 'Ativo';
  qryCadNfm.FieldbyName('NFM_ACRMOB').DisplayLabel := 'Acréscimo mão de obra';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 20 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
    TFloatField(qryCadNfm.FieldByName('NFM_QTDD' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
  End;

  TFloatField(qryCadNfm.FieldByName('NFM_QTDDIL')).DisplayFormat := '0.000';
  TFloatField(qryCadNfm.FieldByName('NFM_QTDCAT')).DisplayFormat := '0.000';
  TFloatField(qryCadNfm.FieldByName('NFM_ACRMOB')).DisplayFormat := '0.00';

  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;

procedure TfrmCadDupNovasFormulas.pHabilitarBotoes;
begin
  dbeLinha_.Enabled    := (qryCadNfm.State in [dsInsert,dsEdit]);
  btnAtivarNfm.Enabled := not(qryCadNfm.State in [dsInsert,dsEdit]);
end;

initialization
  RegisterClass(TfrmCadDupNovasFormulas);
finalization
  UnRegisterClass(TfrmCadDupNovasFormulas);
end.

