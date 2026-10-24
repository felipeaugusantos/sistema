unit CupomPromocao.Reimpressao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls,
  dxCore, cxDateUtils, Vcl.ExtCtrls, Vcl.StdCtrls, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, EditFocus, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, CupomPromocao.Controle,
  Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Datasnap.DBClient,
  UniClientDataSet, DBAccess, Uni, System.UITypes;

type
  TfrmImpCupProm = class(TfrmPai)
    pnlFiltros: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    btnConsultar: TBitBtnLocked;
    edtNomCli: TEditFocus;
    edtCodCli: TEditFocus;
    dtaFin: TcxDateEdit;
    dtaIni: TcxDateEdit;
    rdgCupom: TRadioGroup;
    edtCodPro: TEditFocus;
    edtDesPro: TEditFocus;
    Panel1: TPanel;
    Label9: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    shpReimpresso: TShape;
    shpNaoImpresso: TShape;
    shpImpresso: TShape;
    shpEditavel: TShape;
    lblEditavel: TLabel;
    btnConfirmar: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnInfCliente: TBitBtnLocked;
    btnLimpar: TBitBtnLocked;
    pnlFundo: TPanel;
    dbgCupons: TDBGridCitel;
    dtsCppGer: TUniDataSource;
    cdsCppGer: TUniClientDataSet;
    cdsCppGerDOCUMENTO: TStringField;
    cdsCppGerCLIENTE: TStringField;
    cdsCppGerVALOR: TFloatField;
    cdsCppGerQUANTIDADE: TIntegerField;
    cdsCppGerDATA: TDateTimeField;
    cdsCppGerIMPRIMIR: TIntegerField;
    cdsCppGerCLICPF: TStringField;
    cdsCppGerIMPRESSO: TStringField;
    cdsCppGerQTDORI: TIntegerField;
    cdsCppGerCUPOM: TStringField;
    cdsCppGerPROMOCAO: TStringField;
    cdsCppGerSEQPRO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbgCuponsDblClick(Sender: TObject);
    procedure dbgCuponsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnLimparClick(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure cdsCppGerAfterScroll(DataSet: TDataSet);
    procedure btnInfClienteClick(Sender: TObject);
    procedure cdsCppGerBeforePost(DataSet: TDataSet);
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    objControleCupomPromocao: TControleCupomPromocao;

    procedure pCarregaCupons;
    procedure pPreencheCliente(blnComCodigo: Boolean);
    procedure pMarcaDesmarcaRegistro;
    procedure pImprimeCupons;
    function fTravarUsoDeCliente: Boolean;
    procedure pLiberarUsoDeCliente;
    procedure pHabilitaDesabilitaFiltros(blnHabilitar: Boolean);
    procedure pLimparFiltros;
    function fImpressaoLiberada: Boolean;
    function fListaDeCuponsSelecionados: String;
    function fRetTipoImpressoFiltro: String;
    function fMostraBotaoParaInformarCpfCliente: Boolean;
    procedure pInformaPessoaFisica;
    procedure pGravaCliCpf(strCliCpf: String);
    function fTravaCupomPessoaJuridica(ACupons: TUniClientDataSet): Boolean;
    function fTemMaisDeUmDocSelecionado(ADataSet: TUniClientDataSet): Boolean;
    procedure pAtualizaCliCPF(ADocumento, ACliCpf: String);
    procedure pMarcaDesmarcaTodos(AMarcar: Boolean);
    function fValidarData(AData: String): Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema, untLiberacao, untDigCliente;

{$R *.dfm}

procedure TfrmImpCupProm.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  pImprimeCupons;
end;

procedure TfrmImpCupProm.btnConsultarClick(Sender: TObject);
begin
  inherited;

  If (fValidaCampos(edtCodCli)) And
     (fValidaCampos(dtaIni)) And
     (fValidaCampos(dtaFin)) And
     (fValidaCampos(edtCodPro)) Then
    pCarregaCupons;
end;

procedure TfrmImpCupProm.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(False);
end;

procedure TfrmImpCupProm.btnInfClienteClick(Sender: TObject);
begin
  inherited;

  if cdsCppGer.RecordCount <= 0 then
    Exit;

  if (not btnInfCliente.Visible) then
    Exit;

  pInformaPessoaFisica;
end;

procedure TfrmImpCupProm.btnLimparClick(Sender: TObject);
begin
  inherited;
  pLimparFiltros;
end;

procedure TfrmImpCupProm.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(True);
end;

procedure TfrmImpCupProm.cdsCppGerAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btnInfCliente.Visible := fMostraBotaoParaInformarCpfCliente;
end;

procedure TfrmImpCupProm.cdsCppGerBeforePost(DataSet: TDataSet);
begin
  inherited;

  if (cdsCppGer.FieldByName('QUANTIDADE').AsInteger <= 0) then
  begin
    fMensagem('ATENÇÃO!', 'A quantidade não pode ser menor ou igual a 0!', ['&Ok']);
    cdsCppGer.FieldByName('QUANTIDADE').AsInteger := cdsCppGer.FieldByName('QTDORI').AsInteger;
    DataSet.Cancel;
    Abort;
  end;

  if (cdsCppGer.FieldByName('QUANTIDADE').AsInteger > cdsCppGer.FieldByName('QTDORI').AsInteger) then
  begin
    fMensagem('ATENÇÃO!', 'A quantidade não pode ser maior que ' + cdsCppGer.FieldByName('QTDORI').AsString + '!', ['&Ok']);
    cdsCppGer.FieldByName('QUANTIDADE').AsInteger := cdsCppGer.FieldByName('QTDORI').AsInteger;
    DataSet.Cancel;
    Abort;
  end;
end;

procedure TfrmImpCupProm.dbgCuponsDblClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaRegistro;
end;

procedure TfrmImpCupProm.dbgCuponsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;

  If (cdsCppGer.FieldByName('IMPRIMIR').AsInteger = 1) Then
    dbgCupons.Canvas.Brush.Color := clAqua;

  if Column.FieldName = 'QUANTIDADE' then
  begin
    dbgCupons.Canvas.Brush.Color := shpEditavel.Brush.Color;
    dbgCupons.Canvas.Font.Color  := clBlack;
  end
  Else If (cdsCppGer.FieldByName('IMPRESSO').AsString = 'S') Then
  Begin
    dbgCupons.Canvas.Font.Color  := shpImpresso.Brush.Color;
  End
  Else If (cdsCppGer.FieldByName('IMPRESSO').AsString = 'N') Then
  Begin
    dbgCupons.Canvas.Font.Color  := shpNaoImpresso.Brush.Color;
  End
  Else If (cdsCppGer.FieldByName('IMPRESSO').AsString = 'R') Then
  Begin
    dbgCupons.Canvas.Font.Color  := shpReimpresso.Brush.Color;
  End
  Else
  Begin
    If (Rect.Top = TStringGrid(dbgCupons).CellRect(0, TStringGrid(dbgCupons).Row).Top) And
      (cdsCppGer.RecordCount > 0) Then
    Begin
      dbgCupons.Canvas.Brush.Color := clInactiveBorder;
    End
    Else
      dbgCupons.Canvas.Brush.Color := clWindow;

    dbgCupons.Canvas.Font.Color  := clBlack;
  End;
  dbgCupons.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmImpCupProm.edtCodCliKeyPress(Sender: TObject; var Key: Char);
var
  arrClientes: TConsultasArray;
begin
  If (fPesqCliente(conCliCompleta, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes)) Then
  Begin
    If fValidaCampos(edtCodCli) Then
      SelectNext(ActiveControl, True, True);
  End;

  If (Key = #13) Then
    pPreencheCliente(False)
  Else If (Key = #8) Then
    edtNomCli.Text := '';
end;

procedure TfrmImpCupProm.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
var
  arrEmp: TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, Nil, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;

  If (Key = #13) Then
  Begin
    If (Not fEmptyStr(edtNumDoc.Text)) Then
      edtCodEmp.Text := fStrZero(edtCodEmp.Text, 3);
    pPreencheCliente(True);
  End;
end;

procedure TfrmImpCupProm.edtCodProKeyPress(Sender: TObject; var Key: Char);
var
  arrProm: TConsultasArray;
begin
  if (fPesqPromoCupom(Self, edtCodPro, edtDesPro, nil, Key, arrProm)) then
  begin
    edtDesPro.Text := fRetornaDescricaoPromocao(edtCodPro.Text);

    if fValidaCampos(edtCodPro) then
      SelectNext(ActiveControl, True, True);
  end;

  if (Key = #13) then
    edtDesPro.Text := fRetornaDescricaoPromocao(edtCodPro.Text)
  else if (Key = #8) then
    edtDesPro.Text := '';
end;

procedure TfrmImpCupProm.edtNumDocKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If (Key = #13) And (Not fEmptyStr(edtNumDoc.Text)) Then
    edtNumDoc.Text := fStrZero(edtNumDoc.Text, 12);
end;

function TfrmImpCupProm.fImpressaoLiberada: Boolean;
var
  objLiberacao: TLiberacao;
  strCliente: String;
begin
  Result := True;

  If (Not fVerificaAcessoSistema('REIMPCPP', strLoginUsuarioLogado)) Then
  Begin
    objLiberacao := TLiberacao.Create;
    strCliente := edtCodCli.Text + '-' + edtNomCli.Text;

    Try
      objLiberacao.objMsgLibera.pAddTexto('Reimpressão de cupom promocional');
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddTexto('Cupons a serem reeimpressos: ');
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddTexto(fListaDeCuponsSelecionados);
      objLiberacao.objMsgLibera.pAddQuebra;

      objLiberacao.strDirAce  := 'REIMPCPP';
      objLiberacao.strSenLib  := fCfgSis('SENLBD');
      objLiberacao.strMsgSen  := 'Reimpressão de cupom promocional';
      objLiberacao.strCodOpe  := strLoginUsuarioLogado;
      objLiberacao.strCliente := strCliente;

      Result := objLiberacao.fLibera;
    Finally
      FreeAndNil(objLiberacao);
    End;
  End;
end;

function TfrmImpCupProm.fValidarData(AData: String): Boolean;
begin
  if (StrToDateDef(AData, 0) > 0) then
    Exit(True);

  Result := fEmptyStr(edtNumDoc.Text) or fEmptyStr(edtEspDoc.Text) or fEmptyStr(edtCodEmp.Text);
end;

function TfrmImpCupProm.fListaDeCuponsSelecionados: String;
var
  strSelecionados: String;
  strDocCup: String;
begin
  cdsCppGer.First;

  While (Not cdsCppGer.Eof) Do
  Begin
    If (cdsCppGer.FieldByName('IMPRIMIR').AsInteger = 1) And (cdsCppGer.FieldByName('IMPRESSO').AsString <> 'N') Then
    Begin
      strDocCup := cdsCppGer.FieldByName('DOCUMENTO').AsString + ': ' +
        IntToStr(cdsCppGer.FieldByName('QUANTIDADE').AsInteger) + ' cupons';

      If (Not fEmptyStr(strSelecionados)) Then
        strSelecionados := strSelecionados + #13;

      strSelecionados := strSelecionados + strDocCup;
    End;

    cdsCppGer.Next;
  End;

  Result := strSelecionados;
end;

function TfrmImpCupProm.fMostraBotaoParaInformarCpfCliente: Boolean;
var
  LCodCli: String;
begin
  Result := False;

  If Not cdsCppGer.Active Then
    Exit;

  If cdsCppGer.RecordCount <= 0 Then
    Exit;

  If cdsCppGer.RecNo <= 0 Then
    Exit;

  If Not fCfgSis('CLICFJ', varBoolean) Then
    Exit;

  LCodCli := Copy(cdsCppGer.FieldByName('CLIENTE').AsString, 1, 8);

  If fClientePessoaFisica(LCodCli) and (not fClienteConsumidor(fRetNomCliente(LCodCli), True, False)) Then
    Exit;

  Result := True;
end;

procedure TfrmImpCupProm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  pLimparFiltros;
end;

procedure TfrmImpCupProm.FormCreate(Sender: TObject);
var
  LAnalitico: Boolean;
begin
  inherited;

  objControleCupomPromocao := TControleCupomPromocao.Create;
  cdsCppGer.CreateDataSet;

  LAnalitico := SameText(fCfgSis('IMPCPR'), 'A');

  fFindColumnByName(dbgCupons, 'CLICPF').Visible     := fCfgSis('CLICFJ', varBoolean);
  fFindColumnByName(dbgCupons, 'QUANTIDADE').Visible := (not LAnalitico);
  fFindColumnByName(dbgCupons, 'CUPOM').Visible      := LAnalitico;
  fFindColumnByName(dbgCupons, 'SEQPRO').Visible     := LAnalitico;

  lblEditavel.Visible := (not LAnalitico);
  shpEditavel.Visible := (not LAnalitico);

  pSetFocus(edtNumDoc);
end;

procedure TfrmImpCupProm.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(objControleCupomPromocao) then
    FreeAndNil(objControleCupomPromocao);
end;

procedure TfrmImpCupProm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_ESCAPE: Close;
    VK_F5    : btnMarcarTodos.Click;
    VK_F6    : btnDesmarcarTodos.Click;
    VK_F7    : btnInfCliente.Click;
    VK_F10   : btnConfirmar.Click;
    VK_DOWN  :
      begin
        if (dbgCupons.DataSource.DataSet.RecNo = dbgCupons.DataSource.DataSet.RecordCount) then
          Key := 0;
      end;
    VK_INSERT: Key := 0;
  end;
end;

function TfrmImpCupProm.fRetTipoImpressoFiltro: String;
begin
  case rdgCupom.ItemIndex of
    0: Result := 'T';
    1: Result := 'S';
    2: Result := 'N';
  end;
end;

function TfrmImpCupProm.fTemMaisDeUmDocSelecionado(ADataSet: TUniClientDataSet): Boolean;
var
  LDoc: String;
begin
  Result := False;

  ADataSet.Filtered := False;
  ADataSet.Filter := 'IMPRIMIR = 1';
  ADataSet.Filtered := True;

  if ADataSet.IsEmpty then
    Exit;

  ADataSet.First;
  LDoc := cdsCppGer.FieldByName('DOCUMENTO').AsString;

  while not ADataSet.Eof do
  begin
    if (LDoc <> ADataSet.FieldByName('DOCUMENTO').AsString) then
      Exit(True);

    ADataSet.Next;
  end;
end;

function TfrmImpCupProm.fTravaCupomPessoaJuridica(
  ACupons: TUniClientDataSet): Boolean;
begin
  Result := False;

  if not fCfgSis('CLICFJ', varBoolean) then
    Exit;

  ACupons.First;

  while not ACupons.Eof do
  begin
    if fClientePessoaFisica(Copy(ACupons.FieldByName('CLIENTE').AsString, 1, 8)) Then
    begin
      ACupons.Next;
      Continue;
    end;

    if fEmptyStr(cdsCppGer.FieldByName('CLICPF').AsString) then
      Exit(True);

    ACupons.Next;
  end;
end;

function TfrmImpCupProm.fTravarUsoDeCliente: Boolean;
const
  TABELA = 'CPPGER';
var
  strAutIncCli: String;
begin
  Result := False;

  strAutIncCli :=  fRetornaInformacaoDeCliente('AUTOINCREM', edtCodCli.Text);

  If (Not fLock_Unlock(TABELA + strAutIncCli, True, False)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Este cliente está sendo utilizado por outra '+
      'estação: '+ fGetHostLock(TABELA + strAutIncCli), ['&Ok']);

    edtCodCli.Text := '';
    edtNomCli.Text := '';

    pSetFocus(edtCodCli);
    Exit;
  End;

  Result := True;
end;

function TfrmImpCupProm.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodCli) Then
  Begin
    If (fEmptyStr(edtNomCli.Text)) Then
    Begin
      fMensagem('AVISO','Código do cliente deve ser preenchido.', ['&OK']);
      Result := False;
    End
    Else If (fEmptyStr(edtNomCli.Text)) And (Not fEmptyStr(edtCodCli.Text)) Then
    Begin
      fMensagem('AVISO','Código do cliente não encontrado.', ['&OK']);
      Result := False;
      edtCodCli.Text := '';
    End;
  End

  else if (Sender = edtCodPro) then
  Begin
    if (fEmptyStr(edtDesPro.Text)) and (not fEmptyStr(edtCodPro.Text)) then
    begin
      fMensagem('AVISO','Código da promoção não encontrado.', ['&OK']);
      Result := False;
      edtCodPro.Text := '';
    end;
  end

  Else If (Sender = dtaIni) Then
  Begin
    If fValidarData(dtaFin.Text) and (StrToDateDef(dtaIni.Text, 0) = 0) Then
    Begin
      fMensagem('AVISO', 'Informe uma data inicial válida!', ['&Ok']);
      dtaIni.Clear;
      Result := False;
    End;
  End

  Else If (Sender = dtaFin) Then
  Begin
    If fValidarData(dtaIni.Text) and (StrToDateDef(dtaFin.Text, 0) = 0) Then
    Begin
      fMensagem('AVISO', 'Informe uma data final válida!', ['&Ok']);
      dtaFin.Clear;
      Result := False;
    End;
  End;

  If (Result) Then
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(dtaIni.Text))) And
       (Not fEmptyStr(fTiraCaracEspeciais(dtaFin.Text))) Then
    Begin
      If (StrToDateDef(dtaIni.Text, 0) > StrToDateDef(dtaFin.Text, 0)) Then
      Begin
        fMensagem('', 'A Data Inicial deve ser menor que a Data Final!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmImpCupProm.pAtualizaCliCPF(ADocumento, ACliCpf: String);
begin
  cdsCppGer.DisableControls;

  cdsCppGer.First;

  while not cdsCppGer.Eof do
  begin
    if (cdsCppGer.FieldByName('DOCUMENTO').AsString <> ADocumento) then
    begin
      cdsCppGer.Next;
      Continue;
    end;

    cdsCppGer.Edit;
    cdsCppGer.FieldByName('CLICPF').AsString := Concat(ACliCpf, '-', fRetNomCliente(ACliCpf));
    cdsCppGer.Post;

    cdsCppGer.Next;
  end;

  cdsCppGer.EnableControls;
end;

procedure TfrmImpCupProm.pCarregaCupons;
begin
  If (Not fTravarUsoDeCliente) Then
    Exit;

  try
    cdsCppGer.BeforePost := nil;

    pHabilitaDesabilitaFiltros(False);
    SelectNext(ActiveControl, True, True);

    objControleCupomPromocao.pCarregaCDSReimpressao(cdsCppGer, edtNumDoc.Text,
      edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text, dtaIni.Text, dtaFin.Text, fRetTipoImpressoFiltro, edtCodPro.Text);

    TNumericField(cdsCppGer.FieldByName('VALOR')).DisplayFormat := fMskDigitos(2);

    cdsCppGer.First;

    If (cdsCppGer.RecordCount <= 0) Then
    Begin
      fMensagem('AVISO', 'Sem dados para exibir.', ['&OK']);
      pLimparFiltros;
    End;
  finally
    cdsCppGer.BeforePost := cdsCppGerBeforePost;
  end;
end;

procedure TfrmImpCupProm.pGravaCliCpf(strCliCpf: String);
var
  qryCliCpf: TUniQuery;
  strNumDoc,
  strEspDoc,
  strCodEmp,
  strCodCli,
  LDoc: String;
  LDocPos: Boolean;
  LDados: TUniClientDataSet;
begin
  if fEmptyStr(strCliCpf) then
    Exit;

  if not cdsCppGer.Active then
    Exit;

  if cdsCppGer.RecordCount <= 0 then
    Exit;

  if cdsCppGer.RecNo <= 0 then
    Exit;

  qryCliCpf := fCriaQuery;
  LDados := TUniClientDataSet.Create(Self);

  try
    try
      LDocPos := True;
      pCloneDataSet(LDados, cdsCppGer);

      if fTemMaisDeUmDocSelecionado(LDados) then
        LDocPos := (fGetMenu('Informar Cliente', ['Documento posicionado', 'Documentos selecionados'], 1) = 1);

      fStartTransaction;

      qryCliCpf.SQL.Add('UPDATE CPPGER');
      qryCliCpf.SQL.Add('SET CPG_CLICPF = :CLICPF');
      qryCliCpf.SQL.Add('WHERE CPG_NUMDOC = :NUMDOC');
      qryCliCpf.SQL.Add('AND CPG_ESPDOC = :ESPDOC');
      qryCliCpf.SQL.Add('AND CPG_CODEMP = :CODEMP');
      qryCliCpf.SQL.Add('AND CPG_CODCLI = :CODCLI');

      if LDocPos then
      begin
        strNumDoc := Copy(cdsCppGer.FieldByName('DOCUMENTO').AsString, 1, 12);
        strEspDoc := Copy(cdsCppGer.FieldByName('DOCUMENTO').AsString, 14, 2);
        strCodEmp := Copy(cdsCppGer.FieldByName('DOCUMENTO').AsString, 17, 3);
        strCodCli := Copy(cdsCppGer.FieldByName('CLIENTE').AsString, 1, 8);

        qryCliCpf.Close;
        qryCliCpf.ParamByName('CLICPF').AsString := strCliCpf;
        qryCliCpf.ParamByName('NUMDOC').AsString := strNumDoc;
        qryCliCpf.ParamByName('ESPDOC').AsString := strEspDoc;
        qryCliCpf.ParamByName('CODEMP').AsString := strCodEmp;
        qryCliCpf.ParamByName('CODCLI').AsString := strCodCli;
        qryCliCpf.ExecSQL;

        pAtualizaCliCPF(cdsCppGer.FieldByName('DOCUMENTO').AsString, strCliCpf);
      end
      else
      begin
        LDados.IndexFieldNames := 'DOCUMENTO';
        LDados.First;
        LDoc := '';

        while not LDados.Eof do
        begin
          if (LDoc = LDados.FieldByName('DOCUMENTO').AsString) then
          begin
            LDados.Next;
            Continue;
          end;

          strNumDoc := Copy(LDados.FieldByName('DOCUMENTO').AsString, 1, 12);
          strEspDoc := Copy(LDados.FieldByName('DOCUMENTO').AsString, 14, 2);
          strCodEmp := Copy(LDados.FieldByName('DOCUMENTO').AsString, 17, 3);
          strCodCli := Copy(LDados.FieldByName('CLIENTE').AsString, 1, 8);

          qryCliCpf.Close;
          qryCliCpf.ParamByName('CLICPF').AsString := strCliCpf;
          qryCliCpf.ParamByName('NUMDOC').AsString := strNumDoc;
          qryCliCpf.ParamByName('ESPDOC').AsString := strEspDoc;
          qryCliCpf.ParamByName('CODEMP').AsString := strCodEmp;
          qryCliCpf.ParamByName('CODCLI').AsString := strCodCli;
          qryCliCpf.ExecSQL;

          pAtualizaCliCPF(LDados.FieldByName('DOCUMENTO').AsString, strCliCpf);

          LDoc := LDados.FieldByName('DOCUMENTO').AsString;
          LDados.Next;
        end;
      end;

      fCommit;
    except
      on E: Exception do
      begin
        fRollBack;
        pMensagensErro(E.Message, '[CupomPromocao.Reimpressao.pGravaCliCpf]');
      end;
    end;
  finally
    FreeAndNil(qryCliCpf);
    FreeAndNil(LDados);
  end;
end;

procedure TfrmImpCupProm.pHabilitaDesabilitaFiltros(blnHabilitar: Boolean);
var
  intIndex: Integer;
begin
  For intIndex := 0 To pnlFiltros.ControlCount -1 Do
  Begin
    If (pnlFiltros.Controls[intIndex] Is TEditFocus) Then
      (pnlFiltros.Controls[intIndex] As TEditFocus).Enabled := blnHabilitar;

    If (pnlFiltros.Controls[intIndex] Is TcxDateEdit) Then
      (pnlFiltros.Controls[intIndex] As TcxDateEdit).Enabled := blnHabilitar;
  End;

  btnConsultar.Enabled := blnHabilitar;
  edtNomCli.Enabled := False;
  edtDesPro.Enabled := False;
end;

procedure TfrmImpCupProm.pImprimeCupons;
var
  cdsClone: TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Nil);
  try
    Try
      pCloneDataSet(cdsClone, cdsCppGer);

      cdsClone.Filtered := False;
      cdsClone.Filter := '(IMPRIMIR = 1) AND (IMPRESSO <> ''N'') ';
      cdsClone.Filtered := True;

      if cdsClone.RecordCount > 0 then
      begin
        If (Not fImpressaoLiberada) Then
          Exit;
      end;

      cdsClone.Filtered := False;
      cdsClone.Filter := 'IMPRIMIR = 1';
      cdsClone.Filtered := True;

      if (cdsClone.RecordCount = 0) then
      begin
        fMensagem('', 'Não há documentos selecionados!', ['&Ok']);
        Exit;
      end;

      if (fTravaCupomPessoaJuridica(cdsClone)) then
      begin
        fMensagem('AVISO', 'Há cupons selecionados que não foram informados o Cliente pessoa física. Informe para continuar.', ['&OK']);
        Exit;
      end;

      objControleCupomPromocao.pImprimeColecaoDeCupons(cdsClone);
      pLimparFiltros;
    Finally
      FreeAndNil(cdsClone);
    End;
  except
  end;
end;

procedure TfrmImpCupProm.pInformaPessoaFisica;
var
  frmDigCliente: TfrmDigCliente;
begin
  pCriarFormularios(TfrmDigCliente, frmDigCliente);

  try
    frmDigCliente.blnSomentePessoaFisica := True;

    If frmDigCliente.ShowModal = mrOk Then
      pGravaCliCpf(frmDigCliente.edtCodCli.Text);
  finally
    pFreeAndNil(frmDigCliente);
  end;
end;

procedure TfrmImpCupProm.pLiberarUsoDeCliente;
const
  TABELA = 'CPPGER';
var
  strAutIncCli: String;
begin
  strAutIncCli :=  fRetornaInformacaoDeCliente('AUTOINCREM', edtCodCli.Text);
  fLock_Unlock(TABELA + strAutIncCli, False);
end;

procedure TfrmImpCupProm.pLimparFiltros;
var
  intIndex: Integer;
begin
  pLiberarUsoDeCliente;

  For intIndex := 0 To pnlFiltros.ControlCount -1 Do
  Begin
    If (pnlFiltros.Controls[intIndex] Is TEditFocus) Then
      (pnlFiltros.Controls[intIndex] As TEditFocus).Text := ''
    Else If (pnlFiltros.Controls[intIndex] Is TcxDateEdit) Then
      (pnlFiltros.Controls[intIndex] As TcxDateEdit).Clear;
  End;

  rdgCupom.ItemIndex := 0;

  cdsCppGer.EmptyDataSet;

  pHabilitaDesabilitaFiltros(True);
  pSetFocus(edtNumDoc);
end;

procedure TfrmImpCupProm.pMarcaDesmarcaRegistro;
var
  blnMarcado: Boolean;
begin
  blnMarcado := cdsCppGer.FieldByName('IMPRIMIR').AsInteger = 1;

  cdsCppGer.Edit;
  cdsCppGer.FieldByName('IMPRIMIR').AsInteger := IIF(blnMarcado, 0, 1);
  cdsCppGer.Post;
end;

procedure TfrmImpCupProm.pMarcaDesmarcaTodos(AMarcar: Boolean);
begin
  if (cdsCppGer.RecordCount <= 0) then
    Exit;

  if (fMensagem('Atenção', 'Deseja ' + IIF(AMarcar, 'marcar', 'desmarcar') + ' todos os registros?', ['&Sim', '&Não']) = 2) then
    Exit;

  cdsCppGer.DisableControls;

  cdsCppGer.First;

  while not cdsCppGer.Eof do
  begin
    cdsCppGer.Edit;
    cdsCppGer.FieldByName('IMPRIMIR').AsInteger := IIF(AMarcar, 1, 0);
    cdsCppGer.Post;

    cdsCppGer.Next;
  end;

  cdsCppGer.First;
  cdsCppGer.EnableControls;
end;

procedure TfrmImpCupProm.pPreencheCliente(blnComCodigo: Boolean);
begin
  If (blnComCodigo) Then
  Begin
    edtCodCli.Text := fRetornarClienteDocumento(edtNumDoc.Text, edtEspDoc.Text,
      edtCodEmp.Text);
  End;

  If (Not fEmptyStr(edtCodCli.Text)) Then
  Begin
    edtCodCli.Text := fStrZero(edtCodCli.Text, 8);
    edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
  End;
end;

end.