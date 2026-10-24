unit untEntSelecionaNotaElet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, System.UITypes,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  StrUtils, BitBtnLockedIncrem, MemDS, DBAccess, Provider, frxClass,
  frxExportCSVTestabilidade, untEntConfPreNotaFuncoes, Datasnap.DBClient,
  untTypesSistema, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, untPaiEdit, cxGridExportLink,
  untTDistribuicaoConferencia, untTEnderecamentoConferenciaParcial;


type

  TPedReq = Record
    strNumPed: String;
    strEspPed: String;
    strEmpPed: String;
    strCodCli: String;
  End;

  TArrPedReq = Array Of TPedReq;

  TfrmEntSelecionaNotaElet = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    btnSeleciona: TBitBtnLocked;
    dbgPedidos: TDBGridCitel;
    Splitter1: TSplitter;
    cxvConsulta: TcxGridDBTableViewCitel;
    cxgConsultaLevel: TcxGridLevel;
    cxgConsulta: TcxGridCitel;
    cxvConsultaIDEDIG: TcxGridDBColumn;
    cxvConsultaAGEREC: TcxGridDBColumn;
    cxvConsultaNUMDOC: TcxGridDBColumn;
    cxvConsultaESPDOC: TcxGridDBColumn;
    cxvConsultaSERDOC: TcxGridDBColumn;
    cxvConsultaDTAEMI: TcxGridDBColumn;
    cxvConsultaCODFOR: TcxGridDBColumn;
    cxvConsultaNOMFOR: TcxGridDBColumn;
    cxvConsultaVALDOC: TcxGridDBColumn;
    cxvConsultaRAZSOC: TcxGridDBColumn;
    cxvConsultaMARDES: TcxGridDBColumn;
    pnlTail: TPanel;
    shpGarantia: TShape;
    Label1: TLabel;
    pnlHeader: TPanel;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    cxvConsultaAUTOINCREM: TcxGridDBColumn;
    cxvConsultaDTAENT: TcxGridDBColumn;
    btnGerarCSV: TBitBtnLocked;
    procedure btnSelecionaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgPedidosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure cxvConsultaCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGerarCSVClick(Sender: TObject);
  private
    qryPedidos : TUniQuery;
    dtsPedidos : TDataSource;
    clrCorZebra: TColor;
    ArrPedReq: TArrPedReq;
    procedure pAddListaQuery;
    procedure pAddListaQueryInterna;
    procedure pMascaraValor;
    procedure pMarcaDesmarca;
    function fGetSqlPedidos: String;
    function fRetChaveLista: String;
    function fInLista: Boolean;
    procedure pCarregaPedidosRequisao(ASeqger: String);
    procedure pAtualizaStatusPedidos;


    function fAbreConsulta: Boolean;
    function fGetSql(blnLike: Boolean): String;
  public
    { Public declarations }

    objConfPreNota: TConferePreNota;
    opcTipoOperacao : TipoOperacaoPreNota;
    topTipoOperacaoPreNota : TipoOperacaoPreNota;
    stlListSelecao       : TStringList;
    strCampoLista        : String;
    intCorSelecao        : Integer;
  end;

implementation

uses untFuncoesSimples, untPreNota, untFuncoesCRM, untTypesCRM,
  untDefineBaixaPedido, untTSituacaoPedidoVenda;

{$R *.dfm}

function TfrmEntSelecionaNotaElet.fAbreConsulta: Boolean;
begin
  Try
    With qryConsulta, Sql Do
    Begin
      Close;
      cdsConsulta.Close;
      Clear;
      Add(fGetSql(True));
      Open;
      If Assigned(dspConsulta.DataSet) Then
        pSetaClient(dspConsulta.DataSet);
      cdsConsulta.Open;
      pMascaraValor;
      Result := True;
    End;
  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmEntSelecionaNotaElet.fAbreConsulta]');
      Result := False;
    End;
  End;
end;

function TfrmEntSelecionaNotaElet.fGetSql(blnLike: Boolean): String;
Begin
  Result := objConfPreNota.fGetSqlConfer(blnLike, opcTipoOperacao);
End;

procedure TfrmEntSelecionaNotaElet.btnConfirmaClick(Sender: TObject);
  var
    intCont: Integer;
    qryCanc: TUniQuery;
    Erro: String;
begin

  If stlListSelecao.Count = 0 Then
    Exit;

  If opcTipoOperacao = opeConferencia Then
    inherited;

  With cdsConsulta Do
  Begin
    objConfPreNota.strDocume := '';

    For intCont := 0 To stlListSelecao.Count -1 Do
    Begin
      If cdsConsulta.Locate('AUTOINCREM', stlListSelecao[intCont], []) Then
      Begin
        objConfPreNota.strDocume := objConfPreNota.strDocume + FieldByName('NUMDOC').AsString + '-' +
                                                               FieldByName('ESPDOC').AsString + ' ' +
                                                               FieldByName('SERDOC').AsString + ', ';
      End;
    end;
    objConfPreNota.ObjDistribuicaoConferencia := TDistribuicaoConferenciaFactory.CriarPorGerEle(stlListSelecao);
    If opcTipoOperacao = opeConferencia Then
      If TEnderecamentoConferenciaParcial.ConferenciaSemDigConCorreta(FieldByName('SEQFGO').AsString) Then
      Begin
        objConfPreNota.strDocume := '';
        raise Exception.Create('Esta conferência foi iniciada em outra vesão do Autcom, por motivos de compatibilidade não será possível prosseguir com esta versão!');
      End;
    objConfPreNota.strCdiFor := objConfPreNota.strCodFor;
    objConfPreNota.strCodFor := objConfPreNota.strCodFor + '-' + fRetNomFornecedor(objConfPreNota.strCodFor);
    objConfPreNota.strDocume := LeftStr(objConfPreNota.strDocume, Length(objConfPreNota.strDocume) -2);
    objConfPreNota.strIncrem := stlListSelecao.Text;
    objConfPreNota.strSerDoc := FieldByName('SERDOC').AsString;
    objConfPreNota.strNumDoc := FieldByName('NUMDOC').AsString;
    objConfPreNota.dtaDtaDoc := FieldByName('DTAEMI').AsDateTime;
    objConfPreNota.dtaFisDtaEnt := FieldByName('FIS_DTAENT').AsDateTime;
    objConfPreNota.strSeqFgo := FieldByName('SEQFGO').AsString;

  end;

  If (fCfgSis('TIPPNT', varString) = 'D') and ((fCfgSis('UDEVME') = 'S') or (fCfgSis('COFEND') = 'S')) then
   If not objConfPreNota.ObjDistribuicaoConferencia.fPodeCancelarConferencia(Erro) Then
   Begin
     objConfPreNota.strDocume := '';
     pMensagemOk(Erro);
     Exit;
   End;

  If (opcTipoOperacao <> opeConferencia) And
     (fMensagem('','Este processo cancelará a ' + IfThen(opcTipoOperacao = opeCancelaConferencia, 'Conferência' , 'Pré-Nota') + ', Deseja prosseguir?', ['','']) = 1) Then
  Begin
    Try
      fStartTransaction;

      qryCanc := fCriaQuery(Nil);
      If (opcTipoOperacao = opeCancelaConferencia) Then
      Begin
        If fUsaRotinaWMS And fConferenciaDepoisDaEntrada And (fCfgSis('TPLREC', varString) <> 'N') Then
        Begin
          qryCanc.Close;
          qryCanc.SQL.Clear;
          qryCanc.SQL.Add('UPDATE AGEREC SET ARC_STATUS = '+ IfThen(fConferenciaAntesDoPlanoDeRecebimento, '"EC"', '"EP"') + ' WHERE ARC_IDEDIG = ' + QuotedStr(cdsConsulta.FieldByName('IDEDIG').AsString));
          qryCanc.ExecSQL;
        End;

        //Remove as conferencias
        qryCanc.Close;
        qryCanc.SQL.Clear;
        qryCanc.SQL.Add('DELETE FROM DIGELE WHERE DIG_IDEDIG = ' + QuotedStr(cdsConsulta.FieldByName('IDEDIG').AsString) +
                                     ' AND DIG_CODEMP = ' + QuotedStr(VS_strCodEmp));
        qryCanc.ExecSQL;

        If (fCfgSis('TIPPNT', varString) = 'D') and ((fCfgSis('UDEVME') = 'S') or (fCfgSis('COFEND') = 'S')) then
          If not objConfPreNota.ObjDistribuicaoConferencia.fCancelaConferenciaBaixada(Erro) Then
          begin
            fRollback;
            Exit;
          End;

        {// Remove a pre-baixa
        If (fConferenciaDepoisDaEntrada And fEmptyStr(cdsConsulta.FieldByName('DOCENT').AsString)) Or (not fConferenciaDepoisDaEntrada) Then
          TPreNota.pExcluiPreBaixa(cdsConsulta.FieldByName('AUTOINCREM').AsString);}

        If (fCfgSis('TIPPNT', varString) = 'D') and ((fCfgSis('UDEVME') = 'S') or (fCfgSis('COFEND') = 'S')) then
          If not objConfPreNota.ObjDistribuicaoConferencia.fCancelaConferenciaBaixada(Erro) Then
          begin
            fRollback;
            Exit;
          End;
        //Se usa o retorno pela pre nota, tem que limpar as quantidades de contagem para conseguir conferir novamente.
        If fCfgSis('REFENT', varBoolean) Then
        Begin
          qryCanc.Close;
          qryCanc.SQL.Clear;
          qryCanc.SQL.Add(' SELECT MOVGAE.*  ');
          qryCanc.SQL.Add(' FROM PEDELE      ');
          qryCanc.SQL.Add('   INNER JOIN PCMDET ON PCD_NUMPED = PEL_NUMDOC ');
          qryCanc.SQL.Add('                    AND PCD_ESPDOC = PEL_ESPDOC ');
          qryCanc.SQL.Add('                    AND PCD_CODEMP = PEL_CODEMP ');
          qryCanc.SQL.Add('                    AND PCD_CODFOR = PEL_CODFOR ');

          qryCanc.SQL.Add(' INNER JOIN MOVGAE ON GAE_NUMENV = SUBSTRING(PCD_DOCORI,1,12) ');
          qryCanc.SQL.Add('                  AND GAE_ESPENV = SUBSTRING(PCD_DOCORI,13,2) ');
          qryCanc.SQL.Add('                  AND GAE_DTAENV = PCD_DTAPED ');
          qryCanc.SQL.Add('                  AND GAE_EMPENV = PCD_CODEMP ');

          qryCanc.SQL.Add(' WHERE PEL_SEQELE = :SEQELE ');

          For intCont := 0 To stlListSelecao.Count -1 Do
          Begin
            qryCanc.ParamByName('SEQELE').AsString := stlListSelecao[intCont];
            qryCanc.Open;
            While not qryCanc.Eof Do
            Begin
              qryCanc.Edit;
              qryCanc.FieldByName('GAE_REFCON').AsFloat := 0;
              qryCanc.FieldByName('GAE_RETCON').AsFloat := 0;
              qryCanc.Post;
              qryCanc.Next;
            End;
          End;

        End;

        //retorna a nota para a situação antes de setar como pre-nota
        qryCanc.Close;
        qryCanc.SQL.Clear;
        qryCanc.SQL.Add('UPDATE GERELE SET ');

        //Só limpa o sequencial se nao utiuliza wms com coletor de dados.
        If Not ( fUsaRotinaWMS And fConferenciaDepoisDaEntrada and (fCfgSis('TPLREC', varString) <> 'N') ) Then
          qryCanc.SQL.Add('  GER_IDEDIG = NULL, ');

        qryCanc.SQL.Add('  GER_DTACON = NULL, ');
        qryCanc.SQL.Add('  GER_INDCON = NULL, ');
        qryCanc.SQL.Add('  GER_INHCON = NULL, ');
        qryCanc.SQL.Add('  GER_HORCON = NULL, ');
        qryCanc.SQL.Add('  GER_ENDFIN = "N", ');
        qryCanc.SQL.Add('  GER_OPECON = NULL  ');

        qryCanc.SQL.Add('WHERE AUTOINCREM = :AUTINC');

        For intCont := 0 To stlListSelecao.Count -1 Do
        Begin
          qryCanc.ParamByName('AUTINC').AsString := stlListSelecao[intCont];
          qryCanc.ExecSQL;
          TDefineBaixaPedido.ProcessaStatusPedidoRequisicaoConferencia(stlListSelecao[intCont]);
        End;

      End;

      //Remove dados contas a pagar prectp e precnd
      For intCont := 0 To stlListSelecao.Count -1 Do
      Begin
        qryCanc.Close;
        qryCanc.SQL.Clear;
        qryCanc.SQL.Add('DELETE FROM PRECTP WHERE PRE_SEQGER = :AUTINC');
        qryCanc.ParamByName('AUTINC').AsString := stlListSelecao[intCont];
        qryCanc.ExecSQL;

        qryCanc.Close;
        qryCanc.SQL.Clear;
        qryCanc.SQL.Add('DELETE FROM PRECND WHERE PRE_SEQGER = :AUTINC');
        qryCanc.ParamByName('AUTINC').AsString := stlListSelecao[intCont];
        qryCanc.ExecSQL;

        qryCanc.Close;
        qryCanc.SQL.Clear;
        qryCanc.SQL.Add('DELETE FROM PREDES WHERE PRE_SEQGER = :AUTINC');
        qryCanc.ParamByName('AUTINC').AsString := stlListSelecao[intCont];
        qryCanc.ExecSQL;

        qryCanc.Close;
        qryCanc.SQL.Clear;
        qryCanc.SQL.Add('DELETE FROM PREPGA WHERE PRE_SEQGER = :AUTINC');
        qryCanc.ParamByName('AUTINC').AsString := stlListSelecao[intCont];
        qryCanc.ExecSQL;
      End;

      //Remove os pedidos
      For intCont := 0 To stlListSelecao.Count -1 Do
      Begin
        if cdsConsulta.Locate('AUTOINCREM', stlListSelecao[intCont], []) Then
        Begin
          If (opcTipoOperacao = opeCancelaPreNota) Then
          Begin
            pCarregaPedidosRequisao(cdsConsulta.FieldByName('AUTOINCREM').AsString);
            If (fConferenciaDepoisDaEntrada And fEmptyStr(cdsConsulta.FieldByName('DOCENT').AsString)) Or (not fConferenciaDepoisDaEntrada) Then
            Begin
              If (VS_strHabilitarCRM) Then
                pGeraHisOcoConferencia(cdsConsulta.FieldByName('AUTOINCREM').AsString, afcPedidoCancelaPreNota);

              qryCanc.Close;
              qryCanc.SQL.Clear;
              qryCanc.SQL.Add('DELETE FROM PEDELE WHERE PEL_SEQELE = ' + QuotedStr(cdsConsulta.FieldByName('AUTOINCREM').AsString));
              qryCanc.ExecSQL;
            End;
            TDefineBaixaPedido.ProcessaStatusPedidoRequisicao(cdsConsulta.FieldByName('AUTOINCREM').AsString);

            TPreNota.pExcluiPreBaixa(cdsConsulta.FieldByName('AUTOINCREM').AsString);

            //Remove as criticas armazenadas
            qryCanc.Close;
            qryCanc.SQL.Clear;
            qryCanc.SQL.Add('DELETE FROM PRECRI WHERE CRI_AUTNFE = ' + QuotedStr(cdsConsulta.FieldByName('AUTOINCREM').AsString));
            qryCanc.ExecSQL;

            qryCanc.Close;
            qryCanc.SQL.Clear;
            qryCanc.SQL.Add('UPDATE GERELE SET ');
            qryCanc.SQL.Add(' GER_DTALIB = IF(GER_CONDIR = "S", GER_DTALIB, NULL), ');
            qryCanc.SQL.Add(' GER_IDEDIG = NULL ');
            qryCanc.SQL.Add('WHERE AUTOINCREM = :AUTINC');

            qryCanc.ParamByName('AUTINC').AsString := stlListSelecao[intCont];
            qryCanc.ExecSQL;

          End;
        End;
      End;

      If (opcTipoOperacao = opeCancelaPreNota) Then
        pAtualizaStatusPedidos;

      fCommit;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message,'');
      End;
    End;

    FreeAndNil(qryCanc);

    pMensagemOk(IfThen(opcTipoOperacao = opeCancelaConferencia, 'Conferência(s)' , 'Pré-Nota(s)') + ' cancelada(s) com sucesso!');

    if Assigned(objConfPreNota) and (not fEmptyStr(objConfPreNota.strAutoincremGERELE)) then
      Self.Close;

    inherited;
  End
end;

procedure TfrmEntSelecionaNotaElet.btnGerarCSVClick(Sender: TObject);
Var
    dlgSave    : TSaveDialog;
Begin

  inherited;

  Try

    Application.ProcessMessages;

    qryConsulta.DisableControls;

    dlgSave     := TSaveDialog.Create(Self);
    Try
      dlgSave.Filter := 'Arquivos CSV|*.csv';

      If dlgSave.Execute Then
        Begin
          ExportGridToCSV(dlgSave.FileName, cxgConsulta,  True, True , ';');
          pMensagemOk('Arquivo gerado com sucesso!');
        End;

      qryConsulta.First;
      qryConsulta.EnableControls;
    Finally
      FreeAndNil(dlgSave);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmEntSelecionaNotaElet.btnGerarCSVClick]');
    End;
  End;


End;


procedure TfrmEntSelecionaNotaElet.btnSelecionaClick(Sender: TObject);
begin
  inherited;
  pAddListaQuery;
end;

procedure TfrmEntSelecionaNotaElet.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If cdsConsulta.Active Then
  Begin
    qryPedidos.Close;
    qryPedidos.ParamByName('SEQELE').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
    qryPedidos.Open;
  End;
  
end;

procedure TfrmEntSelecionaNotaElet.cxvConsultaCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
    If ((Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvConsultaMARDES.Index]) = '1') Then
    Begin
      If ACanvas.Brush.Color = clHighLight Then
      Begin
        ACanvas.Font.Color := clHighLightText;
      End Else
      Begin
        ACanvas.Brush.Color := intCorSelecao;
      End;
    End;
end;

procedure TfrmEntSelecionaNotaElet.cxvConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_RETURN) then
  begin
    btnSeleciona.Click;
  end;

end;

procedure TfrmEntSelecionaNotaElet.dbgPedidosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If TDBGridCitel(Sender).DataSource.DataSet.FieldByName('PEDGAR').AsString = 'S' Then
  Begin
    TDBGridCitel(Sender).Canvas.Font.Color := shpGarantia.Brush.Color;
    TDBGridCitel(Sender).Canvas.FillRect(Rect);
    TDBGridCitel(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
end;

procedure TfrmEntSelecionaNotaElet.FormShow(Sender: TObject);
begin
  inherited;
  strCampoLista := 'AUTOINCREM';
  objConfPreNota.strCodFor := '';
  objConfPreNota.blnPedCompraGarantia := False;
//  objConfPreNota.blnCancelamentoPreNota := (opcTipoOperacao <> opeConferencia);

  If opcTipoOperacao = opeCancelaConferencia Then
    Self.Caption := 'Cancelamento de Conferência de Entrada'
  Else
  If opcTipoOperacao = opeCancelaPreNota Then
    Self.Caption := 'Cancelamento de Pré-Nota';

  if Not (fConferenciaDepoisDaEntrada and (fCfgSis('TPLREC', varString) <> 'N')) Then
    cxvConsultaAGEREC.Visible := False;

  If fConferenciaDepoisDaEntrada Then
    cxvConsultaDTAENT.Visible := True
  Else
    cxvConsultaDTAENT.Visible := False;

  fAbreConsulta;
end;

function TfrmEntSelecionaNotaElet.fRetChaveLista: String;
begin
  Result := cdsConsulta.Fieldbyname(strCampoLista).AsString;
end;

procedure TfrmEntSelecionaNotaElet.pAddListaQuery;
  Var
    strIncAtu: String;
    qryCanc : TUniQuery;
    blnCofEnd: Boolean;
    ObjDistribuicaoConferencia: TDistribuicaoConferencia;
Begin
  Try
    blnCofEnd := fCfgSis('COFEND', varBoolean);
    cdsConsulta.DisableControls;

    If (blnCofEnd) and (opcTipoOperacao = opeCancelaConferencia) Then
    Begin
      ObjDistribuicaoConferencia := TDistribuicaoConferenciaFactory.CriarPorIDeDig(cdsConsulta.FieldByName('IDEDIG').AsString);
      Try
        If ObjDistribuicaoConferencia.fJateveDevolucao Then
        begin
          fMensagem('', 'Esta conferência não poderá ser cancelar pois existe devolução realizado!',['&Ok']);
          Exit;
        end;

        If ObjDistribuicaoConferencia.fJateveEnderecamento Then
        begin
          fMensagem('', 'Esta conferência não poderá ser cancelada pois existe endereçamento realizado!',['&Ok']);
          Exit;
        end
      Finally
        FreeAndNil(ObjDistribuicaoConferencia)
      End;
    End;

    If opcTipoOperacao = opeCancelaConferencia Then
      if (blnCofEnd) And (cdsConsulta.FieldByName('ITE_QTDEND').AsCurrency > 0) Then
      Begin
        fMensagem('', 'Esta conferência só poderá ser cancelar quando não houver endereçamento!',['&Ok']);
        Exit;
      End;
    if Not objConfPreNota.fValidaQuantidades(cdsConsulta, opcTipoOperacao) Then
    Begin
      fMensagem('', 'Não é possível marcar este documento pois o mesmo já possui quantidade endereçada ou devolvida!',['&Ok']);
      Exit;
    End;

    if objConfPreNota.fValidaPedidoSelec(cdsConsulta, objConfPreNota.strCodFor) then
    begin

      With cdsConsulta Do
      If (stlListSelecao.Count > 0) And (Not SameText(objConfPreNota.strIdeDig, FieldByName('IDEDIG').AsString)) Then
      Begin
        fMensagem('','Selecione documentos da mesma conferência!', ['&Ok']);
      End

      Else
      Begin
        If (stlListSelecao.Count > 0) And (not fInLista) Then
        Begin
          If objConfPreNota.blnPedCompraGarantia And (not fPedidoDeCompraOriundoDeGarantia(qryPedidos.FieldByName('PCG_NUMPED').AsString,
                                                                                           qryPedidos.FieldByName('PCG_CODEMP').AsString)) Then
          Begin
            fMensagem('', 'Só é permitido selecionar nota onde os pedidos são originados de garantia!', ['&Ok']);
            Exit;
          End

          Else
          If (not objConfPreNota.blnPedCompraGarantia) And (fPedidoDeCompraOriundoDeGarantia(qryPedidos.FieldByName('PCG_NUMPED').AsString,
                                                                                             qryPedidos.FieldByName('PCG_CODEMP').AsString)) Then
          Begin
            fMensagem('', 'Só é permitido selecionar nota onde os pedidos não são originados de garantia!', ['&Ok']);
            Exit;
          End;

        End;

        If (opcTipoOperacao = opeCancelaConferencia) and fUsaRotinaWMS And fConferenciaDepoisDaEntrada And (fCfgSis('TPLREC', varString) <> 'N') Then
        Begin
          Try
            qryCanc := fCriaQuery;

            qryCanc.Close;
            qryCanc.SQL.Clear;
            if (fCfgSis('TPLREC', varString) = 'L') Then
            Begin
              qryCanc.SQL.Add(' SELECT L.*                                         ');
              qryCanc.SQL.Add(' FROM AGEREC R                                      ');
              qryCanc.SQL.Add('   INNER JOIN AGEITE I ON AIT_SEQGER = R.AUTOINCREM ');
              qryCanc.SQL.Add('   INNER JOIN AGEILO L ON AIL_SEQITE = I.AUTOINCREM ');
              qryCanc.SQL.Add(' WHERE ARC_IDEDIG = :IDEDIG                         ');
              qryCanc.SQL.Add('   AND AIL_ENDERE = "S"                             ');
            End
            Else
            Begin
              qryCanc.SQL.Add(' SELECT R.*                                         ');
              qryCanc.SQL.Add(' FROM AGEREC R                                      ');
              qryCanc.SQL.Add('   INNER JOIN AGEITE I ON AIT_SEQGER = R.AUTOINCREM ');
              qryCanc.SQL.Add(' WHERE ARC_IDEDIG = :IDEDIG                         ');
              qryCanc.SQL.Add('   AND AIT_QTDEND > 0                               ');
            End;
            qryCanc.ParamByName('IDEDIG').AsString := cdsConsulta.FieldByName('IDEDIG').AsString;

            qryCanc.Open;

            If (qryCanc.RecordCount > 0) Then
            Begin
              pMensagemOK('Esse sequêncial de conferência já começou a ser endereçado, não é possivel cancelar!');
              Exit;
            End;
          Finally
            FreeAndNil(qryCanc);
          End;

        End;

        //If blnCancel and fConferenciaDepoisDaEntrada And (not fEmptyStr(cdsConsulta.FieldByName('DOCENT').AsString)) Then
        //Begin
        //  If fMensagem('', 'Já foi realizada a entrada de mercadorias desse documento, deseja cancelar apenas a conferência da pré-nota?', ['&Sim', '&Não'], 2) = 2 Then
        //    Exit;
        //End;

        pAddListaQueryInterna;

        objConfPreNota.strIdeDig := FieldByName('IDEDIG').AsString;
        strIncAtu := FieldByName('AUTOINCREM').AsString;

        If Not fEmptyStr(objConfPreNota.strIdeDig) Then
        Begin
          cdsConsulta.Filter := 'IDEDIG = ' + QuotedStr(objConfPreNota.strIdeDig);
          cdsConsulta.Filtered := True;

          While Not Eof Do
          Begin
            If strIncAtu <> FieldByName('AUTOINCREM').AsString Then
              pAddListaQueryInterna;
            Next;
          End;

          cdsConsulta.Filtered := False;
          Locate('AUTOINCREM', strIncAtu, []);
        end;

        If stlListSelecao.Count = 0 Then
          objConfPreNota.strCodFor := ''
        Else
          objConfPreNota.strCodFor := cdsConsulta.FieldByName('CODFOR').AsString;

        If stlListSelecao.Count = 1 Then
          objConfPreNota.blnPedCompraGarantia := (qryPedidos.RecordCount > 0) And fPedidoDeCompraOriundoDeGarantia(qryPedidos.FieldByName('PCG_NUMPED').AsString,
                                                                                                                   qryPedidos.FieldByName('PCG_CODEMP').AsString);
      End;

    end;

  Finally
    cdsConsulta.EnableControls;
  End;

End;

procedure TfrmEntSelecionaNotaElet.pAddListaQueryInterna;
var
  strAuto  : String;
  intIndex : integer;
begin
  If cdsConsulta.Active And (Not cdsConsulta.IsEmpty) Then
  Begin
    strAuto  := fRetChaveLista;

    intIndex := stlListSelecao.IndexOf(strAuto);
    If intIndex > -1 then
    Begin
      stlListSelecao.Delete(intIndex);
    End
    Else
    Begin
      stlListSelecao.Add(strAuto);
    End;
    pMarcaDesmarca;
  End;
end;

procedure TfrmEntSelecionaNotaElet.pMarcaDesmarca;
begin
  cdsConsulta.Edit;
  If cdsConsulta.FieldByName('MARDES').AsInteger = 0 then
    cdsConsulta.FieldByName('MARDES').AsInteger := 1
  Else
    cdsConsulta.FieldByName('MARDES').AsInteger := 0;
  cdsConsulta.Post;
end;

procedure TfrmEntSelecionaNotaElet.pMascaraValor;
Begin
  If cdsConsulta.Active Then
    TFloatField(cdsConsulta.FieldByName('VALDOC')).DisplayFormat := fMskDigitos(2);
End;

procedure TfrmEntSelecionaNotaElet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If (ModalResult = mrOk) And (stlListSelecao.Count = 0) Then
  Begin
    fMensagem('','Selecione um documento para conferência!', ['&Ok']);
    Action := caNone;
  End;

  inherited;
end;

procedure TfrmEntSelecionaNotaElet.FormCreate(Sender: TObject);
begin
  inherited;
  SetLength(ArrPedReq, 0);
  qryPedidos            := fCriarQuery(fGetSqlPedidos, Self);
  dtsPedidos            := TDataSource.Create(Self);
  dtsPedidos.DataSet    := qryPedidos;
  dbgPedidos.DataSource := dtsPedidos;

  TFloatField(qryPedidos.FieldByName('PCG_TOTGER')).DisplayFormat := '#,##0.00';
  clrCorZebra := fCfgSis('CORZEB');
  topTipoOperacaoPreNota := opeConferencia;

  stlListSelecao := TStringList.Create;
  stlListSelecao.Clear;
  intCorSelecao          := clAqua;
end;

procedure TfrmEntSelecionaNotaElet.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryPedidos);
  FreeAndNil(dtsPedidos);
  FreeAndNil(stlListSelecao);
end;

procedure TfrmEntSelecionaNotaElet.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_SPACE: Begin
                If cxvConsulta.Focused Then
                  btnSeleciona.Click;
              End;

    VK_F11:  btnGerarCSV.Click();

    VK_F10  : Begin
                btnConfirma.Click;
                Key := 0;
              End;
  End;

end;

function TfrmEntSelecionaNotaElet.fGetSqlPedidos: String;
begin
  Result := '';

  Result := Result + ' SELECT PCG_NUMPED, ';
  Result := Result + '  			PCG_CODEMP, ';
  Result := Result + '  			CONCAT(PCG_CODFOR, " - ", FOR_NOMFOR) AS NOMFOR, ';
  Result := Result + '        PCG_DTAENT, ';
  Result := Result + '        PCG_DTAPED, ';

  Result := Result + '  ( SELECT IF(GROUP_CONCAT( DISTINCT PCD_DOCORI) IS NULL, "N", "S") ';
  Result := Result + '    FROM PCMDET                                                     ';
  Result := Result + '    INNER JOIN MOVGAE ON SUBSTRING(PCD_DOCORI,1,12) = GAE_NUMENV    ';
  Result := Result + '                     AND SUBSTRING(PCD_DOCORI,13,2) = GAE_ESPENV    ';
  Result := Result + '                     AND PCD_CODEMP = GAE_EMPENV                    ';
  Result := Result + '    WHERE PCG_NUMPED = PCD_NUMPED                                   ';
  Result := Result + '      AND PCG_CODEMP = PCD_CODEMP                                   ';
  Result := Result + '      AND PCG_ESPDOC = PCD_ESPDOC ) AS PEDGAR,                      ';

  Result := Result + '        PCG_TOTGER ';

  Result := Result + ' FROM PEDELE ';

  Result := Result + '   INNER JOIN PCMGER ON PCG_NUMPED = PEL_NUMDOC ';
  Result := Result + '                 		AND PCG_CODEMP = PEL_CODEMP ';
  Result := Result + '                		AND PCG_ESPDOC = PEL_ESPDOC ';

  Result := Result + '   INNER JOIN CADFOR ON FOR_CODFOR = PEL_CODFOR ';

  Result := Result + ' WHERE ';
  Result := Result + '   PEL_SEQELE = :SEQELE ';
end;

function TfrmEntSelecionaNotaElet.fInLista: Boolean;
begin
{  If blnQuoteLista Then
    Result := (stlListselecao.IndexOf('''' + fRetChaveLista + '''') > -1) Or
              (stlListselecao.IndexOf(fRetChaveLista) > -1)
  Else}
    Result := stlListselecao.IndexOf(fRetChaveLista) > -1;
end;

procedure TfrmEntSelecionaNotaElet.pCarregaPedidosRequisao(ASeqger: String);
var qrySQL: TUniQuery;
begin
  qrySQL := fCriaQuery;
  Try
    qrySQL.SQL.Add('SELECT DISTINCT FATGOR.FGO_NUMDOC, FATGOR.FGO_ESPDOC, FATGOR.FGO_CODEMP, FATGOR.FGO_CODCLI');
    qrySQL.SQL.Add(' FROM GERELE');
    qrySQL.SQL.Add('INNER JOIN DEFBAI ON  DEF_GERELE = GERELE.AUTOINCREM');
    qrySQL.SQL.Add('INNER JOIN PCMDET ON PCMDET.AUTOINCREM = DEF_AUTPCD');
    qrySQL.SQL.Add('INNER JOIN MOVRCD ON MOVRCD.RCD_SEQPCD = PCMDET.AUTOINCREM');
    qrySQL.SQL.Add('INNER JOIN FATGOR ON FGO_NUMDOC = RCD_DOCPDV AND FGO_CODEMP =  RCD_EMPPDV AND FGO_ESPDOC = RCD_ESPPDV');
    qrySQL.SQL.Add('WHERE GERELE.AUTOINCREM = "' + ASeqger + '";');

    qrySQL.Open;
    If qrySQL.IsEmpty Then
      Exit;
    while not qrySQL.Eof Do
    begin
      SetLength(ArrPedReq, succ(Length(ArrPedReq)));
      ArrPedReq[High(ArrPedReq)].strNumPed := qrySQL.FieldByName('FGO_NUMDOC').AsString;
      ArrPedReq[High(ArrPedReq)].strEspPed := qrySQL.FieldByName('FGO_ESPDOC').AsString;
      ArrPedReq[High(ArrPedReq)].strEmpPed := qrySQL.FieldByName('FGO_CODEMP').AsString;
      ArrPedReq[High(ArrPedReq)].strCodCli := qrySQL.FieldByName('FGO_CODCLI').AsString;
      qrySQL.Next;
    End;

  Finally
    FreeAndNil(qrySQL);

  End;

end;

procedure TfrmEntSelecionaNotaElet.pAtualizaStatusPedidos;
var
  intCont: Integer;
begin
  if Length(ArrPedReq) > 0 then
  begin
    for intCont := Low(ArrPedReq) to High(ArrPedReq) do
    begin
      TUpdateStatus.New(TParamStatus.New()
                        .NumDoc(ArrPedReq[intCont].strNumPed)
                        .EspDoc(ArrPedReq[intCont].strEspPed)
                        .CodEmp(ArrPedReq[intCont].strEmpPed)
                        .CodCli(ArrPedReq[intCont].strCodCli)).pExecute();
    end;
  end;
End;

End.

