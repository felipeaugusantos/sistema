unit untFatRomManutencaoEndereco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, Uni,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, UniClientDataSet, cxProgressBar, System.UITypes;

type
  TfrmFatRomManutencaoEndereco = class(TfrmPaiConfirma)
    gpbEnderecoEntrega: TGroupBox;
    lblEndCon: TLabel;
    lblBaiCon: TLabel;
    lblComple: TLabel;
    lblCidade: TLabel;
    lblCep: TLabel;
    edtEndEnt: TEditFocus;
    edtBaiEnt: TEditFocus;
    edtComple: TEditFocus;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    edtEstado: TEditFocus;
    edtCepEnt: TEditFocus;
    lblTipEnt: TLabel;
    Shape2: TShape;
    lblEndRef: TLabel;
    edtRefEnt: TEditFocus;
    rdgEntrega: TRadioGroup;
    pnlTransp: TPanel;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    pnlFilial: TPanel;
    edtCodFil: TEditFocus;
    edtNomFil: TEditFocus;
    cxgDocumentos: TcxGridCitel;
    cxgDocumentosTv: TcxGridDBTableViewCitel;
    cxgDocumentosTvGER_TIPENT: TcxGridDBColumn;
    cxgDocumentosTvGER_NUMDOC: TcxGridDBColumn;
    cxgDocumentosTvGER_CODEMP: TcxGridDBColumn;
    cxgDocumentosTvGER_NOMCLI: TcxGridDBColumn;
    cxgDocumentosTvGER_NOMCID: TcxGridDBColumn;
    cxgDocumentosTvGER_ESTADO: TcxGridDBColumn;
    cxgDocumentosTvGER_BAIRRO: TcxGridDBColumn;
    cxgDocumentosTvGER_ENDCON: TcxGridDBColumn;
    cxgDocumentosTvGER_CEPCON: TcxGridDBColumn;
    cxgDocumentosTvGER_TRANSP: TcxGridDBColumn;
    cxgDocumentosLvl: TcxGridLevel;
    btnDesmarcaTodos: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    cxgDocumentosTvGER_CODFIL: TcxGridDBColumn;
    btnConfirmaCapa: TBitBtnLocked;
    btnOutroModo: TBitBtnLocked;
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure edtCepEntKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure rdgEntregaClick(Sender: TObject);
    procedure edtCodFilKeyPress(Sender: TObject; var Key: Char);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure cxgDocumentosTvCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgDocumentosTvDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgDocumentosTvGER_TIPENTGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure btnConfirmaCapaClick(Sender: TObject);
    procedure cxgDocumentosTvKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure btnOutroModoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    strCepAnt: String;
    strCodFilAnt: String;

    dtsDocs: TDataSource;

    procedure pCarregaCadCidade;
    procedure pCarregaCadTra;
    procedure pCarregaCadFil;

    procedure pAtualizaEntrega;

    function fDesmarcaTodos(pgbStatus: TcxProgressBar): Boolean;
    function fMarcaTodos(pgbStatus: TcxProgressBar): Boolean;
    procedure pMarcaDesmarca;
    procedure pSelecionaDocumento(blnMarca: Boolean);

    procedure pHabilitaDesabilitaCamposCapa(blnHabilita: Boolean);
    procedure pHabilitaDesabilitaGridSelecao(blnHabilita: Boolean);

    function fValidaSelecao(blnMostraMensagem: Boolean): Boolean;
  public
    { Public declarations }
    cdsDocs: TUniClientDataSet;

    procedure pSetDados(cdsTmpDoc: TUniClientDataSet);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

const
  IDX_TRANSPORTADORA = 0;
  IDX_TRANSBORDO = 1;
  IDX_RETIRA_FILIAL = 2;

implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas, untCadCidades, untCadCid, untGravando,
  System.StrUtils;

{$R *.dfm}

procedure TfrmFatRomManutencaoEndereco.btnConfirmaCapaClick(Sender: TObject);
begin
  inherited;

  if not fVerificaCampos then
    Exit;

  pHabilitaDesabilitaGridSelecao(True);
  pHabilitaDesabilitaCamposCapa(False);
  pSetFocus(cxgDocumentos);
end;

procedure TfrmFatRomManutencaoEndereco.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  If (Not btnDesmarcaTodos.Visible) Or (Not btnDesmarcaTodos.Enabled) then
    Exit;

  fChamaTelaGravando(fDesmarcaTodos, 'Desmarcando documentos...');
end;

procedure TfrmFatRomManutencaoEndereco.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  If (Not btnMarcaTodos.Visible) Or (Not btnMarcaTodos.Enabled) then
    Exit;

  fChamaTelaGravando(fMarcaTodos, 'Marcando documentos...');
end;

procedure TfrmFatRomManutencaoEndereco.btnOutroModoClick(Sender: TObject);
begin
  inherited;
  If (Not btnOutroModo.Visible) Or (Not btnOutroModo.Enabled) then
    Exit;

  pHabilitaDesabilitaCamposCapa(True);
  pHabilitaDesabilitaGridSelecao(False);

  rdgEntrega.ItemIndex := IDX_TRANSPORTADORA;
  pAtualizaEntrega;
  edtCodTra.Text := '';
  edtNomTra.Text := '';
  edtCodFil.Text := '';
  edtNomFil.Text := '';
  edtEndEnt.Text := '';
  edtBaiEnt.Text := '';
  edtComple.Text := '';
  edtCodCid.Text := '';
  edtNomCid.Text := '';
  edtEstado.Text := '';
  edtCepEnt.Text := '';
  edtRefEnt.Text := '';

  strCepAnt := '';
  strCodFilAnt := '';

  if rdgEntrega.Visible then
    pSetFocus(rdgEntrega)
  else
    pSetFocus(edtCodTra);
end;

procedure TfrmFatRomManutencaoEndereco.btnSairClick(Sender: TObject);
begin
  If (fMensagem('ATENÇÃO!', 'Deseja realmente cancelar?', ['&S I M', '&N Ã O'], 2) = 2) Then
    Exit;

  inherited;
end;

procedure TfrmFatRomManutencaoEndereco.cxgDocumentosTvCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Const
  COR_TRASNPORTADORA = clSkyBlue;
  COR_TRANSBORDO = $00379BFF;
  COR_RETIRA_FILIAL = $00C6FFFF;
var
  strTipEnt: String;
begin
  inherited;
  if not Assigned(cdsDocs) then
    Exit;

  if not cdsDocs.Active then
    Exit;

  inherited;

  strTipEnt := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDocumentosTvGER_TIPENT.Index]);

  if strTipEnt = 'T' then
    ACanvas.Brush.Color := COR_TRASNPORTADORA
  else if strTipEnt = 'B' then
    ACanvas.Brush.Color := COR_TRANSBORDO
  else if strTipEnt = 'R' then
    ACanvas.Brush.Color := COR_RETIRA_FILIAL;

  ACanvas.Font.Color := clBlack;
end;

procedure TfrmFatRomManutencaoEndereco.cxgDocumentosTvDblClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarca;
end;

procedure TfrmFatRomManutencaoEndereco.cxgDocumentosTvKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN, VK_SPACE: pMarcaDesmarca;
  end;
end;

procedure TfrmFatRomManutencaoEndereco.edtCepEntKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
    Key := #0;

    edtCepEnt.Text := fConsultarCep(Self, edtCepEnt.Text, edtCepEnt);
  End;
end;

procedure TfrmFatRomManutencaoEndereco.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCidade: TConsultasArray;
begin
  inherited;
  If fPesqCidade(Self, edtCodCid, edtNomCid, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(edtCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatRomManutencaoEndereco.edtCodFilKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrFilial: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodFil, edtNomFil, Nil, Key, arrFilial) Then
    If fValidaCampos(edtCodFil, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmFatRomManutencaoEndereco.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrTransp: TConsultasArray;
begin
  inherited;
  If fPesqTransportadora(conTraSimples, Self, edtCodTra, edtNomTra, Nil, Key, arrTransp) Then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatRomManutencaoEndereco.FormCreate(Sender: TObject);
begin
  inherited;
  blnFecharComEscape := False;
  blnVerificaCampos := False;
  Self.WindowState := wsMaximized;
end;

procedure TfrmFatRomManutencaoEndereco.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dtsDocs);
  FreeAndNil(cdsDocs);
end;

procedure TfrmFatRomManutencaoEndereco.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F10:
      begin
        if btnConfirmaCapa.Enabled then
          btnConfirmaCapa.Click
        else if btnConfirma.Enabled then
          btnConfirma.Click;

        Key := 0;
      end;

    VK_F6:
      begin
        if btnOutroModo.Enabled then
          btnOutroModo.Click;

        Key := 0;
      end;
  end;

  inherited;
end;

procedure TfrmFatRomManutencaoEndereco.FormShow(Sender: TObject);
begin
  inherited;
  pHabilitaDesabilitaCamposCapa(True);
  pHabilitaDesabilitaGridSelecao(False);

  pnlFilial.Left := pnlTransp.Left;
  pnlFilial.Top  := pnlTransp.Top;

  rdgEntrega.Visible := fCfgSis('UTITDE', varBoolean);
  cxgDocumentosTvGER_TIPENT.Visible := fCfgSis('UTITDE', varBoolean);
  cxgDocumentosTvGER_CODFIL.Visible := fCfgSis('UTITDE', varBoolean);
  btnOutroModo.Visible := fCfgSis('UTITDE', varBoolean);

  if rdgEntrega.Visible then
  begin
    rdgEntrega.ItemIndex := IDX_TRANSPORTADORA;

    lblTipEnt.Alignment := taRightJustify;

    pAtualizaEntrega;
    pSetFocus(rdgEntrega);
  end
  else
    pSetFocus(edtCodTra);

end;

function TfrmFatRomManutencaoEndereco.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strCodCid,
  strEndere,
  strBairro,
  strNomCid,
  strEstado,
  LCodigoCorreio: String;

  blnAtualizar: Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
   If (Sender = edtCodCid) Then
    Begin
      If fEmptyStr(edtCodCid.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Cidade deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        pCarregaCadCidade;
        If fEmptyStr(edtNomCid.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else
    If (Sender = edtEndEnt) Then
    Begin
      If (fEmptyStr(edtEndEnt.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Endereço deve ser preenchido!', ['&OK']);
        Result := False;
      End;
    End
    Else
    If (Sender = edtBaiEnt) Then
    Begin
      If (fEmptyStr(edtBaiEnt.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Bairro deve ser preenchido!', ['&OK']);
        Result := False;
      End;
    End
    Else
    If (Sender = edtCodTra) and (pnlTransp.Visible) Then
    Begin
      If Not (fEmptyStr(edtCodTra.Text)) Then
      Begin
        pCarregaCadTra;
        If fEmptyStr(edtNomTra.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Transportadora não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
          pCarregaCadCidade;
      End;
    End
    Else
    If (Sender = edtCodFil) and (pnlFilial.Visible) Then
    Begin
      If (Not (fEmptyStr(edtCodFil.Text))) and (edtCodFil.Text <> strCodFilAnt) Then
      Begin
        pCarregaCadFil;
        If fEmptyStr(edtNomFil.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
          pCarregaCadCidade;

        strCodFilAnt := edtCodFil.Text;
      End;
    End
    Else If (Sender = edtCepEnt) Then
    Begin

      If (fEmptyStr(edtCepEnt.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo CEP deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      If (Not fEmptyStr(fTiraCaracEspeciais(edtCepEnt.Text))) Then
      Begin
        If Length(Trim(fTiraCaracEspeciais(edtCepEnt.Text))) < 8 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Cep deve ser vazio ou com 8 digitos.', ['&Ok']);
          Result := False;
        End;
      End;

      If (Result) And (fCfgSis('USACEP', varBoolean)) Then
      Begin
        If (Not fCadCepDadosCep(edtCepEnt.Text,
                                strCodCid,
                                strEndere,
                                strBairro,
                                strNomCid,
                                strEstado,
                                LCodigoCorreio,
                                '',
                                '')) Then
          Begin
            Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;
          End
          Else
          Begin

            If (fEmptyStr(strCodCid)) Then
            Begin

              If Not fEmptyStr(fRetNomCidade(edtCodCid.Text)) Then
              Begin

                If fMensagem('ATENÇÃO!', 'O Código Correios da cidade ' + edtNomCid.Text + ' está em branco.' + #13#10 +
                             'Deseja que o mesmo seja preenchido automaticamente no Cadastro de Cidades?', ['&Sim', '&Não']) = 1 Then
                Begin
                  pAtualizaCodigoCorreios(edtCodCid.Text, edtCepEnt.Text);
                End
                Else
                  Result := False;

              End
              Else
              Begin
                fMensagem('ATENÇÃO!', 'Esse CEP não tem nenhum endereço associado no cadastro do AutCom.' + #13#10 +
                                      'Será aberto o Cadastro de Cidades para o preenchimento do Código Correios.', ['&Ok']);
                pCriarForm(TfrmCadCidades);

                Result := False;
              End;

            End

            {***********************************}
            {* CASO O CEP NÃO POSSUIR ENDERECO *}
            {********************************JB*}
            Else If (Not fEmptyStr(strNomCid)) And (fEmptyStr(edtEndEnt.Text)) Then
            Begin
              edtEndEnt.Text := fTiraCaracEspeciais(edtNomCid.Text);
              strEndere      := edtEndEnt.Text;
            End;

            If (Result) Then
            Begin

              blnAtualizar := False;
              If fTiraCaracEspeciais(strCepAnt) <> fTiraCaracEspeciais(edtCepEnt.Text) Then
              Begin
                If fTiraCaracEspeciais(strCepAnt) = '' Then
                Begin
                  blnAtualizar := True;
                End
                Else
                If fMensagem('ATENÇÃO!', 'O CEP foi alterado, deseja atualizar o endereço?', ['&Sim', '&Não']) = 1 Then
                Begin
                  blnAtualizar := True;
                End

              End;

              If fEmptyStr(edtCodCid.Text) Or (blnAtualizar) Then
              Begin
                edtCodCid.Text := strCodCid;
                strCepAnt :=  edtCepEnt.Text;
                pCarregaCadCidade;
              End;

              If ((fEmptyStr(edtEndEnt.Text)) Or (blnAtualizar)) And (fEmptyStr(edtCodTra.Text)) Then
                edtEndEnt.Text := strEndere;

              If fEmptyStr(edtBaiEnt.Text) Or (blnAtualizar) Then
                edtBaiEnt.Text := strBairro;

              If (strCodCid <> edtCodCid.Text) And (Not fEmptyStr(strCodCid)) Then
              Begin
                Result := False;
                pMensagemOk('O CEP informado não pertence a cidade de ' + fRetNomCidade(edtCodCid.Text) + '!');
              End;

            End;

          End;

          If (Result) Then
            strCepAnt := edtCepEnt.Text;
      End;

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFatRomManutencaoEndereco.fValidaSelecao(blnMostraMensagem: Boolean): Boolean;
begin
  Result := True;

  if (rdgEntrega.ItemIndex = IDX_TRANSBORDO) and (cdsDocs.FieldByName('GER_ESPDOC').AsString = 'OX') then
  begin
    Result := False;
    if blnMostraMensagem then
      pMensagemOK('Não é possível selecionar um documento de espécie "Outras Entregas" para transbordo!');
  end;
end;

procedure TfrmFatRomManutencaoEndereco.cxgDocumentosTvGER_TIPENTGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  if AText = 'T' then
    AText := 'Transportadora'
  else if AText = 'B' then
    AText := 'Transbordo'
  else if AText = 'R' then
    AText := 'Retira Filial'
  else
    AText := '';
end;

procedure TfrmFatRomManutencaoEndereco.pAtualizaEntrega;
begin
  pnlTransp.Visible := False;
  pnlFilial.Visible := False;

  case rdgEntrega.ItemIndex of
    IDX_TRANSPORTADORA:
      begin
        lblTipEnt.Caption := 'Transportadora:';
        pnlTransp.Visible := True;
      end;
    IDX_TRANSBORDO, IDX_RETIRA_FILIAL:
      begin
        lblTipEnt.Caption := 'Filial:';
        pnlFilial.Visible := True;
      end;
  end;

  lblEndCon.Enabled := rdgEntrega.ItemIndex <> IDX_RETIRA_FILIAL;
  lblBaiCon.Enabled := rdgEntrega.ItemIndex <> IDX_RETIRA_FILIAL;
  lblComple.Enabled := rdgEntrega.ItemIndex <> IDX_RETIRA_FILIAL;
  lblCidade.Enabled := rdgEntrega.ItemIndex <> IDX_RETIRA_FILIAL;
  lblCep.Enabled    := rdgEntrega.ItemIndex <> IDX_RETIRA_FILIAL;
  lblEndRef.Enabled := rdgEntrega.ItemIndex <> IDX_RETIRA_FILIAL;
  edtEndEnt.Enabled := rdgEntrega.ItemIndex <> IDX_RETIRA_FILIAL;
  edtBaiEnt.Enabled := rdgEntrega.ItemIndex <> IDX_RETIRA_FILIAL;
  edtComple.Enabled := rdgEntrega.ItemIndex <> IDX_RETIRA_FILIAL;
  edtCodCid.Enabled := rdgEntrega.ItemIndex <> IDX_RETIRA_FILIAL;
  edtNomCid.Enabled := rdgEntrega.ItemIndex <> IDX_RETIRA_FILIAL;
  edtEstado.Enabled := rdgEntrega.ItemIndex <> IDX_RETIRA_FILIAL;
  edtCepEnt.Enabled := rdgEntrega.ItemIndex <> IDX_RETIRA_FILIAL;
  edtRefEnt.Enabled := rdgEntrega.ItemIndex <> IDX_RETIRA_FILIAL;
end;

procedure TfrmFatRomManutencaoEndereco.pCarregaCadCidade;
var
  qryCadCid: TUniQuery;
begin

  qryCadCid := fCriaQuery(Self);
  try
    qryCadCid.Close;
    qryCadCid.SQL.Text :=
    ' SELECT '+
    '   CID_NOMCID, '+
    '   CID_ESTADO '+
    ' FROM '+
    '   CADCID '+
    ' WHERE '+
    '   CID_CODCID = :CODCID ';

    qryCadCid.ParamByName('CODCID').AsString := edtCodCid.Text;
    qryCadCid.Open;

    edtNomCid.Text := qryCadCid.FieldByName('CID_NOMCID').AsString;
    edtEstado.Text := qryCadCid.FieldByName('CID_ESTADO').AsString;
  finally
    FreeAndNil(qryCadCid);
  end;
end;

procedure TfrmFatRomManutencaoEndereco.pCarregaCadFil;
var
  qryEnd: TUniQuery;
begin
  qryEnd := fCriaQuery(Self);
  try
    qryEnd.Close;
    qryEnd.SQL.Text :=
    ' SELECT '+
    '   EMP_NOMEMP, '+
    '   EMP_ENDERE, '+
    '   EMP_BAIRRO, '+
    '   EMP_C_E_P_, '+
    '   EMP_CODCID '+
    ' FROM '+
    '   CADEMP '+
    ' WHERE '+
    '   EMP_CODEMP = :CODEMP';

    qryEnd.ParamByName('CODEMP').AsString := edtCodFil.Text;
    qryEnd.Open;

    edtNomFil.Text := qryEnd.FieldByName('EMP_NOMEMP').AsString;
    edtEndEnt.Text := qryEnd.FieldByName('EMP_ENDERE').AsString;
    edtBaiEnt.Text := qryEnd.FieldByName('EMP_BAIRRO').AsString;
    edtCepEnt.Text := qryEnd.FieldByName('EMP_C_E_P_').AsString;
    edtCodCid.Text := qryEnd.FieldByName('EMP_CODCID').AsString;
  finally
    FreeAndNil(qryEnd);
  end;
end;

procedure TfrmFatRomManutencaoEndereco.pCarregaCadTra;
var
  qryEndTra: TUniQuery;
begin

  qryEndTra := fCriaQuery(Self);
  try
    qryEndTra.Close;
    qryEndTra.SQL.Text :=
    ' SELECT '+
    '   TRA_NOMTRA, '+
    '   TRA_ENDERE, '+
    '   TRA_BAIRRO, '+
    '   TRA_C_E_P_, '+
    '   TRA_CODCID '+
    ' FROM '+
    '   CADTRA '+
    ' WHERE '+
    '   TRA_CODTRA = :CODTRA ';

    qryEndTra.ParamByName('CODTRA').AsString := edtCodTra.Text;
    qryEndTra.Open;

    edtNomTra.Text := qryEndTra.FieldByName('TRA_NOMTRA').AsString;
    edtEndEnt.Text := qryEndTra.FieldByName('TRA_ENDERE').AsString;
    edtBaiEnt.Text := qryEndTra.FieldByName('TRA_BAIRRO').AsString;
    edtCepEnt.Text := qryEndTra.FieldByName('TRA_C_E_P_').AsString;
    edtCodCid.Text := qryEndTra.FieldByName('TRA_CODCID').AsString;
  finally
    FreeAndNil(qryEndTra);
  end;
end;

procedure TfrmFatRomManutencaoEndereco.pHabilitaDesabilitaCamposCapa(
  blnHabilita: Boolean);
begin
  pEnableConjuntoControles(gpbEnderecoEntrega, blnHabilita, [TEditFocus, TLabel, TRadioGroup, TBitBtnLocked], []);
  pEnableConjuntoControles(pnlTransp, blnHabilita, [TEditFocus], []);
  pEnableConjuntoControles(pnlFilial, blnHabilita, [TEditFocus], []);
end;

procedure TfrmFatRomManutencaoEndereco.pHabilitaDesabilitaGridSelecao(
  blnHabilita: Boolean);
begin
  cxgDocumentos.Enabled := blnHabilita;
  btnConfirma.Enabled := blnHabilita;
  btnDesmarcaTodos.Enabled := blnHabilita;
  btnMarcaTodos.Enabled := blnHabilita;
  btnOutroModo.Enabled := blnHabilita;
end;

procedure TfrmFatRomManutencaoEndereco.pMarcaDesmarca;
var
  blnMarca: Boolean;
begin
  blnMarca := cdsDocs.FieldByName('GER_TIPENT').AsString = '';

  if (blnMarca and fValidaSelecao(True)) or (not blnMarca) then
    pSelecionaDocumento(blnMarca);
end;

procedure TfrmFatRomManutencaoEndereco.rdgEntregaClick(Sender: TObject);
begin
  inherited;
  pAtualizaEntrega;
end;

function TfrmFatRomManutencaoEndereco.fDesmarcaTodos(pgbStatus: TcxProgressBar): Boolean;
var
  intRecNo: Integer;
begin
  if Assigned(cdsDocs) then
  begin
    intRecNo := cdsDocs.RecNo;

    cdsDocs.DisableControls;
    cdsDocs.First;
    While Not cdsDocs.Eof Do
    begin
      if cdsDocs.FieldByName('GER_TIPENT').AsString <> '' then
        pSelecionaDocumento(False);

      cdsDocs.Next;
      pProgresso(cdsDocs.RecNo, cdsDocs.RecordCount, pgbStatus);
    end;
    cdsDocs.RecNo := intRecNo;
    cdsDocs.EnableControls;
  end;
  Result := True;
end;

function TfrmFatRomManutencaoEndereco.fMarcaTodos(pgbStatus: TcxProgressBar): Boolean;
var
  intRecNo: Integer;
begin
  if Assigned(cdsDocs) then
  begin
    intRecNo := cdsDocs.RecNo;

    cdsDocs.DisableControls;
    cdsDocs.First;
    While Not cdsDocs.Eof Do
    begin
      if cdsDocs.FieldByName('GER_TIPENT').AsString = '' then
        pSelecionaDocumento(True);

      cdsDocs.Next;
      pProgresso(cdsDocs.RecNo, cdsDocs.RecordCount, pgbStatus);
    end;
    cdsDocs.RecNo := intRecNo;
    cdsDocs.EnableControls;
  end;
  Result := True;
end;

procedure TfrmFatRomManutencaoEndereco.pSelecionaDocumento(blnMarca: Boolean);
begin
  if not Assigned(cdsDocs) then
    Exit;

  if not cdsDocs.Active then
    Exit;

  if cdsDocs.IsEmpty then
    Exit;

  if blnMarca and (not fValidaSelecao(False)) then
    Exit;

  cdsDocs.Edit;
  if blnMarca then
  begin
    if rdgEntrega.Visible then
    begin
      case rdgEntrega.ItemIndex of
        IDX_TRANSPORTADORA: cdsDocs.FieldByName('GER_TIPENT').AsString := 'T';
        IDX_TRANSBORDO    : cdsDocs.FieldByName('GER_TIPENT').AsString := 'B';
        IDX_RETIRA_FILIAL : cdsDocs.FieldByName('GER_TIPENT').AsString := 'R';
      end;
    end
    else
      cdsDocs.FieldByName('GER_TIPENT').AsString := 'T';

    if AnsiMatchText(cdsDocs.FieldByName('GER_TIPENT').AsString, ['B', 'R']) then
      cdsDocs.FieldByName('GER_CODFIL').AsString := edtCodFil.Text;

    if AnsiMatchText(cdsDocs.FieldByName('GER_TIPENT').AsString, ['T', 'B']) then
    begin
      cdsDocs.FieldByName('GER_ENDCON_BAK').AsString := cdsDocs.FieldByName('GER_ENDCON').AsString;
      cdsDocs.FieldByName('GER_BAIRRO_BAK').AsString := cdsDocs.FieldByName('GER_BAIRRO').AsString;
      cdsDocs.FieldByName('GER_CEPCON_BAK').AsString := cdsDocs.FieldByName('GER_CEPCON').AsString;
      cdsDocs.FieldByName('CID_CODCID_BAK').AsString := cdsDocs.FieldByName('CID_CODCID').AsString;
      cdsDocs.FieldByName('GER_NOMCID_BAK').AsString := cdsDocs.FieldByName('GER_NOMCID').AsString;
      cdsDocs.FieldByName('GER_ESTADO_BAK').AsString := cdsDocs.FieldByName('GER_ESTADO').AsString;
      cdsDocs.FieldByName('GER_REFCON_BAK').AsString := cdsDocs.FieldByName('GER_REFCON').AsString;

      cdsDocs.FieldByName('GER_ENDCON').AsString := Trim(edtEndEnt.Text) + ' - ' + Trim(edtComple.Text);
      cdsDocs.FieldByName('GER_BAIRRO').AsString := edtBaiEnt.Text;
      cdsDocs.FieldByName('GER_CEPCON').AsString := edtCepEnt.Text;
      cdsDocs.FieldByName('CID_CODCID').AsString := edtCodCid.Text;
      cdsDocs.FieldByName('GER_NOMCID').AsString := edtNomCid.Text;
      cdsDocs.FieldByName('GER_ESTADO').AsString := edtEstado.Text;
      cdsDocs.FieldByName('GER_REFCON').AsString := edtRefEnt.Text;
    end;
  end
  else
  begin
    if AnsiMatchText(cdsDocs.FieldByName('GER_TIPENT').AsString, ['T', 'B'])  then
    begin
      cdsDocs.FieldByName('GER_ENDCON').AsString := cdsDocs.FieldByName('GER_ENDCON_BAK').AsString;
      cdsDocs.FieldByName('GER_BAIRRO').AsString := cdsDocs.FieldByName('GER_BAIRRO_BAK').AsString;
      cdsDocs.FieldByName('GER_CEPCON').AsString := cdsDocs.FieldByName('GER_CEPCON_BAK').AsString;
      cdsDocs.FieldByName('CID_CODCID').AsString := cdsDocs.FieldByName('CID_CODCID_BAK').AsString;
      cdsDocs.FieldByName('GER_NOMCID').AsString := cdsDocs.FieldByName('GER_NOMCID_BAK').AsString;
      cdsDocs.FieldByName('GER_ESTADO').AsString := cdsDocs.FieldByName('GER_ESTADO_BAK').AsString;
      cdsDocs.FieldByName('GER_REFCON').AsString := cdsDocs.FieldByName('GER_REFCON_BAK').AsString;
    end;

    cdsDocs.FieldByName('GER_CODFIL').AsString := '';
    cdsDocs.FieldByName('GER_TIPENT').AsString := '';
  end;

  cdsDocs.Post;
end;

procedure TfrmFatRomManutencaoEndereco.pSetDados(cdsTmpDoc: TUniClientDataSet);
begin
  cdsDocs := fCriaClientDatset(cdsTmpDoc);
  dtsDocs := fCriaDataSource(cdsDocs);
  cdsDocs.First;

  cxgDocumentosTv.DataController.DataSource := dtsDocs;
  cxgDocumentosTv.ApplyBestFit();

  cxgDocumentosTvGER_TIPENT.Width := 100;
  cxgDocumentosTvGER_CODFIL.Width := 30;

end;

end.
