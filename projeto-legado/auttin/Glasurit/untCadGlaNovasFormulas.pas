unit untCadGlaNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, AppEvnts,
  DBComboBoxFocus, BitBtnLockedIncrem, Uni, frxClass, frxExportCSVTestabilidade,
  TypInfo;

type
  TfrmCadGlaNovasFormulas = class(TfrmPaiCad)
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
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
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
    dbeForm09: TDBEditFocus;
    dbeQtdC09: TDBEditFocus;
    dbeForm10: TDBEditFocus;
    dbeQtdC10: TDBEditFocus;
    Label2: TLabel;
    dbeDtaCad: TDBEditFocus;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    dbeForm11: TDBEditFocus;
    dbeForm12: TDBEditFocus;
    dbeForm13: TDBEditFocus;
    dbeForm14: TDBEditFocus;
    dbeForm15: TDBEditFocus;
    dbeForm16: TDBEditFocus;
    dbeForm17: TDBEditFocus;
    dbeForm18: TDBEditFocus;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    dbeQtdC11: TDBEditFocus;
    dbeQtdC12: TDBEditFocus;
    dbeQtdC13: TDBEditFocus;
    dbeQtdC14: TDBEditFocus;
    dbeQtdC15: TDBEditFocus;
    dbeQtdC16: TDBEditFocus;
    dbeQtdC17: TDBEditFocus;
    dbeQtdC18: TDBEditFocus;
    Label32: TLabel;
    dbeLinha_: TDBComboBoxFocus;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    dbeQtdD01: TDBEditFocus;
    dbeQtdD02: TDBEditFocus;
    dbeQtdD03: TDBEditFocus;
    dbeQtdD04: TDBEditFocus;
    dbeQtdD05: TDBEditFocus;
    dbeQtdD06: TDBEditFocus;
    dbeQtdD07: TDBEditFocus;
    dbeQtdD08: TDBEditFocus;
    dbeQtdD09: TDBEditFocus;
    dbeQtdD10: TDBEditFocus;
    Label33: TLabel;
    Label42: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    dbeQtdD11: TDBEditFocus;
    dbeQtdD12: TDBEditFocus;
    dbeQtdD13: TDBEditFocus;
    dbeQtdD14: TDBEditFocus;
    dbeQtdD15: TDBEditFocus;
    dbeQtdD16: TDBEditFocus;
    dbeQtdD17: TDBEditFocus;
    dbeQtdD18: TDBEditFocus;
    lblInformativo: TLabel;
    Label43: TLabel;
    dbeAcrMob: TDBEditFocus;
    Label44: TLabel;
    lblVolumeTotal: TLabel;
    btnAjustarVolume: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure dbeQtdC01Exit(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAjustarVolumeClick(Sender: TObject);
  private
    intPrxNfm: Integer;
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    qryBases: TUniQuery;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    Procedure ConstruirQryBasesVolume;
    Procedure pCalcularTotalVolume;
    procedure AjustarVolume;
    Function GetStrState(): String;
    function VerificarNovaFormulaMovimentada: Boolean;
    function fVerificaNovFormulas(strCodNfm: String): Boolean;
    function fValidarBasePreenchida: Boolean;
    function fValidarQntConcDiluida: Boolean;
    procedure pInserirMascara;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;

    { Private declarations }
  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadGlaNovasFormulas: TfrmCadGlaNovasFormulas;
  fltTotalConcentrado: Double;
  fltTotalDiluido: Double;


implementation

uses
  untModuloTinta, untPai, untGlasurit,
  untFuncoesSimples, untIConfTinta,
  untFuncTinta, untGlasuritDinamica, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadGlaNovasForumulas }

function TfrmCadGlaNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumCol: String;
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
      Result := False;
    End;
  End

  Else If (Sender = dbeForm02) Or
          (Sender = dbeForm03) Or
          (Sender = dbeForm04) Or
          (Sender = dbeForm05) Or
          (Sender = dbeForm06) Or
          (Sender = dbeForm07) Or
          (Sender = dbeForm08) Or
          (Sender = dbeForm09) Or
          (Sender = dbeForm10) Or
          (Sender = dbeForm11) Or
          (Sender = dbeForm12) Or
          (Sender = dbeForm13) Or
          (Sender = dbeForm14) Or
          (Sender = dbeForm15) Or
          (Sender = dbeForm16) Or
          (Sender = dbeForm17) Or
          (Sender = dbeForm18) Then
  Begin
    If (fEmptyStr((TEdit(Sender).Text))) Then
    Begin
      pSetFocus(dbeQtdD18)
    End
    Else If (Not fValidaColorante(TEdit(Sender).Text)) Then
    Begin
      Result := False;
    End
    Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeQtdC01) Or
          (Sender = dbeQtdC02) Or
          (Sender = dbeQtdC02) Or
          (Sender = dbeQtdC03) Or
          (Sender = dbeQtdC04) Or
          (Sender = dbeQtdC05) Or
          (Sender = dbeQtdC06) Or
          (Sender = dbeQtdC07) Or
          (Sender = dbeQtdC08) Or
          (Sender = dbeQtdC09) Or
          (Sender = dbeQtdC10) Or
          (Sender = dbeQtdC11) Or
          (Sender = dbeQtdC12) Or
          (Sender = dbeQtdC12) Or
          (Sender = dbeQtdC13) Or
          (Sender = dbeQtdC14) Or
          (Sender = dbeQtdC15) Or
          (Sender = dbeQtdC16) Or
          (Sender = dbeQtdC17) Or
          (Sender = dbeQtdC18) Then
  Begin
    strNumCol := RightStr(Sender.Name, 2);
    If (Not fEmptyStr(TEdit(fComponentByName(gpbColorantes, 'dbeForm' + strNumCol)).Text)) Then
    Begin
      If (fEmptyStr(TEdit(Sender).Text)) Then
      Begin
//        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade do colorante!', ['&Ok']);
 //       Result := False;
      End
      Else If (fStrToFloat(TEdit(Sender).Text) <= 0) Then
      Begin
        if fStrToFloat(TDBEditFocus(FindComponent('dbeQtdD' + strNumCol)).Text) <= 0 then
        begin
//          fMensagem('ATENÇÃO!', 'A quantidade deve ser maior que zero!', ['&Ok']);
//          Result := False;
        end;
      End;
    End;
  End
  Else If (Sender = dbeLinha_) Then
  Begin
    If (fEmptyStr(dbeLinha_.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Linha deve ser preenchida!', ['&Ok']);
      Result := False;
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

  if not Result then
    pSetFocus(Sender);

end;

function TfrmCadGlaNovasFormulas.fValidaColorante(
  strCodCol: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  GLA_CADBAS ';
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

procedure TfrmCadGlaNovasFormulas.pInicializaIndices;
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

procedure TfrmCadGlaNovasFormulas.pInserirMascara;
var
  intContador : Integer;
begin
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin
    If Self.Components[intContador] Is TDBEditFocus Then
    Begin
      if(LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeQtdC')
      and (TDBEditFocus(Self.Components[intContador]).Text = '') then
        TDBEditFocus(Self.Components[intContador]).Field.AsFloat := 0.000;

      if(LeftStr((TDBEditFocus(Self.Components[intContador]).Name), 7) = 'dbeQtdD')
      and (TDBEditFocus(Self.Components[intContador]).Text = '') then
        TDBEditFocus(Self.Components[intContador]).Field.AsFloat := 0.000;

      if((TDBEditFocus(Self.Components[intContador]).Name) = 'dbeAcrMob')
      and (TDBEditFocus(Self.Components[intContador]).Text = '') then
        TDBEditFocus(Self.Components[intContador]).Field.AsFloat := 0.00;
    End;
  End;
end;

procedure TfrmCadGlaNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;
  ConstruirQryBasesVolume;

  qryTabela := qryCadNfm;
  strNomeTabela := 'GLA_CADNFM';
  strNomeCampo  := 'NFM_CODNFM';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
  dbeLinha_.Enabled := False;
  dbeAcrMob.Enabled := False;
end;

procedure TfrmCadGlaNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pInserirMascara;

  blnUsaProCodigo := False;

  dbeCodigo.Enabled := False;
  dbeLinha_.Enabled := True;
  dbeAcrMob.Enabled := True;
  pSetFocus(dbeLinha_);
  dbeDtaCad.Field.AsDateTime := Date;
  btnAjustarVolume.Enabled := Not MatchStr(GetStrState,  ['dsBrowse', 'dsInactive']);
end;

procedure TfrmCadGlaNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conGla, Nil, qryTabela, key, arrSel) Then
  Begin
    pSetFocus(btnAlterar);
    dbeLinha_.Enabled := False;
    dbeAcrMob.Enabled := True;
  End;
  pCalcularTotalVolume;
end;

procedure TfrmCadGlaNovasFormulas.AjustarVolume;
var
  iContador: Integer;
begin
  pCalcularTotalVolume;

  For iContador := 1 To 18 Do
  Begin
    If qryBases.Locate('BAS_CODBAS', qryCadNfm.FieldByName('NFM_CODB' + fStrZero(iContador,2)).AsString, []) Then
    Begin
      If fltTotalConcentrado > 0 Then
        qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(iContador, 2)).AsFloat := qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(iContador, 2)).AsFloat * 1000 / fltTotalConcentrado;

      If fltTotalDiluido > 0 Then
        qryCadNfm.FieldByName('NFM_QTDD' + fStrZero(iContador, 2)).AsFloat := qryCadNfm.FieldByName('NFM_QTDD' + fStrZero(iContador, 2)).AsFloat * 1000 / fltTotalDiluido;
    End;
  End;

  pCalcularTotalVolume;
end;

procedure TfrmCadGlaNovasFormulas.ConstruirQryBasesVolume;
begin
  qryBases := fCriaQuery;
  qryBases.Close;
  qryBases.SQL.Clear;
  qryBases.SQL.Add('SELECT BAS_CODBAS, BAS_PESBAS FROM GLA_CADBAS;');
  qryBases.Open;
end;

procedure TfrmCadGlaNovasFormulas.btnAjustarVolumeClick(Sender: TObject);
var
  iContador: Integer;
  sQtdCon: String;
  sQtdDil: String;
begin
  fltTotalConcentrado := 0;
  fltTotalDiluido     := 0;

  AjustarVolume;

  For iContador := 1 To 18 Do
  Begin
    sQtdCon := qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(iContador, 2)).AsString;
    sQtdDil := qryCadNfm.FieldByName('NFM_QTDD' + fStrZero(iContador, 2)).AsString;

    If qryBases.Locate('BAS_CODBAS', qryCadNfm.FieldByName('NFM_CODB' + fStrZero(iContador, 2)).AsString, []) Then
    Begin
      fltTotalConcentrado := fltTotalConcentrado + (fStrToFloat(sQtdCon) / fStrToFloat(qryBases.FieldByName('BAS_PESBAS').AsString));
      fltTotalDiluido     := fltTotalDiluido     + (fStrToFloat(sQtdDil) / fStrToFloat(qryBases.FieldByName('BAS_PESBAS').AsString));
    End;
  End;
end;

procedure TfrmCadGlaNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  if VerificarNovaFormulaMovimentada then
  begin
    fMensagem('ATENÇÃO', 'Já existe movimentação para essa fórmula, por isso não é possivel alterá-la', ['&OK']);
    Exit;
  end;

  inherited;

  if (qryTabela.State = dsEdit) then
    pInserirMascara;

  dbeCodigo.Enabled := False;
  dbeLinha_.Enabled := True;
  dbeAcrMob.Enabled := True;
  btnAjustarVolume.Enabled := Not MatchStr(GetStrState,  ['dsBrowse', 'dsInactive']);
  pCalcularTotalVolume;

  If (dbeDescri.Enabled) Then
    pSetFocus(dbeDescri);
end;

procedure TfrmCadGlaNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    blnGravouNfm: Boolean;
    conf: IConfTinta;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  if fValidarQntConcDiluida then
  begin
    fMensagem('ATENÇÃO!', 'Existe base preenchida sem quantidade informada!', ['&Ok']);
    Exit;
  end;

  if fValidarBasePreenchida then
  begin
    fMensagem('ATENÇÃO!', 'Alguma quantidade "concentrada" ou "diluída" foi preenchida sem que a "base" fosse informada!', ['&Ok']);
    Exit;
  end;

  conf      := fGetConfTinta('GLA');
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    intPrxNfm := Conf.fGetInteger('NFMGLA');

    Repeat
      strNfmBri := fStrZero(IntToStr(intPrxNfm), 5);

      qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + strNfmBri;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(qryTabela.FieldByName('NFM_CODNFM').AsString));
  End;

  Try
    inherited;

    If (blnGravou) Then
    Begin
      blnGravouNfm := fGeraNovasFormulasDinamica(qryTabela);

      If (blnGravouNfm) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NFMGLA', fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5));
        End;

        fCommit;
      End
      Else
        fRollBack;

      btnAjustarVolume.Enabled := Not MatchStr(GetStrState,  ['dsBrowse', 'dsInactive']);

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
end;

procedure TfrmCadGlaNovasFormulas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dbeLinha_.Enabled := False;
  dbeAcrMob.Enabled := False;
  btnAjustarVolume.Enabled := Not MatchStr(GetStrState,  ['dsBrowse', 'dsInactive']);
  pCalcularTotalVolume;
end;

procedure TfrmCadGlaNovasFormulas.btnExcluirClick(Sender: TObject);
var
  strCodigo: String;
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  if VerificarNovaFormulaMovimentada then
  begin
    fMensagem('ATENÇÃO', 'Já existe movimentação para essa fórmula, por isso não é possivel alterá-la', ['&OK']);
    Exit;
  end;

  strCodigo := qryTabela.FieldByName('NFM_CODNFM').AsString;

  Try
    inherited;

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
      pMensagensErro(E.Message, '[TfrmCadGlaNovasFormulas.btnExcluirClick]');
    End;
  End;
end;

procedure TfrmCadGlaNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqBaseTinta(Self, conGla, TDBEditFocus(Sender), nil, nil, Key, arrSel) Then
    If (fValidaCampos(TDBEditFocus(Sender))) Then
        Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadGlaNovasFormulas.dbeQtdC01Exit(Sender: TObject);
begin
  inherited;
  if fEmptyStr((Sender as TDBEditFocus).Text) Then
    (Sender as TDBEditFocus).Text := '0,000';
end;

function TfrmCadGlaNovasFormulas.fJaExisteEssaBaseNaFormulacao(
  strCodBas: String; dbeForm: TObject): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To 18 Do
  Begin
    If (RightStr(TDBEditFocus(dbeForm).Name, 2) <> fStrZero(intCont,2)) And
       (Not fEmptyStr(TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text)) Then
    Begin
      If TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text = strCodBas Then
        Result := True;
    End;
  End;

end;

procedure TfrmCadGlaNovasFormulas.pCalcularTotalVolume;
var
  iContador: Integer;
  sQtdCon: String;
  sQtdDil: String;
begin
  fltTotalConcentrado := 0;
  fltTotalDiluido     := 0;

  For iContador := 1 To 18 Do
  Begin
    sQtdCon := qryCadNfm.FieldByName('NFM_QTDB' + fstrZero(iContador,2)).AsString;
    sQtdDil := qryCadNfm.FieldByName('NFM_QTDD' + fstrZero(iContador,2)).AsString;

    If qryBases.Locate('BAS_CODBAS', qryCadNfm.FieldByName('NFM_CODB' + fStrZero(iContador, 2)).AsString, []) Then
    Begin
      fltTotalConcentrado := fltTotalConcentrado + (fStrToFloat(sQtdCon) / fStrToFloat(qryBases.FieldByName('BAS_PESBAS').AsString));
      fltTotalDiluido     := fltTotalDiluido     + (fStrToFloat(sQtdDil) / fStrToFloat(qryBases.FieldByName('BAS_PESBAS').AsString));
    End;
  End;

  lblVolumeTotal.Caption := Format('Volume total: %.2f ml (Concentrado), %.2f ml (Diluído)', [fltTotalConcentrado, fltTotalDiluido]);
end;

procedure TfrmCadGlaNovasFormulas.pCriaDataSets;
var
  intCont: Integer;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}

  qryCadNfm := fCriarQuery('SELECT * FROM GLA_CADNFM', Self);

  qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  qryCadNfm.FieldbyName('NFM_DESCRI').DisplayLabel := 'Descrição';
  qryCadNfm.FieldbyName('NFM_DTACAD').DisplayLabel := 'Data Cadastro';
  qryCadNfm.FieldbyName('NFM_ACRMOB').DisplayLabel := 'Acréscimo mão de obra';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 18 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
    TFloatField(qryCadNfm.FieldByName('NFM_QTDD' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
  End;

  TFloatField(qryCadNfm.FieldByName('NFM_ACRMOB')).DisplayFormat := '0.00';

  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;

function TfrmCadGlaNovasFormulas.fValidarQntConcDiluida: Boolean;
begin
  result  := false;

  if (dbeForm01.text <> '') and (dbeQtdC01.text = '0,000') and (dbeQtdD01.text = '0,000') then result  := true;
  if (dbeForm02.text <> '') and (dbeQtdC02.text = '0,000') and (dbeQtdD02.text = '0,000') then result  := true;
  if (dbeForm03.text <> '') and (dbeQtdC03.text = '0,000') and (dbeQtdD03.text = '0,000') then result  := true;
  if (dbeForm04.text <> '') and (dbeQtdC04.text = '0,000') and (dbeQtdD04.text = '0,000') then result  := true;
  if (dbeForm05.text <> '') and (dbeQtdC05.text = '0,000') and (dbeQtdD05.text = '0,000') then result  := true;
  if (dbeForm06.text <> '') and (dbeQtdC06.text = '0,000') and (dbeQtdD06.text = '0,000') then result  := true;
  if (dbeForm07.text <> '') and (dbeQtdC07.text = '0,000') and (dbeQtdD07.text = '0,000') then result  := true;
  if (dbeForm08.text <> '') and (dbeQtdC08.text = '0,000') and (dbeQtdD08.text = '0,000') then result  := true;
  if (dbeForm09.text <> '') and (dbeQtdC09.text = '0,000') and (dbeQtdD09.text = '0,000') then result  := true;
  if (dbeForm10.text <> '') and (dbeQtdC10.text = '0,000') and (dbeQtdD10.text = '0,000') then result  := true;
  if (dbeForm11.text <> '') and (dbeQtdC11.text = '0,000') and (dbeQtdD11.text = '0,000') then result  := true;
  if (dbeForm12.text <> '') and (dbeQtdC12.text = '0,000') and (dbeQtdD12.text = '0,000') then result  := true;
  if (dbeForm13.text <> '') and (dbeQtdC13.text = '0,000') and (dbeQtdD13.text = '0,000') then result  := true;
  if (dbeForm14.text <> '') and (dbeQtdC14.text = '0,000') and (dbeQtdD14.text = '0,000') then result  := true;
  if (dbeForm15.text <> '') and (dbeQtdC15.text = '0,000') and (dbeQtdD15.text = '0,000') then result  := true;
  if (dbeForm16.text <> '') and (dbeQtdC16.text = '0,000') and (dbeQtdD16.text = '0,000') then result  := true;
  if (dbeForm17.text <> '') and (dbeQtdC17.text = '0,000') and (dbeQtdD17.text = '0,000') then result  := true;
  if (dbeForm18.text <> '') and (dbeQtdC18.text = '0,000') and (dbeQtdD18.text = '0,000') then result  := true;
end;


function TfrmCadGlaNovasFormulas.fVerificaNovFormulas(
  strCodNfm: String): Boolean;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Text := '';
    qryGen.SQL.Text := qryGen.SQL.Text +  '  SELECT                                 ';
    qryGen.SQL.Text := qryGen.SQL.Text +  '    *  FROM  ' + strNomeTabela + '       ';
    qryGen.SQL.Text := qryGen.SQL.Text +  '  WHERE  ' + strNomeCampo  + ' = :NFM    ';
    qryGen.ParamByName('NFM').AsString := strCodNfm;
    qryGen.Open;

    Result := qryGen.IsEmpty;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmCadGlaNovasFormulas.GetStrState: String;
begin
  Result := GetEnumName(TypeInfo(TDataSetState), Integer(qryCadNfm.State));
end;

function TfrmCadGlaNovasFormulas.fValidarBasePreenchida: Boolean;
begin
  result  := false;

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
end;

procedure TfrmCadGlaNovasFormulas.pLigaDataSets;
var
  intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadNfm;
    End;

    If (Components[intCont] is TDBComboBoxFocus) Then
    Begin
      (Components[intCont] as TDBComboBoxFocus).DataSource := dtsCadNfm;
    End;
  End;
end;

function TfrmCadGlaNovasFormulas.VerificarNovaFormulaMovimentada: Boolean;
begin
  Try
    Result := fVerificarNovaFormulaMovimentada(' SELECT                              ' +
      '   COUNT(0) AS QTD                   ' +
      ' FROM                                ' +
      '   %0:s                              ' +
      '   INNER JOIN GLA_CADGLA             ' +
      '     ON %1:s_ITETIN = CONCAT(         ' +
      '         IFNULL(GLA_LINHA_, '''')    ' +
      '       , IFNULL(GLA_MONTAD, '''')    ' +
      '       , IFNULL(GLA_DESCRI, '''')    ' +
      '       , IFNULL(GLA_CODPRO, '''')    ' +
      '       , IFNULL(GLA_ANOCOR, '''')    ' +
      '       , IFNULL(GLA_VARIAC, '''')    ' +
      '       , IFNULL(GLA_FORM01, '''')    ' +
      '       , IFNULL(GLA_QTDB01, ''0.0'') ' +
      '       , IFNULL(GLA_FORM02, '''')    ' +
      '       , IFNULL(GLA_QTDB02, ''0.0'') ' +
      '       , IFNULL(GLA_FORM03, '''')    ' +
      '       , IFNULL(GLA_QTDB03, ''0.0'') ' +
      '       , IFNULL(GLA_FORM04, '''')    ' +
      '       , IFNULL(GLA_QTDB04, ''0.0'') ' +
      '       , IFNULL(GLA_FORM05, '''')    ' +
      '       , IFNULL(GLA_QTDB05, ''0.0'') ' +
      '       , IFNULL(GLA_FORM06, '''')    ' +
      '       , IFNULL(GLA_QTDB06, ''0.0'') ' +
      '       , IFNULL(GLA_FORM07, '''')    ' +
      '       , IFNULL(GLA_QTDB07, ''0.0'') ' +
      '       , IFNULL(GLA_FORM08, '''')    ' +
      '       , IFNULL(GLA_QTDB08, ''0.0'') ' +
      '       , IFNULL(GLA_FORM09, '''')    ' +
      '       , IFNULL(GLA_QTDB09, ''0.0'') ' +
      '       , IFNULL(GLA_FORM10, '''')    ' +
      '       , IFNULL(GLA_QTDB10, ''0.0'') ' +
      '       , IFNULL(GLA_FORM11, '''')    ' +
      '       , IFNULL(GLA_QTDB11, ''0.0'') ' +
      '       , IFNULL(GLA_FORM12, '''')    ' +
      '       , IFNULL(GLA_QTDB12, ''0.0'') ' +
      '       , IFNULL(GLA_FORM13, '''')    ' +
      '       , IFNULL(GLA_QTDB13, ''0.0'') ' +
      '       , IFNULL(GLA_FORM14, '''')    ' +
      '       , IFNULL(GLA_QTDB14, ''0.0'') ' +
      '       , IFNULL(GLA_FORM15, '''')    ' +
      '       , IFNULL(GLA_QTDB15, ''0.0'') ' +
      '       , IFNULL(GLA_FORM16, '''')    ' +
      '       , IFNULL(GLA_QTDB16, ''0.0'') ' +
      '       , IFNULL(GLA_FORM17, '''')    ' +
      '       , IFNULL(GLA_QTDB17, ''0.0'') ' +
      '       , IFNULL(GLA_FORM18, '''')    ' +
      '       , IFNULL(GLA_QTDB18, ''0.0'') ' +
      '       , IFNULL(GLA_FORM19, '''')    ' +
      '       , IFNULL(GLA_QTDB19, ''0.0'') ' +
      '       , IFNULL(GLA_FORM20, '''')    ' +
      '       , IFNULL(GLA_QTDB20, ''0.0'') ' +
      '     )                               ' +
      ' WHERE %1:s_IDEPRO = "GLA"          ' +
      '   AND GLA_CODPRO = :CODNFM          ',
      [qryTabela.FieldByName('NFM_CODNFM').AsString]);
  Except
    on E: Exception do raise;
  End;
end;

initialization
  RegisterClass(TfrmCadGlaNovasFormulas);
finalization
  UnRegisterClass(TfrmCadGlaNovasFormulas);

end.

