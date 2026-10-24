unit untCadAdtNovasFormulas;

interface

uses
  SysUtils, Classes, Controls, Forms,
  untPaiCad, StdCtrls, 
  ExtCtrls, Mask, DBCtrls, DBEditFocus, Uni, DB, EditFocus,
  BitBtnLockedIncrem, AppEvnts, Menus, ComCtrls, Buttons, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadAdtNovasFormulas = class(TfrmPaiCad) 
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
    edtBase1: TEditFocus;
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
    dbeProduto: TDBEditFocus;
    lblProduto: TLabel;
    edtDesEmbalagem: TEditFocus;
    Label18: TLabel;
    dbeForm11: TDBEditFocus;
    Label19: TLabel;
    dbeQtd11: TDBEditFocus;
    Label20: TLabel;
    dbeForm12: TDBEditFocus;
    Label21: TLabel;
    dbeQtd12: TDBEditFocus;
    Label22: TLabel;
    dbeForm13: TDBEditFocus;
    Label23: TLabel;
    dbeQtd13: TDBEditFocus;
    Label24: TLabel;
    dbeForm14: TDBEditFocus;
    Label25: TLabel;
    dbeQtd14: TDBEditFocus;
    Label26: TLabel;
    dbeForm15: TDBEditFocus;
    Label27: TLabel;
    dbeQtd15: TDBEditFocus;
    Label28: TLabel;
    dbeForm16: TDBEditFocus;
    Label29: TLabel;
    dbeQtd16: TDBEditFocus;
    Label30: TLabel;
    dbeForm17: TDBEditFocus;
    Label31: TLabel;
    dbeQtd17: TDBEditFocus;
    Label32: TLabel;
    dbeForm18: TDBEditFocus;
    Label33: TLabel;
    dbeQtd18: TDBEditFocus;
    Label34: TLabel;
    dbeForm19: TDBEditFocus;
    Label35: TLabel;
    dbeQtd19: TDBEditFocus;
    Label36: TLabel;
    dbeForm20: TDBEditFocus;
    Label37: TLabel;
    dbeQtd20: TDBEditFocus;
    lblQtdCatali: TLabel;
    dbeQuantidadeCatali: TDBEditFocus;
    lblInformacao: TLabel;
    Label38: TLabel;
    dbeDtaCad: TDBEditFocus;
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeBase1KeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeBase2KeyPress(Sender: TObject; var Key: Char);
    procedure dbeForm01Exit(Sender: TObject);
    procedure dbeQtd01Exit(Sender: TObject);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    procedure pCarregarDescricoes;
    procedure CalculaQuantidades;
  protected
    procedure pCriarDataSets;
    procedure pLigarDataSets;
    procedure pInicializaIndices; override;
    function fValidaBase(strcodBas: String): Boolean;
    function fValidaCol(strCodCol: String): Boolean;
    function fValidaCatalisador(const strCodCatalisa: string): Boolean;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
  end;

var
  frmCadAdtNovasFormulas: TfrmCadAdtNovasFormulas;

implementation

uses untFuncoesSimples, StrUtils,untIConfTinta,
     untFuncTinta, untClientDataSetFactory,
     UniClientDataSet, untProcessadorGravandoExecucaoAdvanceTintoSystemCores, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadAdtNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfm: String;
    conf: IConfTinta;
begin
  qryTabela     := qryCadNfm;
  conf := fGetConfTinta('ADT');
  CalculaQuantidades;

  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfm := conf.fGet('NFMADT');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + VS_strCodEmp + fStrZero(strNfm, 5);
    qryTabela.FieldByName('NFM_CODTEC').AsString := 'PERSONALIZADA';
    qryTabela.FieldByName('NFM_IDFORM').AsString := qryTabela.FieldByName('NFM_CODNFM').AsString;
  End;

  fStartTransaction;
  inherited;

  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If TProcessadorGravandoExecucaoAdvanceTintoSystemCores.GravarNovaFormula(qryCadNfm) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NFMADT', fStrZero(StrToInt(strNfm) + 1, 5));
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

procedure TfrmCadAdtNovasFormulas.pCriarDataSets;
  Var
    intCont: Integer;
begin
  qryCadNfm := fCriarQuery('SELECT * FROM ADT_CADNFM');

  qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  qryCadNfm.FieldByName('NFM_IDFORM').DisplayLabel := 'Fórmula';
  qryCadNfm.FieldByName('NFM_CODCOR').DisplayLabel := 'Código da Cor';
  qryCadNfm.FieldByName('NFM_CODTEC').DisplayLabel := 'Código Técnico';
  qryCadNfm.FieldByName('NFM_DTACAD').DisplayLabel := 'Data Cadastro';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 10 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
  End;

  TFloatField(qryCadNfm.FieldByName('NFM_QTDCAT')).DisplayFormat := '0.000';
  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;

procedure TfrmCadAdtNovasFormulas.pLigarDataSets;
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

procedure TfrmCadAdtNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriarDataSets;
  pLigarDataSets;

  qryTabela := qryCadNfm;
  strNomeTabela := 'ADT_CADNFM';
  strNomeCampo := 'NFM_CODNFM';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

function TfrmCadAdtNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If Sender = dbeDescri Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
         Result :=  fMensagem('ATENÇÃO', 'O Código da Cor deve ser preenchido!', ['OK']) = -1;
      End;
    End
    Else If Sender = dbeBase1 Then
    Begin
      pCarregarDescricoes;
      If fEmptyStr(dbeBase1.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'A base deve ser preenchida!', ['OK']) = -1;
      End
      Else If fEmptyStr(edtBase1.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'A base selecionada não é válida!', ['OK']) = -1;
      End;
    End
    Else If Sender = dbeBase2 Then
    Begin
      if not fEmptyStr(dbeBase2.Text) then
      begin
        If Not fValidaCatalisador(dbeBase2.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O catalisador selecionado não é válido!', ['OK']) = -1;
        End;
      end;
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
      Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse colorante já está cadastrado para essa fórmula!', ['&Ok']);
        Result := False;
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
    End
    else if Sender = dbeQuantidadeCatali then
    begin
      if (not fEmptyStr(dbeBase2.Text)) then
      begin
        if fEmptyStr(dbeQuantidadeCatali.Text) then
        begin
          Result := fMensagem('ATENÇÃO', 'A quantidade deve ser maior que zero!', ['OK']) = -1;
        end;
      end;
    end
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadAdtNovasFormulas.fValidaCatalisador(const strCodCatalisa: string): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
{        ' SELECT                     ' +
        '   COUNT(0) AS QTD          ' +
        ' FROM                       ' +
        '   ADT_CADCOL               ' +
        ' WHERE COL_CODCOL = :CODCOL ' +
        '   AND COL_CATALI = "S"     ';}
        ' SELECT                            ' +
        '   COUNT(0) AS QTD                 ' +
        ' FROM                              ' +
        '   ADT_CADBAS                      ' +
        ' WHERE BAS_CODBAS = :CODBAS        ' +
        '   AND BAS_DESCRI LIKE "%PARTE B%" ';
      qryGen.ParamByName('CODBAS').AsString := strCodCatalisa;
      qryGen.Open;
      Result := qryGen.FieldByName('QTD').AsInteger > 0;
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

procedure TfrmCadAdtNovasFormulas.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_CODCOR');
  stlCampos.Add('NFM_PRODUT');
  stlCampos.Add('NFM_CODBAS');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_CODCOR');
  stlCamInd.Add('NFM_PRODUT');
  stlCamInd.Add('NFM_CODBAS');

  stlDesInd.Add('Fórmula');
  stlDesInd.Add('Código da Cor');
  stlDesInd.Add('Produto');
  stlDesInd.Add('Código da Base');
end;

procedure TfrmCadAdtNovasFormulas.pCarregarDescricoes;
var
  qryGen : TUniQuery;
  cdsGen: TUniClientDataSet;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                     ' +
        '   *                        ' +
        ' FROM                       ' +
        '   ADT_CADBAS               ' +
        ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_CODEMB = :CODEMB ' +
        '   AND BAS_PRODUT = :PRODUT ';

      qryGen.ParamByName('CODBAS').AsString := dbeBase1.Text;
      qryGen.ParamByName('CODEMB').AsString := dbeUnidade.Text;
      qryGen.ParamByName('PRODUT').AsString := dbeProduto.Text;

      cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);
      edtBase1.Text := cdsGen.FieldByName('BAS_DESCRI').AsString;

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.Params.Clear;
      qryGen.SQL.Text := 'SELECT * FROM ADT_CADEMB WHERE EMB_CODEMB = :CODEMB';
      qryGen.ParamByName('CODEMB').AsString := dbeUnidade.Text;
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);
      edtDesEmbalagem.Text := cdsGen.FieldByName('EMB_DESCRI').AsString;

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

procedure TfrmCadAdtNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  if fPesqFormulaTinta(Self, conAdt, Nil, qryTabela, Key, arrSel) Then
    pCarregarDescricoes;
end;

procedure TfrmCadAdtNovasFormulas.CalculaQuantidades;
var
  qryGen: TUniQuery;
begin
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                     ' +
        '   BAS_CONTEU               ' +
        ' FROM                       ' +
        '   ADT_CADBAS               ' +
        ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_PRODUT = :PRODUT ' +
        '   AND BAS_CODEMB = :CODEMB ';
      qryGen.ParamByName('CODBAS').AsString := dbeBase1.Text;
      qryGen.ParamByName('PRODUT').AsString := dbeProduto.Text;
      qryGen.ParamByName('CODEMB').AsString := dbeUnidade.Text;
      qryGen.Open;

      qryTabela.FieldByName('NFM_QTDBAS').AsFloat := qryGen.FieldByName('BAS_CONTEU').AsFloat;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then
      FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadAdtNovasFormulas.dbeBase1KeyPress(Sender: TObject; var Key: Char);
  var
    qryGen: TUniQuery;
    arrSel: TConsultasArray;
begin
  qryGen :=  fCriaQuery(Self);
  Try
    If fPesqBaseTinta(Self, conAdt, Nil, Nil, qryGen, Key, arrSel, True, ' AND B.BAS_DESCRI LIKE "%BASE%" ', 'BAS_CODITE') Then
    Begin
      dbeBase1.Field.AsString   := qryGen.FieldByName('BAS_CODBAS').AsString;
      dbeProduto.Field.AsString := qryGen.FieldByName('BAS_PRODUT').AsString;
      dbeUnidade.Field.AsString := qryGen.FieldByName('BAS_CODEMB').AsString;
      pCarregarDescricoes;
      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(stlCamInd);
  End;
end;

procedure TfrmCadAdtNovasFormulas.dbeBase2KeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  If fPesqBaseTinta(Self, conAdt, dbeBase2, Nil, Nil, Key, arrSel, True, ' AND B.BAS_DESCRI LIKE "%PARTE B%" AND B.BAS_CODEMB = ' + QuotedStr(dbeUnidade.Field.Text), 'BAS_CODITE') Then
  Begin
    pCarregarDescricoes;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAdtNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  blnUsaProCodigo := False;
  fInsereProCod(strNomeTabela);

  inherited;

  blnUsaProCodigo := False;
  qryTabela.FieldByName('NFM_DTACAD').AsDateTime := Date;
  pSetFocus(dbeProduto);

  edtBase1.Clear;
  edtDesEmbalagem.Clear;
end;

procedure TfrmCadAdtNovasFormulas.dbeForm01Exit(Sender: TObject);
begin
  if fEmptyStr(TDBEditFocus(Sender).Text) then
    pSetFocus(dbeBase2);
end;

procedure TfrmCadAdtNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  fPesqColorantes(Self, conAdt, TDBEdit(Sender), Nil, Nil, Key, arrSel);
end;

procedure TfrmCadAdtNovasFormulas.dbeQtd01Exit(Sender: TObject);
begin
  if fStrToFloat(TDBEditFocus(Sender).Text) <= 0 then
    pSetFocus(dbeBase2);
end;

function TfrmCadAdtNovasFormulas.fJaExisteEssaBaseNaFormulacao( strCodBas: String; dbeForm: TObject): Boolean;
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

function TfrmCadAdtNovasFormulas.fValidaBase(strcodBas: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   COUNT(*)    QTD ');
  qryGen.SQL.Add(' FROM ADT_CADBAS ');
  qryGen.SQL.Add(' WHERE BAS_CODBAS = :CODBAS ');
  qryGen.SQL.Add('     AND BAS_UNIDAD = "QT" ');

  qryGen.ParamByName('CODBAS').AsString := strcodBas;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

function TfrmCadAdtNovasFormulas.fValidaCol(strCodCol: String): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                     ' +
        '   COUNT(0) AS QTD          ' +
        ' FROM                       ' +
        '   ADT_CADCOL               ' +
        ' WHERE COL_CODCOL = :CODCOL ';
//        '   AND COL_CATALI = "N"     ';
      qryGen.ParamByName('CODCOL').AsString := strCodCol;
      qryGen.Open;
      Result := qryGen.FieldByName('QTD').AsInteger > 0;
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

procedure TfrmCadAdtNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDescri);
end;

procedure TfrmCadAdtNovasFormulas.btnExcluirClick(Sender: TObject);
Var
  strCodNfm: string;
begin
  strCodNfm := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  fStartTransaction;
  inherited;
  Try
    If blnExcluiu Then
    begin
      TProcessadorGravandoExecucaoAdvanceTintoSystemCores.DeletarNovaFormula(strCodNfm);
      edtBase1.Clear;
      edtDesEmbalagem.Clear;
      fCommit;
    end
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

initialization
  RegisterClass(TfrmCadAdtNovasFormulas);
finalization
  UnRegisterClass(TfrmCadAdtNovasFormulas);

end.

