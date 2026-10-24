unit untCTRReajuste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, MaskEditFocus, cxGraphics, untHelperCitel,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, Uni, cxProgressBar, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCitel, cxClasses, cxGridLevel, cxGrid, untTypesSistema, untZClient,
  untTCadRec, untTCadRecRepository,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCTRReajuste = class(TfrmPaiConfirma)
    cxDadosLevel: TcxGridLevel;
    cxDadosTableView: TcxGridDBTableViewCitel;
    cxDados: TcxGridCitel;
    cxDadosTableViewColumn1: TcxGridDBColumn;
    cxDadosTableViewColumn2: TcxGridDBColumn;
    cxDadosTableViewColumn3: TcxGridDBColumn;
    cxDadosTableViewColumn4: TcxGridDBColumn;
    cxDadosTableViewColumn5: TcxGridDBColumn;
    cxDadosTableViewColumn6: TcxGridDBColumn;
    cxDadosTableViewColumn7: TcxGridDBColumn;
    cxDadosTableViewColumn8: TcxGridDBColumn;
    cxDadosTableViewColumn9: TcxGridDBColumn;
    pnlTopo: TPanel;
    Label5: TLabel;
    lblPortador: TLabel;
    lblEmpresa: TLabel;
    lbl5: TLabel;
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    edtFator: TEditFocus;
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
  private
    cdsDados  : TZClient;
    arrCodPor : TConsultasArray;
    arrCodEmp : TConsultasArray;
    arrCodCli : TConsultasArray;

    function fGetSQL : String;
    procedure pAbreDados;
    procedure pAtualizaDadosCTR;
    function fAtualizaDadosCTRProgresso(cxProgress: TcxProgressBar): Boolean;
    procedure pLimpaCampos;
  public
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; Override;
  end;

implementation

{$R *.dfm}

uses untConsultas, untFuncoesSimples, untFuncoesConsulta, untGravando,
  untCadRec, untLogCtr;

procedure TfrmCTRReajuste.btnConfirmaClick(Sender: TObject);
begin
//  inherited;
  If cdsDados.Active And (cdsDados.RecordCount > 0) Then
    pAtualizaDadosCTR
  Else
    fMensagem('', 'Nenhum registro para atualizar!', ['&OK']);
end;

procedure TfrmCTRReajuste.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtDesCli, arrCodCli, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmCTRReajuste.edtCodCliKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrCodCli, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCTRReajuste.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrCodEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmCTRReajuste.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrCodEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCTRReajuste.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtDesPor, arrCodPor, Nil, fRetNomPortador, 'do portador');
end;

procedure TfrmCTRReajuste.edtCodPorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtDesPor,
                   nil,
                   Key,
                   arrCodPor,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmp.Text) Then
  Begin
    If fValidaCampos(edtCodPor,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCTRReajuste.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT CADREC.AUTOINCREM,   ';
  Result := Result + '        CTR_CODEMP,          ';
  Result := Result + '        CTR_CODVEL,          ';
  Result := Result + '        CONCAT(CTR_NUMDUP,   ';
  Result := Result + '        CTR_PARCEL,          ';
  Result := Result + '        CTR_ESPDOC) AS DOCUME,';
  Result := Result + '        CTR_CODCLI,          ';
  Result := Result + '        CTR_VALDUP,          ';
  Result := Result + '        CTR_VALDUP + ROUND( ( ( CTR_VALDUP * :FATOR_ ) / 100 ), 2 ) AS CTR_VALAJU, ';
  Result := Result + '        CTR_VALORI,          ';
  Result := Result + '        CTR_DTACAD,          ';
  Result := Result + '        CTR_DTAVEN,          ';
  Result := Result + '        CTR_NOSNUM,          ';
  Result := Result + '        CTR_CODCTA,          ';
  Result := Result + '        CTR_ULTRIN,          ';
  Result := Result + '        CLI_NOMCLI,          ';
  Result := Result + '        CONCAT(CTR_CODPOR, "-",POR_NOMPOR) AS NOMPOR ';
  Result := Result + ' FROM CADREC                 ';
  Result := Result + ' INNER JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI ';
  Result := Result + ' LEFT  JOIN CADPOR ON POR_CODPOR = CTR_CODPOR ';
  Result := Result + ' LEFT JOIN FATGOR ON FATGOR.FGO_CODCLI = CTR_CODCLI ';
  Result := Result + '                  AND FATGOR.FGO_NUMDOC = CTR_NUMDUP ';
  Result := Result + '                  AND FATGOR.FGO_ESPDOC = CTR_ESPDOC ';
  Result := Result + '                  AND FATGOR.FGO_CODEMP = CTR_CODEMP ';
  Result := Result + ' LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';
  Result := Result + ' WHERE CTR_DTAVEN >= :DTAVEN ';
  Result := Result + '   AND CTR_DTAREC IS NULL    ';
  Result := Result + '   AND CTR_NOSNUM IS NULL    ';
  Result := Result + '   AND CTR_VALDUP > 0        ';

  Result := Result + fStrLocate(edtCodCli, arrCodCli, 'CTR_CODCLI', 'CODCLI');
  Result := Result + fStrLocate(edtCodEmp, arrCodEmp, 'CTR_CODEMP', 'CODEMP');
  Result := Result + fStrLocate(edtCodPor, arrCodPor, 'CTR_CODPOR', 'CODPOR');

  Result := Result + ' AND (IFNULL(FGO_BOLADT, 0.00) = 0.00) ';

  Result := Result + ' ORDER BY CTR_CODCLI, CTR_DTAVEN, CTR_CODEMP, CTR_ESPDOC, CTR_NUMDUP, CTR_PARCEL ';
end;

procedure TfrmCTRReajuste.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If cdsDados.Active And (cdsDados.RecordCount > 0) Then
  Begin
    Action := caNone;
    If fMensagem('', 'Deseja cancelar o Reajuste?', ['&Sim', '&Não'], 1) = 1 Then
      cdsDados.Close;

  End;
end;

procedure TfrmCTRReajuste.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados := TZClient.Create(Self);
end;

procedure TfrmCTRReajuste.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsDados);
  inherited;
end;

function TfrmCTRReajuste.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin
    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyDate(mskDtaIni.Text) Then
      Begin
        Result := False;
        pMensagemOK('Informe uma data!');
      End;

    End

    Else
    If (Sender = edtCodEmp) Then
    Begin
      pDesmarcaLista(edtCodEmp, arrCodEmp);
    End

    Else
    If (Sender = edtCodCli) Then
    Begin
      pDesmarcaLista(edtCodCli, arrCodCli);
    End

    Else
    If (Sender = edtCodPor) Then
    Begin
      {*REQ*145940**********RP*}
      If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Result := False;
      End;

      pDesmarcaLista(edtCodPor, arrCodPor);
    End

    Else
    If (Sender = edtFator) Then
    Begin
      If fStrToFloat(edtFator.Text) <= 0 Then
      Begin
        Result := False;
        pMensagemOK('O fator deve ser maior que zero!');
      End;

      If Result And blnBuscaPorChave And fVerificaCampos Then
        pAbreDados
      Else
        blnMudarFoco := False;
    End;

    If not Result Then
      pSetFocus(Sender);

  End;

end;

procedure TfrmCTRReajuste.pAbreDados;
  Var
    strParam : String;
begin
  With cdsDados.QryQuery, SQL Do
  Begin
    Close;
    Clear;
    Add( fGetSQL );

    cdsDados.QryQuery.ParamByName('DTAVEN').AsDateTime := StrToDate(mskDtaIni.Text);
    cdsDados.QryQuery.ParamByName('FATOR_').AsFloat    := fStrToFloat(edtFator.Text);
    pSetaParam(edtCodCli.Text, arrCodCli, strParam, 'CODCLI', cdsDados.QryQuery);
    pSetaParam(edtCodEmp.Text, arrCodEmp, strParam, 'CODEMP', cdsDados.QryQuery);
    pSetaParam(edtCodPor.Text, arrCodPor, strParam, 'CODPOR', cdsDados.QryQuery);

  End;

  cdsDados.fAbreClient(True, 'TfrmCTRReajuste.pAbreDados', False, True);
  TFloatField(cdsDados.FieldByName('CTR_VALDUP')).DisplayFormat := '#,##0.00';
  TFloatField(cdsDados.FieldByName('CTR_VALAJU')).DisplayFormat := '#,##0.00';

  cxDadosTableView.DataController.DataSource := cdsDados.dtsSource;
end;

procedure TfrmCTRReajuste.pAtualizaDadosCTR;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fAtualizaDadosCTRProgresso;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
End;

Function TfrmCTRReajuste.fAtualizaDadosCTRProgresso(cxProgress : TcxProgressBar):Boolean;
  Var
    qryUpdate : TUniQuery;
Begin
  Try

    qryUpdate := fCriaQuery(Self);
    With qryUpdate, SQL Do
    Begin
      Close;
      Clear;
      Add(' SET @PERC_CORRECAO = ' + FormatFloat('0,00', fStrToFloat(edtFator.Text)) + ';');
      ExecSQL;

      Close;
      Clear;
      Add(' SET @TAXA_CORRECAO = 1 + ( @PERC_CORRECAO / 100 );                           ');
      ExecSQL;

      Close;
      Clear;
      Add(' UPDATE CADREC C SET                                                                                                  ');
      Add('        CTR_VANTER = CTR_VALDUP,                                                                                      ');
      Add('        CTR_INDINC = @TAXA_CORRECAO,                                                                                  ');
      Add('        CTR_ULTRIN = ' + fCurrentDate + ',                                                                            ');
      Add('        CTR_HIST01 = CONCAT( IFNULL( CTR_HIST01, "" ), "Vr.Original em 10/08/2016: R$ ", CTR_VALDUP, ". Com reajuste ' );
      Add('de ", :PERC_UTILIZADO, "% passou para R$ ", :VALCORRIGIDO, ". " ),                           ');
      Add('        CTR_VALORI = :VALCORRIGIDO,                                                         ');
      Add('        CTR_VALDUP = :VALCORRIGIDO                                                          ');
      Add(' WHERE C.AUTOINCREM = :AUTINC                                                                                         ');

    End;

    cxProgress.pSetMax(cdsDados.RecordCount);

    cdsDados.DisableControls;
    cdsDados.First;

    While Not cdsDados.Eof Do
    Begin
      qryUpdate.ParamByName('AUTINC').AsString         := cdsDados.FieldByName('AUTOINCREM').AsString;
      qryUpDate.ParamByName('PERC_UTILIZADO').AsString := edtFator.Text;
      qryUpdate.ParamByName('VALCORRIGIDO').AsFloat    := cdsDados.FieldByName('CTR_VALAJU').AsFloat;
      qryUpdate.ExecSQL;

      {****************}
      {* GRAVA LOGCTR *}
      {*************JS*}
      untLogCtr.GravaLogCtr(cdsDados.FieldByName('AUTOINCREM').AsString, 'REAJUSTE DE FINANCIAMENTOS', Self.Name);

      cdsDados.Next;
      cxProgress.pStepBy;
      Application.ProcessMessages;
    End;

    Result := True;
    fMensagem('', 'Reajuste realizado com sucesso!', ['&OK']);
  Finally
    cdsDados.First;
    cdsDados.EnableControls;
    cdsDados.Close;
    FreeAndNil(qryUpdate);

    pLimpaCampos;
  End;
End;

procedure TfrmCTRReajuste.pLimpaCampos;
Begin
  mskDtaIni.Clear;
  edtCodCli.Clear;
  edtDesCli.Clear;
  edtCodPor.Clear;
  edtDesPor.Clear;
  edtCodEmp.Clear;
  edtDesEmp.Clear;
  edtFator.Text := '0,00';
  pSetFocus(mskDtaIni);
End;

end.
