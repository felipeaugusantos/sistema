unit untDigDocumentoEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, untTypesSistema, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, StrUtils, cxButtonEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, UniClientDataSet, cxProgressBar,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, untFuncFat;

Type

  TDocumentoAImportar = Class
  private
    FcdsDocumentos  : TUniClientDataSet;
    FstrDocumentoSelecionado,
    FstrEspecieSelecionada,
    FstrEmpresaSelecionada : String;

    procedure pCriarCdsDocumentos;

  public
    Constructor Create; Reintroduce;
    Destructor Destroy; Override;

    procedure pAdicionarDocumento(AstrIDDocumento, AstrNumeroDocumento, AstrEspecieDocumento, AstrEmpresaDocumento, AstrTabela : String;
      AdatEntrada : TDateTime);
    function fValidarParaCampanhaDeVendas(var AstrMensagem : String) : Boolean;
    function fGetIdDocumentoSelecionados(AstrTabela : String) : String;

    property cdsDocumentos                   : TUniClientDataSet read FcdsDocumentos           write FcdsDocumentos;
    property strDocumentoSelecionado         : string            read FstrDocumentoSelecionado write FstrDocumentoSelecionado;
    property strEspecieSelecionada           : string            read FstrEspecieSelecionada   write FstrEspecieSelecionada;
    property strEmpresaSelecionada           : string            read FstrEmpresaSelecionada   write FstrEmpresaSelecionada;
  End;

type
  TfrmDigDocumentoEmpresa = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    lblCliFor: TLabel;
    edtCodigoCliente: TEditFocus;
    edtNomeCliente: TEditFocus;
    btnPesquisa: TBitBtnLocked;
    Panel2: TPanel;
    rdgPreco: TRadioGroup;
    Panel3: TPanel;
    cxGridCitel1: TcxGridCitel;
    grdDocumentos: TcxGridDBTableViewCitel;
    grdDocumentosColumn1: TcxGridDBColumn;
    grdDocumentosColumn2: TcxGridDBColumn;
    grdDocumentosColumn3: TcxGridDBColumn;
    cxGridCitel1Level1: TcxGridLevel;
    dtsDocumentos: TDataSource;
    grdDocumentosColumn4: TcxGridDBColumn;
    chkAgruparProdutos: TCheckBox;
    grdDocumentosColumn5: TcxGridDBColumn;
    mskDtaIni: TcxDateEdit;
    lblDataInicial: TLabel;
    mskDtaFin: TcxDateEdit;
    lblDataFinal: TLabel;
    btnSelecionarTodos: TBitBtnLocked;
    chkOrdemOriginal: TCheckBox;
    chkZerarPrecoCusto: TCheckBox;
    chkCarregarAmbientes: TCheckBox;
    grdDocumentosVisualizarItens: TcxGridDBColumn;
    cbxForCli: TComboBox;
    Label3: TLabel;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnSelecionarTodosClick(Sender: TObject);
    procedure rdgPrecoClick(Sender: TObject);
    procedure grdDocumentosVisualizarItensPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
    FObjDocumentosAImportar      : TDocumentoAImportar;
    FblnAcessoPelaCampanhaVendas : Boolean;
    FstrIdFATGORSelecionados     : String;
    FstrIdMOVGERSelecionados     : String;
    FstrIdNOTGERSelecionados     : String;
    FblnAgruparItens             : Boolean;
    FblnOrdemOriginal            : Boolean;
    FblnCarregarAmbiente         : Boolean;

    function fValidaPermissaoDeMudancaDeTipoDePreco : Boolean;
    function fCarregarDocumentos(pgbStatus: TcxProgressBar = Nil) : Boolean;
  public
    { Public declarations }
    blnConfirma: Boolean;
    blnTipoPreco: Boolean;
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    blnZerarCustos : Boolean;

    tpPrecoImpItemDefault : TTipoPrecoImpItem;
    tpPrecoImpItem        : TTipoPrecoImpItem;

    objFatVenda : TFatVenda;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

    property blnAcessoPelaCampanhaVendas : Boolean read FblnAcessoPelaCampanhaVendas write FblnAcessoPelaCampanhaVendas;
    property strIdMOVGERSelecionados     : String  read FstrIdMOVGERSelecionados     write FstrIdMOVGERSelecionados;
    property strIdNOTGERRSelecionados    : String  read FstrIdNOTGERSelecionados     write FstrIdNOTGERSelecionados;
    property strIdFATGORSelecionados     : String  read FstrIdFATGORSelecionados     write FstrIdFATGORSelecionados;
    property blnAgruparItens             : Boolean read FblnAgruparItens             write FblnAgruparItens;
    property blnOrdemOriginal            : Boolean read FblnOrdemOriginal            write FblnOrdemOriginal;
    property blnCarregarAmbiente         : Boolean read FblnCarregarAmbiente         write FblnCarregarAmbiente;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, Uni, untGravando, untLiberacao,
  untMsgLiberacao, untItensDocumento;

{ TfrmDigDocumentoEmpresa }

procedure TfrmDigDocumentoEmpresa.btnConfirmaClick(Sender: TObject);
  var
    LstrMensagem : String;
begin

  inherited;

  tpPrecoImpItem := TTipoPrecoImpItem(rdgPreco.ItemIndex);

  If Not fValidaPermissaoDeMudancaDeTipoDePreco Then
    Exit;

  if FblnAcessoPelaCampanhaVendas then
  Begin
    Try
      if not FObjDocumentosAImportar.fValidarParaCampanhaDeVendas(LstrMensagem) then
        abort;
    Except
      on E: Exception do
      begin
        if (E is EAbort) then
        Begin
          fMensagem('', LstrMensagem, ['&Ok']);
          Exit;
        End;
      end;
    End;

    strNumDoc := FObjDocumentosAImportar.strDocumentoSelecionado;
    strEspDoc := FObjDocumentosAImportar.strEspecieSelecionada;
    strCodEmp := FObjDocumentosAImportar.strEmpresaSelecionada;
    blnZerarCustos := chkZerarPrecoCusto.Checked;
  End
  Else
  Begin
    FstrIdFATGORSelecionados := FObjDocumentosAImportar.fGetIdDocumentoSelecionados('FATGOR');
    FstrIdMOVGERSelecionados := FObjDocumentosAImportar.fGetIdDocumentoSelecionados('MOVGER');
    FstrIdNOTGERSelecionados := FObjDocumentosAImportar.fGetIdDocumentoSelecionados('NOTGER');
    FblnAgruparItens         := chkAgruparProdutos.Checked;
    FblnOrdemOriginal        := chkOrdemOriginal.Checked;
    FblnCarregarAmbiente     := chkCarregarAmbientes.Checked;
  End;

  blnConfirma := True;

end;

procedure TfrmDigDocumentoEmpresa.btnPesquisaClick(Sender: TObject);
  var
    frmGravando : TfrmGravando;
begin
  inherited;

  if blnAcessoPelaCampanhaVendas then
  Begin
    if fEmptyStr(edtNumDoc.Text) then
    Begin
      fMensagem('','Favor preencher o número do documento', ['&Ok']);
      Exit;
    End;

    if fEmptyStr(edtEspDoc.Text) then
    Begin
      fMensagem('','Favor preencher a espécie do documento', ['&Ok']);
      Exit;
    End;

    if fEmptyStr(edtCodEmp.Text) then
    Begin
      fMensagem('','Favor preencher a empresa do documento', ['&Ok']);
      Exit;
    End;

  End;


  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao := fCarregarDocumentos;
    frmGravando.ShowModal;

    Self.Repaint;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmGravando);
end;

procedure TfrmDigDocumentoEmpresa.btnSairClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmDigDocumentoEmpresa.btnSelecionarTodosClick(Sender: TObject);
Var
  Posicao : TBookmark;
Const
  CAMPO_SELECAO = 'DOC_CHECKD';
begin

  inherited;

  If dtsDocumentos.DataSet.IsEmpty Then
    Exit;

  dtsDocumentos.DataSet.DisableControls;
  Posicao := dtsDocumentos.DataSet.GetBookmark;

  Try

    dtsDocumentos.DataSet.First;
    While Not dtsDocumentos.DataSet.Eof Do
    Begin

      dtsDocumentos.DataSet.Edit;
      dtsDocumentos.DataSet.FieldByName(CAMPO_SELECAO).AsBoolean := True;
      dtsDocumentos.DataSet.Post;

      dtsDocumentos.DataSet.Next;

    End;

  Finally
    dtsDocumentos.DataSet.EnableControls;
    If dtsDocumentos.DataSet.BookmarkValid(Posicao) Then
      dtsDocumentos.DataSet.GotoBookmark(Posicao);
  End;

end;

procedure TfrmDigDocumentoEmpresa.edtCodigoClienteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  If fPesqCliente(conCliSimples, Self, edtCodigoCliente, edtNomeCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodigoCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmDigDocumentoEmpresa.fCarregarDocumentos(pgbStatus: TcxProgressBar = Nil): Boolean;
  var
    LQuery : TuniQuery;
    Lidx   : Integer;
    LstrPrefixo,
    LstrTabela : String;
    strCampoDtaEnt : String;
begin
  inherited;

  Result := True;

  pInfoStatusGravacao(pgbStatus, 'Aguarde... Buscando Documentos... ');

  FObjDocumentosAImportar.cdsDocumentos.EmptyDataSet;

  pgbStatus.Position := 0;

  LQuery := fCriaQuery;
  Try
    for Lidx := 1 to 3 do
    Begin
      LQuery.sql.Clear;

      if (Lidx = 3) then
        LstrPrefixo := 'FGO_'
      else
        LstrPrefixo := 'GER_';

      if (Lidx = 1) then
        LstrTabela := 'MOVGER'
      else
      if (Lidx = 2) then
        LstrTabela := 'NOTGER'
      else
      if (Lidx = 3) then
        LstrTabela := 'FATGOR';

      LQuery.Sql.Text := 'SELECT AUTOINCREM, '+LstrPrefixo+'NUMDOC, '+LstrPrefixo+'ESPDOC, '+LstrPrefixo+'CODEMP, "'+LstrTabela+'" TABELA, '+
                         LstrPrefixo+'DTAENT '+
                         '  FROM '+LstrTabela+' '+
                         ' WHERE TRUE ';

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And
         Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        strCampoDtaEnt  := LstrPrefixo+'DTAENT';
        LQuery.Sql.Text := LQuery.Sql.Text + '  AND ((' + strCampoDtaEnt + ' >= :DTAINI) AND (' + strCampoDtaEnt + ' <= :DTAFIN))';
        LQuery.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        LQuery.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      End;

      If Pos(LstrTabela, 'MOVGER_NOTGER_') > 0 Then
      Begin
        If Assigned(objFatVenda) And (Pos(objFatVenda.strOpcDoc, 'PD_OR_VN_EP_TE_NE_UC_') > 0) Then
        Begin
          If (cbxForCli.ItemIndex = 0) Then
          Begin
            LQuery.Sql.Text := LQuery.Sql.Text + '  AND ' + LstrPrefixo + 'TIP_FC = ''C''   ';
            LQuery.Sql.Text := LQuery.Sql.Text + '  AND ' + LstrPrefixo + 'ORIDOC = ''V''   ';
          End
          Else
          Begin
            LQuery.Sql.Text := LQuery.Sql.Text + '  AND ' + LstrPrefixo + 'TIP_FC = ''F''   ';
            LQuery.Sql.Text := LQuery.Sql.Text + '  AND ' + LstrPrefixo + 'ORIDOC = ''''    ';
          End
        End
        Else
        Begin
          LQuery.Sql.Text := LQuery.Sql.Text + '  AND ' + LstrPrefixo + 'TIP_FC = ''C''   ';
          LQuery.Sql.Text := LQuery.Sql.Text + '  AND ' + LstrPrefixo + 'ORIDOC = ''V''   ';
        End;
      End;

      if not fEmptyStr(edtNumDoc.Text) then
        LQuery.Sql.Text := LQuery.Sql.Text + ' AND '+LstrPrefixo+'NUMDOC = :NUMDOC ';

      if not fEmptyStr(edtEspDoc.Text) then
        LQuery.Sql.Text := LQuery.Sql.Text + ' AND '+LstrPrefixo+'ESPDOC = :ESPDOC ';

      if not fEmptyStr(edtCodEmp.Text) then
        LQuery.Sql.Text := LQuery.Sql.Text + ' AND '+LstrPrefixo+'CODEMP = :CODEMP ';

      if not fEmptyStr(edtCodigoCliente.Text) then
        LQuery.Sql.Text := LQuery.Sql.Text + ' AND '+LstrPrefixo+'CODCLI = :CODCLI ';

      if not fEmptyStr(edtNumDoc.Text) then
        LQuery.ParamByName('NUMDOC').AsString := edtNumDoc.Text;

      if not fEmptyStr(edtEspDoc.Text) then
        LQuery.ParamByName('ESPDOC').AsString := edtEspDoc.Text;

      if not fEmptyStr(edtCodEmp.Text) then
        LQuery.ParamByName('CODEMP').AsString := edtCodEmp.Text;

      if not fEmptyStr(edtCodigoCliente.Text) then
        LQuery.ParamByName('CODCLI').AsString := edtCodigoCliente.Text;

      LQuery.Open;

      pgbStatus.Properties.Max := LQuery.RecordCount;

      while not LQuery.Eof do
      Begin
        pInfoStatusGravacao(pgbStatus, 'Aguarde... Buscando Documentos ' + FormatFloat('#,##0', LQuery.RecNo) + '/' + FormatFloat('#,##0', LQuery.RecordCount));

        pgbStatus.Position := pgbStatus.Position + 1;

        FObjDocumentosAImportar.pAdicionarDocumento(LQuery.FieldByName('AUTOINCREM').AsString,
                                                    LQuery.FieldByName(LstrPrefixo+'NUMDOC').AsString,
                                                    LQuery.FieldByName(LstrPrefixo+'ESPDOC').AsString,
                                                    LQuery.FieldByName(LstrPrefixo+'CODEMP').AsString,
                                                    LQuery.FieldByName('TABELA').AsString,
                                                    LQuery.FieldByName(LstrPrefixo+'DTAENT').AsDateTime);

        Application.ProcessMessages;

        LQuery.next;
      End;
    End;

    FObjDocumentosAImportar.cdsDocumentos.First;

    if FObjDocumentosAImportar.cdsDocumentos.RecordCount = 0 then
    Begin
      fMensagem('', 'Não foram encontrados documentos com esses filtros!', ['&O k']);
      Exit;
    End;

  Finally
    FreeAndNil(LQuery);
  End;

end;

procedure TfrmDigDocumentoEmpresa.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigDocumentoEmpresa.FormCreate(Sender: TObject);
begin
  inherited;
  blnTipoPreco := True;
  blnZerarCustos := False;

  FObjDocumentosAImportar := TDocumentoAImportar.Create;
  dtsDocumentos.DataSet   := FObjDocumentosAImportar.cdsDocumentos;

  FblnAcessoPelaCampanhaVendas := False;
  FblnAgruparItens             := False;
  FblnCarregarAmbiente         := False;

  chkCarregarAmbientes.Visible := fCfgSis('UTIDEF', varBoolean);
end;

procedure TfrmDigDocumentoEmpresa.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FObjDocumentosAImportar);
  inherited;
end;

procedure TfrmDigDocumentoEmpresa.FormShow(Sender: TObject);
begin

  inherited;

  If Not blnTipoPreco Then
  Begin
    rdgPreco.Enabled := False;
    rdgPreco.Visible := False;
    Panel2.Visible := False;
  End;

  pSetFocus(edtNumDoc);

  if FblnAcessoPelaCampanhaVendas then
    chkAgruparProdutos.Visible := False;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', VS_Date);

  tpPrecoImpItemDefault.SetValue(fCfgSis('TIPPRC', varString));
  rdgPreco.ItemIndex := Pred(tpPrecoImpItemDefault.GetValue.ToInteger);

end;

function TfrmDigDocumentoEmpresa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin

    {Valida datas}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And
              fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Or
         (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And
              fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('','Informe a data inicial e final dos documentos!',['&OK']);
        Result := False;
      End

      Else

      {Informou o período}
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And
         Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin

        If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('','A data inicial deve ser menor que a data final!',['&OK']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtCodEmp) Then
    Begin
      edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text], False);

      if not fEmptyStr(edtNomEmp.Text) then
      begin
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Empresa não encontrada!', ['&O k']);
          Result := False;
        End;
      end;
    End

    Else If (Sender = rdgPreco) Then
    Begin
      If rdgPreco.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO', 'O tipo preço deve ser informado!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodigoCliente) Then
    Begin
      edtNomeCliente.Text := fRetNomCliente(edtCodigoCliente.Text);

      If (Not fEmptyStr(edtCodigoCliente.Text)) Then
      Begin
        If fEmptyStr(edtNomeCliente.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmDigDocumentoEmpresa.fValidaPermissaoDeMudancaDeTipoDePreco: Boolean;
  var
    objLiberacao : TLiberacao;
begin

  Result := True;

  If (tpPrecoImpItemDefault = tpNenhumaDefinicao) Then
    Exit;

  If (tpPrecoImpItemDefault = tpPrecoImpItem) Then
    Exit;

  objLiberacao := TLiberacao.Create;

  Try

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Importar itens de outros documentos - "Tipo Preço", opção marcada diferente do padrão [CFG_TIPPRC].');
    objLiberacao.objMsgLibera.pAddSeparador(67);
    objLiberacao.objMsgLibera.pAddTextoCaption('Opção padrão',  tpPrecoImpItemDefault.GetName, 20, alEsquerda, teAmbos, '', 200);
    objLiberacao.objMsgLibera.pAddTextoCaption('Opção marcada', tpPrecoImpItem.GetName       , 20, alEsquerda, teAmbos, '', 200);
    objLiberacao.objMsgLibera.pAddSeparador(67);

    objLiberacao.strDirAce  := 'TIPPRC';
    objLiberacao.strMsgSen  := 'Importar itens de outros documentos - "Tipo Preço", opção marcada diferente do padrão.';
    objLiberacao.strCodOpe  := strLoginUsuarioLogado;
    objLiberacao.strCliente := objFatVenda.strCodCli + '-' + objFatVenda.strCliNom;
    objLiberacao.strCpfCnpj := objFatVenda.strCliCgc;

    Result := objFatVenda.fFatMensagemLiberacao(objLiberacao);

  Finally
    If Assigned(objLiberacao) Then
      FreeAndNil(objLiberacao);
  End;

end;

procedure TfrmDigDocumentoEmpresa.grdDocumentosVisualizarItensPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  Var
    frmItensDocumento : TfrmItensDocumento;
    strTabela : String;
begin
  inherited;

  strTabela := FObjDocumentosAImportar.FcdsDocumentos.FieldByName('DOC_TABELA').AsString;
  Case AnsiIndexStr(strTabela, ['MOVGER', 'NOTGER', 'FATGOR']) Of
    0: strTabela := 'MOVDET';
    1: strTabela := 'NOTDET';
    2: strTabela := 'FATDOR';
    Else strTabela := '';
  End;

  If fEmptyStr(strTabela) Then
    Exit;

  pCriarFormularios(TfrmItensDocumento, frmItensDocumento);
  Try
    frmItensDocumento.strTabela := strTabela;
    frmItensDocumento.strAutInc := FObjDocumentosAImportar.cdsDocumentos.FieldByName('DOC_AUTINC').AsString;
    frmItensDocumento.ShowModal;
  Finally
    pFreeAndNil(frmItensDocumento);
  End;
end;

procedure TfrmDigDocumentoEmpresa.rdgPrecoClick(Sender: TObject);
begin
  inherited;
  chkAgruparProdutos.Enabled := (rdgPreco.ItemIndex <> 1);
  If Not chkAgruparProdutos.Enabled Then
    chkAgruparProdutos.Checked := False;
end;

{ TDocumentoAImportar }

constructor TDocumentoAImportar.Create;
begin
  inherited;
  pCriarCdsDocumentos;
end;

destructor TDocumentoAImportar.Destroy;
begin
  FreeAndNil(FcdsDocumentos);
  inherited;
end;

function TDocumentoAImportar.fGetIdDocumentoSelecionados(AstrTabela: String): String;
begin
  Result := '';

  FcdsDocumentos.First;
  while not FcdsDocumentos.Eof do
  Begin
    if (FcdsDocumentos.FieldByName('DOC_CHECKD').AsBoolean) and
       (Pos(FcdsDocumentos.FieldByName('DOC_TABELA').AsString, AstrTabela) > 0) Then
    Begin
      Result := Result + '"'+FcdsDocumentos.FieldByName('DOC_AUTINC').AsString+'", ';
    End;
    FcdsDocumentos.Next;
  End;

  Result := Copy(Result, 1, Length(Result)-2);

  FcdsDocumentos.EnableControls;
end;

function TDocumentoAImportar.fValidarParaCampanhaDeVendas(var AstrMensagem : String) : Boolean;
  var
    LintQuantidadeSelecionada : Integer;
begin
  Result := True;

  LintQuantidadeSelecionada := 0;
  FstrDocumentoSelecionado  := '';
  FstrEspecieSelecionada    := '';
  FstrEmpresaSelecionada    := '';

  FcdsDocumentos.DisableControls;

  FcdsDocumentos.First;
  while not FcdsDocumentos.Eof do
  Begin
    if FcdsDocumentos.FieldByName('DOC_CHECKD').AsBoolean then
    Begin
      FstrDocumentoSelecionado := FcdsDocumentos.FieldByName('DOC_NUMDOC').AsString;
      FstrEspecieSelecionada   := FcdsDocumentos.FieldByName('DOC_ESPDOC').AsString;
      FstrEmpresaSelecionada   := FcdsDocumentos.FieldByName('DOC_EMPDOC').AsString;
      Inc(LintQuantidadeSelecionada);
    End;
    FcdsDocumentos.Next;
  End;

  FcdsDocumentos.EnableControls;

  if LintQuantidadeSelecionada > 1 then
  begin
    AstrMensagem := 'Para Campanha de Vendas é permitido selecionar apenas um documento.';
    Exit(False);
  end;

end;

procedure TDocumentoAImportar.pAdicionarDocumento(AstrIDDocumento, AstrNumeroDocumento, AstrEspecieDocumento, AstrEmpresaDocumento, AstrTabela: String
  ; AdatEntrada : TDateTime);
begin
  FcdsDocumentos.Append;
  FcdsDocumentos.FieldByName('DOC_CHECKD').AsBoolean  := False;
  FcdsDocumentos.FieldByName('DOC_AUTINC').AsString   := AstrIDDocumento;
  FcdsDocumentos.FieldByName('DOC_NUMDOC').AsString   := AstrNumeroDocumento;
  FcdsDocumentos.FieldByName('DOC_ESPDOC').AsString   := AstrEspecieDocumento;
  FcdsDocumentos.FieldByName('DOC_EMPDOC').AsString   := AstrEmpresaDocumento;
  FcdsDocumentos.FieldByName('DOC_TABELA').AsString   := AstrTabela;
  FcdsDocumentos.FieldByName('DOC_DTAENT').AsDateTime := AdatEntrada;
  FcdsDocumentos.Post;
end;

procedure TDocumentoAImportar.pCriarCdsDocumentos;
begin
  FcdsDocumentos := TUniClientDataSet.Create(nil);

  FcdsDocumentos.FieldDefs.Add('DOC_CHECKD', ftBoolean,  0, False);
  FcdsDocumentos.FieldDefs.Add('DOC_NUMDOC', ftString,  12, False);
  FcdsDocumentos.FieldDefs.Add('DOC_ESPDOC', ftString,   2, False);
  FcdsDocumentos.FieldDefs.Add('DOC_EMPDOC', ftString,   3, False);
  FcdsDocumentos.FieldDefs.Add('DOC_AUTINC', ftString,  20, False);
  FcdsDocumentos.FieldDefs.Add('DOC_TABELA', ftString,   6, False);
  FcdsDocumentos.FieldDefs.Add('DOC_DTAENT', ftDateTime, 0, False);

  FcdsDocumentos.CreateDataSet;
  FcdsDocumentos.Open;
end;

end.
