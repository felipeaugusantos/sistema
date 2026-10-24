unit untRelatorioAcompanhamentoPix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, EditFocus, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, Uni, UniClientDataSet, cxCurrencyEdit,
  System.StrUtils, ComboBoxFocus, System.DateUtils, untTypesSistema,
  System.Json;

type
  TfrmRelatorioAcompanhamentoPix = class(TfrmPai)
    pnlFundo: TPanel;
    pnlHeader: TPanel;
    lblDocumento: TLabel;
    lblEmpresa: TLabel;
    lblEspecie: TLabel;
    edtDocumento: TEditFocus;
    edtEmpresa: TEditFocus;
    edtEspecie: TEditFocus;
    grpLegendaCores: TGroupBox;
    shpLegendaAlterados: TShape;
    lblDescricaoAlterados: TLabel;
    dbgConsulta: TcxGrid;
    dbgConsultaDados: TcxGridDBTableView;
    dbgConsultaDadosMPX_DTALOG: TcxGridDBColumn;
    dbgConsultaDadosMPX_HORLOG: TcxGridDBColumn;
    dbgConsultaDadosMPX_DESCRI: TcxGridDBColumn;
    dbgConsultaDadosMPX_NOMFRM: TcxGridDBColumn;
    dbgConsultaDadosMPX_OPELOG: TcxGridDBColumn;
    dbgConsultaDadosMPX_DTACAD: TcxGridDBColumn;
    dbgConsultaDadosMPX_HORCAD: TcxGridDBColumn;
    dbgConsultaDadosMPX_CODEMP: TcxGridDBColumn;
    dbgConsultaDadosMPX_VALPIX: TcxGridDBColumn;
    dbgConsultaDadosCTR_CODEMP: TcxGridDBColumn;
    dbgConsultaDadosMPX_STATUS: TcxGridDBColumn;
    dbgConsultaDadosMPX_TX_ID_: TcxGridDBColumn;
    dbgConsultaDadosMPX_QRCODE: TcxGridDBColumn;
    dbgConsultaDadosPORTADOR: TcxGridDBColumn;
    dbgConsultaDadosMPX_DTAREC: TcxGridDBColumn;
    dbgConsultaDadosMPX_HORREC: TcxGridDBColumn;
    dbgConsultaDadosMPX_VALREC: TcxGridDBColumn;
    dbgConsultaDadosMPX_SOLPAG: TcxGridDBColumn;
    dbgConsultaDadosMPX_INFPAG: TcxGridDBColumn;
    dbgConsultaDadosBANCO: TcxGridDBColumn;
    dbgConsultaDadosMPX_CHAPIX: TcxGridDBColumn;
    dbgConsultaDadosPLANOCONTAS: TcxGridDBColumn;
    dbgConsultaDadosMPX_OPEBAI: TcxGridDBColumn;
    dbgConsultaDadosMPX_RESCAI: TcxGridDBColumn;
    dbgConsultaDadosMPX_DTABAI: TcxGridDBColumn;
    dbgConsultaDadosMPX_SEQCON: TcxGridDBColumn;
    dbgConsultaDadosALTERACOES: TcxGridDBColumn;
    dbgConsultaDadosMPX_NOMEXE: TcxGridDBColumn;
    dbgConsultaDadosMPX_DTAEXE: TcxGridDBColumn;
    dbgConsultaDadosMPX_HOREXE: TcxGridDBColumn;
    dbgConsultaDadosMPX_VEREXE: TcxGridDBColumn;
    dbgConsultaLevel1: TcxGridLevel;
    lblCliente: TLabel;
    edtCliente: TEditFocus;
    pnlHeaderFiltros: TPanel;
    lblPeríodo: TLabel;
    grpLegendaCoresFiltro: TGroupBox;
    shpLegendaAlteradosFiltro: TShape;
    lblDescricaoAlteradosFiltro: TLabel;
    edtDataFinal: TcxDateEdit;
    lblPeriodoA: TLabel;
    edtDataInicial: TcxDateEdit;
    lblStatus: TLabel;
    cmbStatus: TComboBoxFocus;
    btnCarrCartoes: TBitBtnLocked;
    edtCodigoEmpresaFiltro: TEditFocus;
    lblEmpresaFiltro: TLabel;
    edtNomeEmpresaFiltro: TEditFocus;
    dbgConsultaDadosMPX_DOCPAG: TcxGridDBColumn;
    dbgConsultaDadosMPX_NOMPAG: TcxGridDBColumn;
    dbgConsultaDadosCLIENTE: TcxGridDBColumn;
    dbgConsultaDadosDOCUMENTOS: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure dbgConsultaDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCarrCartoesClick(Sender: TObject);
    procedure edtCodigoEmpresaFiltroExit(Sender: TObject);
    procedure edtCodigoEmpresaFiltroKeyPress(Sender: TObject; var Key: Char);
  private
    FTxIdPix,
    FEmpresaPix: String;

    FDatasetLogMPX: TUniClientDataset;

    FDataSourceLogMPX: TDataSource;

    FCorZebra: Integer;

    FTelaChamada: String;

    FArrayEmpresa: TConsultasArray;

    procedure CriaTemporaria;
    procedure DefineAlteracoes;

    function RetornaSQLRegistros: String;

    procedure GerarInformacoesDoJsonEnviado;
    procedure AdicionaDadosDoCliente(AJsonDevedor: String;
                                     var ANomeCliente: String);
    procedure AdicionaDadosDocumentos(AJsonInfoAdicionais: String;
                                      var ADocumentos,
                                          ANomeCliente: String);
    function RetornaNomeClienteDocumento(ADocumento: String): String;
    function RetornaDocumentosPix(Var ANomeCLiente: String): String;
    { Private declarations }
  public
    property TxIdPix: String read FTxIdPix write FTxIdPix;
    property EmpresaPix: String read FEmpresaPix write FEmpresaPix;
    property TelaChamada: String read FTelaChamada write FTelaChamada;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation
Uses untGravando, untFuncoesSimples, untConsultas, untPesqAux, untFuncoesConsulta,
     untTFuncoesAuxiliaresPix;

{$R *.dfm}

procedure TfrmRelatorioAcompanhamentoPix.AdicionaDadosDoCliente(
  AJsonDevedor: String; var ANomeCliente: String);
  Var
    LDocumentoCliente: String;
begin
  ANomeCliente := EmptyStr;

  If AJsonDevedor.IsEmpty Then
    Exit;

  Try
    LDocumentoCliente := TFuncoesPix.RetornaValorCampoJson('cpf', AJsonDevedor);
    If LDocumentoCliente.IsEmpty Then
      LDocumentoCliente := TFuncoesPix.RetornaValorCampoJson('cnpj', AJsonDevedor);

    ANomeCliente := fCampoTabela('CONCAT(CLI_CODCLI, "-", CLI_NOMCLI)',
                                 'CADCLI',
                                 ['CLI_C_G_C_'],
                                 [LDocumentoCliente],
                                 False);

    If ANomeCliente.IsEmpty Then
      ANomeCliente := Concat(LDocumentoCliente, '-',
                             TFuncoesPix.RetornaValorCampoJson('nome', AJsonDevedor));
  Except
    ANomeCliente := EmptyStr;
  End;
end;

procedure TfrmRelatorioAcompanhamentoPix.AdicionaDadosDocumentos(
  AJsonInfoAdicionais: String; var ADocumentos, ANomeCliente: String);
  Var
    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LValorAuxiliar: String;
begin
  ADocumentos := EmptyStr;
  If FDatasetLogMPX.FieldByName('MPX_CRIADO').AsString = 'PEDIDO' Then
    ADocumentos := FDatasetLogMPX.FieldByName('MPX_SOLPAG').AsString
                                 .Replace('Pix gerado referente ao pedido ', EmptyStr) +
                                 '-PD-' + FDatasetLogMPX.FieldByName('MPX_CODEMP').AsString;

  If Not AJsonInfoAdicionais.IsEmpty Then
  Begin
    ADocumentos := EmptyStr;

    LJsonArray := TJSONObject.ParseJSONValue(AJsonInfoAdicionais) as TJSONArray;

    For LJsonValue In LJsonArray Do
    Begin
      LValorAuxiliar := LJsonValue.GetValue<String>('nome').Replace('Pedido número ', EmptyStr);

      ADocumentos := ADocumentos +
                     LValorAuxiliar + ', ';

      If ANomeCliente.IsEmpty Then
      Begin
        ANomeCliente := RetornaNomeClienteDocumento(LValorAuxiliar);
      End;
    End;

    ADocumentos := LeftStr(ADocumentos, ADocumentos.Length - 2);

    FreeAndNil(LJsonArray);
  End;

  If ADocumentos.IsEmpty Then
    ADocumentos := RetornaDocumentosPix(ANomeCliente);
end;

procedure TfrmRelatorioAcompanhamentoPix.btnCarrCartoesClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  TfrmGravando.fExecutarModal(CriaTemporaria, 'Aguarde... Carregando dados.', '');
end;

procedure TfrmRelatorioAcompanhamentoPix.CriaTemporaria;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := RetornaSQLRegistros;

    If FTelaChamada = 'frmRelacaoPedidosPixGerados' Then
    Begin
      LConsulta.ParamByName('CODEMP').AsString := FEmpresaPix;
      LConsulta.ParamByName('TX_ID_').AsString := FTxIdPix;
    End
    Else
    Begin
      LConsulta.ParamByName('DTAINI').AsDateTime := edtDataInicial.Date;
      LConsulta.ParamByName('DTAFIN').AsDateTime := edtDataFinal.Date;
    End;

    LConsulta.Open;

    FDatasetLogMPX := fCriaClientDatSet(LConsulta);
    FDatasetLogMPX.Open;

    GerarInformacoesDoJsonEnviado;

    DefineAlteracoes;

    FDataSourceLogMPX := fCriaDataSource(FDatasetLogMPX);
    FDataSourceLogMPX.AutoEdit := False;

    dbgConsultaDados.DataController.DataSource := FDataSourceLogMPX;

    pSetFocus(dbgConsulta);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmRelatorioAcompanhamentoPix.dbgConsultaDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    LAlterado: Boolean;

    LValorAlteracoes: String;
begin
  inherited;

  LValorAlteracoes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgConsultaDadosALTERACOES.Index]);

  LAlterado := LValorAlteracoes <> '';
  If LAlterado Then
    LAlterado := Pos(TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName, LValorAlteracoes) > 0;

  If LAlterado then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Brush.Color := $4433CC
    Else
      ACanvas.Brush.Color := $8070FF;
  end
  Else
  Begin
    If (not AViewInfo.Selected) Then
    Begin
      If Odd(AViewInfo.GridRecord.Index) Then
        ACanvas.Brush.Color := FCorZebra
      Else
        ACanvas.Brush.Color := clWindow;
    End;
  End;

  ACanvas.Font.Color := clBlack;
end;

procedure TfrmRelatorioAcompanhamentoPix.DefineAlteracoes;
  var
    LarrRef: Array of String;

    LRegistroAtual,
    LCamposDiferentes: String;

    LIndice: Integer;
begin
  FDatasetLogMPX.DisableControls;

  SetLength(LarrRef, FDatasetLogMPX.Fields.Count);

  FDatasetLogMPX.First;

  LRegistroAtual := '';

  While not FDatasetLogMPX.Eof Do
  Begin
    If (LRegistroAtual <> FDatasetLogMPX.FieldByName('MPX_TX_ID_').AsString) Then
    Begin
      LRegistroAtual := FDatasetLogMPX.FieldByName('MPX_TX_ID_').AsString;
      For LIndice := 0 To FDatasetLogMPX.Fields.Count - 1 do
        LarrRef[LIndice] := FDatasetLogMPX.Fields[LIndice].AsString;
    End
    Else
    Begin
      LCamposDiferentes := '/';

      For LIndice := 0 To FDatasetLogMPX.Fields.Count - 1 do
      Begin
        If (LarrRef[LIndice] <> FDatasetLogMPX.Fields[LIndice].AsString) Then
        Begin
          If Not MatchStr(FDatasetLogMPX.Fields[LIndice].FieldName,
                          ['AUTOINCREM', 'MPX_DTALOG', 'MPX_HORLOG, MPX_DESCRI, MPX_NOMFRM, MPX_OPELOG']) Then
            LCamposDiferentes := LCamposDiferentes + FDatasetLogMPX.Fields[LIndice].FieldName + '/';
        End;
      End;

      FDatasetLogMPX.Edit;
      FDatasetLogMPX.FieldByName('ALTERACOES').AsString := LCamposDiferentes;
      FDatasetLogMPX.Post;

      For LIndice := 0 To FDatasetLogMPX.Fields.Count - 1 do
        LarrRef[LIndice] := FDatasetLogMPX.Fields[LIndice].AsString;
    End;

    FDatasetLogMPX.Next;
  End;

  FDatasetLogMPX.EnableControls;
  FDatasetLogMPX.First;
end;

procedure TfrmRelatorioAcompanhamentoPix.edtCodigoEmpresaFiltroExit(
  Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodigoEmpresaFiltro, edtNomeEmpresaFiltro, FArrayEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa', 3);
end;

procedure TfrmRelatorioAcompanhamentoPix.edtCodigoEmpresaFiltroKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodigoEmpresaFiltro, edtNomeEmpresaFiltro, Nil, Key, FArrayEmpresa, False, fEmptyStr(strEmpAcessoUsuarioLogado)) Then
  Begin
    If fValidaCampos(edtCodigoEmpresaFiltro) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelatorioAcompanhamentoPix.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(FDataSourceLogMPX) Then
    FreeAndNil(FDataSourceLogMPX);

  If Assigned(FDatasetLogMPX) Then
    FreeAndNil(FDatasetLogMPX);
end;

procedure TfrmRelatorioAcompanhamentoPix.FormCreate(Sender: TObject);
begin
  inherited;
  edtDataInicial.Date := IncDay(VS_Date, -1);
  edtDataFinal.Date := VS_Date;

  FCorZebra := StrToIntDef(fCfgSis('CORZEB'), clWhite);

  FTelaChamada := '';
end;

procedure TfrmRelatorioAcompanhamentoPix.FormShow(Sender: TObject);
begin
  inherited;
  pnlHeader.Visible := FTelaChamada = 'frmRelacaoPedidosPixGerados';
  pnlHeaderFiltros.Visible := FTelaChamada.IsEmpty;

  dbgConsultaDados.OptionsView.GroupByBox := False;

  TfrmGravando.fExecutarModal(CriaTemporaria, 'Aguarde... Carregando dados.', '');
end;

function TfrmRelatorioAcompanhamentoPix.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    LIndice: Integer;
begin
  Result := True;

  If Not pnlHeaderFiltros.Visible Then
    Exit;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {**********************}
    {* VALIDAÇÃO DE DATAS *}
    {*******************LE*}
    If (Sender = edtDataFinal) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(edtDataFinal.Text))) And (StrToDateDef(edtDataFinal.Text, 0) <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'A Data Final do período informada é inválida!', ['&Ok']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(edtDataFinal.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(edtDataInicial.Text))) Then
      Begin
        fMensagem('ATENÇÃO', 'O campo Data Final do período deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(edtDataFinal.Text))) And fEmptyStr(fTiraCaracEspeciais(edtDataInicial.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'O campo Data Inicial do período deve ser preenchido!', ['&Ok']);
          Result := False;
          Sender := edtDataInicial;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(edtDataFinal.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(edtDataInicial.Text))) Then
          Begin
            If StrToDate(edtDataInicial.Text) > StrToDate(edtDataFinal.Text) Then
            Begin
              fMensagem('ATENÇÃO','A Data Inicial do período deve ser menor que a Data Final do período!',['&Ok']);
              Result := False;
              Sender := edtDataInicial;
            End;
          End;
        End;
      End;
    End
    Else If (Sender = edtDataInicial) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(edtDataInicial.Text))) and (StrToDateDef(edtDataInicial.Text, 0) <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'A Data Inicial do período informada é inválida!', ['&Ok']);
        Result := False;
        Sender := edtDataInicial;
      End;
    End

    Else If (Sender = edtCodigoEmpresaFiltro) Then
    Begin
      If ((Not fEmptyStr(edtCodigoEmpresaFiltro.Text)) Or (High(FArrayEmpresa) >= 0)) And (fEmptyStr(strEmpAcessoUsuarioLogado)) Then
      Begin
        If (High(FArrayEmpresa) >= 0 ) Then
        Begin
          For LIndice := 0 To High(FArrayEmpresa) Do
          Begin
            If Pos(FArrayEmpresa[LIndice].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
            Begin
              fMensagem('ATENÇÃO', 'Usuário sem permissão de acesso a empresa + ' + FArrayEmpresa[LIndice].strCodigo + '!', ['&Ok']);
              Result := False;
              Break;
            End;
          End;
        End
        Else If Pos(edtCodigoEmpresaFiltro.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelatorioAcompanhamentoPix.GerarInformacoesDoJsonEnviado;
  Var
    LTextoJson,

    LNomeCliente,
    LDocumentos: String;
begin
  FDatasetLogMPX.DisableControls;
  Try
    FDatasetLogMPX.First;

    While Not FDatasetLogMPX.Eof Do
    Begin
      LNomeCliente := EmptyStr;
      LDocumentos := EmptyStr;

      LTextoJson := FDatasetLogMPX.FieldByName('MPX_JSOENV').AsString;

      If LTextoJson.IsEmpty Then
      Begin
        FDatasetLogMPX.Next;
        Continue;
      End;

      If FDatasetLogMPX.FieldByName('MPX_USASHP').AsString = 'S' Then
      Begin
        FDatasetLogMPX.Next;
        Continue;
      End;

      Try
        AdicionaDadosDoCliente(TFuncoesPix.RetornaValorCampoJson('devedor', LTextoJson, True),
                               LNomeCliente);

        AdicionaDadosDocumentos(TFuncoesPix.RetornaValorCampoJson('infoAdicionais', LTextoJson, True),
                                LDocumentos,
                                LNomeCliente);

        FDatasetLogMPX.Edit;
        FDatasetLogMPX.FieldByName('CLIENTE').AsString := LNomeCliente;
        FDatasetLogMPX.FieldByName('DOCUMENTOS').AsString := LDocumentos;
        FDatasetLogMPX.Post;
      Except

      End;

      FDatasetLogMPX.Next;
    End;
  Finally
    FDatasetLogMPX.First;
    FDatasetLogMPX.EnableControls;
  End;
end;

function TfrmRelatorioAcompanhamentoPix.RetornaDocumentosPix(
  var ANomeCLiente: String): String;
  Var
    LConsulta: TUniQuery;

    LSQL: String;
begin
  LSQL := 'SELECT CONCAT(R.CTR_NUMDUP, "-", R.CTR_ESPDOC, "-", R.CTR_CODEMP) AS DOCUMENTO, ' +
          '       CONCAT(R.CTR_CODCLI, "-", C.CLI_NOMCLI) AS CLIENTE ' +
          'FROM LOGCTR R ' +
          'JOIN CADCLI C ON C.CLI_CODCLI=R.CTR_CODCLI ' +
          'WHERE ';

  If FDatasetLogMPX.FieldByName('MPX_SEQCON').IsNull Then
    LSQL := LSQL + '     R.CTR_EMPPIX="' + FDatasetLogMPX.FieldByName('MPX_CODEMP').AsString + '" ' +
                   ' AND R.CTR_TX_PIX="' + FDatasetLogMPX.FieldByName('MPX_TX_ID_').AsString + '" '
  Else
    LSQL := LSQL + '     R.CTR_SEQCON=' + FDatasetLogMPX.FieldByName('MPX_SEQCON').AsString + ' ' +
                   ' AND R.CTR_EMPBAI="' + FDatasetLogMPX.FieldByName('MPX_CODEMP').AsString + '" ' +
                   ' AND R.CTR_DTAREC="' + FormatDateTime('yyyy/mm/dd', FDatasetLogMPX.FieldByName('MPX_DTAREC').AsDateTime) + '"';

  LSQL := LSQL + ' GROUP BY CONCAT(R.CTR_NUMDUP, "-", R.CTR_ESPDOC, "-", R.CTR_CODEMP)';

  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;

    Result := EmptyStr;

    While Not LConsulta.Eof Do
    Begin
      Result := Result + LConsulta.FieldByName('DOCUMENTO').AsString + ', ';

      If ANomeCliente.IsEmpty Then
        ANomeCliente := LConsulta.FieldByName('CLIENTE').AsString;

      LConsulta.Next;
    End;

    Result := LeftStr(Result, Result.Length - 2);
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TfrmRelatorioAcompanhamentoPix.RetornaNomeClienteDocumento(
  ADocumento: String): String;
  Var
    LConsulta: TUniQuery;

    LSQL: String;
begin
  If ADocumento.IsEmpty Then
    Exit(EmptyStr);

  LSQL := 'SELECT CONCAT(R.CTR_CODCLI, "-", C.CLI_NOMCLI) AS CLIENTE ' +
          'FROM LOGCTR R ' +
          'JOIN CADCLI C ON C.CLI_CODCLI=R.CTR_CODCLI' +
          'WHERE R.CTR_NUMDUP="' + ADocumento.Split(['-'])[0] + '" ' +
          '  AND R.CTR_ESPDOC="' + ADocumento.Split(['-'])[1] + '" ' +
          '  AND R.CTR_CODEMP="' + ADocumento.Split(['-'])[2] + '" ';

  If FDatasetLogMPX.FieldByName('MPX_SEQCON').IsNull Then
    LSQL := LSQL + ' AND R.CTR_EMPPIX="' + FDatasetLogMPX.FieldByName('MPX_CODEMP').AsString + '" ' +
                   ' AND R.CTR_TX_PIX="' + FDatasetLogMPX.FieldByName('MPX_TX_ID_').AsString + '" '
  Else
    LSQL := LSQL + ' AND R.CTR_SEQCON=' + FDatasetLogMPX.FieldByName('MPX_SEQCON').AsString + ' ' +
                   ' AND R.CTR_EMPBAI="' + FDatasetLogMPX.FieldByName('MPX_CODEMP').AsString + '" ' +
                   ' AND R.CTR_DTAREC="' + FormatDateTime('yyyy/mm/dd', FDatasetLogMPX.FieldByName('MPX_DTAREC').AsDateTime) + '"';

  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;

    Result := LConsulta.FieldByName('CLIENTE').AsString;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TfrmRelatorioAcompanhamentoPix.RetornaSQLRegistros: String;
begin
  Result := '';

  If FTelaChamada = 'frmRelacaoPedidosPixGerados' Then
  Begin
    Result := 'SELECT M.*, ' +
              '       CONCAT(P.POR_CODPOR, "-", P.POR_NOMPOR) AS PORTADOR, ' +
              '       CONCAT(B.BCO_CODBCO, "-", B.BCO_NOMBCO) AS BANCO, ' +
              '       CONCAT(CT.CTA_CODCTA, "-", CT.CTA_DESCTA) AS PLANOCONTAS, ' +
              '       CAST("" AS CHAR(7000)) AS ALTERACOES, ' +
              '       CAST("" AS CHAR(250)) AS CLIENTE, ' +
              '       CAST("" AS CHAR(7000)) AS DOCUMENTOS, ' +
              '       CASE ' +
              '         WHEN M.MPX_STATUS = "cancelled" THEN "REMOVIDA_PELO_USUARIO_RECEBEDOR" ' +
              '         WHEN M.MPX_STATUS = "refunded" THEN "DEVOLVIDO" ' +
              '         WHEN M.MPX_STATUS = "approved" THEN "CONCLUIDA" ' +
              '         WHEN M.MPX_STATUS IN ("ATIVACC", "pending", "pendingv", "pendingvCC") THEN "ATIVA" ' +
              '         ELSE M.MPX_STATUS ' +
              '       END AS STATUS ' +
              'FROM LOGMPX M ' +
              'LEFT JOIN CCAPIX PX ON PX.AUTOINCREM=M.MPX_SEQPIX ' +
              'LEFT JOIN CADCCA C ON C.AUTOINCREM=PX.PIX_SEQCCA ' +
              'LEFT JOIN CADBCO B ON B.BCO_CODBCO=C.CCA_CODBCO ' +
              'LEFT JOIN CADPOR P ON P.POR_CCAAUT=C.AUTOINCREM ' +
              'LEFT JOIN CADCTA CT ON CT.CTA_CODCTA=M.MPX_CTABAI ' +
              'WHERE M.MPX_CODEMP=:CODEMP ' +
              '  AND M.MPX_TX_ID_=:TX_ID_ ' +
              'ORDER BY M.MPX_DTALOG, ' +
              '         M.MPX_HORLOG ';
    Exit;
  End;

  If FTelaChamada.IsEmpty Then
  Begin
    Result := 'SELECT M.*, ' +
              '       CONCAT(P.POR_CODPOR, "-", P.POR_NOMPOR) AS PORTADOR, ' +
              '       CONCAT(B.BCO_CODBCO, "-", B.BCO_NOMBCO) AS BANCO, ' +
              '       CONCAT(CT.CTA_CODCTA, "-", CT.CTA_DESCTA) AS PLANOCONTAS, ' +
              '       CAST("" AS CHAR(7000)) AS ALTERACOES, ' +
              '       CAST("" AS CHAR(250)) AS CLIENTE, ' +
              '       CAST("" AS CHAR(7000)) AS DOCUMENTOS, ' +
              '       CASE ' +
              '         WHEN M.MPX_STATUS = "cancelled" THEN "REMOVIDA_PELO_USUARIO_RECEBEDOR" ' +
              '         WHEN M.MPX_STATUS = "refunded" THEN "DEVOLVIDO" ' +
              '         WHEN M.MPX_STATUS = "approved" THEN "CONCLUIDA" ' +
              '         WHEN M.MPX_STATUS IN ("ATIVACC", "pending", "pendingv", "pendingvCC") THEN "ATIVA" ' +
              '         ELSE M.MPX_STATUS ' +
              '       END AS STATUS ' +
              'FROM LOGMPX M ' +
              'LEFT JOIN CCAPIX PX ON PX.AUTOINCREM=M.MPX_SEQPIX ' +
              'LEFT JOIN CADCCA C ON C.AUTOINCREM=PX.PIX_SEQCCA ' +
              'LEFT JOIN CADBCO B ON B.BCO_CODBCO=C.CCA_CODBCO ' +
              'LEFT JOIN CADPOR P ON P.POR_CCAAUT=C.AUTOINCREM ' +
              'LEFT JOIN CADCTA CT ON CT.CTA_CODCTA=M.MPX_CTABAI ' +
              'WHERE M.MPX_DTALOG BETWEEN :DTAINI AND :DTAFIN ';

    If fEmptyStr(edtCodigoEmpresaFiltro.Text) Then
      Result := Result + '  AND M.MPX_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') '
    Else
      Result := Result + '  AND M.MPX_CODEMP IN (' + fRetArrToSQLIn(FArrayEmpresa, edtCodigoEmpresaFiltro.Text) + ') ';

    Result := Result + ' AND (SELECT IFNULL(COUNT(AUTOINCREM), 0) ' +
                       '      FROM LOGMPX ' +
                       '      WHERE MPX_CODEMP=M.MPX_CODEMP ' +
                       '        AND MPX_TX_ID_=M.MPX_TX_ID_ ';

    Case cmbStatus.ItemIndex Of
      0: Result := Result + '    AND MPX_STATUS IN ("DEVOLVIDO", "refunded") ';
      1: Result := Result + '    AND MPX_DESCRI="EXCLUSÃO PIX EXPIRADO" ';
      2: Result := Result + '    AND MPX_STATUS NOT IN ("DEVOLVIDO", "refunded") AND ' +
                            '        MPX_DESCRI IN ("EXCLUSÃO - REMOÇÃO MANUAL", "EXCLUSÃO - ALTERAÇÃO CONDIÇÃO DE PAGAMENTO", ' +
                            '                       "ESTORNO - RECEBER RESCAI", "EXCLUSÃO - ESTORNO RECEBER") ';
      3: Result := Result + '    AND (MPX_STATUS IN ("DEVOLVIDO", "refunded") OR ' +
                            '         MPX_DESCRI IN ("EXCLUSÃO PIX EXPIRADO", "EXCLUSÃO - REMOÇÃO MANUAL", ' +
                            '                        "EXCLUSÃO - ALTERAÇÃO CONDIÇÃO DE PAGAMENTO", ' +
                            '                        "ESTORNO - RECEBER RESCAI", "EXCLUSÃO - ESTORNO RECEBER")) ';
    End;

    Result := Result + ') > 0 ';

    Result := Result + 'ORDER BY M.MPX_CODEMP, ' +
                       '         M.MPX_TX_ID_, ' +
                       '         M.MPX_DTALOG, ' +
                       '         M.MPX_HORLOG ';
  End;
end;



end.
