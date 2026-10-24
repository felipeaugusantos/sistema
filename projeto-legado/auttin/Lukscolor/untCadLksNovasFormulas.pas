unit untCadLksNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, Uni, AppEvnts,
  BitBtnLockedIncrem;

type
  TfrmCadLksNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbeCodigo: TDBEditFocus;
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
    dbeCodBas: TDBEditFocus;
    Label6: TLabel;
    dbeUnidad: TDBEditFocus;
    Label2: TLabel;
    dbeCodPro: TDBEditFocus;
    Label27: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fBaseCadastrada(strBase: String; strCodPro: String = ''): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadLksNovasFormulas: TfrmCadLksNovasFormulas;

implementation

uses
  untModuloTinta, untPai, untConstantes, untLukscolor,
  untFuncoesSimples, untIConfTinta, untFuncTinta;

{$R *.dfm}

{ TfrmCadLksNovasForumulas }

function TfrmCadLksNovasFormulas.fBaseCadastrada(strBase: String; strCodPro: String = ''): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BAS_DESCRI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LKS_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_CODBAS = :BASE ';
  If (Not fEmptyStr(strCodPro)) Then
    strSQL := strSQL + '  AND BAS_CODPRO = :CODPRO ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('BASE').AsString  := strBase;
    If (Not fEmptyStr(strCodPro)) Then
      ParamByName('CODPRO').AsString  := strCodPro;

    Open;
    Result := (Not IsEmpty);
    If (fEmptyStr(dbeDescri.Field.AsString)) And
       (Not fEmptyStr(strCodPro))            And
       (qryTabela.State <> dsBrowse)         Then
    Begin
      dbeDescri.Field.AsString := FieldByName('BAS_DESCRI').AsString;
    End;
    Close;
  End;
end;

function TfrmCadLksNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumCol: String;
begin

  Result := True;

  If (Sender = dbeCodigo) Then
  Begin
  End

  Else If (Sender = dbeCodBas) Then
  Begin
    If (fEmptyStr(dbeCodBas.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeCodBas.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeCodPro) Then
  Begin
    If (fEmptyStr(dbeCodPro.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeCodBas.Text, dbeCodPro.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End

  {*****************************************}
  {* VALIDA A UNIDADE                      *}
  {**************************************MV*}
  Else If (Sender = dbeUnidad) Then
  Begin

    If (fEmptyStr(dbeUnidad.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&O k']);
      Result := False;
    End
    Else If (Pos(dbeUnidad.Text, UNIDADES_BASE) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa não é uma unidade válida (' + AnsiReplaceStr(UNIDADES_BASE, '_', ' ') + ')', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      If fEmptyStr(fRetNomUnidade(dbeUnidad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa unidade não está cadastrada!', ['&O k']);
        Result := False;
      End;
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

  Else If (Sender = dbeForm01) Then
  Begin
    If (fEmptyStr(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos 1 colorante!', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaColorante(dbeForm01.Text)) Then
    Begin
      Result := False;
    End;
  End

  Else If (Sender = dbeForm02) Or
          (Sender = dbeForm03) Or
          (Sender = dbeForm04) Or
          (Sender = dbeForm05) Or
          (Sender = dbeForm06) Or
          (Sender = dbeForm07) Or
          (Sender = dbeForm08) Or
          (Sender = dbeForm09) Or
          (Sender = dbeForm10) Then
  Begin
    If (fEmptyStr((TEdit(Sender).Text))) Then
    Begin
      pSetFocus(dbeQtdC10)
    End
    Else If (Not fValidaColorante(TEdit(Sender).Text)) Then
    Begin
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
    If (Not fEmptyStr(TEdit(fComponentByName(gpbColorantes, 'dbeForm' + strNumCol)).Text)) Then
    Begin
      If (fEmptyStr(TEdit(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade do colorante!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(TEdit(Sender).Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade deve ser maior que zero!', ['&Ok']);
        Result := False;
      End;
    End;
  End
end;

function TfrmCadLksNovasFormulas.fValidaColorante(
  strCodCol: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LKS_CADCOL ';
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

procedure TfrmCadLksNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODIGO');
  stlCampos.Add('NFM_CODBAS');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODIGO');
  stlCamInd.Add('NFM_DESCRI');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadLksNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'LKS_CADNFM';
  strNomeCampo  := 'NFM_CODIGO';
  qryTabela     := frmModuloTinta.qryLks_CadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

end;

procedure TfrmCadLksNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  frmModuloTinta.qryLks_CadNfm.FieldByName('NFM_UNIDAD').AsString := 'LT';

  dbeCodigo.Enabled := False;
  pSetFocus(dbeCodBas);
end;

procedure TfrmCadLksNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodigo.Enabled := False;
  If (dbeCodBas.Enabled) Then
    pSetFocus(dbeCodBas);
end;

procedure TfrmCadLksNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin
  blnInsert := (qryTabela.State = dsInsert);
  conf := fGetConfTinta('LKS');
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('NFMLKS');
    qryTabela.FieldByName('NFM_CODIGO').AsString := 'ESP ' + fStrZero(strNfmBri, 5);
  End;
  inherited;
  If (blnGravou) Then
  Begin
    Screen.Cursor := crHourGlass;
    If (fGeraNovasFormulas(qryTabela)) Then
    Begin
      If (blnInsert) Then
      Begin
        conf.pSetInteger('NFMLKS', StrToInt(strNfmBri) + 1);
      End;
    End;
    fFecharTabela(frmModuloTinta.qryLks_CadLks);
    Screen.Cursor := crDefault;
    blnGravou := False;
  End;
end;

procedure TfrmCadLksNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strRefere: String;
begin
  strRefere := qryTabela.FieldByName('NFM_CODIGO').AsString;

  inherited;

  If (blnExcluiu) Then
  Begin
    pDeletaNovaFormula(strRefere);
    blnExcluiu := False;
  End;

end;

procedure TfrmCadLksNovasFormulas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  fBaseCadastrada(dbeCodBas.Text);
end;

initialization
  RegisterClass(TfrmCadLksNovasFormulas);
finalization
  UnRegisterClass(TfrmCadLksNovasFormulas);

end.

