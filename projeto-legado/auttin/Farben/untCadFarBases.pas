unit untCadFarBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, EditFocus, DB, Uni, UniDataSetProvider,
  UniClientDataSet, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadFarBases = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodBas: TDBEditFocus;
    pnlCabecalho: TPanel;
    Label3: TLabel;
    dbeDensidad: TDBEditFocus;
    Label4: TLabel;
    dbeCodIte: TDBEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    dbePreVen: TDBEditFocus;
    edtDesIte: TEditFocus;
    btnRestPreco: TSpeedButton;
    edtMargem: TEditFocus;
    dbePreCus: TDBEditFocus;
    Label8: TLabel;
    dbeEmbala: TDBEditFocus;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtMargemExit(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
  private
    qryCadBas : TUniQuery;
    qryCadIte : TUniQuery;
    dtsCadBas : TDataSource;
    StrCodIteAnt : String;
    procedure pAjustaTabelas;
    procedure pCriaDataSet;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
  public
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pCarregaItem;
    procedure pHabilitaBtn;
    procedure pAtualizarFatorTintometrico;
    { Public declarations }
  end;

var
  frmCadFarBases: TfrmCadFarBases;

implementation

uses untPai, untFuncoesSimples, untPesqAux,
  untFuncTinta, untConsultas, untTypesSistema, untValidarBaseItemAmarracao;

{$R *.dfm}

{ TfrmCadFarBases }

procedure TfrmCadFarBases.pAjustaTabelas;
  Var
    intRecNo : Integer;
begin
  intRecNo := qryCadBas.RecNo;
  qryCadBas.Close;
  qryCadBas.Open;
  qryCadBas.FieldByName('BAS_CODBAS').DisplayLabel := 'Código';
  qryCadBas.FieldByName('BAS_DESCRI').DisplayLabel := 'Base';
  qryCadBas.FieldByName('BAS_DENSID').DisplayLabel := 'Densidade';
  qryCadBas.FieldByName('BAS_CODEMP').Visible := False;
  qryCadBas.FieldByName('AUTOINCREM').Visible := False;
  TFloatField(qryCadBas.FieldByName('BAS_EMBALA')).DisplayFormat  := '#,##0.0000';
  TFloatField(qryCadBas.FieldByName('BAS_EMBALA')).EditFormat     := '#,##0.0000';
  TFloatField(qryCadBas.FieldByName('BAS_PRECUS')).DisplayFormat  := '#,##0.00';
  TFloatField(qryCadBas.FieldByName('BAS_PRECUS')).EditFormat     := '#,##0.00';
  TFloatField(qryCadBas.FieldByName('BAS_PREVEN')).DisplayFormat  := '#,##0.00';
  TFloatField(qryCadBas.FieldByName('BAS_PREVEN')).EditFormat     := '#,##0.00';
  TFloatField(qryCadBas.FieldByName('BAS_DENSID')).DisplayFormat  := '#,##0.0000';
  TFloatField(qryCadBas.FieldByName('BAS_DENSID')).EditFormat     := '#,##0.0000';
  qryCadBas.RecNo := intRecNo;
end;

procedure TfrmCadFarBases.pCriaDataSet;
  Var
    intCont : Integer;
begin
  qryCadBas := fCriaQuery(Self);
  qryCadBas.SQL.Text := 'SELECT * FROM FAR_CADBAS';
  qryCadBas.Open;

  dtsCadBas := fCriaDataSource(qryCadBas);

  For intCont := 0 To Self.ComponentCount -1 Do
  Begin
    If Components[intCont] is TDBEditFocus Then
      (Components[intCont] as TDBEditFocus).DataSource := dtsCadBas;
  End;

  dbeCodBas.DataField   := 'BAS_CODBAS';
  dbeCodIte.DataField   := 'BAS_CODITE';
  dbeDensidad.DataField := 'BAS_DENSID';
  dbeDescri.DataField   := 'BAS_DESCRI';
  dbePreCus.DataField   := 'BAS_PRECUS';
  dbePreVen.DataField   := 'BAS_PREVEN';
  dbeEmbala.DataField   := 'BAS_EMBALA';

  qryCadIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

procedure TfrmCadFarBases.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_CODBAS');
  stlCampos.Add('BAS_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_CODBAS');
  stlCamInd.Add('BAS_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadFarBases.btnIncluirClick(Sender: TObject);
begin
  strCodIteAnt := '';
  inherited;
  blnUsaProCodigo := False;
  
  If qryTabela.State = dsInsert Then
  begin
    edtDesIte.Clear;
    edtMargem.Clear;
    pSetFocus(dbeCodBas);
  end;

end;

procedure TfrmCadFarBases.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqBaseTinta(Self, conFar, nil, nil, qryTabela, Key, arrSel, True, '', '', False) Then
  Begin
    pCarregaItem;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadFarBases.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSet;
  pAjustaTabelas;

  TFloatField(qryCadBas.FieldByName('BAS_PRECUS')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_PREVEN')).DisplayFormat := '0.00';
  qryTabela := qryCadBas;

  strNomeTabela := 'FAR_CADBAS';
  strNomeCampo  := 'AUTOINCREM';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodBas;
end;

procedure TfrmCadFarBases.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadFarBases.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadFarBases.edtMargemExit(Sender: TObject);
begin
  inherited;
  edtMargem.Text := FormatFloat('#0.00', fStrToFloat(edtMargem.Text));
end;

procedure TfrmCadFarBases.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;

  If qryTabela.State <> dsEdit Then
    Exit;

  pRetornaPrecos(dbeCodIte.Text, fltPrecus, fltMargem, fltPreVen);
  dbePreCus.Field.AsString := FormatFloat('#,##0.00',fltPrecus);
  edtMargem.Text := FormatFloat('#,##0.00',fltMargem);
  dbePreVen.Field.AsString := FormatFloat('#,##0.00',fltPreVen);
end;

function TfrmCadFarBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodBas) Then
    Begin

      If (fEmptyStr(dbeCodBas.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código da base deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        fBuscaPorCamposChave;
        pCarregaItem;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin

      If (fEmptyStr(dbeDescri.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = dbeDensidad) Then
    Begin

      If (fEmptyStr(dbeDensidad.Text)) or (fStrToFloat(dbeDensidad.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A densidade não está configurada corretamente!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender  = dbeEmbala) Then
    Begin
      If (fEmptyStr(dbeEmbala.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'A embalagem dever ser informada!', ['&OK']);
        Result := False;
      End
      Else If fStrToFloat(dbeEmbala.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', ' A embalagem deve ser configurada', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbePreCus) Then
    Begin
      If (Not (fEmptyStr(dbeCodIte.Text))) Then
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
      If (Not (fEmptyStr(dbeCodIte.Text))) Then
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
          edtMargem.Text := FloatToStr(fRetPrecoVenda(2));
        End;
      End;
    End

    Else If (Sender = edtMargem) Then
    Begin
      If (Not (fEmptyStr(dbeCodIte.Text))) Then
      Begin
        If (fEmptyStr(edtMargem.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A margem deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(edtMargem.Text) < 0) Then
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

    Else If (Sender = dbeCodIte) Then
    Begin

      If fEmptyStr(dbeCodIte.Text) Then
      Begin
        dbeCodIte.Field.Value := Null;
      End
      Else If Not (fEmptyStr(dbeCodIte.Text)) Then
      Begin
        pCarregaItem;
        If (qryCadIte.FieldByName('ITE_CODITE').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;

    End;
  End;


end;

procedure TfrmCadFarBases.pCarregaItem;
begin
  pPesquisaCadIte(qryCadIte, qryCadIte, dbeCodIte.Text);
  With qryCadIte Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
  pHabilitaBtn;
end;

procedure TfrmCadFarBases.pHabilitaBtn;
begin
  If (qryTabela.State <> dsEdit) Then
    btnRestPreco.Visible := False
  Else
    btnRestPreco.Visible := True;

  dbeDensidad.ReadOnly := (qryTabela.State in [dsEdit]);
end;

function TfrmCadFarBases.fRetPrecoVenda(intOpcao: Integer): Double;
begin
  If fEmptyStr(dbePreVen.Text) Then
    dbePreVen.Text := '0,00';

  If fEmptyStr(edtMargem.Text) Then
    edtMargem.Text := '0,00';

  Result := fCalculaPrecoVenda(intOpcao,
                               fStrToFloat(dbePreCus.Text),
                               fStrToFloat(dbePreVen.Text),
                               fStrToFloat(edtMargem.Text),
                               0.0,
                               0.0,
                               0.0,
                               0.0);
end;

procedure TfrmCadFarBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadFarBases.btnExcluirClick(Sender: TObject);
begin
  strCodIteAnt := dbeCodIte.text;
  inherited;

  if fEmptyStr(dbeCodIte.Text)  And  Not(fEmptyStr(strCodIteAnt))Then
    pEnviarLogRep(strCodIteAnt, 'FAR');

  edtDesIte.Clear;
  edtMargem.Clear;
end;


procedure TfrmCadFarBases.btnGravarClick(Sender: TObject);
Var
  ObjValidarBaseItemAmarracao : TValidarBaseItemAmarracao;
  blnEdit : Boolean;
begin
  ObjValidarBaseItemAmarracao := TValidarBaseItemAmarracao.Create;

  blnEdit := (qryCadBas.State in [dsEdit]);

  fStartTransaction;

  Try
    if ObjValidarBaseItemAmarracao.fValidarBaseItemAmarracao('FAR', dbeCodBas.text, dbeDescri.text, dbeCodIte.Text , StrCodIteAnt ,
                                  qryCadBas.FieldByName('BAS_DENSID').AsFloat , strToFloat(dbeEmbala.Text)) Then
    begin
      inherited;

      If (Not fEmptyStr(strCoditeAnt)) And (blnEdit) Then
      Begin
        If (strCoditeAnt <> dbeCodIte.Text) Then
          pEnviarLogRep(strCodIteAnt, 'FAR');
      End;

      pHabilitaBtn;
      pAtualizarFatorTintometrico;
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

procedure TfrmCadFarBases.btnAlterarClick(Sender: TObject);
begin
  StrCodIteAnt := dbeCodIte.text;
  inherited;
  If dbeDescri.CanFocus Then
    pSetFocus(dbeDescri);

  pHabilitaBtn;
end;

procedure TfrmCadFarBases.pAtualizarFatorTintometrico;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qrygen.SQL.Text := 'UPDATE CADITE INNER JOIN FAR_CADBAS ON ITE_CODITE = BAS_CODITE SET ITE_CNV_ML = (IFNULL(BAS_DENSID, 1) * IFNULL(BAS_EMBALA, 1)) ';
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

end.

