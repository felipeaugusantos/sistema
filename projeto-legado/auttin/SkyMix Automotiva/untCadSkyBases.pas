unit untCadSkyBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Uni, EditFocus, Mask, DBCtrls, DBEditFocus, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadSkyBases = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescricao: TDBEditFocus;
    Label3: TLabel;
    dbeDensidade: TDBEditFocus;
    Label4: TLabel;
    dbeEmbala: TDBEditFocus;
    Label6: TLabel;
    dbeCodIte: TDBEditFocus;
    dbeDesIte: TEditFocus;
    btnRestPreco: TSpeedButton;
    Label7: TLabel;
    dbePreCus: TDBEditFocus;
    Label8: TLabel;
    dbeMargem: TDBEditFocus;
    Label9: TLabel;
    dbePreVen: TDBEditFocus;
    Label5: TLabel;
    edtPorIcms: TDBEditFocus;
    Label10: TLabel;
    edtPorIpi: TDBEditFocus;
    pnlCabecalho: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    qryCadBas : TUniQuery;
    dtsCadBas : TDataSource;
    StrCodIteAnt : String;


    procedure pCriaDataSets;
    procedure pLigaDataSets;
    function fCarregaDesIte(strCodIte: String): String;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    function fRetPorcentagemIcms(strCodIte: String): Double;
    function fRetPorcentagemIpi(strCodIte: String): Double;
    procedure pAtualizaFatorTintometrico;
    procedure pHabilitaBtn;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadSkyBases: TfrmCadSkyBases;

implementation

uses untFuncoesSimples, untPai, untFuncTinta,
  untSkyMixAutomotivaDinamica, untConsultas, untTypesSistema,
  untValidarBaseItemAmarracao;

{$R *.dfm}

{ TfrmCadSkyBases }

function TfrmCadSkyBases.fCarregaDesIte(strCodIte: String): String;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = "' + strCodIte + '"';
  qryGen.Open;
  Result := qryGen.FieldByName('ITE_DESITE').AsString;
  If fEmptyStr(Result) Then
  Begin
    If dbeCodIte.Enabled Then
    Begin
      fMensagem('', 'Produto não encontrado!', ['OK']);
      pSetFocus(dbeCodIte);
    End;
  End;
  FreeAndNil(qryGen);
end;

function TfrmCadSkyBases.fRetPrecoVenda(intOpcao: Integer): Double;
begin
  If fEmptyStr(dbePreVen.Text) Then
    dbePreVen.Text := '0,00';

  If fEmptyStr(dbeMargem.Text) Then
    dbeMargem.Text := '0,00';

  Result := fCalculaPrecoVenda(intOpcao,
                               fStrToFloat(dbePreCus.Text),
                               fStrToFloat(dbePreVen.Text),
                               fStrToFloat(dbeMargem.Text),
                               0.0,
                               0.0,
                               0.0,
                               0.0);
end;

function TfrmCadSkyBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = dbeCodigo Then
    Begin
      If fEmptyStr(dbeCodigo.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O código não está preenchido!', ['OK']);
        Result := False;
      End;
    End;

    If (Sender = dbeDescricao) Then
    Begin
      If fEmptyStr(dbeDescricao.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida', ['OK']);
      End;
    end

    Else If (Sender = dbePreCus) Then
    Begin
      If (Not fEmptyStr(dbeCodIte.Text)) Then
      Begin
        If (fEmptyStr(dbePreCus.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de custo deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbePreCus.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de custo deve maior que Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
        End;
      End;
    End

    Else If (Sender = dbePreVen) Then
    Begin
      If (Not fEmptyStr(dbeCodIte.Text)) Then
      Begin
        If (fEmptyStr(dbePreVen.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de venda deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbePreVen.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de venda que Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbeMargem.Field.AsFloat := fRetPrecoVenda(2);
        End;
      End;
    End

    Else If (Sender = dbeMargem) Then
    Begin
      If (Not fEmptyStr(dbeCodIte.Text)) Then
      Begin
        If (fEmptyStr(dbeMargem.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A margem deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbeMargem.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A margem deve maior ou igual a Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
        End;
      End;
    End

    Else If Sender = dbeDensidade Then
    Begin
      If (fEmptyStr(dbeDensidade.Text) or (fStrToFloat(dbeDensidade.Text) <= 0)) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A densidade não está configurada corretamente', ['OK']);
      End;
    End

    Else If Sender = dbeEmbala Then
    Begin
      If (fEmptyStr(dbeEmbala.Text) or (fStrToFloat(dbeEmbala.Text) <= 0)) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A embalagem não está configurada corretamente', ['OK']);
      End;
    End

    Else If Sender = dbeCodIte Then
    Begin
      dbeDesIte.Text := fRetNomProduto(dbeCodIte.Text);
      If (Not fEmptyStr(dbeCodIte.Text)) And (fEmptyStr(dbeDesIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'O produto não está cadastrado', ['OK']);
        Result := False;
      End;
    End

    Else If Sender = edtPorIcms Then
    Begin
      If (Not fEmptyStr(dbeCodIte.Text)) Then
      Begin
        If fEmptyStr(edtPorIcms.Text) Then
        Begin
          fMensagem('ATANÇÃO', 'A porcentagem de icms da base não foi preenchida!', ['OK']);
          Result := False;
        End
        Else If fStrToFloat(edtPorIcms.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO', 'A porcentagem de icms deve ser maior ou igual que zero', ['OK']);
          Result := False;
        End;
      End;
    End

    Else If Sender = edtPorIpi Then
    Begin
      If (Not fEmptyStr(dbeCodIte.Text)) Then
      Begin
        If fEmptyStr(edtPorIpi.Text) Then
        Begin
          fMensagem('ATANÇÃO', 'A porcentagem de ipi da base não foi preenchida!', ['OK']);
          Result := False;
        End
        Else If fStrToFloat(edtPorIpi.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO', 'A porcentagem de ipi deve ser maior ou igual que zero', ['OK']);
          Result := False;
        End;
      End;
    End

  end;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadSkyBases.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' UPDATE                                                          ' +
        '   CADITE                                                        ' +
        '   INNER JOIN SKY_CADBAS                                         ' +
        '     ON BAS_CODITE = ITE_CODITE                                  ' +
        ' SET ITE_CNV_ML = IFNULL(BAS_PESESP, 1) * IFNULL(BAS_EMBALA , 1) ';
      qryGen.ExecSQL;
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

procedure TfrmCadSkyBases.pCriaDataSets;
begin
  qryCadBas := fCriaZQuery('SELECT * FROM SKY_CADBAS');
  qryCadBas.Open;

  qryCadBas.FieldByName('BAS_CODBAS').DisplayLabel := 'Código';
  qryCadBas.FieldByName('BAS_CODEMP').Visible := False;
  qryCadBas.FieldByName('BAS_CODITE').DisplayLabel := 'Item';
  qryCadBas.FieldByName('BAS_DESCRI').DisplayLabel := 'Descrição';
  qryCadBas.FieldByName('AUTOINCREM').Visible := False;
  qryCadBas.FieldByName('BAS_PESESP').DisplayLabel := 'P. Específico';
  TFloatField(qryCadBas.FieldByName('BAS_PESESP')).DisplayFormat := '0.000';
  qryCadBas.FieldByName('BAS_PRECUS').DisplayLabel := 'Preço Custo';
  qryCadBas.FieldByName('BAS_MARGEM').DisplayLabel := 'Margem';
  qryCadBas.FieldByName('BAS_PREVEN').DisplayLabel := 'Preco Venda';
  qryCadBas.FieldByName('BAS_EMBALA').DisplayLabel := 'Embalagem';
  TFloatField(qryCadBas.FieldByName('BAS_EMBALA')).DisplayFormat := '0.00';

  dtsCadBas := fCriaDataSource(qryCadBas);
end;

procedure TfrmCadSkyBases.pHabilitaBtn;
begin
  dbeDensidade.ReadOnly := (qryTabela.State in [dsEdit]);
end;

procedure TfrmCadSkyBases.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_CODBAS');
  stlCampos.Add('BAS_CODPRO');
  stlCampos.Add('BAS_DESCRI');

  stlCampos.Add('BAS_EMBALA');
  stlCampos.Add('BAS_PESESP');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_CODBAS');
  stlCamInd.Add('BAS_CODPRO');
  stlCamInd.Add('BAS_DESCRI');
  stlCamInd.Add('AUTOINCREM');

  stlDesInd.Add('Código');
  stlDesInd.Add('Cód. Prod');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadSkyBases.pLigaDataSets;
  Var
    intCont : Integer;
begin
  For intCont := 0 To Self.ComponentCount - 1 Do
  Begin
    If Components[intCont] is TDBEdit Then
      TDBEdit(Components[intCont]).DataSource := dtsCadBas;
  End;

  dbeCodigo.DataField     := 'BAS_CODBAS';
  dbeCodIte.DataField     := 'BAS_CODITE';
  dbeDensidade.DataField  := 'BAS_PESESP';
  dbeDescricao.DataField  := 'BAS_DESCRI';
  dbeEmbala.DataField     := 'BAS_EMBALA';
  dbeMargem.DataField     := 'BAS_MARGEM';
  dbePreCus.DataField     := 'BAS_PRECUS';
  dbePreVen.DataField     := 'BAS_PREVEN';

  edtPorIcms.DataField    := 'BAS_ICMS__';
  edtPorIpi.DataField     := 'BAS_IPI___';
end;

procedure TfrmCadSkyBases.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  strNomeTabela := 'SKY_CADBAS';
  strNomeCampo  := 'BAS_CODBAS';
  qryTabela     := qryCadBas;
  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadSkyBases.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqBaseTinta(Self, conSky, nil, nil, qryTabela, key, arrSel, True, '', '', False) Then
  Begin
    dbeDesIte.Text := fCarregaDesIte(dbeCodIte.Text);
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadSkyBases.btnAlterarClick(Sender: TObject);
begin
  StrCodIteAnt := dbeCodIte.text;
  inherited;

  pSetFocus(dbeCodigo);
  pHabilitaBtn;
end;

procedure TfrmCadSkyBases.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, dbeDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadSkyBases.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeCodIte.Text, fltPrecus, fltMargem, fltPreVen);
  dbePreCus.Field.AsFloat := fltPrecus;
  dbeMargem.Field.AsFloat := fltMargem;
  dbePreVen.Field.AsFloat := fltPreVen;
  edtPorIcms.Field.AsFloat := fRetPorcentagemIcms(dbeCodIte.Text);
  edtPorIpi.Field.AsFloat := fRetPorcentagemIpi(dbeCodIte.Text);
end;

procedure TfrmCadSkyBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dbeDesIte.Text := fRetNomProduto(dbeCodIte.Text);
end;


procedure TfrmCadSkyBases.btnExcluirClick(Sender: TObject);
begin
  strCodIteAnt := dbeCodIte.Text;
  inherited;

  dbeDesIte.Clear;

  if fEmptyStr(dbeCodIte.Text) Then
    pEnviarLogRep(strCodIteAnt, 'SKY');

end;

procedure TfrmCadSkyBases.btnGravarClick(Sender: TObject);
Var
  ObjValidarBaseItemAmarracao : TValidarBaseItemAmarracao;
  blnEdit : Boolean;
begin
  ObjValidarBaseItemAmarracao := TValidarBaseItemAmarracao.Create;

  blnEdit := (qryCadBas.State in [dsEdit]);

  fStartTransaction;

  Try
    if ObjValidarBaseItemAmarracao.fValidarBaseItemAmarracao('SKY', dbeCodigo.text, dbeDescricao.text, dbeCodIte.Text , StrCodIteAnt ,
                                 qryCadBas.FieldByName('BAS_PESESP').AsFloat , strToFloat(dbeEmbala.Text)) Then
    begin
      inherited;
      pAtualizaFatorTintometrico;

      If (Not fEmptyStr(strCoditeAnt)) And (blnEdit) Then
      Begin
        If (strCoditeAnt <> dbeCodIte.Text) Then
          pEnviarLogRep(strCodIteAnt, 'SKY');
      End;

      fCommit;
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

  If Assigned(ObjValidarBaseItemAmarracao)Then
    FreeAndNil(ObjValidarBaseItemAmarracao);

end;

procedure TfrmCadSkyBases.btnIncluirClick(Sender: TObject);
begin
  strCodIteAnt := '';
  inherited;
  blnUsaProCodigo := False;
  pSetFocus(dbeCodigo);
  dbeDesIte.Clear;
  pHabilitaBtn;
end;

procedure TfrmCadSkyBases.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  dbeDesIte.Text := fRetNomProduto(dbeCodIte.Text);
  btnRestPrecoClick(Sender);
end;

function TfrmCadSkyBases.fRetPorcentagemIcms(strCodIte: String): Double;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT ITE_ICMSAI FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP';
  qryGen.ParamByName('CODITE').AsString := strCodIte;
  qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryGen.Open;

  If qryGen.IsEmpty Or (qryGen.FieldByName('ITE_ICMSAI').IsNull) Then
    Result := 0
  Else
    Result := qryGen.FieldByName('ITE_ICMSAI').AsFloat;

  FreeAndNil(qryGen);
end;

function TfrmCadSkyBases.fRetPorcentagemIpi(strCodIte: String): Double;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT ITE_IPISAI FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP';
  qryGen.ParamByName('CODITE').AsString := strCodIte;
  qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryGen.Open;

  If qryGen.IsEmpty Or (qryGen.FieldByName('ITE_IPISAI').IsNull) Then
    Result := 0
  Else
    Result := qryGen.FieldByName('ITE_IPISAI').AsFloat;

  FreeAndNil(qryGen);
end;

end.

