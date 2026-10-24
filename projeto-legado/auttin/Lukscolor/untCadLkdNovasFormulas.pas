unit untCadLkdNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadLkdNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbeCodNfm: TDBEditFocus;
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
    dbeCodBas: TDBEditFocus;
    Label2: TLabel;
    dbeProKey: TDBEditFocus;
    Label6: TLabel;
    dbeUnidad: TDBEditFocus;
    Label5: TLabel;
    Label27: TLabel;
    dbeSubKey: TDBEditFocus;
    Label28: TLabel;
    dbeDtaCad: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodBasKeyPress(Sender: TObject; var Key: Char);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fBaseCadastrada(strCodBas: String; strProKey: String = ''; strSubKey: String = ''; strUnidad: String = ''): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pApagaCadLkdNfm(CodPro : String);
  public
    { Public declarations }
  end;

var
  frmCadLkdNovasFormulas: TfrmCadLkdNovasFormulas;

implementation

uses
  untPai,
  untFuncoesSimples, untLukscolorImobiliaria,
  untIConfTinta, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadLkdNovasForumulas }

function TfrmCadLkdNovasFormulas.fBaseCadastrada(strCodBas: String;
  strProKey: String = ''; strSubKey: String = ''; strUnidad: String = ''): Boolean;
var
  strSQL: String;
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  BAS_DESCRI ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  LKD_CADBAS ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  BAS_BASE__ = :CODBAS ';
      If (Not fEmptyStr(strProKey)) Then
        strSQL := strSQL + '  AND BAS_PROKEY = :PROKEY ';

      If (Not fEmptyStr(strSubKey)) Then
        strSQL := strSQL + '  AND BAS_SUBKEY = :SUBKEY ';

      If (Not fEmptyStr(strUnidad)) Then
        strSQL := strSQL + '  AND BAS_UNIDAD = :UNIDAD ';

      qryGen := fCriaQuery();
      
      qryGen.SQL.Add(strSQL);
      qryGen.ParamByName('CODBAS').AsString := strCodBas;
      If (Not fEmptyStr(strProKey)) Then
        qryGen.ParamByName('PROKEY').AsString := strProKey;

      If (Not fEmptyStr(strSubKey)) Then
        qryGen.ParamByName('SUBKEY').AsString := strSubKey;

      If (Not fEmptyStr(strUnidad)) Then
        qryGen.ParamByName('UNIDAD').AsString := strUnidad;

      qryGen.Open;
      Result := (Not qryGen.IsEmpty);
      If (fEmptyStr(dbeDescri.Field.AsString)) And
         (qryTabela.State <> dsBrowse)         And
         (Result)                              Then
      Begin
        dbeDescri.Field.AsString := qryGen.FieldByName('BAS_DESCRI').AsString;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function TfrmCadLkdNovasFormulas.fJaExisteEssaBaseNaFormulacao(
  strCodBas: String; dbeForm: TObject): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To 10 Do
  Begin
    If (RightStr(TDBEditFocus(dbeForm).Name, 2) <> fStrZero(intCont,2)) And
       (Not fEmptyStr(TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text)) Then
    Begin
      If TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text = strCodBas Then
        Result := True;
    End;
  End;

end;

function TfrmCadLkdNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumCol: String;
begin

  Result := True;

  If (Sender = dbeCodNfm) Then
  Begin
  End

  Else If (Sender = dbeCodBas) Then
  Begin
    If (fEmptyStr(dbeCodBas.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeCodBas.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeProKey) Then
  Begin
    If (fEmptyStr(dbeProKey.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Prod. Key deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeCodBas.Text, dbeProKey.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeSubKey) Then
  Begin
    If (fEmptyStr(dbeSubKey.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Sub. Key deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeCodBas.Text, dbeProKey.Text, dbeSubKey.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End

  {*****************************************}
  {* VALIDA A UNIDADE                      *}
  {**************************************MV*}
  Else If (Sender = dbeUnidad) Then
  Begin

    If (fEmptyStr(dbeUnidad.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&O k']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeCodBas.Text, dbeProKey.Text, dbeSubKey.Text, dbeUnidad.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      Result := False;
    End;
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
      fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos 1 colorante!', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaColorante(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Colorante não encontrado!', ['&Ok']);
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
          (Sender = dbeForm10) Then
  Begin
    If (fEmptyStr((TEdit(Sender).Text))) Then
    Begin
      pSetFocus(dbeQtdC10)
    End
    Else If (Not fValidaColorante(TEdit(Sender).Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Colorante não encontrado!', ['&Ok']);
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
          (Sender = dbeQtdC10) Then
  Begin
    strNumCol := RightStr(Sender.Name, 2);
    If (Not fEmptyStr(TEdit(fComponentByName(gpbColorantes, 'dbeForm' + strNumCol)).Text)) Then
    Begin
      If (fEmptyStr(TEdit(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade do colorante!', ['&Ok']);
        Result := False;
      End;
      If (fStrToFloat(TEdit(Sender).Text)) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade do colorante deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadLkdNovasFormulas.fValidaColorante(
  strCodCol: String): Boolean;
var
  strSQL: String;
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  COUNT(*) AS QTD ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  LKD_CADCOL ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  COL_CODCOL = :CODCOL ';

      qryGen := fCriaQuery();
      qryGen.SQL.Text := strSQL;
      qryGen.ParamByName('CODCOL').AsString := strCodCol;
      qryGen.Open;
      Result := (qryGen.FieldByName('QTD').AsInteger > 0);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadLkdNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODPRO');
  stlCampos.Add('NFM_BASE__');
  stlCampos.Add('NFM_UNIDAD');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_BASE__+NFM_PROKEY+NFM_SUBKEY');
  stlCamInd.Add('NFM_DESCRI');
  stlDesInd.Add('Base/Prod. Key/Sub. Key');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadLkdNovasFormulas.pLigaDataSets;
var
  intCont: Integer;
begin

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadNfm;
    End;
  End;

  dbeCodNfm.DataField := 'NFM_CODPRO';
  dbeCodBas.DataField := 'NFM_BASE__';
  dbeProKey.DataField := 'NFM_PROKEY';
  dbeSubKey.DataField := 'NFM_SUBKEY';
  dbeUnidad.DataField := 'NFM_UNIDAD';
  dbeDescri.DataField := 'NFM_DESCRI';
  dbeDtaCad.DataField := 'NFM_DTACAD';

  For intCont := 1 To 10 Do
  Begin
    TDBEdit(FindComponent('dbeForm' + fStrZero(intCont, 2))).DataField := 'NFM_COL0' + fStrZero(intCont, 2);
    TDBEdit(FindComponent('dbeQtdC' + fStrZero(intCont, 2))).DataField := 'NFM_QTD0' + fStrZero(intCont, 2);
  End;
end;

procedure TfrmCadLkdNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  strNomeTabela := 'LKD_CADNFM';
  strNomeCampo  := 'NFM_CODPRO';
  qryTabela     := qryCadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodNfm;

end;

procedure TfrmCadLkdNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  qryTabela.FieldByName('NFM_DTACAD').AsDateTime := Date;
  dbeCodNfm.Enabled := False;
  pSetFocus(dbeCodBas);
end;

procedure TfrmCadLkdNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conLkd, Nil, qryTabela, key, arrSel) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadLkdNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodNfm.Enabled := False;
  dbeCodBas.Enabled := False;
  dbeProKey.Enabled := False;
  dbeSubKey.Enabled := False;
  dbeUnidad.Enabled := False;
  If (dbeDescri.Enabled) Then
    pSetFocus(dbeDescri);
end;

procedure TfrmCadLkdNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin
  qryTabela     := qryCadNfm;
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    conf := fGetConfTinta('LKS');
    strNfmBri := conf.fGet('NFMLKS');
    qryTabela.FieldByName('NFM_CODPRO').AsString := 'ESP ' + VS_strCodEmp + fStrZero(strNfmBri, 5);
  End;
  qryTabela.FieldByName('NFM_EMBALA').AsFloat := 1.0;

  fStartTransaction;
  inherited;
  
  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If (fGravaNovaFormula(qryTabela)) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSetInteger('NFMLKS', StrToInt(strNfmBri) + 1);
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
end;

procedure TfrmCadLkdNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strLkdCod : String;
begin
  strLkdCod := qryTabela.FieldByName('NFM_CODPRO').AsString;
  fStartTransaction;
  inherited;

  Try
    If (blnExcluiu) Then
    Begin
      pApagaCadLkdNfm(strLkdCod);
      blnExcluiu := False;
      fCommit;
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


procedure TfrmCadLkdNovasFormulas.pApagaCadLkdNfm(CodPro: String);
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'DELETE FROM LKD_CADLKD WHERE LKD_CODIGO = :CODPRO';
  qryGen.ParamByName('CODPRO').AsString := CodPro;
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

procedure TfrmCadLkdNovasFormulas.pCriaDataSets;
var
  intCont: Integer;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}

  qryCadNfm := fCriarQuery('SELECT * FROM LKD_CADNFM', Self);

  qryCadNfm.FieldByName('NFM_CODPRO').DisplayLabel := 'Código';
  qryCadNfm.FieldbyName('NFM_BASE__').DisplayLabel := 'Base';
  qryCadNfm.FieldbyName('NFM_DESCRI').DisplayLabel := 'Descrição';
  qryCadNfm.FieldbyName('NFM_EMBALA').DisplayLabel := 'Embalagem';
  qryCadNfm.FieldbyName('NFM_UNIDAD').DisplayLabel := 'Unidade';
  qryCadNfm.FieldbyName('NFM_PROKEY').DisplayLabel := 'Produt Key';
  qryCadNfm.FieldbyName('NFM_SUBKEY').DisplayLabel := 'Sub Produt Key';
  qryCadNfm.FieldbyName('NFM_DTACAD').DisplayLabel := 'Data Cadastro';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 6 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTD0' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
  End;

  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;


procedure TfrmCadLkdNovasFormulas.dbeCodBasKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryAux: TUniQuery;
begin
  inherited;
  qryAux := fCriaQuery;
  Try
    If fPesqBaseTinta(Self, conLkd, TDBEditFocus(Sender), Nil, qryAux, Key, arrSel) Then
    begin
      qryTabela.FieldByName('NFM_PROKEY').AsString := qryAux.FieldByName('BAS_PROKEY').AsString;
      qryTabela.FieldByName('NFM_SUBKEY').AsString := qryAux.FieldByName('BAS_SUBKEY').AsString;
      qryTabela.FieldByName('NFM_UNIDAD').AsString := qryAux.FieldByName('BAS_UNIDAD').AsString;
      qryTabela.FieldByName('NFM_DESCRI').AsString := qryAux.FieldByName('BAS_DESCRI').AsString;
      pSetFocus(dbeProKey);
    end;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmCadLkdNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqColorantes(Self, conLkd, TEdit(Sender), nil, nil, key, arrSel) Then
    If fValidaCampos(TEdit(Sender), True) Then
        SelectNext(ActiveControl, True, True);
end;

initialization
  RegisterClass(TfrmCadLkdNovasFormulas);
finalization
  UnRegisterClass(TfrmCadLkdNovasFormulas);

end.

