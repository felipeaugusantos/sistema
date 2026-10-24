unit untBaixaOrdProdGeral;

interface

uses
  Windows, Classes, Controls, untPaiConfirma, AppEvnts, Menus, Buttons, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, Uni, BitBtnLockedIncrem, cxEditRepositoryItems,
  cxImageComboBox, cxSpinEdit, cxTextEdit, dxBar, dxBarExtItems, cxBarEditItem, Gauges, untZClient,
  cxCheckBox, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, StdCtrls, ExtCtrls, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, System.Variants, Vcl.Graphics;

type
  TfrmBaixaOrdProdGeral = class(TfrmPaiConfirma)
    cxgOrdPro: TcxGrid;
    cxgOrdProTable: TcxGridDBTableView;
    cxgOrdProLevel1: TcxGridLevel;
    cxgConsultaOrdPro: TcxGridDBColumn;
    cxgConsultaNumPed: TcxGridDBColumn;
    cxgConsultaDocFat: TcxGridDBColumn;
    cxStyleRepositorio: TcxStyleRepository;
    cxStyleSelecao: TcxStyle;
    cxStyleGroup: TcxStyle;
    cxgConsultaDtaPed: TcxGridDBColumn;
    RxLabel5: TLabel;
    cxgConsultaQtdApr: TcxGridDBColumn;
    cxgConsultaDtaCad: TcxGridDBColumn;
    cxgConsultaDesIte: TcxGridDBColumn;
    cxgConsultaQtdPro: TcxGridDBColumn;
    cxgConsultaDtaPro: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    mnuBarraConfig: TdxBar;
    dxBarGroup1: TdxBarGroup;
    btnUpdate: TdxBarButton;
    btnClose: TdxBarButton;
    lblInformacao: TLabel;
    btnExpand: TdxBarButton;
    btnCollapse: TdxBarButton;
    pgbProgresso: TGauge;
    btnBaixarOP: TdxBarButton;
    edtDiasExi: TdxBarSpinEdit;
    dxBarStatic4: TdxBarStatic;
    btnImprimirOP: TdxBarButton;
    btnExcluirOP: TdxBarButton;
    cxgConsultaFabFor: TcxGridDBColumn;
    cxgConsultaImpDef: TcxGridDBColumn;
    cxgConsultaQTDORI: TcxGridDBColumn;
    cxgConsultaPrevis: TcxGridDBColumn;
    pnlLegenda: TPanel;
    Shape3: TShape;
    Label8: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Shape1: TShape;
    cxgConsultaDesFas: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure cxgOrdProTableKeyPress(Sender: TObject; var Key: Char);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnExpandClick(Sender: TObject);
    procedure edtDiasExiButtonClick(Sender: TdxBarSpinEdit; Button: TdxBarSpinEditButton);
    procedure btnBaixarOPClick(Sender: TObject);
    procedure btnImprimirOPClick(Sender: TObject);
    procedure btnExcluirOPClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cxgOrdProTableCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    function fVerificaSeHouveBaixaParcial: Boolean;
  private
    { Private declarations }
    blnImpGor: Boolean;
    blnVenVid: Boolean;

    blnMonFas: Boolean;

    cdsOrdPro: TZClient;

    function fSqlConsulta: String;

    procedure pAfterScroll(DataSet: TDataSet);

    Procedure pAbreConsulta;

  public
    { Public declarations }
  end;

implementation

uses SysUtils, Forms, UniClientDataSet, untFuncoesSimples, untBaixaOrdProd, untOrdPro,
  untBaixaOrdProdAcabado, untOrdProMonitoramento;

{$R *.dfm}

procedure TfrmBaixaOrdProdGeral.btnAtualizarClick(Sender: TObject);
begin
  inherited;
  pAbreConsulta;
end;

procedure TfrmBaixaOrdProdGeral.btnBaixarOPClick(Sender: TObject);
  Var
    blnBaixou: Boolean;
    frmBaixaOrdProd: TfrmBaixaOrdProd;
begin
  inherited;

  If cdsOrdPro.Active And Not cdsOrdPro.IsEmpty Then
  Begin
    if (cdsOrdPro.FieldByName('IMPDEF').AsString = 'N') And
       (blnVenVid) And
       (blnImpGor) then
    Begin
      pMensagemOk('Está ordem não é uma importação definitiva!');
      Exit;
    End
    Else if (cdsOrdPro.FieldByName('IMPDEF').AsString = 'S') And
       (blnVenVid) And
       (blnImpGor) then
    Begin
      pMensagemOk('Esta ordem é oriunda de um arquivo de projeto, deve ser baixada pelo menu de manutenção de ordem de produção!');
      Exit;
    End;

    If blnMonFas Then
    Begin
      If Not TOrdProMonitoramento.fValidaFasesBaixa(cdsOrdPro.FieldByName('CODPRO').AsString) Then
        Exit;
    End;

    if fEmptyStr(cdsOrdPro.FieldByname('CODCLI').AsString) then
    begin
      if fEmptyStr(fCfgSis('CLIOPR', varString)) Then
      Begin
        fMensagem('','A ordem de produção não tem um cliente definido e a configuração [CFG_CLIOPR] deve estar definida para setar um cliente para esta ordem de produção!',['&OK']);
        Exit;
      End;
    end;

    blnBaixou := TOrdPro.fOrdemProducaoBaixada(cdsOrdPro.FieldByName('CODPRO').AsString, VS_strCodEmp);

    If blnBaixou Then
      pMensagemOk('A ordem de produção Nº ' +
                  cdsOrdPro.FieldByName('CODPRO').AsString + ' já foi baixada!')
    Else
    Begin
      If fLock_Unlock('ORDPRO_' + cdsOrdPro.FieldByName('CODPRO').AsString + '_' + VS_strCodEmp, True, False, False, '', False) Then
      Begin
        If fPergunta('Confirma a baixa da ordem de produção Nº ' +
                     cdsOrdPro.FieldByName('CODPRO').AsString + '?') Then
        Begin
          Try
            pCriarFormularios(TfrmBaixaOrdProd, frmBaixaOrdProd);
            if blnVenVid And  blnImpGor then
            Begin
              blnBaixou := frmBaixaOrdProd
                .objOrdPro
                .fOrdemProducaoProdutoAcabado(cdsOrdPro.FieldByName('CODPRO').AsString);
            End
            Else
            Begin
              frmBaixaOrdProd.strOrdPro := cdsOrdPro.FieldByName('CODPRO').AsString;
              frmBaixaOrdProd.ShowModal;
              blnBaixou := frmBaixaOrdProd.blnBaixou;
            End;
          Except
            On E: Exception Do
              pMensagensErro(E.Message, '');
          End;

          pFreeAndNil(frmBaixaOrdProd);

        End;

        fLock_Unlock('ORDPRO_' + cdsOrdPro.FieldByName('CODPRO').AsString + '_' + VS_strCodEmp, False);

      end
      Else
      Begin
        Screen.Cursor := crDefault;

        fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                      fGetHostLock('ORDPRO_' + cdsOrdPro.FieldByName('CODPRO').AsString + '_' + VS_strCodEmp)  + '!', ['&Ok']);
        Exit;
      End;
    End;

    If blnBaixou And cdsOrdPro.FieldByName('DTABAI').IsNull Then
      btnUpdate.Click;
  End;
end;

procedure TfrmBaixaOrdProdGeral.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBaixaOrdProdGeral.btnExcluirOPClick(Sender: TObject);
  Var
    blnBaixou: Boolean;
    blnExcluir: Boolean;
    strOperador: String;
    strDocTra: String;
begin
  inherited;
  If cdsOrdPro.Active And Not cdsOrdPro.IsEmpty Then
  Begin
    blnBaixou := TOrdPro.fOrdemProducaoBaixada(cdsOrdPro.FieldByName('CODPRO').AsString, VS_strCodEmp);
    blnExcluir := True;

    If blnBaixou Then
      pMensagemOk('A ordem de produção Nº ' +
                  cdsOrdPro.FieldByName('CODPRO').AsString + ' já foi baixada, ' +
                  'portanto não será permitido excluir a mesma!')
    Else If fVerificaSeHouveBaixaParcial Then
    Begin
      pMensagemOk('A ordem de produção Nº ' +
                  cdsOrdPro.FieldByName('CODPRO').AsString + ' está com Baixa Parcial, ' +
                  'portanto não será permitido excluir a mesma!')
    End
    Else
    Begin
      If fPergunta('Confirma a exclusão da ordem de produção Nº ' +
                   cdsOrdPro.FieldByName('CODPRO').AsString + '?') Then
      Begin
        If Not fVerificaAcessoSistema('frmManOrdPro') Then
        Begin
          If fPergunta('Somente operadores com direitos de acesso ao módulo de ' +
                       '"Manutenção de Ordem de Produção" possuem direito de acesso ' +
                       'para excluir uma ordem de produção. ' +
                       'Deseja solicitar senha do operador?') And

             ffrmSenha(strOperador, 'Senha do Operador Exclusão') Then
          Begin
            strOperador := fRetCodVendedor(strOperador);

            If fEmptyStr(strOperador) Then
            Begin
              fMensagem('', 'Operador não cadastrado.', ['&Ok']);
              blnExcluir := False;
            End
            Else If Not fVerificaAcessoSistema('frmManOrdPro', strOperador) Then
            Begin
              pMensagemOk('Operador informado não possui direitos ' +
                          'de acesso ao módulo de "Manutenção de Ordem de Produção"!');
              blnExcluir := False;
            End;
          End
          Else
            blnExcluir := False;
        End;

        If blnExcluir Then
        Begin
          strDocTra := 'ORDPRO_' + cdsOrdPro.FieldByName('CODPRO').AsString + '_' + VS_strCodEmp;

          If fLock_Unlock(strDocTra, True, False, False, '', False) Then
          Begin
            Try
              fStartTransaction;
              TOrdPro.fExcluirOrdemProducao(cdsOrdPro.FieldByName('CODPRO').AsString, VS_strCodEmp, Self.Name, strOperador);
              fCommit;
            Except
              On E: Exception Do
              Begin
                fRollBack;
                pMensagensErro(E.Message, '');
              End;
            End;

            fLock_Unlock(strDocTra, False);
          end
          Else
          Begin
            fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' + fGetHostLock(strDocTra) + '!', ['&Ok']);
          End; 
        End;
      End;
    End;

    If blnExcluir Or (blnBaixou And cdsOrdPro.FieldByName('DTABAI').IsNull) Then
      btnUpdate.Click;
  End;
end;

procedure TfrmBaixaOrdProdGeral.btnExpandClick(Sender: TObject);
begin
  inherited;
  If Sender = btnExpand Then
  Begin
    btnExpand.Visible := ivNever;
    btnCollapse.Visible := ivAlways;
    cxgOrdProTable.ViewData.Expand(True);
  End
  Else
  Begin
    btnExpand.Visible := ivAlways;
    btnCollapse.Visible := ivNever;
    cxgOrdProTable.ViewData.Collapse(True);
  End;
end;

procedure TfrmBaixaOrdProdGeral.btnImprimirOPClick(Sender: TObject);
  Var
    objOrdPro: TOrdPro;
    intUltimaLinha: Integer;
begin
  inherited;
  If cdsOrdPro.Active And Not cdsOrdPro.IsEmpty Then
  Begin
    If fPergunta('Confirma a impressão da ordem de produção Nº ' +
                 cdsOrdPro.FieldByName('CODPRO').AsString + '?') Then
    Begin
      objOrdPro := TOrdPro.Create(Nil, False);
      intUltimaLinha := 0;
      objOrdPro.pImprimeOrdPro(cdsOrdPro.FieldByName('CODPRO').AsString, intUltimaLinha);
      FreeAndNil(objOrdPro);
    End;
  End;
end;

procedure TfrmBaixaOrdProdGeral.btnUpdateClick(Sender: TObject);
begin
  inherited;
  pAbreConsulta;
end;

procedure TfrmBaixaOrdProdGeral.cxgOrdProTableCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  var
    dtaDataPrevisao: TDate;
begin
  inherited;

  If Not(fEmptyStr(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgConsultaPREVIS.Index]))) Then
  Begin

    dtaDataPrevisao:= strToDate(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgConsultaPREVIS.Index]));

    If (dtaDataPrevisao >= strToDate(FormatDateTime('dd/mm/yyyy', fNow()))) Then // Data Previsao
    Begin
      ACanvas.Brush.Color := clGreen;
    End
    Else
    If (dtaDataPrevisao < strToDate(FormatDateTime('dd/mm/yyyy', fNow()))) Then // Data Previsao
    Begin
      ACanvas.Brush.Color := clRed;
    End


  End

end;

procedure TfrmBaixaOrdProdGeral.cxgOrdProTableKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := UpCase(Key);
end;

procedure TfrmBaixaOrdProdGeral.edtDiasExiButtonClick(Sender: TdxBarSpinEdit; Button: TdxBarSpinEditButton);
begin
  inherited;
  Case Button Of
    sbUp   : Sender.Value := Sender.Value + 1;
    sbDown : Sender.Value := Sender.Value - 1;
  End;
end;

procedure TfrmBaixaOrdProdGeral.FormActivate(Sender: TObject);
begin
  inherited;
  
  pAbreConsulta;
end;

procedure TfrmBaixaOrdProdGeral.FormCreate(Sender: TObject);
begin
  inherited;
  cdsOrdPro  := TZClient.Create(Self);
  blnVenVid := fCfgSis('VENVID', varBoolean);
  blnImpGor := fCfgSis('IMPGOR', varBoolean);
  cxgConsultaImpDef.Visible := blnImpGor And blnVenVid;
  blnMonFas := fCfgSis('MONFAS', varBoolean);
  cxgConsultaDesFas.Visible := blnMonFas;
end;

procedure TfrmBaixaOrdProdGeral.FormDestroy(Sender: TObject);
begin
  If Assigned(cdsOrdPro) Then
    FreeAndNil(cdsOrdPro);

  inherited;
end;

procedure TfrmBaixaOrdProdGeral.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F5 : btnUpdate.Click;
    VK_F6 : btnImprimirOP.Click;
    VK_F3 : btnExcluirOP.Click;
    VK_RETURN: btnBaixarOP.Click;
  End;
end;

Procedure TfrmBaixaOrdProdGeral.pAbreConsulta;
Begin

  lblInformacao.Caption := 'AGUARDE, CARREGANDO ORDENS DE PRODUÇÃO...';
  Application.ProcessMessages;

  With cdsOrdPro, qryQuery Do
  Begin
    Close;
    SQL.text := fSqlConsulta;

    ParamByName('CODEMP').AsString  := VS_strCodEmp;

    Open;
  End;

  With cdsOrdPro Do
  Begin
    Close;
    pSetProvider;
    Open;

    TStringField(FieldByName('CODPRO')).Alignment := taCenter;
    TStringField(FieldByName('NUMPED')).Alignment := taCenter;
    TStringField(FieldByName('DOCFAT')).Alignment := taCenter;

    TDateTimeField(FieldByName('DTACAD')).Alignment := taCenter;
    TDateTimeField(FieldByName('DTAPED')).Alignment := taCenter;
    TDateTimeField(FieldByName('DTAPRO')).Alignment := taCenter;
    TDateTimeField(FieldByName('DTABAI')).Alignment := taCenter;
    TDateTimeField(FieldByName('HORBAI')).Alignment := taCenter;

    TFloatField(FieldByName('QTDAPR')).DisplayFormat := fMskDigitos( fCfgSis('DECQTD', varInteger) );
    TFloatField(FieldByName('QTDPRO')).DisplayFormat := fMskDigitos( fCfgSis('DECQTD', varInteger) );
    TFloatField(FieldByName('QTDORI')).DisplayFormat := fMskDigitos( fCfgSis('DECQTD', varInteger) );

  End;

  cdsOrdPro.AfterScroll := pAfterScroll;

  cxgOrdProTable.DataController.DataSource := cdsOrdPro.dtsSource;

  cxgOrdProTable.ApplyBestFit;

  btnExpandClick(btnExpand);

  pAfterScroll(cdsOrdPro);
end;

procedure TfrmBaixaOrdProdGeral.pAfterScroll(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    lblInformacao.Caption := FieldByname('OBS001').AsString + #13#10 +
                             FieldByname('OBS002').AsString;
  End;
end;

function TfrmBaixaOrdProdGeral.fSqlConsulta: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  IFNULL(P.FDO_DTAENT, G.FGO_DTAENT) AS DTAPED, ';
  strSQL := strSQL + '  IFNULL(CONCAT(P.FDO_NUMDOC, "-", P.FDO_ESPDOC, "-", P.FDO_CODEMP), '+
    ' CONCAT(PRO_NUMPED, "-", PRO_ESPPED, "-", PRO_EMPPED)) AS NUMPED, ';
  strSQL := strSQL + '  CONCAT(C.CLI_NOMCLI, " (", C.CLI_CODCLI, ") ") AS NOMCLI, ';
  strSQL := strSQL + '  CONCAT(P.FDO_NUMFAT, "-", P.FDO_TIPFAT, "-", P.FDO_EMPFAT) AS DOCFAT, ';
  strSQL := strSQL + '  M.PRO_CODPRO AS CODPRO, ';
  strSQL := strSQL + '  M.PRO_DTACAD AS DTACAD, ';
  strSQL := strSQL + '  M.PRO_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  M.PRO_CODITE AS CODITE, ';
  strSQL := strSQL + '  CONCAT(M.PRO_CODITE, "-", E.ITE_DESITE) AS DESITE, ';
  strSQL := strSQL + '  IFNULL(M.PRO_QTDAPR,0) - IFNULL(M.PRO_QTDPRO,0) AS QTDAPR, ';
  strSQL := strSQL + '  M.PRO_DTAPRO AS DTAPRO, ';
  strSQL := strSQL + '  M.PRO_DTABAI AS DTABAI, ';
  strSQL := strSQL + '  M.PRO_HORBAI AS HORBAI, ';
  strSQL := strSQL + '  IFNULL(M.PRO_QTDAPR, 0) AS QTDORI, ';
  strSQL := strSQL + '  IFNULL(M.PRO_QTDPRO,0) AS QTDPRO, ';
  strSQL := strSQL + '  M.PRO_OBS001 AS OBS001, ';
  strSQL := strSQL + '  M.PRO_OBS002 AS OBS002, ';
  strSQL := strSQL + '  E.ITE_CODFAB AS CODFAB, ';
//  strSQL := strSQL + '  D.DOP_ITESUB AS ITESUB, ';
//  strSQL := strSQL + '  CONCAT(D.DOP_ITESUB, "-", S.ITE_DESITE) AS DESSUB, ';
//  strSQL := strSQL + '  IF(M.PRO_DTABAI IS NULL, M.PRO_QTDAPR - M.PRO_QTDPRO, M.PRO_QTDPRO) * D.DOP_QTDITE AS QTDSUB, ';
  strSQL := strSQL + '  M.AUTOINCREM AS AUTINC,  ';
  strSQL := strSQL + '  M.PRO_IMPDEF AS IMPDEF,  ';
  strSQL := strSQL + '  M.PRO_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  M.PRO_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  G.FGO_PREVIS AS PREVIS ';
  If blnMonFas Then
  Begin
    strSQL := strSQL + ' ,IF((SELECT COUNT(1) AS CNT FROM MNTORD WHERE MNT_SEQORD = M.AUTOINCREM                                                    ';
    strSQL := strSQL + '    AND ((MNT_DTAINI IS NULL) OR (MNT_DTAINI IS NOT NULL AND MNT_DTAFIN IS NULL))) = 0, "Concluídas","Pendentes") AS DESFAS ';
  End;
  strSQL := strSQL + 'FROM       ';
  strSQL := strSQL + '  MOVPRO M ';
//  strSQL := strSQL + '  INNER JOIN DETPRO D ON D.DOP_SEQGER = M.AUTOINCREM AND D.DOP_CODEMP = M.PRO_CODEMP ';
  strSQL := strSQL + '  LEFT  JOIN FATDOR P ON M.PRO_CODPRO = P.FDO_ORDPRO ';
  strSQL := strSQL + '                     AND M.PRO_CODEMP = P.FDO_CODEMP ';
  strSQL := strSQL + '                     AND M.PRO_NUMDOC = P.FDO_NUMDOC ';
  strSQL := strSQL + '                     AND M.PRO_ESPDOC = P.FDO_ESPDOC ';
  strSQL := strSQL + '                     AND M.PRO_CODITE = P.FDO_CODITE ';
  strSQL := strSQL + '  LEFT  JOIN FATGOR G ON G.FGO_CODEMP = M.PRO_EMPPED ';
  strSQL := strSQL + '                     AND G.FGO_NUMDOC = M.PRO_NUMPED ';
  strSQL := strSQL + '                     AND G.FGO_ESPDOC = M.PRO_ESPPED ';
  strSQL := strSQL + '  LEFT  JOIN CADCLI C ON C.CLI_CODCLI = M.PRO_CODCLI ';
  strSQL := strSQL + '  INNER JOIN CADITE E ON E.ITE_CODITE = M.PRO_CODITE ';
//  strSQL := strSQL + '  INNER JOIN CADITE S ON S.ITE_CODITE = D.DOP_ITESUB ';
  strSQL := strSQL + 'WHERE                    ';
  strSQL := strSQL + '  PRO_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  PRO_DTABAI IS NULL ';
  strSQL := strSQL + 'ORDER BY             ';
  strSQL := strSQL + '  PRO_CODPRO, PRO_CODEMP ';

  Result := strSQL;
End;

function TfrmBaixaOrdProdGeral.fVerificaSeHouveBaixaParcial: Boolean;
begin
  Result:= (cdsOrdPro.FieldByName('QTDPRO').AsFloat >= 1) AND
           (cdsOrdPro.FieldByName('QTDPRO').AsFloat < cdsOrdPro.FieldByName('QTDORI').AsFloat);
end;

end.
