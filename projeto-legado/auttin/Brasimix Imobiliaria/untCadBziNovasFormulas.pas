unit untCadBziNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, EditFocus, StrUtils, DB, AppEvnts, Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadBziNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label1: TLabel;
    dbeCodNfm: TDBEditFocus;
    Label2: TLabel;
    dbeLinha: TDBEditFocus;
    Label3: TLabel;
    dbeBase: TDBEditFocus;
    Label4: TLabel;
    dbeDescri: TDBEditFocus;
    Label6: TLabel;
    dbeUnidad: TDBEditFocus;
    gpbColorantes: TGroupBox;
    Label7: TLabel;
    dbeCodC01: TDBEditFocus;
    Label8: TLabel;
    dbeQtdC01: TDBEditFocus;
    Label9: TLabel;
    dbeCodC02: TDBEditFocus;
    Label10: TLabel;
    dbeQtdC02: TDBEditFocus;
    Label11: TLabel;
    dbeCodC03: TDBEditFocus;
    Label12: TLabel;
    dbeQtdC03: TDBEditFocus;
    Label13: TLabel;
    dbeCodC04: TDBEditFocus;
    Label14: TLabel;
    dbeQtdC04: TDBEditFocus;
    Label15: TLabel;
    dbeCodC05: TDBEditFocus;
    Label16: TLabel;
    dbeQtdC05: TDBEditFocus;
    Label17: TLabel;
    dbeCodC06: TDBEditFocus;
    Label18: TLabel;
    dbeQtdC06: TDBEditFocus;
    Label19: TLabel;
    dbeCodC07: TDBEditFocus;
    Label20: TLabel;
    dbeQtdC07: TDBEditFocus;
    Label21: TLabel;
    dbeCodC08: TDBEditFocus;
    Label22: TLabel;
    dbeQtdC08: TDBEditFocus;
    Label23: TLabel;
    dbeCodC09: TDBEditFocus;
    Label24: TLabel;
    dbeQtdC09: TDBEditFocus;
    Label25: TLabel;
    dbeCodC10: TDBEditFocus;
    Label26: TLabel;
    dbeQtdC10: TDBEditFocus;
    pnlCabecalho: TPanel;
    Label5: TLabel;
    dtsBziCadNfm: TDataSource;
    Label27: TLabel;
    dbeDtaCad: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeLinhaKeyPress(Sender: TObject; var Key: Char);
    procedure dbeLinhaExit(Sender: TObject);
    procedure dbeCodC01KeyPress(Sender: TObject; var Key: Char);
    procedure dbeBaseKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
  private
    { Private declarations }
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fBaseCadastrada(strLinha, strBase: String; strUnidad: String = ''): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadBziNovasFormulas: TfrmCadBziNovasFormulas;

implementation

uses untPai, untModuloTinta, untConstantes,
     untBrasimixImobiliaria,
     untFuncTinta, untIConfTinta, untFuncoesSimples, untNovaFormulaBrasimixImobiliaria, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmCadBziNovasFormulas }

function TfrmCadBziNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumCol: String;
begin

  Result := True;

  If (Sender = dbeCodNfm) Then
  Begin
  End

  Else If (Sender = dbeLinha) Then
  Begin

    If (fEmptyStr(dbeLinha.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A linha deve ser preenchida!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeBase) Then
  Begin
    If (fEmptyStr(dbeBase.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeLinha.Text, dbeBase.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeUnidad) Then
  Begin
    If (fEmptyStr(dbeUnidad.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Pos(dbeUnidad.Text, UNIDADES_BASE) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa não é uma unidade válida (' + AnsiReplaceStr(UNIDADES_BASE, '_', ' ') + ')', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeDescri) Then
  Begin
    If (fEmptyStr(dbeDescri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
    Result := False;
  End

  Else If (Sender = dbeCodC01) Then
  Begin
    If (fEmptyStr(dbeCodC01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos 1 colorante!', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaColorante(dbeCodC01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Colorante não encontrado!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeCodC02) Or
          (Sender = dbeCodC03) Or
          (Sender = dbeCodC04) Or
          (Sender = dbeCodC05) Or
          (Sender = dbeCodC06) Or
          (Sender = dbeCodC07) Or
          (Sender = dbeCodC08) Or
          (Sender = dbeCodC09) Or
          (Sender = dbeCodC10) Then
  Begin
    If (fEmptyStr((TEdit(Sender).Text))) Then
    Begin
      pSetFocus(dbeQtdC10)
    End
    Else If (Not fValidaColorante(TEdit(Sender).Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Colorante não encontrado!', ['&Ok']);    
      Result := False;
    End;
  End

  Else If (Sender = dbeQtdC01) Or
          (Sender = dbeQtdC02) Or
          (Sender = dbeQtdC02) Or
          (Sender = dbeQtdC03) Or
          (Sender = dbeQtdC04) Or
          (Sender = dbeQtdC05) Or
          (Sender = dbeQtdC06) Or
          (Sender = dbeQtdC07) Or
          (Sender = dbeQtdC08) Or
          (Sender = dbeQtdC09) Or
          (Sender = dbeQtdC10) Then
  Begin
    strNumCol := RightStr(Sender.Name, 2);
    If (Not fEmptyStr(TEdit(fComponentByName(gpbColorantes, 'dbeCodC' + strNumCol)).Text)) Then
    Begin
      If (fEmptyStr(TEdit(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade do colorante!', ['&Ok']);
        Result := False;
      End;
    End;
  End

end;

procedure TfrmCadBziNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'BZI_CADNFM';
  strNomeCampo  := 'NFM_CODIGO';
  qryTabela     := frmModuloTinta.qryBzi_CadNfm;

  dtsBziCadNfm.DataSet := frmModuloTinta.qryBzi_CadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodNfm;

end;

procedure TfrmCadBziNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  frmModuloTinta.qryBzi_CadNfm.FieldByName('NFM_UNIDAD').AsString := 'LT';
  frmModuloTinta.qryBzi_CadNfm.FieldByName('NFM_DTACAD').AsDateTime := Date;

  dbeCodNfm.Enabled := False;
  pSetFocus(dbeLinha);
end;

procedure TfrmCadBziNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    key: char;
begin
  key := '/';
  If fPesqFormulaTinta(self, conBzi, dbeCodNFM, qryTabela, Key, arrSel) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadBziNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodNfm.Enabled := False;
  dbeLinha.Enabled  := False;
  dbeBase.Enabled   := False;
  {If (dbeUnidad.Enabled) Then
    pSetFocus(dbeUnidad);}

  pSetFocus(dbeDescri);    
end;

procedure TfrmCadBziNovasFormulas.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODIGO');
  stlCampos.Add('NFM_LINHA_');
  stlCampos.Add('NFM_BASE__');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('NFM_UNIDAD');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODIGO');
  stlCamInd.Add('NFM_LINHA_');
  stlCamInd.Add('NFM_DESCRI');
  stlDesInd.Add('Código');
  stlDesInd.Add('Linha');
  stlDesInd.Add('Descrição');

end;

procedure TfrmCadBziNovasFormulas.btnGravarClick(Sender: TObject);
var
  strNfmBri: String;
  blnInsert: Boolean;
  conf: IConfTinta;
  novaFormula: TNovaFormulaBrasimixImobiliaria;
begin
  novaFormula := nil;
  Try
    Try
      conf  := fGetConfTinta('BZI');
      blnInsert := (qryTabela.State = dsInsert);
      If (blnInsert) Then
      Begin
        strNfmBri := conf.fGet('NFMBRI');
        qryTabela.FieldByName('NFM_CODIGO').AsString := 'ESP ' + VS_strCodEmp + fStrZero(strNfmBri, 5);
      End;
      fStartTransaction;
      inherited;
      If (blnGravou) Then
      Begin
        novaFormula := TNovaFormulaBrasimixImobiliaria.Create;
        If (novaFormula.GravarNovaFormula(qryTabela)) Then
        Begin
          If (blnInsert) Then
          Begin
            conf.pSet('NFMBRI', fStrZero(StrToInt(strNfmBri) + 1, 5)); //fArqIniTinta(1, 'Brasimix Imobiliaria', 'NFMBRI', fStrZero(StrToInt(strNfmBri) + 1, 5));
          End;
        End;
        fCommit;
        blnGravou := False;
      End
      Else
        fRollBack;
    Except
      on E: Exception do
      begin
        fRollBack;
        raise;
      end;
    End;
  Finally
    if Assigned(novaFormula) then FreeAndNil(novaFormula);
  End;

end;

function TfrmCadBziNovasFormulas.fValidaColorante(
  strCodCol: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BZI_CADCOL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COL_CODCOL = :CODCOL ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCOL').AsString := strCodCol;
    Open;
    Result := (FieldByName('QTD').AsInteger > 0);
    Close;
  End;

end;

function TfrmCadBziNovasFormulas.fBaseCadastrada(strLinha,
  strBase: String; strUnidad: String = ''): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BAS_DESCRI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BZI_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_LINHA_ = :LINHA AND ';
  strSQL := strSQL + '  BAS_BASE__ = :BASE ';

  If (Not fEmptyStr(strUnidad)) Then
    strSQL := strSQL + '  AND BAS_UNIDAD = :UNIDAD '; 

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('LINHA').AsString := strLinha;
    ParamByName('BASE').AsString  := strBase;

    If (Not fEmptyStr(strUnidad)) Then
      ParamByName('UNIDAD').AsString  := strUnidad;

    Open;
    Result := (Not IsEmpty);
    If (fEmptyStr(dbeDescri.Field.AsString)) Then
      dbeDescri.Field.AsString := FieldByName('BAS_DESCRI').AsString;
    Close;
  End;

end;

function TfrmCadBziNovasFormulas.fJaExisteEssaBaseNaFormulacao(
  strCodBas: String; dbeForm: TObject): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To 10 Do
  Begin
    If (RightStr(TDBEditFocus(dbeForm).Name, 2) <> fStrZero(intCont,2)) And
       (Not fEmptyStr(TDBEditFocus(FindComponent('dbeCodC' + fStrZero(intCont,2))).Text)) Then
    Begin
      If TDBEditFocus(FindComponent('dbeCodC' + fStrZero(intCont,2))).Text = strCodBas Then
        Result := True;
    End;
  End;

end;

procedure TfrmCadBziNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodigo: String;
begin

  strCodigo := qryTabela.FieldByName('NFM_CODIGO').AsString;

  fStartTransaction;
  inherited;

  Try
    If (blnExcluiu) Then
    Begin
      pDeletaNovaFormula(strCodigo);
      fCommit;
      blnExcluiu := False;
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

procedure TfrmCadBziNovasFormulas.dbeLinhaKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
    qryAux: TUniQuery;
begin
  inherited;
  qryAux := FCriaQuery;
  Try
    If fPesqBaseTinta(Self, conBzi, nil, nil, qryAux, Key,  arrSel) Then
    Begin
      TDBEditFocus(Sender).Text := qryAux.FieldByName('BAS_LINHA_').AsString;
      If (fValidaCampos(TDBEditFocus(Sender), True)) Then
        SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryAux);
  End
end;

procedure TfrmCadBziNovasFormulas.dbeLinhaExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(dbeLinha, True);
end;

procedure TfrmCadBziNovasFormulas.dbeBaseKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsuLtasArray;
begin
  inherited;
  If fPesqBaseTinta(Self, conBzi, TDBEditFocus(Sender), nil, nil, Key, arrSel) Then
    If (fValidaCampos(TDBEditFocus(Sender), True)) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadBziNovasFormulas.dbeCodC01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqColorantes(Self, conBzi, TEdit(Sender), nil, nil, Key, arrSel) Then
    If fValidaCampos(TEdit(Sender), True) Then
      SelectNext(ActiveControl, True, True);
end;

initialization
  RegisterClass(TfrmCadBziNovasFormulas);
finalization
  UnRegisterClass(TfrmCadBziNovasFormulas);

end.

