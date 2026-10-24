unit untRessarcImpRetidoPorSujeicaoPassivaSubst;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiRelatorio, Vcl.ExtCtrls, untTReimpressaoRelRessarcimentoCat158,
  frxExportCSVTestabilidade, Vcl.AppEvnts, frxDesgn, frxClass, frxDBSet,
  frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untIZClient,
  RLFilters, RLDraftFilter, Vcl.Menus, Vcl.StdCtrls, EditFocus, QColorLabel, Uni,
  Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, Vcl.ComCtrls, untTypesSistema,
  Data.DB, Datasnap.DBClient, UniClientDataSet, untGeraExcel, untExcel,
  untICalculaImpostosCat158, untIDadosAdicionaisCalculaImpostosCat158,
  untTCalculaImpostos, untTCalculaImpostosCfgX60, untTCalculaImpostosIVA,
  untTDadosAdicionaisCalculaImpostosCat158;

type
  //dados tabela: CAT_158_SPED
  TItemNotaVendidoRelacionado = class
    strTabela: string;
    strChaveAcesso: string;
    strAutoIncrem: string;
    strAutoIncremCompra: string;
    dtaDataCompra: TDateTime;
    strModeloNfCompra: string;
    strDocumentoNfCompra: string;
    strSerieNfCompra: string;
    strParticipanteNfCompra: string;
    fltQuantidadeUtilizadaNfCompra: double;
    fltValorUnitarioNfCompra: double;
    fltValorUnitarioBaseStNfCompra: double;
    fltValorUnitarioBaseIcmNfCompra: double;
    fltValorAlqIcmNfCompra: double;
    fltValorUnitarioIcmNfCompra: double;
    strCodigoProdutoUtilizadoRessarcimento: string;
    fltTotalUtilizadoBaseIcmST: double;
    fltAlqIcmsST: double;
    fltTotalUtilizadoValorIcmST: double;
    strAutoIncremVenda: string;
  end;

type
  //dados tabela: CAT_158
  TItemNotaValidacao = class
    strAutoIncrem: String;
    strSeqGer: String;
    fltQuantidadeUtilizada: Double;
    fltQuantidadeTotal: Double;
  end;

type
  TfrmRessarcImpRetidoPorSujeicaoPassivaSubst = class(TfrmPaiRelatorio)
    lbl1: TLabel;
    lbl3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    lblCodEmp: TLabel;
    pgbProgresso: TProgressBar;
    cdsRelatorioNotasSaida: TUniClientDataSet;
    cdsRelatorioNotasEntrada: TUniClientDataSet;
    cdsRelatorioNotasEntradaDATA: TDateField;
    cdsRelatorioNotasEntradaDOCUMENTO: TStringField;
    cdsRelatorioNotasEntradaFORNECEDOR: TStringField;
    cdsRelatorioNotasEntradaQUANTIDADE: TFloatField;
    cdsRelatorioNotasEntradaTOTAL_PRODUTO: TFloatField;
    cdsRelatorioNotasEntradaVALOR_ICMS: TFloatField;
    cdsRelatorioNotasEntradaVALORST: TFloatField;
    cdsRelatorioNotasEntradaDOCUMENTO_SAIDA: TStringField;
    frxReportJ: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    cdsRelatorioSintetico: TUniClientDataSet;
    frxDBDataset2: TfrxDBDataset;
    cdsRelatorioSinteticoICMS_SAIDA: TFloatField;
    cdsRelatorioSinteticoDIFAL_SAIDA: TFloatField;
    cdsRelatorioSinteticoTOTAL_SAIDA: TFloatField;
    cdsRelatorioSinteticoVLRCON_ENTRADA: TFloatField;
    cdsRelatorioSinteticoICMS_ENTRADA: TFloatField;
    cdsRelatorioSinteticoICMS_ST_ENTRADA: TFloatField;
    cdsRelatorioSinteticoIPI_ENTRADA: TFloatField;
    cdsRelatorioSinteticoTOTAL_ENTRADA: TFloatField;
    cdsRelatorioNotasEntradaVALORIPI: TFloatField;
    cdsRelatorioNotasSaidaDOCUMENTO: TStringField;
    Label3: TLabel;
    edtDocumento: TEditFocus;
    cdsRelatorioNotasEntradaESPECIE_SAIDA: TStringField;
    cdsRelatorioNotasEntradaCLIENTE_SAIDA: TStringField;
    cdsRelatorioNotasEntradaSERIE_SAIDA: TStringField;
    cdsRelatorioNotasSaidaVLR_ICMS: TFloatField;
    cdsRelatorioNotasSaidaVLR_CONTABIL: TFloatField;
    frxDBDataset3: TfrxDBDataset;
    cdsRelatorioNotasSaidaVLR_DIFAL_ORIGEM: TFloatField;
    cdsRelatorioNotasSaidaVLR_DIFAL_DESTINO: TFloatField;
    cdsRelatorioNotasSaidaCFOP: TStringField;
    lblCodCla: TLabel;
    edtCodClaFis: TEditFocus;
    edtDesClaFis: TEditFocus;
    cdsRelatorioNotasSaidaVLR_ICMS_ST: TFloatField;
    cdsRelatorioNotasEntradaAUTOINCREM_VENDA: TStringField;
    cdsRelatorioNotasSaidaDATA_EMISSAO: TDateField;
    cdsRelatorioNotasSaidaCLIENTE: TStringField;
    cdsRelatorioNotasSaidaESTADO: TStringField;
    cdsRelatorioNotasSaidaCODITE: TStringField;
    cdsRelatorioNotasSaidaREFERENCIA: TStringField;
    cdsRelatorioNotasSaidaUNIDADE: TStringField;
    cdsRelatorioNotasSaidaQUANTIDADE: TFloatField;
    cdsRelatorioNotasSaidaAUTOINCREM: TStringField;
    frxDBDataset4: TfrxDBDataset;
    cdsEntradasSemIcms: TUniClientDataSet;
    cdsEntradasSemIcmsDATAENTRADA: TDateField;
    cdsEntradasSemIcmsDATADOCUMENTO: TStringField;
    cdsEntradasSemIcmsDOCUMENTO: TStringField;
    cdsEntradasSemIcmsSERIE: TStringField;
    cdsEntradasSemIcmsFORNECEDOR: TStringField;
    cdsEntradasSemIcmsVALORCONTABIL: TFloatField;
    frxNotasEntradaSemIcms: TfrxReport;
    btnDeletarPeriodo: TBitBtnLocked;
    cdsRelatorioNotasSaidaTABELA: TStringField;
    cdsRelatorioNotasEntradaTABELA_VENDA: TStringField;
    cdsRelatorioNotasEntradaAUTOINCREM_COMPRA: TStringField;
    cdsRelatorioNotasEntradaBASE_ICMS: TFloatField;
    cdsRelatorioNotasEntradaBASE_ST: TFloatField;
    grpOpcoes: TGroupBox;
    Label5: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    chkVerificaItensComprSt: TCheckBox;
    chkValidarNotasEntrada: TCheckBox;
    chkNaoEnviarValorZeradoIcmsSt: TCheckBox;
    chkValidaSaidaForaEstadoDifal: TCheckBox;
    edtValIva: TEditFocus;
    mskCstTrib: TMaskEditFocus;
    chkValidaSaidaForaEstado: TCheckBox;
    chkValidarCompraDentroForaEstado: TCheckBox;
    chkCalcularST: TCheckBox;
    mskDtaLimiteNfCompra: TMaskEditFocus;
    chkUtilizarStNCredX60: TCheckBox;
    cdsRelatorioNotasEntradaACESSO: TStringField;
    chkEnviaCombinacaoCnpjNomeNfEntrada: TCheckBox;
    chkUtilizarNfTransf: TCheckBox;
    edtEmpTransf: TEditFocus;
    Label7: TLabel;
    chkIgnorarNfImp: TCheckBox;
    lblTip_fc: TLabel;
    edtNomFor: TEditFocus;
    edtCodFor: TEditFocus;
    edtAlqSimples: TEditFocus;
    lblAlqSimples: TLabel;
    chkValidarFornecedorSimplesNacional: TCheckBox;
    cdsEntradasSemIcmsHIST_ERRO: TStringField;
    cdsEntradasSemIcmsNIVEL_ERRO: TIntegerField;
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function frxReportJUserFunction(const MethodName: string; var Params: Variant): Variant;
    procedure edtCodClaFisKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClaFisExit(Sender: TObject);
    procedure chkVerificaItensComprStClick(Sender: TObject);
    procedure btnDeletarPeriodoClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
  private
    listaNotasVendidasRessarcidas: TList;
    listaNotasUtilizadas: TList;
    arrClasFiscal: TConsultasArray;
    arrCodEmp: TConsultasArray;
    arrFornec: TConsultasArray;
    qryRelatorio: IZClient;
    strSufixoTabela: string;
    strCodEmp: string;
    strClafis: string;
    fltAliquotaInterEstadual: double;
    fltAliquotaInterna: double;
    fltAlqIntEstadoEmitente: double;
    fltIva: double;
    FAbfIcm: Boolean; // se for true, fazer validação em cima da tabela "ABFICM" se não "CADABF"
    FSenderUnico: TWinControl; //utilizado para setar o campo na exceção das validações

    procedure pCarregaDadosAdicionaisObjCalculoImpostos(obj: IDadosAdicionaisCalculaImpostosCat158; qryAux: TDataSet; fltIVA, fltAlqInterna: double);
    procedure pCarregaDadosObjCalculoImpostos(obj: ICalculaImpostosCat158; qryAux: TDataSet; fltQtdUtilizada: double);
    function fRetObjCalculoImpostos: ICalculaImpostosCat158;

    procedure pCarregaAlqInternaEstadoEmitente;
    function fRetSufixoMovIcd: string;

    procedure pCarregaClientDataSetEntradasSemIcms(qryCompras: TUniQuery);
    function fValidacoesEntradaSemIcms(blnValidacaoSemIcms, blnValidacaoSimplesNacional: boolean): boolean;
    function fValidaNotaSaida(qryDadosEntrada: TUniQuery; strCodIte, strCodEmp, strCfop, strEstadoDestino, strCodCli: string; dtaDataVenda: TDateTime): boolean;

    function fValidaNotaSaidaR(qryDadosEntrada: TUniQuery; strCodIte, strCodEmp, strCfop, strEstadoDestino, strCodCli: string; dtaDataVenda: TDateTime; blnValidacaoSemIcms: Boolean): boolean;
    function fValidaNotaSaidaFornecedoresSimplesNacional(qryDadosEntrada: TUniQuery; strCodIte, strCodEmp, strCfop, strEstadoDestino, strCodCli: string; dtaDataVenda: TDateTime; strSimpau: string; blnValidacaoSimplesNacional: boolean): boolean;

    function fFiltraItemNotasEntradas(strAutoIncremento, strTabela: string): boolean;

    procedure pFormataCamposDataSet;
    procedure pInicializaClient;

    procedure pImprimeDetalhes(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pSomaTotais(var Totais: TTotais; Dados: TDataSet);
    procedure pAbreExcel;

    procedure pCarregaAliquotaAbreviacao(strCodIte, strEstado, strEmpresa: string);
    procedure pCalculaImpostoTintaMaquina(strAutoIncremCompra: string);
    function fRetValorProporcional(fltQuantidade, fltQuantidadeUtilizada, fltValor: Double): Double;

    procedure pRegistraDadosRelatorioImpresso;
    procedure pRegistraCreditoICM;
    procedure pCarregaTotaisSintetico;
    procedure pCarregaDadosEntradaSintetico;
    procedure pCarregaDadosSaidaAnalitico;
    procedure pCarregaDataSetEntrada(objCalculoImpostos: ICalculaImpostosCat158; qryDadosEntrada: TUniQuery; fltQuantidadeUtilizada: Double);
    procedure pCarregaDadosRegC176SpedFiscal(objCalculoImpostos: ICalculaImpostosCat158; qryAux: TUniQuery; fltQuantidadeUtilizada: double);
    procedure pCalculaQuantidadesUtilizadas(qryAux: TUniQuery; var fltSaldoVendido: double);
    function fRetSQLNotasEntradas: string;
    procedure pCarregaDadosTabelaCat158; overload;
    procedure pCarregaDadosEntrada;
    function fRetSQLNotasSaidas: string;
    function fCarregaDados: boolean;

    procedure pCarregaDadosTabelaCat158(stlListaAutoIncrem: TStringList); overload;
    function fVerificaValidacaoNotasEntradaSemIcms: boolean;
    procedure pCarregaDadosObjReImpressao(objReImpressao: TReimpressaoRelRessarcimentoCat158);
    procedure pCarregaLayoutImpressao;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmRessarcImpRetidoPorSujeicaoPassivaSubst: TfrmRessarcImpRetidoPorSujeicaoPassivaSubst;

implementation

uses untModuloSPR, StrUtils, 
     untFuncoes, untFuncoesSimples, untFuncoesConsulta, untConsultas, untFuncoesRelatorios, untZClient;

{$R *.dfm}

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.btnDeletarPeriodoClick(Sender: TObject);
  function fValidaEmpresaInformada(strEmpresa: string): boolean;
    var
      qryAux: TUniQuery;
  begin
    qryAux := fCriaQuery(nil);
    try
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'SELECT COUNT(1) AS QTD FROM CADEMP WHERE EMP_CODEMP = :CODEMP ';
        ParamByName('CODEMP').AsString := strEmpresa;
        Open;

        Result := FieldByName('QTD').AsInteger > 0;
      end;
    finally
      qryAux.Free;
    end;
  end;

  function fValidaPeriodoDigitado(strMesAno: string): boolean;
  begin
    Result := False;
    try
      StrToDate('01/' + strMesAno);
    except
      Result := True;
    end;
  end;

  var
    itemNotaUtilizada: TItemNotaValidacao;
    stlAutoIncremCompra: TStringList;
    intContador: integer;
    strMesAno, strEmpresa: string;
    qryAux: TUniQuery;
begin
  if InputQuery('Aviso', 'Informe um período para exclusão, ex: "MM/YYYY"', strMesAno) then
  begin
    if fValidaPeriodoDigitado(strMesAno) then
    begin
      fMensagem('', 'Período inválido, favor digitar nas normas "MM/YYYY"!', ['&Ok']);
      Exit;
    end;

    if InputQuery('Aviso', 'Informe a empresa para exclusão, ex: "001"', strEmpresa) then
    begin
      if not fValidaEmpresaInformada(strEmpresa) then
      begin
        fMensagem('', 'Código de empresa inválido!', ['&Ok']);
        Exit;
      end;

      btnDeletarPeriodo.Enabled := False;
      btnImprimir.Enabled := False;
      pnlInfo.Caption := 'Deletando dados do período...';
      pnlInfo.Repaint;

      stlAutoIncremCompra := TStringList.Create;
      qryAux := fCriaQuery(nil);
      try
        with qryAux do
        begin
          try
            Close;
            SQL.Clear;
            SQL.Text := 'SELECT * FROM CAT_158_ENTRADA WHERE CAT_MESANO = :MESANO AND CAT_CODEMP = :CODEMP ';
            ParamByName('MESANO').AsString := strMesAno;
            ParamByName('CODEMP').AsString := strEmpresa;
            Open;

            //captura as gravações do periodo para voltar o saldo das quantidades ja utilizadas
            first;
            while not Eof do
            begin
              stlAutoIncremCompra.Add(FieldByName('CAT_INCCOM').AsString);

              Next;
            end;

            pCarregaDadosTabelaCat158(stlAutoIncremCompra);

            first;
            while not Eof do
            begin
              for intContador := 0 to listaNotasUtilizadas.Count - 1 do
              begin
                itemNotaUtilizada := TItemNotaValidacao(listaNotasUtilizadas[intContador]);

                if (itemNotaUtilizada.strSeqGer = qryAux.FieldByName('CAT_INCCOM').AsString) Then
                begin
                  itemNotaUtilizada.fltQuantidadeUtilizada := itemNotaUtilizada.fltQuantidadeUtilizada - qryAux.FieldByName('CAT_QTDITE').AsFloat;
                end;
              end;

              Next;
            end;

            Close;
            SQL.Clear;
            SQL.Add('REPLACE INTO CAT_158( ');
            SQL.Add(' AUTOINCREM, CAT_SEQGER, CAT_QTDUTI, CAT_TOTAL_) ');
            SQL.Add(' VALUES ( ');
            SQL.Add(' :AUTOINCREM, :CAT_SEQGER, :CAT_QTDUTI, :CAT_TOTAL_) ');

            for intContador := 0 to listaNotasUtilizadas.Count - 1 do
            begin
              itemNotaUtilizada := TItemNotaValidacao(listaNotasUtilizadas[intContador]);

              Close;
              ParamByName('AUTOINCREM').AsString := itemNotaUtilizada.strAutoIncrem;
              ParamByName('CAT_SEQGER').AsString := itemNotaUtilizada.strSeqGer;
              ParamByName('CAT_QTDUTI').AsFloat := itemNotaUtilizada.fltQuantidadeUtilizada;
              ParamByName('CAT_TOTAL_').AsFloat := itemNotaUtilizada.fltQuantidadeTotal;
              ExecSQL;
            end;

            Close;
            SQL.Clear;
            SQL.Text := 'DELETE FROM CAT_158_SPED WHERE CAT_MESANO = :MESANO AND CAT_CODEMP = :CODEMP ';
            ParamByName('MESANO').AsString := strMesAno;
            ParamByName('CODEMP').AsString := strEmpresa;
            ExecSQL;

            Close;
            SQL.Clear;
            SQL.Text := 'DELETE FROM CAT_158_ENTRADA WHERE CAT_MESANO = :MESANO AND CAT_CODEMP = :CODEMP ';
            ParamByName('MESANO').AsString := strMesAno;
            ParamByName('CODEMP').AsString := strEmpresa;
            ExecSQL;

            Close;
            SQL.Clear;
            SQL.Text := 'DELETE FROM CAT_158_SAIDAS WHERE CAT_MESANO = :MESANO AND CAT_CODEMP = :CODEMP ';
            ParamByName('MESANO').AsString := strMesAno;
            ParamByName('CODEMP').AsString := strEmpresa;
            ExecSQL;

            fMensagem('AVISO', 'Registros do período deletados com sucesso!', ['OK']);

            btnDeletarPeriodo.Enabled := True;
            btnImprimir.Enabled := True;
            pgbProgresso.Position := 0;
            pnlInfo.Caption := '';
            pnlInfo.Repaint;
          except
            on e: Exception do
            begin
              fMensagem('AVISO', e.Message, ['OK']);
            end;
          end;
        end;
      finally
        stlAutoIncremCompra.Free;
        qryAux.Free;
      end;
    end;
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.btnImprimirClick(Sender: TObject);
  var
    objReImpressao: TReimpressaoRelRessarcimentoCat158;
begin
  inherited;

  objReImpressao := TReimpressaoRelRessarcimentoCat158.Create;
  try
    if blnImprime then
    begin
      btnDeletarPeriodo.Enabled := False;
      btnImprimir.Enabled := False;
      pnlInfo.Caption := 'Carregando Relatório...';
      pnlInfo.Repaint;

      try
        //carregando dados do objeto de reimpressão
        pCarregaDadosObjReImpressao(objReImpressao);

        //Reseta os DataSets de entrada e saida
        pInicializaClient;

        //Função que retorna true se o período solicitado já foi gerado e gravado os ressarcimentos e créditos
        if objReImpressao.fReImpressao then
        begin
          //Carrega o clientDataSet de entrada sintetizado por nota de saida
          pCarregaDadosEntradaSintetico;

          //Carrega os valores totais dos registros de entrada e saída
          pCarregaTotaisSintetico;

          pCarregaLayoutImpressao;
        end
        else if (not fVerificaValidacaoNotasEntradaSemIcms) and (fCarregaDados) then
        begin
          pCarregaLayoutImpressao;

          //Verifica se vai ser gravado no banco as notas fiscais de entradas já utilizadas para crédito
          if fMensagem('ATENÇÃO', 'Confirma a utilização dos créditos do relatório apresentado?',
             ['&Sim', '&Não'], 2) = 1 then
          begin
            pnlInfo.Caption := 'Aguarde, gravando utilização de créditos...';
            Application.ProcessMessages;

            //registra as tabelas CAT_158 e CAT_158_SPED
            pRegistraCreditoICM;

            //registra as tabelas CAT_158_ENTRADA e CAT_158_SAIDAS
            pRegistraDadosRelatorioImpresso;

            fMensagem('Aviso', 'Dados gravados com sucesso!', ['OK']);
          end;
        end
        else
          pTabelaVazia;

        btnDeletarPeriodo.Enabled := True;
        btnImprimir.Enabled := True;
        pgbProgresso.Position := 0;
        pnlInfo.Caption := '';
        pnlInfo.Repaint;
      except
        on e: Exception do
        begin
          fMensagem('Aviso', e.Message, ['OK']);
          btnDeletarPeriodo.Enabled := True;
          btnImprimir.Enabled := True;
          pgbProgresso.Position := 0;
          pSetFocus(FSenderUnico);
          pnlInfo.Caption := '';
          pnlInfo.Repaint;
        end;
      end;
    end;
  finally
    objReImpressao.Free;
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.chkVerificaItensComprStClick(Sender: TObject);
begin
  inherited;
  mskCstTrib.Enabled := chkVerificaItensComprSt.Checked;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.edtCodClaFisExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodClaFis, edtDesClaFis, arrClasFiscal, fRetNatOpe, Nil, 'da Classificação Fiscal');
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.edtCodClaFisKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CFOP       *}
  {****************************RV*}
  if fPesqCFOP(Self, edtCodClaFis, edtDesClaFis, nil, Key, arrClasFiscal, False) then
  begin
    if fValidaCampos(edtCodClaFis, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp,edtNomEmp,arrCodEmp,fRetNomeEmpresa,nil,'da Empresa');
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************CI*}
  if fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, nil, Key, arrCodEmp, True, True) then
  begin
    if fValidaCampos(edtCodEmp,True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.edtCodForExit(
  Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor,edtNomFor,arrFornec,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.edtCodForKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.fCarregaDados: boolean;
begin
  with qryRelatorio.qryQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Text := fRetSQLNotasSaidas;

    ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);

    if not fEmptyStr(edtCodEmp.Text) then
      pSetaParam(edtCodEmp.Text, arrCodEmp, strCodEmp, 'CODEMP', qryRelatorio.qryQuery);

    ParamByName('CLAVEN').AsString := VS_strClaVen;
    ParamByName('TIP_FC').AsString := 'C';

    if not fEmptyStr(edtDocumento.Text) then
      ParamByName('NUMDOC').AsString := Trim(edtDocumento.Text);

    if not fEmptyStr(edtCodClaFis.Text) then
      pSetaParam(edtCodClaFis.Text, arrClasFiscal, strClafis, 'CLAFIS', qryRelatorio.qryQuery);

    qryRelatorio.fAbreClient(True, 'pAbreConsulta');
  end;

  pFormataCamposDataSet;

  //Carrega as notas de entrada referente as saídas
  pCarregaDadosEntrada;

  //Carrega o clientDataSet de saida sintetizado por nota e não por produto
  pCarregaDadosSaidaAnalitico;

  //Carrega o clientDataSet de entrada sintetizado por nota de saida
  pCarregaDadosEntradaSintetico;

  //Carrega os valores totais dos registros de entrada e saída
  pCarregaTotaisSintetico;

  Result := (cdsRelatorioNotasSaida.RecordCount > 0) and (cdsRelatorioNotasEntrada.RecordCount > 0);
end;

function TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.fFiltraItemNotasEntradas(strAutoIncremento, strTabela: string): boolean;
begin
  Result := True;

  cdsRelatorioNotasEntrada.Filtered := False;
  cdsRelatorioNotasEntrada.Filter := '';
  cdsRelatorioNotasEntrada.Filter := 'AUTOINCREM_VENDA = ' + QuotedStr(strAutoIncremento) + 'AND TABELA_VENDA = ' + QuotedStr(strTabela);
  cdsRelatorioNotasEntrada.Filtered := True;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.FormCreate(Sender: TObject);
begin
  inherited;
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  blnExcel := True;

  if fTabelaExiste('ABFICM', True) then
    FAbfIcm := True
  else
    FAbfIcm := False;

  strSufixoTabela := fRetSufixoMovIcd;

  listaNotasUtilizadas := TList.Create;
  listaNotasVendidasRessarcidas := TList.Create;

  cdsRelatorioNotasEntrada.CreateDataSet;
  cdsRelatorioNotasSaida.CreateDataSet;
  cdsRelatorioSintetico.CreateDataSet;
  cdsEntradasSemIcms.CreateDataSet;

  qryRelatorio := untZClient.TZClient.Create(Self);
  frxRelatorio.DataSet := qryRelatorio.qryQuery;

  frxReportJ.AddFunction('function fFiltraItemNotasEntradas(strAutoIncremento, strTabela: String): Boolean');

  pCarregaAlqInternaEstadoEmitente;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.FormDestroy(Sender: TObject);
begin
  listaNotasUtilizadas.Clear;
  listaNotasUtilizadas.Free;

  listaNotasVendidasRessarcidas.Clear;
  listaNotasVendidasRessarcidas.Free;

  inherited;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
  edtValIva.Enabled := fCfgSis('X60CAT') = 'S';
  chkCalcularST.Enabled := edtValIva.Enabled;
end;

function TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.fRetObjCalculoImpostos: ICalculaImpostosCat158;
begin
  if chkCalcularST.Checked then
    Result := TCalculaImpostosIVA.Create
  else if fCfgSis('X60CAT') = 'S' then
    Result := TCalculaImpostosCfgX60.Create
  else
    Result := TCalculaImpostos.Create;
end;

function TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.fRetSQLNotasEntradas: string;
  function fRetCalcFornSimplesBaseIcms: string;
  begin
    if fCfgSis('CAT158') = '0' then
      result := ' IF( ROUND(COALESCE(TRI.DET_BCI158, 0) / D.DET_QTDITE, 2) > 0, '+
                      'ROUND(COALESCE(TRI.DET_BCI158, 0) / D.DET_QTDITE, 2),    '+
                      'ROUND((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE, 2)   '+ //CASO A LINHA ACIMA RETORNE ZERO
                '   ) '
    else
      result := ' ROUND((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE, 2) ';
  end;

  function fRetCalcFornSimplesAlqIcms: string;
  begin
    if fCfgSis('CAT158') = '0' then
    begin
      result := ' IF( IF((DLE.N24_CREDSN > 0 AND DLE.N24_CREDICMSSN > 0), DLE.N24_CREDSN, TRI.DET_ALI158) > 0, '+
                '     IF((DLE.N24_CREDSN > 0 AND DLE.N24_CREDICMSSN > 0), DLE.N24_CREDSN, TRI.DET_ALI158),     '+
                '     ' + AnsiReplaceStr(FormatFloat('0.00',StrToFloatDef(edtAlqSimples.text, 0)), ',', '.') +
                '   )';
    end
    else
      result := FloatToStr(fltAlqIntEstadoEmitente);
  end;

  function fRetFornSimplesAlqIcms: string;
  begin
    if fCfgSis('CAT158') = '0' then
    begin
      result := ' DLE.N24_CREDSN AS CREDSN, ';
    end
    else
      result := ' 0 AS CREDSN, ';
  end;

  function fRetCalcFornSimplesValorIcms: string;
  begin
    if fCfgSis('CAT158') = '0' then
    begin
      result := 'IF( ROUND(COALESCE(DLE.N24_CREDICMSSN, TRI.DET_VLI158, 0) / D.DET_QTDITE, 3) > 0, '+
                '    ROUND(COALESCE(DLE.N24_CREDICMSSN, TRI.DET_VLI158, 0) / D.DET_QTDITE, 3),     '+
                '    ROUND((((D.DET_TOTITE - D.DET_DESESP) * ' + AnsiReplaceStr(FormatFloat('#0.00',StrToFloatDef(edtAlqSimples.text, 0)), ',', '.') + ') / 100) / D.DET_QTDITE, 3) '+
                '  )';
    end
    else
      result := '  ROUND((((D.DET_TOTITE - D.DET_DESESP) * ' + FloatToStr(fltAlqIntEstadoEmitente) + ') / 100) / D.DET_QTDITE, 3) ';
  end;

  function fRetFornSimplesValorIcms: string;
  begin
    if fCfgSis('CAT158') = '0' then
    begin
      result := ' DLE.N24_CREDICMSSN AS CREDICMSSN, ';
    end
    else
      result := ' 0 AS CREDICMSSN, ';
  end;

  function fRetCalcFornSimplesValorIcmsTotal: string;
  begin
    if fCfgSis('CAT158') = '0' then
      result := ' IF( COALESCE(DLE.N24_CREDICMSSN, TRI.DET_VLI158, 0) > 0, '+
                '     COALESCE(DLE.N24_CREDICMSSN, TRI.DET_VLI158, 0),     '+
                '     ROUND(((D.DET_TOTITE - D.DET_DESESP) * ' + AnsiReplaceStr(FormatFloat('0.00',StrToFloatDef(edtAlqSimples.text, 0)), ',', '.') + ') / 100, 2) '+
                '   ) '
    else
      result := ' ROUND(((D.DET_TOTITE - D.DET_DESESP) * ' + FloatToStr(fltAlqIntEstadoEmitente) + ') / 100, 2) ';
  end;

  //quando o mesmo não informar no livro a BASE e ST(DET_BCR158 e DET_VLR158), e marcar o check box "chkUtilizarStNCredX60" deve ser enviado a ST N CRED
  function fRetBaseStNCred: string;
  begin
    if chkUtilizarStNCredX60.checked then
      result := ' TRI.DET_BAERET '
    else
      result := '0';
  end;

  function fRetBaseStNCred158: string;
  begin
    if chkUtilizarStNCredX60.checked then
      result := ' TRI.DET_BCR158 '
    else
      result := '0';
  end;

  //quando o mesmo não informar no livro a BASE e ST(DET_BCR158 e DET_VLR158), e marcar o check box "chkUtilizarStNCredX60" deve ser enviado a ST N CRED
  function fRetValorStNCred: string;
  begin
    if chkUtilizarStNCredX60.checked then
      result := ' TRI.DET_VAERET '
    else
      result := '0';
  end;

  function fRetValorStNCred158: string;
  begin
    if chkUtilizarStNCredX60.checked then
      result := ' TRI.DET_VLR158 '
    else
      result := '0';
  end;

  function fRetBaseTotalGare: string;
  begin
    Result := ' (D.DET_TOTITE + (D.DET_VALIPI + IFNULL(TRI.DET_VAEIPI, 0)) - D.DET_DESESP) * ABF_IVA_ST_ENT_PEJ ';
  end;

  function fRetAlqGare: string;
  begin
    Result := ' ABF_ALQRET_ENT_PEJ ';
  end;

  function fRetValorTotalGare: string;
  begin
    Result := ' TRI.DET_VLGNRE ';
  end;

  function fRetFiltroFornecedor: string;
    var
      intContador: integer;
      strCodFor: string;
  begin
    strCodFor := '';

    Result := '';

    if Length(arrFornec) > 0 then
    begin
      for intContador := Low(arrFornec) to High(arrFornec) do
      begin
        strCodFor := strCodFor + arrFornec[intContador].strCodigo + '_';
      end;

      Result := ' AND LOCATE(FOR_CODFOR, ' + QuotedStr(strCodFor) + ') > 0 ';
    end;
  end;

  var
    strSQL: string;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  IFNULL(FOR_SIMPAU, "N") AS FOR_SIMPAU, ';
  strSQL := strSQL + '  FOR_SIMPAU AS SIMPAU, '
                   + fRetFornSimplesAlqIcms
                   + fRetFornSimplesValorIcms;
  strSQL := strSQL + '  DLE.N15_VBC, ';
  strSQL := strSQL + '  DLE.N17_VICMS, ';
  strSQL := strSQL + '  DLE.N21_VBCST, ';
  strSQL := strSQL + '  DLE.N23_VICMSST, ';
  strSQL := strSQL + '  D.AUTOINCREM AS AUTOINCREM, ';
  strSQL := strSQL + '  D.DET_DTAENT, ';
  strSQL := strSQL + '  D.DET_DTADOC, ';
  strSQL := strSQL + '  D.DET_VLRCON, ';
  strSQL := strSQL + '  D.DET_HORENT, ';
  strSQL := strSQL + '  D.DET_CODEMP, ';
  strSQL := strSQL + '  D.DET_NUMDOC, ';
  strSQL := strSQL + '  D.DET_ESPDOC, ';
  strSQL := strSQL + '  D.DET_SERIE_, ';
  strSQL := strSQL + '  D.DET_CODITE, ';
  strSQL := strSQL + '  D.DET_QTDITE, ';
  strSQL := strSQL + '  IFNULL(D.DET_UNITAR, 0) AS UNITAR, ';
  strSQL := strSQL + '  IF(LOCATE(RIGHT(D.DET_CODFIS, 2), "10_30_70_60") > 0 AND LOCATE(LEFT(D.DET_CLAFIS, 1), "1_2") > 0, IF((IFNULL(FOR_SIMPAU, "N") = "S" OR (N24_CREDICMSSN > 0 AND N24_CREDSN > 0)), 1, 0), 0) AS REGRA_CST_CFOP, ';

  if fCfgSis('X60CAT') = 'S' then
  begin
    strSQL := strSQL + '  ROUND(IF(RIGHT(D.DET_CODFIS, 2) = "60", IF(IFNULL(TRI.DET_BCR158,0) > 0, ' + fRetBaseStNCred158 + ', IF(IFNULL(TRI.DET_VLGNRE,0) > 0, ' + fRetBaseTotalGare + ',' + fRetBaseStNCred + ')), ';
    strSQL := strSQL + '  (IFNULL(D.DET_BASRET, 0) + IFNULL(TRI.DET_BAERET, 0) + IF(IFNULL(TRI.DET_VLGNRE,0) > 0, ' + fRetBaseTotalGare + ',0) )) / IFNULL(D.DET_QTDITE, 0), 4) AS ST_UNITAR, ';
  end
  else
    strSQL := strSQL + '  (IFNULL(D.DET_BASRET, 0) + IFNULL(TRI.DET_BAERET, 0) + IF(IFNULL(TRI.DET_VLGNRE,0) > 0, ' + fRetBaseTotalGare + ',0)) / IFNULL(D.DET_QTDITE, 0) AS ST_UNITAR, ';

  // CASO NÃO TENHA VALOR DE ST, FAZER OS CÁCULOS EM CIMA DO TOTAL DO PRODUTO E DA ALÍQUOTA INTERNA DO ESTADO
  //# 000 - BASE_ICM_UNITAR *******************************************************
  strSQL := strSQL + '  IF(ROUND(IFNULL(D.DET_BASRET, 0) + IFNULL(TRI.DET_BAERET, 0), 2) > 0, ';
  strSQL := strSQL + '  IF(IFNULL(FOR_SIMPAU,"N") <> "S", IF( ';
  strSQL := strSQL + '  IF(N14_PREDBC > 0, IF((D.DET_TOTITE - D.DET_DESESP) = DLE.N15_VBC ';
  strSQL := strSQL + '  , ROUND(DLE.N15_VBC - (DLE.N15_VBC * (DLE.N14_PREDBC / 100)), 2), DLE.N15_VBC) ';
  strSQL := strSQL + '  , ROUND(DLE.N15_VBC / D.DET_QTDITE, 2)) > 0, ' ;
  strSQL := strSQL + '  IF(N14_PREDBC > 0, IF((D.DET_TOTITE - D.DET_DESESP) = DLE.N15_VBC ';
  strSQL := strSQL + '  , ROUND(DLE.N15_VBC - (DLE.N15_VBC * (DLE.N14_PREDBC / 100)), 2), DLE.N15_VBC) ';
  strSQL := strSQL + '  , ROUND(DLE.N15_VBC / D.DET_QTDITE, 2)), ' + fRetCalcFornSimplesBaseIcms + '), ' + fRetCalcFornSimplesBaseIcms + '), ';
  strSQL := strSQL + '  ROUND((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE, 2)) AS BASE_ICM_UNITAR, ';
  //# FIM BASE_ICM_UNITAR ********************************************************************************************************************************

  //# 001 - DET_ALQICM ************************************************************
  strSQL := strSQL + '  IF(ROUND(IFNULL(D.DET_BASRET, 0) + IFNULL(TRI.DET_BAERET, 0), 2) > 0, ';
  strSQL := strSQL + '  IF(IFNULL(FOR_SIMPAU,"N") <> "S", IF(DLE.N16_PICMS > 0, DLE.N16_PICMS, IF((DLE.N24_CREDSN > 0 ';
  strSQL := strSQL + '  AND DLE.N24_CREDICMSSN > 0), N24_CREDSN, '
                   + FloatToStr(fltAlqIntEstadoEmitente) + ' )), ' + fRetCalcFornSimplesAlqIcms + '), ';
  strSQL := strSQL + ' IF(LOCATE(LEFT(D.DET_CLAFIS, 1), "1_2") > 0, IF(DLE.N16_PICMS > 0, DLE.N16_PICMS, ';
  strSQL := strSQL + ' IF((DLE.N24_CREDSN > 0 AND DLE.N24_CREDICMSSN > 0), DLE.N24_CREDSN, IF(ABF_ALQICM_ENT_PEJ > 0, ';
  strSQL := strSQL + ' ABF_ALQICM_ENT_PEJ, '
                   + FloatToStr(fltAlqIntEstadoEmitente) + ' ))), ' + FloatToStr(fltAlqIntEstadoEmitente) + ') ';
  strSQL := strSQL + ' ) AS DET_ALQICM, ';
  //# FIM DET_ALQICM ************************************************************************************************************************************

  //# 002 - VALOR_ICM_UNITAR ******************************************************
  strSQL := strSQL + '  IF(ROUND(IFNULL(D.DET_BASRET, 0) + IFNULL(TRI.DET_BAERET, 0), 3) > 0, ';
  strSQL := strSQL + '  IF(IFNULL(FOR_SIMPAU,"N") <> "S", IF(ROUND(IF(DLE.N17_VICMS > 0, ';
  strSQL := strSQL + '  DLE.N17_VICMS, N24_CREDICMSSN) / D.DET_QTDITE, 3) > 0, ';
  strSQL := strSQL + '  ROUND(IF(((DLE.N15_VBC > DLE.N21_VBCST) AND (DLE.N21_VBCST > 0)), ';

  if fCfgSis('X60CAT') = 'S' then
  begin
    strSQL := strSQL + '  ROUND((IF(RIGHT(D.DET_CODFIS, 2) = "60", IF(IFNULL(TRI.DET_BCR158,0) > 0, '
                     + fRetBaseStNCred158 + ', ';
    strSQL := strSQL + '  IF(IFNULL(TRI.DET_VLGNRE,0) > 0, '
                     + fRetBaseTotalGare + ',' + fRetBaseStNCred + ')), ';
    strSQL := strSQL + '  (IFNULL(D.DET_BASRET, 0) + IFNULL(TRI.DET_BAERET, 0) + IF(IFNULL(TRI.DET_VLGNRE,0) > 0, '
                     + fRetBaseTotalGare + ',0)) ';
    strSQL := strSQL + '  ) / IFNULL(D.DET_QTDITE, 0) * IF(DLE.N16_PICMS > 0, DLE.N16_PICMS, N24_CREDSN) / 100), 3) ';
  end
  else
  begin
    strSQL := strSQL + '  ((IFNULL(D.DET_BASRET, 0) + IFNULL(TRI.DET_BAERET, 0) + IF(IFNULL(TRI.DET_VLGNRE,0) > 0, '
                     + fRetBaseTotalGare + ',0) ';
    strSQL := strSQL + '  ) / IFNULL(D.DET_QTDITE, 0) * IF(DLE.N16_PICMS > 0, DLE.N16_PICMS, N24_CREDSN) / 100) ';
  end;

  strSQL := strSQL + '  ,IF(DLE.N17_VICMS > 0, DLE.N17_VICMS, N24_CREDICMSSN) / D.DET_QTDITE), 3), '
                   + fRetCalcFornSimplesValorIcms + ' ), '
                   + fRetCalcFornSimplesValorIcms + '), ';
  strSQL := strSQL + '  ROUND((((D.DET_TOTITE - D.DET_DESESP) * IF(LOCATE(LEFT(D.DET_CLAFIS, 1), "1_2") > 0, IF(DLE.N16_PICMS > 0, ';
  strSQL := strSQL + '  DLE.N16_PICMS, IF((DLE.N24_CREDSN > 0 AND DLE.N24_CREDICMSSN > 0), DLE.N24_CREDSN, IF(ABF_ALQICM_ENT_PEJ > 0, ABF_ALQICM_ENT_PEJ, '
                   + FloatToStr(fltAlqIntEstadoEmitente) + ' ))), ' + FloatToStr(fltAlqIntEstadoEmitente) + ') ';
  strSQL := strSQL + '  ) / 100) / D.DET_QTDITE, 3)) AS VALOR_ICM_UNITAR, ';
  //# FIM VALOR_ICM_UNITAR*******************************************************************************************************************************

  //# 003 - ICMS_ENTRADA **********************************************************
  strSQL := strSQL + '  IF(ROUND(IFNULL(D.DET_BASRET, 0) + IFNULL(TRI.DET_BAERET, 0), 2) > 0, ';
  strSQL := strSQL + '  IF(IFNULL(FOR_SIMPAU,"N") <> "S", IF(DLE.N17_VICMS > 0, DLE.N17_VICMS, IF(N24_CREDICMSSN > 0, N24_CREDICMSSN, '
                   + fRetCalcFornSimplesValorIcmsTotal + ' )), ' + fRetCalcFornSimplesValorIcmsTotal + '), ';
  strSQL := strSQL + '  ROUND(((D.DET_TOTITE - D.DET_DESESP) * IF(LOCATE(LEFT(D.DET_CLAFIS, 1), "1_2") > 0, ';
  strSQL := strSQL + '  IF(DLE.N16_PICMS > 0, DLE.N16_PICMS, IF((DLE.N24_CREDSN > 0 AND DLE.N24_CREDICMSSN > 0), DLE.N24_CREDSN ' ;
  strSQL := strSQL + '  ,IF(ABF_ALQICM_ENT_PEJ > 0, ABF_ALQICM_ENT_PEJ, '
                   + FloatToStr(fltAlqIntEstadoEmitente) + ' ))';
  strSQL := strSQL + '  ), ' + FloatToStr(fltAlqIntEstadoEmitente) + ')) / 100, 2)) AS ICMS_ENTRADA, ';
  //# FIM ICMS_ENTRADA **********************************************************************************************************************************

  strSQL := strSQL + '  IFNULL(D.DET_CODFOR, "") AS CODFOR, ';
  strSQL := strSQL + '  IF((FIS_ESPDOC = "NF") AND (IFNULL(FIS_ACESSO,"") = "") , "01", ';
  strSQL := strSQL + '  IF(((FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(FIS_ACESSO,"") <> "") ) OR ';
  strSQL := strSQL + '  (FIS_ESPDOC = "EL"), "55", ';
  strSQL := strSQL + '  IF(FIS_ESPDOC IN ("IF", "IV"), IF(IFNULL(FIS_ACESSO,"")= "", "2D", "65"), "01"))) AS FIS_DOCMOD, ';
  strSQL := strSQL + '  IFNULL(FIS_ACESSO, "") AS CHAVE_ACESSO, ';
  strSQL := strSQL + '  (D.DET_TOTITE - D.DET_DESESP) AS VALOR_PRODUTO, ';

  strSQL := strSQL + '  IF(';

  if fCfgSis('X60CAT') = 'S' then
  begin
    strSQL := strSQL + '  IF(RIGHT(D.DET_CODFIS, 2) = "60", IF(IFNULL(TRI.DET_VLR158,0) > 0, ' + fRetValorStNCred158 + ', IF(IFNULL(TRI.DET_VLGNRE,0) > 0, ' + fRetValorTotalGare + ',' + fRetValorStNCred + ')), ';
    strSQL := strSQL + '  ROUND(D.DET_VALRET + IFNULL(TRI.DET_VAERET, 0) + ' + fRetValorTotalGare + ', 2)) > 0 ';
  end
  else
    strSQL := strSQL + '  IFNULL(D.DET_VALRET, 0) + IFNULL(TRI.DET_VAERET, 0) + IFNULL(' + fRetValorTotalGare + ', 0) > 0 ';

  strSQL := strSQL + '  ,IF(FOR_SIMPAU IN ("R", "P") AND (DLE.N24_CREDSN + DLE.N24_CREDICMSSN > 0), ';
  strsql := strSQL + '  IF(FOR_SIMPAU = "P", 1,2), IF(' ;
  strSQL := strSQL + '  (RIGHT(D.DET_CODFIS, 2) NOT IN ("10", "30", "70", "60")) AND ( ';

  if fCfgSis('X60CAT') = 'S' then
  begin
    strSQL := strSQL + '  IF(RIGHT(D.DET_CODFIS, 2) = "60", IF(IFNULL(TRI.DET_VLR158,0) > 0, ' + fRetValorStNCred158 + ', IF(IFNULL(TRI.DET_VLGNRE,0) > 0, ' + fRetValorTotalGare + ',' + fRetValorStNCred + ')), ';
    strSQL := strSQL + '  ROUND(D.DET_VALRET + IFNULL(TRI.DET_VAERET, 0) + ' + fRetValorTotalGare + ', 2))) > 0 ';
  end
  else
    strSQL := strSQL + '  IFNULL(D.DET_VALRET, 0) + IFNULL(TRI.DET_VAERET, 0) + IFNULL(' + fRetValorTotalGare + ', 0)) > 0 ';

  strSQL := strSQL + ' ,4,0)), 3) AS NIVEL_ERRO, ';

  strSQL := strSQL + '  IF(';

  if fCfgSis('X60CAT') = 'S' then
  begin
    strSQL := strSQL + '  IF(RIGHT(D.DET_CODFIS, 2) = "60", IF(IFNULL(TRI.DET_VLR158,0) > 0, ' + fRetValorStNCred158 + ', IF(IFNULL(TRI.DET_VLGNRE,0) > 0, ' + fRetValorTotalGare + ',' + fRetValorStNCred + ')), ';
    strSQL := strSQL + '  ROUND(D.DET_VALRET + IFNULL(TRI.DET_VAERET, 0) + ' + fRetValorTotalGare + ', 2)) > 0 ';
  end
  else
    strSQL := strSQL + '  IFNULL(D.DET_VALRET, 0) + IFNULL(TRI.DET_VAERET, 0) + IFNULL(' + fRetValorTotalGare + ', 0) > 0 ';

  strSQL := strSQL + '  ,IF(FOR_SIMPAU IN ("R", "P") AND (DLE.N24_CREDSN + DLE.N24_CREDICMSSN > 0), ';
  strSQL := strSQL + '  IF(FOR_SIMPAU = "P", "Forn Simples c/ Créd ICMS e Reg Trib L. Presumido", ';
  strSQL := strSQL + '  "Forn Simples c/ Créd ICMS e Reg Trib L. Real"), IF(';
  strSQL := strSQL + '  (RIGHT(D.DET_CODFIS, 2) NOT IN ("10", "30", "70", "60")) AND ( ';

  if fCfgSis('X60CAT') = 'S' then
  begin
    strSQL := strSQL + '  IF(RIGHT(D.DET_CODFIS, 2) = "60", IF(IFNULL(TRI.DET_VLR158,0) > 0, ' + fRetValorStNCred158 + ', IF(IFNULL(TRI.DET_VLGNRE,0) > 0, ' + fRetValorTotalGare + ',' + fRetValorStNCred + ')), ';
    strSQL := strSQL + '  ROUND(D.DET_VALRET + IFNULL(TRI.DET_VAERET, 0) + ' + fRetValorTotalGare + ', 2))) > 0 ';
  end
  else
    strSQL := strSQL + '  IFNULL(D.DET_VALRET, 0) + IFNULL(TRI.DET_VAERET, 0) + IFNULL(' + fRetValorTotalGare + ', 0)) > 0 ';

  strSQL := strSQL + '   , "Notas Fiscais c/ CST diferente de x10,x30,x60, x70" ';
  strSQL := strSQL + '   , "Forn Simples s/ Crédito ICMS")), "Notas Fiscais s/ Subst. Tributária") AS HIST_ERRO, ';

  if chkEnviaCombinacaoCnpjNomeNfEntrada.Checked then
    strSQL := strSQL + '  CONCAT(FOR_C_G_C_, " - " , FOR_NOMFOR) AS FORNECEDOR, '
  else
    strSQL := strSQL + '  CONCAT(FOR_CODFOR, " - " , FOR_NOMFOR) AS FORNECEDOR, ';

  if fCfgSis('X60CAT') = 'S' then
  begin
    strSQL := strSQL + '  IF(RIGHT(D.DET_CODFIS, 2) = "60", IF(IFNULL(TRI.DET_BCR158,0) > 0, ' + fRetBaseStNCred158 + ', IF(IFNULL(TRI.DET_VLGNRE,0) > 0, ' + fRetBaseTotalGare + ',' + fRetBaseStNCred + ')), ';
    strSQL := strSQL + '  ROUND(IFNULL(D.DET_BASRET, 0) + IFNULL(TRI.DET_BAERET, 0) + IF(IFNULL(TRI.DET_VLGNRE,0) > 0, ' + fRetBaseTotalGare + ',0), 2)) AS BASE_ICMS_ST_ENTRADA, ';
  end
  else
    strSQL := strSQL + '  IFNULL(D.DET_BASRET, 0) + IFNULL(TRI.DET_BAERET, 0) + IF(IFNULL(TRI.DET_VLGNRE,0) > 0, ' + fRetBaseTotalGare + ',0) AS BASE_ICMS_ST_ENTRADA, ';


  //# Os campos 'D.DET_ALQRET' e 'TRI.DET_ALERET' são usados para o custo
  //# strSQL := strSQL + '  IF(IFNULL(D.DET_ALQRET, 0) > 0, D.DET_ALQRET, IF(IFNULL(TRI.DET_ALERET, 0) > 0, TRI.DET_ALERET, ' + fRetAlqGare + ')) AS ALQ_ICMS_ST_ENTRADA, ';
  strSQL := strSQL + '  IF(IFNULL(DLE.N22_PICMSST, 0) > 0, DLE.N22_PICMSST, IF(IFNULL(' + fRetAlqGare + ', 0) > 0, ' + fRetAlqGare + ', ' + FloatToStr(fltAlqIntEstadoEmitente) + ')) AS ALQ_ICMS_ST_ENTRADA, ';

  if fCfgSis('X60CAT') = 'S' then
  begin
    strSQL := strSQL + '  IF(RIGHT(D.DET_CODFIS, 2) = "60", IF(IFNULL(TRI.DET_VLR158,0) > 0, ' + fRetValorStNCred158 + ', IF(IFNULL(TRI.DET_VLGNRE,0) > 0, ' + fRetValorTotalGare + ',' + fRetValorStNCred + ')), ';
    strSQL := strSQL + '  ROUND(D.DET_VALRET + IFNULL(TRI.DET_VAERET, 0) + ' + fRetValorTotalGare + ', 2)) AS ICMS_ST_ENTRADA, ';
  end
  else
    strSQL := strSQL + '  IFNULL(D.DET_VALRET, 0) + IFNULL(TRI.DET_VAERET, 0) + IFNULL(' + fRetValorTotalGare + ', 0) AS ICMS_ST_ENTRADA, ';

  strSQL := strSQL + '  ROUND(D.DET_VALIPI + IFNULL(TRI.DET_VAEIPI, 0), 2) AS IPI_ENTRADA, ';
  strSQL := strSQL + '  CONCAT(D.DET_NUMDOC, " - ", D.DET_ESPDOC, " - ", D.DET_CODEMP) AS DOCUMENTO, ';
  strSQL := strSQL + '  IF(IFNULL(FOR_SIMPAU,"N") <> "S", D.DET_VALICM, 0) AS DET_VALICM, ';
  strSQL := strSQL + '  IF(IFNULL(FOR_SIMPAU,"N") <> "S", D.DET_BASICM, 0) AS DET_BASICM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET D ';

  strSQL := strSQL + '  INNER JOIN CADFIS ';
  strSQL := strSQL + '    ON FIS_NUMDOC = D.DET_NUMDOC ';
  strSQL := strSQL + '    AND FIS_ESPDOC = D.DET_ESPDOC ';
  strSQL := strSQL + '    AND FIS_CODEMP = D.DET_CODEMP ';
  strSQL := strSQL + '    AND IFNULL(FIS_SERIE_, "") = IFNULL(D.DET_SERIE_, "") ';
  strSQL := strSQL + '    AND FIS_FORCLI = D.DET_CODFOR ';
  strSQL := strSQL + '    AND FIS_TIP_FC = D.DET_TIP_FC ';

  strSQL := strSQL + '  LEFT JOIN MOVTRI TRI ';
  strSQL := strSQL + '   ON TRI.DET_SEQGER = D.AUTOINCREM ';

  strSQL := strSQL + '  LEFT JOIN CADFOR ';
  strSQL := strSQL + '   ON FOR_CODFOR = IFNULL(D.DET_CODFOR, "") ';

  strSQL := strSQL + '  LEFT JOIN CADCID ';
  strSQL := strSQL + '   ON CID_CODCID = FOR_CODCID ';

  strSQL := strSQL + '  LEFT JOIN GERELE GLE ';
  strSQL := strSQL + '   ON GLE.B08_NNF = FIS_NUMDOC ';
  strSQL := strSQL + '   AND IFNULL(GLE.B07_SERIE, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND GLE.GER_CODFOR = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN DETELE DLE ';
  strSQL := strSQL + '   ON DLE.DET_SEQGER = GLE.AUTOINCREM ';
  strSQL := strSQL + '   AND DLE.DET_CODITE = D.DET_CODITE ';

  strSQL := strSQL + '  LEFT JOIN ITEGER GER ';
  strSQL := strSQL + '   ON GER.ITE_CODITE = D.DET_CODITE ';
  strSQL := strSQL + '   AND GER.ITE_CODEMP = :CODEMP ';

  strSQL := strSQL + '  LEFT JOIN CADITE ITE ';
  strSQL := strSQL + '   ON ITE.ITE_CODITE = D.DET_CODITE ';

  if FAbfIcm then
    strSQL := strSQL + '  LEFT JOIN ABFICM '
  else
    strSQL := strSQL + '  LEFT JOIN CADABF ';

  if fCfgSis('TIPABF') = '1' then
    strSQL := strSQL + '  ON ABF_CODABF = ITE.ITE_CODABF '
  else
    strSQL := strSQL + '  ON ABF_CODABF = GER.ITE_CODABF ';

  strSQL := strSQL + '  AND ABF_ESTADO = CID_ESTADO ';

  strSQL := strSQL + '  LEFT JOIN CAT_158 ';
  strSQL := strSQL + '   ON CAT_SEQGER = D.AUTOINCREM ';

  strSQL := strSQL + 'WHERE D.DET_DTAENT <= :DTAREF ';
  strSQL := strSQL + '  AND D.DET_CODITE = :CODITE ';

  //FILTRO DE NOTAS FISCAIS DE COMPRA COM ST OU CST 060 + CFOP DENTRO DO ESTADO
  if chkValidarCompraDentroForaEstado.Checked then
    strSQL := strSQL + '  AND ((IFNULL(D.DET_VALRET, 0) + IFNULL(TRI.DET_VAERET, 0) + ' + fRetValorTotalGare + ' > 0) OR (RIGHT(D.DET_CODFIS, 2) = "60")) '
  else
  begin
    //# strSQL := strSQL + '  AND ((IFNULL(D.DET_VALRET, 0) + IFNULL(TRI.DET_VAERET, 0) + ' + fRetValorTotalGare + ' > 0) OR (RIGHT(D.DET_CODFIS, 2) = "60" AND LEFT(D.DET_CLAFIS, 1) = "1")) ';
    strSQL := strSQL + '  AND ((IFNULL(D.DET_VALRET, 0) + IFNULL(TRI.DET_VAERET, 0) + ' + fRetValorTotalGare + ' > 0) OR (LOCATE(RIGHT(D.DET_CODFIS, 2), "10_30_70_60") > 0 AND LOCATE(LEFT(D.DET_CLAFIS, 1), "1_2") > 0)) ';
  end;


  strSQL := strSQL + ' AND LOCATE(D.DET_CODEMP, :CODEMP) > 0 ';

  //adiciona o filtro de notas de transferência(1152, 1409)
  if chkUtilizarNfTransf.Checked then
    strSQL := strSQL + '  AND ((LOCATE(D.DET_CLAFIS, :CLACOM) > 0) OR (LOCATE(D.DET_CLAFIS, "1152_1409") > 0)) '
  else
    strSQL := strSQL + '  AND LOCATE(D.DET_CLAFIS, :CLACOM) > 0 ';

  if chkIgnorarNfImp.Checked then
    strSQL := strSQL + ' AND D.DET_CLAFIS < 3000 ';

  if (chkVerificaItensComprSt.Checked) and (not fEmptyStr(mskCstTrib.Text)) then
    strSQL := strSQL + ' AND LOCATE(IFNULL(D.DET_CODFIS, ""), "' + mskCstTrib.Text + '") > 0 ';

  strSQL := strSQL + '  AND LOCATE(D.DET_ESPDOC, "NF_NV") > 0 ';
  strSQL := strSQL + '  AND D.DET_TIP_FC = :TIP_FC ';
  strSQL := strSQL + '  AND IF(D.AUTOINCREM = CAT_SEQGER AND CAT_QTDUTI = CAT_TOTAL_, FALSE, TRUE) ';

  strSQL := strSQL + fRetFiltroFornecedor;

  if not fEmptyStr(fTiraCaracEspeciais(mskDtaLimiteNfCompra.Text)) then
    strSQL := strSQL + ' AND D.DET_DTAENT >= :DTALIMITE ';

  strSQL := strSQL + ' ORDER BY DET_DTAENT DESC, DET_HORENT DESC ';

  Result := strSQL;
end;

function TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.fRetSQLNotasSaidas: string;
  var
    strSQL: string;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  "MOVDET" AS TABELA, ';
  strSQL := strSQL + '  D.AUTOINCREM AS AUTOINCREM, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  DET_DTAENT, ';
  strSQL := strSQL + '  DET_NUMDOC AS DOCUMENTO, ';
  strSQL := strSQL + '  DET_ESPDOC AS ESPECIE, ';
  strSQL := strSQL + '  IFNULL(DET_CODCLI, "") AS CLIENTE, ';
  strSQL := strSQL + '  IFNULL(DET_SERIE_, "") AS SERIE, ';
  strSQL := strSQL + '  DET_ESTADO, ';
  strSQL := strSQL + '  DET_CODEMP, ';
  strSQL := strSQL + '  DET_CLAFIS, ';
  strSQL := strSQL + '  IFNULL(DET_IDEPRO, "") AS DET_IDEPRO, ';
  strSQL := strSQL + '  IFNULL(DET_TOTCUS, 0) AS TOTCUS, ';
  strSQL := strSQL + '  IFNULL(ABF_CODABF, "") ABF_CODABF, ';
  strSQL := strSQL + '  DET_QTDITE ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET D ';

  strSQL := strSQL + '  LEFT JOIN CADITE ITE ';
  strSQL := strSQL + '   ON ITE.ITE_CODITE = D.DET_CODITE ';

  strSQL := strSQL + '  LEFT JOIN ITEGER GER ';
  strSQL := strSQL + '   ON GER.ITE_CODITE = D.DET_CODITE ';
  strSQL := strSQL + '   AND GER.ITE_CODEMP = D.DET_CODEMP ';

  if FAbfIcm then
    strSQL := strSQL + ' LEFT JOIN ABFICM '
  else
    strSQL := strSQL + ' LEFT JOIN CADABF ';

  if fCfgSis('TIPABF') = '1' then
    strSQL := strSQL + '  ON ABF_CODABF = ITE.ITE_CODABF '
  else
    strSQL := strSQL + '  ON ABF_CODABF = GER.ITE_CODABF ';

  strSQL := strSQL + '  AND ABF_ESTADO = D.DET_ESTADO ';

  strSQL := strSQL + 'WHERE D.DET_DTAENT BETWEEN :DTAINI ';
  strSQL := strSQL + '  AND :DTAFIN ';
  strSQL := strSQL + '  AND D.DET_CLAFIS >= 6000 ';
  strSQL := strSQL + '  AND DET_IDEPRO = "NOR" ';

  strSQL := strSQL + fStrLocateEmpresa(edtCodEmp, arrCodEmp, 'D.DET_CODEMP', 'CODEMP');

  strSQL := strSQL + '  AND LOCATE(D.DET_ESPDOC, "NF_NV") > 0 ';
  strSQL := strSQL + '  AND LOCATE(D.DET_CLAFIS, :CLAVEN) > 0 ';
  strSQL := strSQL + '  AND D.DET_TIP_FC = :TIP_FC ';
  strSQL := strSQL + '  AND IFNULL(D.DET_PROEMB, "N") <> "S" ';

  if not fEmptyStr(edtDocumento.Text) then
    strSQL := strSQL + ' AND D.DET_NUMDOC = :NUMDOC ';

  if not fEmptyStr(edtCodClaFis.Text) then
    strSQL := strSQL + fStrLocate(edtCodClaFis, arrClasFiscal, 'D.DET_CLAFIS', 'CLAFIS');

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET'), 'MOVTRI', 'NOTTRI'), 'MOVICD' + strSufixoTabela, 'NOTICD' + strSufixoTabela);

  strSQL := 'SELECT TAB.* FROM (' + strSQL + ') AS TAB ORDER BY DOCUMENTO ';

  Result := strSQL;
end;

function TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.fRetSufixoMovIcd: String;
begin
  if not fTabelaExiste('MOVICD', True) then
    Result := '_TMP'
  else
    Result := '';
end;

function TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.fRetValorProporcional(
  fltQuantidade, fltQuantidadeUtilizada, fltValor: Double): Double;
begin
  if fltQuantidade = fltQuantidadeUtilizada then
  begin
    Result := fltValor;
    Exit;
  end;

  Result := (fltValor / fltQuantidade);
  Result := fFormataFloat(Result * fltQuantidadeUtilizada, 2);
end;

function TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.frxReportJUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;
  if MethodName = 'FFILTRAITEMNOTASENTRADAS' then
    Result := fFiltraItemNotasEntradas(Params[0], Params[1]);
end;

function TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = mskDtaIni) or (Sender = mskDtaFin) then
  begin
    if fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) then
    begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
      Result := False;

      if (Sender = mskDtaFin) then
        Sender := mskDtaIni;
    end
    else
    begin
      mskDtaIni.Text := DateToStr(StrToDate(mskDtaIni.Text));

      if (Sender = mskDtaFin) then
      begin
        if fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) then
        begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        end
        else
        begin
          if StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) then
          begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          end
          else
            mskDtaFin.Text := DateToStr(StrToDate(mskDtaFin.Text));
        end;
      end
    end;
  end;

  if (Sender = edtCodEmp) then
  begin
    If fEmptyStr(edtCodEmp.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário informar um código de empresa!', ['&OK']);
      pSetFocus(edtCodEmp);
      Result := False;
    End;
  end

  else if (Sender = edtCodClaFis) then
  begin
    if (not fEmptyStr(edtCodClaFis.Text)) and
       (Pos(edtCodClaFis.Text, VS_strClaVen) <= 0) then
    begin
      fMensagem('ATENÇÃO!', 'Classificação selecionada não é uma CFOP de venda!', ['&Ok']);
      Result := False;
      edtCodClaFis.Clear;
      edtDesClaFis.Clear;
      pSetFocus(edtCodClaFis);
    end;
  end;

  if (chkVerificaItensComprSt.Checked) and
     (fEmptyStr(mskCstTrib.Text)) then
  begin
    fMensagem('ATENÇÃO!', 'Preencher as CST tributadas!', ['&OK']);
    pSetFocus(mskCstTrib);
    Result := False;
  end;

  if not Result then
    pSetFocus(Sender);
end;

function TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.fValidacoesEntradaSemIcms(blnValidacaoSemIcms,
  blnValidacaoSimplesNacional: boolean): boolean;
  var
    qryCompras, qryVendas: TUniQuery;
begin
  cdsEntradasSemIcms.EmptyDataSet;

  qryCompras := fCriaQuery(nil);
  qryVendas := fCriaQuery(nil);
  try
    pnlInfo.Caption := 'Aguarde validando notas de entrada...';

    //CARREGANDO SQL DAS COMPRAS VINCULADOS COM O GERELE, PARA SE SABER SE A MESMA TEM ICMS
    qryCompras.Close;
    qryCompras.SQL.Clear;
    qryCompras.SQL.Text := fRetSQLNotasEntradas; //valida apenas notas que não de fornecedor simples

    with qryVendas do
    begin
      Close;
      SQL.Clear;
      SQL.Text := fRetSQLNotasSaidas;

      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);

      if not fEmptyStr(edtCodEmp.Text) then
        pSetaParam(edtCodEmp.Text, arrCodEmp, strCodEmp, 'CODEMP', qryVendas);

      ParamByName('CLAVEN').AsString := VS_strClaVen;
      ParamByName('TIP_FC').AsString := 'C';

      if not fEmptyStr(edtDocumento.Text) then
        ParamByName('NUMDOC').AsString := Trim(edtDocumento.Text);

      if not fEmptyStr(edtCodClaFis.Text) then
        pSetaParam(edtCodClaFis.Text, arrClasFiscal, strClafis, 'CLAFIS', qryVendas);

      qryVendas.Open;

      pgbProgresso.Visible := True;
      pgbProgresso.Max := qryVendas.RecordCount;
      pgbProgresso.Position := 0;

      first;
      while not eof do
      begin
        //função que carrega os parâmetros das notas de entrada e valida se tem valor de ICMS
        if (fValidaNotaSaidaR(qryCompras,
                              FieldByName('DET_CODITE').AsString,
                              FieldByName('DET_CODEMP').AsString,
                              FieldByName('DET_CLAFIS').AsString,
                              FieldByName('DET_ESTADO').AsString,
                              FieldByName('CLIENTE').AsString,
                              FieldByName('DET_DTAENT').AsDateTime,
                              blnValidacaoSemIcms)) then
          pCarregaClientDataSetEntradasSemIcms(qryCompras);

        if (fValidaNotaSaidaFornecedoresSimplesNacional(qryCompras,
                                                        FieldByName('DET_CODITE').AsString,
                                                        FieldByName('DET_CODEMP').AsString,
                                                        FieldByName('DET_CLAFIS').AsString,
                                                        FieldByName('DET_ESTADO').AsString,
                                                        FieldByName('CLIENTE').AsString,
                                                        FieldByName('DET_DTAENT').AsDateTime,
                                                        '',
                                                        blnValidacaoSimplesNacional)) then
          pCarregaClientDataSetEntradasSemIcms(qryCompras);

        pgbProgresso.StepBy(1);
        Application.ProcessMessages;

        next;
      end;
    end;
  finally
    qryCompras.Free;
    qryVendas.Free;
  end;

  result := cdsEntradasSemIcms.RecordCount > 0;
end;

function TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.fValidaNotaSaida(qryDadosEntrada: TUniQuery; strCodIte, strCodEmp,
  strCfop, strEstadoDestino, strCodCli: string; dtaDataVenda: TDateTime): boolean;
  function fValidaSaidasForaEstado: boolean;
    var
      qryAux: TUniQuery;
      strSufixo: string;
  begin
    Result := False;

    if (chkValidaSaidaForaEstado.Checked) and (strCfop = '6102') then
    begin
      strSufixo := fGetTipoAbfCliente(strCodCli);

      qryAux := fCriaQuery(nil);
      try
        with qryAux do
        begin
          Close;
          SQL.Clear;
          SQL.Text := 'SELECT ' +
                      '  ABF_CODSIT' + strSufixo +
                      ' FROM ' +
                      '  CADITE ' +
                      '  LEFT JOIN ABFICM ' +
                      '    ON ABF_CODABF = ITE_CODABF ' +
                      'WHERE ITE_CODITE = :CODITE ' +
                      '  AND LOCATE(ABF_ESTADO, :ESTADO) > 0 ' +
                      'GROUP BY ABF_CODSIT' + strSufixo;

          ParamByName('CODITE').AsString := strCodIte;
          ParamByName('ESTADO').AsString := QuotedStr(strEstadoDestino + '_' + fCadEmp('ESTADO'));
          Open;

          Result := RecordCount = 1;
        end;
      finally
        qryAux.Free;
      end;
    end;
  end;

  function fValidaSaidaForaEstadoDifal: boolean;
    var
      qryAux: TUniQuery;
  begin
    Result := False;

    if (chkValidaSaidaForaEstadoDifal.Checked) and (strCfop = '6108') then
    begin
      qryAux := fCriaQuery(nil);
      try
        with qryAux do
        begin
          Close;
          SQL.Clear;
          SQL.Text := 'SELECT ' +
                      '  ABF_CODSIT_SAI_NCO ' +
                      'FROM ' +
                      '  CADITE ' +
                      '  LEFT JOIN ABFICM ' +
                      '    ON ABF_CODABF = ITE_CODABF ' +
                      'WHERE ITE_CODITE = :CODITE ' +
                      '  AND LOCATE(ABF_ESTADO, :ESTADO) > 0 ' +
                      'GROUP BY ABF_CODSIT_SAI_NCO ';

          ParamByName('CODITE').AsString := strCodIte;
          ParamByName('ESTADO').AsString := QuotedStr(strEstadoDestino + '_' + fCadEmp('ESTADO'));
          Open;

          Result := RecordCount = 1;
        end;
      finally
        qryAux.Free;
      end;
    end;
  end;
begin
  if fValidaSaidaForaEstadoDifal then
  begin
    Result := False;
    Exit;
  end;

  if fValidaSaidasForaEstado then
  begin
    Result := False;
    Exit;
  end;

  qryDadosEntrada.Close;
  qryDadosEntrada.ParamByName('CODITE').AsString := strCodIte;
  qryDadosEntrada.ParamByName('CLACOM').AsString := VS_strClaCom;
  qryDadosEntrada.ParamByName('TIP_FC').AsString := 'F';
  qryDadosEntrada.ParamByName('DTAREF').AsDateTime := dtaDataVenda;
  qryDadosEntrada.ParamByName('CODEMP').AsString := strCodEmp + '_' + edtEmpTransf.Text;

   if not fEmptyStr(fTiraCaracEspeciais(mskDtaLimiteNfCompra.Text)) then
     qryDadosEntrada.ParamByName('DTALIMITE').AsDateTime := StrToDate(mskDtaLimiteNfCompra.Text);

  qryDadosEntrada.Open;

  Result := qryDadosEntrada.RecordCount > 0;
end;

function TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.fValidaNotaSaidaFornecedoresSimplesNacional(qryDadosEntrada: TUniQuery; strCodIte, strCodEmp, strCfop,
  strEstadoDestino, strCodCli: string; dtaDataVenda: TDateTime; strSimpau: string; blnValidacaoSimplesNacional: boolean): boolean;
  function fValidaSaidasForaEstado: boolean;
    var
      qryAux: TUniQuery;
      strSufixo: string;
  begin
    Result := False;

    if (chkValidaSaidaForaEstado.Checked) and (strCfop = '6102') then
    begin
      strSufixo := fGetTipoAbfCliente(strCodCli);

      qryAux := fCriaQuery(nil);
      try
        with qryAux do
        begin
          Close;
          SQL.Clear;
          SQL.Text := 'SELECT ' +
                      '  ABF_CODSIT' + strSufixo +
                      ' FROM ' +
                      '  CADITE ' +
                      '  LEFT JOIN ABFICM ' +
                      '    ON ABF_CODABF = ITE_CODABF ' +
                      'WHERE ITE_CODITE = :CODITE ' +
                      '  AND LOCATE(ABF_ESTADO, :ESTADO) > 0 ' +
                      'GROUP BY ABF_CODSIT' + strSufixo;

          ParamByName('CODITE').AsString := strCodIte;
          ParamByName('ESTADO').AsString := QuotedStr(strEstadoDestino + '_' + fCadEmp('ESTADO'));
          Open;

          Result := RecordCount = 1;
        end;
      finally
        qryAux.Free;
      end;
    end;
  end;

  function fValidaSaidaForaEstadoDifal: boolean;
    var
      qryAux: TUniQuery;
  begin
    Result := False;

    if (chkValidaSaidaForaEstadoDifal.Checked) and (strCfop = '6108') then
    begin
      qryAux := fCriaQuery(nil);
      try
        with qryAux do
        begin
          Close;
          SQL.Clear;
          SQL.Text := 'SELECT ' +
                      '  ABF_CODSIT_SAI_NCO ' +
                      'FROM ' +
                      '  CADITE ' +
                      '  LEFT JOIN ABFICM ' +
                      '    ON ABF_CODABF = ITE_CODABF ' +
                      'WHERE ITE_CODITE = :CODITE ' +
                      '  AND LOCATE(ABF_ESTADO, :ESTADO) > 0 ' +
                      'GROUP BY ABF_CODSIT_SAI_NCO ';

          ParamByName('CODITE').AsString := strCodIte;
          ParamByName('ESTADO').AsString := QuotedStr(strEstadoDestino + '_' + fCadEmp('ESTADO'));
          Open;

          Result := RecordCount = 1;
        end;
      finally
        qryAux.Free;
      end;
    end;
  end;
begin
  if fValidaSaidaForaEstadoDifal then
  begin
    Result := False;
    Exit;
  end;

  if fValidaSaidasForaEstado then
  begin
    Result := False;
    Exit;
  end;

  qryDadosEntrada.Close;
  qryDadosEntrada.ParamByName('CODITE').AsString := strCodIte;
  qryDadosEntrada.ParamByName('CLACOM').AsString := VS_strClaCom;
  qryDadosEntrada.ParamByName('TIP_FC').AsString := 'F';
  qryDadosEntrada.ParamByName('DTAREF').AsDateTime := dtaDataVenda;
  qryDadosEntrada.ParamByName('CODEMP').AsString := strCodEmp + '_' + edtEmpTransf.Text;

   if not fEmptyStr(fTiraCaracEspeciais(mskDtaLimiteNfCompra.Text)) then
     qryDadosEntrada.ParamByName('DTALIMITE').AsDateTime := StrToDate(mskDtaLimiteNfCompra.Text);

  qryDadosEntrada.Open;

  Result := ((qryDadosEntrada.RecordCount > 0) and
             (qryDadosEntrada.FieldByName('CREDSN').AsFloat + qryDadosEntrada.FieldByName('CREDICMSSN').AsFloat > 0) and
             (IndexStr(qryDadosEntrada.FieldByName('SIMPAU').AsString, ['P','R']) > -1) and
             (blnValidacaoSimplesNacional));
end;

function TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.fValidaNotaSaidaR(qryDadosEntrada: TUniQuery; strCodIte, strCodEmp,
  strCfop, strEstadoDestino, strCodCli: string; dtaDataVenda: TDateTime; blnValidacaoSemIcms: Boolean): boolean;
  function fValidaSaidasForaEstado: boolean;
    var
      qryAux: TUniQuery;
      strSufixo: string;
  begin
    Result := False;

    if (chkValidaSaidaForaEstado.Checked) and (strCfop = '6102') then
    begin
      strSufixo := fGetTipoAbfCliente(strCodCli);

      qryAux := fCriaQuery(nil);
      try
        with qryAux do
        begin
          Close;
          SQL.Clear;
          SQL.Text := 'SELECT ' +
                      '  ABF_CODSIT' + strSufixo +
                      ' FROM ' +
                      '  CADITE ' +
                      '  LEFT JOIN ABFICM ' +
                      '    ON ABF_CODABF = ITE_CODABF ' +
                      'WHERE ITE_CODITE = :CODITE ' +
                      '  AND LOCATE(ABF_ESTADO, :ESTADO) > 0 ' +
                      'GROUP BY ABF_CODSIT' + strSufixo;

          ParamByName('CODITE').AsString := strCodIte;
          ParamByName('ESTADO').AsString := QuotedStr(strEstadoDestino + '_' + fCadEmp('ESTADO'));
          Open;

          Result := RecordCount = 1;
        end;
      finally
        qryAux.Free;
      end;
    end;
  end;

  function fValidaSaidaForaEstadoDifal: boolean;
    var
      qryAux: TUniQuery;
  begin
    Result := False;

    if (chkValidaSaidaForaEstadoDifal.Checked) and (strCfop = '6108') then
    begin
      qryAux := fCriaQuery(nil);
      try
        with qryAux do
        begin
          Close;
          SQL.Clear;
          SQL.Text := 'SELECT ' +
                      '  ABF_CODSIT_SAI_NCO ' +
                      'FROM ' +
                      '  CADITE ' +
                      '  LEFT JOIN ABFICM ' +
                      '    ON ABF_CODABF = ITE_CODABF ' +
                      'WHERE ITE_CODITE = :CODITE ' +
                      '  AND LOCATE(ABF_ESTADO, :ESTADO) > 0 ' +
                      'GROUP BY ABF_CODSIT_SAI_NCO ';

          ParamByName('CODITE').AsString := strCodIte;
          ParamByName('ESTADO').AsString := QuotedStr(strEstadoDestino + '_' + fCadEmp('ESTADO'));
          Open;

          Result := RecordCount = 1;
        end;
      finally
        qryAux.Free;
      end;
    end;
  end;
begin
  if fValidaSaidaForaEstadoDifal then
  begin
    Result := False;
    Exit;
  end;

  if fValidaSaidasForaEstado then
  begin
    Result := False;
    Exit;
  end;

  qryDadosEntrada.Close;
  qryDadosEntrada.ParamByName('CODITE').AsString := strCodIte;
  qryDadosEntrada.ParamByName('CLACOM').AsString := VS_strClaCom;
  qryDadosEntrada.ParamByName('TIP_FC').AsString := 'F';
  qryDadosEntrada.ParamByName('DTAREF').AsDateTime := dtaDataVenda;
  qryDadosEntrada.ParamByName('CODEMP').AsString := strCodEmp + '_' + edtEmpTransf.Text;

   if not fEmptyStr(fTiraCaracEspeciais(mskDtaLimiteNfCompra.Text)) then
     qryDadosEntrada.ParamByName('DTALIMITE').AsDateTime := StrToDate(mskDtaLimiteNfCompra.Text);

  qryDadosEntrada.Open;

  Result := ((qryDadosEntrada.RecordCount > 0) and
            ((((qryDadosEntrada.FieldByName('ICMS_ENTRADA').AsFloat <= 0) or
               (qryDadosEntrada.FieldByName('VALOR_ICM_UNITAR').AsFloat <= 0)) or
             (qryDadosEntrada.FieldByName('ICMS_ST_ENTRADA').AsFloat <= 0)) or
             (qryDadosEntrada.FieldByName('NIVEL_ERRO').AsInteger = 4)) and
             (blnValidacaoSemIcms));
end;

function TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.fVerificaValidacaoNotasEntradaSemIcms: boolean;
begin
  Result := false;

  if (chkValidarNotasEntrada.Checked) or (chkValidarFornecedorSimplesNacional.Checked) then
  begin
    if fValidacoesEntradaSemIcms(chkValidarNotasEntrada.Checked, chkValidarFornecedorSimplesNacional.Checked) then
    begin
      cdsEntradasSemIcms.IndexFieldNames := 'NIVEL_ERRO; DOCUMENTO';
      frxNotasEntradaSemIcms.Script.Variables['NOMEMP'] := fCadEmp('NOMEMP');
      frxNotasEntradaSemIcms.Script.Variables['NOMREL'] := 'Notas fiscais eletrônicas de entrada com inconsistência';
      frxNotasEntradaSemIcms.Script.Variables['CODEMP'] := fStrTitulo(edtCodEmp.Text, edtNomEmp, arrCodEmp, strCodEmp, 'EMPRESA', TRUE);
      frxNotasEntradaSemIcms.Script.Variables['REFERE'] := 'REFERENTE AO PERÍODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
      frxNotasEntradaSemIcms.Script.Variables['DOCUMENTO'] := fStrTitulo(edtDocumento.Text, nil, nil, '', 'DOCUMENTO', FALSE);
      frxNotasEntradaSemIcms.Script.Variables['CLAFIS'] := fStrTitulo(edtCodClaFis.Text, edtDesClaFis, arrClasFiscal, strClafis, 'CFOP', TRUE);

      if frxNotasEntradaSemIcms.PrepareReport then
      begin
        frxNotasEntradaSemIcms.PrintOptions.PrintMode := pmScale;
        frxNotasEntradaSemIcms.PrintOptions.PrintOnSheet := 9;
        pPreviewReport(Self.Name, 'Notas fiscais eletrônicas de entrada com inconsistência', frxNotasEntradaSemIcms);
      end;

      if fMensagem('ATENÇÃO', 'Imprimir o relatório mesmo com advertências?',
        ['&Sim', '&Não'], 2) = 1 then
        Result := false
      else
        Result := true;
    end;
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pAbreExcel;
  Var
    objGeraExcel: TGeraExcel;
begin
  pFormataCamposDataSet;

  objGeraExcel := TGeraExcel.Create(cdsRelatorioNotasSaida, pgbProgresso);
  try
    with objGeraExcel do
    begin
      strNomRel := 'RESSARCIMENTO DO IMPOSTO RETIDO POR SUJEIÇÃO PASSIVA POR SUBSTITUIÇÃO';
      AddFiltro('REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);
      AddFiltro(fStrTitulo(edtCodEmp.Text, edtNomEmp, arrCodEmp, strCodEmp, 'EMPRESA', TRUE));
      AddFiltro(fStrTitulo(edtDocumento.Text, nil, nil, '', 'DOCUMENTO', FALSE));
      AddFiltro(fStrTitulo(edtCodClaFis.Text, edtDesClaFis, arrClasFiscal, strClafis, 'CFOP', TRUE));

      AddCampo('DOCUMENTO', 'DOCUMENTO');
      AddCampo('CFOP', 'CFOP');
      AddCampo('VLR_CONTABIL', 'VLR. CONTÁBIL');
      AddCampo('VLR_ICMS', 'VLR. ICMS');
      AddCampo('VLR_ICMS_ST', 'VLR. ICMS ST');
      AddCampo('VLR_DIFAL_ORIGEM', 'VLR. DIFAL ORIGEM');
      AddCampo('VLR_DIFAL_DESTINO', 'VLR. DIFAL DESTINO');

      AddTotais('VLR_CONTABIL');
      AddTotais('VLR_ICMS');
      AddTotais('VLR_ICMS_ST');
      AddTotais('VLR_DIFAL_ORIGEM');
      AddTotais('VLR_DIFAL_DESTINO');

      OnMontaResumo := pMontaResumo;
      OnSomaResumo := pSomaTotais;
      OnImpDetalhes := pImprimeDetalhes;

      if fGerarRelatorio then
      begin
        fMensagem('','Arquivo gerado com sucesso!',['&OK']);
      end;
    end;
  finally
    objGeraExcel.Free;
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCalculaImpostoTintaMaquina(strAutoIncremCompra: string);
  function fRetValorImpostoCalculado(blnIcms: boolean): double;
    var
      fltValorIcm, fltValorRessarcimento: double;
  begin
    if blnIcms then
    begin
      Result := fFormataFloat((qryRelatorio.qryQuery.FieldByName('TOTCUS').AsFloat * fltAliquotaInterEstadual) / 100, 002);
    end
    else
    begin
      fltValorIcm := fFormataFloat((qryRelatorio.qryQuery.FieldByName('TOTCUS').AsFloat * fltAliquotaInterEstadual) / 100, 002);
      fltValorRessarcimento := fFormataFloat(((qryRelatorio.qryQuery.FieldByName('TOTCUS').AsFloat * fltIva) * fltAliquotaInterna) / 100, 002);
      Result := Abs(fltValorIcm - fltValorRessarcimento);
    end;
  end;
begin
  //função que alimenta as variaveis para calculo do imposto da tinta de máquina
  pCarregaAliquotaAbreviacao(qryRelatorio.qryQuery.FieldByName('DET_CODITE').AsString,
                             qryRelatorio.qryQuery.FieldByName('DET_ESTADO').AsString,
                             qryRelatorio.qryQuery.FieldByName('DET_CODEMP').AsString);

  cdsRelatorioNotasEntrada.Append;
  cdsRelatorioNotasEntrada.FieldByName('DATA').AsDateTime := qryRelatorio.qryQuery.FieldByName('DET_DTAENT').AsDateTime;
  cdsRelatorioNotasEntrada.FieldByName('DOCUMENTO').AsString := qryRelatorio.qryQuery.FieldByName('DOCUMENTO').AsString;
  cdsRelatorioNotasEntrada.FieldByName('FORNECEDOR').AsString := '';
  cdsRelatorioNotasEntrada.FieldByName('QUANTIDADE').AsFloat := qryRelatorio.qryQuery.FieldByName('DET_QTDITE').AsFloat;
  cdsRelatorioNotasEntrada.FieldByName('TOTAL_PRODUTO').AsFloat := fFormataFloat(qryRelatorio.qryQuery.FieldByName('TOTCUS').AsFloat, 002);
  cdsRelatorioNotasEntrada.FieldByName('VALOR_ICMS').AsFloat := fRetValorImpostoCalculado(true);
  cdsRelatorioNotasEntrada.FieldByName('VALORST').AsFloat := fRetValorImpostoCalculado(false);
  cdsRelatorioNotasEntrada.FieldByName('VALORIPI').AsFloat := 0;
  cdsRelatorioNotasEntrada.FieldByName('AUTOINCREM_VENDA').AsString := qryRelatorio.qryQuery.FieldByName('AUTOINCREM').AsString;
  cdsRelatorioNotasEntrada.FieldByName('AUTOINCREM_COMPRA').AsString := '';
  cdsRelatorioNotasEntrada.FieldByName('TABELA_VENDA').AsString := qryRelatorio.qryQuery.FieldByName('TABELA').AsString;
  cdsRelatorioNotasEntrada.Post;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCalculaQuantidadesUtilizadas(qryAux: TUniQuery; var fltSaldoVendido: double);
  var
    intContador: Integer;
    blnAdicionar: Boolean;
    itemNotaUtilizada: TItemNotaValidacao;
    fltSaldoComprado, fltQuantidadeUtilizada: Double;
    objCalculoImpostos: ICalculaImpostosCat158;
    objDadosAdicionaisCalculaImpostos: IDadosAdicionaisCalculaImpostosCat158;
begin
  {
    qryAux = fRetSQLNotasEntradas
    qryRelatorio = fRetSQLNotasSaidas
    fltSaldoVendido := qryRelatorio.qryQuery.FieldByName('DET_QTDITE').AsFloat
  }
  objDadosAdicionaisCalculaImpostos := TDadosAdicionaisCalculaImpostosCat158.Create;
  objCalculoImpostos := fRetObjCalculoImpostos;
  objCalculoImpostos.pSetDadosAdicionais(objDadosAdicionaisCalculaImpostos);

  qryAux.First;
  while (fltSaldoVendido <> 0) and (not qryAux.Eof) do
  begin
    fltSaldoComprado := qryAux.FieldByName('DET_QTDITE').AsFloat;
    itemNotaUtilizada := nil;
    blnAdicionar := True;

    for intContador := 0 to listaNotasUtilizadas.Count - 1 do
    begin
      itemNotaUtilizada := TItemNotaValidacao(listaNotasUtilizadas[intContador]);

      // Se existir dentro da lista a nota que será processada, verificar se a mesma já foi utilizada totalmente
      if (itemNotaUtilizada.strSeqGer = qryAux.FieldByName('AUTOINCREM').AsString) then
      begin
        if itemNotaUtilizada.fltQuantidadeUtilizada = itemNotaUtilizada.fltQuantidadeTotal then
          qryAux.Next
        else
        begin
          fltSaldoComprado := Abs(itemNotaUtilizada.fltQuantidadeUtilizada - itemNotaUtilizada.fltQuantidadeTotal);
          blnAdicionar := False;
          Break;
        end;
      end;
    end;

    if fltSaldoVendido < fltSaldoComprado then
    begin
      fltQuantidadeUtilizada := fltSaldoVendido;
      fltSaldoVendido := 0;
    end
    else
    begin
      fltSaldoVendido := fltSaldoVendido - fltSaldoComprado;
      fltQuantidadeUtilizada := fltSaldoComprado;
    end;

    //carrega o objeto com os dados adicionais para o calculo dos impostos
    pCarregaDadosAdicionaisObjCalculoImpostos(objDadosAdicionaisCalculaImpostos, qryAux, fStrToFloat(edtValIva.Text), fltAlqIntEstadoEmitente);

    //carrega o objeto de calculo dos impostos
    pCarregaDadosObjCalculoImpostos(objCalculoImpostos, qryAux, fltQuantidadeUtilizada);

    //método que insere dados dentro de uma lista de objetos para gravação na tabela "CAT_158_SPED" utilizada no sped fiscal
    pCarregaDadosRegC176SpedFiscal(objCalculoImpostos, qryAux, fltQuantidadeUtilizada);

    //Carrega o dataset de entrada analitico e o sintético
    pCarregaDataSetEntrada(objCalculoImpostos, qryAux, fltQuantidadeUtilizada);

    //ALIMENTANDO A LISTA DE NOTAS DE ENTRADA UTILIZADAS
    if blnAdicionar then
    begin
      itemNotaUtilizada := TItemNotaValidacao.Create;
      itemNotaUtilizada.strAutoIncrem := fRetAutoIncrem('CAT_158', edtCodEmp.Text);
      itemNotaUtilizada.strSeqGer := qryAux.FieldByName('AUTOINCREM').AsString;
      itemNotaUtilizada.fltQuantidadeUtilizada := fltQuantidadeUtilizada;
      itemNotaUtilizada.fltQuantidadeTotal := qryAux.FieldByName('DET_QTDITE').AsFloat;
      listaNotasUtilizadas.Add(itemNotaUtilizada);
    end
    else
      itemNotaUtilizada.fltQuantidadeUtilizada := itemNotaUtilizada.fltQuantidadeUtilizada + fltQuantidadeUtilizada;

    qryAux.Next;
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCarregaAliquotaAbreviacao(strCodIte, strEstado, strEmpresa: String);
  var
    qryAux: TUniQuery;
    strSQL: string;
begin
  qryAux := fCriaQuery(nil);
  try
    strSQL := '';

    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ABF_ALQICM_ENT_PEJ AS ALQ_INTERESTADUAL, ';
    strSQL := strSQL + '  ABF_ALQRET_ENT_PEJ AS ALQ_INTERNA, ';
    strSQL := strSQL + '  ABF_IVA_ST_ENT_PEJ AS IVA ';
    strSQL := strSQL + 'FROM ';

    if fCfgSis('TIPABF') = '1' then
      strSQL := strSQL + 'CADITE '
    else
      strSQL := strSQL + 'ITEGER ';

    strSQL := strSQL + ' LEFT JOIN ABFICM ';
    strSQL := strSQL + '   ON ABF_CODABF = ITE_CODABF ';
    strSQL := strSQL + '   AND ABF_ESTADO = :ESTADO ';

    strSQL := strSQL + 'WHERE ITE_CODITE = :CODITE ';

    if not fCfgSis('TIPABF') = '1' then
      strSQL := strSQL + ' AND ITE_CODEMP = :CODEMP ';

    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := strSQL;
      ParamByName('ESTADO').AsString := strEstado;
      ParamByName('CODITE').AsString := strCodIte;

      if not fCfgSis('TIPABF') = '1' then
        ParamByName('CODEMP').AsString := strEmpresa;

      Open;

      fltAliquotaInterEstadual := FieldByName('ALQ_INTERESTADUAL').AsFloat;
      fltAliquotaInterna := FieldByName('ALQ_INTERNA').AsFloat;
      fltIva := FieldByName('IVA').AsFloat;
    end;
  finally
    qryAux.Free;
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCarregaAlqInternaEstadoEmitente;
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT CID_ESTADO FROM CADEMP LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID WHERE EMP_CODEMP = :CODEMP ';
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      if FieldByName('CID_ESTADO').AsString = 'AC' then
        fltAlqIntEstadoEmitente := 17
      else if FieldByName('CID_ESTADO').AsString = 'AL' then
        fltAlqIntEstadoEmitente := 17
      else if FieldByName('CID_ESTADO').AsString = 'AM' then
        fltAlqIntEstadoEmitente := 18
      else if FieldByName('CID_ESTADO').AsString = 'AP' then
        fltAlqIntEstadoEmitente := 18
      else if FieldByName('CID_ESTADO').AsString = 'BA' then
        fltAlqIntEstadoEmitente := 18
      else if FieldByName('CID_ESTADO').AsString = 'CE' then
        fltAlqIntEstadoEmitente := 17
      else if FieldByName('CID_ESTADO').AsString = 'DF' then
        fltAlqIntEstadoEmitente := 18
      else if FieldByName('CID_ESTADO').AsString = 'ES' then
        fltAlqIntEstadoEmitente := 17
      else if FieldByName('CID_ESTADO').AsString = 'EX' then
        fltAlqIntEstadoEmitente := 4
      else if FieldByName('CID_ESTADO').AsString = 'GO' then
        fltAlqIntEstadoEmitente := 17
      else if FieldByName('CID_ESTADO').AsString = 'MA' then
        fltAlqIntEstadoEmitente := 18
      else if FieldByName('CID_ESTADO').AsString = 'MG' then
        fltAlqIntEstadoEmitente := 18
      else if FieldByName('CID_ESTADO').AsString = 'MS' then
        fltAlqIntEstadoEmitente := 17
      else if FieldByName('CID_ESTADO').AsString = 'MT' then
        fltAlqIntEstadoEmitente := 17
      else if FieldByName('CID_ESTADO').AsString = 'PA' then
        fltAlqIntEstadoEmitente := 17
      else if FieldByName('CID_ESTADO').AsString = 'PB' then
        fltAlqIntEstadoEmitente := 18
      else if FieldByName('CID_ESTADO').AsString = 'PE' then
        fltAlqIntEstadoEmitente := 18
      else if FieldByName('CID_ESTADO').AsString = 'PI' then
        fltAlqIntEstadoEmitente := 18
      else if FieldByName('CID_ESTADO').AsString = 'PR' then
        fltAlqIntEstadoEmitente := 18
      else if FieldByName('CID_ESTADO').AsString = 'RJ' then
        fltAlqIntEstadoEmitente := 19
      else if FieldByName('CID_ESTADO').AsString = 'RN' then
        fltAlqIntEstadoEmitente := 18
      else if FieldByName('CID_ESTADO').AsString = 'RO' then
        fltAlqIntEstadoEmitente := 17.5
      else if FieldByName('CID_ESTADO').AsString = 'RR' then
        fltAlqIntEstadoEmitente := 17
      else if FieldByName('CID_ESTADO').AsString = 'RS' then
        fltAlqIntEstadoEmitente := 18
      else if FieldByName('CID_ESTADO').AsString = 'SC' then
        fltAlqIntEstadoEmitente := 17
      else if FieldByName('CID_ESTADO').AsString = 'SE' then
        fltAlqIntEstadoEmitente := 18
      else if FieldByName('CID_ESTADO').AsString = 'SP' then
        fltAlqIntEstadoEmitente := 18
      else if FieldByName('CID_ESTADO').AsString = 'TO' then
        fltAlqIntEstadoEmitente := 18;
    end;
  finally
    qryAux.Free;
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCarregaClientDataSetEntradasSemIcms(qryCompras: TUniQuery);
begin
  cdsEntradasSemIcms.Append;
  cdsEntradasSemIcmsDATAENTRADA.AsDateTime := qryCompras.FieldByName('DET_DTAENT').AsDateTime;
  cdsEntradasSemIcmsDATADOCUMENTO.AsDateTime := qryCompras.FieldByName('DET_DTADOC').AsDateTime;
  cdsEntradasSemIcmsDOCUMENTO.AsString := qryCompras.FieldByName('DOCUMENTO').AsString;
  cdsEntradasSemIcmsSERIE.AsString := qryCompras.FieldByName('DET_SERIE_').AsString;
  cdsEntradasSemIcmsFORNECEDOR.AsString := qryCompras.FieldByName('FORNECEDOR').AsString;
  cdsEntradasSemIcmsVALORCONTABIL.AsFloat := qryCompras.FieldByName('DET_VLRCON').AsFloat;
  cdsEntradasSemIcmsHIST_ERRO.AsString := qryCompras.FieldByName('HIST_ERRO').AsString;
  cdsEntradasSemIcmsNIVEL_ERRO.AsString := qryCompras.FieldByName('NIVEL_ERRO').AsString;
  cdsEntradasSemIcms.Post;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCarregaDadosAdicionaisObjCalculoImpostos(
  obj: IDadosAdicionaisCalculaImpostosCat158; qryAux: TDataSet; fltIVA,
  fltAlqInterna: double);
begin
  obj.pSetRegraCstCfop(qryAux.FieldByName('REGRA_CST_CFOP').AsString);
  obj.pSetValorProduto(qryAux.FieldByName('VALOR_PRODUTO').AsFloat);
  obj.pSetAlqInterna(fltAlqInterna);
  obj.pSetValorIVA(fltIva);
  obj.pSetValorIpi(qryAux.FieldByName('IPI_ENTRADA').AsFloat);
  obj.pSetValorIcms(qryAux.FieldByName('ICMS_ENTRADA').AsFloat);
  obj.pSetValorIcmsUntCompra(qryAux.FieldByName('ICMS_ENTRADA').AsFloat);
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCarregaDadosEntrada;
  Var
    qryDadosEntrada: TUniQuery;
    fltSaldoVendido: Double;
begin
  listaNotasVendidasRessarcidas.Clear;

  qryDadosEntrada := fCriaQuery(nil);
  try
    if not qryRelatorio.qryQuery.IsEmpty then
    begin
      pgbProgresso.Visible := True;
      pgbProgresso.Max := qryRelatorio.qryQuery.RecordCount;
      pgbProgresso.Position := 0;
    end;

    //Carrega as notas que não foram usadas totalmente os produtos
    pCarregaDadosTabelaCat158;

    qryDadosEntrada.Close;
    qryDadosEntrada.SQL.Clear;
    qryDadosEntrada.SQL.Text := fRetSQLNotasEntradas;

    qryRelatorio.qryQuery.First;
    while not qryRelatorio.qryQuery.Eof do
    begin
      if fValidaNotaSaida(qryDadosEntrada,
                          qryRelatorio.qryQuery.FieldByName('DET_CODITE').AsString,
                          qryRelatorio.qryQuery.FieldByName('DET_CODEMP').AsString,
                          qryRelatorio.qryQuery.FieldByName('DET_CLAFIS').AsString,
                          qryRelatorio.qryQuery.FieldByName('DET_ESTADO').AsString,
                          qryRelatorio.qryQuery.FieldByName('CLIENTE').AsString,
                          qryRelatorio.qryQuery.FieldByName('DET_DTAENT').AsDateTime) then
      begin
        fltSaldoVendido := qryRelatorio.qryQuery.FieldByName('DET_QTDITE').AsFloat;

        if (qryRelatorio.qryQuery.FieldByName('DET_IDEPRO').AsString <> 'NOR') or
           (qryRelatorio.qryQuery.FieldByName('ABF_CODABF').AsString = '047') then
          //função que fará o cálculo do imposto da tinta vendida (equação passada pelo cliente DARKA)
          pCalculaImpostoTintaMaquina(qryDadosEntrada.FieldByName('AUTOINCREM').AsString)
        else
          //função que fará o calculo da quantidade que será utilizada e os devidos inserts nos cds para amostragem dos ressarcimentos.
          pCalculaQuantidadesUtilizadas(qryDadosEntrada, fltSaldoVendido);
      end;

      qryRelatorio.qryQuery.Next;

      pgbProgresso.StepBy(1);
      Application.ProcessMessages;
    end;
  finally
    qryDadosEntrada.Free;
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCarregaDadosEntradaSintetico;
begin
  cdsRelatorioNotasSaida.First;
  while not cdsRelatorioNotasSaida.Eof do
  begin
    fFiltraItemNotasEntradas(cdsRelatorioNotasSaidaAUTOINCREM.AsString,
                             cdsRelatorioNotasSaidaTABELA.AsString);

    cdsRelatorioNotasEntrada.First;
    while not cdsRelatorioNotasEntrada.Eof do
    begin
      //carrega o cds de entrada sintético
      cdsRelatorioSintetico.Edit;
      cdsRelatorioSintetico.FieldByName('VLRCON_ENTRADA').AsFloat := cdsRelatorioSintetico.FieldByName('VLRCON_ENTRADA').AsFloat +
                                                                     cdsRelatorioNotasEntrada.FieldByName('TOTAL_PRODUTO').AsFloat;

      if chkNaoEnviarValorZeradoIcmsSt.Checked then
      begin
        //só deverá somar nos totais, caso exista crédito de icms e ressarcimento de st ao mesmo tempo
        if (cdsRelatorioNotasEntrada.FieldByName('BASE_ICMS').AsFloat > 0) and
           (cdsRelatorioNotasEntrada.FieldByName('VALOR_ICMS').AsFloat > 0) and
           (cdsRelatorioNotasEntrada.FieldByName('BASE_ST').AsFloat > 0) and
           (cdsRelatorioNotasEntrada.FieldByName('VALORST').AsFloat > 0) then
        begin
          cdsRelatorioSintetico.FieldByName('ICMS_ENTRADA').AsFloat := cdsRelatorioSintetico.FieldByName('ICMS_ENTRADA').AsFloat +
                                                                       cdsRelatorioNotasEntrada.FieldByName('VALOR_ICMS').AsFloat;

          cdsRelatorioSintetico.FieldByName('ICMS_ST_ENTRADA').AsFloat := cdsRelatorioSintetico.FieldByName('ICMS_ST_ENTRADA').AsFloat +
                                                                          cdsRelatorioNotasEntrada.FieldByName('VALORST').AsFloat;
        end;
      end
      else
      begin
        cdsRelatorioSintetico.FieldByName('ICMS_ENTRADA').AsFloat := cdsRelatorioSintetico.FieldByName('ICMS_ENTRADA').AsFloat +
                                                                     cdsRelatorioNotasEntrada.FieldByName('VALOR_ICMS').AsFloat;

        cdsRelatorioSintetico.FieldByName('ICMS_ST_ENTRADA').AsFloat := cdsRelatorioSintetico.FieldByName('ICMS_ST_ENTRADA').AsFloat +
                                                                        cdsRelatorioNotasEntrada.FieldByName('VALORST').AsFloat;
      end;

      cdsRelatorioSintetico.FieldByName('IPI_ENTRADA').AsFloat := cdsRelatorioSintetico.FieldByName('IPI_ENTRADA').AsFloat +
                                                                  cdsRelatorioNotasEntrada.FieldByName('VALORIPI').AsFloat;
      cdsRelatorioSintetico.Post;

      cdsRelatorioNotasEntrada.Next;
    end;

    //Carrega o cds de saída sintético.
    cdsRelatorioSintetico.Edit;
    cdsRelatorioSintetico.FieldByName('ICMS_SAIDA').AsFloat := cdsRelatorioSintetico.FieldByName('ICMS_SAIDA').AsFloat +
                                                               cdsRelatorioNotasSaida.FieldByName('VLR_ICMS').AsFloat;

    cdsRelatorioSintetico.FieldByName('DIFAL_SAIDA').AsFloat := cdsRelatorioSintetico.FieldByName('DIFAL_SAIDA').AsFloat +
                                                                cdsRelatorioNotasSaida.FieldByName('VLR_DIFAL_ORIGEM').AsFloat +
                                                                cdsRelatorioNotasSaida.FieldByName('VLR_DIFAL_DESTINO').AsFloat;
    cdsRelatorioSintetico.Post;

    cdsRelatorioNotasSaida.Next;
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCarregaDadosObjCalculoImpostos(obj: ICalculaImpostosCat158;
  qryAux: TDataSet; fltQtdUtilizada: double);
begin
  obj.pSetQuantidadeComprada(qryAux.FieldByName('DET_QTDITE').AsFloat);
  obj.pSetBaseStUnitaria(qryAux.FieldByName('ST_UNITAR').AsFloat);
  obj.pSetBaseSt(qryAux.FieldByName('BASE_ICMS_ST_ENTRADA').AsFloat);
  obj.pSetAlqSt(qryAux.FieldByName('ALQ_ICMS_ST_ENTRADA').AsFloat);
  obj.pSetValorSt(qryAux.FieldByName('ICMS_ST_ENTRADA').AsFloat);
  obj.pSetValorN15Vbc(qryAux.FieldByName('N15_VBC').AsFloat);
  obj.pSetValorN17Vicms(qryAux.FieldByName('N17_VICMS').AsFloat);
  obj.pSetValorN21VbcSt(qryAux.FieldByName('N21_VBCST').AsFloat);
  obj.pSetValorN23VicmsSt(qryAux.FieldByName('N23_VICMSST').AsFloat);
  obj.pSetValorIcmUnitar(qryAux.FieldByName('VALOR_ICM_UNITAR').AsFloat);
  obj.pSetBaseIcmsStEntrada(qryAux.FieldByName('BASE_ICMS_ST_ENTRADA').AsFloat);
  obj.pSetAlqIcmsStEntrada(qryAux.FieldByName('ALQ_ICMS_ST_ENTRADA').AsFloat);
  obj.pSetQuantidadeUtilizada(fltQtdUtilizada);
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCarregaDadosObjReImpressao(objReImpressao: TReimpressaoRelRessarcimentoCat158);
begin
  objReImpressao.cdsEntradasReImpressao := cdsRelatorioNotasEntrada;
  objReImpressao.cdsSaidasReImpressao := cdsRelatorioNotasSaida;
  objReImpressao.dtaDtaIni := StrToDate(mskDtaIni.Text);
  objReImpressao.dtaDtaFin := StrToDate(mskDtaFin.Text);
  objReimpressao.strCodEmp := edtCodEmp.Text;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCarregaDadosRegC176SpedFiscal(objCalculoImpostos: ICalculaImpostosCat158;
  qryAux: TUniQuery; fltQuantidadeUtilizada: double);
  var
    itemNotaVendidoRelacionado: TItemNotaVendidoRelacionado;
begin
  itemNotaVendidoRelacionado := TItemNotaVendidoRelacionado.Create;
  itemNotaVendidoRelacionado.strAutoIncrem := fRetAutoIncrem('CAT_158_SPED', edtCodEmp.Text);
  itemNotaVendidoRelacionado.strAutoIncremCompra := qryAux.FieldByName('AUTOINCREM').AsString;
  itemNotaVendidoRelacionado.dtaDataCompra := qryAux.FieldByName('DET_DTAENT').AsDateTime;
  itemNotaVendidoRelacionado.strModeloNfCompra := qryAux.FieldByName('FIS_DOCMOD').AsString;
  itemNotaVendidoRelacionado.strDocumentoNfCompra := qryAux.FieldByName('DET_NUMDOC').AsString;
  itemNotaVendidoRelacionado.strSerieNfCompra := qryAux.FieldByName('DET_SERIE_').AsString;
  itemNotaVendidoRelacionado.strParticipanteNfCompra := qryAux.FieldByName('CODFOR').AsString;
  itemNotaVendidoRelacionado.fltQuantidadeUtilizadaNfCompra := fltQuantidadeUtilizada;
  itemNotaVendidoRelacionado.fltValorUnitarioNfCompra := qryAux.FieldByName('UNITAR').AsFloat;

  itemNotaVendidoRelacionado.strCodigoProdutoUtilizadoRessarcimento := qryAux.FieldByName('DET_CODITE').AsString;
  itemNotaVendidoRelacionado.fltValorUnitarioBaseStNfCompra := objCalculoImpostos.fRetBaseStUnitaria;
  itemNotaVendidoRelacionado.fltTotalUtilizadoBaseIcmST := objCalculoImpostos.fRetBaseSt;
  itemNotaVendidoRelacionado.fltAlqIcmsST := objCalculoImpostos.fRetAlqSt;
  itemNotaVendidoRelacionado.fltTotalUtilizadoValorIcmST := objCalculoImpostos.fRetValorSt;

  itemNotaVendidoRelacionado.strAutoIncremVenda := qryRelatorio.qryQuery.FieldByName('AUTOINCREM').AsString;
  itemNotaVendidoRelacionado.fltValorUnitarioBaseIcmNfCompra := qryAux.FieldByName('BASE_ICM_UNITAR').AsFloat;
  itemNotaVendidoRelacionado.fltValorAlqIcmNfCompra := qryAux.FieldByName('DET_ALQICM').AsFloat;
  itemNotaVendidoRelacionado.fltValorUnitarioIcmNfCompra := qryAux.FieldByName('VALOR_ICM_UNITAR').AsFloat;
  itemNotaVendidoRelacionado.strChaveAcesso := qryAux.FieldByName('CHAVE_ACESSO').AsString;
  itemNotaVendidoRelacionado.strTabela := qryRelatorio.qryQuery.FieldByName('TABELA').AsString;

  listaNotasVendidasRessarcidas.Add(itemNotaVendidoRelacionado);
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCarregaDadosSaidaAnalitico;
  function fCarregaSQLSaidaAnalitica(strTabela: string): string;
    var
      strSQL: string;
  begin
    strSQL := '';

    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP) AS DOCUMENTO, ';
    strSQL := strSQL + '  CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS CLIENTE, ';
    strSQL := strSQL + '  DET_DTAENT, ';
    strSQL := strSQL + '  DET_ESTADO, ';
    strSQL := strSQL + '  DET_CLAFIS, ';
    strSQL := strSQL + '  DET_VLRCON, ';
    strSQL := strSQL + '  DET_VALICM, ';
    strSQL := strSQL + '  DET_VALRET, ';
    strSQL := strSQL + '  ICD_VALORI, ';
    strSQL := strSQL + '  ICD_VALDES, ';
    strSQL := strSQL + '  CONCAT(DET_CODITE, "-", DET_DESCRI) AS CODITE, ';
    strSQL := strSQL + '  DET_REFERE, ';
    strSQL := strSQL + '  UNI_SIGUNI AS UNIDADE, ';
    strSQL := strSQL + '  DET_QTDITE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + strTabela;

    strSQL := strSQL + '  LEFT JOIN MOVICD ' + strSufixoTabela;
    strSQL := strSQL + '   ON ICD_SEQGER = ' + strTabela + '.AUTOINCREM ';

    strSQL := strSQL + '  LEFT JOIN CADUNI ';
    strSQL := strSQL + '   ON UNI_CODUNI = DET_UNIDAD ';

    strSQL := strSQL + '  LEFT JOIN CADCLI ';
    strSQL := strSQL + '   ON CLI_CODCLI = DET_CODCLI ';

    strSQL := strSQL + 'WHERE ' + strTabela + '.AUTOINCREM = :AUTOINCREM ';

    Result := strSQL;
  end;

  var
    qryAux: TUniQuery;
    strDocumentoAnterior: string;
begin
  strDocumentoAnterior := '';

  qryAux := fCriaQuery(nil);
  try
    cdsRelatorioNotasEntrada.IndexFieldNames := 'AUTOINCREM_VENDA';
    cdsRelatorioNotasEntrada.First;
    while not cdsRelatorioNotasEntrada.Eof do
    begin
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Text := fCarregaSQLSaidaAnalitica(cdsRelatorioNotasEntrada.FieldByName('TABELA_VENDA').AsString);
        ParamByName('AUTOINCREM').AsString := cdsRelatorioNotasEntrada.FieldByName('AUTOINCREM_VENDA').AsString;
        Open;
      end;

      if cdsRelatorioNotasEntrada.FieldByName('AUTOINCREM_VENDA').AsString <> strDocumentoAnterior then
      begin
        strDocumentoAnterior := cdsRelatorioNotasEntrada.FieldByName('AUTOINCREM_VENDA').AsString;

        cdsRelatorioNotasSaida.Append;
        cdsRelatorioNotasSaida.FieldByName('DOCUMENTO').AsString := qryAux.FieldByName('DOCUMENTO').AsString;
        cdsRelatorioNotasSaida.FieldByName('DATA_EMISSAO').AsDateTime := qryAux.FieldByName('DET_DTAENT').AsDateTime;
        cdsRelatorioNotasSaida.FieldByName('CLIENTE').AsString := qryAux.FieldByName('CLIENTE').AsString;
        cdsRelatorioNotasSaida.FieldByName('ESTADO').AsString := qryAux.FieldByName('DET_ESTADO').AsString;
        cdsRelatorioNotasSaida.FieldByName('CODITE').AsString := qryAux.FieldByName('CODITE').AsString;
        cdsRelatorioNotasSaida.FieldByName('REFERENCIA').AsString := qryAux.FieldByName('DET_REFERE').AsString;
        cdsRelatorioNotasSaida.FieldByName('UNIDADE').AsString := qryAux.FieldByName('UNIDADE').AsString;
        cdsRelatorioNotasSaida.FieldByName('QUANTIDADE').AsFloat := qryAux.FieldByName('DET_QTDITE').AsFloat;
        cdsRelatorioNotasSaida.FieldByName('CFOP').AsString := qryAux.FieldByName('DET_CLAFIS').AsString;
        cdsRelatorioNotasSaida.FieldByName('VLR_CONTABIL').AsFloat := qryAux.FieldByName('DET_VLRCON').AsFloat;
        cdsRelatorioNotasSaida.FieldByName('VLR_ICMS').AsFloat := qryAux.FieldByName('DET_VALICM').AsFloat;
        cdsRelatorioNotasSaida.FieldByName('VLR_ICMS_ST').AsFloat := qryAux.FieldByName('DET_VALRET').AsFloat;
        cdsRelatorioNotasSaida.FieldByName('VLR_DIFAL_ORIGEM').AsFloat := qryAux.FieldByName('ICD_VALORI').AsFloat;
        cdsRelatorioNotasSaida.FieldByName('VLR_DIFAL_DESTINO').AsFloat := qryAux.FieldByName('ICD_VALDES').AsFloat;
        cdsRelatorioNotasSaida.FieldByName('AUTOINCREM').AsString := cdsRelatorioNotasEntrada.FieldByName('AUTOINCREM_VENDA').AsString;
        cdsRelatorioNotasSaida.FieldByName('TABELA').AsString := cdsRelatorioNotasEntrada.FieldByName('TABELA_VENDA').AsString;
        cdsRelatorioNotasSaida.Post;
      end;

      cdsRelatorioNotasEntrada.Next;
    end;
  finally
    qryAux.Free;
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCarregaDadosTabelaCat158(stlListaAutoIncrem: TStringList);
  var
    itemNotaUtilizada: TItemNotaValidacao;
    qryAux: TUniQuery;
begin
  listaNotasUtilizadas.Clear;

  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := ' SELECT * FROM CAT_158 WHERE LOCATE(CAT_SEQGER, :INCREM) > 0 ';
      ParamByName('INCREM').AsString := stlListaAutoIncrem.CommaText;
      Open;

      First;
      while not Eof do
      begin
        itemNotaUtilizada := TItemNotaValidacao.Create;
        itemNotaUtilizada.strAutoIncrem := FieldByName('AUTOINCREM').AsString;
        itemNotaUtilizada.strSeqGer := FieldByName('CAT_SEQGER').AsString;
        itemNotaUtilizada.fltQuantidadeUtilizada := FieldByName('CAT_QTDUTI').AsFloat;
        itemNotaUtilizada.fltQuantidadeTotal := FieldByName('CAT_TOTAL_').AsFloat;
        listaNotasUtilizadas.Add(itemNotaUtilizada);

        Next;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCarregaDadosTabelaCat158;
  var
    itemNotaUtilizada: TItemNotaValidacao;
    qryAux: TUniQuery;
begin
  listaNotasUtilizadas.Clear;

  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := ' SELECT * FROM CAT_158 WHERE CAT_QTDUTI <> CAT_TOTAL_ ';
      Open;

      First;
      while not Eof do
      begin
        itemNotaUtilizada := TItemNotaValidacao.Create;
        itemNotaUtilizada.strAutoIncrem := FieldByName('AUTOINCREM').AsString;
        itemNotaUtilizada.strSeqGer := FieldByName('CAT_SEQGER').AsString;
        itemNotaUtilizada.fltQuantidadeUtilizada := FieldByName('CAT_QTDUTI').AsFloat;
        itemNotaUtilizada.fltQuantidadeTotal := FieldByName('CAT_TOTAL_').AsFloat;
        listaNotasUtilizadas.Add(itemNotaUtilizada);

        Next;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCarregaDataSetEntrada(objCalculoImpostos: ICalculaImpostosCat158;
  qryDadosEntrada: TUniQuery; fltQuantidadeUtilizada: Double);
begin
  if ((chkNaoEnviarValorZeradoIcmsSt.Checked) and
     (qryDadosEntrada.FieldByName('BASE_ICM_UNITAR').AsFloat > 0) and
     (fFormataFloat((qryDadosEntrada.FieldByName('VALOR_ICM_UNITAR').AsFloat * fltQuantidadeUtilizada), 003) > 0) and
     (objCalculoImpostos.fRetBaseSt > 0) and
     (objCalculoImpostos.fRetValorSt > 0)) or
     (not(chkNaoEnviarValorZeradoIcmsSt.Checked)) then
  begin
    cdsRelatorioNotasEntrada.Append;
    cdsRelatorioNotasEntrada.FieldByName('DATA').AsDateTime := qryDadosEntrada.FieldByName('DET_DTAENT').AsDateTime;
    cdsRelatorioNotasEntrada.FieldByName('DOCUMENTO').AsString := qryDadosEntrada.FieldByName('DOCUMENTO').AsString;
    cdsRelatorioNotasEntrada.FieldByName('FORNECEDOR').AsString := qryDadosEntrada.FieldByName('FORNECEDOR').AsString;
    cdsRelatorioNotasEntrada.FieldByName('QUANTIDADE').AsFloat := fltQuantidadeUtilizada;
    cdsRelatorioNotasEntrada.FieldByName('TOTAL_PRODUTO').AsFloat := fFormataFloat(fRetValorProporcional(qryDadosEntrada.FieldByName('DET_QTDITE').AsFloat,
                                                                                                         fltQuantidadeUtilizada,
                                                                                                         qryDadosEntrada.FieldByName('VALOR_PRODUTO').AsFloat), 002);
    cdsRelatorioNotasEntrada.FieldByName('BASE_ICMS').AsFloat := qryDadosEntrada.FieldByName('BASE_ICM_UNITAR').AsFloat; //necessario apenas um valor de base para verificar se será transmitido para o sped
    cdsRelatorioNotasEntrada.FieldByName('VALOR_ICMS').AsFloat := fFormataFloat((qryDadosEntrada.FieldByName('VALOR_ICM_UNITAR').AsFloat * fltQuantidadeUtilizada), 003);
    cdsRelatorioNotasEntrada.FieldByName('BASE_ST').AsFloat := objCalculoImpostos.fRetBaseSt; //necessário apenas um valor de BASE_ST para verificar se tem base
    cdsRelatorioNotasEntrada.FieldByName('VALORST').AsFloat := objCalculoImpostos.fRetValorSt;
    cdsRelatorioNotasEntrada.FieldByName('VALORIPI').AsFloat := fFormataFloat(fRetValorProporcional(qryDadosEntrada.FieldByName('DET_QTDITE').AsFloat,
                                                                                                    fltQuantidadeUtilizada,
                                                                                                    qryDadosEntrada.FieldByName('IPI_ENTRADA').AsFloat), 002);
    cdsRelatorioNotasEntrada.FieldByName('AUTOINCREM_VENDA').AsString := qryRelatorio.qryQuery.FieldByName('AUTOINCREM').AsString;
    cdsRelatorioNotasEntrada.FieldByName('AUTOINCREM_COMPRA').AsString := qryDadosEntrada.FieldByName('AUTOINCREM').AsString;
    cdsRelatorioNotasEntrada.FieldByName('TABELA_VENDA').AsString := qryRelatorio.qryQuery.FieldByName('TABELA').AsString;
    cdsRelatorioNotasEntrada.FieldByName('ACESSO').AsString := qryDadosEntrada.FieldByName('CHAVE_ACESSO').AsString;
    cdsRelatorioNotasEntrada.Post;
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCarregaLayoutImpressao;
  var
    frxReport: TFrxReport;
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  cdsRelatorioNotasSaida.IndexFieldNames := 'DOCUMENTO';

  if edtDestino.Text = 'E' then
    pAbreExcel
  else
  begin
    frxReport := frxReportJ;

    frxReport.Script.Variables['NOMEMP'] := fCadEmp('NOMEMP');
    frxReport.Script.Variables['NOMREL'] := 'Ressarcimento do imposto retido por sujeição passiva por substituição';
    frxReport.Script.Variables['REFERE'] := 'REFERENTE AO PERÍODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
    frxReport.Script.Variables['CODEMP'] := fStrTitulo(edtCodEmp.Text, edtNomEmp, arrCodEmp, strCodEmp, 'EMPRESA', TRUE);
    frxReport.Script.Variables['DOCUMENTO'] := fStrTitulo(edtDocumento.Text, nil, nil, '', 'DOCUMENTO', FALSE);
    frxReport.Script.Variables['CLAFIS'] := fStrTitulo(edtCodClaFis.Text, edtDesClaFis, arrClasFiscal, strClafis, 'CFOP', TRUE);
    frxReport.Script.Variables['MSG1'] := '* Quando houver falta de uma das informações da operação própria ou do ICMS ST, não será enviado ' +
    'ao SPED, somente mostrado no relatório. ';

    if frxReport.PrepareReport then
    begin
      frxReport.PrintOptions.PrintMode:= pmScale;
      frxReport.PrintOptions.PrintOnSheet := 9;

      if edtDestino.Text = 'V' then
        pPreviewReport(Self.Name, Self.Caption, frxReport)
      else
        pPrintReport(Self.Name, Self.Caption, strNomImp, frxReport);
    end;
  end
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pCarregaTotaisSintetico;
begin
  //Carregas os totais dos impostos de saida e entrada e o ressarcimento
  cdsRelatorioSintetico.Edit;
  cdsRelatorioSintetico.FieldByName('TOTAL_SAIDA').AsFloat := fFormataFloat(cdsRelatorioSintetico.FieldByName('ICMS_SAIDA').AsFloat +
                                                              cdsRelatorioSintetico.FieldByName('DIFAL_SAIDA').AsFloat, 2);
  cdsRelatorioSintetico.FieldByName('TOTAL_ENTRADA').AsFloat := fFormataFloat(cdsRelatorioSintetico.FieldByName('ICMS_ENTRADA').AsFloat +
                                                                cdsRelatorioSintetico.FieldByName('ICMS_ST_ENTRADA').AsFloat +
                                                                cdsRelatorioSintetico.FieldByName('IPI_ENTRADA').AsFloat, 2);
  cdsRelatorioSintetico.Post;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pFormataCamposDataSet;
begin
  TFloatField(cdsRelatorioNotasSaida.FieldByName('VLR_CONTABIL')).EditFormat := '#,##0.00';
  TFloatField(cdsRelatorioNotasSaida.FieldByName('VLR_CONTABIL')).DisplayFormat := '#,##0.00';

  TFloatField(cdsRelatorioNotasSaida.FieldByName('VLR_ICMS')).EditFormat := '#,##0.00';
  TFloatField(cdsRelatorioNotasSaida.FieldByName('VLR_ICMS')).DisplayFormat := '#,##0.00';

  TFloatField(cdsRelatorioNotasSaida.FieldByName('VLR_DIFAL_ORIGEM')).EditFormat := '#,##0.00';
  TFloatField(cdsRelatorioNotasSaida.FieldByName('VLR_DIFAL_ORIGEM')).DisplayFormat := '#,##0.00';

  TFloatField(cdsRelatorioNotasSaida.FieldByName('VLR_DIFAL_DESTINO')).EditFormat := '#,##0.00';
  TFloatField(cdsRelatorioNotasSaida.FieldByName('VLR_DIFAL_DESTINO')).DisplayFormat := '#,##0.00';

  TFloatField(cdsRelatorioNotasEntrada.FieldByName('QUANTIDADE')).EditFormat := '#,##0.00';
  TFloatField(cdsRelatorioNotasEntrada.FieldByName('QUANTIDADE')).DisplayFormat := '#,##0.00';

  TFloatField(cdsRelatorioNotasEntrada.FieldByName('VALOR_ICMS')).EditFormat := '#,##0.000';
  TFloatField(cdsRelatorioNotasEntrada.FieldByName('VALOR_ICMS')).DisplayFormat := '#,##0.000';

  TFloatField(cdsRelatorioNotasEntrada.FieldByName('VALORST')).EditFormat := '#,##0.000';
  TFloatField(cdsRelatorioNotasEntrada.FieldByName('VALORST')).DisplayFormat := '#,##0.000';

  TFloatField(cdsRelatorioNotasEntrada.FieldByName('VALORIPI')).EditFormat := '#,##0.00';
  TFloatField(cdsRelatorioNotasEntrada.FieldByName('VALORIPI')).DisplayFormat := '#,##0.00';

  TFloatField(cdsRelatorioNotasEntrada.FieldByName('TOTAL_PRODUTO')).EditFormat := '#,##0.00';
  TFloatField(cdsRelatorioNotasEntrada.FieldByName('TOTAL_PRODUTO')).DisplayFormat := '#,##0.00';
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pImprimeDetalhes(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
  var
    fltTotIcms, fltTotSt, fltTotIpi: Double;
begin
  fltTotIcms := 0;
  fltTotSt := 0;
  fltTotIpi := 0;

  fFiltraItemNotasEntradas(Dados.FieldByName('AUTOINCREM').AsString, Dados.FieldByName('TABELA').AsString);

  with Excel do
  begin
    ProximaLinha;
    Escrever(LinhaAtual, 01, 'DT. EMISSÃO');
    Escrever(LinhaAtual, 02, 'DOCUMENTO');
    Escrever(LinhaAtual, 03, 'FORNECEDOR');
    Escrever(LinhaAtual, 04, 'QUANTIDADE');
    Escrever(LinhaAtual, 05, 'VALOR ICMS');
    Escrever(LinhaAtual, 06, 'VALOR ST');
    Escrever(LinhaAtual, 07, 'VALOR IPI');

    cdsRelatorioNotasEntrada.First;
    while not cdsRelatorioNotasEntrada.Eof do
    begin
      ProximaLinha;
      Escrever(LinhaAtual, 01, cdsRelatorioNotasEntrada.FieldByName('DATA').AsString);
      Escrever(LinhaAtual, 02, cdsRelatorioNotasEntrada.FieldByName('DOCUMENTO').AsString);
      Escrever(LinhaAtual, 03, cdsRelatorioNotasEntrada.FieldByName('FORNECEDOR').AsString);
      Escrever(LinhaAtual, 04, cdsRelatorioNotasEntrada.FieldByName('QUANTIDADE').AsFloat);
      Escrever(LinhaAtual, 05, cdsRelatorioNotasEntrada.FieldByName('VALOR_ICMS').AsFloat);
      Escrever(LinhaAtual, 06, cdsRelatorioNotasEntrada.FieldByName('VALORST').AsFloat);
      Escrever(LinhaAtual, 07, cdsRelatorioNotasEntrada.FieldByName('VALORIPI').AsFloat);

      fltTotIcms := fltTotIcms + cdsRelatorioNotasEntrada.FieldByName('VALOR_ICMS').AsFloat;
      fltTotSt := fltTotSt + cdsRelatorioNotasEntrada.FieldByName('VALORST').AsFloat;
      fltTotIpi := fltTotIpi + cdsRelatorioNotasEntrada.FieldByName('VALORIPI').AsFloat;

      cdsRelatorioNotasEntrada.Next;
    end;

    ProximaLinha;
    Escrever(LinhaAtual, 04, 'TOTAL: ');

    Escrever(LinhaAtual, 05, fltTotIcms);
    Escrever(LinhaAtual, 06, fltTotSt);
    Escrever(LinhaAtual, 07, fltTotIpi);

    Negrito('A' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual), True);
    Alinhamento('A' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual), Direita);
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pInicializaClient;
begin
  cdsRelatorioNotasSaida.EmptyDataSet;
  cdsRelatorioNotasSaida.Filter := '';
  cdsRelatorioNotasSaida.Filtered := False;

  cdsRelatorioNotasEntrada.EmptyDataSet;
  cdsRelatorioNotasEntrada.Filter := '';
  cdsRelatorioNotasEntrada.Filtered := False;

  cdsRelatorioSintetico.EmptyDataSet;
  cdsRelatorioSintetico.Filter := '';
  cdsRelatorioSintetico.Filtered := False;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
  Var
    strLegend: String;
begin
  with Excel do
  begin
    strLegend := 'TOTAL GERAL: ';

    ProximaLinha;
    Escrever(LinhaAtual, Campos.ColunaPorNome['VLR_CONTABIL'].Coluna - 1, strLegend);
    Mesclar('A' + IntToStr(LinhaAtual), 'B' + IntToStr(LinhaAtual));

    Escrever(LinhaAtual, Campos.ColunaPorNome['VLR_CONTABIL'].Coluna, fFormataFloat(Quebra.Totais['VLR_CONTABIL'], 2));
    FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['VLR_CONTABIL'].Coluna);
    Escrever(LinhaAtual, Campos.ColunaPorNome['VLR_ICMS'].Coluna, fFormataFloat(Quebra.Totais['VLR_ICMS'], 2));
    FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['VLR_ICMS'].Coluna);
    Escrever(LinhaAtual, Campos.ColunaPorNome['VLR_ICMS_ST'].Coluna, fFormataFloat(Quebra.Totais['VLR_ICMS_ST'], 2));
    FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['VLR_ICMS_ST'].Coluna);
    Escrever(LinhaAtual, Campos.ColunaPorNome['VLR_DIFAL_ORIGEM'].Coluna, fFormataFloat(Quebra.Totais['VLR_DIFAL_ORIGEM'], 2));
    FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['VLR_DIFAL_ORIGEM'].Coluna);
    Escrever(LinhaAtual, Campos.ColunaPorNome['VLR_DIFAL_DESTINO'].Coluna, fFormataFloat(Quebra.Totais['VLR_DIFAL_DESTINO'], 2));
    FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['VLR_DIFAL_DESTINO'].Coluna);

    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);

    ProximaLinha;
    ProximaLinha;

    Escrever(LinhaAtual, 1, 'SAÍDAS');
    Mesclar    ('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
    Negrito    ('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Preto);
    CorFonte   ('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Branco);
    Bordas     ('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual), Centro);

    Escrever(LinhaAtual, 4, 'ENTRADAS');
    Mesclar    ('D' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual));
    Alinhamento('D' + IntToStr(LinhaAtual), 'H' + IntToStr(LinhaAtual), Centro);

    Escrever(LinhaAtual, 09, 'RESSARCIMENTO');
    Mesclar    ('I' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));
    Alinhamento('I' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Centro);

    ProximaLinha;
    Escrever(LinhaAtual, 01, 'VLR. ICMS');
    Escrever(LinhaAtual, 02, 'VLR. DIFAL');
    Escrever(LinhaAtual, 03, 'TOTAL');
    Escrever(LinhaAtual, 04, 'VLR. CONTÁBIL');
    Escrever(LinhaAtual, 05, 'VLR. ICMS');
    Escrever(LinhaAtual, 06, 'VLR. ICMS ST');
    Escrever(LinhaAtual, 07, 'VLR. IPI');
    Escrever(LinhaAtual, 08, 'TOTAL ENTRADAS');

    Negrito    ('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Preto);
    CorFonte   ('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Branco);
    Bordas     ('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Direita);

    ProximaLinha;
    Escrever(LinhaAtual, 01, cdsRelatorioSintetico.FieldByName('ICMS_SAIDA').AsFloat);
    FormatoNumerico(LinhaAtual, 01);
    Escrever(LinhaAtual, 02, cdsRelatorioSintetico.FieldByName('DIFAL_SAIDA').AsFloat);
    FormatoNumerico(LinhaAtual, 02);
    Escrever(LinhaAtual, 03, cdsRelatorioSintetico.FieldByName('TOTAL_SAIDA').AsFloat);
    FormatoNumerico(LinhaAtual, 03);
    Escrever(LinhaAtual, 04, cdsRelatorioSintetico.FieldByName('VLRCON_ENTRADA').AsFloat);
    FormatoNumerico(LinhaAtual, 04);
    Escrever(LinhaAtual, 05, cdsRelatorioSintetico.FieldByName('ICMS_ENTRADA').AsFloat);
    FormatoNumerico(LinhaAtual, 05);
    Escrever(LinhaAtual, 06, cdsRelatorioSintetico.FieldByName('ICMS_ST_ENTRADA').AsFloat);
    FormatoNumerico(LinhaAtual, 06);
    Escrever(LinhaAtual, 07, cdsRelatorioSintetico.FieldByName('IPI_ENTRADA').AsFloat);
    FormatoNumerico(LinhaAtual, 07);
    Escrever(LinhaAtual, 08, cdsRelatorioSintetico.FieldByName('TOTAL_ENTRADA').AsFloat);
    FormatoNumerico(LinhaAtual, 07);
    Escrever(LinhaAtual, 09, cdsRelatorioSintetico.FieldByName('ICMS_ST_ENTRADA').AsFloat);
    FormatoNumerico(LinhaAtual, 09);

    Bordas     ('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));
    Alinhamento('A' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual), Direita);
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pRegistraCreditoICM;
  procedure pExecutaItemNotaVendidoRelacionado(qryAux: TUniQuery; itemNotaVendidoRelacionado: TItemNotaVendidoRelacionado);
  begin
    with qryAux do
    begin
      ParamByName('AUTOINCREM').AsString := itemNotaVendidoRelacionado.strAutoIncrem;
      ParamByName('CAT_INCREC').AsString := itemNotaVendidoRelacionado.strAutoIncremCompra;
      ParamByName('CAT_DTAENT').AsDateTime := itemNotaVendidoRelacionado.dtaDataCompra;
      ParamByName('CAT_CODMOD').AsString := itemNotaVendidoRelacionado.strModeloNfCompra;
      ParamByName('CAT_NUMDOC').AsString := itemNotaVendidoRelacionado.strDocumentoNfCompra;
      ParamByName('CAT_SERIE_').AsString := itemNotaVendidoRelacionado.strSerieNfCompra;
      ParamByName('CAT_CODFOR').AsString := itemNotaVendidoRelacionado.strParticipanteNfCompra;
      ParamByName('CAT_QTDUTI').AsFloat := itemNotaVendidoRelacionado.fltQuantidadeUtilizadaNfCompra;
      ParamByName('CAT_UNITAR').AsFloat := itemNotaVendidoRelacionado.fltValorUnitarioNfCompra;
      ParamByName('CAT_UNITST').AsFloat := itemNotaVendidoRelacionado.fltValorUnitarioBaseStNfCompra;
      ParamByName('CAT_CODITE').AsString := itemNotaVendidoRelacionado.strCodigoProdutoUtilizadoRessarcimento;
      ParamByName('CAT_TOTBST').AsFloat := itemNotaVendidoRelacionado.fltTotalUtilizadoBaseIcmST;
      ParamByName('CAT_ALQIST').AsFloat := itemNotaVendidoRelacionado.fltAlqIcmsST;
      ParamByName('CAT_TOTVST').AsFloat := itemNotaVendidoRelacionado.fltTotalUtilizadoValorIcmST;
      ParamByName('CAT_INCREV').AsString := itemNotaVendidoRelacionado.strAutoIncremVenda;
      ParamByName('CAT_UNBICM').AsFloat := itemNotaVendidoRelacionado.fltValorUnitarioBaseIcmNfCompra;
      ParamByName('CAT_UNAICM').AsFloat := itemNotaVendidoRelacionado.fltValorAlqIcmNfCompra;
      ParamByName('CAT_UNVICM').AsFloat := itemNotaVendidoRelacionado.fltValorUnitarioIcmNfCompra;
      ParamByName('CAT_ACESSO').AsString := itemNotaVendidoRelacionado.strChaveAcesso;
      ParamByName('CAT_TABELA').AsString := itemNotaVendidoRelacionado.strTabela;
      ParamByName('CAT_MESANO').AsString := FormatDateTime('MM/YYYY', StrToDate(mskDtaIni.Text));
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ExecSQL;
    end;
  end;

  var
    itemNotaVendidoRelacionado: TItemNotaVendidoRelacionado;
    itemNotaUtilizada: TItemNotaValidacao;
    qryReplace: TUniQuery;
    intContador: Integer;
begin
  pgbProgresso.Visible := True;

  if listaNotasUtilizadas.Count > 0 then
    pgbProgresso.Max := listaNotasUtilizadas.Count - 1;

  pgbProgresso.Position := 0;

  qryReplace := fCriaQuery(nil);
  try
    with qryReplace do
    begin
      Close;
      SQL.Clear;
      SQL.Add('REPLACE INTO CAT_158( ');
      SQL.Add(' AUTOINCREM, CAT_SEQGER, CAT_QTDUTI, CAT_TOTAL_) ');
      SQL.Add(' VALUES ( ');
      SQL.Add(' :AUTOINCREM, :CAT_SEQGER, :CAT_QTDUTI, :CAT_TOTAL_) ');

      for intContador := 0 to listaNotasUtilizadas.Count - 1 do
      begin
        itemNotaUtilizada := TItemNotaValidacao(listaNotasUtilizadas[intContador]);

        Close;
        ParamByName('AUTOINCREM').AsString := itemNotaUtilizada.strAutoIncrem;
        ParamByName('CAT_SEQGER').AsString := itemNotaUtilizada.strSeqGer;
        ParamByName('CAT_QTDUTI').AsFloat := itemNotaUtilizada.fltQuantidadeUtilizada;
        ParamByName('CAT_TOTAL_').AsFloat := itemNotaUtilizada.fltQuantidadeTotal;
        ExecSQL;

        pgbProgresso.StepBy(1);
        Application.ProcessMessages;
      end;

      if listaNotasVendidasRessarcidas.Count > 0 then
        pgbProgresso.Max := listaNotasVendidasRessarcidas.Count - 1;

      pgbProgresso.Position := 0;

      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO CAT_158_SPED( ');
      SQL.Add(' AUTOINCREM, CAT_INCREC, CAT_DTAENT, CAT_CODMOD, CAT_NUMDOC, CAT_SERIE_, CAT_CODFOR, ');
      SQL.Add(' CAT_QTDUTI, CAT_UNITAR, CAT_UNITST, CAT_CODITE, CAT_TOTBST, CAT_ALQIST, CAT_TOTVST, CAT_INCREV, ');
      SQL.Add(' CAT_UNBICM, CAT_UNAICM, CAT_UNVICM, CAT_ACESSO, CAT_TABELA, CAT_MESANO, CAT_CODEMP) ');
      SQL.Add(' VALUES ( ');
      SQL.Add(' :AUTOINCREM, :CAT_INCREC, :CAT_DTAENT, :CAT_CODMOD, :CAT_NUMDOC, :CAT_SERIE_, :CAT_CODFOR, ');
      SQL.Add(' :CAT_QTDUTI, :CAT_UNITAR, :CAT_UNITST, :CAT_CODITE, :CAT_TOTBST, :CAT_ALQIST, :CAT_TOTVST, :CAT_INCREV, ');
      SQL.Add(' :CAT_UNBICM, :CAT_UNAICM, :CAT_UNVICM, :CAT_ACESSO, :CAT_TABELA, :CAT_MESANO, :CODEMP) ');

      for intContador := 0 to listaNotasVendidasRessarcidas.Count - 1 do
      begin
        Close;

        itemNotaVendidoRelacionado := TItemNotaVendidoRelacionado(listaNotasVendidasRessarcidas[intContador]);

        if chkNaoEnviarValorZeradoIcmsSt.Checked then
        begin
          if (itemNotaVendidoRelacionado.fltValorUnitarioBaseStNfCompra > 0) and
             (itemNotaVendidoRelacionado.fltTotalUtilizadoValorIcmST > 0) and
             (itemNotaVendidoRelacionado.fltValorUnitarioBaseIcmNfCompra > 0) and
             (itemNotaVendidoRelacionado.fltValorUnitarioIcmNfCompra > 0) then
          begin
            pExecutaItemNotaVendidoRelacionado(qryReplace, itemNotaVendidoRelacionado);
          end;
        end
        else
        begin
          pExecutaItemNotaVendidoRelacionado(qryReplace, itemNotaVendidoRelacionado);
        end;

        pgbProgresso.StepBy(1);
        Application.ProcessMessages;
      end;
    end;
  finally
    qryReplace.Free;
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pRegistraDadosRelatorioImpresso;
  function fRetSQLInsertEntradas: string;
  begin
    result := '';
    result := result + 'INSERT INTO CAT_158_ENTRADA( ';
    result := result + '  AUTOINCREM, ';
    result := result + '  CAT_MESANO, ';
    result := result + '  CAT_DTAENT, ';
    result := result + '  CAT_NUMDOC, ';
    result := result + '  CAT_FORNEC, ';
    result := result + '  CAT_QTDITE, ';
    result := result + '  CAT_VLRCON, ';
    result := result + '  CAT_VALICM, ';
    result := result + '  CAT_VALRET, ';
    result := result + '  CAT_VALIPI, ';
    result := result + '  CAT_INCVEN, ';
    result := result + '  CAT_INCCOM, ';
    result := result + '  CAT_BASICM, ';
    result := result + '  CAT_BASRET, ';
    result := result + '  CAT_TABELA, ';
    result := result + '  CAT_CODEMP ) ';
    result := result + 'VALUES (';
    result := result + '  :AUTOINCREM, ';
    result := result + '  :MESANO, ';
    result := result + '  :DTAENT, ';
    result := result + '  :NUMDOC, ';
    result := result + '  :FORNEC, ';
    result := result + '  :QTDITE, ';
    result := result + '  :VLRCON, ';
    result := result + '  :VALICM, ';
    result := result + '  :VALRET, ';
    result := result + '  :VALIPI, ';
    result := result + '  :INCVEN, ';
    result := result + '  :INCCOM, ';
    result := result + '  :BASICM, ';
    result := result + '  :BASRET, ';
    result := result + '  :TABELA, ';
    result := result + '  :CODEMP )';
  end;

  function fRetSQLInsertSaidas: string;
  begin
    result := '';
    result := result + 'INSERT INTO CAT_158_SAIDAS( ';
    result := result + '  AUTOINCREM, ';
    result := result + '  CAT_MESANO, ';
    result := result + '  CAT_NUMDOC, ';
    result := result + '  CAT_DTAENT, ';
    result := result + '  CAT_CLIENT, ';
    result := result + '  CAT_ESTADO, ';
    result := result + '  CAT_CODITE, ';
    result := result + '  CAT_REFERE, ';
    result := result + '  CAT_UNIDAD, ';
    result := result + '  CAT_QTDITE, ';
    result := result + '  CAT_CLAFIS, ';
    result := result + '  CAT_VLRCON, ';
    result := result + '  CAT_VALICM, ';
    result := result + '  CAT_VALRET, ';
    result := result + '  CAT_DIFORI, ';
    result := result + '  CAT_DIFDES, ';
    result := result + '  CAT_INCVEN, ';
    result := result + '  CAT_TABELA, ';
    result := result + '  CAT_CODEMP) ';
    result := result + 'VALUES (';
    result := result + '  :AUTOINCREM, ';
    result := result + '  :MESANO, ';
    result := result + '  :NUMDOC, ';
    result := result + '  :DTAENT, ';
    result := result + '  :CLIENT, ';
    result := result + '  :ESTADO, ';
    result := result + '  :CODITE, ';
    result := result + '  :REFERE, ';
    result := result + '  :UNIDAD, ';
    result := result + '  :QTDITE, ';
    result := result + '  :CLAFIS, ';
    result := result + '  :VLRCON, ';
    result := result + '  :VALICM, ';
    result := result + '  :VALRET, ';
    result := result + '  :DIFORI, ';
    result := result + '  :DIFDES, ';
    result := result + '  :INCVEN, ';
    result := result + '  :TABELA, ';
    result := result + '  :CODEMP )';
  end;

  var
    qryInsert: TUniQuery;
begin
  cdsRelatorioNotasEntrada.Filtered := False;
  cdsRelatorioNotasSaida.Filtered := False;

  qryInsert := fCriaQuery(nil);
  try
    with qryInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := fRetSQLInsertEntradas;

      pgbProgresso.Position := 0;
      pgbProgresso.Max := cdsRelatorioNotasEntrada.RecordCount;

      cdsRelatorioNotasEntrada.First;
      while not cdsRelatorioNotasEntrada.Eof do
      begin
        if ((chkNaoEnviarValorZeradoIcmsSt.Checked) and
           (cdsRelatorioNotasEntrada.FieldByName('BASE_ICMS').AsFloat > 0) and
           (cdsRelatorioNotasEntrada.FieldByName('VALOR_ICMS').AsFloat > 0) and
           (cdsRelatorioNotasEntrada.FieldByName('BASE_ST').AsFloat > 0) and
           (cdsRelatorioNotasEntrada.FieldByName('VALORST').AsFloat > 0)) or
           (not (chkNaoEnviarValorZeradoIcmsSt.Checked)) then
        begin
          Close;
          ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CAT_158_ENTRADA', VS_strCodEmp);
          ParamByName('MESANO').AsString := FormatDateTime('MM/YYYY', StrToDate(mskDtaIni.Text));
          ParamByName('DTAENT').AsDateTime := cdsRelatorioNotasEntrada.FieldByName('DATA').AsDateTime;
          ParamByName('NUMDOC').AsString := cdsRelatorioNotasEntrada.FieldByName('DOCUMENTO').AsString;
          ParamByName('FORNEC').AsString := cdsRelatorioNotasEntrada.FieldByName('FORNECEDOR').AsString;
          ParamByName('QTDITE').AsFloat := cdsRelatorioNotasEntrada.FieldByName('QUANTIDADE').AsFloat;
          ParamByName('VLRCON').AsFloat := cdsRelatorioNotasEntrada.FieldByName('TOTAL_PRODUTO').AsFloat;
          ParamByName('VALICM').AsFloat := cdsRelatorioNotasEntrada.FieldByName('VALOR_ICMS').AsFloat;
          ParamByName('VALRET').AsFloat := cdsRelatorioNotasEntrada.FieldByName('VALORST').AsFloat;
          ParamByName('VALIPI').AsFloat := cdsRelatorioNotasEntrada.FieldByName('VALORIPI').AsFloat;
          ParamByName('INCVEN').AsString := cdsRelatorioNotasEntrada.FieldByName('AUTOINCREM_VENDA').AsString;
          ParamByName('INCCOM').AsString := cdsRelatorioNotasEntrada.FieldByName('AUTOINCREM_COMPRA').AsString;
          ParamByName('BASICM').AsFloat := cdsRelatorioNotasEntrada.FieldByName('BASE_ICMS').AsFloat;
          ParamByName('BASRET').AsFloat := cdsRelatorioNotasEntrada.FieldByName('BASE_ST').AsFloat;
          ParamByName('TABELA').AsString := cdsRelatorioNotasEntrada.FieldByName('TABELA_VENDA').AsString;
          ParamByName('CODEMP').AsString := edtCodEmp.Text;//CODIGO DA EMPRESA
          ExecSQL;
        end;

        pgbProgresso.StepBy(1);
        Application.ProcessMessages;

        cdsRelatorioNotasEntrada.Next;
      end;

      Close;
      SQL.Clear;
      SQL.Text := fRetSQLInsertSaidas;

      pgbProgresso.Position := 0;
      pgbProgresso.Max := cdsRelatorioNotasSaida.RecordCount;

      cdsRelatorioNotasSaida.First;
      while not cdsRelatorioNotasSaida.Eof do
      begin
        Close;
        ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CAT_158_SAIDAS', VS_strCodEmp);
        ParamByName('MESANO').AsString := FormatDateTime('MM/YYYY', StrToDate(mskDtaIni.Text));
        ParamByName('NUMDOC').AsString := cdsRelatorioNotasSaida.FieldByName('DOCUMENTO').AsString;
        ParamByName('DTAENT').AsDateTime := cdsRelatorioNotasSaida.FieldByName('DATA_EMISSAO').AsDateTime;
        ParamByName('CLIENT').AsString := cdsRelatorioNotasSaida.FieldByName('CLIENTE').AsString;
        ParamByName('ESTADO').AsString := cdsRelatorioNotasSaida.FieldByName('ESTADO').AsString;
        ParamByName('CODITE').AsString := cdsRelatorioNotasSaida.FieldByName('CODITE').AsString;
        ParamByName('REFERE').AsString := cdsRelatorioNotasSaida.FieldByName('REFERENCIA').AsString;
        ParamByName('UNIDAD').AsString := cdsRelatorioNotasSaida.FieldByName('UNIDADE').AsString;
        ParamByName('QTDITE').AsFloat := cdsRelatorioNotasSaida.FieldByName('QUANTIDADE').AsFloat;
        ParamByName('CLAFIS').AsString := cdsRelatorioNotasSaida.FieldByName('CFOP').AsString;
        ParamByName('VLRCON').AsFloat := cdsRelatorioNotasSaida.FieldByName('VLR_CONTABIL').AsFloat;
        ParamByName('VALICM').AsFloat := cdsRelatorioNotasSaida.FieldByName('VLR_ICMS').AsFloat;
        ParamByName('VALRET').AsFloat := cdsRelatorioNotasSaida.FieldByName('VLR_ICMS_ST').AsFloat;
        ParamByName('DIFORI').AsFloat := cdsRelatorioNotasSaida.FieldByName('VLR_DIFAL_ORIGEM').AsFloat;
        ParamByName('DIFDES').AsFloat := cdsRelatorioNotasSaida.FieldByName('VLR_DIFAL_DESTINO').AsFloat;
        ParamByName('INCVEN').AsString := cdsRelatorioNotasSaida.FieldByName('AUTOINCREM').AsString; // INCREM DA VENDA
        ParamByName('TABELA').AsString := cdsRelatorioNotasSaida.FieldByName('TABELA').AsString; // TABELA DA VENDA (MOVDET/NOTDET)
        ParamByName('CODEMP').AsString := edtCodEmp.Text;//CODIGO DA EMPRESA
        ExecSQL;

        pgbProgresso.StepBy(1);
        Application.ProcessMessages;

        cdsRelatorioNotasSaida.Next;
      end;
    end;
  finally
    qryInsert.Free;
  end;
end;

procedure TfrmRessarcImpRetidoPorSujeicaoPassivaSubst.pSomaTotais(var Totais: TTotais; Dados: TDataSet);
begin
  Totais['VLR_CONTABIL'] := Totais['VLR_CONTABIL'] + cdsRelatorioNotasSaida.FieldByName('VLR_CONTABIL').AsFloat;
  Totais['VLR_ICMS'] := Totais['VLR_ICMS'] + cdsRelatorioNotasSaida.FieldByName('VLR_ICMS').AsFloat;
  Totais['VLR_ICMS_ST'] := Totais['VLR_ICMS_ST'] + cdsRelatorioNotasSaida.FieldByName('VLR_ICMS_ST').AsFloat;
  Totais['VLR_DIFAL_ORIGEM'] := Totais['VLR_DIFAL_ORIGEM'] + cdsRelatorioNotasSaida.FieldByName('VLR_DIFAL_ORIGEM').AsFloat;
  Totais['VLR_DIFAL_DESTINO'] := Totais['VLR_DIFAL_DESTINO'] + cdsRelatorioNotasSaida.FieldByName('VLR_DIFAL_DESTINO').AsFloat;
end;

end.

