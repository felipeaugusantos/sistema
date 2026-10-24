{*********************************************************}
{* REPROGRAMAÇÃO DE VENCIMENTOS DO CTP                   *}
{*                                                       *}
{* DATA......: 07/10/2014                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI                  *}
{*                                                       *}
{******************************************************AF*}
unit untCtpReprogVen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxContainer, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Vcl.Mask, MaskEditFocus, EditFocus, untTypesSistema,
  untConsultas, UniClientDataset, Datasnap.Provider, UniDataSetProvider, Uni,
  untAltDtaVenc, untTCadPagRepository,
  cxDataControllerConditionalFormattingRulesManagerDialog, untTLock,
  untFrameCentroCustoEditFocus, cxProgressBar, untGravando, untFramePlanoDeContasMaskEdit;

type
  TfrmCtpReprogVen = class(TfrmPai)
    pnlTopo: TPanel;
    cxDadosView: TcxGridDBTableView;
    cxDadosLevel1: TcxGridLevel;
    cxDados: TcxGrid;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label13: TLabel;
    edtCodFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    lblPortador: TLabel;
    edtDesPortador: TEditFocus;
    edtCodPor: TEditFocus;
    shpMultSel: TShape;
    dtsDados: TDataSource;
    colNUMDUP: TcxGridDBColumn;
    colPARCEL: TcxGridDBColumn;
    colCODEMP: TcxGridDBColumn;
    colNOMFOR: TcxGridDBColumn;
    colDTAVEN: TcxGridDBColumn;
    colVALDUP: TcxGridDBColumn;
    colMARDES: TcxGridDBColumn;
    btnDesTodas: TBitBtnLocked;
    btnMarTodas: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnConsultar: TBitBtnLocked;
    fraCentroCusto: TfraCentroCustoEditFocus;
    btnHistDocumentos: TBitBtnLocked;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure edtCodFornecedorExit(Sender: TObject);
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cxDadosViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxDadosViewDblClick(Sender: TObject);
    procedure cxDadosViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarTodasClick(Sender: TObject);
    procedure btnDesTodasClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConsultarClick(Sender: TObject);
    procedure fraCentroCustoedtCodEveExit(Sender: TObject);
    procedure btnHistDocumentosClick(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaExit(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryDados: TUniQuery;
    cdsDados: TUniClientDataset;
    pvdDados: TUniDataSetProvider;
    objLock : TLock;

    strFornecedor : String;
    strEmpresa    : String;
    strEvento     : String;
    strCentroCusto: String;
    strPortador   : String;

    arrFornecedor : TConsultasArray;
    arrEvento     : TConsultasArray;
    arrCentroCusto: TConsultasArray;
    arrEmpresa    : TConsultasArray;
    arrPortador   : TConsultasArray;

    procedure pCriaTemporaria;
    procedure pLimparTela;
    procedure pMarcaDuplicata(blnMarcar: Boolean);
    procedure pSelecionaDuplicata;
    function fDuplicataTravada(strNumDup, strCodEmp, strCodCli, strParcel: String; blnMosMen: Boolean = True): Boolean;
    function fSelecionouDuplicata : Boolean;
    procedure pDestravarParcela(strNumDup, strCodEmp, strCodCli, strParcel: String);
    procedure pAtualizaVencimento(dtaDtaVen: TDateTime);
  public
    { Public declarations }
  protected
    function  fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    function  fDesmarcarTodos(pgbStatus: TcxProgressBar): Boolean;
    function  fMarcarTodos(pgbStatus: TcxProgressBar): Boolean;
    function  fCarregaTitulos(pgbStatus: TcxProgressBar): Boolean;
    procedure pStep(pgbStatus: TcxProgressBar);
  end;


implementation

{$R *.dfm}

uses untFuncoesConsulta, untFuncoesSimples, StrUtils, untCadPag, untRelCtpLogAcompDuplicNovo,
untTCadPag, untLogCtp;

procedure TfrmCtpReprogVen.btnMarTodasClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.fExecutarAcao := fMarcarTodos;
  frmGravando.lblGravando.Caption := 'AGUARDE... MARCANDO DUPLICATAS';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
end;

procedure TfrmCtpReprogVen.btnConfirmaClick(Sender: TObject);
  Var
    dtaDtaVen: TDateTime;
    frmAltDtaVenc : TfrmAltDtaVenc;
begin
  inherited;

  If Not fSelecionouDuplicata Then
  Begin
    pMensagemOk('Nenhuma duplicata selecionada. Verifique!');
    pSetFocus(mskDtaIni);
    Exit;
  End;

  dtaDtaVen := 0;

  Try
    pCriarFormularios(TfrmAltDtaVenc, frmAltDtaVenc);
    frmAltDtaVenc.mskDtaVen.Text := cdsDados.FieldByName('DTAVEN').AsString;
    frmAltDtaVenc.ShowModal;

    If frmAltDtaVenc.blnConfirma = True Then
      dtaDtaVen := frmAltDtaVenc.dtaDtaVen;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmAgrupDuplicatas.dbgDuplicatasKeyDown]');
  End;

  pFreeAndNil(frmAltDtaVenc);

  If dtaDtaVen <> 0 Then
  Begin
    pAtualizaVencimento(dtaDtaVen);
  End;

end;

procedure TfrmCtpReprogVen.btnConsultarClick(Sender: TObject);
begin
  inherited;
  if not fValidaCampos(mskDtaIni,false) then
  begin
     Exit;
  end;
  if not fValidaCampos(mskDtaFin,false) then
  begin
     Exit;
  end;

  If Not fVerificaCampos Then
    Exit;

  TfrmGravando.fExecutarModal(pCriaTemporaria, 'AGUARDE... CARREGANDO TÍTULOS','');

  if not cdsDados.isEmpty then
    pSetFocus(cxDados);
end;

procedure TfrmCtpReprogVen.btnDesTodasClick(Sender: TObject);
begin
  inherited;
  If Not fSelecionouDuplicata Then
  Begin
    fMensagem('','É necessário selecionar ao menos um registro para desmarcar!',['&O K']);
    pSetFocus(cxDados);
    Exit;
  End;

  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.fExecutarAcao := fDesmarcarTodos;
  frmGravando.lblGravando.Caption := 'AGUARDE...DESMARCANDO DUPLICATAS';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
end;

procedure TfrmCtpReprogVen.btnHistDocumentosClick(Sender: TObject);
Var
    frmRelCtpLogAcompDuplicNovo: TfrmRelCtpLogAcompDuplicNovo;
begin
  inherited;
  Try
    pCriarFormularios(TfrmRelCtpLogAcompDuplicNovo, frmRelCtpLogAcompDuplicNovo);
    frmRelCtpLogAcompDuplicNovo.blnVeioCtpReprogVen := True;
    frmRelCtpLogAcompDuplicNovo.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmAgrupDuplicatasCtp.btnHistDocumentos]');
  End;
  pFreeAndNil(frmRelCtpLogAcompDuplicNovo);
end;

procedure TfrmCtpReprogVen.cxDadosViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (cdsDados.IsEmpty) Then Exit;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, colMARDES.Index]) = 'M' Then
  Begin

    If AViewInfo.Selected Then ACanvas.Font.Color := clLime
    Else ACanvas.Font.Color := clBlue;

  End;

end;

procedure TfrmCtpReprogVen.cxDadosViewDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaDuplicata;
  cxDadosView.NavigatorButtons.Next.Click;
end;

procedure TfrmCtpReprogVen.cxDadosViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of

    VK_Escape: pLimparTela;
    VK_Return: Begin
                 pSelecionaDuplicata;
                 cxDadosView.NavigatorButtons.Next.Click;
               End;

  End;

end;

procedure TfrmCtpReprogVen.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
If Not edtCodEmpresa.ReadOnly Then
    pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmCtpReprogVen.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False, True) Then
  Begin
    fValidaCampos(edtCodEmpresa,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCtpReprogVen.edtCodFornecedorExit(Sender: TObject);
begin
  inherited;
  If Not edtCodFornecedor.ReadOnly Then
    pEdtCodSelectExit(edtCodFornecedor, edtDesFornecedor, arrFornecedor, fRetNomFornecedor, Nil, 'do fornecedor');
end;

procedure TfrmCtpReprogVen.edtCodFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtDesFornecedor, Nil, Key, arrFornecedor, False) Then
  Begin
    fValidaCampos(edtCodFornecedor,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCtpReprogVen.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtDesPortador, arrPortador, Nil, fRetNomPortador, 'do portador');
end;

procedure TfrmCtpReprogVen.edtCodPorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtDesPortador,
                   nil,
                   Key,
                   arrPortador,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmpresa.Text) Then
  Begin
    If fValidaCampos(edtCodPor,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCtpReprogVen.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmCtpReprogVen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objLock);
end;

procedure TfrmCtpReprogVen.FormCreate(Sender: TObject);
begin
  inherited;

  qryDados := fCriaQuery(Self);

  pvdDados := TUniDataSetProvider.Create(Self);
  pvdDados.DataSet := qryDados;

  cdsDados := TUniClientDataset.Create(Self);

  dtsDados.DataSet := cdsDados;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  objLock := TLock.Create;
end;

procedure TfrmCtpReprogVen.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
     VK_F10: btnConfirma.Click;
     VK_F8 : btnDesTodas.Click;
     VK_F7 : btnMarTodas.Click;
  End;

end;

function TfrmCtpReprogVen.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        pMensagemOk('O campo Data Inicial deve ser preenchido!');
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            pMensagemOk('O campo Data Final deve ser preenchido!');
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              pMensagemOk('A data inicial deve ser menor que a data final!');
              Result := False;
            End;
          End;
        End
      End;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) And (edtCodEmpresa.Text <> '000') Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          pMensagemOk('Usuário sem permissão de acesso a essa Empresa!');
          Result := False;
        End;
      End;
    End

    Else If Sender = edtCodPor Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) And (edtCodPor.Text <> '00000') Then
      Begin
        edtDesPortador.Text := fRetNomPortador(edtCodPor.Text);

        If fEmptyStr(edtDesPortador.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End

        {*REQ*145940**********RP*}
        Else If (High(arrEmpresa) > 0) Then
        Begin
            If Not fEmpresaTemAcessoPortador(edtCodPor.Text,arrEmpresa) Then
              Result := False;
        End

        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
        edtDesPortador.Text := 'TODOS';

    End
    Else If Sender = fraCentroCusto.edtCodEve Then
    Begin
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);

        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='R') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a receber!',['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        fraCentroCusto.edtDesEve.Clear;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCtpReprogVen.pCriaTemporaria;
  Var
    strSQL: String;
begin

  cdsDados.IndexFieldNames := 'DTAVEN;NUMDUP'; //Foi usado esse filtro, para os registros não serem jogados para o final da grid

  Try
    cdsDados.Close;
    cdsDados.SetProvider(pvdDados);

    strSQL := 'SELECT ' +
              '  P.AUTOINCREM, ' +
              '  CTP_NUMDUP AS NUMDUP, ' +
              '  CTP_PARCEL AS PARCEL, ' +
              '  CTP_CODEMP AS CODEMP, ' +
              '  CTP_CODFOR AS CODFOR, ' +
              '  CTP_SERIE_ AS SERIE_, ' +
              '  CTP_SEQBAI AS SEQBAI, ' +
              '  CTP_CODPOR AS CODPOR, ' +
              '  CTP_DTACAD AS DTACAD, ' +
              '  CTP_HIST01 AS HIST01, ' +
              '  CTP_HIST02 AS HIST02, ' +
              '  CTP_PORBAI AS PORBAI, ' +
              '  CTP_HISBAI AS HISBAI, ' +
              '  CTP_CTABAI AS CTABAI, ' +
              '  CTP_DOCBAI AS DOCBAI, ' +
              '  CTP_OPEBAI AS OPEBAI, ' +
              '  CTP_DTAPAG AS DTAPAG, ' +
              '  CTP_VALPAG AS VALPAG, ' +
              '  CTP_VALJUR AS VALJUR, ' +
              '  CTP_VALDES AS VALDES, ' +
              '  CTP_RESCAI AS RESCAI, ' +
              '  CTP_BCOENV AS BCOENV, ' +
              '  CTP_DTAENV AS DTAENV, ' +
              '  CTP_DTABAI AS DTABAI, ' +

              '  CTP_CODEVE AS CODEVE, ' +
              '  CTP_CODVEL AS CODVEL, ' +
              '  CTP_CODCTA AS CODCTA, ' +
              '  CTP_EMPBAI AS EMPBAI, ' +
              '  CTP_JURSUJ AS JURSUJ, ' +
              '  CTP_DESSUJ AS DESSUJ, ' +
              '  CTP_SEQCON AS SEQCON, ' +
              '  CTP_PREVIS AS PREVIS, ' +
              '  CTP_VEIOBO AS VEIOBO, ' +
              '  CTP_VEIONF AS VEIONF, ' +
              '  CTP_EMPGER AS EMPGER, ' +
              '  CTP_USACHQ AS USACHQ, ' +
              '  CTP_CODVEN AS CODVEN, ' +
              '  CTP_TIPDOC AS TIPDOC, ' +
              '  CTP_NUMDOC AS NUMDOC, ' +
              '  CTP_CODBAR AS CODBAR, ' +
              '  CTP_TIPDES AS TIPDES, ' +
              '  CTP_DEPOSI AS DEPOSI, ' +
              '  CTP_RCXCON AS RCXCON, ' +
              '  CTP_VENDOR AS VENDOR, ' +
              '  CTP_PAGANT AS PAGANT, ' +

              '  CONCAT(FOR_CODFOR,"-", FOR_NOMFOR) AS NOMFOR, ' +
              '  CTP_DTAVEN AS DTAVEN, ' +
              '  CTP_VALDUP AS VALDUP, ' +
              '  CTP_VALORI AS VALORI, ' +
              '  "D" AS MARDES ' +
              'FROM ' +
              '  CADPAG P ' +
              '  JOIN CADFOR ON FOR_CODFOR = CTP_CODFOR ' +
              'WHERE ' +
              '  CTP_DTAPAG IS NULL AND ' +
              '  CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ' +
              fStrLocate(edtCodFornecedor,  arrFornecedor,  'CTP_CODFOR', 'CODFOR') +
              fStrLocate(fraPlanoDeContas.mskCodCta,  arrCentroCusto,  'CTP_CODCTA', 'CODCTA') +
              fStrLocate(fraCentroCusto.edtCodEve,  arrEvento,  'CTP_CODEVE', 'CODEVE') +
              fStrLocate(edtCodEmpresa,  arrEmpresa,  'CTP_CODEMP', 'CODEMP');

    If Not fEmptyStr(edtCodPor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor,  arrPortador,  'CTP_CODPOR', 'CODPOR')
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (IFNULL(CTP_CODPOR, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    With qryDados Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      pSetaParam(edtCodFornecedor.Text, arrFornecedor, strFornecedor, 'CODFOR', qryDados);
      pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP',qryDados);
      pSetaParam(fraCentroCusto.edtCodEve.Text, arrEvento, strEvento, 'CODEVE', qryDados);
      pSetaParam(fraPlanoDeContas.mskCodCta.Text, arrCentroCusto, strCentroCusto, 'CODCTA', qryDados);
      pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryDados);
      Open;

      If IsEmpty Then
      Begin
        pMensagemOk('Não foi encontrado dados!');

        pLimparTela;

        Exit;
      End;
    End;

    objLock.pDestravarTodos;

    pSetaClient(qryDados);

    cdsDados.Open;

    TFloatField(cdsDados.FieldByName('VALDUP')).DisplayFormat := '#,##0.00';

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'TfrmCtpReprogVen.pCriaTemporaria');
  End;

End;

procedure TfrmCtpReprogVen.pLimparTela;
begin
  cdsDados.Close;
  pSetFocus(mskDtaIni);

  edtCodPor.Clear;
  edtDesPortador.Clear;
  SetLength(arrPortador,0);


  edtCodFornecedor.Clear;
  edtDesFornecedor.Clear;
  SetLength(arrFornecedor,0);

  fraPlanoDeContas.mskCodCta.Clear;
  fraPlanoDeContas.edtDesCta.Clear;
  SetLength(arrCentroCusto,0);

  fraCentroCusto.edtCodEve.Clear;
  fraCentroCusto.edtDesEve.Clear;
  SetLength(arrEvento,0);

  edtCodEmpresa.Clear;
  edtDesEmpresa.Clear;
  SetLength(arrEmpresa,0);
end;

{*****************************************}
{* SELECIONA UMA DUPLICATA               *}
{**************************************AF*}
procedure TfrmCtpReprogVen.pSelecionaDuplicata;
begin
  If cdsDados.IsEmpty Then
    Exit;

  if Not fEmpresaTemAcessoPortador(cdsDados.FieldByName('CODPOR').AsString,VS_strCodEmp) Then
  Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Exit;
  End;

  If cdsDados.FieldByName('MARDES').AsString <> 'M' Then
  Begin
    If fDuplicataTravada(cdsDados.FieldByName('NUMDUP').AsString,
                         cdsDados.FieldByName('CODEMP').AsString,
                         cdsDados.FieldByName('CODFOR').AsString,
                         cdsDados.FieldByName('PARCEL').AsString) Then
    Begin
      Exit;
    End;

    pMarcaDuplicata(True);
  End
  Else
  Begin
    pMarcaDuplicata(False);
  End;
end;


procedure TfrmCtpReprogVen.pStep(pgbStatus: TcxProgressBar);
begin
  if Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

{*****************************************}
{* MARCA UMA DUPLICATA A SER BAIXADA     *}
{**************************************AF*}
procedure TfrmCtpReprogVen.pMarcaDuplicata(blnMarcar: Boolean);
begin
  If Not blnMarcar Then
  Begin
    pDestravarParcela(cdsDados.FieldByName('NUMDUP').AsString,
                      cdsDados.FieldByName('CODEMP').AsString,
                      cdsDados.FieldByName('CODFOR').AsString,
                      cdsDados.FieldByName('PARCEL').AsString);
  End;

  With cdsDados Do
  Begin
    Edit;
    if blnMarcar And Not fEmpresaTemAcessoPortador(cdsDados.FieldByName('CODPOR').AsString,VS_strCodEmp) Then
    Begin
      FieldByName('MARDES').AsString:='D';
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
    End Else
      FieldByName('MARDES').AsString := IIF(blnMarcar, 'M', 'D');

    Post;
  End;
end;

function TfrmCtpReprogVen.fCarregaTitulos(pgbStatus: TcxProgressBar): Boolean;
var
  prcScroll: TprcScroll;
begin
  Result := true;
  pgbStatus.Properties.Max := cdsDados.RecordCount;
    With cdsDados Do
    Begin
      Try
        pDisableControls(cdsDados, prcScroll);
        AggregatesActive := False;
        if IsEmpty Then
          Exit;

        First;
        While Not Eof Do
        Begin
          pStep(pgbStatus);
          Next;
        End;
      Finally
        First;
        pEnableControls(cdsDados, prcScroll);
      End;
    End;
end;

function TfrmCtpReprogVen.fDesmarcarTodos(pgbStatus: TcxProgressBar): Boolean;
var
  prcScroll: TprcScroll;
begin
  Result := true;
  if (cdsDados.IsEmpty) Then
  begin
    pMensagemOk('É necessário selecionar ao menos uma duplicata!');
    Exit;
  end;
    pgbStatus.Properties.Max := cdsDados.RecordCount;

    With cdsDados Do
    Begin
      Try
        pDisableControls(cdsDados, prcScroll);
        AggregatesActive := False;
        if IsEmpty Then
          Exit;

        First;
        While Not Eof Do
        Begin
          pMarcaDuplicata(False);
          pStep(pgbStatus);
          Next;
        End;
      Finally
        First;
        pEnableControls(cdsDados, prcScroll);
      End;
    End;
    cxDadosView.NavigatorButtons.First.Click;
    cdsDados.AggregatesActive := True;
end;

function TfrmCtpReprogVen.fDuplicataTravada(strNumDup, strCodEmp, strCodCli,
  strParcel: String; blnMosMen: Boolean = True): Boolean;
  Var
    strChaLck: String;
begin
  Result := False;

  strChaLck := 'CADPAG' +
               strNumDup +
               strCodEmp +
               strCodCli +
               strParcel;

  If Not objLock.fLock_Unlock(strChaLck, True, False) Then
  Begin
    If blnMosMen Then
      pMensagemOk('Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck));

    Result := True;
    Exit;
  End;
end;


function TfrmCtpReprogVen.fMarcarTodos(pgbStatus: TcxProgressBar): Boolean;
Var
  prcScroll: TprcScroll;
begin
  Result := True;
  If (cdsDados.IsEmpty) Then
  begin
    pMensagemOk('É necessário selecionar ao menos uma duplicata!');
    Exit;
  end;
    pgbStatus.Properties.Max := cdsDados.RecordCount;

  With cdsDados Do
  Begin
    If IsEmpty Then
      Exit;
    Try
      pDisableControls(cdsDados, prcScroll);

      First;
      While Not Eof Do
      Begin
        If Not fDuplicataTravada(cdsDados.FieldByName('NUMDUP').AsString,
                                cdsDados.FieldByName('CODEMP').AsString,
                                cdsDados.FieldByName('CODFOR').AsString,
                                cdsDados.FieldByName('PARCEL').AsString,
                                False) Then
        Begin
          pMarcaDuplicata(True);
        End;
        pStep(pgbStatus);
        Next;
      End;
    Finally
      First;
      pEnableControls(cdsDados, prcScroll);
    end;

    cxDadosView.NavigatorButtons.First.Click;
    cdsDados.AggregatesActive := True;
  End;
end;

procedure TfrmCtpReprogVen.pDestravarParcela(strNumDup, strCodEmp, strCodCli,
  strParcel: String);
  Var
    strChaLck : String;
begin
  strChaLck := 'CADPAG' +
               strNumDup +
               strCodEmp +
               strCodCli +
               strParcel;

  objLock.fLock_Unlock(strChaLck, False);
end;

procedure TfrmCtpReprogVen.pAtualizaVencimento(dtaDtaVen: TDateTime);
  Var
    intRecNo: Integer;
    qryGen  : TUniQuery;
    objPag  : TCadPag;
    objRep  : TCadPagRepository;
    strGetCodFor: String;
begin
  Try
    qryGen := fCriaQuery(Nil);

    With cdsDados Do
    Begin
      intRecNo := RecNo;
      DisableControls;

      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fCarregaTitulos;
      frmGravando.lblGravando.Caption := 'ATUALIZANDO DUPLICATAS... AGUARDE...';
      frmGravando.ShowModal;
      pFreeAndNil(frmGravando);

      First;

      fStartTransaction;
      While Not Eof Do
      Begin

        If FieldByName('MARDES').AsString = 'M' Then
        Begin
          qryGen.Close;
          qryGen.SQL.Clear;
          qryGen.SQL.Add('UPDATE CADPAG SET ' +
                         '  CTP_DTAVEN = :DTAVEN ' +
                         'WHERE ' +
                         '  CTP_CODFOR = :CODFOR AND CTP_NUMDUP = :NUMDUP AND CTP_PARCEL = :PARCEL AND ' +
                         '  CTP_CODEMP = :CODEMP AND CTP_SERIE_ = :SERIE_ ');
          qryGen.ParamByName('DTAVEN').AsDate   := dtaDtaVen;
          qryGen.ParamByName('CODFOR').AsString := FieldByName('CODFOR').AsString;
          qryGen.ParamByName('NUMDUP').AsString := FieldByName('NUMDUP').AsString;
          qryGen.ParamByName('PARCEL').AsString := FieldByName('PARCEL').AsString;
          qryGen.ParamByName('CODEMP').AsString := FieldByName('CODEMP').AsString;
          qryGen.ParamByName('SERIE_').AsString := FieldByName('SERIE_').AsString;
          qryGen.ExecSQL;
        End;

        Next;
      End;

      fCommit;

      First;
      While Not Eof Do
      Begin
        If FieldByName('MARDES').AsString = 'M' Then
        Begin
          objRep := TCadPagRepository.Create;
          objPag := objRep.fRetDuplicata(FieldByName('NUMDUP').AsString,
                                         FieldByName('PARCEL').AsString,
                                         FieldByName('SEQBAI').AsInteger,
                                         FieldByName('CODEMP').AsString,
                                         FieldByName('CODFOR').AsString,
                                         FieldByName('SERIE_').AsString);
          If Assigned(objPag) Then
          begin
            strGetCodFor := objPag.objCodFor.FOR_CODFOR;
            pGravaLogCtp(objPag, 'ALTERACAO DE VENCIMENTO', Self.Name);
          end;
        end;
        Next;
      end;

      If Assigned(objRep) Then
        FreeandNil(objRep);


      RecNo := intRecNo;
      EnableControls;
    End;

    pMensagemOk('Dados alterados com sucesso!');
    pLimparTela;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message,'TfrmCtpReprogVen.pAtualizaVencimento');
    End;
  End;

  FreeAndNil(qryGen);
  If Assigned(objRep) Then
    FreeAndNil(objRep);
End;

procedure TfrmCtpReprogVen.fraCentroCustoedtCodEveExit(Sender: TObject);
begin
  inherited;
  If Not fraCentroCusto.edtCodEve.ReadOnly Then
    pEdtCodSelectExit(fraCentroCusto.edtCodEve, fraCentroCusto.edtDesEve, arrEvento, fRetNomEvento, Nil, 'do Centro de Custos');
end;

procedure TfrmCtpReprogVen.fraPlanoDeContasMskCodCtaExit(Sender: TObject);
begin
  inherited;
  If Not fraPlanoDeContas.mskCodCta.ReadOnly Then
  Begin
    fraPlanoDeContas.MskCodCtaExit(Sender);
    pEdtCodSelectExit(fraPlanoDeContas.mskCodCta, fraPlanoDeContas.edtDesCta, arrCentroCusto, fRetNomeConta, Nil, 'do plano de contas');
  End;

end;

procedure TfrmCtpReprogVen.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContas.mskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, False) Then
  Begin
    fValidaCampos(fraPlanoDeContas.mskCodCta,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCtpReprogVen.fSelecionouDuplicata: Boolean;
  Var
    intRecNo: Integer;
begin
  inherited;

  Result := False;

  If (cdsDados.IsEmpty) Then
    Exit;

  With cdsDados Do
  Begin
    intRecNo := RecNo;
    DisableControls;

    Filtered := False;
    Filter := 'MARDES = ''M''';
    Filtered := True;

    If Not Eof Then
      Result := True;

    Filtered := False;

    RecNo := intRecNo;
    EnableControls;
    IndexFieldNames := 'DTAVEN;NUMDUP';
  End;

end;

end.
