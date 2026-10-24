unit untCadAutNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Uni, DBEditFocus, Mask, DBCtrls, EditFocus, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadAutNfm = class(TfrmPaiCad)
    Panel1: TPanel;
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
    Label5: TLabel;
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
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    edtDesMon: TEditFocus;
    pnlCabecalho: TPanel;
    edtCodNfm: TDBEditFocus;
    edtDescri: TDBEditFocus;
    edtAnoIni: TDBEditFocus;
    edtCodMon: TDBEditFocus;
    edtMixSch: TDBEditFocus;
    edtRefere: TDBEditFocus;
    edtVarian: TDBEditFocus;
    edtAnoFin: TDBEditFocus;
    edtLinha: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure edtMixSchKeyPress(Sender: TObject; var Key: Char);
    function fCriarQuery(strTabela: String; AOwner: TComponent): TUniQuery;
    procedure edtLinhaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMonKeyPress(Sender: TObject; var Key: Char);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMonExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadNfm : TUniQuery;
    dtsCadNfm : TDataSource;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fRetMontadora(strcodMon: String): String;
    function fValidaBase(strBase: String): Boolean;
    function fValidaMontadora(strCodMon: String): Boolean;
    function fValidaGenerico(strNomeCampo, strNomeTabela: String; strValor: String): Boolean;
    function fValidaLinha(strSistema, strlinha: String): Boolean;
   public
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    { Public declarations }
  end;

var
  frmCadAutNfm: TfrmCadAutNfm;

implementation

uses untFuncoesSimples, untFuncTinta,
     untIConfTinta, StrUtils, untAutocolorDinamica;



{$R *.dfm}

procedure TfrmCadAutNfm.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  strNomeTabela := 'AUT_CADNFM';
  strNomeCampo  := 'NFM_CODNFM';
  qryTabela     := qryCadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := edtCodNfm;

end;

function TfrmCadAutNfm.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtDescri) Then
    Begin
      If fEmptyStr(edtDescri.Text) Then
      Begin
        fMensagem('', 'Entre com uma descrição', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodMon) Then
    Begin
      If Not fEmptyStr(edtCodMon.Text) and (Not fValidaMontadora(edtCodMon.Text)) Then
      Begin
        fMensagem('', 'Montadora inválida!', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtMixSch) Then
    Begin
      If Not fEmptyStr(edtMixSch.Text)
        and (Not fValidaGenerico('AUT_CODSIS', 'AUT_CADSIS', edtMixSch.Text)) Then
      Begin
        fMensagem('', 'Sistema inválido!', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtLinha) Then
    Begin
      If Not (fEmptyStr(edtMixSch.Text)) and (fEmptyStr(edtLinha.Text)) Then
      Begin
        fMensagem('', 'Entre com uma linha!', ['OK']);
        Result := False;
      End

      Else If Not fEmptyStr(edtLinha.Text) Then
      Begin
        If Not fValidaLinha(edtMixSch.Text, edtLinha.Text) Then
        Begin
          fMensagem('', 'Linha inválida!', ['OK']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = dbeForm01) and (fEmptyStr(dbeForm01.Text)) Then
    Begin
      fMensagem('', 'É necessário digitar pelo menos 1 base!', ['OK']);
      Result := False;
    End

    Else If (Not fEmptyStr(TDBEditFocus(Sender).Text)) and (Sender is TDBEditFocus)
          and (LeftStr(Sender.Name, 7) = 'dbeForm') Then
    Begin
      If Not fValidaBase(TDBEditFocus(Sender).Text) Then
      Begin
        fMensagem('', 'Base inválida!', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender is TDBEditFocus) and (LeftStr(Sender.Name, 7) = 'dbeQtdC')
      and (Not fEmptyStr(TDBEditFocus(FindComponent('dbeForm' + RightStr(Sender.Name, 2))).Text))
      and (fEmptyStr(TDBEditFocus(Sender).Text)) Then
    Begin
        fMensagem('', 'Entre com uma quantidade!', ['OK']);
        Result := False;
    End


  end;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadAutNfm.pCriaDataSets;
  Var
    intCont : Integer;
begin
  qryCadNfm := fCriaQuery(Self);

  qryCadNfm.Close;
  qryCadNfm.SQL.Text := 'SELECT * FROM AUT_CADNFM WHERE FALSE;';
  qryCadNfm.Open;
  qryCadNfm.Close;
  dtsCadNfm := fCriaDataSource(qryCadNfm);

  For intCont := 0 To qryCadNfm.FieldDefs.Count - 1 Do
  Begin
    qryCadNfm.FieldDefs[intCont].CreateField(qryCadNfm);
  End;

  qryCadNfm.FieldByName('NFM_CODNFM').DisplayLabel := 'Código';
  qryCadNfm.FieldByName('NFM_DESCRI').DisplayLabel := 'Descrição';
  qryCadNfm.FieldByName('NFM_MONTAD').DisplayLabel := 'Montadora';
  qryCadNfm.FieldByName('NFM_ANOINI').DisplayLabel := 'Ano Inicial';
  qryCadNfm.FieldByName('NFM_ANOFIN').DisplayLabel := 'Ano Final';
  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

end;

procedure TfrmCadAutNfm.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODNFM');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('NFM_MONTAD');
  stlCampos.Add('NFM_ANOINI');
  stlCampos.Add('NFM_ANOFIN');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODNFM');
  stlCamInd.Add('NFM_DESCRI');
  stlCamInd.Add('NFM_MONTAD');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Montadora');
end;

procedure TfrmCadAutNfm.pLigaDataSets;
  var
    intCont : Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
      TDBEdit(Components[intCont]).DataSource := dtsCadNfm;
  End;

  edtCodNfm.DataField := 'NFM_CODNFM';
  edtDescri.DataField := 'NFM_DESCRI';
  edtRefere.DataField := 'NFM_REFERE';
  edtCodMon.DataField := 'NFM_MONTAD';
  edtVarian.DataField := 'NFM_VARIAN';
  edtAnoIni.DataField := 'NFM_ANOINI';
  edtAnoFin.DataField := 'NFM_ANOFIN';
  edtMixSch.DataField := 'NFM_MIXSCH';
  edtLinha.DataField  := 'NFM_LINHA_';

  For intCont := 1 To 10 Do
  Begin
    TDBEdit(FindComponent('dbeForm' + fStrZero(intCont, 2))).DataField := 'NFM_CODB' + fStrZero(intCont, 2);
    TDBEdit(FindComponent('dbeQtdC' + fStrZero(intCont, 2))).DataField := 'NFM_QTDC' + fStrZero(intCont, 2);
  End;
end;

procedure TfrmCadAutNfm.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('AUT');
  qryTabela     := qryCadNfm;
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('NFMAUT'); //fArqIniTinta(0, 'Autocolor', 'NFMAUT', '0');
    qryTabela.FieldByName('NFM_CODNFM').AsString := 'ESP ' + fStrZero(strNfmBri, 5);
  End;
  fStartTransaction;
  inherited;

  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If fGravaCadNfm(qryCadNfm) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NFMAUT', fStrZero(StrToInt(strNfmBri) + 1, 5)); //fArqIniTinta(1, 'AUTOCOLOR', 'NFMAUT', fStrZero(StrToInt(strNfmBri) + 1, 5));
        End;
        fCommit;
      End
      Else
        fRollBack;
      Screen.Cursor := crDefault;
      blnGravou := False;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadAutNfm.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  edtCodNfm.Enabled := False;
  pSetFocus(edtMixSch);
end;

procedure TfrmCadAutNfm.edtMixSchKeyPress(Sender: TObject; var Key: Char);
  Var
    stlIndice: TStringList;
    stlDescricao: TStringList;
    stlIndCampos: TStringList;
    strSQL: String;
    qryCadSis : TUniQuery;
begin

  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    qryCadSis := fCriaQuery(Self);
    stlIndice := TStringList.Create;
    stlDescricao := TStringList.Create;
    stlIndCampos := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + ' 	AUT_CODSIS AS "Sistema", AUTOINCREM ';
    strSQL := strSQL + ' FROM  ';
    strSQL := strSQL + ' 	AUT_CADSIS ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + ' 	AUT_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
    strSQL := strSQL + ' GROUP BY ';
    strSQL := strSQL + ' 	AUT_CODSIS ';

    stlIndice.Add('AUT_CODSIS');
    stlDescricao.Add('Sistema');
    stlIndCampos.Add('AUT_CODSIS');

    utcRegistros.Limpar(Self.Name + 'AUT_CADSIS');
    If pConsultaComp(Self, qryCadSis, 'AUT_CADSIS', strSQL, stlIndice, stlDescricao) Then
    Begin
      edtMixSch.Text := qryCadSis.FieldByName('AUT_CODSIS').AsString;
    End;

    FreeAndNil(stlIndice);
    FreeAndNil(stlDescricao);
    FreeAndNil(qryCadSis);
  End;
end;

function TfrmCadAutNfm.fCriarQuery(strTabela: String;
  AOwner: TComponent): TUniQuery;
  Var
    intCont : Integer;
begin
  {******************************************************************}
  {* CRIA UMA TUniQuery E DEIXA OS CAMPOS FIXOS, ISSO EVITA QUE       *}
  {* QUANDO SE USA O METODO CLOSE, PERCA AS PROPRIEDADES DOS CAMPOS *}
  {***************************************************************PH*}

  Result := fCriaQuery(AOwner);
  Result.SQL.Text := 'SELECT * FROM ' + strTabela + ' WHERE FALSE;';
  Result.Open;
  Result.Close;

  For intCont := 0 To Result.FieldDefs.Count - 1 Do
  Begin
    Result.FieldDefs[intCont].CreateField(Result);
  End;
end;

procedure TfrmCadAutNfm.edtLinhaKeyPress(Sender: TObject; var Key: Char);
  Var
    stlIndice: TStringList;
    stlDescricao: TStringList;
    strSQL: String;
    qryCadMat : TUniQuery;
begin

  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    qryCadMat := fCriaQuery(Self);
    stlIndice := TStringList.Create;
    stlDescricao := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + ' 	CONCAT(AUT_CODMAT, " ", AUT_TIPO__) AS "Linha", ';
    strSQL := strSQL + ' 	AUTOINCREM ';
    strSQL := strSQL + ' FROM  ';
    strSQL := strSQL + ' 	AUT_CADSIS ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + ' 	AUT_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
    strSQL := strSQL + ' 	AND AUT_CODSIS = "' + edtMixSch.Text + '" ';

    stlIndice.Add('Linha');

    stlDescricao.Add('Linha');
    utcRegistros.Limpar(Self.Name + 'AUT_CADSIS');
    If pConsultaComp(Self, qryCadMat, 'AUT_CADSIS', strSQL, stlIndice, stlDescricao) Then
    Begin
      edtLinha.Text := qryCadMat.FieldByName('AUT_CODMAT').AsString + ' ' + qryCadMat.FieldByName('AUT_TIPO__').AsString;
    End;

    FreeAndNil(stlIndice);
    FreeAndNil(stlDescricao);
    FreeAndNil(qryCadMat);
  End;
end;

procedure TfrmCadAutNfm.edtCodMonKeyPress(Sender: TObject; var Key: Char);
  Var
    stlIndice: TStringList;
    stlDescricao: TStringList;
    stlIndCampos: TStringList;
    strSQL: String;
    qryCadMon : TUniQuery;
begin

  If (fEntraCons(Key)) Then
  Begin
    Key := #0;
    qryCadMon := fCriaQuery(Self);
    stlIndice := TStringList.Create;
    stlDescricao := TStringList.Create;
    stlIndCampos := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + ' 	AUT_CODMON AS "Código", ';
    strSQL := strSQL + ' 	AUT_DESCRI AS "Descrição", ';
    strSQL := strSQL + ' 	AUT_LINHAS AS "Linhas", ';
    strSQL := strSQL + ' 	AUTOINCREM ';
    strSQL := strSQL + ' FROM  ';
    strSQL := strSQL + ' 	AUT_CADMON ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + ' 	AUT_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    stlIndice.Add('AUT_CODMON');
    stlIndice.Add('AUT_DESCRI');

    stlDescricao.Add('Código');
    stlDescricao.Add('Descrição');

    stlIndCampos.Add('AUT_CODMON');
    stlIndCampos.Add('AUT_DESCRI');

    utcRegistros.Limpar(Self.Name + 'AUT_CADMON');
    If pConsultaComp(Self, qryCadMon, 'AUT_CADMON', strSQL, stlIndice, stlDescricao) Then
    Begin
      edtCodMon.Text := qryCadMon.FieldByName('AUT_CODMON').AsString;
      edtDesMon.Text := qryCadMon.FieldByName('AUT_DESCRI').AsString;
    End;

    FreeAndNil(stlIndice);
    FreeAndNil(stlDescricao);
    FreeAndNil(qryCadMon);
  End;
end;

procedure TfrmCadAutNfm.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  var
    stlIndice: TStringList;
    stlDescricao: TStringList;
    stlIndCampos: TStringList;
    strSQL: String;
    qryCadBas : TUniQuery;
begin
  qryCadBas := nil;
  stlIndice := nil;
  stlDescricao := nil;
  Try
    Try
      If (Sender is TDBEdit) And (LeftStr(TDBEdit(Sender).Name, 7) = 'dbeForm') And (fEntraCons(Key)) Then
      Begin
        Key := #0;
        qryCadBas := fCriaQuery(Self);
        stlIndice := TStringList.Create;
        stlDescricao := TStringList.Create;
        stlIndCampos := TStringList.Create;

        strSQL := '';
        strSQL := strSQL + ' SELECT  ';
        strSQL := strSQL + ' 	BAS_CODBAS AS "Código", ';
        strSQL := strSQL + ' 	BAS_CODITE AS "Item", ';
        strSQL := strSQL + ' 	BAS_DESBAS AS "Base", ';
        strSQL := strSQL + ' 	BAS_PESPEC AS "Densidade", ';
        strSQL := strSQL + ' 	AUTOINCREM ';
        strSQL := strSQL + ' FROM  ';
        strSQL := strSQL + ' 	AUT_CADBAS ';
        strSQL := strSQL + ' WHERE TRUE ';
    //    strSQL := strSQL + ' 	BAS_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

        stlIndice.Add('BAS_CODBAS');
        stlIndice.Add('BAS_DESBAS');

        stlDescricao.Add('Código');
        stlDescricao.Add('Base');

        stlIndCampos.Add('BAS_CODBAS');
        stlIndCampos.Add('BAS_DESBAS');

        utcRegistros.Limpar(Self.Name + 'AUT_CADBAS');
        If pConsultaComp(Self, qryCadBas, 'AUT_CADBAS', strSQL, stlIndice, stlDescricao) Then
        Begin
          TDBEdit(Sender).Text := qryCadBas.FieldByName('BAS_CODBAS').AsString;
        End;
        SelectNext(ActiveControl, True, True);
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlIndice) then FreeAndNil(stlIndice);
    if Assigned(stlDescricao) then FreeAndNil(stlDescricao);
    if Assigned(qryCadBas) then FreeAndNil(qryCadBas);
  End;
end;

procedure TfrmCadAutNfm.edtCodMonExit(Sender: TObject);
begin
  inherited;
  edtDesMon.Text := fRetMontadora(edtCodMon.Text);
end;

function TfrmCadAutNfm.fRetMontadora(strcodMon: String): String;
  Var
    qryCadMon: TUniQuery;
begin
  qryCadMon := fCriaQuery(nil);
  qryCadMon.SQL.Text := 'SELECT AUT_DESCRI FROM AUT_CADMON WHERE AUT_CODMON = "' + strcodMon + '";';
  qryCadMon.Open;
  Result := qryCadMon.FieldByName('AUT_DESCRI').AsString;
  FreeAndNil(qryCadMon);
end;

procedure TfrmCadAutNfm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dtsCadNfm);
  FreeAndNil(qryCadNfm);
  inherited;
end;

function TfrmCadAutNfm.fValidaBase(strBase: String): Boolean;
  Var
    qryCadLin : TUniQuery;
begin
  qryCadLin := fCriaQuery;
  qryCadLin.SQL.Text := 'SELECT BAS_CODBAS FROM AUT_CADBAS WHERE BAS_CODBAS = "' + strBase + '"';
  qryCadLin.Open;
  Result := Not qryCadLin.IsEmpty;
  FreeAndNil(qryCadLin);
end;

function TfrmCadAutNfm.fValidaMontadora(strCodMon: String): Boolean;
  Var
    qryCadMon: TUniQuery;
begin
  qryCadMon := fCriaQuery(nil);
  qryCadMon.SQL.Text := 'SELECT AUT_CODMON FROM AUT_CADMON WHERE AUT_CODMON = "' + strcodMon + '";';
  qryCadMon.Open;
  Result := Not qryCadMon.IsEmpty;
  FreeAndNil(qryCadMon);
end;

function TfrmCadAutNfm.fValidaGenerico(strNomeCampo,
  strNomeTabela: String; strValor: String): Boolean;
  Var
    qryCadGen:  TUniQuery;
begin
  qryCadGen := fCriaQuery(nil);
  qryCadGen.SQL.Text := 'SELECT ' + strNomeCampo +
                        ' FROM ' + strNomeTabela +
                        ' WHERE ' + strNomeCampo + ' = "' + strValor + '"';
  qryCadGen.Open;
  Result := Not qryCadGen.IsEmpty;
  FreeAndNil(qryCadGen);
end;

function TfrmCadAutNfm.fValidaLinha(strSistema, strlinha: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(nil);
  qryGen.SQL.Clear;
  qryGen.SQL.Add('SELECT');
  qryGen.SQL.Add('	CONCAT(AUT_CODMAT, " ", AUT_TIPO__)');
  qryGen.SQL.Add('FROM ');
  qryGen.SQL.Add('	AUT_CADSIS');
  qryGen.SQL.Add('WHERE');
  qryGen.SQL.Add('	AUT_CODSIS = "' + strSistema + '"');
  qryGen.SQL.Add('	AND CONCAT(AUT_CODMAT, " ", AUT_TIPO__) = "' + strlinha + '"');
  qryGen.Open;
  Result := Not qryGen.IsEmpty;
  FreeAndNil(qryGen);
end;

procedure TfrmCadAutNfm.btnAlterarClick(Sender: TObject);
begin
  inherited;
  edtCodNfm.Enabled := False;
  pSetFocus(edtMixSch);
end;

procedure TfrmCadAutNfm.btnExcluirClick(Sender: TObject);
  Var
    strCodigo: String;
begin
  strCodigo := qryTabela.FieldByName('NFM_CODNFM').AsString;
  fStartTransaction;
  inherited;
  Try
    If blnExcluiu Then
    Begin
      pDeletaNovaFormula(strCodigo);
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
  RegisterClass(TfrmCadAutNfm);
finalization
  UnRegisterClass(TfrmCadAutNfm);

end.

