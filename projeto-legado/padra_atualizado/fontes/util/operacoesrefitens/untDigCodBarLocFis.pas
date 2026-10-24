unit untDigCodBarLocFis;

interface

uses
  Uni,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, untIteBar, untCadLote, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, Vcl.ComCtrls, untLogAltCadIte,
  untLocFisAdicionais, QColorLabel, untAltEst;

type
  TfrmDigCodBarLocFis = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodIte: TEditFocus;
    edtLinGru: TEditFocus;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtDesUni: TEditFocus;
    edtDesMar: TEditFocus;
    edtNomFor: TEditFocus;
    btnConfirma: TBitBtnLocked;
    pagCadastros: TPageControl;
    tbsLocFis: TTabSheet;
    tbsEmbalagens: TTabSheet;
    pnlEmbalagens: TPanel;
    pnlLocalizacao: TPanel;
    Panel1: TPanel;
    Label6: TLabel;
    Label12: TLabel;
    lbl1: TLabel;
    edtLocFis: TEditFocus;
    edtSupEst: TEditFocus;
    edtTamLcf: TEditFocus;
    pnlLocFis: TPanel;
    edtCodLse: TEditFocus;
    lblLocSep: TLabel;
    edtDesLse: TEditFocus;
    shpTamLcf: TShape;
    shpLocFis: TShape;
    shpSupEst: TShape;
    shpLocSep: TShape;
    btnTransCod: TBitBtnLocked;
    tbsEstoque: TTabSheet;
    pnlEstoque: TPanel;
    lbl30: TLabel;
    lbl31: TLabel;
    edtEstMin: TEditFocus;
    edtEstMax: TEditFocus;
    Label67: TLabel;
    edtIteAti: TEditFocus;
    ColorLabel4: TColorLabel;
    shpIteAti: TShape;
    shpEstMin: TShape;
    shpEstMax: TShape;
    tbsPontoExposicao: TTabSheet;
    Panel2: TPanel;
    Label4: TLabel;
    shpPonExp: TShape;
    edtPonExp: TEditFocus;
    edtCodOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    lblCodOpe: TLabel;
    edtSitPro: TEditFocus;
    lblSitPro: TLabel;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodIteEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure edtSupEstKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodLseKeyPress(Sender: TObject; var Key: Char);
    procedure btnTransCodClick(Sender: TObject);
    procedure edtPonExpExit(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
  private
    curEstMin: Currency;
    curEstMax: Currency;
    blnPontoExposicao: Boolean;
    blnCadLoc: Boolean;
    objCadLot: TCadLot;
    qryConIte : TUniQuery;
    strTraLoc,
    strLocAnt : String;
    strSupAnt : String;
    strAtiAnt : String;
    objIteBar : TIteBar;
    objLocFis: TLocFisAdicionais;
    fltPonExp: Double;
    strCodOpe: String;

    intSitEmp : Integer;
    blnSitPro : Boolean;

    function fCarregaItem(strCodIte : String) : Boolean;
    procedure pVerdeVermelho; overload;
    procedure pVerdeVermelho(objEdit: TEditFocus; objShape: TShape; blnAcesso: Boolean); overload;
    procedure pLimpaCampos;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodBar: String;
    blnCarregandoDoMapeamento: Boolean;
  end;

var
  frmDigCodBarLocFis: TfrmDigCodBarLocFis;

implementation

uses untPesqAux, untFuncoesSimples, DB, untConsultas, untTypesSistema, untTPontoExposicao;

function TfrmDigCodBarLocFis.fCarregaItem(strCodIte : String) : Boolean;
  Var
    strSQL: String;
    qryGenIte: TUniQuery;
begin
  Result := False;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_CODITE AS "ITE_CODITE", ';
  strSQL := strSQL + '  I.ITE_CODGRU AS "ITE_CODGRU", ';
  strSQL := strSQL + '  P.GRU_DESGRU AS "GRU_DESGRU", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "ITE_DESITE", ';
  strSQL := strSQL + '  I.ITE_REFERE AS "ITE_REFERE", ';
  strSQL := strSQL + '  I.ITE_CODUNI AS "ITE_CODUNI", ';
  strSQL := strSQL + '  U.UNI_SIGUNI AS "UNI_SIGUNI", ';
  strSQL := strSQL + '  I.ITE_CODMAR AS "ITE_CODMAR", ';
  strSQL := strSQL + '  M.MAR_DESMAR AS "MAR_DESMAR", ';
  strSQL := strSQL + '  I.ITE_CODFOR AS "ITE_CODFOR", ';
  strSQL := strSQL + '  F.FOR_NOMFOR AS "FOR_NOMFOR", ';
  strSQL := strSQL + '  I.ITE_CODBAR AS "ITE_CODBAR", ';
  strSQL := strSQL + '  I.ITE_BAREMB AS "ITE_BAREMB", ';
  strSQL := strSQL + '  I.ITE_EMBALA AS "ITE_EMBALA", ';
  strSQL := strSQL + '  G.ITE_LOCFIS AS "ITE_LOCFIS", ';
  strSQL := strSQL + '  L.LSE_CODIGO AS "LSE_CODLSE", ';
  strSQL := strSQL + '  L.LSE_DESCRI AS "LSE_LOCSEP", ';
  strSQL := strSQL + '  G.ITE_LOCSUP AS "ITE_LOCSUP", ';
  strSQL := strSQL + '  G.ITE_TAMLCF AS "ITE_TAMLCF", ';
  strSQL := strSQL + '  I.ITE_ITEATI AS "ITE_ITEATI", ';
  strSQL := strSQL + '  G.ITE_ESTMIN AS "ITE_ESTMIN", ';
  strSQL := strSQL + '  G.ITE_PONEXP AS "ITE_PONEXP", ';
  strSQL := strSQL + '  G.ITE_ESTMAX AS "ITE_ESTMAX"  ';

  If blnSitPro Then
  Begin
    strSQL := strSQL + ' ,S.SIT_CODIGO AS "SIT_CODIGO" ';
    strSQL := strSQL + ' ,S.SIT_DESCRI AS "SIT_DESCRI" ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + '  INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE AND G.ITE_CODEMP = :CODEMP '; //Empresa Atual
  strSQL := strSQL + '   LEFT JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';
  strSQL := strSQL + '   LEFT JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR ';
  strSQL := strSQL + '   LEFT JOIN CADFOR F ON I.ITE_CODFOR = F.FOR_CODFOR ';
  strSQL := strSQL + '   LEFT JOIN CADGRU P ON I.ITE_CODGRU = P.GRU_CODGRU ';

  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
  begin
    strSQL := strSQL + '  LEFT JOIN CADLOC ON LOC_CODLOC = G.ITE_LOCFIS AND LOC_CODEMP = G.ITE_CODEMP ';
    strSQL := strSQL + '  LEFT JOIN CADLSE L ON L.LSE_CODIGO = LOC_CODLSE ';
  end
  else
    strSQL := strSQL + '  LEFT JOIN CADLSE L ON G.ITE_CODLSE = L.LSE_CODIGO ';

  If blnSitPro Then
  Begin
    If intSitEmp = 1 Then
      strSQL := strSQL + ' LEFT JOIN SITPRO S ON I.ITE_SITPRO = SIT_CODIGO '
    Else
      strSQL := strSQL + ' LEFT JOIN SITPRO S ON G.ITE_SITPRO = SIT_CODIGO ';
  End;

  strSQL := strSQL + '  LEFT JOIN ITEBAR B ON B.BAR_CODITE = I.ITE_CODITE ';

  strSQL := strSQL + 'WHERE ';

  If Length(strCodIte) <= fTamCodIte Then
  Begin
    strSQL    := strSQL + '  I.ITE_CODITE = :CODITE  ';
    strCodIte := fStrZero(strCodIte, fTamCodIte);
  End
  Else
  Begin
    strSQL := strSQL + '  (I.ITE_CODBAR = :CODITE OR ';
    strSQL := strSQL + '   I.ITE_BAREMB = :CODITE OR ';
    strSQL := strSQL + '   I.ITE_EMBALA = :CODITE OR ';
    strSQL := strSQL + '   B.BAR_CODBAR = :CODITE)   ';
  End;

  strSQL := strSQL + '  LIMIT 1                      ';

  qryGenIte := fCriaQuery(nil);

  With qryGenIte Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    If Not qryGenIte.IsEmpty Then
      Result := True;

    edtCodIte.Text := FieldByName('ITE_CODITE').AsString;
    edtLinGru.Text := FieldByName('ITE_CODGRU').AsString + ' - ' + FieldByName('GRU_DESGRU').AsString;
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
    edtPonExp.Text := FormatFloat('#,##0.00', FieldByName('ITE_PONEXP').AsFloat);
    fltPonExp      := FieldByName('ITE_PONEXP').AsFloat;
    edtRefere.Text := FieldByName('ITE_REFERE').AsString;
    edtDesUni.Text := FieldByName('UNI_SIGUNI').AsString;
    edtDesMar.Text := FieldByName('ITE_CODMAR').AsString + ' - ' + FieldByName('MAR_DESMAR').AsString;
    edtNomFor.Text := FieldByName('ITE_CODFOR').AsString + ' - ' + FieldByName('FOR_NOMFOR').AsString;
    edtLocFis.Text := FieldByName('ITE_LOCFIS').AsString;
    edtSupEst.Text := FieldByName('ITE_LOCSUP').AsString;
    edtTamLcf.Text := FieldByName('ITE_TAMLCF').AsString;

    If edtCodLse.Visible Then
    Begin
      edtCodLse.Text := FieldByName('LSE_CODLSE').AsString;
      edtDesLse.Text := FieldByName('LSE_LOCSEP').AsString;
    End;

    If blnSitPro Then
      edtSitPro.Text := FieldByName('SIT_CODIGO').AsString + ' - ' + FieldByName('SIT_DESCRI').AsString;

    strLocAnt      := FieldByName('ITE_LOCFIS').AsString;
    strSupAnt      := FieldByName('ITE_LOCSUP').AsString;

    strAtiAnt      := FieldByName('ITE_ITEATI').AsString;
    edtIteAti.Text := FieldByName('ITE_ITEATI').AsString;
    edtEstMin.Text := FormatFloat( '#,##0.000', FieldByName('ITE_ESTMIN').AsFloat );
    edtEstMax.Text := FormatFloat( '#,##0.000', FieldByName('ITE_ESTMAX').AsFloat );

    curEstMin := FieldByName('ITE_ESTMIN').AsFloat;
    curEstMax := FieldByName('ITE_ESTMAX').AsFloat;
  end;

  FreeAndNil(qryGenIte);

end;

{$R *.dfm}

procedure TfrmDigCodBarLocFis.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If (fEntraCons(Key)) And (Not edtCodIte.ReadOnly) Then
  Begin
    fPesqItem(conIteSimples, Self, edtCodIte, nil, qryConIte, Key, arrSel,  True, nil, 'Consulta de Itens', '1');
  End;

end;


procedure TfrmDigCodBarLocFis.edtCodLseKeyPress(Sender: TObject; var Key: Char);
  Var
    arrLocSep : TConsultasArray;
begin
  If Not edtCodLse.ReadOnly And fPesqLocSep(Self, edtCodLse, edtDesLse, Nil, Key, arrLocSep) Then
  Begin
    If fValidaCampos(edtCodLse, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigCodBarLocFis.edtCodOpeKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
Begin
  Try
    if fPesqOperador(Self, edtCodOpe, edtNomOpe, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodOpe, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  Except
    On E: Exception Do
    Begin
      fMensagem('', 'Erro na busca rápida: ' + E.Message, ['&O k']);
    End;
  End;
end;

procedure TfrmDigCodBarLocFis.edtLocFisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If Not edtLocFis.ReadOnly And blnCadLoc And
    fPesqLocFisica(Self, edtLocFis, Nil, Nil, Key, arrSel) And
    fValidaCampos(edtLocFis, True) Then SelectNext(ActiveControl, True, True);

end;

procedure TfrmDigCodBarLocFis.edtPonExpExit(Sender: TObject);
begin
  inherited;
  If edtPonExp.Text <> '' Then
    edtPonExp.Text := FormatFloat('#,##0.00', fStrToFloat(edtPonExp.Text));

end;

procedure TfrmDigCodBarLocFis.edtSupEstKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If Not edtSupEst.ReadOnly And blnCadLoc And
    fPesqLocFisica(Self, edtSupEst, Nil, Nil, Key, arrSel) And
    fValidaCampos(edtSupEst, True) Then SelectNext(ActiveControl, True, True);

end;

procedure TfrmDigCodBarLocFis.FormCreate(Sender: TObject);
  Var
    intLocFis,
    intLocSup,
    intTamLcf,
    intLocSep : Integer;
begin
  inherited;
  blnSitPro := fCfgSis('SITPRO', varBoolean);
  intSitEmp := fCfgSis('SITEMP', varInteger);

  If blnSitPro Then
  Begin
    edtSitPro.Visible := True;
    lblSitPro.Visible := True;
  End;

  blnCarregandoDoMapeamento := False;
  strCodBar := '';
  blnPontoExposicao := fCfgSis('PONEXP', varBoolean);
  tbsPontoExposicao.TabVisible := blnPontoExposicao;
  strTraLoc := fCfgSIs('TRALOC');
  blnCadLoc := fCfgSis('CADLOC', varBoolean);
  objCadLot := TCadLot.Create(Self);

  qryConIte := fCriaQuery(Self);

  objIteBar := TIteBar.Create(opcCadastro,
                              Nil,
                              Nil,
                              Nil,
                              Nil,
                              pnlEmbalagens,
                              edtCodIte.Text);

  shpLocSep.Visible := (fCfgSis('GRUSEP', VarString) = 'S');
  lblLocSep.Visible := (fCfgSis('GRUSEP', VarString) = 'S');
  edtCodLse.Visible := (fCfgSis('GRUSEP', VarString) = 'S');
  edtDesLse.Visible := (fCfgSis('GRUSEP', VarString) = 'S');

  pSetaCodLse(edtCodLse);

  if (fCfgSis('DCBOPE', VarString) = 'S') Then
  Begin
    lblCodOpe.Visible := True;
    EdtCodOpe.Visible := True;
    EdtNomOpe.Visible := True;
  End;

  If Not fUsaRotinaWMS Then
  Begin
    pagCadastros.ActivePageIndex := 0;

    objLocFis := TLocFisAdicionais.Create(Self, pnlLocFis);

    pVerdeVermelho;
    pTamanhoCamposLocFis(intLocFis, intLocSup, intTamLcf, intLocSep);

    With edtLocFis Do
    Begin
      TamCampo := intLocFis;
      MaxLength:= intLocFis;
    End;

    With edtSupEst Do
    Begin
      TamCampo := intLocSup;
      MaxLength:= intLocSup;
    End;

    With edtTamLcf Do
    Begin
      TamCampo := intTamLcf;
      MaxLength:= intTamLcf;
    End;
  End
  Else
  Begin
    tbsLocFis.TabVisible := False;
    pagCadastros.ActivePageIndex := 1;
  End;
end;

procedure TfrmDigCodBarLocFis.FormDestroy(Sender: TObject);
begin
  inherited;
  objIteBar.Destroy;

  If Assigned(objLocFis) Then
    FreeAndNil(objLocFis);
end;

procedure TfrmDigCodBarLocFis.edtCodIteExit(Sender: TObject);
begin
  inherited;

  edtCodIte.Text := StringReplace(edtCodIte.Text, #$D#$A, '', [rfReplaceAll]);

  If Not fEmptyStr(edtCodIte.Text) Then
  Begin
    If fCarregaItem(edtCodIte.Text) Then
    Begin
      objIteBar.pCarregaDados(edtCodIte.Text);
      objIteBar.pHabilitaEdicao(True);

      If Not fUsaRotinaWMS Then
      Begin
        objLocFis.fCarregaLocalizacoes(edtCodIte.Text, edtLocFis.Text);
        objLocFis.pHabilitaEdicao(True);
      End;

      btnConfirma.Enabled := True;
      edtLocFis.Enabled   := True;
      edtTamLcf.Enabled   := True;
      edtSupEst.Enabled   := True;

      If edtCodLse.Visible Then
        edtCodLse.Enabled   := True;

      pVerdeVermelho;

      pSetFocus(edtCodOpe);
    End
    Else
    Begin
      fMensagem('AVISO','Não Foi encontrado nenhum item!',['&O K']);
      pSetFocus(edtCodIte);
      edtLocFis.Enabled   := False;
      edtTamLcf.Enabled   := False;
      edtSupEst.Enabled   := False;

      If edtCodLse.Visible Then
        edtCodLse.Enabled   := False;

      objIteBar.pCarregaDados('');
      objIteBar.pHabilitaEdicao(False);

      If Not fUsaRotinaWMS Then
      Begin
        objLocFis.fCarregaLocalizacoes('', '');
        objLocFis.pHabilitaEdicao(False);
      End;
    End;
  End
  Else
    pLimpaCampos;

end;

procedure TfrmDigCodBarLocFis.pLimpaCampos;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtRefere.Clear;
  edtDesUni.Clear;
  edtDesMar.Clear;
  edtNomFor.Clear;
  edtLinGru.Clear;
  edtLocFis.Clear;
  edtSupEst.Clear;
  edtTamLcf.Clear;
  edtCodLse.Clear;
  edtDesLse.Clear;
  if edtCodOpe.Visible Then Begin
    edtCodOpe.Clear;
    edtNomOpe.Clear;
  End;

  edtLocFis.Enabled   := False;
  edtTamLcf.Enabled   := False;
  edtSupEst.Enabled   := False;
  edtCodLse.Enabled   := False;
  btnConfirma.Enabled := False;

  objIteBar.pCarregaDados('');
  objIteBar.pHabilitaEdicao(False);

  If Not fUsaRotinaWMS Then
  Begin
    objLocFis.fCarregaLocalizacoes('', '');
    objLocFis.pHabilitaEdicao(False);

    pagCadastros.ActivePageIndex := 0;
  End
  Else
  Begin
    pagCadastros.ActivePageIndex := 1;
  End;
end;

procedure TfrmDigCodBarLocFis.pVerdeVermelho;
begin
  If Not fUsaRotinaWMS Then
    objLocFis.pVerdeVermelho(fVerificaAcessoSistema('DIGBARLOC_LOCADI'));

  objIteBar.pVerdeVermelho(fVerificaAcessoSistema('DIGBARLOC_EMBALA'));

  Self.pVerdeVermelho(edtLocFis, shpLocFis, fVerificaAcessoSistema('DIGBARLOC_LOCFIS'));
  Self.pVerdeVermelho(edtTamLcf, shpTamLcf, fVerificaAcessoSistema('DIGBARLOC_CAPLOC'));
  Self.pVerdeVermelho(edtSupEst, shpSupEst, fVerificaAcessoSistema('DIGBARLOC_LOCSUP'));
  Self.pVerdeVermelho(edtCodLse, shpLocSep, fVerificaAcessoSistema('DIGBARLOC_LOCSEP'));

  Self.pVerdeVermelho(edtIteAti, shpIteAti, fVerificaAcessoSistema('DIGBARLOC_ITEATI'));
  Self.pVerdeVermelho(edtEstMin, shpEstMin, fVerificaAcessoSistema('DIGBARLOC_ESTMIN'));
  Self.pVerdeVermelho(edtEstMax, shpEstMax, fVerificaAcessoSistema('DIGBARLOC_ESTMAX'));
  Self.pVerdeVermelho(edtPonExp, shpPonExp, fVerificaAcessoSistema('DIGBARLOC_PONEXP'));
end;

procedure TfrmDigCodBarLocFis.pVerdeVermelho(objEdit: TEditFocus; objShape: TShape; blnAcesso: Boolean);
begin
  objEdit.ReadOnly     := Not blnAcesso;
  objShape.Brush.Color := IIF(blnAcesso, clGreen, clRed);
end;

procedure TfrmDigCodBarLocFis.btnConfirmaClick(Sender: TObject);
  Var
    qryUpdate : TUniQuery;
    strCodIte: String;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  If (fCfgSis('CODBAR') <> '4') And (Not objIteBar.fVerificaCodBar(edtCodIte.Text)) Then
  Begin
    objIteBar.pFocaCodBarras;
    Exit;
  End;

  Try
    strCodIte := edtCodIte.Text;

    fStartTransaction;

    objIteBar.pSalvaDados(edtCodIte.Text, True);

    If Not fUsaRotinaWMS Then
    Begin
      If Not objLocFis.fSalvaLocalizacoes(edtCodIte.Text) Then
      Begin
        fRollBack;
        Exit;
      End;
    End;

    TAltEst.fGravaLog(Self,
                      edtCodIte.Text,
                      vs_strCodEmp,
                      fStrToFloat(edtEstMin.Text),
                      fStrToFloat(edtEstMax.Text),
                      (curEstMin <> fStrToFloat(edtEstMin.Text)),
                      (curEstMax <> fStrToFloat(edtEstMax.Text)),
                      strCodOpe
                      );

    qryUpdate := fCriaQuery(Nil);

    With qryUpdate Do
    Begin
      If Not fUsaRotinaWMS Then
      Begin
        Close;

        SQL.Clear;
        SQL.Add(' UPDATE  ');
        SQL.Add('   ITEGER  ');
        SQL.Add(' SET ITE_LOCFIS = :LOCFIS, ');
        SQL.Add('     ITE_TAMLCF = :TAMLCF, ');
        SQL.Add('     ITE_ESTMIN = :ESTMIN, ');
        SQL.Add('     ITE_ESTMAX = :ESTMAX, ');

        If edtCodLse.Visible Then
          SQL.Add('     ITE_CODLSE = :CODLSE, ');

        SQL.Add('     ITE_LOCSUP = :LOCSUP  ');
        SQL.Add(' WHERE ITE_CODITE = :CODITE AND ');
        SQL.Add('       ITE_CODEMP = :CODEMP ');

        ParamByName('LOCFIS').AsString  := edtLocFis.Text;
        ParamByName('TAMLCF').AsString  := edtTamLcf.Text;
        ParamByName('ESTMIN').AsFloat   := fStrToFloat(edtEstMin.Text);
        ParamByName('ESTMAX').AsFloat   := fStrToFloat(edtEstMax.Text);

        If edtCodLse.Visible Then
          ParamByName('CODLSE').AsString  := edtCodLse.Text;

        ParamByName('LOCSUP').AsString  := edtSupEst.Text;
        ParamByName('CODITE').AsString  := edtCodIte.Text;
        ParamByName('CODEMP').AsString  := VS_strCodEmp;

        ExecSQL;
      End;

      If blnPontoExposicao And (fltPonExp <> StrToFloat(StringReplace(edtPonExp.Text, '.', '', [rfReplaceAll]))) Then
        pAtualizaPontoExposicao(nil, edtCodIte.Text, strLoginUsuarioLogado, VS_strCodEmp,fltPonExp, StrToFloat(edtPonExp.Text));

      If strAtiAnt <> edtIteAti.Text Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' UPDATE CADITE SET ITE_ITEATI = :ITEATI WHERE ITE_CODITE = :CODITE ');

        ParamByName('ITEATI').AsString  := edtIteAti.Text;
        ParamByName('CODITE').AsString  := edtCodIte.Text;
        ExecSQL;
      End;

      If fGeraLogLocFis(strLocAnt, edtLocFis.Text) Then
      Begin
        fGravaLogLocFisica(edtCodIte.Text,
                           strLocAnt,
                           edtLocFis.Text, 1, '', strCodOpe);

        TLogAltCadIte.pGravaLogAlteracaoIndividual(edtCodIte.Text,
                                                   'LOC. FISIC',
                                                   strLocAnt,
                                                   edtLocFis.Text);

      End;

      If fGeraLogLocFis(strSupAnt, edtSupEst.Text) Then
      Begin
        fGravaLogLocFisica(edtCodIte.Text,
                           strSupAnt,
                           edtSupEst.Text, 2, '', strCodOpe);

        TLogAltCadIte.pGravaLogAlteracaoIndividual(edtCodIte.Text,
                                                   'SUPER EST',
                                                   strSupAnt,
                                                   edtSupEst.Text);
      End;


      pLimpaCampos;
      pSetFocus(edtCodIte);

    End;


    fCommit;

    FreeAndNil(qryUpdate);

  Except

    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmDigCodBarLocFis.btnConfirmaClick]');
    End;

  End;

end;

procedure TfrmDigCodBarLocFis.btnSairClick(Sender: TObject);
begin
  inherited;

  objIteBar.pCancela;

  If Not fUsaRotinaWMS Then
    objLocFis.pCancela;
end;

procedure TfrmDigCodBarLocFis.btnTransCodClick(Sender: TObject);
  Var
    strCodIte: String;
begin
  inherited;

  If fEmptyStr(edtCodIte.Text) Then
  Begin
    pMensagemOk('Informe um item para a transferência!');
    Exit;
  End;

  strCodIte := edtCodIte.Text;

  If btnConfirma.Enabled Then
    btnConfirma.Click;

  strCodBar := fRetCodBarra(strCodIte);

  Close;
end;

procedure TfrmDigCodBarLocFis.edtCodIteEnter(Sender: TObject);
begin
  inherited;
  If Not blnCarregandoDoMapeamento Then
    pLimpaCampos;
end;

procedure TfrmDigCodBarLocFis.FormShow(Sender: TObject);
begin
  inherited;
  If blnCarregandoDoMapeamento Then
  Begin
    edtCodIteExit(Sender);
    Exit;
  End;
  if fEmptyStr(edtCodIte.Text) then
    pSetFocus(edtCodIte);
end;

procedure TfrmDigCodBarLocFis.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
     VK_F10: If (btnConfirma.Enabled) Then
               btnConfirma.Click;

     VK_ESCAPE: Close;

     VK_F5:  btnTransCod.Click;
  End;

end;

function TfrmDigCodBarLocFis.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
   Var
     strItem, strLote: String;
     fltPonExp, fltSalIte, fltSalML: Double;
begin
  Result := True;

  If (Sender = edtLocFis) Then
  Begin

    If blnCadLoc Then
    Begin

      If (Not fEmptyStr(edtLocFis.Text)) Then
      Begin

        If fEmptyStr(fRetNomLocFisica(edtLocFis.Text, '', True)) Then
        Begin
          pMensagemOk('Localização Física não encontrada!');
          Result := False;
        End;

        If (strTraLoc <> 'N') And (Result) Then
        Begin

          If objCadLot.fTemProdutoComLocFisica(edtLocFis.Text, strItem, fltSalIte, fltSalML, edtCodIte.Text) Then
          Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' já está cadastrado com essa localização física!');
            If (strTraLoc = 'T') Then
              Result := False;
          End

          Else If objCadLot.fTemProdutoComLocAdicional(edtLocFis.Text, strItem, fltSalIte, fltSalML, edtCodIte.Text) Then
          Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' já está cadastrado com essa localização física adicional!');
            If (strTraLoc = 'T') Then
              Result := False;
          End

          Else If objCadLot.fTemLoteComLocFisica(edtLocFis.Text, strItem, strLote, fltSalIte, fltSalML) Then
          Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' (' + objCadLot.strTitLab + strLote + ') já está cadastrado com essa localização física!');
            If (strTraLoc = 'T') Then
              Result := False;
          End;

        End;

      End;

    End
    Else
    Begin

      If Not fEmptyStr(edtLocFis.Text) Then
      Begin

        strItem := fLocFisUtilizada(edtLocFis.Text, edtCodIte.Text);

        If (Not fEmptyStr(strItem)) And (strTraLoc <> 'N') Then
        Begin
          fMensagem('ATENÇÃO!', 'Localização física utilizada no produto: ' + #13 + strItem, ['&Ok']);
          If (strTraLoc = 'T') Then
            Result := False;
        End;

      End;

    End;

    If Not fUsaRotinaWMS Then
    Begin
      If Result And (Not fEmptyStr(edtLocFis.Text)) And
         objLocFis.fTemLocalizacaoAdicional(edtLocFis.Text) Then
      Begin
        pMensagemOk('A Localização Física ' + edtLocFis.Text + ' já está cadastrada em Localizações Físicas Adicionais!');
        Result := False;
      End;
    End;

    If Result Then
      If Not fUsaRotinaWMS Then
        objLocFis.pSetaLocalizacaoPrincipal(edtLocFis.Text);

  End
  Else If (Sender = edtCodOpe) And (edtCodOpe.Visible) Then
  Begin

    If fEmptyStr(edtCodOpe.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O operador deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      edtNomOpe.Text := fRetNomeOperador(edtCodOpe.Text);
      If fEmptyStr(edtNomOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse operador não foi encontrado!', ['&O k']);
        Result := False;
      End
      Else If (strCodOpe <> edtCodOpe.Text) Then
      Begin

        If (ffrmSenha(strSenha)) Then
        Begin

          If (strSenha <> fDecrypt(fCampoTabela('OPE_SENOPE', 'CADOPE', ['OPE_CODOPE'], [edtCodOpe.Text]))) Then
          Begin
            fMensagem('ATENÇÃO!', 'Senha Invalida!', ['&O k']);
            edtNomOpe.Clear;
            Result := False;
          End
          Else
            strCodOpe := edtCodOpe.Text;
        End
        Else
        Begin
          Result := False;
        End;

      End;

    End;

  End
  Else If (Sender = edtSupEst) Then
  Begin

    If blnCadLoc Then
    Begin

      If (Not fEmptyStr(edtSupEst.Text)) Then
      Begin

        If fEmptyStr(fRetNomLocFisica(edtSupEst.Text,'', True)) Then
        Begin
          pMensagemOk('Localização de Super Estoque não encontrada!');
          Result := False;
        End;

        If (strTraLoc <> 'N') And (Result) Then
        Begin
          If objCadLot.fTemProdutoComLocFisica(edtSupEst.Text, strItem, fltSalIte, fltSalML, edtCodIte.Text, True) Then
          Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' já está cadastrado com essa localização física!');
            If (strTraLoc = 'T') Then
              Result := False;
          End

          Else If objCadLot.fTemProdutoComLocAdicional(edtSupEst.Text, strItem, fltSalIte, fltSalML, edtCodIte.Text) Then
          Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' já está cadastrado com essa localização física adicional!');
            If (strTraLoc = 'T') Then
              Result := False;
          End

          Else If objCadLot.fTemLoteComLocFisica(edtSupEst.Text, strItem, strLote, fltSalIte, fltSalML) Then
          Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' (' + objCadLot.strTitLab + strLote + ') já está cadastrado com essa localização física!');
            If (strTraLoc = 'T') Then
              Result := False;
          End;
        End;

      End;

    End;

  End

  Else If (Sender = edtCodLse) Then
  Begin
    If Not fEmptyStr(edtCodLse.Text) Then
    Begin
      edtDesLse.Text := fRetLocSep(edtCodLse.Text);
      If fEmptyStr(edtDesLse.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Localização de Separação não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtPonExp) Then
  Begin
    If (edtPonExp.Text = '') Then
      edtPonExp.Text := '0,00';
    fltPonExp := fStrToFloat(edtPonExp.Text);
    If  fltPonExp < 0 Then
    Begin
      edtPonExp.Text := '0,00';
      fMensagem('ATENÇÃO!', 'O Ponto de Exposição deve ser maior ou igual a zero!', ['&Ok']);
      Result := False;
    End

    Else If Result Then
    Begin
      blnMudarFoco := False;
      pSetFocus(btnConfirma);
    End;
  End

  Else If (Sender = edtIteAti) And (not edtIteAti.ReadOnly) Then
  Begin
    Result := Pos(edtIteAti.Text, 'S_N_') > 0;
    If Not Result Then
      fMensagem('', 'O campo Ativo deve conter "S" ou "N"!', ['&Ok']);
  End

  Else If (Sender = edtEstMin) And (not edtEstMin.ReadOnly) Then
  Begin
    If fEmptyStr(edtEstMin.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Mínimo deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtEstMin.Text) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Mínimo deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtEstMax) And (not edtEstMax.ReadOnly) Then
  Begin
    If fEmptyStr(edtEstMax.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Máximo deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtEstMax.Text) < fStrToFloat(edtEstMin.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Máximo deve ser maior ou igual ao Estoque Mínimo!', ['&Ok']);
      Result := False;
    End;

    If Result Then
    Begin
      blnMudarFoco := False;
      pSetFocus(btnConfirma);
    End;

  End;


  If Not Result Then
    pSetFocus(Sender);

end;

end.

