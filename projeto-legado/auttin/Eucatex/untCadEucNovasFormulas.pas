unit untCadEucNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, EditFocus, Mask, DBCtrls, DBEditFocus, DB, Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadEucNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    dbeProdut: TDBEditFocus;
    Label3: TLabel;
    dbeBase: TDBEditFocus;
    Label4: TLabel;
    dbeUnidade: TDBEditFocus;
    Label5: TLabel;
    dbeForm01: TDBEditFocus;
    Label6: TLabel;
    dbeQtd01: TDBEditFocus;
    Label7: TLabel;
    dbeForm02: TDBEditFocus;
    Label8: TLabel;
    dbeQtd02: TDBEditFocus;
    Label9: TLabel;
    dbeForm03: TDBEditFocus;
    Label10: TLabel;
    dbeQtd03: TDBEditFocus;
    Label11: TLabel;
    dbeForm04: TDBEditFocus;
    Label12: TLabel;
    dbeQtd04: TDBEditFocus;
    Label13: TLabel;
    dbeForm05: TDBEditFocus;
    Label14: TLabel;
    dbeQtd05: TDBEditFocus;
    Label15: TLabel;
    dbeForm06: TDBEditFocus;
    Label16: TLabel;
    dbeQtd06: TDBEditFocus;
    Label17: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDtaCad: TDBEditFocus;
    Label18: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure dbeProdutKeyPress(Sender: TObject; var Key: Char);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  private
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    function fValidaColorante(strCol: String): Boolean;
    function fValidaProduto(strProd: String): Boolean;
    function fValidaBase(strBas: String): Boolean;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;

    { Private declarations }
  public
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

    { Public declarations }
  end;

var
  frmCadEucNovasFormulas: TfrmCadEucNovasFormulas;

implementation

uses untFuncoesSimples, untFuncTinta, untPai, StrUtils,
      untIConfTinta, untEucatexImobiliariaDinamica, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadEucNovasFormulas }



function TfrmCadEucNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeDescri) Then
    Begin
      If (fEmptyStr(dbeDescri.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'A descrição deve ser preenchida', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeProdut) Then
    Begin
      If (fEmptyStr(dbeProdut.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'O produto deve ser preenchido', ['OK']);
        Result := False;
      End
      Else If Not (fValidaProduto(dbeProdut.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'Não existe base com esse produto', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeBase) Then
    Begin
      If (fEmptyStr(dbeBase.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'A base deve ser preenchida', ['OK']);
        Result := False;
      End
      Else If Not (fValidaBase(dbeBase.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'A base não é valida', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeUnidade) Then
    Begin
      If (fEmptyStr(dbeUnidade.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'A unidade deve ser preenchida', ['OK']);
        Result := False;
      End;
    End


    Else If (LeftStr(Sender.Name, 6) = 'dbeQtd') Then
    Begin
      If Not (fEmptyStr(TDBEdit(FindComponent('dbeForm' + RightStr(Sender.Name, 2))).Text))
        And (fEmptyStr(TDBEdit(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'A quantidade deve ser preenchida', ['OK']);
        Result := False;
      End;
    End

    Else If (LeftStr(Sender.Name, 7) = 'dbeForm') Then
    Begin
      If (fEmptystr(dbeForm01.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'Entre com pelo menos um colorante', ['OK']);
        Result := False;
      End
      Else If Not (fEmptyStr(TDBEdit(Sender).Text)) And Not (fValidaColorante(TDBEdit(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'O colorante não é valido', ['OK']);
        Result := False;
      End

      Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
        Result := False;
      End

      Else If (fEmptyStr(TDBEdit(Sender).Text)) Then
      Begin
        SelectNext(dbeForm06, True, True);
      End;
    End;

  End;

  If Not (Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadEucNovasFormulas.pCriaDataSets;
  Var
    intCont: Integer;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}

  qryCadNfm := fCriarQuery('SELECT * FROM EUC_CADNFM', Self);

  qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  qryCadNfm.FieldbyName('NFM_DESCOR').DisplayLabel := 'Descrição';
  qryCadNfm.FieldbyName('NFM_PRODUT').DisplayLabel := 'Produto';
  qryCadNfm.FieldbyName('NFM_DESBAS').DisplayLabel := 'Base';
  qryCadNfm.FieldbyName('NFM_UNIDAD').DisplayLabel := 'Unidade';
  qryCadNfm.FieldbyName('NFM_DTACAD').DisplayLabel := 'Data Cadastro';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 6 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
  End;

  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;

procedure TfrmCadEucNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_DESCOR');
  stlCampos.Add('NFM_PRODUT');
  stlCampos.Add('NFM_DESBAS');
  stlCampos.Add('NFM_UNIDAD');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_DESCOR');
  stlCamInd.Add('NFM_PRODUT');
  stlCamInd.Add('NFM_DESBAS');
  stlCamInd.Add('NFM_UNIDAD');
  stlCamInd.Add('AUTOINCREM');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Produto');
  stlDesInd.Add('Base');
  stlDesInd.Add('Unidade');
end;

procedure TfrmCadEucNovasFormulas.pLigaDataSets;
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

  dbeCodigo.DataField := 'NFM_CODNFM';
  dbeBase.DataField := 'NFM_DESBAS';
  dbeDescri.DataField := 'NFM_DESCOR';
  dbeProdut.DataField := 'NFM_PRODUT';
  dbeUnidade.DataField := 'NFM_UNIDAD';
  dbeDtaCad.DataField := 'NFM_DTACAD';

  For intCont := 1 To 6 Do
  Begin
    TDBEdit(FindComponent('dbeForm' + fStrZero(intCont, 2))).DataField := 'NFM_FORM' + fStrZero(intCont, 2);
    TDBEdit(FindComponent('dbeQtd' + fStrZero(intCont, 2))).DataField := 'NFM_QTDB' + fStrZero(intCont, 2);
  End;

end;

procedure TfrmCadEucNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadNfm;
  strNomeTabela := 'EUC_CADNFM';
  strNomeCampo := 'NFM_CODNFM';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadEucNovasFormulas.dbeProdutKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryGen: TUniQuery;
begin
  qryGen:= fCriaQuery;
  Try
    If fPesqBaseTinta(Self, conEUC, nil, dbeBase, qryGen, Key, arrSel) Then
    Begin
      dbeProdut.Field.AsString := qryGen.FieldByName('BAS_PRODUT').AsString;
      dbeUnidade.Field.AsString := qryGen.FieldByName('BAS_CODUNI').AsString;
      pSetFocus(dbeForm01);
    End;

  Finally
    FreeAndNil(qryGen)
  end;
end;

function TfrmCadEucNovasFormulas.fJaExisteEssaBaseNaFormulacao(
  strCodBas: String; dbeForm: TObject): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To 6 Do
  Begin
    If (RightStr(TDBEditFocus(dbeForm).Name, 2) <> fStrZero(intCont,2)) And
       (Not fEmptyStr(TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text)) Then
    Begin
      If TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text = strCodBas Then
        Result := True;
    End;
  End;

end;

procedure TfrmCadEucNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  fPesqColorantes(Self, conEuc, TDBEdit(Sender), nil, nil, Key, arrSel);
End;

function TfrmCadEucNovasFormulas.fValidaColorante(strCol: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriarQuery('SELECT COUNT(*) AS "CONT" FROM EUC_CADCOL WHERE COL_CODCOL = :CODCOL', Self);
  qryGen.ParamByName('CODCOL').AsString := strCol;
  qryGen.Open;
  Result := qryGen.FieldByName('CONT').AsInteger > 0;
  FreeAndNil(qryGen);
end;

function TfrmCadEucNovasFormulas.fValidaProduto(strProd: String): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriarQuery('SELECT COUNT(*) AS "CONT" FROM EUC_CADBAS WHERE BAS_PRODUT = :CODPRO', Self);
  qryGen.ParamByName('CODPRO').AsString := strProd;
  qryGen.Open;
  Result := qryGen.FieldByName('CONT').AsInteger > 0;
  FreeAndNil(qryGen);
end;

function TfrmCadEucNovasFormulas.fValidaBase(strBas: String): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriarQuery('SELECT COUNT(*) AS "CONT" FROM EUC_CADBAS WHERE BAS_DESCRI = :CODBAS', Self);
  qryGen.ParamByName('CODBAS').AsString := strBas;
  qryGen.Open;
  Result := qryGen.FieldByName('CONT').AsInteger > 0;
  FreeAndNil(qryGen);
end;

procedure TfrmCadEucNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfm: String;
    conf: IConfTinta;
begin
  conf     := fGetConfTinta('EUC');
  qryTabela     := qryCadNfm;
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfm := conf.fGet('EUCNFM'); //fArqIniTinta(0, 'EUCATEX IMOBILIARIA', 'NFMEUC', '0');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + VS_strCodEmp + fStrZero(strNfm, 5);
  End;
  fStartTransaction;
  inherited;

  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If fGravaCadNfm(qryCadNfm) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('EUCNFM', fStrZero(StrToInt(strNfm) + 1, 5)); //fArqIniTinta(1, 'EUCATEX IMOBILIARIA', 'NFMEUC', fStrZero(StrToInt(strNfm) + 1, 5));
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

procedure TfrmCadEucNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodNfm: String;
begin
  strCodNfm := dbeCodigo.Text;
  fStartTransaction;
  inherited;

  Try
    If blnExcluiu Then
    Begin
      If fRemoverFormula(strCodNfm) Then
        fCommit
      Else
        fRollBack;
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

procedure TfrmCadEucNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  qryTabela.FieldByName('NFM_DTACAD').AsDateTime := Date;
  pSetFocus(dbeDescri);
end;

procedure TfrmCadEucNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conEuc, Nil, qryTabela, key, arrSel) Then
    pSetFocus(btnAlterar);
end;

initialization
  RegisterClass(TfrmCadEucNovasFormulas);
finalization
  UnRegisterClass(TfrmCadEucNovasFormulas);

end.

