 unit untCadGenNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, dbcgrids, DB, UniClientDataSet, Uni,
  EditFocus,BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadGenNfm = class(TfrmPaiCad)
    pnlCampos: TPanel;
    lblCodigo: TLabel;
    lblVariac: TLabel;
    lblDescricao: TLabel;
    lblMontadora: TLabel;
    lblAnoIni: TLabel;
    lblAnoFin: TLabel;
    lblVersao: TLabel;
    lblProduto: TLabel;
    pnlCabecalho: TPanel;
    dbeVariac: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    dbeCodMontadora: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    dbeAnoIni: TDBEditFocus;
    dbeAnoFin: TDBEditFocus;
    dbeVersao: TDBEditFocus;
    dbeProduto: TDBEditFocus;
    grpFormulacao: TGroupBox;
    lblBase: TLabel;
    dbeBase01: TDBEditFocus;
    lblQuantidade1: TLabel;
    dbeQuantidade01: TDBEditFocus;
    dbeQuantidade02: TDBEditFocus;
    lblQuantidade2: TLabel;
    dbeBase02: TDBEditFocus;
    lblBase2: TLabel;
    lblBase3: TLabel;
    dbeBase03: TDBEditFocus;
    lblQuantidade3: TLabel;
    dbeQuantidade03: TDBEditFocus;
    lblBase4: TLabel;
    dbeBase04: TDBEditFocus;
    lblQuantidade4: TLabel;
    dbeQuantidade04: TDBEditFocus;
    lblBase5: TLabel;
    dbeBase05: TDBEditFocus;
    lblQuantidade5: TLabel;
    dbeQuantidade05: TDBEditFocus;
    lblBase6: TLabel;
    dbeBase06: TDBEditFocus;
    lblQuantidade6: TLabel;
    dbeQuantidade06: TDBEditFocus;
    lblBase7: TLabel;
    dbeBase07: TDBEditFocus;
    lblQuantidade7: TLabel;
    dbeQuantidade07: TDBEditFocus;
    lblBase8: TLabel;
    dbeBase08: TDBEditFocus;
    lblQuantidade8: TLabel;
    dbeQuantidade08: TDBEditFocus;
    lblBase9: TLabel;
    dbeBase09: TDBEditFocus;
    lblQuantidade9: TLabel;
    dbeQuantidade09: TDBEditFocus;
    lblBase10: TLabel;
    dbeBase10: TDBEditFocus;
    lblQuantidade10: TLabel;
    dbeQuantidade10: TDBEditFocus;
    edtDesMontadora: TEditFocus;
    dbchkNacional: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeBase10KeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodMontadoraKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    procedure pCriarDataSets;
    procedure pLigarDataSets;
    procedure pCarregarMontadora;
    function fValidaBase(strCodBas: String): Boolean;
    function fValidaProduto(strProduto: String): Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;

var
  frmCadGenNfm: TfrmCadGenNfm;

implementation

uses untFuncoesSimples, StrUtils, untGeneral,
      untIConfTinta, untFuncTinta, untConsultas, untTypesSistema;
{$R *.dfm}

{ TfrmCadGenNfm }

procedure TfrmCadGenNfm.pCriarDataSets;
  Var
    intCont: Integer;
begin
  qryCadNfm := fCriarQuery('SELECT * FROM GEN_CADNFM;');
  dtsCadNfm := fCriaDataSource(qryCadNfm);

  qryCadNfm.FieldByName('NFM_CODIGO').DisplayLabel := 'Código';
  qryCadNfm.FieldByName('NFM_VARIAC').DisplayLabel := 'Variação';
  qryCadNfm.FieldByName('NFM_DESCRI').DisplayLabel := 'Descrição';
  qryCadNfm.FieldByName('NFM_CODMON').DisplayLabel := 'Código Montadora';
  qryCadNfm.FieldByName('NFM_ANOINI').DisplayLabel := 'Ano Inicial';
  qryCadNfm.FieldByName('NFM_ANOFIN').DisplayLabel := 'Ano Final';
  qryCadNfm.FieldByName('NFM_NACION').DisplayLabel := 'Nascional';
  qryCadNfm.FieldByName('NFM_CODCOR').DisplayLabel := 'Código Cor';
  qryCadNfm.FieldByName('NFM_VERSAO').DisplayLabel := 'Versão';
  qryCadNfm.FieldByName('NFM_PRODUT').DisplayLabel := 'Produto';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 15 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.00';
    TFloatField(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).EditFormat := '0.00';
  End;
end;

procedure TfrmCadGenNfm.pLigarDataSets;
  Var
    intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadNfm;
    End;

    If (Components[intCont] is TDBCheckBox ) Then
    Begin
      (Components[intCont] as TDBCheckBox).DataSource := dtsCadNfm;
    End;
  End;
end;

procedure TfrmCadGenNfm.FormCreate(Sender: TObject);
begin
  inherited;
  pCriarDataSets;
  pLigarDataSets;

  qryTabela := qryCadNfm;
  strNomeTabela := 'GEN_CADNFM';
  strNomeCampo := 'NFM_CODIGO';

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodigo;
  arrCamposChave[1] := dbeVariac;
end;

function TfrmCadGenNfm.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If Sender = dbeDescricao Then
    Begin
      If fEmptyStr(dbeDescricao.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'A descrição deve ser preenchida!', ['OK']) = -1;
      End;
    End
    Else If Sender = dbeCodMontadora Then
    Begin
      If Not fEmptyStr(dbeCodMontadora.Text) Then
      Begin
        pCarregarMontadora;

        If fEmptyStr(edtDesMontadora.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esta montadora não está cadastrada!', ['OK']) = -1;
        End;
      End;
    End
    Else If Sender = dbeProduto Then
    Begin
      If fEmptyStr(dbeProduto.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O produto deve ser escolhido!', ['OK']) = -1;
      End
      Else If Not fValidaProduto(dbeProduto.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O produto escolhido não é valido!', ['OK']) = -1;
      End;
    End
    Else If LeftStr(Sender.Name, 13) = 'dbeQuantidade' Then
    Begin
      If Not fEmptyStr(TDBEdit(FindComponent('dbeBase' + RightStr(Sender.Name, 2))).Text) Then
      Begin
        If fEmptyStr(TDBEdit(Sender).Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'A Quantidade deve ser preenchida!', ['OK']) = -1;
        End
        Else If fStrToFloat(TDBEdit(Sender).Text) <= 0 Then
        Begin
          Result := fMensagem('ATENÇÃO', 'A Quantidade deve ser maior que zero!', ['OK']) = -1;
        End
      End;
    End
    Else If LeftStr(Sender.Name, 7) = 'dbeBase' Then
    Begin
      If (fEmptyStr(dbeBase01.Text)) Then
      Begin
        Sender := dbeBase01;
        Result := fMensagem('ATENÇÃO', 'Entre com pelo menos uma base!', ['OK']) = -1;
      End
      Else If fEmptyStr(TDBEdit(Sender).Text) Then
      Begin
        pSetFocus(dbeQuantidade10);
      End
      Else If Not fValidaBase(TDBEdit(Sender).Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'A base não é álida!', ['OK']) = -1;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadGenNfm.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODIGO');
  stlCampos.Add('NFM_VARIAC');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('NFM_VERSAO');
  stlCampos.Add('NFM_PRODUT');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODIGO');
  stlCamInd.Add('NFM_VARIAC');
  stlCamInd.Add('NFM_DESCRI');
  stlCamInd.Add('NFM_VERSAO');
  stlCamInd.Add('NFM_PRODUT');
  stlCamInd.Add('AUTOINCREM');

  stlDesInd.Add('Código');
  stlDesInd.Add('Variação');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Versão');
  stlDesInd.Add('Produto');
end;

procedure TfrmCadGenNfm.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqFormulaTinta(Self, conGen, nil, qryTabela, key, arrSel) Then
  Begin
    pSetFocus(btnAlterar);
    pCarregarMontadora;
  End;
end;

procedure TfrmCadGenNfm.pCarregarMontadora;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT MON_DESCRI FROM GEN_CADMON WHERE MON_CODMON = :CODMON';
  qryGen.ParamByName('CODMON').AsString := dbeCodMontadora.Text;
  qryGen.Open;

  edtDesMontadora.Text := qryGen.FieldByName('MON_DESCRI').AsString;
  FreeAndNil(qryGen);
end;

procedure TfrmCadGenNfm.dbeBase10KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqBaseTinta(Self, conGen, TDBEdit(Sender), Nil, Nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

function TfrmCadGenNfm.fValidaBase(strCodBas: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT COUNT(*) QTD FROM GEN_CADBAS WHERE BAS_CODBAS = :CODBAS;';
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

procedure TfrmCadGenNfm.dbeCodMontadoraKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqMontadoraTinta(Self, conGen, TDBEdit(Sender), edtDesMontadora, Nil, key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadGenNfm.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;

  pSetFocus(dbeDescricao);
end;

procedure TfrmCadGenNfm.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDescricao);
end;

function TfrmCadGenNfm.fValidaProduto(strProduto: String): Boolean;
begin
  Result := Pos(strProduto, '_ESMALTE SINTETICO_LACA NICTROCELULOSE_BASE POLIESTER_PU_') > 0;
end;

procedure TfrmCadGenNfm.dbeProdutoKeyPress(Sender: TObject; var Key: Char);
  Const
    arrOpcoes: Array[1..4] Of String =
      ('ESMALTE SINTETICO', 'LACA NICTROCELULOSE', 'BASE POLIESTER', 'PU');
begin
  If fEntraCons(Key) Then
  Begin
    Key := #0;
    dbeProduto.Text := arrOpcoes[fGetMenu('ESCOLHA O PRODUTO',arrOpcoes , 1, True)];
  End;
end;

procedure TfrmCadGenNfm.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfm: String;
    conf: IConfTinta;
begin
  conf     := fGetConfTinta('GEN');
  qryTabela     := qryCadNfm;
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfm := conf.fGet('GENNFM'); //fArqIniTinta(0, 'GENERAL', 'GENNFM', '0');
    qryTabela.FieldByName('NFM_CODIGO').AsString := 'ESP ' + fStrZero(strNfm, 5);
  End;
  fStartTransaction;
  inherited;
  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If TGeneral.fGravaNovaFormula(qryCadNfm) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('GENNFM', fStrZero(StrToInt(strNfm) + 1, 5)); //fArqIniTinta(1, 'GENERAL', 'GENNFM', fStrZero(StrToInt(strNfm) + 1, 5));
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

initialization
  RegisterClass(TfrmCadGenNfm);
finalization
  UnRegisterClass(TfrmCadGenNfm);

end.

