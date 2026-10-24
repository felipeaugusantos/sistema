{***********************************************}
{* MODULO DE CADASTRO DE IMPRESSORAS FISCAIS   *}
{********************************************ED*}
{***************************}
{* qryEcfAlq -> ECFALQ     *}
{* qryEcfMod -> ECFMOD     *}
{* qryCadEcf -> CADECF     *}
{* qryFpgEcf -> FPGECF     *}
{************************RV*}
unit untCadEcf;

interface
                                        
uses
  Windows, Classes, Controls, Forms, StdCtrls, untPaiCad, Menus, ComCtrls,
  Buttons, ExtCtrls, Mask, DBCtrls, DBEditFocus, Grids, DBGridCitel, DBGrids, EditFocus,
  QColorLabel, DBLookupComboBoxFocus, DB, Uni, AppEvnts, UniClientDataSet,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;


Type
  TOpcoesIdentificacao = Record
    strCodMod: String;
    StrDesMod: String;
  End;

type
  TfrmCadEcf = class(TfrmPaiCad)
    pnlMarMod: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeModelo: TDBEditFocus;
    Panel1: TPanel;
    dbeCodStb: TDBEditFocus;
    dbeCodIse: TDBEditFocus;
    dbeCodNin: TDBEditFocus;
    tabModali: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Panel4: TPanel;
    dbgModali: TDBGridCitel;
    Panel5: TPanel;
    dbgAliquo: TDBGridCitel;
    ColorLabel2: TColorLabel;
    ColorLabel3: TColorLabel;
    ColorLabel4: TColorLabel;
    Label7: TLabel;
    Label21: TLabel;
    ColorLabel5: TColorLabel;
    Label4: TLabel;
    ColorLabel6: TColorLabel;
    dbeIdenti: TDBLookupComboBoxFocus;
    edtCodAlq: TEditFocus;
    edtServic: TEditFocus;
    edtDesMod: TEditFocus;
    edtCodMod: TEditFocus;
    edtPerAlq: TEditFocus;
    dtsEcfIde: TDataSource;
    Label5: TLabel;
    edtInfAdi: TEditFocus;
    ColorLabel1: TColorLabel;
    TabSheet1: TTabSheet;
    Panel6: TPanel;
    pnlFpgEcf: TPanel;
    Panel8: TPanel;
    dbgFpgEcf: TDBGridCitel;
    Label8: TLabel;
    edtModFpg: TEditFocus;
    dtsFpgEcf: TDataSource;
    cdsFpgEcf: TUniClientDataSet;
    cdsFpgEcfCODFPG: TStringField;
    cdsFpgEcfCODMOD: TStringField;
    Label6: TLabel;
    edtDesFpg: TEditFocus;
    edtCodFpg: TEditFocus;
    dtsTabAlq: TDataSource;
    dtsTabMod: TDataSource;
    dtsCadEcf: TDataSource;
    Label3: TLabel;
    dbeNumSer: TDBEditFocus;
    btnCadInicial: TBitBtnLocked;
    btnConfirmaFpg: TBitBtnLocked;
    btnCancelaFpg: TBitBtnLocked;
    btnConfirmaMod: TBitBtnLocked;
    btnCancelaMod: TBitBtnLocked;
    btnConfirmaAlq: TBitBtnLocked;
    btnCancelaAlq: TBitBtnLocked;
    btnAliquo: TBitBtnLocked;
    Label9: TLabel;
    dbeCodNac: TDBEditFocus;
    Label10: TLabel;
    dbeNumUsu: TDBEditFocus;

    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnConfirmaAlqClick(Sender: TObject);
    procedure btnConfirmaModClick(Sender: TObject);
    procedure btnCancelaAlqClick(Sender: TObject);
    procedure dbeIdentiKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelaModClick(Sender: TObject);
    procedure edtPerAlqExit(Sender: TObject);
    procedure dbgAliquoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgModaliKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);

  {***********************************************}
  {* PROCEDURE DO SISTEMA                        *}
  {********************************************ED*}
    procedure pCriaTempEcfIde;
    procedure pCriaTempEcfAlq;
    procedure pCriaTempEcfMod;
    procedure pDelTempIde;

    procedure pGravaEcfAlq;
    procedure pGravaEcfMod;
    procedure pDelEcfAlq(strCodEcf, strCodEmp: String);
    procedure pDelEcfMod(strCodMod, strCodEmp: String);

    procedure pCarregaEcfAlq(strCodEcf, strCodEmp: String);
    procedure pCarregaEcfMod(strCodEcf, strCodEmp: String);

    procedure pDelTempEcfAlq;
    procedure pDelTempEcfMod;
    procedure btnAliquoClick(Sender: TObject);
    procedure edtCodFpgKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaFpgClick(Sender: TObject);
    procedure dbgFpgEcfKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelaFpgClick(Sender: TObject);
    procedure btnCadInicialClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbeNumUsuKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }

    arrOpcoes: Array Of TOpcoesIdentificacao;
    qryConFpg: TUniQuery;
    qryEcfAlq: TUniQuery;
    qryEcfMod: TUniQuery;
    qryCadEcf: TUniQuery;
    qryFpgEcf: TUniQuery;

    cdsTabAlq,
    cdsTabMod,
    cdsEcfIde: TUniClientDataSet;

    procedure pCarregaCadFpg;
    procedure pCarregaEcfFpg;
    procedure pGravaEcfFpg;
  protected

    procedure pInicializaIndices; override;
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pHabComponentes(blnHabilita: Boolean);

  public
    { Public declarations }
  end;


implementation

uses SysUtils, Variants, untFuncoesSimples, untPai, untConsultas, untConstantes, 
  untPesqAux, untPafCadIniECF, untTypesSistema;

{$R *.dfm}

procedure TfrmCadEcf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryConFpg);
  FreeAndNil(qryCadEcf);
  FreeAndNil(qryEcfAlq);
  FreeAndNil(qryEcfMod);
  FreeAndNil(qryFpgEcf);
end;

procedure TfrmCadEcf.FormCreate(Sender: TObject);
  Var
    intContador : Integer;
begin
  qryEcfAlq := fCriarQuery('SELECT * FROM ECFALQ', Self);
  qryEcfMod := fCriarQuery('SELECT * FROM ECFMOD', Self);
  qryConFpg := fCriarQuery('SELECT * FROM CADFPG WHERE FALSE', Self);
  qryFpgEcf := fCriaQuery(Self);

  cdsFpgEcf.CreateDataSet;

  pCriaTempEcfIde;
  pCriaTempEcfAlq;
  pCriaTempEcfMod;

  pHabComponentes(False);

  SetLength( arrOpcoes, 6);

  arrOpcoes[0].strCodMod := '0';
  arrOpcoes[0].strDesMod := 'Geral';

  arrOpcoes[1].strCodMod := '1';
  arrOpcoes[1].strDesMod := 'Dinheiro';

  arrOpcoes[2].strCodMod := '2';
  arrOpcoes[2].strDesMod := 'Cheque-Pré';

  arrOpcoes[3].strCodMod := '3';
  arrOpcoes[3].strDesMod := 'Cartão';

  arrOpcoes[4].strCodMod := '4';
  arrOpcoes[4].strDesMod := 'Cheque';

  arrOpcoes[5].strCodMod := '5';
  arrOpcoes[5].strDesMod := 'Faturado';

  For intContador := 0 To Length( arrOpcoes) -1 Do
  Begin
    With cdsEcfIde Do
    Begin
      Insert;
      FieldByName('TMP_CODIDE').AsString := arrOpcoes[intContador].strCodMod;
      FieldByName('TMP_DESIDE').AsString := arrOpcoes[intContador].strDesMod;
      Post;
    End;

  End;

  inherited;
  strNomeTabela     := 'CADECF';
  strNomeCampo      := 'ECF_CODECF';

  qryCadEcf         := fCriaQuery(Self);
  qryTabela         := qryCadEcf;
  dtsCadEcf.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmCadEcf.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('ECF_CODECF');
  stlCampos.Add('ECF_MODELO');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('ECF_CODECF');
  stlCamInd.Add('ECF_MODELO');

  stlDesInd.Add('Código');
  stlDesInd.Add('Modelo');
end;


function TfrmCadEcf.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código deve ser ser informado!', ['&O k']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
        Begin
          pLimparCampos
        End
        Else
        Begin
          pCarregaEcfAlq(qryTabela.FieldByName('ECF_CODECF').AsString,
                         qryTabela.FieldByName('ECF_CODEMP').AsString);

          pCarregaEcfMod(qryTabela.FieldByName('ECF_CODECF').AsString,
                         qryTabela.FieldByName('ECF_CODEMP').AsString);

          pCarregaEcfFpg;
        End;
      End;
    End

    Else If (Sender = dbeModelo) Then
    Begin
      If (fEmptyStr(dbeModelo.Text)) And (dbeModelo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O modelo da impressora deve ser informado!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = dbeNumUsu) Then
    Begin
      If (fEmptyStr(dbeNumUsu.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O número do ECF deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
        dbeNumUsu.Text := fStrZero(dbeNumUsu.Text, 3);
    End

    Else If (Sender = dbeCodNac) Then
    Begin
      If (fCfgSis('PAFECF', varBoolean)) And (fEmptyStr(dbeCodNac.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código nacional do ECF deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodStb) Then
    Begin
      If (fEmptyStr(dbeCodStb.Text)) And (dbeCodStb.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código de substituição tributária dever ser preenchido!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = dbeCodIse) Then
    Begin
      If (fEmptyStr(dbeCodIse.Text)) And (dbeCodIse.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código de isenção tributária dever ser preenchido!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = dbeCodNin) Then
    Begin
      If (fEmptyStr(dbeCodNin.Text)) And (dbeCodNin.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código não incidente dever ser preenchido!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = edtCodAlq) Then
    Begin
      If (fEmptyStr(edtCodAlq.Text)) And (edtCodAlq.Enabled) Then
      Begin
        If Not cdsTabAlq.IsEmpty Then
        Begin
          pgcDados.ActivePageIndex := 1;
          blnMudarFoco := False;
        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'O código da alíquota dever ser preenchido!', ['&O k']);
          Result := False;
        End;
      End

    End

    Else If (Sender = edtPerAlq) Then
    Begin
      If Not fEmptyStr(edtCodAlq.Text) Then
      Begin
        If (fEmptyStr(edtPerAlq.Text)) And (edtPerAlq.Enabled) Then
        Begin
          fMensagem('ATENÇÃO!', 'O percentual dever ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          Try
            If fStrToFloat(edtPerAlq.Text) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'O percentual dever ser preenchido com valor maior que zero!', ['&O k']);
              Result := False;
            End
            Else
            Begin
              If fStrToFloat(edtPerAlq.Text) > 50 Then
              Begin
                fMensagem('ATENÇÃO!', 'O percentual dever estar entre 1% e 50%!', ['&O k']);
                Result := False;
              End;
            End;


          Except
            fMensagem('ATENÇÃO!', 'O percentual informado não é válido!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtServic) Then
    Begin
      If Not fEmptyStr(edtCodAlq.Text) Then
      Begin
        If (fEmptyStr(edtServic.Text)) And (edtServic.Enabled) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo serviço dever ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If (edtServic.Text <> 'S') And (edtServic.Text <> 'N') Then
          Begin
            fMensagem('ATENÇÃO!', 'O campo serviço dever ser preenchido com (S)im ou (N)ão!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtDesMod) Then
    Begin
      If (fEmptyStr(edtDesMod.Text)) And (edtDesMod.Enabled) Then
      Begin
        blnMudarFoco := False;
        pSetFocus(dbgModali);
        Exit;
      End;
    End

    Else If (Sender = edtCodFpg) Then
    Begin
      If (Not fEmptyStr(edtCodFpg.Text)) Then
      Begin
        pCarregaCadFpg;
        If (fEmptyStr(edtDesFpg.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa forma de pagamento não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If (qryConFpg.FieldByName('FPG_MOSMOD').AsString <> 'S') Then
        Begin
          fMensagem('ATENÇÃO!', 'Forma de pagamento não permitida!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        pSetFocus(btnCancelaFpg);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadEcf.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pgcDados.ActivePageIndex := 0;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeModelo, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  pHabComponentes(True);

  pDelTempEcfAlq;
  pDelTempEcfMod;
end;

procedure TfrmCadEcf.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If cdsTabAlq.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'As alíquotas devem ser informadas!', ['&O k']);
    pgcDados.ActivePageIndex := 0;
    pSetFocus(edtCodAlq);
    Exit;
  End;

  If cdsTabMod.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'As modalidades de pagamento devem ser informadas!', ['&O k']);
    pgcDados.ActivePageIndex := 1;
    pSetFocus(edtDesMod);
    Exit;
  End;

  If (Not fValidaCampos(dbeNumUsu, True)) Then
    Exit;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadEcf.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  Begin
    Try
      pGravaEcfAlq;

      pGravaEcfMod;

      pGravaEcfFpg;

      pgcDados.ActivePageIndex := 0;

      pHabComponentes(False);

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '');
      End;
    End;
  End
  Else
    fRollBack;

  blnGravou := False;
end;

procedure TfrmCadEcf.pCriaTempEcfIde;
begin
  cdsEcfIde := TUniClientDataSet.Create(Self);
  With cdsEcfIde, FieldDefs Do
  Begin
    With AddFieldDef Do Begin Name := 'TMP_CODIDE'; DataType := ftString; Size := 002; End;
    With AddFieldDef Do Begin Name := 'TMP_DESIDE'; DataType := ftString; Size := 015; End;

    CreateDataSet;
    Open;
  End;

  dtsEcfIde.DataSet := cdsEcfIde;
end;

procedure TfrmCadEcf.pCriaTempEcfAlq;
begin
  cdsTabAlq := TUniClientDataSet.Create(Self);
  With cdsTabAlq, FieldDefs Do
  Begin
    With AddFieldDef Do Begin Name := 'CODALQ'; DataType := ftString; Size := 010; End;
    With AddFieldDef Do Begin Name := 'PERALQ'; DataType := ftString; Size := 015; End;
    With AddFieldDef Do Begin Name := 'SERVIC'; DataType := ftString; Size := 001; End;

    CreateDataSet;
    Open;
  End;
  dtsTabAlq.DataSet := cdsTabAlq;
end;

procedure TfrmCadEcf.pCriaTempEcfMod;
begin
  cdsTabMod := TUniClientDataSet.Create(Self);
  With cdsTabMod, FieldDefs Do
  Begin
    With AddFieldDef Do Begin Name := 'CODMOD'; DataType := ftString; Size := 003; End;
    With AddFieldDef Do Begin Name := 'DESMOD'; DataType := ftString; Size := 030; End;
    With AddFieldDef Do Begin Name := 'DESIDE'; DataType := ftString; Size := 015; End;
    With AddFieldDef Do Begin Name := 'INFADI'; DataType := ftString; Size := 001; End;
    With AddFieldDef Do Begin Name := 'IDENTI'; DataType := ftString; Size := 002; End;

    CreateDataSet;
    Open;
  End;

  dtsTabMod.DataSet := cdsTabMod;
end;

procedure TfrmCadEcf.btnConfirmaAlqClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodAlq.Text) Then
    Exit;

  If Not cdsTabAlq.Active Then
    cdsTabAlq.Open;

  With cdsTabAlq Do
  Begin

    If (edtServic.Text = 'S') Then
    Begin

      If Locate('SERVIC', 'S', []) Then
      Begin
        fMensagem('', 'Não é permitido mais de uma alíquota de Serviço!', ['&O k']);
        Exit;
      End;

    End;

    Append;
    FieldByName('CODALQ').AsString := edtCodAlq.Text;
    FieldByName('PERALQ').AsString := FormatFloat('0.00', fStrToFloat(edtPerAlq.Text));
    FieldByName('SERVIC').AsString := edtServic.Text;
    Post;
  End;

  edtCodAlq.Clear;
  edtPerAlq.Clear;
  edtServic.Clear;
  pSetFocus(edtCodAlq);
end;

procedure TfrmCadEcf.btnConfirmaModClick(Sender: TObject);
  var
    intRecno: Integer;
begin
  inherited;
  If (fEmptyStr(edtDesMod.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Defina a descrição da modalidade!', ['&Ok']);
    pSetFocus(edtDesMod);
    Exit;
  End;

  If (fEmptyStr(edtCodMod.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Defina o código da modalidade!', ['&Ok']);
    pSetFocus(edtCodMod);
    Exit;
  End;

  If (fEmptyStr(dbeIdenti.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Defina a identificação da modalidade!', ['&Ok']);
    pSetFocus(dbeIdenti);
    Exit;
  End;

  If (fEmptyStr(edtInfAdi.Text)) Or (Pos(edtInfAdi.Text, 'SN') <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O campo Imprime Vencimentos deve ser "S" ou "N"!', ['&Ok']);
    pSetFocus(edtInfAdi);
    Exit;
  End;

  If Not cdsTabMod.Active Then
    cdsTabMod.Open;

  With cdsTabMod Do
  Begin
    intRecno := RecNo;

    First;
    While Not Eof Do
    Begin
      If Trim( FieldByName( 'CODMOD' ).AsString ) = Trim( edtCodMod.Text ) Then
      Begin
        fMensagem('ATENÇÃO!', 'Já existe uma modalidade com esse Código!', ['&Ok']);
        Recno := intRecno;
        Exit;
      End;

      Next;
    End;

    Append;
    FieldByName('CODMOD').AsString := edtCodMod.Text;
    FieldByName('DESMOD').AsString := edtDesMod.Text;
    FieldByName('DESIDE').AsString := dbeIdenti.Text;
    FieldByName('IDENTI').AsString := dbeIdenti.KeyValue;
    FieldByName('INFADI').AsString := edtInfAdi.Text;
    Post;

  End;
  edtDesMod.Clear;
  edtCodMod.Clear;
  edtInfAdi.Clear;
  dbeIdenti.ListFieldIndex := -1;
  pSetFocus(edtDesMod);
end;

procedure TfrmCadEcf.btnCancelaAlqClick(Sender: TObject);
begin
  inherited;
  edtCodAlq.Clear;
  edtPerAlq.Clear;
  edtServic.Clear;
  pSetFocus(edtCodAlq);
end;

procedure TfrmCadEcf.pDelTempIde;
begin
  If cdsEcfIde.Active Then
    cdsEcfIde.EmptyDataSet;
end;

procedure TfrmCadEcf.dbeIdentiKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Down) Then
  Begin
    dbeIdenti.DropDown;
  End
  Else If (Key = VK_Return) Then
  Begin
    dbeIdenti.CloseUp(True);
    pProximoControle(Sender);
  End
  Else If (Key = VK_Escape) Then
  Begin
    If (Assigned(qryTabela)) And (qryTabela.State = dsInsert) Then
    Begin
      If fMensagem('AVISO', 'Deseja cancelar a inserção desse registro?', ['&S i m', '&N ã o']) = 1 Then
      Begin
        btnCancela.Click;
      End;
    End
    Else If (Assigned(qryTabela)) And (qryTabela.State = dsEdit) Then
    Begin
      If fMensagem('AVISO', 'Deseja cancelar a edição desse registro?', ['&S i m', '&N ã o']) = 1 Then
      Begin
        btnCancela.Click;
      End;
    End
    Else
      btnSair.Click;
  End;
end;

procedure TfrmCadEcf.dbeNumUsuKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = ',') Then
    Key := #0;
end;

procedure TfrmCadEcf.btnCancelaModClick(Sender: TObject);
begin
  inherited;
  edtDesMod.Clear;
  edtInfAdi.Clear;
  edtCodMod.Clear;
  pSetFocus(edtDesMod);
end;

procedure TfrmCadEcf.edtPerAlqExit(Sender: TObject);
begin
  Try
    edtPerAlq.Text := Formatfloat('0.00', fStrToFloat(edtPerAlq.Text));
  Except

  End;
  inherited;
end;

procedure TfrmCadEcf.pGravaEcfAlq;
  Var
    strCodEcf : String;
    strCodEmp : String;
begin
  strCodEcf := qryTabela.FieldByName('ECF_CODECF').AsString;
  strCodEmp := qryTabela.FieldByName('ECF_CODEMP').AsString;

  pDelEcfAlq(strCodEcf, strCodEmp);

  With qryEcfAlq Do
  Begin
    Close;
    Open;

    cdsTabAlq.First;
    While Not cdsTabAlq.Eof Do
    Begin
      Append;
      FieldByName('ECF_CODECF').AsString  := strCodEcf;
      FieldByName('ECF_CODEMP').AsString  := strCodEmp;
      FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ECFALQ', strCodEmp);
      FieldByName('ECF_CODALQ').AsString  := cdsTabAlq.FieldByName('CODALQ').AsString;
      FieldByName('ECF_PERALQ').AsString  := cdsTabAlq.FieldByName('PERALQ').AsString;
      FieldByName('ECF_SERVIC').AsString  := cdsTabAlq.FieldByName('SERVIC').AsString;
      Post;
      cdsTabAlq.Next;
    End;
  End;
end;

procedure TfrmCadEcf.pDelEcfAlq(strCodEcf, strCodEmp: String);
  Var
    strSQL   : String;
    qryGenAlq: TUniQuery;
begin
  Try

    qryGenAlq := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'DELETE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ECFALQ ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ECF_CODECF = :CODECF AND ';
    strSQL := strSQL + '  ECF_CODEMP = :CODEMP ';

    With qryGenAlq Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODECF').AsString := strCodEcf;
      ParamByName('CODEMP').AsString := strCodEmp;
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryGenAlq);
  End;
end;

procedure TfrmCadEcf.pDelEcfMod(strCodMod, strCodEmp: String);
  Var
    strSQL   : String;
    qryGenMod: TUniQuery;
begin
  Try

    qryGenMod := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'DELETE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ECFMOD ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ECF_CODECF = :CODECF AND ';
    strSQL := strSQL + '  ECF_CODEMP = :CODEMP ';

    With qryGenMod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODECF').AsString := strCodMod;
      ParamByName('CODEMP').AsString := strCodEmp;
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryGenMod);
  End;
end;

procedure TfrmCadEcf.pGravaEcfMod;
  Var
    strCodEcf : String;
    strCodEmp : String;
begin
  strCodEcf := qryTabela.FieldByName('ECF_CODECF').AsString;
  strCodEmp := qryTabela.FieldByName('ECF_CODEMP').AsString;

  pDelEcfMod(strCodEcf, strCodEmp);

  With qryEcfMod Do
  Begin
    Close;
    Open;

    cdsTabMod.First;
    While Not cdsTabMod.Eof Do
    Begin
      Append;
      FieldByName('ECF_CODECF').AsString  := strCodEcf;
      FieldByName('ECF_CODEMP').AsString  := strCodEmp;
      FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ECFMOD', strCodEmp);
      FieldByName('ECF_DESMOD').AsString  := cdsTabMod.FieldByName('DESMOD').AsString;
      FieldByName('ECF_CODMOD').AsString  := cdsTabMod.FieldByName('CODMOD').AsString;
      FieldByName('ECF_IDENTI').AsString  := cdsTabMod.FieldByName('IDENTI').AsString;
      FieldByName('ECF_INFADI').AsString  := cdsTabMod.FieldByName('INFADI').AsString;
      Post;
      cdsTabMod.Next;
    End;
  End;
end;

procedure TfrmCadEcf.pCarregaEcfAlq(strCodEcf, strCodEmp: String);
  Var
    strSQL   : String;
    qryGenAlq: TUniQuery;
begin
  qryGenAlq := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ECFALQ ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ECF_CODECF = :CODECF  AND ';
  strSQL := strSQL + '  ECF_CODEMP = :CODEMP ';

  With qryGenAlq Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODECF').AsString := strCodEcf;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    pDelTempEcfAlq;

    If IsEmpty Then
    Begin
      fMensagem('ATENÇÃO!', 'Cadastro de alíquotas não encontrado.', ['&O k']);
      Exit;
    End
    Else
    Begin
      First;
      While Not Eof Do
      Begin
        If Not cdsTabAlq.Active Then
          cdsTabAlq.Open;

        With cdsTabAlq Do
        Begin
          Append;
          FieldByName('CODALQ').AsString := qryGenAlq.FieldByName('ECF_CODALQ').AsString;
          FieldByName('PERALQ').AsString := FormatFloat('0.00', qryGenAlq.FieldByName('ECF_PERALQ').AsFloat);
          FieldByName('SERVIC').AsString := qryGenAlq.FieldByName('ECF_SERVIC').AsString;
          Post;
        End;
        Next;
      End;
    End;
  End;

  FreeAndNil(qryGenAlq);
end;

procedure TfrmCadEcf.pCarregaEcfMod(strCodEcf, strCodEmp: String);
  Var
    strSQL   : String;
    qryGenMod: TUniQuery;
begin
  qryGenMod := fCriaQuery(Self);

  SetLength( arrOpcoes, 6);

  arrOpcoes[0].strCodMod := '0';
  arrOpcoes[0].strDesMod := 'Geral';

  arrOpcoes[1].strCodMod := '1';
  arrOpcoes[1].strDesMod := 'Dinheiro';

  arrOpcoes[2].strCodMod := '2';
  arrOpcoes[2].strDesMod := 'Cheque-Pré';

  arrOpcoes[3].strCodMod := '3';
  arrOpcoes[3].strDesMod := 'Cartão';

  arrOpcoes[4].strCodMod := '4';
  arrOpcoes[4].strDesMod := 'Cheque';

  arrOpcoes[5].strCodMod := '5';
  arrOpcoes[5].strDesMod := 'Faturado';

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ECFMOD ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ECF_CODECF = :CODECF AND ';
  strSQL := strSQL + '  ECF_CODEMP = :CODEMP ';
  With qryGenMod Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODECF').AsString := strCodEcf;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;
    pDelTempEcfMod;

    If IsEmpty Then
    Begin
      fMensagem('ATENÇÃO!', 'Modalidades não encontradas.', ['&O k']);
      Exit;
    End
    Else
    Begin
      First;

      While Not Eof Do
      Begin
        If Not cdsTabMod.Active Then
          cdsTabMod.Open;

        With cdsTabMod Do
        Begin
          Append;
          FieldByName('CODMOD').AsString := qryGenMod.FieldByName('ECF_CODMOD').AsString;
          FieldByName('DESMOD').AsString := qryGenMod.FieldByName('ECF_DESMOD').AsString;
          FieldByName('DESIDE').AsString := arrOpcoes[qryGenMod.FieldByName('ECF_IDENTI').AsInteger].strDesMod;
          FieldByName('IDENTI').AsString := qryGenMod.FieldByName('ECF_IDENTI').AsString;
          FieldByName('INFADI').AsString := qryGenMod.FieldByName('ECF_INFADI').AsString;
          Post;
        End;
        Next;

      End;
    End;
  End;

  FreeAndNil(qryGenMod);
end;

procedure TfrmCadEcf.dbgAliquoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    pSetFocus(edtCodAlq);
  End
  Else If (Key = VK_Delete) Then
  Begin
    If Not cdsTabAlq.IsEmpty  then
      cdsTabAlq.Delete;
  End;
end;

procedure TfrmCadEcf.dbgModaliKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var
  strCodModAux: String;
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    pSetFocus(edtDesMod);
  End
  Else If (Key = VK_Delete) Then
  Begin
    If Not cdsTabMod.IsEmpty Then
    Begin
      strCodModAux := cdsTabMod.FieldByName('CODMOD').AsString;
      If cdsFpgEcf.Locate('CODMOD', strCodModAux, []) Then
      Begin
        If fMensagem('AVISO', 'Esta modalidade está vinculada a uma forma de pagamento.'+#13+
                     'Se for apagada, irá apagar o vinculo criado em Formas de Pagamento.'+#13+
                     'Confirma que deseja apagar essa Modalidade?', ['&S i m', '&N ã o']) = 1 Then
        Begin
          cdsTabMod.Delete;
          cdsFpgEcf.First;
          While cdsFpgEcf.Locate('CODMOD', strCodModAux, []) Do
            cdsFpgEcf.Delete;
        End;
      End
      Else
        cdsTabMod.Delete;
    End;
  End;
end;

procedure TfrmCadEcf.btnPesquisaClick(Sender: TObject);
Var
  arrECF : TConsultasArray;
  chrKey : Char;
begin
  {************************}
  {* NOVA CONSULTA DE ECF *}
  {*********************DP*}
  chrKey := '/';
  fPesqECF(Self, Nil, Nil, qryTabela, chrKey, arrECF);

  If (Not qryTabela.IsEmpty) Then
  Begin

    pDelTempEcfAlq;
    pDelTempEcfMod;

    pCarregaEcfAlq(qryTabela.FieldByName('ECF_CODECF').AsString,
                   qryTabela.FieldByName('ECF_CODEMP').AsString);

    pCarregaEcfMod(qryTabela.FieldByName('ECF_CODECF').AsString,
                   qryTabela.FieldByName('ECF_CODEMP').AsString);

    pCarregaEcfFpg;

  End;

  pHabComponentes(False);
end;

procedure TfrmCadEcf.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pgcDados.ActivePageIndex := 0;
  pHabilitaCodigo(dbeCodigo, dbeModelo, False);
  pHabComponentes(True);
end;

procedure TfrmCadEcf.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadEcf.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    Try
      pDelEcfAlq(qryTabela.FieldByName('ECF_CODECF').AsString, qryTabela.FieldByName('ECF_CODEMP').AsString);
      pDelEcfMod(qryTabela.FieldByName('ECF_CODECF').AsString, qryTabela.FieldByName('ECF_CODEMP').AsString);
      cdsTabAlq.EmptyDataSet;
      cdsTabMod.EmptyDataSet;
      cdsTabAlq.Close;
      cdsTabMod.Close;
      pHabComponentes(False);
      blnExcluiu := False;
      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '');
      End;
    End;
  End
  Else
    fRollBack;
end;

procedure TfrmCadEcf.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pDelTempEcfAlq;
  pDelTempEcfMod;

  If (Not qryTabela.IsEmpty) Then
  Begin
    pCarregaEcfAlq(qryTabela.FieldByName('ECF_CODECF').AsString,
                   qryTabela.FieldByName('ECF_CODEMP').AsString);

    pCarregaEcfMod(qryTabela.FieldByName('ECF_CODECF').AsString,
                   qryTabela.FieldByName('ECF_CODEMP').AsString);

    pCarregaEcfFpg;
  End;

  pHabComponentes(False);
  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmCadEcf.pHabComponentes(blnHabilita: Boolean);
begin
  btnConfirmaAlq.Enabled := blnHabilita;
  btnConfirmaMod.Enabled := blnHabilita;
  btnConfirmaFpg.Enabled := blnHabilita;

  btnCancelaAlq.Enabled := blnHabilita;
  btnCancelaMod.Enabled := blnHabilita;
  btnCancelaFpg.Enabled := blnHabilita;

  btnAliquo.Enabled     := blnHabilita;

  dbgAliquo.Enabled     := blnHabilita;
  dbgModali.Enabled     := blnHabilita;
  dbgFpgEcf.Enabled     := blnHabilita;
end;

procedure TfrmCadEcf.pDelTempEcfAlq;
begin
  If cdsTabAlq.Active Then
    cdsTabAlq.EmptyDataSet;
end;

procedure TfrmCadEcf.pDelTempEcfMod;
begin
  If cdsTabMod.Active Then
    cdsTabMod.EmptyDataSet;
end;

procedure TfrmCadEcf.btnAliquoClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgAliquo);
end;

procedure TfrmCadEcf.edtCodFpgKeyPress(Sender: TObject; var Key: Char);
  Var
    arrForma: TConsultasArray;
begin
  inherited;
  {***********************************}
  {* NOVA CONSULTA DE FORMA DE PAGTO *}
  {********************************RV*}
  If fPesqFormaPgto(conFpgSimples, Self, edtCodFpg, edtDesFpg, Nil, Key, arrForma) Then
  Begin
    If fValidaCampos(edtCodFpg, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEcf.pCarregaCadFpg;
begin
  pPesquisaCadFpg(qryConFpg, qryConFpg, edtCodFpg.Text);
  edtDesFpg.Text := qryConFpg.FieldByName('FPG_DESCRI').AsString;
end;

procedure TfrmCadEcf.btnConfirmaFpgClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodFpg.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'A forma de pagamento deve ser preenchida!', ['&Ok']);
    pSetFocus(edtCodFpg);
    Exit;
  End
  Else
  Begin
    If Not fValidaCampos(edtCodFpg, True) Then
    Begin
      pSetFocus(edtCodFpg);
      Exit;
    End;
  End;

  If fEmptyStr(edtModFpg.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'A modalidade deve ser preenchida!', ['&Ok']);
    pSetFocus(edtModFpg);
    Exit;
  End;

  If Not cdsTabMod.Locate('CODMOD', edtModFpg.Text, []) Then
  Begin
    fMensagem('ATENÇÃO!', 'Modalidade não foi cadastrada. Cadastre esta Modalidade Antes!', ['&Ok']);
    pSetFocus(edtModFpg);
    Exit;
  End;

  If cdsFpgEcf.Locate('CODFPG;CODMOD', VarArrayOf([edtCodFpg.Text, edtModFpg.Text]), []) Then
  Begin
    fMensagem('ATENÇÃO!', 'Já existe um registro com esses dados!', ['&Ok']);
    pSetFocus(edtCodFpg);
    Exit;
  End;

  If (edtCodFpg.Text = '002') And (cdsTabMod.FieldByName('IDENTI').AsString <> '2') Then
  Begin
    fMensagem('ATENÇÃO!', 'Esta Forma de Pagamento só é Permitida Com Modalidade '+
              'que tenha Identificação = "Cheque-Pré"!'+#13+
              'Identificação da Modalidade '+edtModFpg.Text+
              ' (Atual) é '+cdsTabMod.FieldByName('DESIDE').AsString, ['&Ok']);
    pSetFocus(edtCodFpg);
    Exit;
  End;

  If (edtCodFpg.Text = '006') And (cdsTabMod.FieldByName('IDENTI').AsString <> '4') Then
  Begin
    fMensagem('ATENÇÃO!', 'Esta Forma de Pagamento só é Permitida Com Modalidade '+
              'que tenha Identificação = "Cheque"!'+#13+
              ' (Atual) é '+cdsTabMod.FieldByName('DESIDE').AsString, ['&Ok']);
    pSetFocus(edtCodFpg);
    Exit;
  End;

  If (edtCodFpg.Text = '007') And (cdsTabMod.FieldByName('IDENTI').AsString <> '3') Then
  Begin
    fMensagem('ATENÇÃO!', 'Esta Forma de Pagamento só é Permitida Com Modalidade '+
              'que tenha Identificação = "Cartão"!'+#13+
              ' (Atual) é '+cdsTabMod.FieldByName('DESIDE').AsString, ['&Ok']);
    pSetFocus(edtCodFpg);
    Exit;
  End;

  cdsFpgEcf.Append;
  cdsFpgEcf.FieldByName('CODFPG').AsString := edtCodFpg.Text;
  cdsFpgEcf.FieldByName('CODMOD').AsString := edtModFpg.Text;
  cdsFpgEcf.Post;

  btnCancelaFpg.Click;
end;

procedure TfrmCadEcf.dbgFpgEcfKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
  Begin
    If (cdsFpgEcf.IsEmpty) Then
      Exit;

    cdsFpgEcf.Delete;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    btnCancelaFpg.Click;
  End;
end;

procedure TfrmCadEcf.pCarregaEcfFpg;
  Var
    qryAux: TUniQuery;
begin
  cdsFpgEcf.EmptyDataSet;

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT * FROM FPGECF WHERE ECF_CODECF = :CODECF AND ECF_CODEMP = :CODEMP');
  qryAux.ParamByName('CODECF').AsString := qryTabela.FieldByName('ECF_CODECF').AsString;
  qryAux.ParamByName('CODEMP').AsString := qryTabela.FieldByName('ECF_CODEMP').AsString;
  qryAux.Open;

  While (Not qryAux.Eof) Do
  Begin
    cdsFpgEcf.Append;
    cdsFpgEcf.FieldByName('CODFPG').AsString := qryAux.FieldByName('FPG_CODIGO').AsString;
    cdsFpgEcf.FieldByName('CODMOD').AsString := qryAux.FieldByName('ECF_CODMOD').AsString;
    cdsFpgEcf.Post;
    qryAux.Next;
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmCadEcf.pGravaEcfFpg;
  Var
    qryAux    : TUniQuery;
    strCodEcf : String;
    strCodEmp : String;
    strSQL    : String;
begin
  strCodEcf := qryTabela.FieldByName('ECF_CODECF').AsString;
  strCodEmp := qryTabela.FieldByName('ECF_CODEMP').AsString;

  qryAux := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FPGECF ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ECF_CODECF = :CODECF AND ';
  strSQL := strSQL + '  ECF_CODEMP = :CODEMP ';

  With qryFpgEcf Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODECF').AsString := strCodEcf;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If (RecordCount > 0) Then
    Begin
      qryAux.SQL.Clear;
      qryAux.SQL.Add('DELETE FROM FPGECF WHERE ECF_CODECF = :CODECF AND ECF_CODEMP = :CODEMP');
      qryAux.ParamByName('CODECF').AsString := strCodEcf;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ExecSQL;
      qryAux.Close;

      Close;
      Open;
    End;

    cdsFpgEcf.First;
    While (Not cdsFpgEcf.Eof) Do
    Begin
      Append;
    	FieldByName('FPG_CODIGO').AsString := cdsFpgEcf.FieldByName('CODFPG').AsString;
    	FieldByName('ECF_CODECF').AsString := strCodEcf;
    	FieldByName('ECF_CODEMP').AsString := strCodEmp;
    	FieldByName('ECF_CODMOD').AsString := cdsFpgEcf.FieldByName('CODMOD').AsString;
    	FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FPGECF', VS_strCodEmp);
      Post;
      cdsFpgEcf.Next;
    End;

    Close;
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmCadEcf.btnCancelaFpgClick(Sender: TObject);
begin
  inherited;
  edtCodFpg.Clear;
  edtDesFpg.Clear;
  edtModFpg.Clear;
  pSetFocus(edtCodFpg);
end;

procedure TfrmCadEcf.btnCadInicialClick(Sender: TObject);
  Var
    strSenhaECF: String;
begin
  inherited;
  If ffrmSenha(strSenhaECF) Then
  Begin
    If strSenhaECF = SEN_ADM Then
      pCriarForm(TfrmPafCadIniECF, frmPafCadIniECF);
  End;
end;

end.

