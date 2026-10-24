unit untCadMzaNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, dbcgrids, DB, UniClientDataSet, Uni,
  EditFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadMzaNfm = class(TfrmPaiCad) 
    pnlCampos: TPanel;
    lblCodigo: TLabel;
    lblVariac: TLabel;
    lblDescricao: TLabel;
    lblMontadora: TLabel;
    lblLinha: TLabel;
    dbeVariac: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    dbeCodMontadora: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    dbeLinha_: TDBEditFocus;
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
    dbeObserv: TDBEditFocus;
    Label1: TLabel;
    edtDesLinha_: TEditFocus;
    Label2: TLabel;
    dbeUniver: TDBEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    dbeBase11: TDBEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    dbeBase12: TDBEditFocus;
    dbeBase13: TDBEditFocus;
    dbeBase14: TDBEditFocus;
    dbeBase15: TDBEditFocus;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    dbeQuantidade11: TDBEditFocus;
    dbeQuantidade12: TDBEditFocus;
    dbeQuantidade13: TDBEditFocus;
    dbeQuantidade14: TDBEditFocus;
    dbeQuantidade15: TDBEditFocus;
    Label14: TLabel;
    Label15: TLabel;
    dbePesCor: TDBEditFocus;
    dbePesFor: TDBEditFocus;
    Label16: TLabel;
    dbeAcrMob: TDBEditFocus;
    pnlCabecalho: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeBase10KeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodMontadoraKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbeLinha_KeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    procedure pCriarDataSets;
    procedure pLigarDataSets;
    procedure pCarregarMontadora;
    procedure pCarregarLinha;
    function fValidaBase(strCodBas: String): Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
  end;

var
  frmCadMzaNfm: TfrmCadMzaNfm;

implementation

uses untFuncoesSimples, StrUtils,
     untIConfTinta, untFuncTinta,  untMazaAutomotiva, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadMzaNfm }

procedure TfrmCadMzaNfm.pCriarDataSets;
  Var
    intCont: Integer;
begin
  qryCadNfm := fCriarQuery('SELECT * FROM MZA_CADNFM;');
  dtsCadNfm := fCriaDataSource(qryCadNfm);

  qryCadNfm.FieldByName('NFM_CODIGO').DisplayLabel := 'Código';
  qryCadNfm.FieldByName('NFM_VARIAC').DisplayLabel := 'Variação';
  qryCadNfm.FieldByName('NFM_DESCRI').DisplayLabel := 'Descrição';
  qryCadNfm.FieldByName('NFM_OBSERV').DisplayLabel := 'Observação';  
  qryCadNfm.FieldByName('NFM_CODMON').DisplayLabel := 'Código Montadora';
  qryCadNfm.FieldByName('NFM_UNIVER').DisplayLabel := 'Versão';
  qryCadNfm.FieldByName('NFM_LINHA_').DisplayLabel := 'Linha';
  qryCadNfm.FieldByName('NFM_ACRMOB').DisplayLabel := 'Acréscimo mão de obra';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  TFloatField(qryCadNfm.FieldByName('NFM_PESCOR')).DisplayFormat := '0.000000';
  TFloatField(qryCadNfm.FieldByName('NFM_PESCOR')).EditFormat    := '0.000000';
  TFloatField(qryCadNfm.FieldByName('NFM_PESFOR')).DisplayFormat := '0.000000';
  TFloatField(qryCadNfm.FieldByName('NFM_PESFOR')).EditFormat    := '0.000000';

  TFloatField(qryCadNfm.FieldByName('NFM_ACRMOB')).DisplayFormat := '0.00';
  TFloatField(qryCadNfm.FieldByName('NFM_ACRMOB')).EditFormat    := '0.00';

  For intCont := 1 To 15 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.00';
    TFloatField(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).EditFormat := '0.00';
  End;
end;

procedure TfrmCadMzaNfm.pLigarDataSets;
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

procedure TfrmCadMzaNfm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCadNfm);
end;

procedure TfrmCadMzaNfm.FormCreate(Sender: TObject);
begin
  inherited;
  pCriarDataSets;
  pLigarDataSets;

  qryTabela := qryCadNfm;
  strNomeTabela := 'MZA_CADNFM';
  strNomeCampo := 'NFM_CODIGO';

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodigo;
  arrCamposChave[1] := dbeVariac;
end;

function TfrmCadMzaNfm.fValidaCampos(Sender: TWinControl;
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
    Else If Sender = dbeLinha_ Then
    Begin
      If fEmptyStr(dbeLinha_.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'A Linha deve ser escolhida!', ['OK']) = -1;
      End
      Else
      Begin
        pCarregarLinha;
        if fEmptyStr(edtDesLinha_.Text) then
          Result := fMensagem('ATENÇÃO', 'A Linha escolhida não é valida!', ['OK']) = -1;
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
        pSetFocus(dbeQuantidade15);
      End
      Else If Not fValidaBase(TDBEdit(Sender).Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'A base não é Válida!', ['OK']) = -1;
      End
      Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
        Result := False;
      End;
    End
    Else If Sender = dbePesCor Then
    Begin
      If (fEmptyStr(dbePesCor.Text)) Or (fStrToFloat(dbePesCor.Text) = 0) Then
      Begin
        fMensagem('ATENÇÃO', 'O Peso da Cor deve ser preenchido!', ['OK']);
        Result := False;
      End
    End
    Else If Sender = dbePesFor Then
    Begin
      If (fEmptyStr(dbePesFor.Text)) Or (fStrToFloat(dbePesFor.Text) = 0) Then
      Begin
        fMensagem('ATENÇÃO', 'A Peso da Fórmula deve ser preenchido!', ['OK']);
        Result := False;
      End
    End

    Else If (Sender = dbeAcrMob) Then
    Begin
      If fEmptyStr(dbeAcrMob.Text) Then
      Begin
        dbeAcrMob.Field.AsFloat := 0.00;
      End
      Else If Not fEmptyStr(dbeAcrMob.Text) Then
      Begin
        If (fStrToFloat(dbeAcrMob.Text) < 0) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O Acréscimo de Mão de Obra deve ser maior ou igual a zero', ['OK']) = -1;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadMzaNfm.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODIGO');
  stlCampos.Add('NFM_VARIAC');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('NFM_OBSERV');
  stlCampos.Add('NFM_LINHA_');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODIGO');
  stlCamInd.Add('NFM_VARIAC');
  stlCamInd.Add('NFM_DESCRI');
  stlCamInd.Add('NFM_OBSERV');
  stlCamInd.Add('NFM_LINHA_');
  stlCamInd.Add('AUTOINCREM');

  stlDesInd.Add('Código');
  stlDesInd.Add('Variação');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Observação');
  stlDesInd.Add('Linha');
end;

procedure TfrmCadMzaNfm.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key : char;
begin
  Key := '/';
  If fPesqFormulaTinta(Self, conMza, Nil, qryTabela, Key, arrSel) Then
  Begin
    pSetFocus(btnAlterar);
    pCarregarMontadora;
    pCarregarLinha;
  End;
end;

procedure TfrmCadMzaNfm.pCarregarLinha;
  Var
    qryMza: TUniQuery;
begin
  Try
    qryMza := fCriaQuery();
    qryMza.Close;
    qryMza.SQL.Clear;
    qryMza.SQL.Text := 'SELECT LIN_DESCRI FROM MZA_CADLIN WHERE LIN_CODIGO = :CODLIN';
    qryMza.ParamByName('CODLIN').AsString := dbeLinha_.Text;
    qryMza.Open;

    edtDesLinha_.Text := qryMza.FieldByName('LIN_DESCRI').AsString;
  Finally
    FreeAndNil(qryMza);
  End;
end;

procedure TfrmCadMzaNfm.pCarregarMontadora;
  Var
    qryMza: TUniQuery;
begin
  Try
    qryMza := fCriaQuery();
    qryMza.Close;
    qryMza.SQL.Clear;
    qryMza.SQL.Text := 'SELECT MON_DESCRI FROM MZA_CADMON WHERE MON_CODMON = :CODMON';
    qryMza.ParamByName('CODMON').AsString := dbeCodMontadora.Text;
    qryMza.Open;

    edtDesMontadora.Text := qryMza.FieldByName('MON_DESCRI').AsString;
  Finally
    FreeAndNil(qryMza);
  End;
end;

procedure TfrmCadMzaNfm.dbeBase10KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqBaseTinta(Self, conMza, TDBEdit(Sender), nil, Nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

function TfrmCadMzaNfm.fValidaBase(strCodBas: String): Boolean;
  Var
    qryMza: TUniQuery;
begin
  Try
    qryMza := fCriaQuery();
    qryMza.Close;
    qryMza.SQL.Clear;
    qryMza.SQL.Text := 'SELECT COUNT(*) QTD FROM MZA_CADBAS WHERE BAS_CODBAS = :CODBAS;';
    qryMza.ParamByName('CODBAS').AsString := strCodBas;
    qryMza.Open;

    Result := qryMza.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryMza);
  End;
end;

procedure TfrmCadMzaNfm.dbeCodMontadoraKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqMontadoraTinta(Self, conMza, TDBEdit(Sender), Nil, Nil, Key, arrSel) Then
  Begin
    pCarregarMontadora;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMzaNfm.dbeLinha_KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqMZA_CADLIN(Self, TDBEdit(Sender), Nil, Key, arrSel) Then
  Begin
    pCarregarLinha;
    SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadMzaNfm.fJaExisteEssaBaseNaFormulacao(strCodBas: String;
  dbeForm: TObject): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To 15 Do
  Begin
    If (RightStr(TDBEditFocus(dbeForm).Name, 2) <> fStrZero(intCont,2)) And
       (Not fEmptyStr(TDBEditFocus(FindComponent('dbeBase' + fStrZero(intCont,2))).Text)) Then
    Begin
      If TDBEditFocus(FindComponent('dbeBase' + fStrZero(intCont,2))).Text = strCodBas Then
        Result := True;
    End;
  End;


end;

procedure TfrmCadMzaNfm.btnIncluirClick(Sender: TObject);
begin
  inherited;
//pSetFocus(dbeDescricao);
  pSetFocus(dbeVariac);
  edtDesMontadora.Clear;
  edtDesLinha_.Clear;
end;

procedure TfrmCadMzaNfm.btnAlterarClick(Sender: TObject);
begin
  inherited;
//pSetFocus(dbeDescricao);
  pSetFocus(dbeVariac);
end;

procedure TfrmCadMzaNfm.btnExcluirClick(Sender: TObject);
var
  strCodigo : String;
begin
  strCodigo := dbeCodigo.text;
  fStartTransaction;
  inherited;

  Try
    If (blnExcluiu) Then
    Begin
      TMazaAutomotiva.pDeletaNovaFormulaDinamica(strCodigo);
      fCommit;
      edtDesMontadora.Clear;
      edtDesLinha_.Clear;
      blnExcluiu  := False;
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

procedure TfrmCadMzaNfm.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfm: String;
    conf: IConfTinta;
begin
  conf     := fGetConfTinta('MZA');
  qryTabela     := qryCadNfm;
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfm := conf.fGet('MZANFM');
    qryTabela.FieldByName('NFM_CODIGO').AsString := 'ESP ' + fStrZero(strNfm, 5);
  End;
  fStartTransaction;
  inherited;
  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If TMazaAutomotiva.fGravaNovaFormula(qryCadNfm) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('MZANFM', fStrZero( StrToInt(strNfm) + 1  , 5));
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
  RegisterClass(TfrmCadMzaNfm);
finalization
  UnRegisterClass(TfrmCadMzaNfm);

end.

