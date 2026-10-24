unit untCadFutNovasFormulasDin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade ;

type
  TfrmCadFutNovasFormulasDin = class(TfrmPaiCad)
    pnlCentral: TPanel;
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
    dbeCodPro: TDBEditFocus;
    Label2: TLabel;
    dbeBase: TDBEditFocus;
    Label6: TLabel;
    dbeUnidad: TDBEditFocus;
    Label27: TLabel;
    dbeProd: TDBEditFocus;
    Label28: TLabel;
    dbeSProd: TDBEditFocus;
    Panel1: TPanel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodProKeyPress(Sender: TObject; var Key: Char);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
  private
    { Private declarations }
    dtsCadNfm: TDataSource;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fBaseCadastrada(strCodFml: String; strBase: String; strProd: String; strSProd: String): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pLigarDataSets;        
  public
    { Public declarations }
  end;

var
  frmCadFutNovasFormulasDin: TfrmCadFutNovasFormulasDin;

implementation

uses
     untIConfTinta, untFuncTinta,untModuloTinta, untPai,  untFuncoesSimples, untFuturaDinamica, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadFutNovasForumulas }

function TfrmCadFutNovasFormulasDin.fBaseCadastrada(strCodFml: String; strBase: String; strProd: String; strSProd: String): Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
  conf: IConfTinta;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      conf := fGetConfTinta('FUT');
      strSQL := '';
      strSQL := strSQL + ' SELECT * ';
      strSQL := strSQL + ' FROM FUT_CADBAS ';
      strSQL := strSQL + ' WHERE BAS_CODUNI = "' + conf.fGet('FUTQUA') + '" ';
      strSQL := strSQL + '     AND BAS_CODFML = :CODFML ';
      strSQL := strSQL + '     AND BAS_DESCRI = :DESCRI ';
      strSQL := strSQL + '     AND BAS_PRODUT = :PRODUT ';

      qryGen := fCriaQuery(Self);

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODFML').AsString  := strCodFml;
        ParamByName('DESCRI').AsString  := strBase;
        ParamByName('PRODUT').AsString  := strProd;

        Open;
        Result := (Not IsEmpty);
        Close;
      End;
    Except
      on E: Exception do raise;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function TfrmCadFutNovasFormulasDin.fJaExisteEssaBaseNaFormulacao(
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

function TfrmCadFutNovasFormulasDin.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumCol: String;
begin

  Result := True;

  If (Sender = dbeCodNfm) Then
  Begin
  End

  Else If (Sender = dbeCodPro) or (Sender = dbeBase) or (Sender = dbeProd) or (Sender = dbeSProd) Then
  Begin
    If fEmptyStr(dbeCodPro.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Not fBaseCadastrada(dbeCodPro.Text, dbeBase.Text, dbeProd.Text, dbeSProd.Text) Then
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

    Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
      Result := False;
    End

    Else If (Not fValidaColorante(TEdit(Sender).Text)) Then
    Begin
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
  End
end;

function TfrmCadFutNovasFormulasDin.fValidaColorante(
  strCodCol: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FUT_CADCOL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COL_CODCOL = :CODCOL ';

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

procedure TfrmCadFutNovasFormulasDin.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_CODPRO');
  stlCampos.Add('NFM_BASE__');
  stlCampos.Add('NFM_UNIDAD');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_DESCRI');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadFutNovasFormulasDin.pLigarDataSets;
  Var
    intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadNfm;
    End;
  End;
end;

procedure TfrmCadFutNovasFormulasDin.FormCreate(Sender: TObject);
begin
  inherited;
  dtsCadNfm := fCriaDataSource(frmModuloTinta.qryFut_CadNfm);
  pLigarDataSets;
  
  strNomeTabela := 'FUT_CADNFM';
  strNomeCampo  := 'NFM_CODNFM';
  qryTabela     := frmModuloTinta.qryFut_CadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodNfm;

end;

procedure TfrmCadFutNovasFormulasDin.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  frmModuloTinta.qryFut_CadNfm.FieldByName('NFM_UNIDAD').AsString := 'LT';

  dbeCodNfm.Enabled := False;
  pSetFocus(dbeCodPro);
end;

procedure TfrmCadFutNovasFormulasDin.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conFut, Nil, qryTabela, key, arrSel) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadFutNovasFormulasDin.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodNfm.Enabled := False;
  dbeCodPro.Enabled := False;
  dbeBase.Enabled   := False;
  {If (dbeUnidad.Enabled) Then
    pSetFocus(dbeUnidad);}
  If (dbeDescri.Enabled) Then
    pSetFocus(dbeDescri);  
end;

procedure TfrmCadFutNovasFormulasDin.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf     : iConfTinta;
begin
  conf      := fGetConfTinta('FUT');
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('NFMFUT'); //fArqIniTinta(0, 'FUTURA', 'NFMFUT', '0');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + fStrZero(strNfmBri, 5);
  End;
  inherited;

  If (blnGravou) Then
  Begin
    Screen.Cursor := crHourGlass;
    If (TFuturaImobiliariaDinamica.fGravaNovaFormula(qryTabela)) Then
    Begin
      If (blnInsert) Then
      Begin
        conf.pSet('NFMFUT', fStrZero(StrToInt(strNfmBri) + 1, 5)); //fArqIniTinta(1, 'FUTURA', 'NFMFUT', fStrZero(StrToInt(strNfmBri) + 1, 5));
      End;
    End;

    Screen.Cursor := crDefault;
    blnGravou := False;
  End;
end;

procedure TfrmCadFutNovasFormulasDin.btnExcluirClick(Sender: TObject);
  Var
    strCodNfm: String;
    strBase: String;
    strCodPro: String;
begin

  strCodNfm := dbeCodNfm.Text;
  strBase   := dbeBase.Text;
  strCodPro := dbeCodPro.Text;
  inherited;
  If (blnExcluiu) Then
  Begin
    TFuturaImobiliariaDinamica.pDeletaNovaFormula(strCodNfm);

    blnExcluiu := False;
  End;
end;

procedure TfrmCadFutNovasFormulasDin.dbeCodProKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    If fPesqBaseTinta(Self, conFut, nil, nil, qryAux, Key, ArrSel) Then
    Begin
      qryTabela.FieldByName('NFM_CODPRO').AsString := qryAux.FieldByName('BAS_CODFML').AsString;
      qryTabela.FieldByName('NFM_PRODUT').AsString := qryAux.FieldByName('BAS_PRODUT').AsString;
      qryTabela.FieldByName('NFM_SPRODU').AsString := qryAux.FieldByName('BAS_PRODUT').AsString;
      qryTabela.FieldByName('NFM_BASE__').AsString := qryAux.FieldByName('BAS_CODBAS').AsString;
      qryTabela.FieldByName('NFM_DESBAS').AsString := qryAux.FieldByName('BAS_DESCRI').AsString;
      qryTabela.FieldByName('NFM_UNIDAD').AsString := qryAux.FieldByName('BAS_CODUNI').AsString;
      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmCadFutNovasFormulasDin.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqColorantes(Self, conFut, TEdit(Sender), nil, nil, Key, ArrSel) Then
    SelectNext(ActiveControl, True, True);
end;

initialization
  RegisterClass(TfrmCadFutNovasFormulasDin);
finalization
  UnRegisterClass(TfrmCadFutNovasFormulasDin);

end.

