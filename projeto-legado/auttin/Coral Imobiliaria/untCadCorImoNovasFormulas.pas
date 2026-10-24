unit untCadCorImoNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, AppEvnts, Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadCorImoNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    dbeCodIte: TDBEditFocus;
    edtDesIte: TEditFocus;
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
    dbeCodEmb: TDBEditFocus;
    edtUnidad: TEditFocus;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCodBasKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodEmbKeyPress(Sender: TObject; var Key: Char);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    qryCadIte: TUniQuery;

    procedure pCarregaItem;
  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fBaseCadastrada(strBase: String): Boolean;
    function fEmbalagemCadastrada(strCodEmb: String): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadCorImoNovasFormulas: TfrmCadCorImoNovasFormulas;

implementation

uses  untPesqAux,
      untConsultaFatItem, untModuloTinta, untPai, untCoralImobiliaria,
      untFuncoesSimples, untIConfTinta, untFuncTinta;

{$R *.dfm}

{ TfrmCadCorImoNovasForumulas }

function TfrmCadCorImoNovasFormulas.fBaseCadastrada(strBase: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BAS_DESCRI, ';
  strSQL := strSQL + '  BAS_UNIDAD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CORIMO_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_BASE__ = :BASE ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('BASE').AsString  := strBase;
    Open;
    Result := (Not IsEmpty);
    If (fEmptyStr(dbeDescri.Field.AsString)) And (qryTabela.State <> dsBrowse) Then
    Begin
      dbeDescri.Field.AsString := FieldByName('BAS_DESCRI').AsString;
    End;
    Close;
  End;
end;

function TfrmCadCorImoNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumCol: String;
begin

  Result := True;

  If (Sender = dbeCodigo) Then
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

  Else If (Sender = dbeCodEmb) Then
  Begin

    If (fEmptyStr(dbeCodEmb.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A embalagem deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fEmbalagemCadastrada(dbeCodEmb.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa embalagem não está cadastrada!', ['&Ok']);
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

  Else If (Sender = dbeCodIte) Then
  Begin
    If (fEmptyStr(dbeCodIte.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O item deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaItem;
      If (qryCadIte.FieldByName('ITE_CODITE').IsNull) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
        Result := False;
      End;
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
      fMensagem('ATENÇÃO!', 'Esse colorante não está cadastrado!', ['&O k']);    
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

function TfrmCadCorImoNovasFormulas.fValidaColorante(
  strCodCol: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CORIMO_CADCOL ';
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

procedure TfrmCadCorImoNovasFormulas.pCarregaItem;
begin
  pPesquisaCadIte(qryCadIte, qryCadIte, dbeCodIte.Text);
  With qryCadIte Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;

procedure TfrmCadCorImoNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODIGO');
  stlCampos.Add('NFM_CODBAS');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('NFM_UNIDAD');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODIGO');
  stlCamInd.Add('NFM_DESCRI');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadCorImoNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CORIMO_CADNFM';
  strNomeCampo  := 'NFM_CODIGO';
  qryTabela     := frmModuloTinta.qryCorImo_CadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  qryCadIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

procedure TfrmCadCorImoNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  dbeCodigo.Enabled := False;
  edtDesIte.Clear;
  pSetFocus(dbeCodBas);
end;

procedure TfrmCadCorImoNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodigo.Enabled := False;
  If (dbeCodBas.Enabled) Then
    pSetFocus(dbeCodBas);
end;

procedure TfrmCadCorImoNovasFormulas.dbeCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamIndIte: TStringList;
    stlDesIndIte: TStringList;
    strSQL: String;
begin

  If (fEntraCons(Key)) Then
  Begin

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
    //strSQL := strSQL + '  G.ITE_SALRES ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  CADMAR M ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    stlCamIndIte.Add('I.ITE_CODITE');
    stlCamIndIte.Add('I.ITE_DESITE');
    stlCamIndIte.Add('I.ITE_REFERE');
    stlCamIndIte.Add('I.ITE_CODBAR');

    stlDesIndIte.Add('Codigo');
    stlDesIndIte.Add('Descrição');
    stlDesIndIte.Add('Referência');

    pCriarFormularios(TfrmConsultaFatItem, frmConsultaFatItem);

    If pConsultaEspecifica(Self, frmConsultaFatItem, qryCadIte, 'CADITE',
        strSQL, stlCamIndIte, stlDesIndIte) Then
    Begin

      dbeCodIte.Text := qryCadIte.FieldByName('ITE_CODITE').AsString;
      pCarregaItem;
      SelectNext(ActiveControl, True, True);

    End;

    FreeAndNil(frmConsultaFatItem);

    FreeAndNil(stlCamIndIte);
    FreeAndNil(stlDesIndIte);

  End;
end;

procedure TfrmCadCorImoNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('CIM');
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('NFMCOR');
    qryTabela.FieldByName('NFM_CODIGO').AsString := 'ESP ' + fStrZero(strNfmBri, 5);
  End;
  qryTabela.FieldByName('NFM_UNIDAD').AsString := edtUnidad.Text;

  fStartTransaction;
  inherited;

  Try
    If (blnGravou) Then
    Begin
      If (fGeraNovasFormulas(qryTabela)) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NFMCOR', fStrZero(StrToInt(strNfmBri) + 1, 5));
        End;
        fCommit;
      End;
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

function TfrmCadCorImoNovasFormulas.fEmbalagemCadastrada(
  strCodEmb: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  EMB_UNIDAD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CORIMO_CADEMB ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EMB_CODEMB = :CODEMB ';

  With frmModuloTinta.qryGen001 Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMB').AsString := strCodEmb;
    Open;
    Result := (Not IsEmpty);
    edtUnidad.Text := FieldByName('EMB_UNIDAD').AsString;
    Close;

  End;

end;

procedure TfrmCadCorImoNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodigo: String;
begin
  strCodigo := qryTabela.FieldByName('NFM_CODIGO').AsString;

  fStartTransaction;

  inherited;

  Try
    If (blnExcluiu) Then
    Begin
      pDeletaNovaFormula(strCodigo);
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

  pCarregaItem;
  edtUnidad.Clear;
end;

procedure TfrmCadCorImoNovasFormulas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  fBaseCadastrada(dbeCodBas.Text);
  pCarregaItem;
end;

procedure TfrmCadCorImoNovasFormulas.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  edtUnidad.Text := qryTabela.FieldByName('NFM_UNIDAD').AsString;
end;

procedure TfrmCadCorImoNovasFormulas.dbeCodBasKeyPress(Sender: TObject;
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

    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  BAS_BASE__ "Base", ';
    strSQL := strSQL + '  BAS_UNIDAD "Unidade", ';
    strSQL := strSQL + '  BAS_CODEMP "Empresa", ';
    strSQL := strSQL + '  BAS_CODITE "Item", ';
    strSQL := strSQL + '  ITE_DESITE "Desc. Item", ';
    strSQL := strSQL + '  BAS_DESCRI "Descrição", ';
    strSQL := strSQL + '  CORIMO_CADBAS.AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CORIMO_CADBAS ';
    strSQL := strSQL + 'LEFT JOIN CADITE ON ITE_CODITE = BAS_CODITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TRUE ';

    stlCamIndBas.Add('BAS_DESCRI');
    stlCamIndBas.Add('BAS_BASE__');
    stlCamIndBas.Add('BAS_CODITE');
    stlCamIndBas.Add('ITE_DESITE');

    stlDesIndBas.Add('Descrição');
    stlDesIndBas.Add('Base');
    stlDesIndBas.Add('Item');
    stlDesIndBas.Add('Desc. Item');

    If (pConsultaComp(Self, qryAux, 'CORIMO_CADBAS', strSQL, stlCamIndBas, stlDesIndBas)) Then
    Begin
      TDBEditFocus(Sender).Text := qryAux.FieldByName('BAS_BASE__').AsString;
      dbeCodIte.Field.AsString := qryAux.FieldByName('BAS_CODITE').AsString;
      If (fValidaCampos(TDBEditFocus(Sender), True)) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;
    End;

    FreeAndNil(qryAux);
    FreeAndNil(stlCamIndBas);
    FreeAndNil(stlDesIndBas);
  End;

end;

procedure TfrmCadCorImoNovasFormulas.dbeCodEmbKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamIndEmb: TStringList;
    stlDesIndEmb: TStringList;
    qryAux: TUniQuery;
    strSQL: String;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    Key := #0;
    stlCamIndEmb := TStringList.Create;
    stlDesIndEmb := TStringList.Create;
    qryAux       := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMB_CODEMB AS "Embalagem", ';
    strSQL := strSQL + '  EMB_UNIDAD AS "Unidade", ';
    strSQL := strSQL + '  AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CORIMO_CADEMB ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TRUE ';

    stlCamIndEmb.Add('EMB_CODEMB');
    stlCamIndEmb.Add('EMB_UNIDAD');
    stlDesIndEmb.Add('Embalagem');
    stlDesIndEmb.Add('Unidade');

    If (pConsultaComp(Self, qryAux, 'CORIMO_CADEMB', strSQL, stlCamIndEmb, stlDesIndEmb)) Then
    Begin
      TDBEditFocus(Sender).Text := qryAux.FieldByName('EMB_CODEMB').AsString;
      If (fValidaCampos(TDBEditFocus(Sender), True)) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;
    End;

    FreeAndNil(qryAux);
    FreeAndNil(stlCamIndEmb);
    FreeAndNil(stlDesIndEmb);
  End;

end;

procedure TfrmCadCorImoNovasFormulas.dbeForm01KeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamIndCol: TStringList;
    stlDesIndCol: TStringList;
    stlCamposCol: TStringList;
    qryAux: TUniQuery;
    strSQL: String;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    Key := #0;
    stlCamIndCol := TStringList.Create;
    stlDesIndCol := TStringList.Create;
    stlCamposCol := TStringList.Create;
    qryAux       := frmModuloTinta.qryCorImo_CadCol;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COL_CODCOL "Código", ';
    strSQL := strSQL + '  COL_CODITE "Item", ';
    strSQL := strSQL + '  ITE_DESITE "Desc. Item", ';
    strSQL := strSQL + '  COL_PRECUS "Preço Custo", ';
    strSQL := strSQL + '  COL_MARGEM "Margem", ';
    strSQL := strSQL + '  COL_PREVEN "Preço Venda", ';
    strSQL := strSQL + '  CORIMO_CADCOL.AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CORIMO_CADCOL ';
    strSQL := strSQL + 'LEFT JOIN CADITE ON ITE_CODITE = COL_CODITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TRUE ';

    stlCamIndCol.Add('COL_CODCOL');
    stlCamIndCol.Add('COL_CODITE');
    stlCamIndCol.Add('ITE_DESITE');

    stlDesIndCol.Add('Código');
    stlDesIndCol.Add('Item');
    stlDesIndCol.Add('Desc. Item');

    If pConsultaComp(Self, qryAux, 'CORIMO_CADCOL', strSQL, stlCamIndCol, stlDesIndCol) Then
    Begin
      TDBEditFocus(Sender).Text := qryAux.FieldByName('COL_CODCOL').AsString;
      If (fValidaCampos(TDBEditFocus(Sender), True)) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;
    End;

    FreeAndNil(stlCamIndCol);
    FreeAndNil(stlDesIndCol);
    FreeAndNil(stlCamposCol);
  End;

end;

initialization
  RegisterClass(TfrmCadCorImoNovasFormulas);
finalization
  UnRegisterClass(TfrmCadCorImoNovasFormulas);

end.

