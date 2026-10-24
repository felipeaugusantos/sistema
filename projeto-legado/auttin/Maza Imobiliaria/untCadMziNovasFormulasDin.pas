unit untCadMziNovasFormulasDin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,Uni,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, ComboBoxFocus;

type
  TfrmCadMziNovasFormulasDin = class(TfrmPaiCad)
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
    Label2: TLabel;
    dbeBase: TDBEditFocus;
    Label6: TLabel;
    dbeUnidad: TDBEditFocus;
    Label27: TLabel;
    dbeDescProd: TComboBoxFocus;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    dbeForm11: TDBEditFocus;
    dbeQtdC11: TDBEditFocus;
    dbeForm12: TDBEditFocus;
    dbeQtdC12: TDBEditFocus;
    dbeForm13: TDBEditFocus;
    dbeQtdC13: TDBEditFocus;
    dbeForm14: TDBEditFocus;
    dbeQtdC14: TDBEditFocus;
    dbeForm15: TDBEditFocus;
    dbeQtdC15: TDBEditFocus;
    dbeForm16: TDBEditFocus;
    dbeQtdC16: TDBEditFocus;
    dbeForm17: TDBEditFocus;
    dbeQtdC17: TDBEditFocus;
    dbeForm18: TDBEditFocus;
    dbeQtdC18: TDBEditFocus;
    dbeForm19: TDBEditFocus;
    dbeQtdC19: TDBEditFocus;
    dbeForm20: TDBEditFocus;
    dbeQtdC20: TDBEditFocus;
    dbeDtaCad: TDBEditFocus;
    Label55: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodProKeyPress(Sender: TObject; var Key: Char);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    dtsCadNfm: TDataSource;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;

    procedure pCarregaProdutoDesc(strProduto: string = ''; strCodBas: String = '');

  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fBaseCadastrada(strCodBase : String; strCodUni : String): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pLigarDataSets;
    function VerificarNovaFormulaMovimentada: Boolean;
  public
    { Public declarations }
  end;

var
  frmCadMziNovasFormulasDin: TfrmCadMziNovasFormulasDin;

implementation

uses
  untModuloTinta, untIConfTinta, untFuncTinta, untPai,
  untFuncoesSimples, untMazaImobiliariaDinamica, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadMziNovasForumulas }

function TfrmCadMziNovasFormulasDin.fBaseCadastrada(strCodBase : String; strCodUni : String): Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
  conf: IConfTinta;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      conf := fGetConfTinta('MZI');
      strSQL := '';
      strSQL := strSQL + 'SELECT * ';
      strSQL := strSQL + '  FROM MZI_CADBAS ';
      strSQL := strSQL + ' WHERE BAS_CODBAS = :BAS_CODBAS';
      strSQL := strSQL + '   AND BAS_CODUNI = :BAS_CODUNI';

      qryGen := fCriaQuery(Self);

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('BAS_CODBAS').AsString  := strCodBase;
        ParamByName('BAS_CODUNI').AsString  := strCodUni;

        Open;
        Result := (Not IsEmpty);
        Close;
      End;
    Except
      on E: Exception do
      begin
        fMensagem('ATENÇÃO!', e.message, ['&Ok']);
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function TfrmCadMziNovasFormulasDin.fJaExisteEssaBaseNaFormulacao(
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

function TfrmCadMziNovasFormulasDin.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumCol: String;
begin

  Result := True;

  If (Sender = dbeBase) or (Sender = dbeDescProd) Then
  Begin
    If Not fBaseCadastrada(dbeBase.Text, dbeUnidad.Text ) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base não está cadastrada!', ['&Ok']);
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

  Else If (Sender = dbeForm01) Then
  Begin
    If (fEmptyStr(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos 1 colorante!', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaColorante(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse colorante não está cadastrado!', ['&Ok']);
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
          (Sender = dbeForm10) Or
          (Sender = dbeForm11) Or
          (Sender = dbeForm12) Or
          (Sender = dbeForm13) Or
          (Sender = dbeForm14) Or
          (Sender = dbeForm15) Or
          (Sender = dbeForm16) Or
          (Sender = dbeForm17) Or
          (Sender = dbeForm18) Or
          (Sender = dbeForm19) Or
          (Sender = dbeForm20) Then
  Begin
    If (fEmptyStr((TEdit(Sender).Text))) Then
    Begin
      pSetFocus(dbeQtdC20)
    End
    Else If (Not fValidaColorante(TEdit(Sender).Text)) Then
    Begin
      Result := False;
    End
    Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeQtdC01) Or
          (Sender = dbeQtdC02) Or
          (Sender = dbeQtdC03) Or
          (Sender = dbeQtdC04) Or
          (Sender = dbeQtdC05) Or
          (Sender = dbeQtdC06) Or
          (Sender = dbeQtdC07) Or
          (Sender = dbeQtdC08) Or
          (Sender = dbeQtdC09) Or
          (Sender = dbeQtdC10) Or
          (Sender = dbeQtdC11) Or
          (Sender = dbeQtdC12) Or
          (Sender = dbeQtdC13) Or
          (Sender = dbeQtdC14) Or
          (Sender = dbeQtdC15) Or
          (Sender = dbeQtdC16) Or
          (Sender = dbeQtdC17) Or
          (Sender = dbeQtdC18) Or
          (Sender = dbeQtdC19) Or
          (Sender = dbeQtdC20) Then
  Begin
    strNumCol := RightStr(Sender.Name, 2);
    If (Not fEmptyStr(TEdit(fComponentByName(gpbColorantes, 'dbeForm' + strNumCol)).Text)) Then
    Begin
      If (fEmptyStr(TEdit(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade do colorante!', ['&Ok']);
        Result := False;
      End;
      If (fStrToFloat(TEdit(Sender).Text)) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade do colorante deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;
    End;
  End
end;

function TfrmCadMziNovasFormulasDin.fValidaColorante(
  strCodCol: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MZI_CADCOL ';
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

procedure TfrmCadMziNovasFormulasDin.pCarregaProdutoDesc(strProduto : string = ''; strCodBas: String = '');
var
  qryMzi : TUniQuery;
  intIdx : Integer;
  intPos : Integer;
begin
  qryMzi := fCriaQuery(Self);

  intIdx := 0;
  intPos := -1;

  try
    qryMzi.SQl.Clear;
    qryMzi.Close;
    qryMzi.SQL.Text := ' SELECT DISTINCT (BAS_PRODUT) AS PRODUTO ' +
                       '   FROM MZI_CADBAS     ';

    If (Not fEmptyStr(strCodBas)) Then
    Begin
      qryMzi.SQL.Text := qryMzi.SQL.Text + '  WHERE BAS_CODBAS = :CODBAS ';

      qryMzi.ParamByName('CODBAS').AsString := strCodBas;
    End;

    qryMzi.Open;

    dbeDescProd.Clear;

    qryMzi.First;

    while not (qryMzi.Eof) do
    begin
      if (strProduto <> '' ) then
      begin
        if (qryMzi.Fields[0].AsString = strProduto) then
          intPos := intIdx;
      end;

      dbeDescProd.Items.Add(qryMzi.Fields[0].AsString);

      intIdx := intIdx + 1;
      qryMzi.Next;
    end;

    dbeDescProd.ItemIndex := intPos;

  finally
    pFreeAndNil(qryMzi);
  end;

end;

procedure TfrmCadMziNovasFormulasDin.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_PRODUT');
  stlCampos.Add('NFM_CODBAS');
  stlCampos.Add('NFM_CODUNI');
  stlCampos.Add('NFM_COLNAM');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_COLNAM');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadMziNovasFormulasDin.pLigarDataSets;
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

function TfrmCadMziNovasFormulasDin.VerificarNovaFormulaMovimentada: Boolean;
var
  strChave: string;
begin
  Result := True;
  Try
    Try
      strChave := ' CONCAT(IFNULL(MZI_CODMZI, ""),   ' +
                  ' IFNULL(MZI_CODEMP, ""), ' +
                  ' IFNULL(MZI_CODUNI, ""), ' +
                  ' IFNULL(MZI_PRODUT, ""), ' +
                  ' IFNULL(MZI_COLNUM, ""), ' +
                  ' IFNULL(MZI_CODBAS, "")) ';

      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD '+
                                                 '  FROM %0:s '+
                                                 ' INNER JOIN MZI_CADMZI ON %1:s_ITETIN = ' + strChave + '' +
                                                 ' WHERE MZI_CODMZI = :CODNFM',
        [qryTabela.FieldByName('NFM_CODNFM').AsString]);
    Except
      on E: Exception do
      begin
        fMensagem('ATENÇÃO!', e.message, ['&Ok']);
      end;
    End;
  Finally
  End;
end;

procedure TfrmCadMziNovasFormulasDin.FormCreate(Sender: TObject);
begin
  inherited;

  dtsCadNfm := fCriaDataSource(frmModuloTinta.qryMzi_CadNfm);
  pLigarDataSets;

  strNomeTabela := 'MZI_CADNFM';
  strNomeCampo  := 'NFM_CODNFM';
  qryTabela     := frmModuloTinta.qryMzi_CadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodNfm;
end;

procedure TfrmCadMziNovasFormulasDin.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo   := False;
  dbeCodNfm.Enabled := False;
  dbeDtaCad.Field.AsDateTime := Date;
  pSetFocus(dbeBase);

  dbeDescProd.ItemIndex := -1;
  dbeDescProd.Enabled   := True;
end;

procedure TfrmCadMziNovasFormulasDin.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conMzi, Nil, qryTabela, key, arrSel) Then
  Begin
    pSetFocus(btnAlterar);
    pCarregaProdutoDesc(qryTabela.FieldByName('NFM_PRODUT').AsString, qryTabela.FieldByName('NFM_CODBAS').AsString);
    dbeDescProd.Enabled := False;
  End;
end;

procedure TfrmCadMziNovasFormulasDin.btnAlterarClick(Sender: TObject);
begin
  if VerificarNovaFormulaMovimentada then
  begin
    fMensagem('ATENÇÃO', 'Já existe movimentação para essa fórmula, por isso não é possivel alterá-la', ['&OK']);
    Exit;
  end;

  inherited;
  dbeCodNfm.Enabled   := False;
  dbeBase.Enabled     := False;
  dbeDescProd.Enabled := False;

  If (dbeDescri.Enabled) Then
    pSetFocus(dbeDescri);
end;

procedure TfrmCadMziNovasFormulasDin.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf     : iConfTinta;
begin
  conf      := fGetConfTinta('MZI');

  blnInsert := (qryTabela.State = dsInsert);


  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('NFMMZI'); //fArqIniTinta(0, 'MazaImobiliaria', 'NFMMzi', '0');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + VS_strCodEmp  + fStrZero(strNfmBri, 5);
  End;

  qryTabela.FieldByName('NFM_COLNUM').AsString := qryTabela.FieldByName('NFM_CODNFM').AsString;
  qryTabela.FieldByName('NFM_PRODUT').AsString := dbeDescProd.Text;

  fStartTransaction;
  inherited;

  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If (TMazaImobiliariaDinamica.fGravaNovaFormula(qryTabela)) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NFMMZI', fStrZero(StrToInt(strNfmBri) + 1, 5)); //fArqIniTinta(1, 'MazaImobiliaria', 'NFMMzi', fStrZero(StrToInt(strNfmBri) + 1, 5));
        End;

        fCommit;
      End
      Else
        fRollBack;

      dbeDescProd.Enabled := False;
      Screen.Cursor := crDefault;
      blnGravou     := False;
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

procedure TfrmCadMziNovasFormulasDin.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dbeDescProd.ItemIndex := -1;
  dbeDescProd.Enabled := False;
end;

procedure TfrmCadMziNovasFormulasDin.btnExcluirClick(Sender: TObject);
  Var
    strCodNfm: String;
begin
  strCodNfm := dbeCodNfm.Text;
  fStartTransaction;
  inherited;
  Try
    If (blnExcluiu) Then
    Begin
      pDeletaNovaFormulaDinamica(strCodNfm);
      fCommit;

      dbeDescProd.ItemIndex := -1;
      dbeDescProd.Enabled   := False;
      blnExcluiu            := False;
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

procedure TfrmCadMziNovasFormulasDin.dbeCodProKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  Try
    If fPesqBaseTinta(Self, conMzi, Nil, Nil, qryAux, key, arrSel) Then
    Begin
      qryTabela.FieldByName('NFM_CODBAS').AsString := qryAux.FieldByName('BAS_CODBAS').AsString;
      qryTabela.FieldByName('NFM_CODUNI').AsString := qryAux.FieldByName('BAS_CODUNI').AsString;
      pCarregaProdutoDesc(qryAux.FieldByName('BAS_PRODUT').AsString, qryAux.FieldByName('BAS_CODBAS').AsString);
      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmCadMziNovasFormulasDin.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    qryConsulta: TUniQuery;
    arrSel: TConsultasArray;
begin
  qryConsulta := fCriaQuery;
  Try
    If fPesqColorantes(Self, conMzi, TEdit(Sender), Nil, qryConsulta, key, arrSel) Then
    Begin
      TEdit(Sender).Text := qryConsulta.FieldByName('COL_CODCOL').AsString;
      If fValidaCampos(TEdit(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(stlCamInd);
  End;
end;

initialization
  RegisterClass(TfrmCadMziNovasFormulasDin);
finalization
  UnRegisterClass(TfrmCadMziNovasFormulasDin);

end.

