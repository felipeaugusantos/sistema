unit untCadSolNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Uni, DB, Mask, DBCtrls, DBEditFocus, EditFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadSolNovasFormulas = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescricao: TDBEditFocus;
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
    Label5: TLabel;
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
    pnlCabecalho: TPanel;
    Label3: TLabel;
    dbeCodBas: TDBEditFocus;
    Label4: TLabel;
    dbeDesBas: TDBEditFocus;
    dbeUnidUnid: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodBasKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm : TDataSource;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
  public
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    function fValidaColorante(strCol: String): Boolean;
    function fValidaDesBas(strCodBas, strDesBas: String): Boolean;
    function fValidaCodBas(strCodBas: String): Boolean;
    { Public declarations }
  end;

var
  frmCadSolNovasFormulas: TfrmCadSolNovasFormulas;

implementation

uses untIConfTinta, untFuncoesSimples,
     untFuncTinta, StrUtils, untSolBrazDinamica;

{$R *.dfm}

{ TfrmPaiCad1 }

function TfrmCadSolNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeDescricao) Then
    Begin
      If (fEmptyStr(dbeDescricao.Text)) Then
      Begin
        fMensagem('', 'A descrição deve ser preenchida!', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodBas) Then
    Begin

      If (fEmptyStr(dbeCodBas.Text)) Then
      Begin
        fMensagem('', 'O Código da base deve ser preenchido!', ['OK']);
        Result := False;
      End

      Else If Not (fValidaCodBas(dbeCodBas.Text)) Then
      Begin
        fMensagem('', 'O código da base não é válido!', ['OK']);
        Result := False;
      End;

    End

    Else If (Sender = dbeDesBas) Then
    Begin

      If (fEmptyStr(dbeDesBas.Text)) Then
      Begin
        fMensagem('', 'A descrição da base deve ser preenchida!', ['OK']);
        Result := False;
      End

      Else If Not (fValidaDesBas(dbeCodBas.Text,dbeDesBas.Text)) Then
      Begin
        fMensagem('', 'A base não é válida!', ['OK']);
        Result := False;
      End;

    End

    Else If (Sender = dbeForm01) and (fEmptyStr(dbeForm01.Text)) Then
    Begin
      fMensagem('', 'É necessário digitar pelo menos 1 base!', ['OK']);
      Result := False;
    End

    Else If (LeftStr(Sender.Name, 7) = 'dbeForm') Then
    Begin

      If (Not fEmptyStr(TDBEditFocus(Sender).Text)) and
        (Not fValidaColorante(TDBEditFocus(Sender).Text)) Then
      Begin
        fMensagem('', 'O colorante não está cadastrada!', ['OK']);
        Result := False;
      End

      Else If (fEmptyStr(TDBEditFocus(Sender).Text)) Then
      Begin
        pSetFocus(dbeQtdC06);
      End;

    End

    Else If (LeftStr(Sender.Name, 7) = 'dbeQtdC') Then
    Begin

      If (Not fEmptyStr(TDBEditFocus(FindComponent('dbeForm' + RightStr(Sender.Name, 2))).Text))
         And (fEmptyStr(TDBEditFocus(Sender).Text)) Then
      Begin
        fMensagem('', 'A quantidade deve ser preenchida!', ['OK']);
        Result := False;
      End;
      If (Not fEmptyStr(TDBEditFocus(FindComponent('dbeForm' + RightStr(Sender.Name, 2))).Text))
         And ((fStrToFloat(TDBEditFocus(Sender).Text)) <= 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade do colorante deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

    End;


  end;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadSolNovasFormulas.pCriaDataSets;
begin
  qryCadNfm := fCriarQuery('SELECT * FROM SOL_CADNFM WHERE FALSE', Self);

  dtsCadNfm := fCriaDataSource(qryCadNfm);

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;
  qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  qryCadNfm.FieldByName('NFM_MARCA_').DisplayLabel := 'Marca';
  qryCadNfm.FieldByName('NFM_CODBAS').DisplayLabel := 'Código Base';
  qryCadNfm.FieldByName('NFM_DESBAS').DisplayLabel := 'Descrição Base';
  qryCadNfm.FieldByName('NFM_CODCOR').DisplayLabel := 'Cor';
  qryCadNfm.FieldByName('NFM_UNIDAD').DisplayLabel := 'Unidade';

end;

procedure TfrmCadSolNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('AUTOINCREM');
  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_MARCA_');
  stlCampos.Add('NFM_CODBAS');
  stlCampos.Add('NFM_DESBAS');
  stlCampos.Add('NFM_CODCOR');
  stlCampos.Add('NFM_UNIDAD');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_MARCA_');
  stlCamInd.Add('NFM_CODBAS');
  stlCamInd.Add('NFM_DESBAS');
  stlCamInd.Add('NFM_CODCOR');
  stlCamInd.Add('NFM_UNIDAD');

  stlDesInd.Add('Código');
  stlDesInd.Add('Marca');
  stlDesInd.Add('Código Base');
  stlDesInd.Add('Descrição Base');
  stlDesInd.Add('Cor');
  stlDesInd.Add('Unidade');
end;

procedure TfrmCadSolNovasFormulas.pLigaDataSets;
  Var
    intCont : Integer;
begin
  For intCont := 0 To Self.ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEditFocus) Then
      (Components[intCont] as TDBEditFocus).DataSource := dtsCadNfm;
  End;

  dbeCodigo.DataField     := 'NFM_CODNFM';
  dbeCodBas.DataField     := 'NFM_CODBAS';
  dbeDesBas.DataField     := 'NFM_DESBAS';
  dbeDescricao.DataField  := 'NFM_CODCOR';
  dbeUnidUnid.DataField   := 'NFM_UNIDAD';

  For intCont := 1 To 6 Do
  Begin
    TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont, 2))).DataField := 'NFM_FORM' + fStrZero(intCont, 2);
    TDBEditFocus(FindComponent('dbeQtdC' + fStrZero(intCont, 2))).DataField := 'NFM_QTDB' + fStrZero(intCont, 2);
  End;

end;

procedure TfrmCadSolNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  strNomeTabela := 'SOL_CADNFM';
  strNomeCampo  := 'NFM_CODNFM';
  qryTabela     := qryCadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

function TfrmCadSolNovasFormulas.fValidaColorante(strCol: String): Boolean;
  Var
    qryCadCol : TUniQuery;
begin
  qryCadCol := fCriaQuery;
  qryCadCol.SQL.Text := 'SELECT COL_CODCOL FROM SOL_CADCOL WHERE COL_CODCOL = "' + strCol + '"';
  qryCadCol.Open;
  Result := Not qryCadCol.IsEmpty;
  FreeAndNil(qryCadCol);
end;

procedure TfrmCadSolNovasFormulas.dbeForm01KeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndice: TStringList;
    stlDescricao: TStringList;
    stlIndCampos: TStringList;
    strSQL: String;
    qryCadCol : TUniQuery;
begin

  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    qryCadCol := fCriaQuery(Self);
    stlIndice := TStringList.Create;
    stlDescricao := TStringList.Create;
    stlIndCampos := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + ' 	COL_CODCOL AS "Colorante",  ';
    strSQL := strSQL + ' 	COL_CODITE AS "Cód Item", ';
    strSQL := strSQL + ' 	AUTOINCREM ';
    strSQL := strSQL + ' FROM  ';
    strSQL := strSQL + ' 	SOL_CADCOL ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + ' 	COL_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    stlIndice.Add('COL_CODCOL');

    stlDescricao.Add('Colorante');

    stlIndCampos.Add('COL_CODCOL');

    utcRegistros.Limpar(Self.Name + 'SOL_CADCOL');
    If pConsultaComp(Self, qryCadCol, 'SOL_CADCOL', strSQL, stlIndice, stlDescricao) Then
    Begin
      TDBEditFocus(Sender).Text := qryCadCol.FieldByName('COL_CODCOL').AsString;
    End;

    FreeAndNil(stlIndice);
    FreeAndNil(stlDescricao);
    FreeAndNil(qryCadCol);
  End;
end;

procedure TfrmCadSolNovasFormulas.dbeCodBasKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndice: TStringList;
    stlDescricao: TStringList;
    stlIndCampos: TStringList;
    strSQL: String;
    qryCadBas : TUniQuery;
begin

  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    qryCadBas := fCriaQuery(Self);
    stlIndice := TStringList.Create;
    stlDescricao := TStringList.Create;
    stlIndCampos := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + ' 	BAS_CODBAS AS "Cód Base", ';
    strSQL := strSQL + ' 	BAS_CODUNI AS "Unidade", ';
    strSQL := strSQL + ' 	BAS_DESCRI AS "Descrição", ';
    strSQL := strSQL + ' 	BAS_CODITE AS "Cód. Item", ';
    strSQL := strSQL + ' 	AUTOINCREM ';
    strSQL := strSQL + ' FROM  ';
    strSQL := strSQL + ' 	SOL_CADBAS ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + ' 	BAS_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    stlIndice.Add('BAS_CODBAS');
    stlIndice.Add('BAS_DESCRI');

    stlDescricao.Add('Cód Base');
    stlDescricao.Add('Descrição');

    stlIndCampos.Add('BAS_CODBAS');
    stlIndCampos.Add('BAS_DESCRI');

    utcRegistros.Limpar(Self.Name + 'SOL_CADBAS');
    If pConsultaComp(Self, qryCadBas, 'SOL_CADBAS', strSQL, stlIndice, stlDescricao) Then
    Begin
      dbeCodBas.Field.AsString := qryCadBas.FieldByName('BAS_CODBAS').AsString;
      dbeDesBas.Field.AsString := qryCadBas.FieldByName('BAS_DESCRI').AsString;
      dbeUnidUnid.Field.AsString := qryCadBas.FieldByName('BAS_CODUNI').AsString;
    End;

    FreeAndNil(stlIndice);
    FreeAndNil(stlDescricao);
    FreeAndNil(qryCadBas);
  End;
end;

procedure TfrmCadSolNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin
  conf     := fGetConfTinta('COL');
  qryTabela     := qryCadNfm;
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('SOLNFM'); //fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLNFM', '0');
    qryTabela.FieldByName('NFM_MARCA_').AsString := 'ESPECIAL';
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + fStrZero(strNfmBri, 5);
  End;
  fStartTransaction;
  inherited;
  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If fGravaNFM(qryCadNfm) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('SOLNFM', fStrZero(StrToInt(strNfmBri) + 1, 5)); //fArqIniTinta(1, 'ColorBraz Imobiliaria', 'SOLNFM', fStrZero(StrToInt(strNfmBri) + 1, 5));
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



procedure TfrmCadSolNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    qryGen: TUniQuery;
    strCod: String;
begin
  strcod := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  fStartTransaction;
  inherited;

  Try
    If (blnExcluiu) Then
    Begin
      qryGen := fCriaQuery(nil);
      qryGen.SQL.Text := 'DELETE FROM SOL_CADSOL WHERE SOL_CODNFM = :CODNFM';
      qryGen.ParamByName('CODNFM').AsString := strCod;
      qryGen.ExecSQL;

      fCommit;

      FreeAndNil(qryGen);
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

procedure TfrmCadSolNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  pSetFocus(dbeDescricao);
end;

function TfrmCadSolNovasFormulas.fValidaDesBas(strCodBas,
  strDesBas: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(nil);
  qryGen.SQL.Text := 'SELECT COUNT(*) AS CONT FROM SOL_CADBAS WHERE BAS_CODBAS = :CODBAS AND BAS_DESCRI = :DESBAS';
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('DESBAS').AsString := strDesBas;
  qryGen.Open;
  Result := qryGen.FieldByName('CONT').AsInteger > 0;
  FreeAndNil(qryGen);
end;

function TfrmCadSolNovasFormulas.fValidaCodBas(strCodBas: String): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(nil);
  qryGen.SQL.Text := 'SELECT COUNT(*) AS CONT FROM SOL_CADBAS WHERE BAS_CODBAS = :CODBAS';
  qryGen.ParamByName('CODBAS').AsString := strCodbas;
  qryGen.Open;
  Result := qryGen.FieldByName('CONT').AsInteger > 0;
  FreeAndNil(qryGen);
end;


initialization
  RegisterClass(TfrmCadSolNovasFormulas);
finalization
  UnRegisterClass(TfrmCadSolNovasFormulas);


end.

