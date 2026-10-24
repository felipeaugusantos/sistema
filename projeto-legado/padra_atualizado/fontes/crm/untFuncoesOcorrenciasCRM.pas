unit untFuncoesOcorrenciasCRM;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
     Dialogs, DB, Uni, untAtualizaOcorrenciasCRM, UniClientDataSet,
     UniDataSetProvider, untTypesSistema, StrUtils, untCRM, Vcl.Menus,
     untOcorrenciaCRM, untTypesCRM, untBoleto;

resourcestring
  strCRMOcoFinFat         =  'Ocorrência Referente a Pedido/Orçamento só pode '+
                             'ser finalizada via faturamento/Cancelamento!';
var
  objAtuOcoCrm: TAtuOcoCrm;

function fRetornaSQLHistoricoOcorrencias: String;
procedure pVincularArquivos(strCodOco, strTip_Fc, strCodCli: String; blnSomenteLeitura : Boolean);
function fAlteraSituacaoOcorrencia(frmOwner: TForm; strCodToc, strCodOco, strCodCli, strCodOpe, strCodEmp, strCodCoc: String; strDtaAge: String = ''; strHorAge: String = ''): Boolean;
procedure pGravaHistoricoOcorrencia(DataSet: TDataSet; blnFinalizar: Boolean; strObsFinaliza : String = '');
procedure pAtualizaOcorrencia(strCodOco, strCodEmp, strObsFinaliza, strCodSit: String; dtAge: TDateTime = 0; hrAge: TDateTime = 0);
function fFinalizaReabreOcorrencia(DataSet: TDataSet; blnFinaliza : Boolean = True; strTip_Fc: String = ''): Boolean;
procedure pCancelaADE(DataSet: TDataSet);
procedure pEnviarEmailSemPerguntar(AOwner: TComponent; strEmailCliente, strEmailOperador, strCodCli,
  strNomeCli, strCodGOc, strDesCodGOc, strDtaInc, strHorInc, strTipOco, strDesTipOco, strOpeOco,
  strDesOpeOco, strDescri, strComple, strDesComple, strTip_Fc, strProtocolo: String; Anexos: TStringArray;
  blnAdicionaUmParagrafoPorLinha: Boolean = True; strNumLead: String = ''; strCodOco : String = '');
function fChamaHistoricoOcorrencias(strCodOco, strCodEmp, strCodCli, strNomCli, strCliEma,
  strCodGoc, strNomGoc, strCodToc, strNomToc, strCodCoc, strNomCoc, strTip_Fc,
  strProtoc, strNumDoc, strEspDoc, strCodSit: String; var blnOcoFin: Boolean; strObserv: String = '';
  strDtaAge: String = ''; strHraAge: String = ''): Boolean;
procedure pFluxoDevolucaoDeProdutos(AOwner: TComponent; blnOcoFin: Boolean;
  strCodOco, strCodEmp, strCodCli, strNomCli: String; var strInfDev: String;
  blnInserirOco: Boolean = False);
procedure pChamaFormularioDevolucaoProdutos(blnInserir: Boolean; strCodOco, strCodEmp,
  strCodCli, strNomCli: String; var CdsDev: TUniClientDataSet; var blnConDev: Boolean;
  var strGerCol, strNumDev, strSeqGer: String; blnConsultar: Boolean = False);
procedure pGravaDevolucaoProdutos(blnInserir: Boolean; CdsDev: TUniClientDataSet;
  strCodOco, strCodCli, strGerCol: String; var strNumDev, strInfDev, strInfCol,
  strCodTra: String; strSeqGer: String = '');
procedure pEnviarEmailColeta(AOwner: TComponent; strNumDev, strCodTra, strInfCol: String);
procedure pChamaFormularioSelecaoOpeEmergencial(blnInserir: Boolean; strCodOco, strCodEmp,
  strCodOpe: String; var arrOpeEmer: TStringArray; var blnConEme: Boolean);
procedure pGravaOcorrenciaEmergencial(strCodOco, strCodEmp: String;
  var arrOpeEmer: TStringArray; strNomFrm: String = '');
procedure pFluxoOcorrenciasEmergenciais(blnOcoFin: Boolean; blnDevolu: Boolean; strDescri: String;
  objAtuOcoCrm: TAtuOcoCrm);
procedure pBaixarPedidoReservaFaltaEstoque(qryTabela: TDataSet);
procedure pIncluirNovoHistoricoOcorrencia( strCodOco, strProtoc, strTip_FC,
  strCodCli, strCodEmp, strCodSit: String; dtaDtaLim: TDateTime;
  blnMnuEfetivarOrcamento, blnMnuGerarVendaPerdida: Boolean; out strCodGoc: String;
  strCpfCli: String = ''; strCodCpl: String = ''; blnMnuAlterarDocumento: Boolean = True);
function fEfetivarOrcamentoEmPedido(strNumDoc, strCodCli: String): Boolean;
procedure pAlterarDocumento(strNumDoc, strCodCli: String; popMenu: TPopupMenu; blnProspecto: Boolean = False; strNumLeadP: string = '');
procedure pChamaFaturamentoOrcamento(popMenu: TPopupMenu; strCodCli: String; strNumOrc: String = ''; blnProspecto: Boolean = False; strNumLeadP : String = ''; strCgcCpf: String = '');
procedure pChamaFaturamentoPedido(popMenu: TPopupMenu; strCodCli: String; strNumPed: String = ''; strCgcCpf: String = ''; strNumLeadP: string = '');
procedure pEnviarEmail(AOwner: TComponent; strNumDoc, strCodCli, strNomCli, strEmail_: String);
procedure pGerarPDF(strNumDoc: String; blnPedidoBaixadoTotalmente: Boolean = False);
procedure pGerarPDFVN(strNumDoc: String; strEspDoc: String; strCodEmp: String; strCodCli: String);
procedure pGerarVendaPerdida(strNumDoc: String; strCodOco: String = '');
procedure pRetirarVinculoReq_Transf(strNumDoc: String);
function fDesmembrarPedOrc(strNumDoc: String): Boolean;
function fDesmembrarPedidoAbastecimento(strNumDoc: String): Boolean;
Function fRetornaItensCRM(strNumPed, strEspDoc, strCodEmp: string): TUniQuery;
function fMSG_SenhaImprimirComPrecoCRM(strNumPed, strEspDoc, strCodEmp: string): Boolean;
procedure pChamaFaturamentoVendaNormal(popMenu: TPopupMenu; strCodCli: String; strNumVendNormal: String = ''; strCgcCpf: String = '');
procedure pGravarHistoricoOcorrenciaBaixaSeparacao(strCodCli: String; strCodOpeBaiSep: String;
  strNumDoc: String; strEspDoc: String; strCodEmp: String);

procedure pChamaFaturamento_PD_OR_Em_VendaNormal(popMenu          : TPopupMenu;
                                                 strCodCli        : String;
                                                 strCgcCpf        : String = '';
                                                 strNumDocAbrir   : String = '';
                                                 strEspDocAbrir   : String = '');


  function fRetOcoDoc(const strCodEmp: String; strEspDoc: string; strNumDoc: String; strCodCli: String = ''): IOcorrenciaCRM;
  procedure pEnviaMensagemEmergencial(const blnDevol: Boolean; strObsMensagem: String;
    objOcoCrm : TAtuOcoCrm; arrOpeEmer: TStringArray);
  procedure pGravarMsgOco(strAutIncMsg: String; objOcoCrm : TAtuOcoCrm);
  procedure pAtualizaMsgLida(strAutIncMsg: String; dtaCon, HorCon: TDateTime);
  function fInformacaoDesatualizada(const strAutInc, strNosNum: String): Boolean;
  procedure pImprimeBoleto(Sender: TComponent; const strCodEmp, strEspDoc, strCodcli, strNumDoc, strParcel: String);
  function fAtualizarAssuntoOcorrencia(const strCodOco, strTip_FC, strCodEmp: String): Boolean;
  function fInformarTemperaturaAtendimento(const strCodCor: String = ''): String;
  function fRetornaCorAtendimentoOcorrencia(const strCodOco, strCodEmp: String): String;
  function fPathArquivosOcoCrm: String;

implementation

uses
  untFuncoes,
  untFuncFat,
  untCadRcxx,
  untLiberacao,
  untConsultas,
  untPrincipal,
  untFuncoesCRM,
  untTEnvioEmail,
  untFatGorEmail,
  untObservacaoCRM,
  untCadProdDevCRM,
  untFuncoesDiarias,
  untVendasPerdidas,
  untFuncFatTypes,
  untFuncoesSimples,
  untHistOcorrencias,
  untFuncoesGenerica,
  untGravaArquivoPasta,
  untCadMovOcorrencias,
  Faturamento.Classes.TAlterarPedido,
  untCadOpeOcorrEmergCRM,
  untFatDesmembrarPedido,
  untDigEmailPedOrcEditor,
  untTSituacaoPedidoVenda,
  untDigMotivoVendaPerdida,
  untFatAltQtdeItensPedido,
  untFatRetirarVinculoReq_Transf,
  untFatEfetivarItensOrcamentoEmPedido,
  untMsgLiberacao,
  untFatMenuPrecoQtde,
  untValidacoesSistemaDEPS,
  untGerarEspelhoDevolucaoAD,
  untDigMotivoFinOco,
  untMsgInterna, untTravaCaixa, untConstantes,
  untInputDialog,
  untDigTempAtendimento,
  untFuncoesEditorFast,
  untFatImpressao;

function fRetornaSQLHistoricoOcorrencias: String;
  Const
    strMOVGER = ' (SELECT ' +
                '    G.AUTOINCREM ' +
                '  FROM ' +
                '    MOVGER G' +
                '  WHERE G.GER_NUMDOC = HIS_NUMDOC ' +
                '    AND G.GER_ESPDOC = HIS_ESPDOC ' +
                '    AND G.GER_CODEMP = HIS_EMPFAT ' +
                '    AND G.GER_CODCLI = M.OCO_CODCLI  ' +
                '    AND G.GER_ORIDOC = "V"  ' +
                ' ) ';

    strFATGOR = ' (SELECT ' +
                '    IFNULL(S.STA_DESCRI, "") ' +
                '  FROM ' +
                '    FATGOR F LEFT JOIN EXTGOR E ON E.FGO_SEQFGO = F.AUTOINCREM ' +
                '             LEFT JOIN FGOSTA S ON E.FGO_STATUS = S.STA_CODIGO ' +
                '  WHERE F.FGO_NUMDOC = HIS_NUMDOC ' +
                '    AND F.FGO_ESPDOC = HIS_ESPDOC ' +
                '    AND F.FGO_CODEMP = IFNULL(HIS_EMPFAT, HIS_CODEMP) ' +
                '    AND F.FGO_CODCLI = M.OCO_CODCLI) ';
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT HIS_DTAINC AS DTAINC,                            ';
  strSQL := strSQL + '        HIS_HORINC AS HORINC,                            ';
  strSQL := strSQL + '        CONCAT(HIS_OPEHIS, "-", O.OPE_NOMOPE) AS OPEORI, ';
  strSQL := strSQL + '        CONCAT(HIS_CODOPE, "-", D.OPE_NOMOPE) AS OPEDES, ';
  strSQL := strSQL + '        IF(IFNULL(HIS_NUMDOC,"")<>"",                    ';
  strSQL := strSQL + '           CONCAT(HIS_NUMDOC, "-", HIS_ESPDOC, "-", IFNULL(HIS_EMPFAT,HIS_CODEMP),        ';
  strSQL := strSQL + '                  IF(IFNULL(HIS_PARCEL,"")<>"",CONCAT("-",HIS_PARCEL),"")),"") AS NUMDOC, ';
  strSQL := strSQL + '        CONCAT(HIS_CODTOC,"-", TOC_DESTOC) AS TIPOCO,    ';
  strSQL := strSQL + '        HIS_DESCRI AS DESCRI,                            ';
  strSQL := strSQL + '        SUBSTRING(HIS_DESCRI, 1, LOCATE("<<csq>>", HIS_DESCRI) -1) AS OBSERV, ';
  strSQL := strSQL + '        CONCAT(HIS_CODSIT," - ", SIT_DESSIT) AS CODSIT,  ';
  strSQL := strSQL + '        CONCAT(HIS_CODCOC," - ", COC_DESCOC) AS CODCOC,  ';
  strSQL := strSQL + '        (CASE WHEN '+strMOVGER+' IS NOT NULL THEN "Faturado"        ';
  strSQL := strSQL + '              ELSE '+strFATGOR;
  strSQL := strSQL + '         END) AS STATUS                                             ';
  strSQL := strSQL + ' FROM HISOCO                                             ';
  strSQL := strSQL + '   INNER JOIN MOVOCO M ON M.OCO_CODOCO = HIS_CODOCO AND M.OCO_CODEMP = HIS_CODEMP ';
  strSQL := strSQL + '    LEFT JOIN CADOPE O ON O.OPE_CODOPE = HIS_OPEHIS       ';
  strSQL := strSQL + '    LEFT JOIN CADOPE D ON D.OPE_CODOPE = HIS_CODOPE       ';
  strSQL := strSQL + '    LEFT JOIN CADTOC   ON   TOC_CODTOC = HIS_CODTOC       ';
  strSQL := strSQL + '    LEFT JOIN SITOCO   ON   SIT_CODSIT = HIS_CODSIT  AND SIT_CODTOC = HIS_CODTOC ';
  strSQL := strSQL + '    LEFT JOIN CADCOC   ON   COC_CODCOC = HIS_CODCOC       ';
  strSQL := strSQL + ' WHERE HIS_CODOCO = :CODOCO                               ';
  strSQL := strSQL + '   AND HIS_CODEMP = :CODEMP                               ';
  strSQL := strSQL + '   AND OCO_CODCLI = :CODCLI                               ';

  Result := strSQL;

  Result := Result + ' ORDER BY DTAINC DESC, HORINC DESC, HISOCO.AUTOINCREM DESC ';
end;

procedure pVincularArquivos(strCodOco, strTip_Fc, strCodCli: String; blnSomenteLeitura : Boolean);
begin
  Try
    Try
      pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);
      frmGravaArquivoPasta.strCaminhoPasta :=  fPathArquivosOcoCrm + strCodOco;
      frmGravaArquivoPasta.Caption         := 'Pasta ( Arquivos Anexos )';
      frmGravaArquivoPasta.btnImportar.Enabled := Not blnSomenteLeitura;
      If strTip_Fc = 'C' Then
        frmGravaArquivoPasta.strCodCli := strCodCli;
      frmGravaArquivoPasta.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    pFreeAndNil(frmGravaArquivoPasta);
  End;
end;

function fAlteraSituacaoOcorrencia(frmOwner: TForm; strCodToc, strCodOco, strCodCli, strCodOpe, strCodEmp, strCodCoc: String; strDtaAge: String = ''; strHorAge: String = ''): Boolean;
  Var
    qrySitOco : TUniQuery;
    arrSel    : TConsultasArray;
    chrKey    : Char;
begin
  Result := False;
  qrySitOco := fCriaQuery;
  Try
    chrKey := '/';
    If (fMensagem('','Deseja alterar a situação da ocorrencia ?', ['&Sim', '&Não']) = 1) And
       fPesqSitOcorrencias(frmOwner, nil, nil, qrySitOco, chrKey, arrSel, True, True, strCodToc) Then
    Begin
      objAtuOcoCrm := TAtuOcoCrm.Create(frmOwner);
      objAtuOcoCrm.strCodOco := strCodOco;
      objAtuOcoCrm.strCodCli := strCodCli;
      objAtuOcoCrm.strDtaInc := VS_Date;
      objAtuOcoCrm.strHorInc := fRetHoraServidor();
      If Not(fEmptyDate(strDtaAge)) Then
      Begin
        objAtuOcoCrm.strDtaAge := StrToDateTime(strDtaAge);
        objAtuOcoCrm.strHorAge := StrToTime(strHorAge);
      End
      Else
      Begin
        objAtuOcoCrm.strDtaAge := objAtuOcoCrm.strDtaInc;
        objAtuOcoCrm.strHorAge := objAtuOcoCrm.strHorInc;
      End;

      objAtuOcoCrm.strDtaCon := 0;
      objAtuOcoCrm.strHorCon := 0;
      objAtuOcoCrm.strOpeHis := strLoginUsuarioLogado;
      objAtuOcoCrm.strCodOpe := strCodOpe;
      objAtuOcoCrm.strCodEmp := strCodEmp;
      objAtuOcoCrm.strCodCoc := strCodCoc;
      objAtuOcoCrm.strCodToc := strCodToc;
      objAtuOcoCrm.strCodSit := qrySitOco.FieldByName('SIT_CODSIT').AsString;
      objAtuOcoCrm.strDescri := fGeraTextoHistorico(VS_Date, fNow,
                                                 fRetNomeOperador(strCodOpe),
                                                 'ALTERAÇÃO DA SITUAÇÃO DA OCORRÊNCIA');
      objAtuOcoCrm.pInsereHistoricoOcorrencia;
      objAtuOcoCrm.pAtualizaOcorrencia;

      fMensagem('', 'Situação alterada com sucesso!', ['&OK']);
      Result := True;
    End;
  Finally
    If Assigned(objAtuOcoCrm) Then
      pFreeAndNil(objAtuOcoCrm);
    FreeAndNil(qrySitOco);
  End;
end;

procedure pGravaHistoricoOcorrencia(DataSet: TDataSet; blnFinalizar: Boolean; strObsFinaliza : String = '');
  procedure pGravaHistoricoSemFinalizar;
  begin
    objAtuOcoCrm.strCodOco := DataSet.FieldByName('OCO_CODOCO').AsString;
    objAtuOcoCrm.strDtaInc := DataSet.FieldByName('OCO_DTAINC').AsDateTime;
    objAtuOcoCrm.strHorInc := DataSet.FieldByName('OCO_HORINC').AsDateTime;
    objAtuOcoCrm.strDtaAge := DataSet.FieldByName('OCO_DTAAGE').AsDateTime;
    objAtuOcoCrm.strHorAge := DataSet.FieldByName('OCO_HORAGE').AsDateTime;
    objAtuOcoCrm.strDtaCon := DataSet.FieldByName('OCO_DTACON').AsDateTime;
    objAtuOcoCrm.strHorCon := DataSet.FieldByName('OCO_HORCON').AsDateTime;
    objAtuOcoCrm.strOpeHis := DataSet.FieldByName('OCO_OPEOCO').AsString;
    objAtuOcoCrm.strCodOpe := DataSet.FieldByName('OCO_CODOPE').AsString;
    objAtuOcoCrm.strDescri := DataSet.FieldByName('OCO_DESCRI').AsString;
    objAtuOcoCrm.strCodEmp := DataSet.FieldByName('OCO_CODEMP').AsString;
    objAtuOcoCrm.strCodCoc := DataSet.FieldByName('OCO_CODCOC').AsString;
    objAtuOcoCrm.strCodToc := DataSet.FieldByName('OCO_CODTOC').AsString;
    objAtuOcoCrm.strCodSit := DataSet.FieldByName('OCO_CODSIT').AsString;
    objAtuOcoCrm.strCodLad := DataSet.FieldByName('OCO_SEQLAG').AsString;
    objAtuOcoCrm.pInsereHistoricoOcorrencia;
  end;

  procedure pGravaHistoricoFinalizando;
  begin
    objAtuOcoCrm.strCodOco := DataSet.FieldByName('OCO_CODOCO').AsString;
    objAtuOcoCrm.strDtaInc := VS_Date;
    objAtuOcoCrm.strHorInc := fRetHoraServidor();
    objAtuOcoCrm.strDtaAge := DataSet.FieldByName('OCO_DTAAGE').AsDateTime;
    objAtuOcoCrm.strHorAge := DataSet.FieldByName('OCO_HORAGE').AsDateTime;
    objAtuOcoCrm.strDtaCon := objAtuOcoCrm.strDtaInc;
    objAtuOcoCrm.strHorCon := objAtuOcoCrm.strHorInc;
    objAtuOcoCrm.strOpeHis := strLoginUsuarioLogado;
    objAtuOcoCrm.strCodOpe := strLoginUsuarioLogado;
    objAtuOcoCrm.strDescri := IfThen(Not fEmptyStr(strObsFinaliza), strObsFinaliza + '<<csq>>', '') + 'Finalizando a Ocorrência.'+
                              '<<csq>>Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) +
                              '<<csq>>' + DateToStr(VS_Date) + ' ' + TimeToStr(fTime()) + ' - ' + fRetNomeOperador(strLoginUsuarioLogado);

    objAtuOcoCrm.strCodEmp := DataSet.FieldByName('OCO_CODEMP').AsString;
    objAtuOcoCrm.strCodCoc := DataSet.FieldByName('OCO_CODCOC').AsString;
    objAtuOcoCrm.strCodToc := DataSet.FieldByName('OCO_CODTOC').AsString;
    objAtuOcoCrm.strCodSit := DataSet.FieldByName('OCO_CODSIT').AsString;
    objAtuOcoCrm.strCodLad := DataSet.FieldByName('OCO_SEQLAG').AsString;
    objAtuOcoCrm.pInsereHistoricoOcorrencia;
  end;
begin
  Try
    objAtuOcoCrm := TAtuOcoCrm.Create(nil);
    If blnFinalizar Then
      pGravaHistoricoFinalizando
    Else
      pGravaHistoricoSemFinalizar;
  Finally
    objAtuOcoCrm.Free;
  End;
end;

procedure pAtualizaOcorrencia(strCodOco, strCodEmp, strObsFinaliza, strCodSit: String; dtAge: TDateTime = 0; hrAge: TDateTime = 0);
begin
  Try
    objAtuOcoCrm := TAtuOcoCrm.Create(nil);
    objAtuOcoCrm.strCodOco := strCodOco;
    objAtuOcoCrm.strDtaCon := VS_Date;
    objAtuOcoCrm.strHorCon := fTime();
    objAtuOcoCrm.strOpeHis := strLoginUsuarioLogado;
    objAtuOcoCrm.strCodOpe := strLoginUsuarioLogado;
    objAtuOcoCrm.strDtaAge := dtAge;
    objAtuOcoCrm.strHorAge := hrAge;
    objAtuOcoCrm.strDescri := IfThen(Not fEmptyStr(strObsFinaliza), strObsFinaliza + '<<csq>>', '') + 'Finalizando a Ocorrência.' +
                              '<<csq>><<csq>>Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                              DateToStr(VS_Date) + ' ' + TimeToStr(fTime()) + ' - ' + fRetNomeOperador(strLoginUsuarioLogado);
    objAtuOcoCrm.strCodEmp := strCodEmp;
    objAtuOcoCrm.strCodSit := strCodSit;
    objAtuOcoCrm.pAtualizaOcorrencia;
  Finally
    objAtuOcoCrm.Free;
  End;
end;

function fInformarMotivoFinalizacao: String;
var
  frmDigMotivoFinOco: TfrmDigMotivoFinOco;
begin
  Result := EmptyStr;

  pCriarFormularios(TfrmDigMotivoFinOco, frmDigMotivoFinOco);
  Try
    If (frmDigMotivoFinOco.ShowModal = mrOk) Then
    Begin
      Result := frmDigMotivoFinOco.edtCodMot.Text;
    End;
  Finally
    pFreeAndNil(frmDigMotivoFinOco);
  End;
end;

function fFinalizaReabreOcorrencia(DataSet: TDataSet; blnFinaliza : Boolean = True; strTip_Fc: String = ''): Boolean;
var
  objOcoCrm: IOcorrenciaCRM;
  strCodFinOco: String;
begin

  Case fStrToTTip_Fc(strTip_Fc) Of
    tpCliente   : objOcoCrm := TAtuOcoCrmCliente.Create;
    tpProspecto : objOcoCrm := TAtuOcoCrmProspecto.Create;
    tpFornecedor: objOcoCrm := TAtuOcoCrmFornecedor.Create;
  End;

  objOcoCrm.NomFrm(DataSet.FieldByName('OCO_NOMFRM').AsString);

  pCriarFormularios(TfrmObservacaoCRM, frmObservacaoCRM);
  Try
    If ((DataSet.FieldByName('OCO_CODTOC').AsString = fCfgSis('VENORC', varString)) Or
        (DataSet.FieldByName('OCO_CODTOC').AsString = fCfgSis('VENPED', varString))) Then
    Begin
      fMensagem('', strCRMOcoFinFat, ['&Ok']);
      Exit(False);
    End;

    frmObservacaoCRM.memObs.Lines.Clear;
    frmObservacaoCRM.blnFinaliza := blnFinaliza;
    If frmObservacaoCRM.ShowModal = MrOK Then
    Begin
      If blnFinaliza Then
      Begin
        If (strTip_Fc = 'P') Then
        Begin
          strCodFinOco := fInformarMotivoFinalizacao;

          If fEmptyStr(strCodFinOco) Then
          Begin
            Result := False;
            Exit;
          End;
        End;

        objOcoCrm.CodOco(DataSet.FieldByName('OCO_CODOCO').AsString)
                 .CodEmp(DataSet.FieldByName('OCO_CODEMP').AsString)
                 .CodSit(DataSet.FieldByName('OCO_CODSIT').AsString)
                 .DtaAge(DataSet.FieldByName('OCO_DTAAGE').AsDateTime)
                 .HraAge(DataSet.FieldByName('OCO_HORAGE').AsDateTime)
                 .CodToc(DataSet.FieldByName('OCO_CODTOC').AsString)
                 .CodCoc(DataSet.FieldByName('OCO_CODCOC').AsString)
                 .CodCli(DataSet.FieldByName('OCO_CODCLI').AsString)
                 .Assunt(DataSet.FieldByName('OCO_ASSUNT').AsString)
                 .CodMotFinOco(strCodFinOco)
                 .pFinalizarOcorrencia(frmObservacaoCRM.memObs.Text,
                                       IIF(fCfgSis('OPEFOC', varBoolean), frmObservacaoCRM.edtCodOpe.Text, strLoginUsuarioLogado));

        If fCfgSis('FINOCO', varBoolean) And fOcorrenciaDevolucao(DataSet.FieldByName('OCO_CODTOC').AsString, strTip_Fc) Then
        Begin
          pCancelaADE(DataSet);
        End;

        If fOcorrenciaDesmembramentoCortePedidoFaltaEstoque(DataSet.FieldByName('OCO_CODTOC').AsString, strTip_Fc) Then
          pBaixarPedidoReservaFaltaEstoque(DataSet);

        Result := True;

      End
      Else
      Begin
        objOcoCrm.CodOco(DataSet.FieldByName('OCO_CODOCO').AsString)
                 .CodEmp(DataSet.FieldByName('OCO_CODEMP').AsString)
                 .Descri(IfThen(Not fEmptyStr(frmObservacaoCRM.memObs.Text), frmObservacaoCRM.memObs.Text + '<<csq>>', '') + 'Reabrindo a Ocorrência.<<csq>>' +
                         'Operador Origem : ' +  fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                         DateToStr(VS_Date) + ' ' + TimeToStr(fTime()) + ' - ' + fRetNomeOperador(strLoginUsuarioLogado))
                 .CodCoc(DataSet.FieldByName('OCO_CODCOC').AsString)
                 .CodToc(DataSet.FieldByName('OCO_CODTOC').AsString)
                 .CodOpe(frmObservacaoCRM.edtCodOpe.Text)
                 .Assunt(DataSet.FieldByName('OCO_ASSUNT').AsString)
                 .pReabreOcorrencia;

         Result := True;
      End;
    End
    Else
      Result := False;

  Finally
    pFreeAndNil(frmObservacaoCRM);
  End;
end;

Procedure pCancelaADE(DataSet: TDataSet);
Var
  qryAdeGer,
  qryAdeDet : TUniQuery;
Begin
  Try
    qryAdeGer := fCriaQuery;
    qryAdeDet := fCriaQuery;

    qryAdeGer.SQL.Add(' SELECT * FROM ADEGER WHERE GER_CODOCO = :CODOCO ');
    qryAdeGer.ParamByName('CODOCO').AsString := DataSet.FieldByName('OCO_CODOCO').AsString;
    qryAdeGer.Open;

    If Not qryAdeGer.IsEmpty Then
    Begin
      qryAdeDet.SQL.Add(' SELECT * FROM ADEDET WHERE DET_SEQGER = :SEQGER ');
      qryAdeDet.ParamByName('SEQGER').AsString := qryAdeGer.FieldByName('AUTOINCREM').AsString;
      qryAdeDet.Open;

      If fCfgSis('ESP_AD', varBoolean) Then
      Begin
        While Not qryAdeDet.EOF Do
        Begin
          TGerarEspelhoDevolucaoAD.pApagarEspelhoGeradoPelaAD(qryAdeDet.FieldByName('DET_NUMDOC').AsString,
                                                              qryAdeDet.FieldByName('DET_ESPDOC').AsString,
                                                              qryAdeDet.FieldByName('DET_CODEMP').AsString);
          qryAdeDet.Next;
        End;
      End;

      qryAdeDet.First;
      While Not qryAdeDet.IsEmpty Do
      Begin
        fVerificaIntegridade('untFuncoesOcorrenciasCRM', 'ADEDET', qryAdeDet);
        qryAdeDet.Delete;
      End;
    End;

    While Not qryAdeGer.IsEmpty Do
    Begin
      fVerificaIntegridade('untFuncoesOcorrenciasCRM', 'ADEGER', qryAdeGer);
      qryAdeGer.Delete;
    End;

  Finally
    FreeAndNil(qryAdeGer);
    FreeAndNil(qryAdeDet);
  End;
End;

procedure pEnviarEmailSemPerguntar(AOwner: TComponent; strEmailCliente, strEmailOperador, strCodCli,
  strNomeCli, strCodGOc, strDesCodGOc, strDtaInc, strHorInc, strTipOco, strDesTipOco, strOpeOco,
  strDesOpeOco, strDescri, strComple, strDesComple, strTip_Fc, strProtocolo: String; Anexos: TStringArray;
  blnAdicionaUmParagrafoPorLinha: Boolean = True; strNumLead: String =  ''; strCodOco : String = '');
begin
  TEnvioEmail.EnviarEmail(AOwner,
                          strLoginUsuarioLogado,
                          'Nova ocorrência CRM - Concluída',
                          fRetornaParaMovOcorrencias(strEmailCliente,
                                                     strEmailOperador),
                          [],
                          [],
                          TEnvioEmail.ContruirArrayMensagem(fFormataTextoMovOcorrencias(strCodCli,
                                                         strNomeCli,
                                                         strCodGOc,
                                                         strDesCodGOc,
                                                         strDtaInc,
                                                         strHorInc,
                                                         '',
                                                         '',
                                                         strTipOco,
                                                         strDesTipOco,
                                                         strOpeOco,
                                                         strDesOpeOco,
                                                         strDescri,
                                                         strComple,
                                                            strDesComple,
                                                            strTip_Fc,
                                                            strProtocolo,
                                                            fOcorrenciaDevolucao(strTipOco, strTip_Fc),
                                                            '',
                                                            '',
                                                            '',
                                                            strNumLead)),
                          Anexos,
                          true,False, '','', 0,False,
                          '','','','',0,0,0,'',
                          '',0,False,'',Nil,'',
                          '',False,False,'S','N', '','',
                          blnAdicionaUmParagrafoPorLinha,
                          True, True, Nil, False, False, strCodOco);
end;

function fChamaHistoricoOcorrencias(strCodOco, strCodEmp, strCodCli, strNomCli, strCliEma,
  strCodGoc, strNomGoc, strCodToc, strNomToc, strCodCoc, strNomCoc, strTip_Fc,
  strProtoc, strNumDoc, strEspDoc, strCodSit: String; var blnOcoFin: Boolean; strObserv: String = '';
  strDtaAge: String = ''; strHraAge: String = ''): Boolean;
begin
  pCriarFormularios(TfrmHistOcorrencias,frmHistOcorrencias);
  try
    frmHistOcorrencias.strCodOco := strCodOco;
    frmHistOcorrencias.strCodEmp := strCodEmp;
    frmHistOcorrencias.strCodCli := strCodCli;
    frmHistOcorrencias.strNomCli := strNomCli;
    frmHistOcorrencias.strCliEma := strCliEma;
    frmHistOcorrencias.strCodGoc := strCodGoc;
    frmHistOcorrencias.strNomGoc := strNomGoc;
    frmHistOcorrencias.strCodToc := strCodToc;
    frmHistOcorrencias.strNomToc := strNomToc;
    frmHistOcorrencias.strCodCoc := strCodCoc;
    frmHistOcorrencias.strNomCoc := strNomCoc;
    frmHistOcorrencias.strTip_Fc := strTip_Fc;
    frmHistOcorrencias.strProtoc := strProtoc;
    frmHistOcorrencias.strNumDoc := strNumDoc;
    frmHistOcorrencias.strEspDoc := strEspDoc;
    frmHistOcorrencias.strCodSit := strCodSit;
    frmHistOcorrencias.strObserv := strObserv;
    frmHistOcorrencias.strDtaAge := strDtaAge;
    frmHistOcorrencias.strHraAge := strHraAge;

    frmHistOcorrencias.ShowModal;
    blnOcoFin := (frmHistOcorrencias.FDtaCon > 0) And (frmHistOcorrencias.FHorCon > 0);
    Result := (frmHistOcorrencias.ModalResult = mrOk)
  finally
    FreeAndNil(frmHistOcorrencias);
  end;
end;

procedure pFluxoDevolucaoDeProdutos(AOwner: TComponent; blnOcoFin: Boolean;
  strCodOco, strCodEmp, strCodCli, strNomCli: String; var strInfDev: String;
  blnInserirOco: Boolean = False);
  Var
    strGerCol,
    strNumDev,
    strCodTra,
    strSeqGer,
    strInfCol: String;
    blnConDev: Boolean;
    CdsDev: TUniClientDataSet;
begin
  CdsDev := TUniClientDataSet.Create(Nil);
  Try
    if (Not blnOcoFin) then
    begin
      pChamaFormularioDevolucaoProdutos(False, strCodOco, strCodEmp, strCodCli,
        strNomCli, CdsDev, blnConDev, strGerCol, strNumDev, strSeqGer);
      If blnConDev then
      Begin
        pGravaDevolucaoProdutos(blnInserirOco, CdsDev, strCodOco, strCodCli, strGerCol,
          strNumDev, strInfDev, strInfCol, strCodTra, strSeqGer);
        If (strGerCol = 'S') Then
          pEnviarEmailColeta(AOwner, strNumDev, strCodTra, strInfCol);
      End;
    end;
  Finally
    If Assigned(CdsDev) Then
      FreeAndNil(CdsDev);
  End;
end;

procedure pChamaFormularioDevolucaoProdutos(blnInserir: Boolean; strCodOco, strCodEmp,
  strCodCli, strNomCli: String; var CdsDev: TUniClientDataSet; var blnConDev: Boolean;
  var strGerCol, strNumDev, strSeqGer: String; blnConsultar: Boolean = False);
begin
  pCriarFormularios(TfrmCadProdDevCRM, frmCadProdDevCRM);
  try
    frmCadProdDevCRM.blnInsert := blnInserir;
    frmCadProdDevCRM.strCodEmp := IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp);
    frmCadProdDevCRM.strCodOco := strCodOco;
    frmCadProdDevCRM.strCodCli := strCodCli;
    frmCadProdDevCRM.strNomCli := strNomCli;
    frmCadProdDevCRM.blnConsul := blnConsultar;
    frmCadProdDevCRM.ShowModal;

    If Not Assigned(CdsDev) Then
      CdsDev := TUniClientDataSet.Create(Nil);

    CdsDev.Data := frmCadProdDevCRM.cdsProdutos.Data;
    strGerCol := IIF(frmCadProdDevCRM.chkGerarColeta.checked, 'S', 'N');
    blnConDev := not CdsDev.IsEmpty;

    strNumDev := frmCadProdDevCRM.strCodDev;
    strSeqGer := frmCadProdDevCRM.strSeqGer;
  finally
    FreeAndNil(frmCadProdDevCRM);
  end;
end;

procedure pGravaDevolucaoProdutos(blnInserir: Boolean; CdsDev: TUniClientDataSet;
  strCodOco, strCodCli, strGerCol: String; var strNumDev, strInfDev, strInfCol,
  strCodTra: String; strSeqGer: String = '');

  function fMontaMensagemItensDevolucao: String;
  begin
    Result := '';
    If Assigned(CdsDev) Then
    Begin
      Result := Result + #13#10 + 'Produtos da AD Nº ' + strNumDev + #13#10;

      Result := Result + fReplicatorStr('-', 95) + #13#10;

      Result := Result                   + '|' +
                fPadR('Código', 8)       + '|' +
                fPadR('Descrição', 30)   + '|' +
                fPadC('UN', 5)           + '|' +
                fPadL('Quantidade', 12)  + '|' +
                fPadL('Unitar.', 10)     + '|' +
                fPadL('Valor Total', 12) + '|' +
                fPadC('Garantia', 10)     + '|' + #13#10;

      Result := Result + fReplicatorStr('-', 95) + #13#10;

      CdsDev.First;
      While Not CdsDev.Eof Do
      Begin
        Result := Result + '|' +
                  fPadR(CdsDev.FieldByName('CODITE').AsString, 8)  + '|' +
                  fPadR(CdsDev.FieldByName('DESITE').AsString, 30) + '|' +
                  fPadC(CdsDev.FieldByName('SIGUNI').AsString, 5)  + '|' +
                  fPadL(FloatToStrF(CdsDev.FieldByName('QTDITE').AsFloat, ffFixed, 12, 2), 12) + '|' +
                  fPadL(FloatToStrF(CdsDev.FieldByName('UNITAR').AsFloat, ffFixed, 12, 2), 10) + '|' +

                  fPadL(FloatToStrF(CdsDev.FieldByName('QTDITE').AsFloat *
                                    CdsDev.FieldByName('UNITAR').AsFloat, ffFixed, 12, 2), 12) + '|' +
                  fPadC(CdsDev.FieldByName('GARANT').AsString, 10)                             + '|' + #13#10;
        CdsDev.Next;
      End;

      Result := Result + fReplicatorStr('-', 95) + #13#10;
    End;
  end;

  function fMontaMensagemColeta: String;
    Var
      qryDadosCliente: TUniQuery;
      stlNotasFiscais: TStringList;
      strCnpjCliente : String;
      strFoneCliente : String;

    function fTranportadoraDoDocumento(strDoc, strEsp, strEmp, strCli: String): String;
    begin
      Result := fCampoTabela( 'GER_CODTRA', 'MOVGER',
                             ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_CODCLI', 'GER_TIP_FC', 'GER_ORIDOC'],
                             [strDoc, strEsp, strEmp, strCli, 'C', 'V']);
    end;
  begin
    stlNotasFiscais := TStringList.Create;
    stlNotasFiscais.Sorted := True;
    stlNotasFiscais.Duplicates := dupIgnore;

    qryDadosCliente := fCriaQuery;

    With qryDadosCliente Do
    Begin
      Close;
      SQL.Clear;

      SQL.Add('SELECT SQL_NO_CACHE ');
      SQL.Add('  CLI_CODCLI, ');
      SQL.Add('  CLI_NOMCLI, ');
      SQL.Add('  CONCAT(CID_NOMCID, "/", CID_ESTADO) AS CLI_CIDEST, ');
      SQL.Add('  CLI_C_G_C_, ');
      SQL.Add('  CLI_I_E_S_, ');
      SQL.Add('  CLI_FONE01, ');
      SQL.Add('  CONCAT(CLI_ENDERE, ');
      SQL.Add('         IF(IFNULL(CLI_ENDNUM, "") = "", "", CONCAT(", ", CLI_ENDNUM)), ');
      SQL.Add('         IF(IFNULL(CLI_ENDCOM, "") = "", "", CONCAT(", ", CLI_ENDCOM))) AS CLI_ENDERE ');
      SQL.Add('FROM ');
      SQL.Add('  CADCLI ');
      SQL.Add('  INNER JOIN CADCID ON CLI_CODCID = CID_CODCID ');
      SQL.Add('WHERE ');
      SQL.Add('  CLI_CODCLI = :CODCLI ');

      ParamByName('CODCLI').AsString := strCodCli;

      Open;

      strCodTra := '';

      If (Not IsEmpty) And Assigned(CdsDev) Then
      Begin
        CdsDev.First;
        While Not CdsDev.Eof Do
        Begin
          If Not fEmptyStr(CdsDev.FieldByName('NUMDOC').AsString) Then
          Begin

            If fEmptyStr(strCodTra) Then
            Begin
              stlNotasFiscais.Add(CdsDev.FieldByName('NUMDOC').AsString + '-' +
                                  CdsDev.FieldByName('ESPDOC').AsString);

              strCodTra := fTranportadoraDoDocumento(CdsDev.FieldByName('NUMDOC').AsString,
                                                     CdsDev.FieldByName('ESPDOC').AsString,
                                                     CdsDev.FieldByName('CODEMP').AsString,
                                                     strCodCli);

              //Se encontrar alguma transportadora ele apaga tudo que nao tinha transportadora
              //e lança a nota da transportadora que ele encontrou.
              If Not fEmptyStr(strCodTra) Then
              Begin
                stlNotasFiscais.Clear;
                stlNotasFiscais.Add(CdsDev.FieldByName('NUMDOC').AsString + '-' +
                                    CdsDev.FieldByName('ESPDOC').AsString);
              End;
            End
            Else
            Begin
              If strCodTra = fTranportadoraDoDocumento(CdsDev.FieldByName('NUMDOC').AsString,
                                                       CdsDev.FieldByName('ESPDOC').AsString,
                                                       CdsDev.FieldByName('CODEMP').AsString,
                                                       strCodCli) Then
                stlNotasFiscais.Add(CdsDev.FieldByName('NUMDOC').AsString + '-' +
                                    CdsDev.FieldByName('ESPDOC').AsString);
            End;
          End;
          CdsDev.Next;
        End;
      End;

      strCnpjCliente := fFormataCpfCgc(FieldByName('CLI_C_G_C_').AsString, fSetaPais);
      strFoneCliente := fFormataFone(FieldByName('CLI_FONE01').AsString);

      Result := '';
      Result := Result + #13#10 + fCadEmp('NOMCID') + ', ' + FormatDateTime('dd "de" mmmm "de" YYYY', VS_Date);
      Result := Result + #13#10 + 'A ' + fRetNomTransportadora(strCodTra) + #13#10;

      Result := Result + #13#10 + 'Cliente' + #13#10;
      Result := Result + '----------------------------------------------------------------------------' + #13#10;
      Result := Result + '| Razão Social      | ' + fPadR(FieldByName('CLI_NOMCLI').AsString, 53) + '|' + #13#10;
      Result := Result + '----------------------------------------------------------------------------' + #13#10;
      Result := Result + '| Endereço          | ' + fPadR(FieldByName('CLI_ENDERE').AsString, 53) + '|' + #13#10;
      Result := Result + '----------------------------------------------------------------------------' + #13#10;
      Result := Result + '| Cidade/UF         | ' + fPadR(FieldByName('CLI_CIDEST').AsString, 53) + '|' + #13#10;
      Result := Result + '----------------------------------------------------------------------------' + #13#10;
      Result := Result + '| CNPJ              | ' + fPadR(strCnpjCliente                    , 53) + '|' + #13#10;
      Result := Result + '----------------------------------------------------------------------------' + #13#10;
      Result := Result + '| Inscr. Estadual   | ' + fPadR(FieldByName('CLI_I_E_S_').AsString, 53) + '|' + #13#10;
      Result := Result + '----------------------------------------------------------------------------' + #13#10;
      Result := Result + '| Telefone          | ' + fPadR(strFoneCliente                    , 53) + '|' + #13#10;
      Result := Result + '----------------------------------------------------------------------------' + #13#10;
      Result := Result + '| Quant. de Volume  |                                                      |' + #13#10;
      Result := Result + '----------------------------------------------------------------------------' + #13#10;
      Result := Result + '| Peso Total        |                                                      |' + #13#10;
      Result := Result + '----------------------------------------------------------------------------' + #13#10;
      Result := Result + '| Mercadoria frágil | ( )sim (X)não                                        |' + #13#10;
      Result := Result + '----------------------------------------------------------------------------' + #13#10;
      Result := Result + '|                   |                                                      |' + #13#10;
      Result := Result + '----------------------------------------------------------------------------' + #13#10;
      Result := Result + '| Número da(s) NF   | ' + fPadR(stlNotasFiscais.Commatext, 53)          + '|' + #13#10;
      Result := Result + '----------------------------------------------------------------------------' + #13#10;
      Result := Result + '| Horário de        | 08:00 as 17:00                                       |' + #13#10;
      Result := Result + '| Funcionamento     |                                                      |' + #13#10;
      Result := Result + '----------------------------------------------------------------------------' + #13#10;
      Result := Result + '| Tipo de Embalagem | Caixa de Papelão                                     |' + #13#10;
      Result := Result + '----------------------------------------------------------------------------' + #13#10;

      Result := Result + #13#10 + 'Documentos' + #13#10;
      Result := Result + '----------------------------------------------------------------------------' + #13#10;
      Result := Result + '| AD ' + fPadR(strNumDev,15)+ '| Emissão ' + fPadR(DateToStr(VS_Date), 45)+ '|' + #13#10;
      Result := Result + '----------------------------------------------------------------------------' + #13#10;

      Result := Result + #13#10;
      Result := Result + 'Solicitamos a gentileza de coletar e enviar a ' + fCadEmp('NOMEMP') + ', ' + #13#10;
      Result := Result + 'a mercadoria do referido cliente.' + #13#10;
      Result := Result + 'Dúvidas ou esclarecimentos, entre em contato com o, ' + #13#10;
      Result := Result + 'Departamento de Atendimento ao Cliente (DAC),' + #13#10;
      Result := Result + 'fone: ' + fFormataFone(fCadEmp('FONE01')) + '.' + #13#10;
      Result := Result + 'Atenciosamente.' + #13#10;
    End;

    FreeAndNil(qryDadosCliente);
    FreeAndNil(stlNotasFiscais);
  end;
begin
  Try
    objAtuOcoCrm := TAtuOcoCrm.Create(nil);
    objAtuOcoCrm.cdsCdsDev := CdsDev;
    objAtuOcoCrm.strCodOco := strCodOco;
    objAtuOcoCrm.strCodEmp := VS_strCodEmp;
    objAtuOcoCrm.strGerCol := strGerCol;

    If blnInserir Then
      objAtuOcoCrm.pInsereAutorizacaoDevolucao
    Else
    Begin
      objAtuOcoCrm.strNumDev := strNumDev;
      objAtuOcoCrm.strSeqGer := strSeqGer;
      objAtuOcoCrm.pInsereAutorizacaoDevolucaoProdutos;
    End;

    strNumDev := objAtuOcoCrm.strNumDev;
    strInfDev := fMontaMensagemItensDevolucao;

    If strGerCol = 'S' Then
      strInfCol := fMontaMensagemColeta
    Else
      strInfCol := '';
  Finally
    objAtuOcoCrm.Free;
  End;
end;

procedure pEnviarEmailColeta(AOwner: TComponent; strNumDev, strCodTra, strInfCol: String);
begin
  TEnvioEmail.EnviarEmail(AOwner,
                          strLoginUsuarioLogado,
                          'Coleta de Mercadorias ' + strNumDev,
                          fRetornaParaMovOcorrencias(fCampoTabela('TRA_EMAIL_', 'CADTRA', ['TRA_CODTRA'], [strCodTra]), ''),
                          [],
                          [],
                          TEnvioEmail.ContruirArrayMensagem(strInfCol),
                          []);
end;

procedure pChamaFormularioSelecaoOpeEmergencial(blnInserir: Boolean; strCodOco, strCodEmp,
  strCodOpe: String; var arrOpeEmer: TStringArray; var blnConEme: Boolean);
  Var
    frmCadOpeOcorrEmergCRM: TfrmCadOpeOcorrEmergCRM;

  procedure pPreencheArrayOpeEmergencial(
    ArrayOperadores: TStringArray);
  var
    intCont: Integer;
  begin
    SetLength(arrOpeEmer, Length(ArrayOperadores));
    For intCont := 0 To Length(ArrayOperadores) - 1 Do
      arrOpeEmer[intCont] := ArrayOperadores[intCont];
  end;
begin
  Try
    pCriarFormularios(TfrmCadOpeOcorrEmergCRM, frmCadOpeOcorrEmergCRM);
    frmCadOpeOcorrEmergCRM.blnInsert  := blnInserir;
    frmCadOpeOcorrEmergCRM.strOpeResp := strCodOpe;
    frmCadOpeOcorrEmergCRM.strCodOco  := strCodOco;
    frmCadOpeOcorrEmergCRM.strCodEmp  := strCodEmp;
    frmCadOpeOcorrEmergCRM.ShowModal;

    if Assigned(frmCadOpeOcorrEmergCRM.arrOpe) then
      pPreencheArrayOpeEmergencial(frmCadOpeOcorrEmergCRM.arrOpe);

    blnConEme := Length(arrOpeEmer) > 0;
  Finally
    FreeAndNil(frmCadOpeOcorrEmergCRM);
  End;
end;

procedure pGravaOcorrenciaEmergencial(strCodOco, strCodEmp: String;
  var arrOpeEmer: TStringArray; strNomFrm: String = '');
begin
  objAtuOcoCrm := TAtuOcoCrm.Create(nil);
  Try
    objAtuOcoCrm.strNomFrm := strNomFrm;
    objAtuOcoCrm.blnEmerge := True;
    objAtuOcoCrm.pInserirOcorrenciaEmergencial(arrOpeEmer, strCodOco, strCodEmp);
  Finally
    objAtuOcoCrm.Free;
  End;
end;

procedure pFluxoOcorrenciasEmergenciais(blnOcoFin: Boolean; blnDevolu: Boolean; strDescri: String;
  objAtuOcoCrm: TAtuOcoCrm);
Var
  blnConEme: Boolean;
  arrOpeEmer: TStringArray;
begin
  If (blnOcoFin) Then
    Exit;

  pChamaFormularioSelecaoOpeEmergencial(False, objAtuOcoCrm.strCodOco, objAtuOcoCrm.strCodEmp, objAtuOcoCrm.strCodOpe,
    arrOpeEmer, blnConEme);

  If blnConEme Then
    pGravaOcorrenciaEmergencial(objAtuOcoCrm.strCodOco, objAtuOcoCrm.strCodEmp, arrOpeEmer);

  If fCfgSis('OCOMSG', varBoolean) Then
    pEnviaMensagemEmergencial(blnDevolu, strDescri, objAtuOcoCrm, arrOpeEmer);
end;

procedure pEnviaMensagemEmergencial(const blnDevol: Boolean; strObsMensagem: String;
  objOcoCrm : TAtuOcoCrm; arrOpeEmer: TStringArray);
var
  strMensagem: String;
  strAssunto: String;
  strAutIncMsg: String;
  objMsgInterna: TMsgInterna;
  intCount: Integer;
Begin
  If Not Assigned(objOcoCrm) Then
    Exit;

  strAssunto := objOcoCrm.strCodCli + ' - ' + objOcoCrm.strNomCli + ' ' + 'Protocolo: ' + objOcoCrm.strProtocolo;

  strMensagem := '- Ocorrência Emergencial -  ' + #13#10 + #13#10 +
                 'Grupo Ocorrência: ' + objOcoCrm.strCodGoc + ' - ' + objOcoCrm.strDesGoc + #13#10 +
                 'Tipo Ocorrência: '  + objOcoCrm.strCodToc + ' - ' + objOcoCrm.strDesToc;

  If blnDevol Then
    strMensagem := strMensagem + #13#10 + 'Número da Autorização de Devolução(AD): ' + objOcoCrm.strNumDev;

  strMensagem := strMensagem  + #13#10 +  #13#10 +
                 'Mensagem: ' + #13#10 + strObsMensagem+ #13#10;


  objMsgInterna := TMsgInterna.Create(Nil);
  Try
    For intCount := Low(arrOpeEmer) to High(arrOpeEmer) do
    Begin
      objMsgInterna.fEnviaMensagemAutInc(strAssunto, strMensagem, strLoginUsuarioLogado, LeftStr(arrOpeEmer[intCount],3), 'N', '', strAutIncMsg);
    End;

    If Not fEmptyStr(strAutIncMsg) Then
      pGravarMsgOco(strAutIncMsg, objOcoCrm);

  Finally
    FreeAndNil(objMsgInterna);
  End;
end;

procedure pGravarMsgOco(strAutIncMsg: String; objOcoCrm : TAtuOcoCrm);
var
  qryMsgOco : TUniQuery;
begin
  qryMsgOco := fCriaQuery;
  Try
    qryMsgOco.Close;
    qryMsgOco.SQL.Clear;
    qryMsgOco.SQL.Add(' SELECT DISTINCT                                ');
    qryMsgOco.SQL.Add('        GROUP_CONCAT(MSG_OPEREC SEPARATOR ", ") AS OPERAD, ');
    qryMsgOco.SQL.Add('        MSG_MENSAG                              ');
    qryMsgOco.SQL.Add(' FROM CADMSG                                    ');
    qryMsgOco.SQL.Add(' WHERE AUTOINCREM IN ( ' + strAutIncMsg + ')    ');
    qryMsgOco.Open;

    If Not qryMsgOco.IsEmpty Then
    Begin
      objOcoCrm.afcAcaFat := afcNenhum;
      objOcoCrm.strDescri := 'Mensagem Enviada<<csq>>' +
                             qryMsgOco.FieldByName('MSG_MENSAG').AsString + '<<csq>>' +
                             'Destinatário(s): ' + qryMsgOco.FieldByName('OPERAD').AsString +
                             '<<csq>><<csq>>Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                              DateToStr(VS_Date) + ' ' + TimeToStr(fNow) + ' - ' + objOcoCrm.strCodOpe + ' - ' + fRetNomeOperador(objOcoCrm.strCodOpe);

      objOcoCrm.strOperadoresDestino := qryMsgOco.FieldByName('OPERAD').AsString;
      objOcoCrm.BlnMsgMultiplosDestinatarios := True;

      objOcoCrm.pInsereHistoricoOcorrencia;
      objOcoCrm.pAtualizaOcorrencia;
      qryMsgOco.Close;
      qryMsgOco.SQL.Clear;
      qryMsgOco.SQL.Add(' INSERT INTO MSGOCO ( MSO_SEQMSG,            ');
      qryMsgOco.SQL.Add('                      MSO_CODOCO,            ');
      qryMsgOco.SQL.Add('                      MSO_CODEMP,            ');
      qryMsgOco.SQL.Add('                      MSO_CODTOC,            ');
      qryMsgOco.SQL.Add('                      MSO_CODCLI)            ');
      qryMsgOco.SQL.Add(' SELECT AUTOINCREM,                          ');
      qryMsgOco.SQL.Add('        :CODOCO,                             ');
      qryMsgOco.SQL.Add('        :CODEMP,                             ');
      qryMsgOco.SQL.Add('        :CODTOC,                             ');
      qryMsgOco.SQL.Add('        :CODCLI                              ');
      qryMsgOco.SQL.Add(' FROM CADMSG                                 ');
      qryMsgOco.SQL.Add(' WHERE AUTOINCREM IN ( ' + strAutIncMsg + ') ');

      qryMsgOco.ParamByName('CODOCO').AsString := objOcoCrm.strCodOco;
      qryMsgOco.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryMsgOco.ParamByName('CODTOC').AsString := objOcoCrm.strCodToc;
      qryMsgOco.ParamByName('CODCLI').AsString := objOcoCrm.strCodCli;

      qryMsgOco.ExecSQL;
    End;

  Finally
    FreeAndNil(qryMsgOco);
  End;

end;

procedure pAtualizaMsgLida(strAutIncMsg: String; dtaCon, HorCon: TDateTime);
var
  qryGen : TUniQuery;
  strSQL : string;
begin
  If fEmptyStr(strAutIncMsg) Then
    Exit;

  qryGen := fCriaQuery;
  Try
    If (dtaCon > 0) And (HorCon > 0) then
    Begin
      strSQL := '';
      strSQL := strSQL + ' UPDATE CADMSG      ';
      strSQL := strSQL + ' SET                ';
      strSQL := strSQL + '   MSG_LIDA__ = "S" ';
      strSQL := strSQL + ' WHERE              ';
      strSQL := strSQL + '   AUTOINCREM IN (' +  strAutIncMsg + ')';

      qryGen.SQL.Clear;
      qryGen.SQL.add(strSQL);
      qryGen.ExecSQL;
    End;
  Finally
    FreeAndNil(qryGen);
  End;

end;

procedure pBaixarPedidoReservaFaltaEstoque(qryTabela: TDataSet);
  Var
    qryUpdate: TUniQuery;

    function fMotivoBaixa: String;
    Begin
      Result := '';
      Result := Result + 'Baixa da ocorrência ' + qryTabela.FieldByName('OCO_CODOCO').AsString +
        ', pelo operador ' + strLoginUsuarioLogado + ', em ' +
        FormatDateTime('DD/MM/YYYY', VS_Date) + ' ' +
        FormatDateTime('HH:MM:SS', fTime());
    End;

begin
  qryUpdate := fCriaQuery(Nil);

  qryUpdate.SQL.Add('UPDATE                     ');
  qryUpdate.SQL.Add('  FATGOR                   ');
  qryUpdate.SQL.Add('SET                        ');
  qryUpdate.SQL.Add('  FGO_JAFATU = 1,          ');
  qryUpdate.SQL.Add('  FGO_MOTBAI = :MOTBAI     ');
  qryUpdate.SQL.Add('WHERE                      ');
  qryUpdate.SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
  qryUpdate.SQL.Add('  FGO_ESPDOC = :ESPDOC AND ');
  qryUpdate.SQL.Add('  FGO_CODEMP = :CODEMP     ');
  qryUpdate.ParamByName('MOTBAI').AsString := fMotivoBaixa;
  qryUpdate.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('OCO_NUMDOC').AsString;
  qryUpdate.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('OCO_ESPDOC').AsString;
  qryUpdate.ParamByName('CODEMP').AsString := qryTabela.FieldByName('OCO_CODEMP').AsString;
  qryUpdate.ExecSQL;

  qryUpdate.SQL.Clear;
  qryUpdate.SQL.Add('UPDATE                     ');
  qryUpdate.SQL.Add('  FATDOR                   ');
  qryUpdate.SQL.Add('SET                        ');
  qryUpdate.SQL.Add('  FDO_JAFATU = 1           ');
  qryUpdate.SQL.Add('WHERE                      ');
  qryUpdate.SQL.Add('  FDO_NUMDOC = :NUMDOC AND ');
  qryUpdate.SQL.Add('  FDO_ESPDOC = :ESPDOC AND ');
  qryUpdate.SQL.Add('  FDO_CODEMP = :CODEMP     ');
  qryUpdate.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('OCO_NUMDOC').AsString;
  qryUpdate.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('OCO_ESPDOC').AsString;
  qryUpdate.ParamByName('CODEMP').AsString := qryTabela.FieldByName('OCO_CODEMP').AsString;
  qryUpdate.ExecSQL;

  FreeAndNil(qryUpdate);
end;

procedure pIncluirNovoHistoricoOcorrencia( strCodOco, strProtoc, strTip_FC,
  strCodCli, strCodEmp, strCodSit: String; dtaDtaLim: TDateTime;
  blnMnuEfetivarOrcamento, blnMnuGerarVendaPerdida: Boolean; out strCodGoc: String;
  strCpfCli: String = ''; strCodCpl: String = ''; blnMnuAlterarDocumento: Boolean = True);
var
  frmCadMovOcorrencias: TfrmCadMovOcorrencias;
begin
  try
    pCriarFormularios(TfrmCadMovOcorrencias, frmCadMovOcorrencias);

    frmCadMovOcorrencias.Caption   := 'Ocorrência - Protocolo ' + strProtoc;
    frmCadMovOcorrencias.lblTxtLim.Visible := True;
    frmCadMovOcorrencias.lblHraLim.Visible := True;
    frmCadMovOcorrencias.lblHraLim.Caption := FormatDateTime('dd/mm/yyyyy hh:nn:ss', dtaDtaLim);
    frmCadMovOcorrencias.strTip_FC := strTip_FC;
    frmCadMovOcorrencias.strCodOco := strCodOco;
    frmCadMovOcorrencias.strCodCli := strCodCli;
    frmCadMovOcorrencias.strCodEmp := strCodEmp;
    frmCadMovOcorrencias.strCodSit := strCodSit;
    frmCadMovOcorrencias.strCodCpl := strCodCpl;
    frmCadMovOcorrencias.strOperac := 'Alterar';
    frmCadMovOcorrencias.mnuEfetivarOrcamento.Visible := blnMnuEfetivarOrcamento;
    frmCadMovOcorrencias.mnuGerarVendaPerdida.Visible := blnMnuGerarVendaPerdida;
    frmCadMovOcorrencias.mnuAlterarDocumento.Visible := blnMnuAlterarDocumento;
    frmCadMovOcorrencias.strCpfCli := strCpfCli;

    frmCadMovOcorrencias.ShowModal;
    strCodGoc := frmCadMovOcorrencias.strCodGoc;
  finally
    FreeAndNil(frmCadMovOcorrencias);
  end;
end;

function fEfetivarOrcamentoEmPedido(strNumDoc, strCodCli: String): Boolean;

  function fTemItemEspecialOrcamento: Boolean;
  begin
    Result := fCampoTabela('SUM(LOCATE("ITEM ESPECIAL", ITE_DESITE))',
      'FATDOR INNER JOIN CADITE ON ITE_CODITE = FDO_CODITE',
      ['FDO_NUMDOC','FDO_ESPDOC','FDO_CODEMP'],
      [LeftStr(strNumDoc, 12), 'OR', RightStr(strNumDoc, 3)]) > 0;
  end;

  function fRetConPag(ANumDoc : String) : String;
    const
      SQL = 'SELECT FGO_CONPAG FROM FATGOR WHERE FGO_NUMDOC = :NUMDOC AND FGO_ESPDOC = :ESPDOC AND FGO_CODEMP = :CODEMP';
    var
      LNumDoc : String;
      LEspDoc : String;
      LEmpDoc : String;
      LConPag : TUniQuery;
  begin

    Result := '';

    LNumDoc := LeftStr(ANumDoc, 12);
    LEspDoc := Copy(ANumDoc, 14, 2);
    LEmpDoc := RightStr(ANumDoc, 3);

    If LNumDoc.IsEmpty Then
      Exit;

    If LEspDoc.IsEmpty Then
      Exit;

    If LEmpDoc.IsEmpty Then
      Exit;

    LConPag := fCriaQuery;

    Try

      LConPag.Close;
      LConPag.SQL.Clear;
      LConPag.SQL.Add(SQL);
      LConPag.ParamByName('NUMDOC').AsString := LNumDoc;
      LConPag.ParamByName('ESPDOC').AsString := LEspDoc;
      LConPag.ParamByName('CODEMP').AsString := LEmpDoc;
      LConPag.Open;

      If Not LConPag.IsEmpty Then
        Result := LConPag.FieldByName('FGO_CONPAG').AsString;

    Finally
      FreeAndNil(LConPag);
    End;

  end;

  function fTravaCaixa : Boolean;
    var
      objTravaCaixa : TTravaCaixa;
      strConPag     : String;
  begin

    Result := False;

    objTravaCaixa := TTravaCaixa.New('PD');

    Try

      If (objTravaCaixa.blnTravar) Then
        Exit(True);

      If (objTravaCaixa.fCaixaDoDiaFechadoOuCaixaDoDiaAnteriorAindaNaoFechado) Then
      Begin

        strConPag := fRetConPag(strNumDoc);

        If (fStatusCndPag(strConPag) = A_VISTA) Then
          If Not objTravaCaixa.blnApenasEmissaoDePD_OR_AVista Then
          Begin
            fMensagem('ATENÇÃO!', MSG_SOMENTE_A_PRAZO, ['&Ok']);
            Exit(True);
          End;

        If (fStatusCndPag(strConPag) = A_PRAZO) Then
          If Not objTravaCaixa.blnApenasEmissaoDeDocumentosAPrazo Then
          Begin
            fMensagem('ATENÇÃO!', MSG_SOMENTE_A_VISTA, ['&Ok']);
            Exit(True);
          End;

      End;

    Finally
      FreeAndNil(objTravaCaixa);
    End;

  end;

begin
  Result := False;

  If fTravaCaixa Then
    Exit;

  If Not fVerificaAcessoSistema('CRM_PD', strLoginUsuarioLogado) Then
  Begin
    fMensagem('Informação !','Usuário não tem direito de acesso para fazer um pedido !',['&Ok']);
    Exit;
  End;

  If (Not fPermiteItemEspecial('PD')) And fTemItemEspecialOrcamento Then
  Begin
    fMensagem('', 'Não é permitido item especial em pedidos de venda!', ['&Ok']);
    Exit;
  End;

  If (fRetornaStatusCliente(strCodCli) <> 'A') And (fCfgSis('PTRASC', varBoolean)) Then
  Begin
    fMensagem('', 'O cliente deste documento não está ativo!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmFatEfetivarItensOrcamentoEmPedido, frmFatEfetivarItensOrcamentoEmPedido);

    frmFatEfetivarItensOrcamentoEmPedido.strNumOrc := LeftStr(strNumDoc, 12);
    frmFatEfetivarItensOrcamentoEmPedido.strEmpOrc := RightStr(strNumDoc, 3);
    frmFatEfetivarItensOrcamentoEmPedido.blnOrigemCrm := True;
    frmFatEfetivarItensOrcamentoEmPedido.ShowModal;
    Result := frmFatEfetivarItensOrcamentoEmPedido.blnGravouPedido;
  Finally
    pFreeAndNil(frmFatEfetivarItensOrcamentoEmPedido);
  End;
end;

procedure pAlterarDocumento(strNumDoc, strCodCli: String; popMenu: TPopupMenu;
  blnProspecto: Boolean = False; strNumLeadP: string = '');
begin
  If (Pos('PD', strNumDoc) > 0) Then
    pChamaFaturamentoPedido(popMenu, strCodCli, LeftStr(strNumDoc, 12), '', strNumLeadP)
  Else If (Pos('OR', strNumDoc) > 0) Then
    pChamaFaturamentoOrcamento(popMenu, strCodCli, LeftStr(strNumDoc, 12), blnProspecto, strNumLeadP);
end;

procedure pChamaFaturamentoOrcamento(popMenu: TPopupMenu; strCodCli: String; strNumOrc: String = ''; blnProspecto: Boolean = False; strNumLeadP : String = ''; strCgcCpf: String = '');
begin
  If fVerificaAcessoSistema('CRM_OR', strLoginUsuarioLogado) Then
  Begin
    If blnProspecto Then
      popMenu.Items[0].Hint := 'CRM' + fCfgSis('CONCRM', varString) + 'frmFatVendas - PROSPECTO - ' +
                                    strCodCli + 'OR'
    Else
      popMenu.Items[0].Hint := 'CRM' + strCodCli + 'frmFatVendas - '+
                                    IIF(Not fEmptyStr(strCgcCpf), 'CGC' + strCgcCpf, '') + 'OR';

    frmPrincipal.strNumOrcPedAbrir := '';
    frmPrincipal.strEspOrcPedAbrir := '';
    frmPrincipal.strCodCliGravado  := '';
    frmPrincipal.blnEstouNoCrm     := True;
    frmPrincipal.strNLeads         := strNumLeadP;

    If Not fEmptyStr(strNumOrc) Then
    Begin
      frmPrincipal.strEspOrcPedAbrir := 'OR';
      frmPrincipal.strNumOrcPedAbrir := strNumOrc;
    End;

    frmPrincipal.mnuFatTrocaMercClick(popMenu.Items[0]);
    frmPrincipal.strNLeads:= '';
  End
  Else
    fMensagem('Informação !','Usuário não tem direito de acesso para fazer um orçamento !',['&Ok'])
end;

procedure pChamaFaturamentoPedido(popMenu: TPopupMenu; strCodCli: String; strNumPed: String = ''; strCgcCpf: String = ''; strNumLeadP: string = '');
begin
  If fVerificaAcessoSistema('CRM_PD', strLoginUsuarioLogado) Then
  Begin
    popMenu.Items[0].Hint := 'CRM' + strCodCli + 'frmFatVendas - '+
                             IIF(Not fEmptyStr(strCgcCpf), 'CGC' + strCgcCpf, '') + 'PD';

    frmPrincipal.strNumOrcPedAbrir := '';
    frmPrincipal.strEspOrcPedAbrir := '';
    frmPrincipal.strCodCliGravado  := '';
    frmPrincipal.blnEstouNoCrm     := True;
    frmPrincipal.strNLeads         := strNumLeadP;

    If Not fEmptyStr(strNumPed) Then
    Begin
      frmPrincipal.strEspOrcPedAbrir := 'PD';
      frmPrincipal.strNumOrcPedAbrir := strNumPed;
    End;

    frmPrincipal.mnuFatTrocaMercClick(popMenu.Items[0]);
    frmPrincipal.strNLeads:= '';
  End
  Else
    fMensagem('Informação !','Usuário não tem direito de acesso para fazer um pedido !',['&Ok'])
end;

procedure pChamaFaturamentoVendaNormal(popMenu: TPopupMenu; strCodCli: String; strNumVendNormal: String = ''; strCgcCpf: String = '');
begin

  If fVerificaAcessoSistema('CRM_VN', strLoginUsuarioLogado) Then
  Begin
    popMenu.Items[0].Hint := 'CRM' + strCodCli + 'frmFatVendas - '+
                             IIF(Not fEmptyStr(strCgcCpf), 'CGC' + strCgcCpf, '') + 'VN';

    frmPrincipal.strNumOrcPedAbrir := '';
    frmPrincipal.strEspOrcPedAbrir := '';
    frmPrincipal.strCodCliGravado  := '';
    frmPrincipal.blnEstouNoCrm     := True;

    If Not fEmptyStr(strNumVendNormal) Then
    Begin
      frmPrincipal.strEspOrcPedAbrir := 'VN';
      frmPrincipal.strNumOrcPedAbrir := strNumVendNormal;
    End;

    frmPrincipal.mnuFatTrocaMercClick(popMenu.Items[0]);
  End
  Else
    fMensagem('Informação !','Usuário não tem direito de acesso para fazer um pedido !',['&Ok'])

end;

procedure pGravarHistoricoOcorrenciaBaixaSeparacao(strCodCli: String; strCodOpeBaiSep: String; strNumDoc: String; strEspDoc: String; strCodEmp: String);
  Var
    objOcoCrm : TAtuOcoCrm;
    qryGen : TUniQuery;
begin
  If fEmptyStr(tciBaixaSeparacao.fGetSituacao()) Then
    Exit;

  objOcoCrm := TAtuOcoCrm.Create(Nil);
  Try
    qryGen := fCriaQuery;
    Try
      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(' SELECT OCO_CODOCO,         ');
      qryGen.SQL.Add('        OCO_CODEMP,         ');
      qryGen.SQL.Add('        OCO_AGECOM,         ');
      qryGen.SQL.Add('        OCO_CODTOC,         ');
      qryGen.SQL.Add('        OCO_CODCOC          ');
      qryGen.SQL.Add(' FROM MOVOCO                ');
      qryGen.SQL.Add(' WHERE OCO_NUMDOC = :NUMDOC ');
      qryGen.SQL.Add('   AND OCO_ESPDOC = :ESPDOC ');
      qryGen.SQL.Add('   AND OCO_CODEMP = :CODEMP ');
      qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
      qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;
      qryGen.Open;

      objOcoCrm.strNomFrm := '[untFuncoesOcorrenciasCRM.pGravarHistoricoOcorrenciaBaixaSeparacao]';
      objOcoCrm.strCodCli := strCodCli;
      objOcoCrm.strNumDoc := strNumDoc;
      objOcoCrm.strEspDoc := strEspDoc;
      objOcoCrm.strCodEmp := strCodEmp;
      objOcoCrm.strCodOco := qryGen.FieldByName('OCO_CODOCO').AsString;
      objOcoCrm.strCodCoc := qryGen.FieldByName('OCO_CODCOC').AsString;
      objOcoCrm.strCodToc := qryGen.FieldByName('OCO_CODTOC').AsString;
      objOcoCrm.strCodOpe := strLoginUsuarioLogado;
      objOcoCrm.strDtaInc := fRetDataServidor();
      objOcoCrm.strHorInc := fRetHoraServidor();
      objOcoCrm.strDtaAge := objOcoCrm.strDtaInc;
      objOcoCrm.strHorAge := objOcoCrm.strHorInc;
      objOcoCrm.strOpeHis := strLoginUsuarioLogado;
      objOcoCrm.strCodSit := tciBaixaSeparacao.fGetSituacao();
      objOcoCrm.strDescri := 'BAIXA DA SEPARAÇÃO ' + '<<csq>>' +
                             'Operador da Baixa: ' + strCodOpeBaiSep + ' - ' + fRetNomeOperador(strCodOpeBaiSep) + '<<csq>>' +
                             DateToStr(fNow) + ' ' + TimeToStr(fNow) + ' - ' + strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado);
      objOcoCrm.pInsereHistoricoOcorrencia;
      objOcoCrm.pAtualizaOcorrencia;
    Finally
      FreeAndNil(qryGen);
    End;
  Finally
    FreeAndNil(objOcoCrm);
  End;
end;

procedure pChamaFaturamento_PD_OR_Em_VendaNormal(popMenu          : TPopupMenu;
                                                 strCodCli        : String;
                                                 strCgcCpf        : String = '';
                                                 strNumDocAbrir   : String = '';
                                                 strEspDocAbrir   : String = '');
begin

  If fVerificaAcessoSistema('CRM_VN', strLoginUsuarioLogado) Then
  Begin

    popMenu.Items[0].Hint := 'CRM' + strCodCli + 'frmFatVendas - '+
                             IIF(Not fEmptyStr(strCgcCpf), 'CGC' + strCgcCpf, '') + 'VN';

    frmPrincipal.strNumOrcPedAbrir := strNumDocAbrir;
    frmPrincipal.strEspOrcPedAbrir := strEspDocAbrir;
    frmPrincipal.strCodCliGravado  := '';
    frmPrincipal.blnEstouNoCrm     := True;

    frmPrincipal.mnuFatTrocaMercClick(popMenu.Items[0]);

  End
  Else
    fMensagem('Informação !','Usuário não tem direito de acesso para fazer um pedido !',['&Ok'])

end;

procedure pEnviarEmail(AOwner: TComponent; strNumDoc, strCodCli, strNomCli, strEmail_: String);
  Var
    blnConfirma         : Boolean;
    strNumPed           : String;
    strEspDoc           : String;
    strCodEmp           : String;
    strArqHtml          : String;
    strTexto            : String;
    strAssunto          : String;
    strEmailDestinatario: String;
    strOrdem : String;
    strTipExp: String;
    opcComSemPreco: TImpressaoComSemPrecoOrPd;
    blnComMar: Boolean;
    blnLocFis: Boolean;
    strModo  : String;
    strNomEmp: String;
    blnCabCD : Boolean;
    blnAnexar: Boolean;
    qryFatDor: TUniQuery;
    arrArquivos, arrDestinatarios : TStringArray;
begin
  strEspDoc := '';

  If (Pos('OR', strNumDoc) > 0) Then
    strEspDoc := 'OR'

  Else If (Pos('PD', strNumDoc) > 0) Then
    strEspDoc := 'PD';

  If fEmptyStr(strEspDoc) Then
    Exit;

  strNumPed := LeftStr(strNumDoc, 12);
  strCodEmp := RightStr(strNumDoc, 3);
  blnAnexar := False;

  // VERIFICA PERMISSÃO PARA ENVIAR POR EMAIL
  If Not fVerificaAcessoSistema('PEMAIL', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  TFatVenda.pAtualizacaoCotacaoDolar(strNumPed, strEspDoc, strCodEmp);

  strOrdem  := '1';
  strNomEmp := 'R';
  opcComSemPreco := impComPrecoGeral;
  blnComMar := True;
  blnLocFis := False;
  strModo   := 'R';
  blnCabCD  := False;

  strAssunto := '';
  strEmailDestinatario := strEmail_;

  If Not fLayoutAtivoPdfPedidoOrcamento(strNumPed, strEspDoc, strCodEmp) Then
  Begin
    fMensagem('ATENÇÃO', 'Não há Layout Disponível para gerar PDF!', ['&O k']);
    Exit;
  End
  Else
  Begin

    Try
      pCriarFormularios(TfrmDigEmailPedOrcEditor, frmDigEmailPedOrcEditor);

      frmDigEmailPedOrcEditor.strNumDoc := strNumPed;
      frmDigEmailPedOrcEditor.strCodEmp := strCodEmp;
      frmDigEmailPedOrcEditor.strEspDoc := strEspDoc;
      frmDigEmailPedOrcEditor.strCodCli := strCodCli;

      blnConfirma := (frmDigEmailPedOrcEditor.ShowModal = mrOk);

      If (blnConfirma) Then
      Begin
        strEmailDestinatario := frmDigEmailPedOrcEditor.strEmails;
        blnAnexar            := frmDigEMailPedOrcEditor.chkAnexar.Checked;
        strTipExp            := frmDigEmailPedOrcEditor.strTipExp;
        opcComSemPreco       := frmDigEmailPedOrcEditor.opcComSemPreco;
        blnComMar            := frmDigEmailPedOrcEditor.chkMarca.Checked;
        strOrdem             := frmDigEmailPedOrcEditor.edtOrdem.Text;
        strNomEmp            := IIF(frmDigEmailPedOrcEditor.rdgNomEmp.ItemIndex = 0, 'R', 'F');
        blnCabCD             := (frmDigEmailPedOrcEditor.edtEmpCab.Text = '2');
        blnLocFis            := false;
      End;
    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro(E.Message, '[]');
      End;
    End;
    pFreeAndNil(frmDigEmailPedOrcEditor);
  End;

  If (Not blnConfirma) Then
    Exit;

  {*******************************************}
  {* RETORNA A VARIAVEL strNomeArquivo       *}
  {****************************************AC*}
  Try
    pCriarFormularios(TfrmFatGorEmail, frmFatGorEmail);
    strArqHtml := frmFatGorEmail.fGeraEmail(strNumPed,
                                            strEspDoc,
                                            opcComSemPreco,
                                            blnComMar,
                                            strTipExp,
                                            strModo,
                                            strOrdem,
                                            strCodEmp,
                                            blnLocFis,
                                            strNomEmp,
                                            strCodCli,
                                            blnCabCD);
  Finally
    pDestroiModulo(frmFatGorEmail);
  End;

  If (Not fEmptyStr(strArqHtml)) Then
  Begin

    {************************************************}
    {* AQUI É GERADO O EMAIL E EXPORTADO EM PDF     *}
    {*********************************************AC*}
    If (strEspDoc = 'PD') Then
    Begin
      strAssunto := 'Pedido Nº: ';
      strTexto := 'Segue em anexo Pedido.';
    End
    Else
    Begin
      strAssunto := 'Orçamento Nº: ';
      strTexto := 'Segue em anexo Orçamento.';
    End;

    If strTipExp = 'P' Then
    Begin
      strTexto := strTexto + #13#10 + #13#10;
      strTexto := strTexto + 'Caso não possua o programa Acrobat Reader para visualizar o arquivo anexo, ';
      strTexto := strTexto + 'acesse o link e faça o download: <a href="https://www.adobe.com">www.adobe.com</a>';
    End;

    strAssunto := fRetNomeEmpresa + ' - ' + strAssunto + strNumPed;

    If not blnAnexar Then Begin
      pCriarArrayAnexosEDestinatarios(strArqHtml, strEmailDestinatario, arrDestinatarios, arrArquivos);

      TEnvioEmail.EnviarEmail(AOwner, strLoginUsuarioLogado, strAssunto, arrDestinatarios, [], [], TEnvioEmail.ContruirArrayMensagem(strTexto), arrArquivos);
    End Else Begin
      Setlength(arrArquivos, 1);
      arrArquivos[0] := strArqHtml;

      qryFatDor := fCriaQuery(AOwner);
      Try
        With qryFatDor, SQL Do
        Begin
          Close;
          Clear;

          Add(' SELECT DISTINCT            ');
          Add('        FDO_CODITE          ');
          Add(' FROM FATDOR                ');
          Add(' WHERE FDO_NUMDOC = :NUMDOC ');
          Add('   AND FDO_ESPDOC = :ESPDOC ');
          Add('   AND FDO_CODEMP = :CODEMP ');

          ParamByName('NUMDOC').AsString := strNumPed;
          ParamByName('ESPDOC').AsString := strEspDoc;
          ParamByName('CODEMP').AsString := strCodEmp;

          Open;

          While Not Eof Do
          Begin

            If FileExists(fCfgSis('PATIMG') +'\'+ FieldByName('FDO_CODITE').AsString +'.jpg') Then
            Begin
              Setlength(arrArquivos, Length(arrArquivos)+1);
              arrArquivos[High(arrArquivos)] := fCfgSis('PATIMG')+ '\' + FieldByName('FDO_CODITE').AsString +'.jpg';
            End;

            Next;
          End;

        End;

        pCriarArrayAnexosEDestinatarios('', strEmailDestinatario, arrDestinatarios, arrArquivos);

        TEnvioEmail.EnviarEmail(AOwner, strLoginUsuarioLogado, strAssunto, arrDestinatarios, [], [], TEnvioEmail.ContruirArrayMensagem(strTexto), arrArquivos);
      Finally
        FreeAndNil(qryFatDor);
      End;

    End;
    SetForegroundWindow(Application.Handle);
  End
  Else
    fMensagem('ATENÇÃO!', 'Não foi possível exportar o arquivo PDF !', ['&Ok']);
end;

procedure pGerarPDF(strNumDoc: String; blnPedidoBaixadoTotalmente: Boolean = False);
Var
    strArquivo: String;
    strOrdem  : String;
    opcComSemPreco: TImpressaoComSemPrecoOrPd;
    blnComMar,
    blnLocFis : Boolean;
    strModo   : String;
    strNomEmp : String;
    blnCabCD  : Boolean;
    strNumPed : String;
    strEspDoc : String;
    strCodEmp : String;
    strCodCli : String;
    blnQtdOri : Boolean;
    frmFatMenuPrecoQtde: TfrmFatMenuPrecoQtde;

begin
  strEspDoc := '';
  blnQtdOri := True;

  If (Pos('OR', strNumDoc) > 0) Then
    strEspDoc := 'OR'

  Else If (Pos('PD', strNumDoc) > 0) Then
    strEspDoc := 'PD';

  If fEmptyStr(strEspDoc) Then
    Exit;

  strNumPed := LeftStr(strNumDoc, 12);
  strCodEmp := RightStr(strNumDoc, 3);

  If Not fVerificaAcessoSistema('PGEPDF', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!'+ #13#10 +
                          'PGEPDF: permite gerar PDF para Pedido/Orçamento.', ['&Ok']);
    Exit;
  End;

  TFatVenda.pAtualizacaoCotacaoDolar(strNumPed, strEspDoc, strCodEmp);

  strNomEmp := 'R';
  blnComMar := True;
  blnLocFis := False;
  strModo   := 'R';
  blnCabCD  := False;

  If Not fLayoutAtivoPdfPedidoOrcamento(strNumPed, strEspDoc, strCodEmp) Then
  Begin
    fMensagem('ATENÇÃO', 'Não há Layout Disponível para gerar PDF!', ['&O k']);
    Exit;
  End
  Else
  Begin

    opcComSemPreco := impComPrecoGeral;

    If (fCfgSis('ORCSPR', varBoolean, VS_strCodEmp)) And Not fCfgSis('ORSPSM', varBoolean, VS_strCodEmp) Then // Sim e Não
    Begin

      Try
        pCriarFormularios(TfrmFatMenuPrecoQtde, frmFatMenuPrecoQtde);

        If (blnPedidoBaixadoTotalmente) then
        begin
          blnQtdOri := True;
          frmFatMenuPrecoQtde.rdgQtde.ItemIndex := 0;
          frmFatMenuPrecoQtde.rdgQtde.Enabled := False;
        end
        Else
          blnQtdOri := False;

        frmFatMenuPrecoQtde.showModal;
        opcComSemPreco := IIF((frmFatMenuPrecoQtde.rdgPreco.ItemIndex = 0), impComPrecoGeral, impSemPrecoGeral);
        blnQtdOri := (frmFatMenuPrecoQtde.rdgQtde.ItemIndex  = 0);
        If (Not fEmptyStr(fCfgSis('SENPRE'))) And (frmFatMenuPrecoQtde.rdgPreco.ItemIndex = 0) Then
          opcComSemPreco := IIF(fMSG_SenhaImprimirComPrecoCRM(strNumPed, strEspDoc, strCodEmp), opcComSemPreco, impSemPrecoGeral);
      Finally
        pFreeAndNil(frmFatMenuPrecoQtde);
      End;

    End
    Else If (fCfgSis('ORCSPR', varBoolean, VS_strCodEmp)) And fCfgSis('ORSPSM', varBoolean, VS_strCodEmp) Then //Sim e Sim
    Begin

      Case fGetMenu('Opção:',['Com Preço e Com Marca', 'Com Preço e Sem Marca', 'Sem Preço e Com Marca', 'Sem Preço e Sem Marca'], 1) Of
        1:opcComSemPreco := impComPrecoComMarca;
        2:opcComSemPreco := impComPrecoSemMarca;
        3:opcComSemPreco := impSemPrecoComMarca;
        4:opcComSemPreco := impSemPrecoSemMarca;
      End;

      If (Not fEmptyStr(fCfgSis('SENPRE'))) And (opcComSemPreco in [impComPrecoComMarca, impComPrecoGeral, impComPrecoSemMarca]) Then
      Begin
        opcComSemPreco := IIF(fMSG_SenhaImprimirComPrecoCRM(strNumPed, strEspDoc, strCodEmp), opcComSemPreco, impSemPrecoGeral);
        If (opcComSemPreco = impSemPrecoGeral) Then
        Begin
          Case fGetMenu('Opção para geração do PDF ("Sem Preço" pois não houve liberação!)',['Sem Preço e Com Marca', 'Sem Preço e Sem Marca'], 1) Of
            1:opcComSemPreco := impSemPrecoComMarca;
            2:opcComSemPreco := impSemPrecoSemMarca;
          End;
        End;
      End;

    End;
  End;

  If fEmptyStr(IIf(strEspDoc='OR', fCfgSis('PDFOSP', IIF(fUsaLayOrigReimpDocs(), strCodEmp, VS_strCodEmp)), fCfgSis('PDFPSP', IIF(fUsaLayOrigReimpDocs(), strCodEmp, VS_strCodEmp)))) Or
     fEmptyStr(IIf(strEspDoc='OR', fCfgSis('PDFSPO', IIF(fUsaLayOrigReimpDocs(), strCodEmp, VS_strCodEmp)), fCfgSis('PDFSPP', IIF(fUsaLayOrigReimpDocs(), strCodEmp, VS_strCodEmp)))) Then
    pMensagemOk('Não foi encontrado o layout para a geração de PDF!' + #13#10 +
                'Será utilizado o layout padrão para essa ação.' + #13#10 +
                'Verifique as configurações: PDFOSP, PDFSPO, PDFPSP e PDFSPP');

  If Not fVerificaAcessoSistema('IMPDCP', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!' + #13#10 +
                          'IMPDCP: permitir impressão de documento com preço.', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmFatGorEmail, frmFatGorEmail);

    strCodCli := fRetornaInformacaoVenda(strNumPed, strEspDoc, strCodEmp, 'CODCLI');

    strArquivo := frmFatGorEmail.fGeraEmail(strNumPed,
                                            strEspDoc,
                                            opcComSemPreco,
                                            blnComMar,
                                            'P',
                                            strModo,
                                            strOrdem,
                                            strCodEmp,
                                            blnLocFis,
                                            strNomEmp,
                                            strCodCli,
                                            blnCabCD,
                                            False,
                                            blnQtdOri);
  Finally
    pDestroiModulo(frmFatGorEmail);
  End;

  If (Not fEmptyStr(strArquivo)) Then
    pExecArquivo(strArquivo, Application.Handle);
end;

procedure pGerarPDFVN(strNumDoc: String; strEspDoc: String; strCodEmp: String; strCodCli: String);
  Var
    strNomeArquivo: String;
    strArqPDF: String;
    blnImprimiuEditor: Boolean;
    blnImprimiuAmbien: Boolean;
    blnAchouLayout: Boolean;
begin
  If Not fLayoutAtivo(strNumDoc, strEspDoc, strCodEmp, 'C', False, True) Then
  Begin
    fMensagem('ATENÇÃO', 'Não há Layout Disponível para gerar PDF!', ['&O k']);
    Exit;
  End;

  If (Pos(strEspDoc, 'NS_FF_DV_') > 0) And (Not fVerificaAcessoSistema('RENAUT')) Then
  Begin
    fMensagem('ATENÇÃO', 'Operador não tem direito de acesso para imprimir documentos não autorizados!', ['&O k']);
    Exit;
  End;

  If Not fVerificaAcessoSistema('IMPDCP', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!' + #13#10 +
                          'IMPDCP: Permitir impressão de documento com preço.', ['&Ok']);
    Exit;
  End;

  pImprimeFatImpAux('MOVGER',
                    strNumDoc,
                    strEspDoc,
                    strCodEmp,
                    strCodCli,
                    'C',
                    'V',
                    False,
                    strNomeArquivo,
                    False,
                    False,
                    blnImprimiuEditor,
                    blnImprimiuAmbien,
                    strArqPDF,
                    blnAchouLayout,
                    'P');

  If (Not fEmptyStr(strArqPDF)) Then
    pExecArquivo(strArqPDF, Application.Handle);
end;

procedure pGerarVendaPerdida(strNumDoc: String; strCodOco: String = '');
  Var
    qryGen   : TUniQuery;
    strObserv: String;
    strCodMot: String;
    strNumGA : String;
    strCodigo: String;
    strCodCon: String;
    fltVlrCon: Double;
    blnVerificaOrc: Boolean;

  procedure pCarregaItensOrcamento;
  begin
    qryGen.Close();
    qryGen.SQL.Clear();
    qryGen.SQL.Add('SELECT D.AUTOINCREM, D.FDO_CODITE, D.FDO_DESCRI,    ');
    qryGen.SQL.Add('       (D.FDO_QTDITE - D.FDO_QTDBAI) AS FDO_QTDITE, ');
    qryGen.SQL.Add('       D.FDO_UNIORI, D.FDO_UNITAR, D.FDO_TOTITE,    ');
    qryGen.SQL.Add('       C.CLI_CODCLI, C.CLI_C_G_C_, D.FDO_NUMDOC,    ');
    qryGen.SQL.Add('       D.FDO_ESPDOC, D.FDO_CODEMP, D.FDO_CODVEN,    ');
    qryGen.SQL.Add('       E.FDO_NUMCMP, G.AUTOINCREM AS SEQGER         ');
    qryGen.SQL.Add('  FROM FATDOR D                                     ');
    qryGen.SQL.Add('  JOIN FATGOR G ON D.FDO_NUMDOC = G.FGO_NUMDOC      ');
    qryGen.SQL.Add('               AND D.FDO_ESPDOC = G.FGO_ESPDOC      ');
    qryGen.SQL.Add('               AND D.FDO_CODEMP = G.FGO_CODEMP      ');
    qryGen.SQL.Add('  INNER JOIN EXTDOR E ON E.FDO_SEQFDO = D.AUTOINCREM');
    qryGen.SQL.Add('  JOIN CADCLI C ON D.FDO_CODCLI = C.CLI_CODCLI      ');
    qryGen.SQL.Add(' WHERE FDO_NUMDOC = :NUMDOC                         ');
    qryGen.SQL.Add('   AND FDO_ESPDOC = :ESPDOC                         ');
    qryGen.SQL.Add('   AND FDO_CODEMP = :CODEMP                         ');
    qryGen.SQL.Add('   AND FDO_JAFATU = 0                               ');

    qryGen.ParamByName('NUMDOC').AsString := LeftStr(strNumDoc, 12);
    qryGen.ParamByName('ESPDOC').AsString := Copy(strNumDoc, 14, 2);
    qryGen.ParamByName('CODEMP').AsString := RightStr(strNumDoc, 3);

    qryGen.Open();
  end;

  procedure pRemoveVendaPerdida(Const AVerificaOrc: Boolean = False);
    Var
      qryGenDel: TUniQuery;
  begin
    If fEmptyStr(strCodigo) Then
     Exit;

    If AVerificaOrc Then
    Begin
      pCarregaItensOrcamento();

      If qryGen.IsEmpty Then
        Exit;
    End;

    qryGenDel := fCriaQuery();

    Try
      qryGenDel.SQL.Add('DELETE FROM MOVVPG');
      qryGenDel.SQL.Add('WHERE VPG_CODEMP = :CODEMP');
      qryGenDel.SQL.Add('  AND VPG_CODIGO = :CODIGO');

      qryGenDel.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGenDel.ParamByName('CODIGO').AsString := strCodigo;
      qryGenDel.ExecSQL;
    Finally
      FreeAndNil(qryGenDel);
    End;
  end;

  function fInformaMotivo: Boolean;
  begin
    pCriarFormularios(TfrmDigMotivoVendaPerdida, frmDigMotivoVendaPerdida);

    Try
      If (frmDigMotivoVendaPerdida.ShowModal = mrOk) Then
      Begin
        strCodMot := frmDigMotivoVendaPerdida.strCodMot;
        strObserv := frmDigMotivoVendaPerdida.strObservacoes;
        strCodCon := frmDigMotivoVendaPerdida.strCodCon;
        fltVlrCon := frmDigMotivoVendaPerdida.fltVlrCon;
        Exit(True);
      End;

      Exit(False);
    Finally
      FreeAndNil(frmDigMotivoVendaPerdida);
    End;
  end;

  function fInsereVendaPerdida(Const strCodMot, strObserv, strCodCon: String; fltVlrCon: Double): Boolean;
    Var
      blnCapa       : Boolean;
      blnExigeSenha : Boolean;
      strSenha      : String;
      strSenhaConfg : String;
  begin
    blnCapa := False;

    {Validações}
    strSenhaConfg := fCfgSis('SENEIO');
    blnExigeSenha := (Not fEmptyStr(strSenhaConfg));

    If blnExigeSenha Then
    Begin
      If ffrmSenha(strSenha, 'Inclusão Venda Perdida') Then
      Begin

        If (strSenha <> strSenhaConfg) Then
        Begin
          fMensagem('','Senha incorreta!',['&OK']);
          Exit(False);
        End;

      End
      Else
        Exit(False);
    End;

    qryGen.First();

    While Not qryGen.Eof Do
    Begin
      if not blnCapa then
      Begin
        blnCapa   := True;

        strCodigo := fAtualizaProCod('MOVVPG', 'VPG_CODIGO');

        pIncluiMovVpg(strCodigo,
                      qryGen.FieldByName('CLI_CODCLI').AsString,
                      qryGen.FieldByName('FDO_CODVEN').AsString,
                      qryGen.FieldByName('CLI_C_G_C_').AsString,
                      VS_Date,
                      qryGen.FieldByName('FDO_NUMDOC').AsString,
                      qryGen.FieldByName('FDO_ESPDOC').AsString,
                      fCfgSis('SERFSC'));
      End;

      pIncluiMovVpd(strCodigo,
                    qryGen.FieldByName('FDO_CODITE').AsString,
                    qryGen.FieldByName('FDO_DESCRI').AsString,
                    strCodMot,
                    qryGen.FieldByName('FDO_QTDITE').AsFloat,
                    qryGen.FieldByName('FDO_UNIORI').AsFloat,
                    qryGen.FieldByName('FDO_UNITAR').AsFloat,
                    qryGen.FieldByName('FDO_TOTITE').AsFloat,
                    strObserv,
                    strCodCon,
                    fltVlrCon,
                    qryGen.FieldByName('FDO_NUMCMP').AsString);

      qryGen.Next();
    End;

    Exit(True);
  end;

begin
  qryGen := fCriaQuery();
  blnVerificaOrc := True;

  Try
    Try
      pCarregaItensOrcamento();

      If qryGen.IsEmpty Then
      Begin
        fMensagem('ATENÇÃO!', 'Orçamento não possui itens para gerar venda perdida!', ['&Ok']);
        Exit;
      End;

      If fPedidoVinculadoComGarantia(qryGen.FieldByName('SEQGER').AsString, strNumGA) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não será possível realizar baixa, pois o Orçamento contem vínculo com Garantia: GA [' + strNumGA + ']  !', ['&Ok']);
        Exit;
      End;

      If fInformaMotivo() Then
      Begin
        If Not fInsereVendaPerdida(strCodMot, strObserv, strCodCon,fltVlrCon) Then
          Exit;

        TfrmFatAltQtdeItensPedido.pBaixarPedidoNaoEntregue(qryGen.FieldByName('FDO_NUMDOC').AsString,
                                                           qryGen.FieldByName('FDO_ESPDOC').AsString,
                                                           qryGen.FieldByName('FDO_CODEMP').AsString,
                                                           qryGen.FieldByName('CLI_CODCLI').AsString,
                                                           True,
                                                           True,
                                                           strCodOco,
                                                           strObserv);
      End;
    Except On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'pGerarVendaPerdida');
        blnVerificaOrc := False;
      End;
    End;
  Finally
    pRemoveVendaPerdida(blnVerificaOrc);
    FreeAndNil(qryGen);
  End;
end;

function fDesmembrarPedidoAbastecimento(strNumDoc: String): Boolean;
  Var
    strNumero : String;
    strEspecie: String;
    strEmpresa: String;
    objAltPed : TAlterarPedido;
begin
  strNumero  := LeftStr(strNumDoc, 12);
  strEspecie := Copy(strNumDoc, 14, 2);
  strEmpresa := RightStr(strNumDoc, 3);

  objAltPed := TAlterarPedido.Create(nil);

  Try
    objAltPed.opcExibirTelaAbastecimento := oeExibirSempre;
    objAltPed.blnRealizarDesmembramento  := True;

    objAltPed.strNumPed := strNumero;
    objAltPed.strEspPed := strEspecie;
    objAltPed.strEmpPed := strEmpresa;

    Result := objAltPed.fCarregarPedido And
              objAltPed.fCalculaTotalPedido And
              objAltPed.fGravarPedido;
  Finally
    FreeAndNil(objAltPed);
  End;
end;

procedure pRetirarVinculoReq_Transf(strNumDoc: String);
  Var
    strNumero: String;
    strEspecie: String;
    strEmpresa: String;
    frmFatRetirarVinculoReq_Transf : TfrmFatRetirarVinculoReq_Transf;
begin
  strNumero  := LeftStr(strNumDoc, 12);
  strEspecie := Copy(strNumDoc, 14, 2);
  strEmpresa := RightStr(strNumDoc, 3);

  If strEspecie <> 'PD' Then
    Exit;

  pCriarFormularios(TfrmFatRetirarVinculoReq_Transf, frmFatRetirarVinculoReq_Transf);

  Try
    frmFatRetirarVinculoReq_Transf.strNumDoc := strNumero;
    frmFatRetirarVinculoReq_Transf.strEspDoc := strEspecie;
    frmFatRetirarVinculoReq_Transf.strEmpDoc := strEmpresa;
    frmFatRetirarVinculoReq_Transf.ShowModal;
  Finally
    pFreeAndNil(frmFatRetirarVinculoReq_Transf);
  End;

end;

function fDesmembrarPedOrc(strNumDoc: String): Boolean;
  Var
    strNumero: String;
    strEspecie: String;
    strEmpresa: String;
    frmFatDesmembrarPedido : TfrmFatDesmembrarPedido;
begin
  strNumero  := LeftStr(strNumDoc, 12);
  strEspecie := Copy(strNumDoc, 14, 2);
  strEmpresa := RightStr(strNumDoc, 3);

  If (strEspecie = 'PD') And (fCfgSis('SLTFRC', varBoolean)) Then
  Begin
    Result := fDesmembrarPedidoAbastecimento(strNumDoc);
    If Result Then
    Begin
      pGeraTransferencias;
      pGeraRequisicoesCompra;
    End;
    Exit;
  End;

  Try
    pCriarFormularios(TfrmFatDesmembrarPedido, frmFatDesmembrarPedido);
    frmFatDesmembrarPedido.strNumPed    := strNumero;
    frmFatDesmembrarPedido.strEspPed    := strEspecie;
    frmFatDesmembrarPedido.strEmpPed    := strEmpresa;
    frmFatDesmembrarPedido.blnCRM       := True;
    frmFatDesmembrarPedido.blnPermiteAlterarCndPag := True;

    frmFatDesmembrarPedido.ShowModal();

    Result := frmFatDesmembrarPedido.blnDesmembrou;

    If Result Then
    Begin
      pGeraTransferencias;
      pGeraRequisicoesCompra;
    End;
  Finally
    FreeAndNil(frmFatDesmembrarPedido);
  End;
end;

Function fRetornaItensCRM(strNumPed, strEspDoc, strCodEmp: string): TUniQuery;
Begin
  result := fCriaQuery;

  result.sql.Add('SELECT DISTINCT');
  result.sql.Add(' D.CLI_NOMCLI');
  result.sql.Add(',D.CLI_CODCLI');
  result.sql.Add(',D.CLI_C_G_C_');
  result.sql.Add(',C.ITE_CODITE');
  result.sql.Add(',C.ITE_DESITE');
  result.sql.Add(',MAR_DESMAR');
  result.sql.Add(',FDO_UNIDAD');
  result.sql.Add(',FDO_QTDITE');
  result.sql.Add(',FDO_UNITAR');
  result.sql.Add(',FDO_TOTITE');
  result.sql.Add(',FDO_UNIORI');
  result.sql.Add(',FGO_VLRCON');
  result.sql.Add('FROM FATGOR');
  result.sql.Add('      JOIN FATDOR   ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM');
  result.sql.Add('      JOIN CADITE C ON C.ITE_CODITE = FDO_CODITE');
  result.sql.Add('LEFT  JOIN CADCLI D ON D.CLI_CODCLI   = FATGOR.FGO_CODCLI');
  result.sql.Add('LEFT  JOIN CADMAR   ON MAR_CODMAR   = C.ITE_CODMAR');
  result.sql.Add('WHERE FGO_NUMDOC = :NUMDOC');
  result.sql.Add('AND   FGO_ESPDOC = :ESPDOC');
  result.sql.Add('AND   FGO_CODEMP = :CODEMP');
  result.ParamByName('NUMDOC').AsString := strNumPed;
  result.ParamByName('ESPDOC').AsString := strEspDoc;
  result.ParamByName('CODEMP').AsString := strCodEmp;

  result.open;

End;

function fMSG_SenhaImprimirComPrecoCRM(strNumPed, strEspDoc, strCodEmp: string): Boolean;
var
  objTabela    : TRegistroMsgLiberaTabela;
  objLinha     : TLinhaMsgLibera;
  objLiberacao : TLiberacao;
  strCodEmi,
  strDesEmi,
  strMarEmi,
  strUndEmi,
  strQtdEmi,
  strUniTar,
  strTotIte,
  strUniOri    : String;
  qryTabAux: TUniQuery;
Begin

  objLiberacao := TLiberacao.Create;

  qryTabAux := fRetornaItensCRM(strNumPed, strEspDoc, strCodEmp);

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Senha para imprimir documento com preço');
  objLiberacao.objMsgLibera.pAddSeparador(75);
  objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                   , qryTabAux.FieldByName('CLI_NOMCLI').AsString                                                , 24);
  objLiberacao.objMsgLibera.pAddTextoCaption('Número Dcumento'           , strNumPed                                                                                   , 24);
  objLiberacao.objMsgLibera.pAddTextoCaption('Valor Total do Documento'  , FormatFloat('#,##0.00', qryTabAux.FieldByName('FGO_VLRCON').AsFloat)                        , 24);

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'Código/Descrição' , 24 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'Marca'            , 7  , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'Und.'             , 4  , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'Quantidade'       , 12 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'Pr. Unitário'     , 13 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'Valor Total'      , 14 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'Pr. Tabela'       , 13 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);


  With qryTabAux Do
  Begin
    First;

    While Not Eof Do
    Begin

      strCodEmi := FieldByName('ITE_CODITE').AsString;
      strDesEmi := FieldByName('ITE_DESITE').AsString;
      strMarEmi := FieldByName('MAR_DESMAR').AsString;
      strUndEmi := fRetSiglaUni(FieldByName('FDO_UNIDAD').AsString);
      strQtdEmi := FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), FieldByName('FDO_QTDITE').AsFloat);
      strUniTar := FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), FieldByName('FDO_UNITAR').AsFloat);
      strTotIte := FormatFloat(fMskDigitos(2), FieldByName('FDO_TOTITE').AsFloat);
      strUniOri := FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), FieldByName('FDO_UNIORI').AsFloat);


      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('Código/Descrição' , strCodEmi + '-' + strDesEmi  , 24 , alEsquerda );
      objLinha.pAddColuna('Marca'            , strMarEmi                    , 7  , alEsquerda );
      objLinha.pAddColuna('Und.'             , strUndEmi                    , 4  , alCentro   );
      objLinha.pAddColuna('Quantidade'       , strQtdEmi                    , 12 , alDireita  );
      objLinha.pAddColuna('Pr. Unitário'     , strUniTar                    , 13 , alDireita  );
      objLinha.pAddColuna('Valor Total'      , strTotIte                    , 14 , alDireita  );
      objLinha.pAddColuna('Pr. Tabela'       , strUniOri                    , 13 , alDireita  );
      objTabela.lstLinhas.Add(objLinha);

      Next;
    End;
  End;

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
  objLiberacao.strDirAce := 'IMPDCP';
  objLiberacao.strMsgSen := 'Senha para imprimir documento com preço';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCliente := qryTabAux.FieldByName('CLI_CODCLI').AsString + '-' + qryTabAux.FieldByName('CLI_NOMCLI').AsString;
  objLiberacao.strCpfCnpj := qryTabAux.FieldByName('CLI_C_G_C_').AsString;

  Result := objLiberacao.fLibera;

  freeAndNil(objLiberacao);

End;

function fRetOcoDoc(const strCodEmp: String; strEspDoc: string; strNumDoc: String; strCodCli: String = ''): IOcorrenciaCRM;
var
  qrySelect: TUniQuery;
begin
  qrySelect :=  fCriaQuery();
  Try
    qrySelect.Close;
    qrySelect.SQL.Clear;

    qrySelect.SQL.Add(' SELECT OCO_CODOCO,         ');
    qrySelect.SQL.Add('        OCO_CODEMP,         ');
    qrySelect.SQL.Add('        OCO_CODCLI,         ');
    qrySelect.SQL.Add('        OCO_CODOPE,         ');
    qrySelect.SQL.Add('        OCO_TIP_FC          ');
    qrySelect.SQL.Add(' FROM MOVOCO                ');
    qrySelect.SQL.Add(' WHERE OCO_NUMDOC = :NUMDOC ');
    qrySelect.SQL.Add('   AND OCO_ESPDOC = :ESPDOC ');
    qrySelect.SQL.Add('   AND OCO_CODEMP = :CODEMP ');
    If Not fEmptyStr(strCodCli)Then
      qrySelect.SQL.Add('   AND OCO_CODCLI = :CODCLI ');

    qrySelect.ParamByName('NUMDOC').AsString := strNumDoc;
    qrySelect.ParamByName('ESPDOC').AsString := strEspDoc;
    qrySelect.ParamByName('CODEMP').AsString := strCodEmp;

    If Not fEmptyStr(strCodCli)Then
      qrySelect.ParamByName('CODCLI').AsString := strCodCli;

    qrySelect.Open;

    If Not qrySelect.IsEmpty Then
    Begin

      Case fStrToTTip_Fc(qrySelect.FieldByName('OCO_TIP_FC').AsString) Of
        tpCliente:   Result := TAtuOcoCrmCliente.Create;
        tpProspecto: Result := TAtuOcoCrmProspecto.Create;
      End;

      Result.CodOco(qrySelect.FieldByName('OCO_CODOCO').AsString)
            .CodEmp(qrySelect.FieldByName('OCO_CODEMP').AsString)
            .Tip_FC(qrySelect.FieldByName('OCO_TIP_FC').AsString)
            .CodOpe(qrySelect.FieldByName('OCO_CODOPE').AsString);

    End;
  Finally
    FreeAndNil(qrySelect);
  End;
end;

function fInformacaoDesatualizada(const strAutInc, strNosNum: String): Boolean;
var
  strNosNumAtu: String;
Begin
  strNosNumAtu := fCampoTabela('CTR_NOSNUM', 'CADREC', ['AUTOINCREM'], [strAutInc]);
  Result := (strNosNumAtu <> strNosNum);
End;

procedure pImprimeBoleto(Sender: TComponent; const strCodEmp, strEspDoc, strCodcli, strNumDoc, strParcel: String);
var
  arrCtrDup: TArrDupCtr;
  objBoleto: TBoleto;
  qrySelect: TUniQuery;
  strSQL: String;
  blnUsaModeloFaturamento: Boolean;
  strPerMor: String;
  strPerMul: String;
  blnEhBoletoMeiaNota: Boolean;
  stlBancosEnvio: TStringList;
  intContador: Integer;
  blnReImprimeParcial: Boolean;
  strOrdCampo: String;
  strOrdTipo: String;
  blnProrrogado: Boolean;
  cdsAux: TUniClientDataSet;
  dspConsulta: TUniDataSetProvider;
  objLiberacao : TLiberacao;
  blnImpBol: Boolean;
  blnReimprime: Boolean;
  objMsg : TMensagemLiberacao;
  strBoletoImpresso: String;
  strCarteira: String;
Begin
  blnImpBol := True;
  blnReImprimeParcial := False;
  blnEhBoletoMeiaNota := False;
  blnProrrogado       := False;
  blnReimprime        := False;

  If Not fVerificaAcessoSistema('OCOBOL', strLoginUsuarioLogado) Then   // PEMAIL - usado na tela de impressao de boletos
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  objBoleto := TBoleto.Create(Sender, 'CADREC', False);
  qrySelect := fCriaQuery();
  stlBancosEnvio := TStringList.Create;
  cdsAux := TUniClientDataSet.Create(Sender);
  dspConsulta := TUniDataSetProvider.Create(Sender);
  objLiberacao := TLiberacao.Create;
  objMsg := TMensagemLiberacao.Create(Sender);
  Try
    qrySelect.Close;
    qrySelect.SQL.Clear;

    strSQL := strSQL + ' SELECT IF(CTR_NOSNUM IS NOT NULL OR CTR_DTAENV IS NOT NULL, CONCAT(CTR_BCOBOL, "-", CTR_CARTEI), CTR_BCOBOL) AS CTR_CHAVE, ';
    strSQL := strSQL + '  0.0000 AS CTR_JURALT, ';
    strSQL := strSQL + '  0.0000 AS CTR_MULALT, ';
    strSQL := strSQL + '  CADREC.*              ';
    strSQL := strSQL + '  FROM CADREC           ';
    strSQL := strSQL + ' LEFT JOIN CADPOR ON CTR_CODPOR = POR_CODPOR ';
    strSQL := strSQL + ' WHERE                      ';
    strSQL := strSQL + '   CTR_NUMDUP = :NUMDOC AND ';
    strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   CTR_DTAREC IS NULL AND   ';
    strSQL := strSQL + '   CTR_VALDUP > 0 AND       ';
    strSQL := strSQL + '   ((CTR_NOSNUM IS NULL AND CTR_DTAENV IS NOT NULL) OR (CTR_NOSNUM IS NOT NULL) OR (CTR_BCOBOL = "999" AND CTR_DTABOL IS NOT NULL)) AND ';
    strSQL := strSQL + '   COALESCE(POR_IMPBOL, "S") = "S" ';

    qrySelect.SQL.Add(strSQL);
    qrySelect.ParamByName('NUMDOC').AsString := strNumDoc;
    qrySelect.ParamByName('ESPDOC').AsString := strEspDoc;
    qrySelect.ParamByName('PARCEL').AsString := strParcel;
    qrySelect.ParamByName('CODEMP').AsString := strCodEmp;
    qrySelect.Open;

    pSetaClient(qrySelect);

    cdsAux.DisableControls;
    cdsAux.Close;
    dspConsulta.Name := 'dspConsulta';
    dspConsulta.DataSet := qrySelect;
    cdsAux.ProviderName := dspConsulta.Name;

    pSetaClient(cdsAux);
    cdsAux.Open;
    cdsAux.EnableControls;

    If Not cdsAux.IsEmpty Then
    Begin
      If  (Not fEmptyStr(cdsAux.FieldByName('CTR_NOSNUM').AsString)) OR
          (cdsAux.FieldByName('CTR_BCOBOL').AsString = '999') And
          (cdsAux.FieldByName('CTR_DTABOL').AsDateTIme > 0) Then
      Begin
        blnReimprime := True;

        objMsg.Clear;
        objMsg.pAddTexto('Existe(m) boleto(s) já impresso(s)');
        strBoletoImpresso := '';

        strBoletoImpresso := IfThen(fEmptyStr(cdsAux.FieldByName('CTR_NUMDUP').AsString),'', ' Duplicata: ' + cdsAux.FieldByName('CTR_NUMDUP').AsString + ' ') +
        IfThen(fEmptyStr(cdsAux.FieldByName('CTR_CODEMP').AsString),'', ' Emp: ' + cdsAux.FieldByName('CTR_CODEMP').AsString + ' ') +
        IfThen(fEmptyStr(cdsAux.FieldByName('CTR_BCOBOL').AsString),'', ' Banco: ' + cdsAux.FieldByName('CTR_BCOBOL').AsString + ' ') +
        IfThen(fEmptyStr(cdsAux.FieldByName('CTR_BCOBOL').AsString),'', ' Carteira: ' + cdsAux.FieldByName('CTR_CARTEI').AsString + ' ') +
        IfThen(fEmptyStr(cdsAux.FieldByName('CTR_NOSNUM').AsString),'', ' Nosso Núm: ' + cdsAux.FieldByName('CTR_NOSNUM').AsString + ' ');

        objMsg.pAddTexto(strBoletoImpresso);

        objLiberacao.Clear;
        objLiberacao.objMsgLibera.fGetObjectFromJson(objMsg.fGetJsonObject.ToJSON);
        objLiberacao.strDirAce := 'REIBOL';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.blnSempreVariavelUsuario := True;

        If objLiberacao.fLibera Then
          blnImpBol := True
        Else
          blnImpBol := False;
      End;

      If qrySelect.FieldByName('CTR_DTAVEN').AsDateTime < VS_Date Then
      Begin
        fMensagem('ATENÇÃO!', 'Impressão de duplicatas vencidas não permitido!', ['&Ok']);
        Exit;
      End;

      If blnImpBol And fInformacaoDesatualizada(cdsAux.FieldByName('AUTOINCREM').AsString, cdsAux.FieldByName('CTR_NOSNUM').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Existem duplicatas marcadas que foram impressas por outro usuário. Realize a pesquisa novamente para efetuar a impressão ou a reimpressão desses boletos!', ['&OK']);
        Exit;
      End;

      If blnImpBol Then
      Begin
        For intContador := 0 To stlBancosEnvio.Count -1 Do
        Begin
          If blnReimprime then
          Begin
            strCarteira := Copy(stlBancosEnvio[intContador], 5, Length(stlBancosEnvio[intContador]));
            cdsAux.Filter := IIF(fEmptyStr(Copy(stlBancosEnvio[intContador], 1, 3)),' AND CTR_BCOBOL = '''' ',
                             ' AND CTR_BCOBOL = ' + Copy(stlBancosEnvio[intContador], 1,3) + ' AND CTR_CARTEI = ' + QuotedStr(strCarteira));
          End
          Else
            cdsAux.Filter :=  IIF(fEmptyStr(Copy(stlBancosEnvio[intContador], 1, 3)),' AND CTR_BCOBOL = '''' ',
                             ' AND CTR_BCOBOL = ' + Copy(stlBancosEnvio[intContador], 1,3));

          cdsAux.Filtered := True;
        End;

        SetLength(arrCtrDup,Length(arrCtrDup)+1);
        arrCtrDup[Length(arrCtrDup)-1].strNumDup := cdsAux.FieldByName('CTR_NUMDUP').AsString;
        arrCtrDup[Length(arrCtrDup)-1].strParcel := cdsAux.FieldByName('CTR_PARCEL').AsString;
        arrCtrDup[Length(arrCtrDup)-1].strEspDoc := cdsAux.FieldByName('CTR_ESPDOC').AsString;
        arrCtrDup[Length(arrCtrDup)-1].strCodEmp := cdsAux.FieldByName('CTR_CODEMP').AsString;
        arrCtrDup[Length(arrCtrDup)-1].strCodCli := cdsAux.FieldByName('CTR_CODCLI').AsString;
        arrCtrDup[Length(arrCtrDup)-1].strAutoIn := cdsAux.FieldByName('AUTOINCREM').AsString;

        strPerMor := fFloatToStrVirgula(cdsAux.FieldByName('CTR_PERMOR').AsFloat, 12, 2);
        strPerMul := fFloatToStrVirgula(cdsAux.FieldByName('CTR_PERMUL').AsFloat, 12, 2);

        blnUsaModeloFaturamento := VarToStrDef(fCampoTabela('EMA_STATUS', 'EMASAI',
                                   ['EMA_CODIGO', 'EMA_CODGRU', 'EMA_CODEMP', 'EMA_ENTSAI'],
                                   ['001', '008', VS_strCodEmp, 'S']), '') = 'A';

        objBoleto.blnEhBoletoMeiaNota := blnEhBoletoMeiaNota;

        stlBancosEnvio.Add(qrySelect.FieldByName('CTR_CHAVE').AsString);

        objBoleto.pImprimir(cdsAux, arrCtrDup, Copy(stlBancosEnvio[0], 1, 3), False, False, False,
                            False, blnReImprimeParcial, qrySelect.FieldByName('CTR_CARTEI').AsString,
                            strPerMor, strPerMul, '', strOrdCampo, strOrdTipo, False, True, blnProrrogado, False,
                            False, blnUsaModeloFaturamento);



      End;

      cdsAux.Next;
    End;

  Finally
    FreeAndNil(objBoleto);
    FreeAndNil(qrySelect);
    FreeAndNil(stlBancosEnvio);
    FreeAndNil(dspConsulta);
    FreeAndNil(cdsAux);
    FreeAndNil(objLiberacao);
    FreeAndNil(objMsg);
  End;
End;

function fAtualizarAssuntoOcorrencia(const strCodOco, strTip_FC, strCodEmp: String): Boolean;
var
  strAssuntoOco: String;
  blnAssuntoInf: Boolean;
  ObjCrm: TAtuOcoCrm;
  ModalResul: Integer;
begin
  Result := False;
  If Not fCfgSis('OCOAST',varBoolean) Then
  Begin
    Exit;
  End;

  ObjCrm := TAtuOcoCrm.Create(Nil);
  Try
    ObjCrm.pCarregaOcorrencia(strTip_FC, strCodOco, strCodEmp);
    If ObjCrm.strDtaCon > 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'A ocorrência está finalizada!', ['&Ok']);
      Exit;
    End;

    repeat
      strAssuntoOco := fInputDialog(ModalResul,
                                    'Assunto Ocorrência',
                                    'Informe o assunto da ocorrência.',
                                    ObjCrm.strAssunto);

      blnAssuntoInf := Not fEmptyStr(strAssuntoOco);

      If (Not blnAssuntoInf) And (ModalResul = MrOk) Then
      Begin
        fMensagem('ATENÇÃO!', 'O assunto da ocorrência deve ser preenchido!', ['&Ok']);
      End;

    until ((blnAssuntoInf) Or (ModalResul = MrCancel)) ;

    If (ModalResul = MrOk) And blnAssuntoInf Then
    Begin
      ObjCrm.strAssunto := strAssuntoOco;
      ObjCrm.strDescri := 'Alterado assunto da ocorrência ' +
                          '<<csq>>Operador : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>';
      ObjCrm.strDtaInc := VS_Date;
      ObjCrm.strHorInc := fNow();
      ObjCrm.pInsereHistoricoOcorrencia;
      ObjCrm.pAtualizaOcorrencia;
      Result := True;
    End;
  Finally
    FreeAndNil(ObjCrm);
  End;

end;

function fInformarTemperaturaAtendimento(const strCodCor: String = ''): String;
var
  frmDigTempAtendimento: TfrmDigTempAtendimento;
Begin
  Result := strCodCor;
  pCriarFormularios(TfrmDigTempAtendimento, frmDigTempAtendimento);
  Try
    frmDigTempAtendimento.strCodCor := strCodCor;
    frmDigTempAtendimento.ShowModal;
    IF frmDigTempAtendimento.ModalResult = MrOk Then
    Begin
      Result := frmDigTempAtendimento.edtCodigo.Text;
    End;
  Finally
    pFreeAndNil(frmDigTempAtendimento);
  End;
End;

function fRetornaCorAtendimentoOcorrencia(const strCodOco, strCodEmp: String): String;
Begin
  Result := EmptyStr;

  If fEmptyStr(strCodOco) Then
    Exit;

  Result := fCampoTabela('OCO_CODTEA',
                         'MOVOCO',
                         ['OCO_CODOCO','OCO_CODEMP'],
                         [strCodOco, IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp)]);
End;


function fPathArquivosOcoCrm: String;
Begin
  Result := ExtractFilePath(Application.ExeName)+ 'Arquivos_crm\';
End;

end.



