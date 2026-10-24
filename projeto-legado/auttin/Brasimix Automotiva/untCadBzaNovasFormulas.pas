unit untCadBzaNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadBzaNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    dbeCodNfm: TDBEditFocus;
    dbeDescri: TDBEditFocus;
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
    Label5: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    dbeMontad: TDBEditFocus;
    Label6: TLabel;
    dbeAno: TDBEditFocus;
    Label27: TLabel;
    dbeCodUni: TDBEditFocus;
    dbeTipo: TDBComboBox;
    dtsBzaCadNfm: TDataSource;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    dbeForm11: TDBEditFocus;
    dbeForm12: TDBEditFocus;
    dbeForm13: TDBEditFocus;
    dbeForm14: TDBEditFocus;
    dbeForm15: TDBEditFocus;
    dbeForm16: TDBEditFocus;
    dbeForm17: TDBEditFocus;
    dbeForm18: TDBEditFocus;
    dbeForm19: TDBEditFocus;
    dbeForm20: TDBEditFocus;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    dbeQtdC11: TDBEditFocus;
    dbeQtdC12: TDBEditFocus;
    dbeQtdC13: TDBEditFocus;
    dbeQtdC14: TDBEditFocus;
    dbeQtdC15: TDBEditFocus;
    dbeQtdC16: TDBEditFocus;
    dbeQtdC17: TDBEditFocus;
    dbeQtdC18: TDBEditFocus;
    dbeQtdC19: TDBEditFocus;
    dbeQtdC20: TDBEditFocus;
    Label48: TLabel;
    dbeAcrMob: TDBEditFocus;
    Label49: TLabel;
    dbeDtaCad: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeTipoKeyPress(Sender: TObject; var Key: Char);
    procedure dtsBzaCadNfmStateChange(Sender: TObject);
  private
    { Private declarations }
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
  protected
    function fBaseCadastrada(strCodBas: String): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;

  public
    { Public declarations }
  end;

var
  frmCadBzaNovasFormulas: TfrmCadBzaNovasFormulas;

implementation

uses untModuloTinta, untPai,  untFuncoesSimples,
     untIConfTinta, untFuncTinta, untBrasimixAutomotivaDinamica, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadBzaNovasForumulas }

function TfrmCadBzaNovasFormulas.fBaseCadastrada(strCodBas: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BAS_CODBAS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BZA_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_CODBAS = :CODBAS ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBAS').AsString := strCodBas;
    Open;
    Result := (Not IsEmpty);
    Close;
  End;
end;

function TfrmCadBzaNovasFormulas.fJaExisteEssaBaseNaFormulacao(
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

function TfrmCadBzaNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumCol: String;
begin

  Result := True;

  If (Sender = dbeCodNfm) Then
  Begin
  End

  Else If (Sender = dbeTipo) Then
  Begin
    If (fEmptyStr(dbeTipo.Text)) Then
    Begin
      fMensagem('', 'O tipo deve ser preenchido!', ['&OK']);
      Result := False;
    End
    Else
    Begin
      If Not fValidaTipos(dbeTipo.Text) Then
      Begin
        fMensagem('', 'O tipo não é válido!', ['&OK']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = dbeDescri) Then
  Begin
    If (fEmptyStr(dbeDescri.Text)) Then
    Begin
      fMensagem('', 'A descrição deve ser preenchida!', ['&OK']);
      Result := False;
    End;
  End

  Else If (Sender = dbeForm01) and (fEmptyStr(dbeForm01.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos 1 base!', ['&Ok']);
    Result := False;
  End

  Else If (Sender is TDBEditFocus) and (LeftStr(Sender.Name, 7) = 'dbeForm') Then
  Begin
    If (Not fEmptyStr(TEditFocus(Sender).Text)) AND (Not fBaseCadastrada(TEditFocus(Sender).Text)) Then
    Begin
      fMensagem('','A base não está cadastrada!', ['&OK']);
      Result := False;
    End

    Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
      Result := False;
    End

    Else If fEmptyStr(TEditFocus(Sender).Text) Then
      pSetFocus(dbeQtdC20);
  End

  Else If (Sender is TDBEditFocus) and (LeftStr(Sender.Name, 7) = 'dbeQtdC') Then
  Begin
    strNumCol := RightStr(Sender.Name, 2);
    If Not fEmptyStr(TDBEditFocus(FindComponent('dbeForm' + strNumCol)).Text) Then
    Begin
      If fEmptyStr(TEditFocus(Sender).Text) Then
      Begin
        fMensagem('', 'A quantidade dee ser informada!', ['&OK']);
        Result := False;
      End;
    End;
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

  If Not Result Then
    pSetFocus(Sender);
end;


procedure TfrmCadBzaNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('NFM_MONTAD');
  stlCampos.Add('NFM_A_N_O_');
  stlCampos.Add('NFM_CODUNI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_DESCRI');
  stlCamInd.Add('NFM_MONTAD');
  stlCamInd.Add('NFM_A_N_O_');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Montadora');
  stlDesInd.Add('Ano');
end;

procedure TfrmCadBzaNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'BZA_CADNFM';
  strNomeCampo  := 'NFM_CODNFM';
  qryTabela     := frmModuloTinta.qryBza_CadNfm;

  dtsBzaCadNfm.DataSet := frmModuloTinta.qryBza_CadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodNfm;

end;

procedure TfrmCadBzaNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;

  frmModuloTinta.qryBza_CadNfm.FieldByName('NFM_DTACAD').AsDateTime := Date;

  If qryTabela.State = dsInsert Then
  Begin
      dbeCodNfm.Enabled := False;
      pSetFocus(dbeTipo);
  End;
end;

procedure TfrmCadBzaNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conBza, Nil, qryTabela, key, arrSel) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadBzaNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodNfm.Enabled := False;

  If (dbeDescri.Enabled) Then
    pSetFocus(dbeDescri);
end;

procedure TfrmCadBzaNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin
  conf      := fGetConfTinta('BZA');
  qryTabela := frmModuloTinta.qryBza_CadNfm;
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('NFMBZA'); //fArqIniTinta(0, 'Brasimix Automotiva', 'NFMBZA', '0');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + VS_strCodEmp + fStrZero(strNfmBri, 5);
  End;

  fStartTransaction;
  inherited;

  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If fGravaNovaFormula(qryTabela) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NFMBZA', fStrZero(StrToInt(strNfmBri) + 1, 5)); //fArqIniTinta(1, 'Brasimix Automotiva', 'NFMBZA', fStrZero(StrToInt(strNfmBri) + 1, 5));
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

procedure TfrmCadBzaNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strBzaCod : String;
begin
  strBzaCod := qryTabela.FieldByName('NFM_CODNFM').AsString;
  inherited;
  If (blnExcluiu) Then
  Begin
    If fApagaCadBzaNfm(strBzaCod) Then
    begin
      blnExcluiu := False;
    end;
  End;
end;

procedure TfrmCadBzaNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqBaseTinta(Self, conBZA, TEdit(Sender), nil, nil, key, arrSel) Then
    If fValidaCampos(TEdit(Sender), True) Then
      SelectNext(ActiveControl, True, True);
End;

procedure TfrmCadBzaNovasFormulas.dbeTipoKeyPress(Sender: TObject;var Key: Char);
begin
  inherited;
  if Key = #13 then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadBzaNovasFormulas.dtsBzaCadNfmStateChange(Sender: TObject);
begin
  inherited;
  dbeTipo.Enabled := (dtsBzaCadNfm.State in [DsInsert, DsEdit]);
end;

initialization
  RegisterClass(TfrmCadBzaNovasFormulas);
finalization
  UnRegisterClass(TfrmCadBzaNovasFormulas);

end.

