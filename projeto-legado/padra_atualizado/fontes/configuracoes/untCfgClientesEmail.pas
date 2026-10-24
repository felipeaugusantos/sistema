unit untCfgClientesEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus,
  untTypesSistema, Vcl.Mask, MaskEditFocus, Uni, UniClientDataSet,
  UniDataSetProvider, cxProgressBar;

type
  TfrmCfgClientesEmail = class(TfrmPaiConfirma)
    pnlHeader: TPanel;
    pnlAddRemove: TPanel;
    btnAdicionaCliente: TSpeedButton;
    btnRemoveCliente: TSpeedButton;
    lblCliente: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    lblAtividade: TLabel;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    lblRegiao: TLabel;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    mskCgcCpf: TMaskEditFocus;
    lblCnpjCpf: TLabel;
    btnCarrClientes: TBitBtnLocked;
    dtsConsulta: TDataSource;
    dtsClientes: TDataSource;
    Splitter1: TSplitter;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    pnlPesquisa: TPanel;
    cxGrdPesquisa: TcxGridCitel;
    cxGrdPesquisaLevel: TcxGridLevel;
    cxGrdPesquisaTableView: TcxGridDBTableViewCitel;
    cxGrdPesquisaTableViewCLI_MARDES: TcxGridDBColumn;
    cxGrdPesquisaTableViewCLI_CODCLI: TcxGridDBColumn;
    cxGrdPesquisaTableViewCLI_NOMCLI: TcxGridDBColumn;
    cxGrdPesquisaTableViewCLI_C_G_C_: TcxGridDBColumn;
    cxGrdPesquisaTableViewATIVIDADE: TcxGridDBColumn;
    cxGrdPesquisaTableViewREGIAO: TcxGridDBColumn;
    pnlClientes: TPanel;
    cxGrdClientes: TcxGridCitel;
    cxGrdClientesLevel: TcxGridLevel;
    cxGrdClientesTableView: TcxGridDBTableViewCitel;
    cxGrdClientesTableViewCLI_CODCLI: TcxGridDBColumn;
    cxGrdClientesTableViewCLI_NOMCLI: TcxGridDBColumn;
    cxGrdClientesTableViewCLI_C_G_C_: TcxGridDBColumn;
    cxGrdClientesTableViewATIVIDADE: TcxGridDBColumn;
    cxGrdClientesTableViewREGIAO: TcxGridDBColumn;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormResize(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure mskCgcCpfChange(Sender: TObject);
    procedure btnCarrClientesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGrdPesquisaTableViewCLI_C_G_C_GetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure cxGrdPesquisaTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrdPesquisaTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGrdPesquisaTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnAdicionaClienteClick(Sender: TObject);
    procedure btnRemoveClienteClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxGrdClientesTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    arrConsulta: TConsultasArray;
    cdsConsulta,
    cdsClientes: TUniClientDataSet;

    procedure pAtualizaTemporaria;
    procedure pSelecionaCliente;
    procedure pMarcaCliente(blnMarcar: Boolean);
    function  fDesmarcarTodos(pgbProgresso: TcxProgressBar): Boolean;
    function  fMarcarTodos(pgbProgresso: TcxProgressBar): Boolean;
    function  fAdicionaClientes(pgbProgresso: TcxProgressBar): Boolean;
    procedure pCriaDataSetClientes;
    procedure pLoadClientes;
    procedure pEfetivaDados;
  public
    { Public declarations }
    strSeqGer: String;
    strCodGru: String;
  protected
    { Protected declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untConsultas, untFuncoesSimples, untGravando, untFuncoesGenerica;

{$R *.dfm}

procedure TfrmCfgClientesEmail.btnAdicionaClienteClick(Sender: TObject);
begin
  inherited;
  If Not cdsConsulta.Active Then
    Exit;

  If Not cdsConsulta.Locate('CLI_MARDES', 'M', []) Then
  Begin
    fMensagem('', 'Nenhum Cliente marcado!', ['&OK']);
    pSetFocus(cxGrdPesquisa);
    Exit;
  End;

  pCriarFormularios(TfrmGravando,frmGravando);
  Try
    frmGravando.fExecutarAcao := fAdicionaClientes;
    frmGravando.lblGravando.Caption := 'Aguarde... Adicionando Clientes.';
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmCfgClientesEmail.btnCarrClientesClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos  Then
    Exit;

  TfrmGravando.fExecutarModal(pAtualizaTemporaria, 'Aguarde... Carregando Clientes', '');
  cxGrdPesquisaTableView.DataController.Filter.Clear;

  If cdsConsulta.RecordCount > 0 Then
  Begin
    cdsConsulta.First;
    pSetFocus(cxGrdPesquisa);
  End
  Else
    pSetFocus(edtCodCli);
end;

procedure TfrmCfgClientesEmail.btnConfirmaClick(Sender: TObject);
begin
  Try
    fStartTransaction;

    pEfetivaDados;

    fCommit;

    pMensagemOK('Dados gravados com sucesso!');

    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro('Ocorreu um erro ao gravar os clientes. Erro gerado: ' + E.Message, '[untCfgClientesEmail.btnConfirmaClick]');
    End;
  End;
end;

procedure TfrmCfgClientesEmail.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  If Not cdsConsulta.Active Then
    Exit;
  If Not cdsConsulta.Locate('CLI_MARDES', 'M', []) Then
    Exit;
  pCriarFormularios(TfrmGravando,frmGravando);
  Try
    frmGravando.fExecutarAcao := fDesmarcarTodos;
    frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando Clientes.';
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmCfgClientesEmail.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  If Not cdsConsulta.Active Then
    Exit;
  If Not cdsConsulta.Locate('CLI_MARDES', 'D', []) Then
    Exit;
  pCriarFormularios(TfrmGravando,frmGravando);
  Try
    frmGravando.fExecutarAcao := fMarcarTodos;
    frmGravando.lblGravando.Caption := 'Aguarde... Marcando Clientes.';
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmCfgClientesEmail.btnRemoveClienteClick(Sender: TObject);
begin
  inherited;
  With cdsClientes Do
  Begin
    If Not IsEmpty Then
    Begin
      If FieldByName('AUTOINCREM').IsNull then
        Delete
      Else
      Begin
        Edit;
        FieldByName('STATUS').AsInteger := 3; //excluído
        Post;
      End;
    End;
  End;
end;

procedure TfrmCfgClientesEmail.cxGrdClientesTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_DELETE Then
    btnRemoveClienteClick(Sender);
end;

procedure TfrmCfgClientesEmail.cxGrdPesquisaTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pSelecionaCliente;
end;

procedure TfrmCfgClientesEmail.cxGrdPesquisaTableViewCLI_C_G_C_GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := fFormataCpfCgc(AText, fSetaPais);
end;

procedure TfrmCfgClientesEmail.cxGrdPesquisaTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  With cdsConsulta Do
  Begin
    If Not Active Then
      Exit;

    If VarToStr(AViewInfo.GridRecord.Values[cxGrdPesquisaTableViewCLI_MARDES.Index]) = 'M' Then
    Begin
      If AViewInfo.Selected Then
        ACanvas.Font.Color := clLime
      Else
        ACanvas.Font.Color := clBlue;
    End;
  End;
end;

procedure TfrmCfgClientesEmail.cxGrdPesquisaTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    pSelecionaCliente;
end;

procedure TfrmCfgClientesEmail.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrConsulta) Then
  Begin
    If fValidaCampos(edtCodAti, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCfgClientesEmail.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrConsulta) Then
  Begin
    If fValidaCampos(edtCodCli, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCfgClientesEmail.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrConsulta) Then
  Begin
    If fValidaCampos(edtCodReg, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCfgClientesEmail.fAdicionaClientes(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;
  cxGrdPesquisaTableView.BeginUpdate;
  cxGrdClientesTableView.BeginUpdate;
  cdsConsulta.DisableControls;
  cdsClientes.DisableControls;
  Try
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter   := 'CLI_MARDES = ''M''';
    cdsConsulta.Filtered := True;

    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      pProgresso(cdsConsulta.RecNo, cdsConsulta.RecordCount, pgbProgresso);

      If Not cdsClientes.Locate('CLI_CODCLI', cdsConsulta.FieldByName('CLI_CODCLI').AsString, []) Then
      Begin
        cdsClientes.Append;
        cdsClientes.FieldByName('CLI_CODCLI').AsString := cdsConsulta.FieldByName('CLI_CODCLI').AsString;
        cdsClientes.FieldByName('CLI_NOMCLI').AsString := cdsConsulta.FieldByName('CLI_NOMCLI').AsString;
        cdsClientes.FieldByName('CLI_C_G_C_').AsString := cdsConsulta.FieldByName('CLI_C_G_C_').AsString;
        cdsClientes.FieldByName('ATIVIDADE').AsString  := cdsConsulta.FieldByName('ATIVIDADE').AsString;
        cdsClientes.FieldByName('REGIAO').AsString     := cdsConsulta.FieldByName('REGIAO').AsString;
        cdsClientes.FieldByName('STATUS').AsInteger    := 1; //incluído
        cdsClientes.Post;
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.Filtered := False;
    cdsConsulta.EnableControls;
    cdsClientes.EnableControls;
    cxGrdPesquisaTableView.EndUpdate;
    cxGrdClientesTableView.EndUpdate;
    cxGrdClientesTableView.ApplyBestFit;
  End;
end;

function TfrmCfgClientesEmail.fDesmarcarTodos(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;
  With cdsConsulta Do
  Begin
    cxGrdPesquisaTableView.BeginUpdate;
    DisableControls;
    Try
      First;
      While Not Eof Do
      Begin
        pProgresso(RecNo, RecordCount, pgbProgresso);
        pMarcaCliente(False);
        Next;
      End;
      First;
    Finally
      EnableControls;
      cxGrdPesquisaTableView.EndUpdate;
    End;
  End;
end;

function TfrmCfgClientesEmail.fMarcarTodos(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;
  With cdsConsulta Do
  Begin
    cxGrdPesquisaTableView.BeginUpdate;
    DisableControls;
    Try
      First;
      While Not Eof Do
      Begin
        pProgresso(RecNo, RecordCount, pgbProgresso);
        pMarcaCliente(True);
        Next;
      End;
      First;
    Finally
      EnableControls;
      cxGrdPesquisaTableView.EndUpdate;
    End;
  End;
end;

procedure TfrmCfgClientesEmail.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsConsulta);
  FreeAndNil(cdsClientes);
end;

procedure TfrmCfgClientesEmail.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If ModalResult <> mrOk Then
    CanClose := fMensagem('ATENÇÃO', 'Deseja realmente cancelar?', ['Sim', 'Não']) = 1;
end;

procedure TfrmCfgClientesEmail.FormCreate(Sender: TObject);
begin
  inherited;
  cdsConsulta := TUniClientDataSet.Create(Self);
  dtsConsulta.DataSet := cdsConsulta;

  pCriaDataSetClientes;
  dtsClientes.DataSet := cdsClientes;
end;

procedure TfrmCfgClientesEmail.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_F7: btnMarcaTodos.Click;
    VK_F8: btnDesmarcaTodos.Click;

    Else inherited;
  End;
end;

procedure TfrmCfgClientesEmail.FormResize(Sender: TObject);
begin
  inherited;
  pnlPesquisa.Width := (Self.ClientWidth div 2) - (pnlAddRemove.Width div 2);
end;

procedure TfrmCfgClientesEmail.FormShow(Sender: TObject);
begin
  inherited;
  pLoadClientes;
end;

function TfrmCfgClientesEmail.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodCli) Then
    Begin
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
        mskCgcCpf.Text := fRetCgcCpf(edtCodCli.Text);

        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtNomCli.Text := 'TODOS';
        mskCgcCpf.Clear;
      End;
    End

    Else If (Sender = edtCodAti) Then
    Begin
      If Not fEmptyStr(edtCodAti.Text) Then
      Begin
        edtDesAti.Text := fRetNomAtividade(edtCodAti.Text);

        If fEmptyStr(edtDesAti.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Atividade não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesAti.Text := 'TODAS';
      End;
    End

    Else If (Sender = edtCodReg) Then
    Begin
      If Not fEmptyStr(edtCodReg.Text) Then
      Begin
        edtDesReg.Text := fRetNomRegiao(edtCodReg.Text);

        If fEmptyStr(edtDesReg.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Região não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesReg.Text := 'TODAS';
      End;
    End
  End;
end;

procedure TfrmCfgClientesEmail.mskCgcCpfChange(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(TMaskEditFocus(Sender).Text) Then
    TMaskEditFocus(Sender).EditMask := fRetMascaraC_G_C_(fSetaPais, fSetaCgcCpf(IIF(Length(TMaskEditFocus(Sender).Text) = 14, '1', '2')))
  Else
    TMaskEditFocus(Sender).EditMask := '';
end;

procedure TfrmCfgClientesEmail.pAtualizaTemporaria;
  Var
    strSQL: String;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
begin
  cdsConsulta.Close;
  qryConsulta := fCriaQuery(Self);
  dspConsulta := TUniDataSetProvider.Create(Self);
  dspConsulta.DataSet := qryConsulta;
  cdsConsulta.SetProvider(dspConsulta);

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT "D" AS CLI_MARDES, ';
    strSQL := strSQL + '       CLI_CODCLI, ';
    strSQL := strSQL + '       CLI_NOMCLI, ';
    strSQL := strSQL + '       CLI_C_G_C_, ';
    strSQL := strSQL + '       CONCAT(ATI_CODATI,'' - '',ATI_DESATI) ATIVIDADE, ';
    strSQL := strSQL + '       CONCAT(REG_CODREG,'' - '',REG_DESREG) REGIAO ';
    strSQL := strSQL + 'FROM CADCLI ';
    strSQL := strSQL + 'LEFT JOIN CADATI ON (ATI_CODATI = CLI_CODATI) ';
    strSQL := strSQL + 'LEFT JOIN CADREG ON (REG_CODREG = CLI_CODREG) ';
    strSQL := strSQL + 'WHERE TRUE ';

    If Not fEmptyStr(edtCodCli.Text) Then
      strSQL := strSQL + 'AND CLI_CODCLI = ' + QuotedStr(edtCodCli.Text);

    If Not fEmptyStr(edtCodAti.Text) Then
      strSQL := strSQL + 'AND ATI_CODATI = ' + QuotedStr(edtCodAti.Text);

    If Not fEmptyStr(edtCodReg.Text) Then
      strSQL := strSQL + 'AND REG_CODREG = ' + QuotedStr(edtCodReg.Text);

    strSQL := strSQL + 'ORDER BY CLI_NOMCLI';

    qryConsulta.SQL.Add(strSQL);
    qryConsulta.Open;

    pSetaClient(qryConsulta);
    cdsConsulta.Open;
    cdsConsulta.LogChanges := False;

    cxGrdPesquisaTableView.ApplyBestFit;
  Finally
    cdsConsulta.SetProvider(nil);
    FreeAndNil(qryConsulta);
    FreeAndNil(dspConsulta);
  End;
end;

procedure TfrmCfgClientesEmail.pCriaDataSetClientes;
  procedure pCriaCampo(Nome: String; Tipo: TFieldType; Tamanho: Integer = 0);
  begin
    With cdsClientes.FieldDefs.AddFieldDef Do
    Begin
      Name     := Nome;
      DataType := Tipo;
      Size     := Tamanho;
      Required := False;
    End;
  end;
begin
  cdsClientes := TUniClientDataSet.Create(Self);

  pCriaCampo('AUTOINCREM', ftString, 20);
  pCriaCampo('CLI_CODCLI', ftString, 8);
  pCriaCampo('CLI_NOMCLI', ftString, 60);
  pCriaCampo('CLI_C_G_C_', ftString, 18);
  pCriaCampo('ATIVIDADE',  ftString, 80);
  pCriaCampo('REGIAO',     ftString, 80);
  pCriaCampo('STATUS',     ftInteger); //1-incluído; 2-alterado; 3-excluído

  cdsClientes.CreateDataSet;
  cdsClientes.LogChanges := False;
  cdsClientes.IndexFieldNames := 'CLI_NOMCLI';

  cdsClientes.Filter := 'STATUS <> 3';
  cdsClientes.Filtered := True;
end;

procedure TfrmCfgClientesEmail.pEfetivaDados;
  Var
    qryInsert, qryDelete: TUniQuery;
begin
  qryInsert := fCriaQuery(Self);
  qryDelete := fCriaQuery(Self);
  With cdsClientes Do
  Begin
    Try
      DisableControls;

      Filtered := False;

      qryInsert.SQL.Add('REPLACE INTO CLINEN(AUTOINCREM, NEN_CODGRU, NEN_CODIGO, NEN_CODCLI)');
      qryInsert.SQL.Add('VALUES(:AUTOINCREM, :NEN_CODGRU, :NEN_CODIGO, :NEN_CODCLI)');

      qryDelete.SQL.Add('DELETE FROM CLINEN');
      qryDelete.SQL.Add('WHERE NEN_CODGRU = :NEN_CODGRU');
      qryDelete.SQL.Add('AND NEN_CODIGO = :NEN_CODIGO');
      qryDelete.SQL.Add('AND NEN_CODCLI = :NEN_CODCLI');

      First;
      While Not Eof Do
      Begin
        If FieldByName('STATUS').AsInteger = 1 Then //incluído
        Begin
          qryInsert.Close;
          qryInsert.Params[0].AsString := fRetAutoIncrem('CLINEN', VS_strCodEmp);
          qryInsert.Params[1].AsString := strCodGru;
          qryInsert.Params[2].AsString := strSeqGer;
          qryInsert.Params[3].AsString := FieldByName('CLI_CODCLI').AsString;
          qryInsert.Execute;
        End
        Else If FieldByName('STATUS').AsInteger = 3 Then //excluído
        Begin
          qryDelete.Close;
          qryDelete.Params[0].AsString := strCodGru;
          qryDelete.Params[1].AsString := strSeqGer;
          qryDelete.Params[2].AsString := FieldByName('CLI_CODCLI').AsString;
          qryDelete.Execute;
        End;

        Next;
      End;
    Finally
      Filtered := True;
      EnableControls;
      FreeAndNil(qryInsert);
      FreeAndNil(qryDelete);
    End;
  End;
end;

procedure TfrmCfgClientesEmail.pLoadClientes;
  Var
    qryConfig: TUniQuery;
    objField: TField;
begin
  qryConfig := fCriaQuery(Self);

  Try
    cdsClientes.DisableControls;

    qryConfig.SQL.Add('SELECT CLINEN.AUTOINCREM,');
    qryConfig.SQL.Add('       CLI_CODCLI,');
    qryConfig.SQL.Add('       CLI_NOMCLI,');
    qryConfig.SQL.Add('       CLI_C_G_C_,');
    qryConfig.SQL.Add('       CONCAT(ATI_CODATI,'' - '',ATI_DESATI) ATIVIDADE,');
    qryConfig.SQL.Add('       CONCAT(REG_CODREG,'' - '',REG_DESREG) REGIAO,');
    qryConfig.SQL.Add('       0 AS STATUS');
    qryConfig.SQL.Add('FROM CLINEN');
    qryConfig.SQL.Add('JOIN CADCLI ON (CLI_CODCLI = NEN_CODCLI)');
    qryConfig.SQL.Add('LEFT JOIN CADATI ON (ATI_CODATI = CLI_CODATI)');
    qryConfig.SQL.Add('LEFT JOIN CADREG ON (REG_CODREG = CLI_CODREG)');
    qryConfig.SQL.Add('WHERE NEN_CODGRU = :NEN_CODGRU');
    qryConfig.SQL.Add('AND NEN_CODIGO = :NEN_CODIGO');
    qryConfig.SQL.Add('ORDER BY CLI_NOMCLI');

    qryConfig.Params[0].AsString := strCodGru;
    qryConfig.Params[1].AsString := strSeqGer;
    qryConfig.Open;

    qryConfig.First;
    While Not qryConfig.Eof Do
    Begin
      cdsClientes.Append;
      For objField In qryConfig.Fields Do
        cdsClientes.FieldByName(objField.FieldName).Value := objField.Value;
      cdsClientes.Post;

      qryConfig.Next;
    End;

    cdsClientes.First;
  Finally
    cdsClientes.EnableControls;
    cxGrdClientesTableView.ApplyBestFit;
    FreeAndNil(qryConfig);
  End;
end;

procedure TfrmCfgClientesEmail.pMarcaCliente(blnMarcar: Boolean);
begin
  With cdsConsulta Do
  Begin
    Edit;
    FieldByName('CLI_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
    Post;
  End;
end;

procedure TfrmCfgClientesEmail.pSelecionaCliente;
begin
  With cdsConsulta Do
    If Active Then
      pMarcaCliente(FieldByName('CLI_MARDES').AsString <> 'M');
end;

end.
