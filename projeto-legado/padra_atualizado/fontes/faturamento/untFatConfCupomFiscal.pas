{*****************************************}
{* qryConCli -> CADCLI                   *}
{**************************************MV*}

unit untFatConfCupomFiscal;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Mask, MaskEditFocus, EditFocus,
  Grids, DBGridCitel, DBGrids, Menus, ComCtrls, Buttons, ExtCtrls, DB, {Qt,} untFuncFat,
  StrUtils, Uni, AppEvnts, Math, BitBtnLockedIncrem, untConfCupom, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFatConfCupomFiscal = class(TfrmPaiSimples)
    pnlAux2: TPanel;
    dbgDocumentos: TDBGridCitel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    pnlBotoesBaixa: TPanel;
    btnItensDoc: TBitBtnLocked;
    btnSairConf: TBitBtnLocked;
    pnlAux1: TPanel;
    pnlDadosDup: TPanel;
    pnlInformativos: TPanel;
    Label16: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label6: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label17: TLabel;
    edtQtdDoc: TEditFocus;
    edtTotGer: TEditFocus;
    edtDupPag: TEditFocus;
    edtTotLiq: TEditFocus;
    edtQtdDocSel: TEditFocus;
    edtTotGerSel: TEditFocus;
    edtDupPagSel: TEditFocus;
    edtTotLiqSel: TEditFocus;
    edtNomCli: TEditFocus;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label5: TLabel;
    lblCliFat: TLabel;
    edtCliFat: TEditFocus;
    edtNomCliFat: TEditFocus;
    btnGeraFF: TBitBtnLocked;
    chkCupEsp: TCheckBox;
    pnlLegendas: TPanel;
    Shape1: TShape;
    Label8: TLabel;
    Shape2: TShape;
    Label10: TLabel;
    btnConfirma: TBitBtnLocked;
    btnMarca: TBitBtnLocked;
    btnPopMenuMarca: TBitBtnLocked;
    btnDesmarca: TBitBtnLocked;
    btnPopMenuDesMarca: TBitBtnLocked;
    popMarca: TPopupMenu;
    popEnt: TMenuItem;
    popRet: TMenuItem;
    procedure btnSairConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDocumentosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgDocumentosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnItensDocClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCliFatKeyPress(Sender: TObject; var Key: Char);
    procedure btnGeraFFClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnMarcaClick(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure btnPopMenuDesMarcaClick(Sender: TObject);
    procedure btnPopMenuMarcaClick(Sender: TObject);
    procedure popEntClick(Sender: TObject);
    procedure popRetClick(Sender: TObject);
  private
    { Private declarations }
    qryConCli: TUniQuery;

    blnFecharForm: Boolean;
    qryCliFat: TUniQuery;

    intAdicionando: Integer;

    strCodCliTrava: String;

    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;
    procedure pCarregaCliente;

    procedure pCarregaItensDocumento;
    procedure pMarcaDocumento(blnMarcar: Boolean);
    procedure pAtualizaTotais;

    procedure pDeletaDocDesmarcados;
    procedure pCarregaNovoCliente;

    procedure pCarregaGrid;

    procedure pMarcarDesmarcarTudo(strOpc, strEntRet: String);
    function fValidaTrocaClienteApenasDocsCPFBranco: Boolean;
    function fPermiteTrocarClienteNaConfirmacao: Boolean;

    function fVerificaTravaNovoClienteConsumidor():Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    fatVenda: TFatVenda;
    objConfCupom: TConfirmacaoCupom;
  end;


implementation

uses untfuncoesSimples, untPesqAux, untConsultas,untPai, System.UITypes, untTypesSistema,
  untFuncoes, untFuncoesGenerica, untLiberacao;

{$R *.dfm}

procedure TfrmFatConfCupomFiscal.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmFatConfCupomFiscal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  dtaDataAtual: TDateTime;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin

      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do cliente deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
          objConfCupom.strCodigoCliente := edtCodCli.Text;
      End;

    End

    Else If (Sender = edtCliFat) Then
    Begin
      If (fEmptyStr(edtCliFat.Text)) Or (Not fVerificaTravaNovoClienteConsumidor()) Then
      Begin
        edtCliFat.Text := edtCodCli.Text;
        pCarregaNovoCliente;
        objConfCupom.strCodigoNovoCliente := edtCliFat.Text;
      End
      Else
      Begin
        pCarregaNovoCliente;
        If (qryCliFat.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else
          objConfCupom.strCodigoNovoCliente := edtCliFat.Text;
      End;
    End

    {***********************}
    {* VALIDA DATA INICIAL *}
    {********************JB*}
    Else If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        if fCfgSis('DIADCF', varInteger) > 0 then
        begin
          dtaDataAtual := StrToDateDef(FormatDateTime('dd/mm/yyyy',fNow),0);
          If (StrToDateDef(mskDtaIni.Text,0) < (dtaDataAtual - fCfgSis('DIADCF', varInteger))) Then
          Begin
            fMensagem('ATENÇÃO', 'O prazo máximo para confirmação de cupom fiscal é de '+fCfgSis('DIADCF')+' dias.', ['&O k']);
            mskDtaIni.Text := DateToStr(dtaDataAtual - fCfgSis('DIADCF', varInteger));
          End;
          objConfCupom.dtaDataInicial := strToDateDef(mskDtaIni.Text, 0);
        end
        else
        begin
          objConfCupom.dtaDataInicial := strToDateDef(mskDtaIni.Text, 0);
        end;
      End;
    End

    {*********************}
    {* VALIDA DATA FINAL *}
    {******************JB*}
    Else If (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End

      Else If Not (fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
        Result := False;
      End

      Else
        objConfCupom.dtaDataFinal := strToDateDef(mskDtaFin.Text, 0);

    End

    Else If (Sender = chkCupEsp) And blnBuscaPorChave Then
    Begin
      objConfCupom.blnCarregarCupomEspecial := chkCupEsp.Checked;

      If fValidaPanel(pnlCabecalho) Then
      Begin
        pCarregaGrid;

        If  objConfCupom.blnSemCuponsParaConfirmar Then
        Begin

          fMensagem('ATENÇÃO!', 'Não há documentos para confirmar nesse período!', ['&Ok']);
          Result := False;

        End
        Else
        Begin
          blnMudarFoco := False;
          pSetFocus(dbgDocumentos);
        End;
      End
      Else
        Result := False;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmFatConfCupomFiscal.pAtualizaTemporaria;
begin
  objConfCupom.pAtualizaTemporariaConfirmacao;
end;

procedure TfrmFatConfCupomFiscal.pCriaTemporaria;
begin
  objConfCupom.pCriaTemporariaConfirmacao;
  pAtualizaTotais;

  If fCfgSis('COENRE', varBoolean) Then
  Begin
    btnPopMenuMarca.Enabled    := fTemItensEntregaRetira(objConfCupom.objFatVenda.strTabelaConfMi);
    btnPopMenuDesMarca.Enabled := btnPopMenuMarca.Enabled;
  End;

end;

procedure TfrmFatConfCupomFiscal.pDeletaTemporaria;
begin
  objConfCupom.pDeletaTemporariaConfirmacao;
end;

procedure TfrmFatConfCupomFiscal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Not blnConfirma Then
  Begin
    objConfCupom.pDestravarTodos;
  End;
  
end;

procedure TfrmFatConfCupomFiscal.FormCreate(Sender: TObject);
begin
  inherited;

  intAdicionando          := -1;

  blnConfirma             := False;
  blnFecharForm           := False;
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);

  strCodCliTrava := '';
end;

procedure TfrmFatConfCupomFiscal.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  edtNomCli.Text := qryConCli.FieldbyName('CLI_NOMCLI').AsString;
end;

procedure TfrmFatConfCupomFiscal.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    If fMensagem('', 'Abandona?', ['&Sim', '&Não']) = 1 Then
    Begin
      pDeletaTemporaria;
      Close;
    End;
  End
  Else If (Key = VK_Return) Then
  Begin
    If fatVenda.qryTemporariaConfirmacao.Active Then
      pMarcaDocumento(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString <> 'M');
  End
  Else If (Key = VK_F5) Then
  Begin
    btnItensDoc.Click;
  End
  Else If (Key = VK_F7) Then
  Begin
    btnMarca.Click
  End
  Else If (Key = VK_F8) Then
  Begin
    btnDesmarca.Click
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;
end;

procedure TfrmFatConfCupomFiscal.pMarcaDocumento(blnMarcar: Boolean);
begin
  objConfCupom.fMarcaDocumento(blnMarcar);
  pAtualizaTotais;
end;

procedure TfrmFatConfCupomFiscal.popEntClick(Sender: TObject);
begin
  inherited;

  pMarcarDesmarcarTudo(IfThen(popMarca.Tag = 0, 'M', 'D'), 'E');
end;

procedure TfrmFatConfCupomFiscal.popRetClick(Sender: TObject);
begin
  inherited;

  pMarcarDesmarcarTudo(IfThen(popMarca.Tag = 0, 'M', 'D'), 'R');
end;

procedure TfrmFatConfCupomFiscal.dbgDocumentosDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;

    If FieldByName('TMP_MARDES').AsString = 'M' Then
    Begin
      dbgDocumentos.Canvas.Font.Color := clBlue;
    End
    Else If FieldByName('TMP_VLRCON').AsFloat = FieldByName('TMP_DUPREC').AsFloat Then
    Begin
      dbgDocumentos.Canvas.Font.Color := clRed;
    End;

    If dbgDocumentos.Canvas.Brush.Color = clHighLight Then
    Begin
      dbgDocumentos.Canvas.Brush.Color := clLtGray;
    End

    Else If SameText(FieldByName('TMP_NOTESP').AsString, 'S') Then
      dbgDocumentos.Canvas.Brush.Color := clMoneyGreen;

  End;

  dbgDocumentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmFatConfCupomFiscal.dbgDocumentosDblClick(Sender: TObject);
begin
  inherited;
  If fatVenda.qryTemporariaConfirmacao.Active Then
    pMarcaDocumento(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString <> 'M');
end;

function TfrmFatConfCupomFiscal.fPermiteTrocarClienteNaConfirmacao: Boolean;
begin
  Result := (Pos(fCfgSis('TRCLCC'), 'S_D_L_') > 0);
end;

procedure TfrmFatConfCupomFiscal.FormShow(Sender: TObject);
begin
  inherited;

  //fatVenda.blnGerarCtrCI := True;
  
  dbgDocumentos.DataSource := fatVenda.dtsTemporariaConfirmacao;
  edtCodCli.Text           := fatVenda.strCodCli;
  pCarregaCliente;

  qryCliFat := fCriaQuery(Self);
  qryCliFat.SQL.Add('SELECT * FROM CADCLI WHERE CLI_CODCLI = :CODCLI');

  pSetFocus(mskDtaIni);
  edtCliFat.Text := edtCodCli.Text;
  If Not fPermiteTrocarClienteNaConfirmacao Then
  Begin
    lblCliFat.Visible    := False;
    edtCliFat.Visible    := False;
    edtNomCliFat.Visible := False;
  End
  Else
  Begin
    pSetFocus(edtCliFat);
  End;

  btnGeraFF.Visible := False;
  btnGeraFF.Enabled := False;
end;

procedure TfrmFatConfCupomFiscal.pAtualizaTotais;
begin
  edtQtdDoc.Text := objConfCupom.strQuantidadeDocumentos;
  edtTotGer.Text := objConfCupom.strTotalGeral;
  edtDupPag.Text := objConfCupom.strDuplicatasPagas;
  edtTotLiq.Text := objConfCupom.strTotalLiquido;

  edtQtdDocSel.Text := objConfCupom.strQuantidadeDocumentosSelecionados;
  edtTotGerSel.Text := objConfCupom.strTotalGeralSelecionados;
  edtDupPagSel.Text := objConfCupom.strDuplicatasPagasSelecionados;
  edtTotLiqSel.Text := objConfCupom.strTotalLiquidoSelecionados;
end;

procedure TfrmFatConfCupomFiscal.pCarregaItensDocumento;
begin
  objConfCupom.pExibirProdutosDocumento;
end;

procedure TfrmFatConfCupomFiscal.btnItensDocClick(Sender: TObject);
begin
  inherited;

  If (fatVenda.qryTemporariaConfirmacao.Active) Then
  Begin
    pCarregaItensDocumento;
    pSetFocus(dbgDocumentos);
  End;

end;

procedure TfrmFatConfCupomFiscal.btnMarcaClick(Sender: TObject);
begin
  inherited;

  If btnPopMenuMarca.Enabled Then
    btnPopMenuMarca.Click
  Else
    pMarcarDesmarcarTudo('M','');

end;

procedure TfrmFatConfCupomFiscal.btnPopMenuDesMarcaClick(Sender: TObject);
begin
  inherited;

  With TButton(Sender).ClientToScreen(Point(0, TButton(Sender).Height)) Do
  Begin
     popMarca.Tag := 1; //DESMARCA
     popMarca.Popup(X, Y);
  End;
end;

procedure TfrmFatConfCupomFiscal.btnPopMenuMarcaClick(Sender: TObject);
begin
  inherited;

  With TButton(Sender).ClientToScreen(Point(0, TButton(Sender).Height)) Do
  Begin
     popMarca.Tag := 0; //MARCA
     popMarca.Popup(X, Y);
  End;
end;

function TfrmFatConfCupomFiscal.fValidaTrocaClienteApenasDocsCPFBranco: Boolean;
  Var
    strMensagem : String;
begin
  Result := True;
  strMensagem := '';

  dbgDocumentos.DataSource.DataSet.DisableControls;
  Try
    dbgDocumentos.DataSource.DataSet.First;
    While Not dbgDocumentos.DataSource.DataSet.Eof Do
    Begin
      If (dbgDocumentos.DataSource.DataSet.FieldByName('TMP_MARDES').AsString = 'M') And (Not fEmptyStr(dbgDocumentos.DataSource.DataSet.FieldByName('TMP_CGCCON').AsString)) Then
      Begin
        If fEmptyStr(strMensagem) Then
          strMensagem := 'Documento(s): '+dbgDocumentos.DataSource.DataSet.FieldByName('TMP_NUMDOC').AsString+'-IF-'+dbgDocumentos.DataSource.DataSet.FieldByName('TMP_CODEMP').AsString
        Else
          strMensagem := strMensagem + ', '+dbgDocumentos.DataSource.DataSet.FieldByName('TMP_NUMDOC').AsString+'-IF-'+dbgDocumentos.DataSource.DataSet.FieldByName('TMP_CODEMP').AsString;
      End;

      dbgDocumentos.DataSource.DataSet.Next;
    End;
  Finally
    dbgDocumentos.DataSource.DataSet.EnableControls;
  End;

  If Not fEmptyStr(strMensagem) Then
  Begin
    fMensagem('','O sistema está configurado para permitir trocar o cliente na confirmação de '+
                 'cupom somente quando o documento não possui cpf/cnpj informado.'+sLineBreak+
                 'Os documentos abaixo possuem CPF/CNPJ informado, sendo assim, não será possível selecioná-lo(s). [CFG_TRCLCC]'+sLineBreak+
                 strMensagem, ['&OK']);
    Result := False;
  End;
end;

function TfrmFatConfCupomFiscal.fVerificaTravaNovoClienteConsumidor(): Boolean;
var
  strCodCid: String;
  strNomCid: String;
  strEstCid: String;
  strCgcCpf: String;
  strNovCli: String;

  objLiberacao: TLiberacao;

  procedure pAtualizaDadosCliente(strCodCliente: String);
  begin
    strCodCid := fRetCodCidByCliente(strCodCliente);
    strNomCid := fRetNomCidade(strCodCid);
    strEstCid := fRetNomCidade(strCodCid, 1);
    strCgcCpf := fRetCgcCpf(strCodCliente);
    strCgcCpf := fFormataCpfCgc(strCgcCpf, fSetaPais);
  end;

  function fVaiVerificarTrava():Boolean;
  begin
    Result := False;

    If fEmptyStr(edtCodCli.Text) Then
      Exit;

    If fEmptyStr(edtCliFat.Text) Then
      Exit;

    If (edtCliFat.Text = edtCodCli.Text) Then
      Exit;

    If (Not fEmptyStr(strCodCliTrava)) And (strCodCliTrava = edtCliFat.Text) Then
      Exit;

    If (fCfgSis('TRCLCC', VarString) <> 'L') Then
      Exit;

    If fClienteConsumidor(fRetNomCliente(edtCodCli.Text), True, True) Then
      Exit;

    Result := True;
  end;
begin
  Result := True;

  If (fVaiVerificarTrava())  Then
  Begin
    strNovCli := fRetNomCliente(edtCliFat.Text);
    If fEmptyStr(strNovCli) Then
      Exit;

    objLiberacao := TLiberacao.Create;

    Try
      pAtualizaDadosCliente(edtCodCli.Text);

      objLiberacao.objMsgLibera.pAddSeparador;
      objLiberacao.objMsgLibera.pAddTexto('TROCA DE CLIENTE NA CONFIRMAÇÃO DE CUPOM FISCAL');
      objLiberacao.objMsgLibera.pAddSeparador;
      objLiberacao.objMsgLibera.pAddTextoCaption('Cliente Atual:' , edtCodCli.Text + '-'+edtNomCli.Text, 22);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cidade:'        , strNomCid + ' - ' + strEstCid, 22);
      objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ:'      , strCgcCpf, 22);

      objLiberacao.objMsgLibera.pAddQuebra;
      pAtualizaDadosCliente(edtCliFat.Text);

      objLiberacao.objMsgLibera.pAddTextoCaption('Novo Cliente:'  , edtCliFat.Text + '-'+ strNovCli, 22);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cidade:'        , strNomCid + ' - ' + strEstCid, 22);
      objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ:'      , strCgcCpf, 22);
      objLiberacao.objMsgLibera.pAddSeparador;

      objLiberacao.strDirAce := 'TCCCFL';
      objLiberacao.strMsgSen := 'TROCA DE CLIENTE NA CONFIRMAÇÃO DE CUPOM FISCAL';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;

      If (Result) Then
        strCodCliTrava := edtCliFat.Text;        
    Finally
      FreeAndNil(objLiberacao);
    End;
  End;
end;

procedure TfrmFatConfCupomFiscal.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If StrToIntDef(edtQtdDocSel.Text, 0) <= 0 Then
  Begin
    fMensagem('', 'É necessário escolher pelo menos um documento!', ['&O k']);
    pSetFocus(dbgDocumentos);
    Exit;
  End;

  If (Not fValidaCampos(edtCliFat, False)) Then
    Exit;

  {***********************************************************************}
  {*CONFIGURADO PARA NÃO PERMITIR SELECIONAR MAIS DE UM DOCUMENTO POR VEZ*}
  {********************************************************************PZ*}
  If (fCfgSis('VCUDOC') = 'N') Then
  Begin
    If (StrToInt(edtQtdDocSel.Text) > 1) Then
    Begin
      fMensagem('', 'Não é permitido confirmar mais de um documento por vez!', ['&O k']);
      pSetFocus(dbgDocumentos);
      Exit;
    End;
  End;

  If (fStrToFloat(edtTotGerSel.Text) < 0.0) Then
  Begin
    fMensagem('', 'Não é possível confirmar um valor negativo!', ['&O k']);
    pSetFocus(dbgDocumentos);
    Exit;
  End;

  If fBloqueiaConfirmacaoOndeTodosDocumentosEstaoQuitados(fStrToFloat(edtTotLiqSel.Text)) Then
  Begin
    pSetFocus(dbgDocumentos);
    Exit;
  End;

  If (fCfgSis('TRCLCC', varString) = 'D') And (edtCodCli.Text <> edtCliFat.Text) Then
  Begin
    If Not fValidaTrocaClienteApenasDocsCPFBranco Then
    Begin
      pSetFocus(dbgDocumentos);
      Exit;
    End;
  End;

  If fMensagem('', 'Confirma documentos?', ['&Sim', '&Não']) = 1 Then
  Begin

    pDeletaDocDesmarcados;  
    objConfCupom.pCarregaDadosDocumentoGeraStringCuponsConfirmados;
    objConfCupom.pPegaPlacaAndKmVeiculo;

    blnConfirma := True;
    Close;

  End;

end;

{*****************************************}
{* APAGA DOCUMENTOS QUE NAO ESTÃO SELE-  *}
{* CIONADOS                              *}
{**************************************MV*}
procedure TfrmFatConfCupomFiscal.pDeletaDocDesmarcados;
begin
  objConfCupom.pDeletaCuponsDesmarcados;
end;

procedure TfrmFatConfCupomFiscal.FormActivate(Sender: TObject);
begin
  inherited;

  {*****************************************}
  {* CASO NÃO TENHA NENHUM DOCUMENTO, SAI  *}
  {**************************************MV*}
  If blnFecharForm Then
  Begin
    fMensagem('', 'Não há documentos para esse cliente!', ['&O k']);
    Self.Close;
  End;
{  If fatVenda.qryTemporariaConfirmacao.IsEmpty Then
  Begin
    Self.Hide;
    fMensagem('', 'Não há documentos para esse cliente!', ['&O k']);
    Self.Close;
  End;}

end;

procedure TfrmFatConfCupomFiscal.pCarregaNovoCliente;
begin

  qryCliFat.Close;
  qryCliFat.ParamByName('CODCLI').AsString := edtCliFat.Text;
  qryCliFat.Open;
  edtNomCliFat.Text := qryCliFat.FieldByName('CLI_NOMCLI').AsString;

end;

procedure TfrmFatConfCupomFiscal.edtCliFatKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCliFat, edtNomCliFat, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCliFat, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatConfCupomFiscal.btnDesmarcaClick(Sender: TObject);
begin
  inherited;

  If btnPopMenuDesMarca.Enabled Then
    btnPopMenuDesMarca.Click
  Else
    pMarcarDesmarcarTudo('D','');

end;

procedure TfrmFatConfCupomFiscal.btnGeraFFClick(Sender: TObject);
begin
  inherited;

  If (Not btnGeraFF.Visible) Then
    Exit;

  If StrToInt(edtQtdDocSel.Text) <= 0 Then
  Begin
    fMensagem('', 'É necessário escolher pelo menos um documento!', ['&O k']);
    pSetFocus(dbgDocumentos);
    Exit;
  End;

  If (fStrToFloat(edtTotGerSel.Text) < 0.0) Then
  Begin
    fMensagem('', 'Não é possivel confirmar um valor negativo!', ['&O k']);
    pSetFocus(dbgDocumentos);
    Exit;
  End;

  If fBloqueiaConfirmacaoOndeTodosDocumentosEstaoQuitados(fStrToFloat(edtTotLiqSel.Text)) Then
  Begin
    pSetFocus(dbgDocumentos);
    Exit;
  End;

  If fMensagem('', 'Confirma transformação em FF?', ['&Sim', '&Não']) = 1 Then
  Begin

    pDeletaDocDesmarcados;
    pAtualizaTemporaria;
    blnConfirma := True;
    fatVenda.blnConfTransFF := True;
    Close;

  End;
end;

procedure TfrmFatConfCupomFiscal.pCarregaGrid;
begin
  If InterlockedIncrement(intAdicionando) = 0 Then
  Begin

    Try

      pCriaTemporaria;
      pAtualizaTemporaria;

      InterlockedDecrement(intAdicionando);

    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(intAdicionando);
        pMensagensErro(E.Message, '[frmFatConfCupomFiscal.chkCupEsp]');
      End;
    End;

  End
  Else
    InterlockedDecrement(intAdicionando)

end;

procedure TfrmFatConfCupomFiscal.pMarcarDesmarcarTudo(strOpc, strEntRet: String);
begin
  If (strOpc = 'M') Then
  Begin
    objConfCupom.pMarcarTodosDocumentos(True, strEntRet);
  End
  Else
  Begin
    objConfCupom.pMarcarTodosDocumentos(False, strEntRet);
  End;

  pAtualizaTotais;
end;

end.

