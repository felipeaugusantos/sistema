unit untCadZynNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadZynNovasFormulas = class(TfrmPaiCad)
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
    dbeVeicul: TDBEditFocus;
    Label6: TLabel;
    dbeAno: TDBEditFocus;
    dbeTipo: TDBEditFocus;
    Label27: TLabel;
    dbeLinha: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
  protected
    function fBaseCadastrada(strCodBas: String): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;

  public
    { Public declarations }
  end;

var
  frmCadZynNovasFormulas: TfrmCadZynNovasFormulas;

implementation

uses
    untIConfTinta, untFuncTinta, untPai,
    untFuncoesSimples, untZynamixDinamica;

{$R *.dfm}

{ TfrmCadZynNovasForumulas }

function TfrmCadZynNovasFormulas.fBaseCadastrada(strCodBas: String): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                       ' +
        '   BAS_CODBAS                 ' +
        ' FROM                         ' +
        '   ZYN_CADBAS                 ' +
        ' WHERE BAS_CODBAS = :CODBAS   ';
      qryGen.ParamByName('CODBAS').AsString  := strCodBas;
      qryGen.Open;
      Result := not qryGen.IsEmpty;
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

function TfrmCadZynNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumCol: String;
begin

  Result := True;

  If (Sender = dbeCodNfm) Then
  Begin
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
    Else If fEmptyStr(TEditFocus(Sender).Text) Then
      pSetFocus(dbeQtdC10);
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
  End;

  If Not Result Then
    pSetFocus(Sender);
end;


procedure TfrmCadZynNovasFormulas.pCriaDataSets;
var
  intCont: Integer;
begin
  qryCadNfm := fCriarQuery('SELECT * FROM ZYN_CADNFM', Self);

  qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  qryCadNfm.FieldbyName('NFM_DESCRI').DisplayLabel := 'Descrição';
  qryCadNfm.FieldbyName('NFM_VEICUL').DisplayLabel := 'Veículo';
  qryCadNfm.FieldbyName('NFM_A_N_O_').DisplayLabel := 'Ano';
  qryCadNfm.FieldbyName('NFM_TIPO__').DisplayLabel := 'Tipo';
  qryCadNfm.FieldbyName('NFM_LINHA_').DisplayLabel := 'Linha';

  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 10 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2))).DisplayFormat := '0.000';
  End;

  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;

procedure TfrmCadZynNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('NFM_VEICUL');
  stlCampos.Add('NFM_A_N_O_');
  stlCampos.Add('NFM_TIPO__');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_DESCRI');
  stlCamInd.Add('NFM_VEICUL');
  stlCamInd.Add('NFM_A_N_O_');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Veículo');
  stlDesInd.Add('Ano');
end;

procedure TfrmCadZynNovasFormulas.pLigaDataSets;
var
  intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadNfm;
    End;
  End;

  dbeCodNfm.DataField := 'NFM_CODNFM';
  dbeDescri.DataField := 'NFM_DESCRI';
  dbeLinha.DataField := 'NFM_LINHA_';
  dbeAno.DataField := 'NFM_A_N_O_';
  dbeVeicul.DataField := 'NFM_VEICUL';
  dbeTipo.DataField := 'NFM_TIPO__';
  
  For intCont := 1 To 10 Do
  Begin
    TDBEdit(FindComponent('dbeForm' + fStrZero(intCont, 2))).DataField := 'NFM_CODB' + fStrZero(intCont, 2);
    TDBEdit(FindComponent('dbeQtdC' + fStrZero(intCont, 2))).DataField := 'NFM_QTDB' + fStrZero(intCont, 2);
  End;
end;

procedure TfrmCadZynNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadNfm;
  strNomeTabela := 'ZYN_CADNFM';
  strNomeCampo := 'NFM_CODNFM';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodNfm;
end;

procedure TfrmCadZynNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  If qryTabela.State = dsInsert Then
  Begin
      dbeCodNfm.Enabled := False;
      pSetFocus(dbeTipo);
  End;
end;

procedure TfrmCadZynNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodNfm.Enabled := False;

  If (dbeDescri.Enabled) Then
    pSetFocus(dbeDescri);
end;

procedure TfrmCadZynNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin
  blnInsert := (qryTabela.State = dsInsert);
  conf          := fGetConfTinta('ZYN');
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('NFMZYN'); //fProximoCodigo;
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + fStrZero(strNfmBri, 5);
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
          conf.pSet('NFMZYN', fStrZero(StrToInt(strNfmBri) + 1, 5)); //fArqIniTinta(1, 'ZYNAMIX', 'NFMZYN', fStrZero(StrToInt(strNfmBri) + 1, 5));
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

procedure TfrmCadZynNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strZynCod : String;
begin
  strZynCod := qryTabela.FieldByName('NFM_CODNFM').AsString;
  fStartTransaction;
  inherited;
  Try
    If (blnExcluiu) Then
    Begin
      If fApagaCadZynNfm(strZynCod) Then
      begin
        blnExcluiu := False;
        fCommit;
      end
      Else
        fRollBack;
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

procedure TfrmCadZynNovasFormulas.dbeForm01KeyPress(Sender: TObject;
  var Key: Char);
  Var
    strSQL: String;
    stlCamInd: TStringList;
    stlDesInd: TStringList;
    qryConsulta: TUniQuery;
begin

  If (fEntraCons(Key)) Then
  Begin

    Key := #0;

    qryConsulta := fCriaQuery;
    stlCamInd := TStringList.Create;
    stlDesInd := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  BAS_CODBAS AS "Código", ';
    strSQL := strSQL + '  BAS_DESBAS AS "Descrição", ';
    strSQL := strSQL + '  AUTOINCREM AS "AUTOINCREM" ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ZYN_CADBAS ';

    stlCamInd.Add('BAS_CODBAS');
    stlCamInd.Add('BAS_DESBAS');

    stlDesInd.Add('Código');
    stlDesInd.Add('Descrição');

    If (pConsultaComp(Self, qryConsulta, 'ZYN_CADBAS', strSQL, stlCamInd, stlDesInd)) Then
    Begin
      TEdit(Sender).Text := qryConsulta.FieldByName('BAS_CODBAS').AsString;
      If fValidaCampos(TEdit(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(stlCamInd);
    FreeAndNil(stlDesInd);
    FreeAndNil(qryConsulta);

  End;

end;

initialization
  RegisterClass(TfrmCadZynNovasFormulas);
finalization
  UnRegisterClass(TfrmCadZynNovasFormulas);

end.

