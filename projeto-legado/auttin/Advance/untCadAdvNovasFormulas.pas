unit untCadAdvNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, Uni, DB, EditFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadAdvNovasFormulas = class(TfrmPaiCad) 
    pnlCentral: TPanel;
    Label2: TLabel;
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
    pnlCabecalho: TPanel;
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
    Label1: TLabel;
    dbeBase2: TDBEditFocus;
    lblInformacao: TLabel;
    edtBase1: TEditFocus;
    edtBase2: TEditFocus;
    lblCol7: TLabel;
    dbeForm07: TDBEditFocus;
    lblQtd7: TLabel;
    dbeQtd07: TDBEditFocus;
    lblCol8: TLabel;
    dbeForm08: TDBEditFocus;
    lblQtd8: TLabel;
    dbeQtd08: TDBEditFocus;
    lblCol9: TLabel;
    dbeForm09: TDBEditFocus;
    lblQtd9: TLabel;
    dbeQtd09: TDBEditFocus;
    lblCol10: TLabel;
    dbeForm10: TDBEditFocus;
    lblQtd10: TLabel;
    dbeQtd10: TDBEditFocus;
    Label28: TLabel;
    dbeDtaCad: TDBEditFocus;
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeBase1KeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    procedure pCarregaDesBas;
  protected
    procedure pCriarDataSets;
    procedure pLigarDataSets;
    procedure pInicializaIndices; override;
    function fValidaBase(strcodBas: String): Boolean;
    function fValidaCol(strCodCol: String): Boolean;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
    function fVerificaBasesLigadas(strCodBas:String): Boolean;
    procedure pMostrarBases(strCodBas: String);
  public
    { Public declarations }
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
  end;

var
  frmCadAdvNovasFormulas: TfrmCadAdvNovasFormulas;

implementation

uses untAdvanceIndustrialDinamica, untFuncoesSimples, StrUtils,
     untIConfTinta, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadAdvNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfm: String;
    conf: IConfTinta;
begin
  qryTabela := qryCadNfm;
  conf      := fGetConfTinta('ADV');
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfm := conf.fGet('NFMADV'); //fArqIniTinta(0, 'ADVANCE', 'NFMADV', '0');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + fStrZero(strNfm, 5);
    qryTabela.FieldByName('NFM_CARTA_').AsString := 'PERSONALIZADA';
    qryTabela.FieldByName('NFM_PRODUT').AsString := 'PERSONALIZADO';
  End;
  fStartTransaction;
  inherited;
  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If TAdvanceIndustrialDinamica.fGravarNovaFormula(qryCadNfm) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NFMADV', fStrZero(StrToInt(strNfm) + 1, 5)); //fArqIniTinta(1, 'ADVANCE', 'NFMADV', fStrZero(StrToInt(strNfm) + 1, 5));
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

procedure TfrmCadAdvNovasFormulas.pCriarDataSets;
  Var
    intCont: Integer;
begin
  qryCadNfm := fCriarQuery('SELECT * FROM ADV_CADNFM');

  qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  qryCadNfm.FieldByName('NFM_CARTA_').DisplayLabel := 'Carta';
  qryCadNfm.FieldByName('NFM_PRODUT').DisplayLabel := 'Produto';
  qryCadNfm.FieldByName('NFM_FORMUL').DisplayLabel := 'Fórmula';
  qryCadNfm.FieldByName('NFM_DTACAD').DisplayLabel := 'Data Cadastro';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 10 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
  End;

  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;

procedure TfrmCadAdvNovasFormulas.pLigarDataSets;
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

procedure TfrmCadAdvNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriarDataSets;
  pLigarDataSets;

  qryTabela := qryCadNfm;
  strNomeTabela := 'ADV_CADNFM';
  strNomeCampo := 'NFM_CODNFM';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

function TfrmCadAdvNovasFormulas.fValidaCampos(Sender: TWinControl;
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
      pCarregaDesBas;
      If fEmptyStr(dbeBase1.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'Uma base deve ser escolhida!', ['OK']) = -1;
      End
      Else If fEmptyStr(edtBase1.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'A base selecionada não é válida!', ['OK']) = -1;
      End
      Else If Not fVerificaBasesLigadas(dbeBase1.Text) Then
      Begin
        pMostrarBases(dbeBase1.Text);
      End;
    End
    Else If Sender = dbeBase2 Then
    Begin
      pCarregaDesBas;

      If Not fEmptyStr(dbeBase2.Text) Then
      Begin
        If fEmptyStr(edtBase2.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'A base selecionada não é válida!', ['OK']) = -1;
        End
        Else If Not fVerificaBasesLigadas(dbeBase2.Text) Then
        Begin
          pMostrarBases(dbeBase2.Text);
        End;
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
        End;
      End
      Else If Not (fEmptyStr(TDBEdit(Sender).Text)) Then
      Begin
        If Not fValidaCol(TDBEdit(Sender).Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O colorante não é válido!', ['OK']) = -1;
        End;
      End
      Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
        Result := False;
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

procedure TfrmCadAdvNovasFormulas.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_CARTA_');
  stlCampos.Add('NFM_PRODUT');
  stlCampos.Add('NFM_FORMUL');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_FORMUL');
  stlCamInd.Add('NFM_CARTA_');
  stlCamInd.Add('NFM_CODNFM');

  stlDesInd.Add('Fórmula');
  stlDesInd.Add('Carta');
  stlDesInd.Add('Código');
end;

procedure TfrmCadAdvNovasFormulas.pCarregaDesBas;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   BAS_CODBAS, ');
  qryGen.SQL.Add('   BAS_DESCRI ');
  qryGen.SQL.Add(' FROM ADV_CADBAS ');
  qryGen.SQL.Add(' WHERE BAS_UNIDAD = "QT" ');
  qryGen.SQL.Add('     AND BAS_CODBAS = :CODBAS ');

  qryGen.Close;
  qryGen.ParamByName('CODBAS').AsString := dbeBase1.Text;
  qryGen.Open;
  edtBase1.Text := qryGen.fieldByName('BAS_DESCRI').AsString;

  qryGen.Close;
  qryGen.ParamByName('CODBAS').AsString := dbeBase2.Text;
  qryGen.Open;
  edtBase2.Text := qryGen.fieldByName('BAS_DESCRI').AsString;

  FreeAndNil(qryGen);
end;

procedure TfrmCadAdvNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conAdv, Nil, qryTabela, key, arrSel) Then
  Begin
    pCarregaDesBas;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadAdvNovasFormulas.dbeBase1KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqBaseTinta(Self, conAdv, TDBEdit(Sender), Nil, Nil, Key, arrSel, True, ' AND BAS_UNIDAD = "QT" ', 'BAS_CODITE') Then
  Begin
    If Not fVerificaBasesLigadas(TDBEdit(Sender).Text) Then
      pMostrarBases(TDBEdit(Sender).Text);
    pCarregaDesBas;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAdvNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  qryTabela.FieldByName('NFM_DTACAD').AsDateTime := Date;
  dbeUnidade.Field.AsString := 'QT';
  pSetFocus(dbeDescri);
end;

procedure TfrmCadAdvNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqColorantes(Self, conAdv, TDBEdit(Sender), Nil, Nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

function TfrmCadAdvNovasFormulas.fJaExisteEssaBaseNaFormulacao(
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

function TfrmCadAdvNovasFormulas.fValidaBase(strcodBas: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   COUNT(*)    QTD ');
  qryGen.SQL.Add(' FROM ADV_CADBAS ');
  qryGen.SQL.Add(' WHERE BAS_CODBAS = :CODBAS ');
  qryGen.SQL.Add('     AND BAS_UNIDAD = "QT" ');

  qryGen.ParamByName('CODBAS').AsString := strcodBas;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

function TfrmCadAdvNovasFormulas.fValidaCol(strCodCol: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   COUNT(*)    QTD ');
  qryGen.SQL.Add(' FROM ADV_CADCOL ');
  qryGen.SQL.Add(' WHERE COL_CODCOL = :CODCOL ');

  qryGen.ParamByName('CODCOL').AsString := strCodCol;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

procedure TfrmCadAdvNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDescri);
end;

function TfrmCadAdvNovasFormulas.fVerificaBasesLigadas(
  strCodBas: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   COUNT(BAS_CODITE)    QTD ');
  qryGen.SQL.Add(' FROM ADV_CADBAS ');
  qryGen.SQL.Add(' WHERE IFNULL(BAS_CODITE, "") <> "" ');
  qryGen.SQL.Add('     AND BAS_CODBAS = :CODBAS ');
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger = 3; //qt gl la
  FreeAndNil(qryGen);
end;

procedure TfrmCadAdvNovasFormulas.pMostrarBases(strCodBas: String);
  Var
    qryGen : TUniQuery;
    strMensagem: String;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   BAS_CODBAS, ');
  qryGen.SQL.Add('   BAS_UNIDAD, ');
  qryGen.SQL.Add('   ITE_CODITE, ');
  qryGen.SQL.Add('   ITE_DESITE ');
  qryGen.SQL.Add(' FROM ADV_CADBAS ');
  qryGen.SQL.Add('   LEFT JOIN CADITE ');
  qryGen.SQL.Add('     ON BAS_CODITE = ITE_CODITE ');
  qryGen.SQL.Add(' WHERE BAS_CODBAS = :CODBAS ');
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.Open;

  strMensagem := '';

  While Not qryGen.Eof Do
  Begin
    strMensagem := strMensagem + qryGen.FieldByName('BAS_CODBAS').AsString + ' - ';
    strMensagem := strMensagem + qryGen.FieldByName('BAS_UNIDAD').AsString + ' - ';

    If fEmptyStr(qryGen.FieldByName('ITE_CODITE').AsString) Then
    Begin
      strMensagem := strMensagem + 'NÃO ASSOCIADO - ' + #10#13;
    End
    Else
    Begin
      strMensagem := strMensagem + qryGen.FieldByName('ITE_CODITE').AsString + ' - ';
      strMensagem := strMensagem + qryGen.FieldByName('ITE_DESITE').AsString + #10#13;
    End;

    qryGen.Next;
  End;

  fMensagem('ATENÇÃO: BASES NÃO ASSOCIADAS', Trim(strMensagem), ['OK']);
  FreeAndNil(qryGen);
end;

procedure TfrmCadAdvNovasFormulas.btnExcluirClick(Sender: TObject);
begin
  fStartTransaction;
  inherited;
  Try
    If blnExcluiu Then
    Begin
      TAdvanceIndustrialDinamica.fDeletaNovaFormula(qryCadNfm.FieldByName('NFM_CODNFM').AsString);
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
  RegisterClass(TfrmCadAdvNovasFormulas);
finalization
  UnRegisterClass(TfrmCadAdvNovasFormulas);

end.

