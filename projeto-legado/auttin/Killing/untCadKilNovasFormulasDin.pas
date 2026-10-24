unit untCadKilNovasFormulasDin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, Uni, DB, EditFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadKilNovasFormulasDin = class(TfrmPaiCad) 
    pnlCentral: TPanel;
    Label3: TLabel;
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
    dbeCodFml: TDBEditFocus;
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
    lblInformacao: TLabel;
    lblDescri: TLabel;
    dbeDescri: TDBEditFocus;
    lblProdut: TLabel;
    dbeBase: TDBEditFocus;
    lblReferencia: TLabel;
    dbeReferencia: TDBEditFocus;
    Label1: TLabel;
    dbeForm07: TDBEditFocus;
    Label2: TLabel;
    dbeQtd07: TDBEditFocus;
    lblForm08: TLabel;
    dbeForm08: TDBEditFocus;
    lblQtd08: TLabel;
    dbeQtd08: TDBEditFocus;
    lblForm09: TLabel;
    dbeForm09: TDBEditFocus;
    lblQtd09: TLabel;
    dbeQtd09: TDBEditFocus;
    lblForm10: TLabel;
    dbeForm10: TDBEditFocus;
    lblQtd10: TLabel;
    dbeQtd10: TDBEditFocus;
    Label4: TLabel;
    dbeQtd11: TDBEditFocus;
    Label18: TLabel;
    dbeQtd12: TDBEditFocus;
    Label19: TLabel;
    dbeQtd13: TDBEditFocus;
    Label20: TLabel;
    dbeQtd14: TDBEditFocus;
    Label21: TLabel;
    dbeQtd15: TDBEditFocus;
    Label22: TLabel;
    dbeQtd16: TDBEditFocus;
    Label23: TLabel;
    dbeQtd17: TDBEditFocus;
    Label24: TLabel;
    dbeQtd18: TDBEditFocus;
    Label25: TLabel;
    dbeQtd19: TDBEditFocus;
    Label26: TLabel;
    dbeQtd20: TDBEditFocus;
    Label27: TLabel;
    dbeForm11: TDBEditFocus;
    Label28: TLabel;
    dbeForm12: TDBEditFocus;
    Label29: TLabel;
    dbeForm13: TDBEditFocus;
    Label30: TLabel;
    dbeForm14: TDBEditFocus;
    Label31: TLabel;
    dbeForm15: TDBEditFocus;
    Label32: TLabel;
    dbeForm16: TDBEditFocus;
    Label33: TLabel;
    dbeForm17: TDBEditFocus;
    Label34: TLabel;
    dbeForm18: TDBEditFocus;
    Label35: TLabel;
    dbeForm19: TDBEditFocus;
    Label36: TLabel;
    dbeForm20: TDBEditFocus;
    pnlCabecalho: TPanel;
    dbeDtaCad: TDBEditFocus;
    Label37: TLabel;
    Label38: TLabel;
    dbeNomCor: TDBEditFocus;
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbeCodFmlKeyPress(Sender: TObject; var Key: Char);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
  protected
    procedure pCriarDataSets;
    procedure pLigarDataSets;
    procedure pInicializaIndices; override;
    function fValidaBase(strcodBas: String; strFml: String): Boolean;
    function fValidaCol(strCodCol: String): Boolean;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadKilNovasFormulasDin: TfrmCadKilNovasFormulasDin;

implementation

uses untFuncoesSimples, StrUtils,  untIConfTinta, untFuncTinta, untKillingDinamica, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadKilNovasFormulasDin.btnExcluirClick(Sender: TObject);
  Var
    strCodNfm: String;
begin
  strCodNfm := dbeCodigo.Text;
  inherited;
  If (blnExcluiu) Then
  Begin
    TKillingDinamica.pDeletaNovaFormulaDinamica(strCodNfm);
    blnExcluiu := False;
  End;

end;

procedure TfrmCadKilNovasFormulasDin.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfm: String;
    conf: IConfTinta;
begin
  conf      := fGetConfTinta('KIL');
  qryTabela     := qryCadNfm;
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfm := conf.fGet('NFMKIL'); //fArqIniTinta(0, 'KILLING', 'NFMKIL', '0');
    qryTabela.FieldByName('NFM_CODCOR').AsString := 'ESP ' + fStrZero(strNfm, 5);
  End;
  fStartTransaction;
  inherited;
  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If TKillingDinamica.fGravarNovaFormula(qryCadNfm) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NFMKIL', fStrZero(StrToInt(strNfm) + 1, 5)); //fArqIniTinta(1, 'KILLING', 'NFMKIL', fStrZero(StrToInt(strNfm) + 1, 5));
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

procedure TfrmCadKilNovasFormulasDin.pCriarDataSets;
  Var
    intCont: Integer;
begin
  qryCadNfm := fCriarQuery('SELECT * FROM KILD_CADNFM');

  qryCadNfm.FieldByName('NFM_CODCOR').DisplayLabel := 'Código';
  qryCadNfm.FieldByName('NFM_DESCRI').DisplayLabel := 'Descrição';
  qryCadNfm.FieldByName('NFM_REFERE').DisplayLabel := 'Referência';
  qryCadNfm.FieldByName('NFM_CODFML').DisplayLabel := 'Código Base';
  qryCadNfm.FieldByName('NFM_CODBAS').DisplayLabel := 'Base';
  qryCadNfm.FieldByName('NFM_DTACAD').DisplayLabel := 'Data Cadastro';
  qryCadNfm.FieldByName('NFM_NOMCOR').DisplayLabel := 'Nome da Cor';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 20 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
  End;

  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;

procedure TfrmCadKilNovasFormulasDin.pLigarDataSets;
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

procedure TfrmCadKilNovasFormulasDin.FormCreate(Sender: TObject);
begin
  inherited;
  pCriarDataSets;
  pLigarDataSets;

  qryTabela := qryCadNfm;
  strNomeTabela := 'KILD_CADNFM';
  strNomeCampo := 'NFM_CODCOR';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

function TfrmCadKilNovasFormulasDin.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If Sender = dbeDescri Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
         Result :=  fMensagem('ATENÇÃO', 'A descrição deve ser preenchida!', ['OK']) = -1;
      End;
    End
    Else If Sender = dbeCodFml Then
    Begin
      If fEmptyStr(dbeCodFml.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'Uma base deve ser escolhida!', ['OK']) = -1;
      End;
    End

    Else If Pos('dbeForm', Sender.Name) > 0 Then
    Begin

      If Sender = dbeForm01 Then
      Begin
        If fEmptyStr(dbeForm01.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Pelo menos um colorante deve ser preenchido!', ['OK']) = -1;
        End

        Else If Not fValidaCol(dbeForm01.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O colorante não é válido!', ['OK']) = -1;
        End

      End

      Else
      If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
        Result := False;
      End

      Else If Not (fEmptyStr(TDBEdit(Sender).Text)) Then
      Begin
        If Not fValidaCol(TDBEdit(Sender).Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O colorante não é válido!', ['OK']) = -1;
        End;
      End;
    End
    Else If Pos('dbeQtd', Sender.Name) > 0 Then
    Begin
      If Not fEmptyStr(TDBEdit(FindComponent('dbeForm' + RightStr(Sender.Name, 2))).Text) Then
      Begin
        If fEmptyStr(TDBEdit(Sender).Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'A quantidade deve ser preenchida!', ['OK']) = -1;
        End
        Else If fStrToFloat(TDBEdit(Sender).Text) <= 0 Then
        Begin
          Result := fMensagem('ATENÇÃO', 'A quantidade deve ser maior que zero!', ['OK']) = -1;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadKilNovasFormulasDin.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODFML+NFM_NOMCOR+NFM_DESCRI+NFM_REFERE');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODFML+NFM_NOMCOR+NFM_DESCRI+NFM_REFERE');

  stlDesInd.Add('Formulação/Nome da Cor/Descrição/Referência');
end;


procedure TfrmCadKilNovasFormulasDin.dbeCodFmlKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;
    If fPesqBaseTinta(Self, conKil, dbeBase, Nil, qryGen, Key, arrSel) Then
    Begin
      dbeCodFml.Field.AsString := qryGen.FieldByName('BAS_CODFML').AsString;
      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadKilNovasFormulasDin.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  try
    If fPesqColorantes(Self, conKil, TDBEdit(Sender), Nil, qryGen, Key, arrSel) Then
      TDBEdit(Sender).Field.AsString := qryGen.FieldByName('COL_CODCOL').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmCadKilNovasFormulasDin.fJaExisteEssaBaseNaFormulacao(
  strCodBas: String; dbeForm: TObject): Boolean;
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

function TfrmCadKilNovasFormulasDin.fValidaBase(strcodBas: String; strFml: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   COUNT(*)    QTD ');
  qryGen.SQL.Add(' FROM KILD_CADBAS ');
  qryGen.SQL.Add(' WHERE BAS_CODBAS = :CODBAS ');
  qryGen.SQL.Add('     AND BAS_CODFML = :CODFML ');
  qryGen.SQL.Add('     AND BAS_UNIDAD = "LT9" ');

  qryGen.ParamByName('CODBAS').AsString := strcodBas;
  qryGen.ParamByName('CODFML').AsString := strFml;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

function TfrmCadKilNovasFormulasDin.fValidaCol(strCodCol: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   COUNT(*)    QTD ');
  qryGen.SQL.Add(' FROM KILD_CADCOL ');
  qryGen.SQL.Add(' WHERE COL_CODCOL = :CODCOL ');

  qryGen.ParamByName('CODCOL').AsString := strCodCol;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

procedure TfrmCadKilNovasFormulasDin.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  qryTabela.FieldByName('NFM_DTACAD').AsDateTime := Date;
  pSetFocus(dbeNomCor);
end;

procedure TfrmCadKilNovasFormulasDin.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conKild, Nil, qryTabela, key, arrSel) Then
    pSetFocus(btnAlterar);
end;

initialization
  RegisterClass(TfrmCadKilNovasFormulasDin);
finalization
  UnRegisterClass(TfrmCadKilNovasFormulasDin);

end.

