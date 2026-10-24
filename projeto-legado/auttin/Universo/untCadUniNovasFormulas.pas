unit untCadUniNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, Uni, DB, EditFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadUniNovasFormulas = class(TfrmPaiCad) 
    pnlCentral: TPanel;
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
    dbeBase1: TDBEditFocus;
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
    lblInformacao: TLabel;
    lblDescri: TLabel;
    dbeDescri: TDBEditFocus;
    lblProdut: TLabel;
    dbeProdut: TDBEditFocus;
    pnlCabecalho: TPanel;
    Label28: TLabel;
    dbeDtaCad: TDBEditFocus;
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbeBase1KeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
  protected
    procedure pCriarDataSets;
    procedure pLigarDataSets;
    procedure pInicializaIndices; override;
    function fValidaBase(strcodBas: String): Boolean;
    function fValidaCol(strCodCol: String): Boolean;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
  public
    { Public declarations }
  end;

var
  frmCadUniNovasFormulas: TfrmCadUniNovasFormulas;

implementation

uses untFuncoesSimples, StrUtils,
    untIConfTinta, untFuncTinta, untUniversoImobiliariaDinamica, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadUniNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfm: String;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('UNI');
  qryTabela := qryCadNfm;
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfm := conf.fGet('NFMUNI'); //fArqIniTinta(0, 'UNIVERSO', 'NFMUNI', '0');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + fStrZero(strNfm, 5);
    qryTabela.FieldByName('NFM_GRUPO_').AsString := 'PERSONALIZADO';
    qryTabela.FieldByName('NFM_CODTIN').AsString := 'ESP ' + fStrZero(strNfm, 5);
  End;
  fStartTransaction;
  inherited;
  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If TUniversoImobiliariaDinamica.fGravarNovaFormula(qryCadNfm) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NFMUNI', fStrZero(StrToInt(strNfm) + 1, 5)); //fArqIniTinta(1, 'UNIVERSO', 'NFMUNI', fStrZero(StrToInt(strNfm) + 1, 5));
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

procedure TfrmCadUniNovasFormulas.pCriarDataSets;
  Var
    intCont: Integer;
begin
  qryCadNfm := fCriarQuery('SELECT * FROM UNI_CADNFM');

  qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  qryCadNfm.FieldByName('NFM_PRODUT').DisplayLabel := 'Produto';
  qryCadNfm.FieldByName('NFM_DESCOR').DisplayLabel := 'Descrição';
  qryCadNfm.FieldByName('NFM_CODBAS').DisplayLabel := 'Base';
  qryCadNfm.FieldByName('NFM_CODUNI').DisplayLabel := 'Unidade';
  qryCadNfm.FieldByName('NFM_DTACAD').DisplayLabel := 'Data Cadastro';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 10 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
  End;

  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;

procedure TfrmCadUniNovasFormulas.pLigarDataSets;
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

procedure TfrmCadUniNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriarDataSets;
  pLigarDataSets;

  qryTabela := qryCadNfm;
  strNomeTabela := 'UNI_CADNFM';
  strNomeCampo := 'NFM_CODNFM';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

function TfrmCadUniNovasFormulas.fValidaCampos(Sender: TWinControl;
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
    Else If Sender = dbeBase1 Then
    Begin
      If fEmptyStr(dbeBase1.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'Uma base deve ser escolhida!', ['OK']) = -1;
      End;
    End
    Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
      Result := False;
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
        End;
      End
      Else If Not (fEmptyStr(TDBEdit(Sender).Text)) Then
      Begin
        If Not fValidaCol(TDBEdit(Sender).Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O colorante não é válido!', ['OK']) = -1;
        End;
      End
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

procedure TfrmCadUniNovasFormulas.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_DESCOR+NFM_PRODUT+NFM_CODBAS');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_DESCOR+NFM_PRODUT+NFM_CODBAS');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição/Produto/Base');
end;


procedure TfrmCadUniNovasFormulas.dbeBase1KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqBaseTinta(Self, conUni, dbeBase1, dbeProdut, Nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadUniNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  qryTabela.FieldByName('NFM_DTACAD').AsDateTime := Date;
  dbeUnidade.Field.AsString := 'QT';
end;

procedure TfrmCadUniNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conUni, Nil, qryTabela, key, arrSel) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadUniNovasFormulas.dbeForm01KeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqColorantes(Self, conUni, TDBEdit(Sender), Nil, Nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

function TfrmCadUniNovasFormulas.fJaExisteEssaBaseNaFormulacao(
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

function TfrmCadUniNovasFormulas.fValidaBase(strcodBas: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   COUNT(*)    QTD ');
  qryGen.SQL.Add(' FROM UNI_CADBAS ');
  qryGen.SQL.Add(' WHERE BAS_CODBAS = :CODBAS ');
  qryGen.SQL.Add('     AND BAS_UNIDAD = "QT" ');

  qryGen.ParamByName('CODBAS').AsString := strcodBas;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

function TfrmCadUniNovasFormulas.fValidaCol(strCodCol: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   COUNT(*)    QTD ');
  qryGen.SQL.Add(' FROM UNI_CADCOL ');
  qryGen.SQL.Add(' WHERE COL_CODCOL = :CODCOL ');

  qryGen.ParamByName('CODCOL').AsString := strCodCol;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

procedure TfrmCadUniNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodigo: String;
begin
  strCodigo := qryCadNfm.FieldbyName('NFM_CODNFM').AsString;
  fStartTransaction;
  inherited;
  Try
    If blnExcluiu Then
    Begin
      TUniversoImobiliariaDinamica.pDeletarNovaFormula(strCodigo);
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
end;

initialization
  RegisterClass(TfrmCadUniNovasFormulas);
finalization
  UnRegisterClass(TfrmCadUniNovasFormulas);

end.
