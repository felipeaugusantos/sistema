unit untReimpressaoCompInspecao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, EditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxGroupBox, cxRadioGroup, Uni, cadastro.Model.ContratoLocacaoEquipamentos,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, DBAccess,
  Datasnap.DBClient, UniClientDataSet, untTypesSistema, Datasnap.Provider,
  UniDataSetProvider, faturamento.Classes.ImpressaoLocEqu,
  untTypesLocEqu, untTLock, untFuncoesLocEqu;

type
  TfrmReimpressaoCompInspecao = class(TfrmPai)
    pnlPeriodo: TPanel;
    pnlDadosContrato: TPanel;
    lblNumCon: TLabel;
    lblCodCli: TLabel;
    edtNumCon: TEditFocus;
    edtNomCli: TEditFocus;
    edtCodCli: TEditFocus;
    lblDtaInspSai: TLabel;
    mskDtaIspSaiIni: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    lblEmpresa: TLabel;
    lblDtaInspEnt: TLabel;
    mskDtaIspEntIni: TMaskEditFocus;
    btnImprimir: TBitBtnLocked;
    pnlPrincipal: TPanel;
    cxGridInspecoesView: TcxGridDBTableViewCitel;
    cxGridInspecoesLevel1: TcxGridLevel;
    cxGridInspecoes: TcxGridCitel;
    cdsInspecoes: TUniClientDataSet;
    dtsInspecoes: TUniDataSource;
    cdsInspecoesEQL_NROCON: TStringField;
    cdsInspecoesEQD_ISPSAI: TDateTimeField;
    cdsInspecoesEQD_ISPENT: TDateTimeField;
    cxGridInspecoesViewEQL_NROCON: TcxGridDBColumn;
    cxGridInspecoesViewEQD_ISPSAI: TcxGridDBColumn;
    cxGridInspecoesViewEQD_ISPENT: TcxGridDBColumn;
    mskDtaIspSaiFim: TMaskEditFocus;
    mskDtaIspEntFim: TMaskEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    cdsInspecoesCLI_NOMCLI: TStringField;
    cxGridInspecoesViewCLI_NOMCLI: TcxGridDBColumn;
    cdsInspecoesEQD_MARDES: TStringField;
    cdsInspecoesEQD_SEQEQL: TStringField;
    cxGridInspecoesViewEQD_MARDES: TcxGridDBColumn;
    cxGridInspecoesViewEQD_SEQEQL: TcxGridDBColumn;
    cdsInspecoesEQD_SEQCON: TStringField;
    btnCarrega: TBitBtnLocked;
    pnlLegenda: TPanel;
    lblMarca: TLabel;
    Label3: TLabel;
    cdsInspecoesEQD_DESCRI: TStringField;
    cxGridInspecoesViewEQD_DESCRI: TcxGridDBColumn;
    cdsInspecoesAUTOINCREM: TStringField;

    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumConKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCarregaClick(Sender: TObject);
    procedure cxGridInspecoesViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridInspecoesViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure cxGridInspecoesViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    qryCli,
    qryEntCli: TUniQuery;
    ObjContratoFiltro: TContratoLocacaoEquipamentos;
    ObjContratoSelecao: TContratoLocacaoEquipamentos;
    ObjImpressao: TImpressaoContrato;
    strCodEmp: String;
    strNroCon: String;
    strCodCli: String;

    arrCodEmp: TConsultasArray;
    arrNroCon: TConsultasArray;
    arrCodCli: TConsultasArray;
    FobjLock: TLock;

    procedure pLimparCampos;
    procedure pCarregarClienteFiltro;
    procedure pCarregarEmpresaFiltro;
    procedure pCarregarDados;
    procedure pMarcarInspecao(blnMarcar: Boolean);
    procedure pImprimirInspecao(const ACodEql: String; ASeqEql: String);
    procedure pImprimir;

    function fCarregarContrato(const strAutInc, strNumeroContrato: String): Boolean;
    function fGetSQL: String;
    function fValidaItensSelecionados: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untPesqAux, untGravando, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmReimpressaoCompInspecao.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrCodEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmReimpressaoCompInspecao.edtNumConKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqContratoLocEquip(Self, edtNumCon, Nil, Nil, Key, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmReimpressaoCompInspecao.fCarregarContrato(const strAutInc,
  strNumeroContrato: String): Boolean;
begin
  pLimparCampos;
  ObjContratoFiltro.pLimpar;
  ObjContratoFiltro.fCarregarContrato(strAutInc, strNumeroContrato);

  If fEmptyStr(ObjContratoFiltro.NroContrato) Then
  Begin
    fMensagem('ATENÇÃO', 'Contrato não encontrado!', ['&Ok']);
    Result := False;
    Exit;
  End;

  If (Not fValidaTravasContrato(ObjContratoFiltro.AutInc)) Then
  Begin
    Exit(False);
  End;

  If Not(fEmptyStr(ObjContratoFiltro.AutInc)) Then
    FobjLock.fLock_Unlock(cst_TRAVA_REIMPC_LOCEQU + ObjContratoFiltro.AutInc, True, False);

  Result := True;
end;

function TfrmReimpressaoCompInspecao.fGetSQL: String;
var
  SQLConsulta: String;
begin
  SQLConsulta :=  'SELECT C.AUTOINCREM AS EQD_SEQCON,                       ' +
                  '   C.EQL_CODCLI,                                         ' +
                  '   CLI_NOMCLI,                                           ' +
                  '   C.EQL_NROCON,                                         ' +
                  '   E.EQD_SEQEQL,                                         ' +
                  '   EQL_DESCRI,                                           ' +
                  '   E.EQD_DTAIPE,                                         ' +
                  '   E.EQD_HORIPE,                                         ' +
                  '   E.EQD_DTAIPS,                                         ' +
                  '   E.EQD_HORIPS,                                         ' +
                  '   "D" AS EQD_MARDES,                                    ' +
                  '   E.AUTOINCREM                                          ' +
                  ' FROM CONEQL C                                           ' +
                  ' INNER JOIN EQLDET E ON C.AUTOINCREM = E.EQD_SEQCON      ' +
                  ' INNER JOIN CADEQL   ON E.EQD_SEQEQL = EQL_CODIGO        ' +
                  ' INNER JOIN CADCLI   ON C.EQL_CODCLI = CLI_CODCLI        ' +
                  ' WHERE TRUE                                              ';

  If Not fEmptyStr(edtCodEmp.Text) Then
    SQLConsulta := SQLConsulta  + '  AND C.EQL_CODEMP = :CODEMP ';

  If Not fEmptyStr(edtNumCon.Text) Then
    SQLConsulta := SQLConsulta  + '  AND C.EQL_NROCON = :NROCON ';

  If Not fEmptyStr(edtCodCli.Text) Then
    SQLConsulta := SQLConsulta  + '  AND C.EQL_CODCLI = :CODCLI ';

  If Not fEmptyDate(mskDtaIspSaiIni.Text) Then
    SQLConsulta := SQLConsulta  +  ' AND E.EQD_DTAIPS >= :DTAIPSINI ';

  If Not fEmptyDate(mskDtaIspSaiFim.Text) Then
    SQLConsulta := SQLConsulta  +  ' AND E.EQD_DTAIPS <= :DTAIPSFIM ';

  If Not fEmptyDate(mskDtaIspEntIni.Text) Then
    SQLConsulta := SQLConsulta  +  ' AND E.EQD_DTAIPE >= :DTAIPESINI ';

  If Not fEmptyDate(mskDtaIspEntFim.Text) Then
    SQLConsulta := SQLConsulta  +  ' AND E.EQD_DTAIPE <= :DTAIPEFIM ';

  SQLConsulta := SQLConsulta  +  ' AND ((E.EQD_DTAIPS IS NOT NULL) OR (E.EQD_DTAIPE IS NOT NULL))';
  SQLConsulta := SQLConsulta  +  ' AND C.EQL_STATUS <> "O"';

  Result := SQLConsulta;
end;

procedure TfrmReimpressaoCompInspecao.FormCreate(Sender: TObject);
begin
  inherited;

  qryCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryEntCli := fCriarQuery('SELECT ENTCLI.AUTOINCREM, CONCAT(ETC_ENDENT, " - ", ETC_BAIENT, " - ", CID_NOMCID, " - ", CID_ESTADO) AS ETC_ENDENT FROM ENTCLI INNER JOIN CADCID ON CID_CODCID = ETC_CIDENT WHERE ETC_CODCLI = :CODCLI AND ETC_SITUAC = "A"', Self);
  ObjContratoFiltro := TContratoLocacaoEquipamentos.Create;
  ObjContratoSelecao := TContratoLocacaoEquipamentos.Create;
  ObjImpressao := TImpressaoContrato.Create;

  cdsInspecoes.CreateDataSet;
  pLimparCampos;
  FobjLock := TLock.Create;
  Self.WindowState := wsMaximized;
end;

procedure TfrmReimpressaoCompInspecao.FormDestroy(Sender: TObject);
begin
  inherited;

  FobjLock.fLock_Unlock(cst_TRAVA_REIMPC_LOCEQU + ObjContratoFiltro.AutInc, False, False);
  FreeAndNil(FobjLock);
  FreeAndNil(qryEntCli);
  FreeAndNil(qryCli);
  FreeAndNil(ObjContratoFiltro);
  FreeAndNil(ObjContratoSelecao);
  FreeAndNil(ObjImpressao);
end;

procedure TfrmReimpressaoCompInspecao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnImprimir.Click;
  End;
end;

procedure TfrmReimpressaoCompInspecao.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIspSaiIni);
end;

function TfrmReimpressaoCompInspecao.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = mskDtaIspSaiFim) and Not fEmptyDate(mskDtaIspSaiFim.Text) Then
    Begin
      If fEmptyDate(mskDtaIspSaiIni.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe a data inicial de Inspeção de Saída!', ['&O k']);
        Result := False;
      End
      Else If StrToDate(mskDtaIspSaiFim.Text) < StrToDate(mskDtaIspSaiIni.Text) Then
      Begin
        fMensagem('ATENÇÃO!','A data de inspeção final de saída deve ser maior que a data de inspeção inicial de saída!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaIspEntFim) and Not fEmptyDate(mskDtaIspEntFim.Text) Then
    Begin
      If fEmptyDate(mskDtaIspEntIni.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe a data inicial de Inspeção de Entrada!', ['&O k']);
        Result := False;
      End
      Else If StrToDate(mskDtaIspEntFim.Text) < StrToDate(mskDtaIspEntIni.Text) Then
      Begin
        fMensagem('ATENÇÃO!','A data de inspeção final de entrada deve ser maior que a data de inspeção inicial de entrada!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      pCarregarEmpresaFiltro;
      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          edtCodEmp.Clear;
          edtNomEmp.Clear;

          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtNumCon) Then
    Begin
      If Not fEmptyStr(edtNumCon.Text) Then
        Result := fCarregarContrato('', edtNumCon.Text);
    End

    Else If (Sender = edtCodCli) Then
    Begin
      pCarregarClienteFiltro;
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        If qryCli.FieldByName('CLI_STATUS').AsString <> 'A' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente está inativo!', ['&O k']);
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmReimpressaoCompInspecao.fValidaItensSelecionados: Boolean;
begin
  cdsInspecoes.Filter := 'EQD_MARDES = ' + QuotedStr('M');
  cdsInspecoes.Filtered := True;

  Result := cdsInspecoes.RecordCount > 0;

  cdsInspecoes.Filter := EmptyStr;
  cdsInspecoes.Filtered := False;
end;

procedure TfrmReimpressaoCompInspecao.pCarregarClienteFiltro;
begin
  pPesquisaCadCli(qryCli, qryCli, edtCodCli.Text);
  If Not fEmptyStr(edtCodCli.Text) Then
    edtNomCli.Text := qryCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtNomCli.Text := 'TODOS';
end;

procedure TfrmReimpressaoCompInspecao.pCarregarEmpresaFiltro;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
    edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text)
  Else
    edtNomEmp.Text := 'TODOS';
end;

procedure TfrmReimpressaoCompInspecao.pImprimir;
var
  intRecNo: Integer;
begin
  If Not fValidaItensSelecionados Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum item selecionado para impressão. Verifique!', ['&O k']);
    Exit;
  End;

  intRecNo := cdsInspecoes.RecNo;
  cdsInspecoes.DisableControls;
  Try
    cdsInspecoes.First;
    While Not cdsInspecoes.Eof Do
    Begin
      If cdsInspecoes.FieldByName('EQD_MARDES').AsString = 'M' Then
      Begin
        pImprimirInspecao(cdsInspecoes.FieldByName('EQD_SEQEQL').AsString, cdsInspecoes.FieldByName('AUTOINCREM').AsString);
      End;
      cdsInspecoes.Next;
    End;
  finally
    cdsInspecoes.RecNo := intRecNo;
    cdsInspecoes.EnableControls;
  end;
end;

procedure TfrmReimpressaoCompInspecao.pImprimirInspecao(const ACodEql: String; ASeqEql: String);
begin
  ObjContratoSelecao.fCarregarContrato(cdsInspecoes.FieldByName('EQD_SEQCON').AsString);
  ObjImpressao.Contrato := ObjContratoSelecao;

  ObjImpressao.fImprimeComprovanteIspEnt(ACodEql, ASeqEql);
  ObjImpressao.fImprimeComprovanteIspSai(ACodEql, ASeqEql);

  If Not fEmptyStr(ObjImpressao.MensagemRetorno) Then
    fMensagem('ATENÇÃO!', ObjImpressao.MensagemRetorno, ['&O k']);

end;

procedure TfrmReimpressaoCompInspecao.pLimparCampos;
begin
  inherited;

  ObjContratoFiltro.pLimpar;
end;

procedure TfrmReimpressaoCompInspecao.pMarcarInspecao(blnMarcar: Boolean);
begin
  cdsInspecoes.Edit;
  cdsInspecoes.FieldByName('EQD_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
  cdsInspecoes.Post;
end;

procedure TfrmReimpressaoCompInspecao.btnCarregaClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodEmp.Text) And
     fEmptyStr(edtNumCon.Text) And
     fEmptyStr(edtCodCli.Text) And
     fEmptyDate(mskDtaIspSaiIni.Text) And
     fEmptyDate(mskDtaIspSaiFim.Text) And
     fEmptyDate(mskDtaIspEntIni.Text) And
     fEmptyDate(mskDtaIspEntFim.Text) Then
  Begin
    If fMensagem('ATENÇÃO!', 'Nenhum filtro foi aplicado para realizar a consulta, desta forma o processo pode demorar. Deseja prosseguir? ', ['&Sim', '&Não']) = 2 Then
      Exit;
  End;

  TfrmGravando.fExecutarModal(pCarregarDados, 'Aguarde carregando...', 'ReimpressaoCompInspecao');
end;

procedure TfrmReimpressaoCompInspecao.btnImprimirClick(Sender: TObject);
begin
  inherited;

  pImprimir;

end;

procedure TfrmReimpressaoCompInspecao.cxGridInspecoesViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  pMarcarInspecao(cdsInspecoes.FieldByName('EQD_MARDES').AsString = 'D');
end;

procedure TfrmReimpressaoCompInspecao.cxGridInspecoesViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If AViewInfo.GridRecord.Values[cxGridInspecoesViewEQD_MARDES.Index] = 'M' Then
    ACanvas.Font.Color := clBlue;
end;

procedure TfrmReimpressaoCompInspecao.cxGridInspecoesViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: pMarcarInspecao(cdsInspecoes.FieldByName('EQD_MARDES').AsString = 'D');
  End;
end;

procedure TfrmReimpressaoCompInspecao.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrCodCli) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmReimpressaoCompInspecao.pCarregarDados;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    Try
      cdsInspecoes.EmptyDataSet;
      qryConsulta.DisableControls;
      qryConsulta.SQL.Add(fGetSQL);

      pSetaParam(edtCodEmp.Text, arrCodEmp, strCodEmp, 'CODEMP', qryConsulta);
      pSetaParam(edtNumCon.Text, arrNroCon, strNroCon, 'NROCON', qryConsulta);
      pSetaParam(edtCodCli.Text, arrCodCli, strCodCli, 'CODCLI', qryConsulta);

      If Not fEmptyDate(mskDtaIspSaiIni.Text) Then
        qryConsulta.ParamByName('DTAIPSINI').AsDateTime := StrToDate(mskDtaIspSaiIni.Text);

      If Not fEmptyDate(mskDtaIspSaiFim.Text) Then
        qryConsulta.ParamByName('DTAIPSFIM').AsDateTime := StrToDate(mskDtaIspSaiFim.Text);

      If Not fEmptyDate(mskDtaIspEntIni.Text) Then
        qryConsulta.ParamByName('DTAIPESINI').AsDateTime := StrToDate(mskDtaIspEntIni.Text);

      If Not fEmptyDate(mskDtaIspEntFim.Text) Then
        qryConsulta.ParamByName('DTAIPEFIM').AsDateTime := StrToDate(mskDtaIspEntFim.Text);

      qryConsulta.Open;
      cdsInspecoes.Open;

      While Not qryConsulta.Eof Do
      Begin
        cdsInspecoes.Append;
        cdsInspecoes.FieldByName('EQD_MARDES').AsString := 'D';
        cdsInspecoes.FieldByName('EQD_SEQCON').AsString := qryConsulta.FieldByName('EQD_SEQCON').AsString;
        cdsInspecoes.FieldByName('EQL_NROCON').AsString := qryConsulta.FieldByName('EQL_NROCON').AsString;
        cdsInspecoes.FieldByName('EQD_SEQEQL').AsString := qryConsulta.FieldByName('EQD_SEQEQL').AsString;
        cdsInspecoes.FieldByName('EQD_DESCRI').AsString := qryConsulta.FieldByName('EQD_SEQEQL').AsString + ' - ' + qryConsulta.FieldByName('EQL_DESCRI').AsString;
        cdsInspecoes.FieldByName('CLI_NOMCLI').AsString := qryConsulta.FieldByName('EQL_CODCLI').AsString + ' - ' + qryConsulta.FieldByName('CLI_NOMCLI').AsString;
        If qryConsulta.FieldByName('EQD_DTAIPE').AsDateTime > 0 Then
          cdsInspecoes.FieldByName('EQD_ISPENT').AsDateTime := qryConsulta.FieldByName('EQD_DTAIPE').AsDateTime + qryConsulta.FieldByName('EQD_HORIPE').AsDateTime;
        If qryConsulta.FieldByName('EQD_DTAIPS').AsDateTime > 0 Then
          cdsInspecoes.FieldByName('EQD_ISPSAI').AsDateTime := qryConsulta.FieldByName('EQD_DTAIPS').AsDateTime + qryConsulta.FieldByName('EQD_HORIPS').AsDateTime;
        cdsInspecoes.FieldByName('AUTOINCREM').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
        cdsInspecoes.Post;

        qryConsulta.Next;
      End;
    Except
      On Erro: Exception Do
      Begin
        pMensagensErro(Erro.Message, '[TfrmReimpressaoCompInspecao.pCarregarDados]');
      End;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

end.
