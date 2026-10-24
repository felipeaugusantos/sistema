unit untCadFarNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, EditFocus, DBEditFocus, untFarbenAutomotiva, Uni, StrUtils,
  DBComboBoxFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadFarNfm = class(TfrmPaiCad)
    Panel1: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    gpbColorantes: TGroupBox;
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
    Label27: TLabel;
    Label28: TLabel;
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
    edtDesMon: TEditFocus;
    dbeCodigo: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    dbeMontadora: TDBEditFocus;
    dbeOem: TDBEditFocus;
    dbeAno: TDBEditFocus;
    Label3: TLabel;
    dbeQtdCon01: TDBEditFocus;
    Label29: TLabel;
    dbeQtdCon02: TDBEditFocus;
    Label30: TLabel;
    dbeQtdCon03: TDBEditFocus;
    Label31: TLabel;
    dbeQtdCon04: TDBEditFocus;
    Label32: TLabel;
    dbeQtdCon05: TDBEditFocus;
    Label33: TLabel;
    dbeQtdCon06: TDBEditFocus;
    Label34: TLabel;
    dbeQtdCon07: TDBEditFocus;
    Label35: TLabel;
    dbeQtdCon08: TDBEditFocus;
    Label36: TLabel;
    dbeQtdCon09: TDBEditFocus;
    Label37: TLabel;
    dbeQtdCon10: TDBEditFocus;
    cbbLinha: TDBComboBoxFocus;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    dbeForm11: TDBEditFocus;
    dbeForm12: TDBEditFocus;
    dbeForm13: TDBEditFocus;
    dbeForm14: TDBEditFocus;
    dbeForm15: TDBEditFocus;
    dbeForm16: TDBEditFocus;
    dbeForm17: TDBEditFocus;
    dbeForm18: TDBEditFocus;
    dbeForm19: TDBEditFocus;
    dbeForm20: TDBEditFocus;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    dbeQtdC11: TDBEditFocus;
    dbeQtdC12: TDBEditFocus;
    dbeQtdC13: TDBEditFocus;
    dbeQtdC14: TDBEditFocus;
    dbeQtdC15: TDBEditFocus;
    dbeQtdC16: TDBEditFocus;
    dbeQtdC17: TDBEditFocus;
    dbeQtdC18: TDBEditFocus;
    dbeQtdC19: TDBEditFocus;
    dbeQtdC20: TDBEditFocus;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Labe65: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    dbeQtdCon11: TDBEditFocus;
    dbeQtdCon12: TDBEditFocus;
    dbeQtdCon13: TDBEditFocus;
    dbeQtdCon14: TDBEditFocus;
    dbeQtdCon15: TDBEditFocus;
    dbeQtdCon16: TDBEditFocus;
    dbeQtdCon17: TDBEditFocus;
    dbeQtdCon18: TDBEditFocus;
    dbeQtdCon19: TDBEditFocus;
    dbeQtdCon20: TDBEditFocus;
    Label67: TLabel;
    dbeAcrMob: TDBEditFocus;
    dbeDtaCad: TDBEditFocus;
    Label68: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeMontadoraKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeAcrMobExit(Sender: TObject);
  private
    farbenAutomotiva : TFarbenAutomotiva;
    qryCadMon: TUniQuery;
    procedure pIniciaCampos;
    procedure pAjustaTabela;
    procedure pCarregaMontadora;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
    procedure pInserirMascara;

    { Private declarations }
  public
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidaColorante(strCodCol: String): Boolean;
    { Public declarations }
  end;

var
  frmCadFarNfm: TfrmCadFarNfm;

implementation

uses  untFuncoesSimples, DB,
      untFuncTinta, untIConfTinta, untModuloTinta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadFarNfm }

procedure TfrmCadFarNfm.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_MONTAD');
  stlCampos.Add('NFM_O_E_M_');
  stlCampos.Add('NFM_A_N_O_');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('NFM_SETOR_');
  stlCampos.Add('NFM_LINHA_');
  stlCampos.Add('NFM_CODEMP');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_MONTAD');
  stlCamInd.Add('NFM_A_N_O_');
  stlCamInd.Add('NFM_DESCRI');


  stlDesInd.Add('Código');
  stlDesInd.Add('Montadora');
  stlDesInd.Add('Ano');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadFarNfm.pInserirMascara;
var
  intCont : Integer;
begin
  TFloatField(qryTabela.FieldByName('NFM_ACRMOB')).DisplayFormat := '0.00';
  qryTabela.FieldByName('NFM_ACRMOB').AsFloat := 0.00;

  for intCont := 1 to 20 do
  begin
    TFloatField(qryTabela.FieldByName('NFM_QTDD' + fStrZero(intCont, 2))).DisplayFormat   := '0.000';
    TFloatField(qryTabela.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.000';

    qryTabela.FieldByName('NFM_QTDD' + fStrZero(intCont, 2)).AsFloat := 0.000;
    qryTabela.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat := 0.000;
  end;

end;

procedure TfrmCadFarNfm.FormCreate(Sender: TObject);
begin
  inherited;
  farbenAutomotiva := TFarbenAutomotiva.Create;
  farbenAutomotiva.pIniciaCadNfm;
  pAjustaTabela;
  pIniciaCampos;
  pInicializaIndices;

  qryTabela := farbenAutomotiva.qryCadNfm;

  strNomeTabela := 'FAR_CADNFM';
  strNomeCampo  := 'AUTOINCREM';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  qryCadMon := fCriaQuery(Self);
end;


procedure TfrmCadFarNfm.pIniciaCampos;
  Var
    intCont : Integer;
begin

  For intCont := 0 To Self.ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEditFocus) Then
      (Components[intCont] as TDBEditFocus).DataSource := farbenAutomotiva.dtsCadNfm;

    If (Components[intCont] is TDBComboBoxFocus) Then
      (Components[intCont] as TDBComboBoxFocus).DataSource := farbenAutomotiva.dtsCadNfm;

  End;

  dbeCodigo.DataField    := 'NFM_CODNFM';
  dbeDescricao.DataField := 'NFM_DESCRI';
  cbbLinha.DataField     := 'NFM_LINHA_';
  dbeOem.DataField       := 'NFM_O_E_M_';
  dbeAno.DataField       := 'NFM_A_N_O_';
  dbeMontadora.DataField := 'NFM_MONTAD';
  dbeAcrMob.DataField    := 'NFM_ACRMOB';
  dbeDtaCad.DataField    := 'NFM_DTACAD';

  For intCont := 1 To 20 Do
  Begin
    TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont, 2))).DataField := 'NFM_CODB' + fStrZero(intCont, 2);
    TDBEditFocus(FindComponent('dbeQtdC' + fStrZero(intCont, 2))).DataField := 'NFM_QTDD' + fStrZero(intCont, 2);
    TDBEditFocus(FindComponent('dbeQtdCon' + fStrZero(intCont, 2))).DataField := 'NFM_QTDC' + fStrZero(intCont, 2);
  End;

end;

procedure TfrmCadFarNfm.pAjustaTabela;
  Var
    intRecNo : Integer;
begin
  intRecNo := farbenAutomotiva.qryCadNfm.RecNo;
  farbenAutomotiva.qryCadNfm.Close;
  farbenAutomotiva.qryCadNfm.Open;

  farbenAutomotiva.qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  farbenAutomotiva.qryCadNfm.FieldByName('NFM_MONTAD').DisplayLabel := 'Montadora';
  farbenAutomotiva.qryCadNfm.FieldByName('NFM_O_E_M_').DisplayLabel := 'Oem';
  farbenAutomotiva.qryCadNfm.FieldByName('NFM_A_N_O_').DisplayLabel := 'Ano';
  farbenAutomotiva.qryCadNfm.FieldByName('NFM_DESCRI').DisplayLabel := 'Descrição';
  farbenAutomotiva.qryCadNfm.FieldByName('NFM_SETOR_').DisplayLabel := 'Setor';
  farbenAutomotiva.qryCadNfm.FieldByName('NFM_LINHA_').DisplayLabel := 'Linha';
  farbenAutomotiva.qryCadNfm.FieldByName('NFM_DTACAD').DisplayLabel := 'Data Cadastro';

  farbenAutomotiva.qryCadNfm.FieldByName('NFM_CODEMP').Visible := False;
  farbenAutomotiva.qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  farbenAutomotiva.qryCadNfm.RecNo := intRecNo;
end;

procedure TfrmCadFarNfm.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  pAjustaTabela;

  If fPesqFormulaTinta(Self, conFar, Nil, qryTabela, key, arrSel) Then
  Begin

    if (dbeAcrMob.Text <> '') Then
      dbeAcrMob.Text := FormatFloat('#0.00', fStrToFloat(dbeAcrMob.Text));

    pCarregaMontadora;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadFarNfm.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  qryTabela.FieldByName('NFM_DTACAD').AsDateTime := Date;

  If qryTabela.State = dsInsert Then
  Begin
    dbeCodigo.Enabled := False;
    edtDesMon.Clear;
    pInserirMascara;
    pSetFocus(dbeDescricao);
  End;
end;

function TfrmCadFarNfm.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    dtaAno: TDateTime;
    strNumCol: String;
    strQtdC: String;
    strQtdCon: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeDescricao) Then
    Begin

      If (fEmptyStr(dbeDescricao.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = cbbLinha) Then
    Begin
      If fEmptyStr(cbbLinha.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A linha deve ser preenchida!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        If (StrLen(PAnsiChar(AnsiString(cbbLinha.Text))) < 2) or (Pos(cbbLinha.Text, 'PE_PA_ST_PU_NC_') <= 0) Then
        Begin
          fMensagem('ATENÇÃO', 'A linha só poder ser PE, PA, ST, PU e NC', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeAno) Then
    Begin
      If (Not fEmptyStr(dbeAno.Text)) and (Not TryStrToDate('01/01/' + dbeAno.Text, dtaAno)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O ano não é válido!', ['OK']);
        Result := False;
      End;

    End

    Else If (Sender = dbeMontadora) Then
    Begin

      If (Not fEmptyStr(dbeMontadora.Text)) Then
      Begin
        pCarregaMontadora;
        If (qryCadMon.FieldByName('FAR_CODMON').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa montadora não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = dbeForm01) Then
    Begin
      If (fEmptyStr(dbeForm01.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos 1 base!', ['&Ok']);
        Result := False;
      End
      Else If (Not fValidaColorante(dbeForm01.Text)) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Essa base não está cadastrada!', ['&Ok']);
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
            (Sender = dbeForm18) Or
            (Sender = dbeForm19) Or
            (Sender = dbeForm20) Then
    Begin

      If (fEmptyStr((TEdit(Sender).Text))) Then
      Begin
        pSetFocus(dbeQtdC20)
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

    Else If (LeftStr(Sender.Name, 6) = 'dbeQtd') Then
    Begin
      strNumCol := RightStr(Sender.Name, 2);
      If (Not fEmptyStr(TEdit(fComponentByName(gpbColorantes, 'dbeForm' + strNumCol)).Text)) Then
      Begin
        strQtdC := TEdit(FindComponent('dbeQtdC' + strNumCol)).Text;
        strQtdCon := TEdit(FindComponent('dbeQtdCon' + strNumCol)).Text;
        If ((fEmptyStr(strQtdC)) And (fEmptyStr(strQtdCon))) Then
        Begin
          fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade do colorante!', ['&Ok']);
          Sender := TWinControl(FindComponent('dbeQtdC' + strNumCol));
          Result := False;
        End
        Else If (Not fEmptyStr(strQtdC)) And (fStrToFloat(strQtdC) <= 0)
          And (fStrToFloat(strQtdCon) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade deve ser maior que zero!', ['&Ok']);
          Sender := TWinControl(FindComponent('dbeQtdC' + strNumCol));
          Result := False;
        End
        Else If (Not fEmptyStr(strQtdCon)) And (fStrToFloat(strQtdCon) <= 0)
          And (fStrToFloat(strQtdC) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade deve ser maior que zero!', ['&Ok']);
          Sender := TWinControl(FindComponent('dbeQtdCon' + strNumCol));
          Result := False;
        End;
      End;

    End

    Else If (Sender = dbeAcrMob) Then
    Begin
      dbeAcrMob.Text := FormatFloat('#0.00', fStrToFloat(dbeAcrMob.Text));

      If Not fEmptyStr(dbeAcrMob.Text) Then
      Begin
        If (fStrToFloat(dbeAcrMob.Text) < 0) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O Acréscimo de Mão de Obra deve ser maior ou igual a zero', ['OK']) = -1;
        End;
      End;
    End;

  End;


  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadFarNfm.dbeMontadoraKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqMontadoraTinta(Self, conFar, dbeMontadora, edtDesMon, nil, key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

function TfrmCadFarNfm.fJaExisteEssaBaseNaFormulacao(strCodBas: String;dbeForm: TObject): Boolean;
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

procedure TfrmCadFarNfm.pCarregaMontadora;
begin
  qryCadMon.Close;
  qryCadMon.SQL.Text := 'SELECT * FROM FAR_CADMON WHERE FAR_CODMON = :CODMON;';
  qryCadMon.ParamByName('CODMON').AsString := dbeMontadora.Text;
  qryCadMon.Open;
  edtDesMon.Text := qryCadMon.FieldByName('FAR_DESMON').AsString; //FAR_DESCRI
end;

procedure TfrmCadFarNfm.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('FAR');
  qryTabela     := farbenAutomotiva.qryCadNfm;
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('PROCOD'); //fArqIniTinta(0, 'Farben Automotiva', 'PROCOD', '0');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + fStrZero(strNfmBri, 5);
  End;

  inherited;

  dbeAcrMob.Text := FormatFloat('#0.00', qryTabela.FieldByName('NFM_ACRMOB').AsFloat);

  If (blnGravou) Then
  Begin
    Screen.Cursor := crHourGlass;
    If TFarbenAutomotivaNfm.fGravarNovaFormula(qryTabela) Then
    Begin
      If (blnInsert) Then
      Begin
        conf.pSet('PROCOD', fStrZero(StrToInt(strNfmBri) + 1, 5)); //fArqIniTinta(1, 'Farben Automotiva', 'PROCOD', fStrZero(StrToInt(strNfmBri) + 1, 5));
      End;
    End;
    Screen.Cursor := crDefault;
    blnGravou := False;
  End;
end;

function TfrmCadFarNfm.fValidaColorante(strCodCol: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FAR_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_CODBAS = :CODCOL ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCOL').AsString := strCodCol;
    Open;
    Result := (FieldByName('QTD').AsInteger > 0);
    Close;
  End;
end;

procedure TfrmCadFarNfm.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodigo.Enabled := False;
  dbeAcrMob.Text := FormatFloat('#0.00', fStrToFloat(dbeAcrMob.Text));
end;

procedure TfrmCadFarNfm.dbeAcrMobExit(Sender: TObject);
begin
  inherited;
  dbeAcrMob.Text := FormatFloat('#0.00', fStrToFloat(dbeAcrMob.Text));
 // dbeAcrMob.Field.AsFloat := fStrToFloat(dbeAcrMob.Text);
end;

procedure TfrmCadFarNfm.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
   arrSel: TConsultasArray;
begin
  If fPesqBaseTinta(Self, conFar, TEdit(Sender), Nil, Nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadFarNfm.btnExcluirClick(Sender: TObject);
  Var
    strCodNfm: String;
begin
  strCodNfm := dbeCodigo.Text;
  inherited;
  pExcluirNfm(strCodNfm);
  edtDesMon.Clear;

end;

initialization
  RegisterClass(TfrmCadFarNfm);
finalization
  UnRegisterClass(TfrmCadFarNfm);

end.

