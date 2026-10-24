unit untCadReiNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, StdCtrls, Mask, DBCtrls, DBEditFocus, AppEvnts,
  Menus, ComCtrls, Buttons, ExtCtrls, Uni, DB, StrUtils,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadReiNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label16: TLabel;
    Label15: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label17: TLabel;
    dbeDescri: TDBEditFocus;
    dbeRefere: TDBEditFocus;
    dbeBase: TDBEditFocus;
    dbeUnidade: TDBEditFocus;
    dbeForm01: TDBEditFocus;
    dbeQtd01: TDBEditFocus;
    dbeQtd03: TDBEditFocus;
    dbeForm03: TDBEditFocus;
    dbeQtd02: TDBEditFocus;
    dbeForm02: TDBEditFocus;
    dbeQtd06: TDBEditFocus;
    dbeForm06: TDBEditFocus;
    dbeQtd05: TDBEditFocus;
    dbeForm05: TDBEditFocus;
    dbeQtd04: TDBEditFocus;
    dbeForm04: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    pnlCabecalho: TPanel;
    procedure dbeBaseKeyPress(Sender: TObject; var Key: Char);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  private
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;  
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    function fValidaColorante(strCol: String): Boolean;
    function fValidaBase(strBas: String): Boolean;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
    { Private declarations }
  public
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Public declarations }
  end;

var
  frmCadReiNovasFormulas: TfrmCadReiNovasFormulas;

implementation

uses untFuncoesSimples,
     untRennerImobiliariaDinamica,  untIConfTinta,
  untFuncTinta,untPai, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadReiNovasFormulas.dbeBaseKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  Try
    If fPesqBaseTinta(Self, conRei, dbeBase, Nil, qryGen, Key, arrSel, True, 'AND ITE_ITEATI = "S" ') Then
    Begin
      dbeUnidade.Field.AsString := qryGen.FieldByName('BAS_UNIDAD').AsString;
      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadReiNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  fPesqColorantes(Self, conRei, TDBEditFocus(Sender), Nil, Nil, Key, arrSel)
end;

function TfrmCadReiNovasFormulas.fJaExisteEssaBaseNaFormulacao(
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

function TfrmCadReiNovasFormulas.fValidaBase(strBas: String): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriarQuery('SELECT COUNT(*) AS "CONT" FROM REI_CADBAS WHERE BAS_CODBAS = :CODBAS', Self);
  qryGen.ParamByName('CODBAS').AsString := strBas;
  qryGen.Open;
  Result := qryGen.FieldByName('CONT').AsInteger > 0;
  FreeAndNil(qryGen);
end;

function TfrmCadReiNovasFormulas.fValidaCampos(Sender: TWinControl;
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

function TfrmCadReiNovasFormulas.fValidaColorante(strCol: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriarQuery('SELECT COUNT(*) AS "CONT" FROM REI_CADCOL WHERE COL_CODCOL = :CODCOL', Self);
  qryGen.ParamByName('CODCOL').AsString := strCol;
  qryGen.Open;
  Result := qryGen.FieldByName('CONT').AsInteger > 0;
  FreeAndNil(qryGen);
end;

procedure TfrmCadReiNovasFormulas.pCriaDataSets;
  Var
    intCont: Integer;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}

  qryCadNfm := fCriarQuery('SELECT * FROM REI_CADNFM', Self);

  qryCadNfm.FieldByName('NFM_CODPRO').DisplayLabel := 'Código';
  qryCadNfm.FieldByName('NFM_DESCOR').DisplayLabel := 'Descrição';
  qryCadNfm.FieldByName('NFM_REFERE').DisplayLabel := 'Referência';
  qryCadNfm.FieldByName('NFM_UNIDAD').DisplayLabel := 'Unidade';
  qryCadNfm.FieldByName('NFM_CODBAS').DisplayLabel := 'Base';
  qryCadNfm.FieldByName('NFM_DTACAD').DisplayLabel := 'Data Cadastro';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 6 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
  End;

  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;

procedure TfrmCadReiNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODPRO');
  stlCampos.Add('NFM_DESCOR');
  stlCampos.Add('NFM_CODBAS');
  stlCampos.Add('NFM_UNIDAD');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODPRO');
  stlCamInd.Add('NFM_DESCOR');
  stlCamInd.Add('NFM_CODBAS');
  stlCamInd.Add('NFM_UNIDAD');
  stlCamInd.Add('AUTOINCREM');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Base');
  stlDesInd.Add('Unidade');
end;

procedure TfrmCadReiNovasFormulas.pLigaDataSets;
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

  dbeCodigo.DataField := 'NFM_CODPRO';
  dbeBase.DataField := 'NFM_CODBAS';
  dbeDescri.DataField := 'NFM_DESCOR';
  dbeRefere.DataField := 'NFM_REFERE';
  dbeUnidade.DataField := 'NFM_UNIDAD';

  For intCont := 1 To 6 Do
  Begin
    TDBEdit(FindComponent('dbeForm' + fStrZero(intCont, 2))).DataField := 'NFM_FORM' + fStrZero(intCont, 2);
    TDBEdit(FindComponent('dbeQtd' + fStrZero(intCont, 2))).DataField := 'NFM_QTDC' + fStrZero(intCont, 2);
  End;
end;

procedure TfrmCadReiNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadNfm;
  strNomeTabela := 'REI_CADNFM';
  strNomeCampo := 'NFM_CODPRO';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadReiNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfm: String;
    tinta: TRennerImobiliariaDinamica;
    conf: IConfTinta;
begin
  conf      := fGetConfTinta('REI');
  qryTabela     := qryCadNfm;
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfm := conf.fGet('PROCOD'); //fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'PROCOD', '0');
    qryTabela.FieldByName('NFM_CODPRO').AsString := 'ESP ' + fStrZero(strNfm, 5);
  End;
  fStartTransaction;
  inherited;
  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      tinta := TRennerImobiliariaDinamica.Create(Self);
      If tinta.fGravarNovaFormula(qryTabela) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('PROCOD', fStrZero(StrToInt(strNfm) + 1, 5)); //fArqIniTinta(1, 'RENNER IMOBILIÁRIA', 'PROCOD', fStrZero(StrToInt(strNfm) + 1, 5));
        End;

        fCommit;
      End
      Else
        fRollBack;

      FreeAndNil(tinta);
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

procedure TfrmCadReiNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  pSetFocus(dbeDescri);
end;

procedure TfrmCadReiNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conRei, Nil, qryTabela, key, arrSel) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadReiNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDescri);
end;

procedure TfrmCadReiNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'DELETE FROM REI_CADREI WHERE REI_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := qryTabela.FieldByName('NFM_CODPRO').AsString;

  fStartTransaction;
  inherited;

  Try
    If blnExcluiu Then
    Begin
      qryGen.ExecSQL;
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

  FreeAndNil(qryGen);
end;

initialization
  RegisterClass(TfrmCadReiNovasFormulas);
finalization
  UnRegisterClass(TfrmCadReiNovasFormulas);

end.

