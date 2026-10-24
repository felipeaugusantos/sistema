unit untCadFutNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadFutNovasFormulas = class(TfrmPaiCad)
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
    dbeCodPro: TDBEditFocus;
    Label2: TLabel;
    dbeBase: TDBEditFocus;
    Label6: TLabel;
    dbeUnidad: TDBEditFocus;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodProKeyPress(Sender: TObject; var Key: Char);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fBaseCadastrada(strCodFml: String; strBase: String = ''; strUnidad: String = ''): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadFutNovasFormulas: TfrmCadFutNovasFormulas;

implementation

uses untIConfTinta, untFuncTinta,
     untModuloTinta, untPai, untConstantes, untFutura, untFuncoesSimples;

{$R *.dfm}

{ TfrmCadFutNovasForumulas }

function TfrmCadFutNovasFormulas.fBaseCadastrada(strCodFml: String; strBase: String = ''; strUnidad: String = ''): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BAS_DESCRI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FUT_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_CODFML = :CODFML ';
  If (Not fEmptyStr(strBase)) Then
    strSQL := strSQL + '  AND BAS_CODBAS = :BASE ';

  If (Not fEmptyStr(strUnidad)) Then
    strSQL := strSQL + '  AND BAS_CODUNI = :UNIDAD ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFML').AsString  := strCodFml;

    If (Not fEmptyStr(strBase)) Then
      ParamByName('BASE').AsString := strBase;

    If (Not fEmptyStr(strUnidad)) Then
      ParamByName('UNIDAD').AsString := strUnidad;

    Open;
    Result := (Not IsEmpty);
    If (fEmptyStr(dbeDescri.Field.AsString)) And
       (qryTabela.State <> dsBrowse)         And
       (Not fEmptyStr(strBase))              Then
    Begin
      dbeDescri.Field.AsString := FieldByName('BAS_DESCRI').AsString;
    End;
    Close;
  End;
end;

function TfrmCadFutNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumCol: String;
begin

  Result := True;

  If (Sender = dbeCodNfm) Then
  Begin
  End

  Else If (Sender = dbeCodPro) Then
  Begin
    If (fEmptyStr(dbeCodPro.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeCodPro.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeBase) Then
  Begin
    If (fEmptyStr(dbeBase.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeCodPro.Text, dbeBase.Text)) Then
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
    Else If (Pos(dbeUnidad.Text, UNIDADES_BASE) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa não é uma unidade válida (' + AnsiReplaceStr(UNIDADES_BASE, '_', ' ') + ')', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      If fEmptyStr(fRetNomUnidade(dbeUnidad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa unidade não está cadastrada!', ['&O k']);
        Result := False;
      End;
      //Else If (Not fBaseCadastrada(dbeCodPro.Text, dbeBase.Text, dbeUnidad.Text)) Then
      //Begin
      //  fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      //  Result := False;
      //End;
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

function TfrmCadFutNovasFormulas.fValidaColorante(
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

procedure TfrmCadFutNovasFormulas.pInicializaIndices;
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

procedure TfrmCadFutNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'FUT_CADNFM';
  strNomeCampo  := 'NFM_CODNFM';
  qryTabela     := frmModuloTinta.qryFut_CadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodNfm;
end;

procedure TfrmCadFutNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  frmModuloTinta.qryFut_CadNfm.FieldByName('NFM_UNIDAD').AsString := 'LT';

  dbeCodNfm.Enabled := False;
  pSetFocus(dbeCodPro);
end;

procedure TfrmCadFutNovasFormulas.btnAlterarClick(Sender: TObject);
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

procedure TfrmCadFutNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin
  conf  := fGetConfTinta('FUT');
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('NFMFUT'); //fArqIniTinta(0, 'FUTURA', 'NFMFUT', '0');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + fStrZero(strNfmBri, 5);
  End;
  inherited;

  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If (fGeraNovasFormulas(qryTabela)) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NFMFUT', fStrZero(StrToInt(strNfmBri) + 1, 5)); //fArqIniTinta(1, 'FUTURA', 'NFMFUT', fStrZero(StrToInt(strNfmBri) + 1, 5));
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

procedure TfrmCadFutNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodNfm: String;
    strBase: String;
    strCodPro: String;
begin

  strCodNfm := dbeCodNfm.Text;
  strBase   := dbeBase.Text;
  strCodPro := dbeCodPro.Text;
  fStartTransaction;
  inherited;
  Try
    If (blnExcluiu) Then
    Begin
      pDeletaNovaFormula(strCodNfm,
                         strBase,
                         strCodPro);
      fCommit;
      blnExcluiu := False;
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
end;

procedure TfrmCadFutNovasFormulas.dbeCodProKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamIndBas: TStringList;
    stlDesIndBas: TStringList;
    qryAux: TUniQuery;
    strSQL: String;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    Key := #0;
    stlCamIndBas := TStringList.Create;
    stlDesIndBas := TStringList.Create;
    qryAux       := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  BAS_CODFML AS "Código", ';
    strSQL := strSQL + '  BAS_CODBAS AS "Base", ';
    strSQL := strSQL + '  BAS_DESCRI AS "Descrição", ';
    strSQL := strSQL + '  AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  FUT_CADBAS ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TRUE ';

    stlCamIndBas.Add('BAS_CODFML');
    stlCamIndBas.Add('BAS_CODBAS');
    stlDesIndBas.Add('Código');
    stlDesIndBas.Add('Base');

    If (pConsultaComp(Self, qryAux, 'FUT_CADBAS', strSQL, stlCamIndBas, stlDesIndBas, 'GROUP BY BAS_CODFML ORDER BY BAS_CODFML ')) Then
    Begin
      TDBEditFocus(Sender).Text := qryAux.FieldByName('BAS_CODFML').AsString;
      qryTabela.FieldByName('NFM_BASE__').AsString := qryAux.FieldByName('BAS_CODBAS').AsString;
      qryTabela.FieldByName('NFM_DESCRI').AsString := qryAux.FieldByName('BAS_DESCRI').AsString;
      If (fValidaCampos(TDBEditFocus(Sender), True)) Then
        SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(qryAux);
    FreeAndNil(stlCamIndBas);
    FreeAndNil(stlDesIndBas);
  End;

end;

procedure TfrmCadFutNovasFormulas.dbeForm01KeyPress(Sender: TObject;
  var Key: Char);
  Var
    strSQL: String;
    stlCamInd: TStringList;
    stlDesInd: TStringList;
    qryConsulta: TUniQuery;
begin

  If (fEntraCons(Key)) Then
  Begin

    Key := #0;

    qryConsulta := fCriaQuery;
    stlCamInd := TStringList.Create;
    stlDesInd := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COL_CODCOL AS "Código", ';
    strSQL := strSQL + '  AUTOINCREM AS "AUTOINCREM" ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  FUT_CADCOL ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  COL_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    stlCamInd.Add('COL_CODCOL');

    stlDesInd.Add('Código');

    If (pConsultaComp(Self, qryConsulta, 'FUT_CADCOL', strSQL, stlCamInd, stlDesInd)) Then
    Begin
      TEdit(Sender).Text := qryConsulta.FieldByName('COL_CODCOL').AsString;
      If fValidaCampos(TEdit(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(stlCamInd);
    FreeAndNil(stlDesInd);
    FreeAndNil(qryConsulta);

  End;

end;

initialization
  RegisterClass(TfrmCadFutNovasFormulas);
finalization
  UnRegisterClass(TfrmCadFutNovasFormulas);

end.

