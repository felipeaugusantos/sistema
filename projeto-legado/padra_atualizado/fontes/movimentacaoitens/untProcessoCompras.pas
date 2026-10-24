unit untProcessoCompras;

interface

uses
  Classes,
  SysUtils,
  System.Variants,
  Vcl.Graphics,
  Vcl.Controls,
  cxGridBandedTableView, cxGridDBBandedTableView,
  cxLabel,
  cxTextEdit,
  cxLookAndFeelPainters,
  cxMemo,
  cxGridCustomTableView,
  cxGraphics,
  cxEdit,
  cxGridCustomView,
  cxEditRepositoryItems,
  uni,
  Data.DB,
  cxCurrencyEdit,
  untTypesSistema,
  cxCustomData;

  Const
    STR_REG_DIVERGENCIA  = '0';
    STR_REG_GERAL        = '1';
    STR_REG_ENTRADA_SIMP = '2';
    STR_REG_LOTE_SIMP    = '3';

  type
    ExceptionMessage = class(Exception);
    TStatusProcesso  = (stpNeutro, stpRealizar, stpRealizarDocumento, stpRealizado, stpRealizadoDocumento, stpVisualizar, stpVisualizarDocumento);
    TTipoProcesso    = (tprDivergenciaFiscal, tprNotaFiscal, tprPreNota,
                        tprEntradaMercadoria, tprDataRecebimentoMercadoria, tprConferenciaPreNota, tprEfetivacaoMovimentoFiscal,
                        tprLotePreco, tprEnderecamento, tprDevolucaoPreNota);

    TRealizarProcessoEvent   = procedure(strAutoincrem, strTipFor, strTipReg, srtNomeCampo : String)        of object;
    TVisualizarProcessoEvent = procedure(strAutoincrem, strTipFor, strTipReg, srtNomeCampo : String)        of object;
    TCancelarProcessoEvent   = procedure(strAutoincrem : String)                   of object;
    TAposRealizarEvent       = procedure()                                         of object;
    TGetStatusProcesso       = function(strValor : String)       : TStatusProcesso of object;
    TPodeCancelarProcesso    = function(Fields: TFields)         : boolean         of object;
    TGetProcessoRealizadoDB  = function(strAutoincrem : String)  : boolean         of object;
    TGetProcessoRealizadoCds = function(Fields : TFields)        : boolean         of object;

    TArrColumn = Array Of TcxGridDBBandedColumn;

    TArrCampo = Array Of Record
                           strFieldName,
                           strCaption,
                           strAlternativeCaption,
                           strClassName: String;
                           aliAlignmentHorz: TAlignment;
                           intWidth: Integer;
                           objSummaryKid: TcxSummaryKind;
                           strSummaryFormat: String;
                         end;

    TProcessoComum = class
      const

        COR_REALIZADO = $00804000;
        COR_REALIAR   = $000000EC;

      private
        FProcessando                : boolean;
        FColumn                     : TArrColumn;
        FComumAnterior              : TProcessoComum;
        FComumSeguinte              : TProcessoComum;
        FChaveDireitoAcessoRealizar : String;
        FDataFieldName              : TArrCampo;
        FTitulo: String;

        FOnRealizar                 : TRealizarProcessoEvent;
        FOnVisualizar               : TVisualizarProcessoEvent;
        FOnCancelar                 : TCancelarProcessoEvent;
        FOnAposRealizar             : TAposRealizarEvent;
        FGetStatus                  : TGetStatusProcesso;
        FGetRealizadoDB             : TGetProcessoRealizadoDB;
        FGetPodeCancelar            : TPodeCancelarProcesso;

        procedure pMouseMoveAuxiliar(strValor: String; AGridSite: TcxGridSite; X, Y, ARecordIndex, AColumnIndex: Integer;
                           AGridView: TcxGridDBBandedTableView);

      public

        strLotSim,
        strConSim: String;

        blnAtualizarGrid: Boolean;

        tprTipoProcesso:  TTipoProcesso;
        FCxgFluxoTBV: TcxGridDBBandedTableView;

        Function fColunaSoDisplay(intIndice: Integer): Boolean;

        procedure pRealizar(strAutoincrem, strTipFor, strTipReg, srtNomeCampo, strClaRet : String);
        procedure pVisualizar(strAutoincrem, strTipFor, strTipReg, srtNomeCampo : String);
        procedure pCancelar(strAutoincrem : String);
        procedure pFormataCelula(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

        procedure pExecuta(strValor, strAutoincrem, strTipFor, strTipReg, srtNomeCampo, strClaRet: String);
        procedure pMouseMove(AGridSite: TcxGridSite; X, Y: Integer);

        function fPodeCancelar(Fields: TFields)     : boolean;
        function fGetRealizadoCds(Fields : TFields) : boolean;

        procedure pSetaNumeroColunas(intTamanho: Integer);

        Procedure pIncluiColuna(intPosicao: Integer;
                                strFieldName,
                                strCaption,
                                strAlternativeCaption,
                                strClassName: String;
                                aliAlignmentHorz: TAlignment;
                                intWidth: Integer;
                                objSummaryKid: TcxSummaryKind = skNone;
                                strSummaryFormat: String = '');


        property strChaveDireitoAcessoRealizar : String                   read FChaveDireitoAcessoRealizar write FChaveDireitoAcessoRealizar;
        property stlDataFieldName              : TArrCampo                read FDataFieldName              write FDataFieldName;
        property strTitulo                     : String                   read FTitulo                     write FTitulo;

        property objColumn                     : TArrColumn               read FColumn                     write FColumn;
        property objProcessoComumAnterior      : TProcessoComum           read FComumAnterior              write FComumAnterior;
        property objProcessoComumSeguinte      : TProcessoComum           read FComumSeguinte              write FComumSeguinte;

        property OnRealizar                    : TRealizarProcessoEvent   read FOnRealizar                 write FOnRealizar;
        property OnVisualizar                  : TVisualizarProcessoEvent read FOnVisualizar               write FOnVisualizar;
        property OnCancelar                    : TCancelarProcessoEvent   read FOnCancelar                 write FOnCancelar;
        property OnAposRealizar                : TAposRealizarEvent       read FOnAposRealizar             write FOnAposRealizar;
        property GetStatus                     : TGetStatusProcesso       read FGetStatus                  write FGetStatus;
        property GetRealizadoDB                : TGetProcessoRealizadoDB  read FGetRealizadoDB             write FGetRealizadoDB;
        property GetPodeCancelar               : TPodeCancelarProcesso    read FGetPodeCancelar            write FGetPodeCancelar;

        constructor Create;

        Destructor Destroy;  Override;
    end;

    TProcessoCompras = class
      private
        FComum : TProcessoComum;

        FCxgFluxoTBV: TcxGridDBBandedTableView;

        Function fCampoSemExecuta(strCampo: String): Boolean;

        procedure pGetPropertiesAuxilar(
                 Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
                var AProperties: TcxCustomEditProperties; strValor: String);

        procedure pGetPropertiesRealizaVisualiza(
          Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
          var AProperties: TcxCustomEditProperties; strValor, strTipReg: String);

        procedure pGetPropertiesEntredaSimplificada(
          Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
          var AProperties: TcxCustomEditProperties; strValor, strTipReg: String);
    procedure pItemsSummary(ASender: TcxDataSummaryItems;
      Arguments: TcxSummaryEventArguments;
      var OutArguments: TcxSummaryEventOutArguments);

      public

        tprTipoProcesso:  TTipoProcesso;

        cxEditRepositoryTextItem: TcxEditRepositoryTextItem;
        cxEditRepositoryButtonVisibleCenter,
        cxEditRepositoryButtonInvisibleCenter: TcxEditRepositoryButtonItem;

        procedure pChamaEntradaSimplificada(strAutoincrem: String; blnRealizarEntrada: Boolean);

        procedure pConfiguraColumn(cxgGrid: TcxGridDBBandedTableView; intBandIndex: Integer); virtual;

        procedure pGetProperties(
               Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
               var AProperties: TcxCustomEditProperties);

        property objComum : TProcessoComum read FComum;


        Constructor Create;
        Destructor Destroy; override;
    end;

    TProcessoDivergenciaFiscal = class sealed(TProcessoCompras)
      const
        DATA_FIELD_NAME               = 'DIVERGENCIA_FISCAL';
        DATA_FIELD_NAME_PENDENCIA     = 'DIVERGENCIA_PENDENCIA';
        TITULO                        = 'Divergência Fiscal';
        CHAVE_DIREITO_ACESSO_REALIZAR = 'frmEntImportaNotaEletDivFiscal';

      private
        procedure pOnRealizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);

        function getProcessoComum: TProcessoComum;
        function fGetRealizadoDB(strAutoincrem : String) : boolean;
        function fGetStatus(strValor : String) :  TStatusProcesso;

      public

        property objComum : TProcessoComum read getProcessoComum;

        constructor Create;
    end;

    TProcessoNotaFiscal = class sealed(TProcessoCompras)
      const
        DATA_FIELD_NAME_NF            = 'NUMERO_DOCUMENTO';
        DATA_FIELD_NAME_ESPECIE       = 'TIPO_DOCUMENTO';
        DATA_FIELD_NAME_SERIE         = 'SERIE_DOCUMENTO';
        DATA_FIELD_NAME_FORNECEDOR    = 'FORNECEDOR';
        DATA_FIELD_NAME_CFOP          = 'CFOP';
        DATA_FIELD_NAME_TRANSF_COMPRA = 'TRANSF_COMPRA';
        DATA_FIELD_NAME_TIPFOR        = 'TIPFOR';
        DATA_FIELD_NAME_TIPREG        = 'TIPREG';
        DATA_FIELD_NAME_DEMI          = 'DATA_EMISSAO';
        DATA_FIELD_NAME_DVENC         = 'DATA_VENCIMENTO';
        DATA_FIELD_NAME_DIATRA        = 'DIATRA';
        DATA_FIELD_NAME_VNF           = 'TOTAL_NF';
        TITULO                        = 'Nota Fiscal';
        CHAVE_DIREITO_ACESSO_REALIZAR = 'frmEntImportaNotaElet';
      private
        procedure pOnVisualizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo : String);

        function getProcessoComum: TProcessoComum;
        function fGetRealizadoDB(strAutoincrem : String) : boolean;
        function fGetStatus(strValor: String): TStatusProcesso;
        function fGetPodeCancelar(Fields: TFields) : Boolean;

      public

        property objComum : TProcessoComum read getProcessoComum;

        constructor Create;
    end;

    TProcessoPreNota = class sealed(TProcessoCompras)
      const
        DATA_FIELD_NAME_PEDIDOS       = 'PRE_NOTA';
        TITULO                        = 'Pré-Nota de Entrada';
        CHAVE_DIREITO_ACESSO_REALIZAR = 'frmEntPreNotaEntrada';

      private
        procedure pOnRealizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);
        procedure pOnCancelar(strAutoincrem: String);

        function getProcessoComum: TProcessoComum;
        function fGetRealizadoDB(strAutoincrem : String) : boolean;
        function fGetStatus(strValor: String): TStatusProcesso;
        function fGetPodeCancelar(Fields: TFields) : Boolean;

      public

        property objComum : TProcessoComum read getProcessoComum;

        constructor Create;
    end;

    TProcessoEntradaMercadoria = class sealed(TProcessoCompras)
      const
        DATA_FIELD_NAME               = 'ENTRADA_MERCADORIA';
        TITULO                        = 'Entrada de Mercadoria';
        CHAVE_DIREITO_ACESSO_REALIZAR = 'frmEntDigPedido';

      private
        procedure pOnRealizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);
        procedure pOnCancelar(strAutoincrem : String);

        function getProcessoComum: TProcessoComum;
        function fGetStatus(strValor: String): TStatusProcesso;
        function fGetRealizadoDB(strAutoincrem : String) : boolean;
        function fGetPodeCancelar(Fields: TFields) : Boolean;
      public

        property objComum : TProcessoComum read getProcessoComum;

        constructor Create;
    end;

    TProcessoDataRecebimentoMercadoria = class sealed(TProcessoCompras)
      const
        DATA_FIELD_NAME               = 'DATA_RECEBIMENTO';
        TITULO                        = 'Data de Recebimento';
        CHAVE_DIREITO_ACESSO_REALIZAR = '';

      private
        procedure pOnCancelar(strAutoincrem: String);

        function getProcessoComum: TProcessoComum;
        function fGetRealizadoDB(strAutoincrem : String) : boolean;
        function fGetStatus(strValor : String) :  TStatusProcesso;
        function fGetPodeCancelar(Fields: TFields) : Boolean;
        procedure pOnRealizar(strAutoincrem, strTipFor, strTipReg,
          strNomeCampo: String);

      public

        property objComum : TProcessoComum read getProcessoComum;

        constructor Create;
    end;

    TProcessoConferenciaPreNota = class sealed(TProcessoCompras)
      const
        DATA_FIELD_NAME               = 'CONFERENCIA';
        TITULO                        = 'Conferência';
        CHAVE_DIREITO_ACESSO_REALIZAR = 'frmEntConferPreNota';

      private
        procedure pOnVisualizarRealizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);
        procedure pOnCancelar(strAutoincrem: String);

        function getProcessoComum: TProcessoComum;
        function fGetRealizadoDB(strAutoincrem : String) : boolean;
        function fGetStatus(strValor : String) :  TStatusProcesso;
        function fGetPodeCancelar(Fields: TFields) : Boolean;

      public

        property objComum : TProcessoComum read getProcessoComum;

        constructor Create;
    end;

    TProcessoEfetivacaoMovimentoFiscal = class sealed(TProcessoCompras)
      const
        DATA_FIELD_NAME               = 'EFETIVACAO_MOVIMENTO_FISCAL';
        TITULO                        = 'Efetivação Movimento Fiscal';
        CHAVE_DIREITO_ACESSO_REALIZAR = 'frmEntMercadoriasEfetivaMovFiscal';

      private
        blnAntCon: Boolean;

        procedure pOnRealizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);

        function getProcessoComum: TProcessoComum;
        function fGetStatus(strValor: String): TStatusProcesso;
        function fGetRealizadoDB(strAutoincrem : String) : boolean;

      public

        property objComum : TProcessoComum read getProcessoComum;

        constructor Create;
    end;

    TProcessoLotePreco = class sealed(TProcessoCompras)
      const
        DATA_FIELD_NAME               = 'LOTE_PRECO';
        TITULO                        = 'Lote Preço';
        CHAVE_DIREITO_ACESSO_REALIZAR = 'frmLotePrecosEfetivacao';

      private
        procedure pOnRealizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);

        function getProcessoComum: TProcessoComum;
        function fGetStatus(strValor: String): TStatusProcesso;
        function fGetRealizadoDB(strAutoincrem : String) : boolean;

      public

        property objComum : TProcessoComum read getProcessoComum;

        constructor Create;
    end;

    TProcessoEnderecamento = class sealed(TProcessoCompras)
      const
        DATA_FIELD_NAME               = 'ENDERECAMENTO';
        TITULO                        = 'Endereçamento';
        CHAVE_DIREITO_ACESSO_REALIZAR = 'frmEntEnderecamentoProduto';

      private
        procedure pOnRealizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);

        function getProcessoComum: TProcessoComum;
        function fGetRealizadoDB(strAutoincrem : String) : boolean;
        function fGetStatus(strValor : String) :  TStatusProcesso;

      public

        property objComum : TProcessoComum read getProcessoComum;

        constructor Create;
    end;

     TProcessoDevolucaoPreNota = class sealed(TProcessoCompras)
      const
        DATA_FIELD_NAME               = 'DEV_PRE_NOTA';
        TITULO                        = 'Devolução de pré-nota';
        CHAVE_DIREITO_ACESSO_REALIZAR = 'frmEntConferPreNotaWMSDevolucao';

      private
        procedure pOnRealizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);

        function getProcessoComum: TProcessoComum;
        function fGetStatus(strValor : String) :  TStatusProcesso;

      public

        property objComum : TProcessoComum read getProcessoComum;

        constructor Create;
    end;

implementation

uses
  Windows,
  Vcl.StdCtrls,
  cxButtonEdit,
  untEntImportaNotaEletDivFiscal,
  untEntImportaNotaElet,
  untFuncoesSimples,
  untEntPreNotaEntradaCx,
  untPreNota,
  untEntMercadorias,
  untEntConferPreNota,
  untEntMercadoriasEfetivaMovFiscal,
  untLotePrecosEfetivacaoCx,
  untEntradaAutomatizada,
  untRecTransfEstoque,
  untPedePendenciasNota,
  untConsultas,
  untEntEnderecamentoProduto, untCancelamentoDocumentos, untEntSelecionaNotaElet, untEntConfPreNotaFuncoes,
  untEntConferPreNotaWMSDevolucao;

Var
  blnProcessoIniciado: Boolean;

{ TProcessoDivergenciaFiscal }

constructor TProcessoDivergenciaFiscal.Create;
begin
  inherited;

  FComum.tprTipoProcesso := tprDivergenciaFiscal;
  tprTipoProcesso        := tprDivergenciaFiscal;

  FComum.pSetaNumeroColunas(2);
  FComum.stlDataFieldName[0].strFieldName := DATA_FIELD_NAME;
  FComum.stlDataFieldName[1].strFieldName := DATA_FIELD_NAME_PENDENCIA;
  FComum.pIncluiColuna(0, DATA_FIELD_NAME, 'Documento', '', 'TcxLabelProperties', taCenter, 140);
  FComum.pIncluiColuna(1, DATA_FIELD_NAME_PENDENCIA, 'Pendências', '', 'TcxLabelProperties', taCenter, 110);

  FComum.strChaveDireitoAcessoRealizar := CHAVE_DIREITO_ACESSO_REALIZAR;
  FComum.strTitulo                     := TITULO;
  FComum.OnRealizar                    := Self.pOnRealizar;
  FComum.GetRealizadoDB                := Self.fGetRealizadoDB;
  FComum.GetStatus                     := Self.fGetStatus;
end;

function TProcessoDivergenciaFiscal.fGetRealizadoDB(strAutoincrem: String): boolean;
var
  qryXMLVAL : TUniQuery;
begin

  qryXMLVAL := fCriaQuery(nil);
  try
    qryXMLVAL.SQL.Add('SELECT                     ');
    qryXMLVAL.SQL.Add('  COUNT(*) AS QUANTIDADE   ');
    qryXMLVAL.SQL.Add('FROM                       ');
    qryXMLVAL.SQL.Add('  XMLVAL                   ');
    qryXMLVAL.SQL.Add('WHERE                      ');
    qryXMLVAL.SQL.Add('  AUTOINCREM = :AUTOINCREM ');

    qryXMLVAL.ParamByName('AUTOINCREM').AsString := strAutoincrem;

    qryXMLVAL.Open;

    Result := qryXMLVAL.FieldByName('QUANTIDADE').AsFloat = 0;

    qryXMLVAL.Close;
  finally
    FreeAndNil(qryXMLVAL);
  end;

end;

function TProcessoDivergenciaFiscal.fGetStatus(strValor: String): TStatusProcesso;
begin
  if SameText(strValor, 'SEM DIVERGÊNCIA') Or
     SameText(strValor, 'SEM PENDÊNCIA') then
    Result := stpNeutro
  else
    Result := stpRealizarDocumento;
end;

function TProcessoDivergenciaFiscal.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

procedure TProcessoDivergenciaFiscal.pOnRealizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);
var
  form : TfrmEntImportaNotaEletDivFiscal;
begin

  If SameText(strNomeCampo, DATA_FIELD_NAME) Then
  Begin

    pCriarFormularios(TfrmEntImportaNotaEletDivFiscal, form);
    try
      form.strAutoincrem := strAutoincrem;
      form.pCriaCdsXmlVal;
      form.pCarregaDados;
      form.btnImporta.Click;

    finally
      pFreeAndNil(form);
    end;

  End Else
  Begin

    Try
      pCriarFormularios(TfrmPedePendenciasNota, frmPedePendenciasNota);
      frmPedePendenciasNota.blnSoConsulta := True;
      frmPedePendenciasNota.srtAutXMLVAL  := strAutoincrem;
      frmPedePendenciasNota.ShowModal;

      FComum.blnAtualizarGrid := False;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmEntNFEDivergencias.btnMotivosPedenciaClick');
      End;
    End;

    FreeAndNil(frmPedePendenciasNota);

  End;

end;

{ TProcessoEnderecamento }

constructor TProcessoEnderecamento.Create;
begin
  inherited;

  tprTipoProcesso        := tprEnderecamento;
  FComum.tprTipoProcesso := tprEnderecamento;

  FComum.pSetaNumeroColunas(1);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME, 'Status', 'Status Endereçamento', 'TcxLabelProperties', taCenter, 90, skCount, '00');

  FComum.strChaveDireitoAcessoRealizar := CHAVE_DIREITO_ACESSO_REALIZAR;
  FComum.strTitulo                     := TITULO;
  FComum.OnRealizar                    := Self.pOnRealizar;
  FComum.GetRealizadoDB                := Self.fGetRealizadoDB;
  FComum.GetStatus                     := Self.fGetStatus;
end;

function TProcessoEnderecamento.fGetRealizadoDB(strAutoincrem: String): boolean;
var
  qryEnderecamento : TUniQuery;
begin

  qryEnderecamento := fCriaQuery(nil);
  try
    qryEnderecamento.SQL.Add('SELECT                                                                         ');
  	qryEnderecamento.SQL.Add('  COUNT(*) AS QUANTIDADE                                                       ');
  	qryEnderecamento.SQL.Add('FROM                                                                           ');
    qryEnderecamento.SQL.Add('  GERELE                                                                       ');
  	qryEnderecamento.SQL.Add('	INNER JOIN EXTGOR ON      SUBSTRING(FGO_DOCEND, 01, 12)  = GERELE.B08_NNF    ');
    qryEnderecamento.SQL.Add('                	 AND TRIM(SUBSTRING(FGO_DOCEND, 15, 03)) = GERELE.B07_SERIE  ');
    qryEnderecamento.SQL.Add('                 	 AND TRIM(SUBSTRING(FGO_DOCEND, 18, 03)) = GERELE.GER_CODEMP ');
    qryEnderecamento.SQL.Add('                   AND TRIM(SUBSTRING(FGO_DOCEND, 21, 08)) = GERELE.GER_CODFOR ');
    qryEnderecamento.SQL.Add('WHERE GERELE.AUTOINCREM = :AUTOINCREM                                          ');


    qryEnderecamento.ParamByName('AUTOINCREM').AsString := strAutoincrem;

    qryEnderecamento.Open;

    Result := qryEnderecamento.FieldByName('QUANTIDADE').AsFloat = 0;

    qryEnderecamento.Close;
  finally
    FreeAndNil(qryEnderecamento);
  end;

end;

function TProcessoEnderecamento.fGetStatus(strValor: String): TStatusProcesso;
begin
//  if (strValor = '0') then
  if (strValor = 'REALIZAR') then
    Result := stpRealizar
  else
    Result := stpRealizado;
end;

function TProcessoEnderecamento.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;


procedure TProcessoEnderecamento.pOnRealizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);
var
  form : TfrmEntEnderecamentoProduto;
begin

  pCriarFormularios(TfrmEntEnderecamentoProduto, form);
  try
    form.strAutoincremGERELE := strAutoincrem;
    form.ShowModal;

    If form.blnDocumentoNaoEncontrado Then
      pMensagemOk('O Documento não está disponível para endereçamento.' + #13#10 +
       'Para prosseguir, é necessário realizar todos os processos anteriores.');

  finally
    pFreeAndNil(form);
  end;

end;



{ TProcessoNotaFiscal }

constructor TProcessoNotaFiscal.Create;
begin
  inherited;

  tprTipoProcesso        := tprNotaFiscal;
  FComum.tprTipoProcesso := tprNotaFiscal;

  FComum.pSetaNumeroColunas(12);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME_NF,         'Documento', '', 'TcxTextEditProperties', taCenter, 100);
  FComum.pIncluiColuna(1, DATA_FIELD_NAME_ESPECIE,    'Esp.', '',       'TcxTextEditProperties', taCenter, 30);
  FComum.pIncluiColuna(2, DATA_FIELD_NAME_SERIE,      'Série', '',      'TcxTextEditProperties', taCenter, 35);
  FComum.pIncluiColuna(3, DATA_FIELD_NAME_CFOP,       'CFOP', '',       'TcxTextEditProperties', taCenter, 50);
  FComum.pIncluiColuna(4, DATA_FIELD_NAME_TRANSF_COMPRA, 'Compra/Transferência', '', 'TcxLabelProperties', taCenter, 50);
  FComum.pIncluiColuna(5, DATA_FIELD_NAME_DEMI,       'Data Emissão', '', 'TcxTextEditProperties', taCenter, 90);
  FComum.pIncluiColuna(6, DATA_FIELD_NAME_DVENC,      IIf(fCfgSis('FDAVEN') = 'S', 'Data Vencimento', ''), '', 'TcxTextEditProperties', taCenter, 90);
  FComum.pIncluiColuna(7, DATA_FIELD_NAME_DIATRA,     'Dias em Trânsito', '', 'TcxTextEditProperties', taCenter, 90);
  FComum.pIncluiColuna(8, DATA_FIELD_NAME_VNF,        'Valor', '',        'TcxCurrencyEditProperties', taRightJustify, 90);
  FComum.pIncluiColuna(9, DATA_FIELD_NAME_FORNECEDOR, 'Fornecedor', '', 'TcxTextEditProperties', taLeftJustify, 350);
  FComum.pIncluiColuna(10, DATA_FIELD_NAME_TIPFOR, '', '', 'TcxTextEditProperties', taLeftJustify, 10);
  FComum.pIncluiColuna(11, DATA_FIELD_NAME_TIPREG, '', '', 'TcxTextEditProperties', taLeftJustify, 10);


  FComum.strChaveDireitoAcessoRealizar := CHAVE_DIREITO_ACESSO_REALIZAR;
  FComum.strTitulo                     := TITULO;
  FComum.OnVisualizar                  := Self.pOnVisualizar;
  FComum.GetRealizadoDB                := Self.fGetRealizadoDB;
  FComum.GetStatus                     := Self.fGetStatus;
  FComum.GetPodeCancelar               := fGetPodeCancelar;
end;

function TProcessoNotaFiscal.fGetPodeCancelar(Fields: TFields): Boolean;
begin
  Result := FComum.fGetRealizadoCds(Fields) and (not FComum.objProcessoComumSeguinte.fGetRealizadoCds(Fields));
end;

function TProcessoNotaFiscal.fGetRealizadoDB(strAutoincrem: String): boolean;
var
  qryGERELE : TUniQuery;
begin

  qryGERELE := fCriaQuery(nil);
  try
    qryGERELE.SQL.Add('SELECT                     ');
    qryGERELE.SQL.Add('  COUNT(*) AS QUANTIDADE   ');
    qryGERELE.SQL.Add('FROM                       ');
    qryGERELE.SQL.Add('  GERELE                   ');
    qryGERELE.SQL.Add('WHERE                      ');
    qryGERELE.SQL.Add('  AUTOINCREM = :AUTOINCREM ');

    qryGERELE.ParamByName('AUTOINCREM').AsString := strAutoincrem;

    qryGERELE.Open;

    Result := qryGERELE.FieldByName('QUANTIDADE').AsFloat > 0;

    qryGERELE.Close;
  finally
    FreeAndNil(qryGERELE);
  end;

end;

function TProcessoNotaFiscal.fGetStatus(strValor: String): TStatusProcesso;
begin
  if (strValor = '') then
    Result := stpNeutro
  else
    Result := stpVisualizarDocumento;
end;

function TProcessoNotaFiscal.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

procedure TProcessoNotaFiscal.pOnVisualizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);
var
  form : TfrmEntImportaNotaElet;
begin

  If strTipFor = 'SIMPLIFICADA' Then
  Begin

    pChamaEntradaSimplificada(strAutoincrem, False);

  End Else
  Begin

    pCriarFormularios(TfrmEntImportaNotaElet, form);
    try
      form.strAutoincrem := strAutoincrem;
      form.ShowModal;

      If Assigned(FComum.FOnAposRealizar) Then
        FComum.FOnAposRealizar;
    finally
      pFreeAndNil(form);
    end;

  End;

end;

{ TProcessoPreNota }

constructor TProcessoPreNota.Create;
begin
  inherited;

  tprTipoProcesso        := tprPreNota;
  FComum.tprTipoProcesso := tprPreNota;

  FComum.pSetaNumeroColunas(1);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME_PEDIDOS, 'Pedidos', 'Pedidos - Pré-nota', 'TcxTextEditProperties' {'TcxMemoProperties'}, taCenter, 120, skCount, '00');

  FComum.strChaveDireitoAcessoRealizar := CHAVE_DIREITO_ACESSO_REALIZAR;
  FComum.strTitulo                     := TITULO;
  FComum.OnRealizar                    := Self.pOnRealizar;
  FComum.OnCancelar                    := Self.pOnCancelar;
  FComum.GetRealizadoDB                := Self.fGetRealizadoDB;
  FComum.GetStatus                     := Self.fGetStatus;
  FComum.GetPodeCancelar               := fGetPodeCancelar;
end;

function TProcessoPreNota.fGetPodeCancelar(Fields: TFields): Boolean;
begin
  Result := FComum.fGetRealizadoCds(Fields) and (not FComum.objProcessoComumSeguinte.fGetRealizadoCds(Fields));
end;

function TProcessoPreNota.fGetRealizadoDB(strAutoincrem: String): boolean;
var
  qryPEDELE : TUniQuery;
begin

  qryPEDELE := fCriaQuery(nil);
  try
    qryPEDELE.SQL.Add('SELECT                     ');
    qryPEDELE.SQL.Add('  COUNT(*) AS QUANTIDADE   ');
    qryPEDELE.SQL.Add('FROM                       ');
    qryPEDELE.SQL.Add('  PEDELE                   ');
    qryPEDELE.SQL.Add('WHERE                      ');
    qryPEDELE.SQL.Add('  PEL_SEQELE = :AUTOINCREM ');

    qryPEDELE.ParamByName('AUTOINCREM').AsString := strAutoincrem;

    qryPEDELE.Open;

    Result := qryPEDELE.FieldByName('QUANTIDADE').AsFloat > 0;

    qryPEDELE.Close;
  finally
    FreeAndNil(qryPEDELE);
  end;

end;

function TProcessoPreNota.fGetStatus(strValor: String): TStatusProcesso;
begin
//  if (strValor = '') then
  if (strValor = 'REALIZAR') then
    Result := stpRealizar
  else
    Result := stpRealizadoDocumento;
end;

function TProcessoPreNota.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

procedure TProcessoPreNota.pOnRealizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);
var
  form : TfrmEntPreNotaEntradaCx;
begin

  pCriarFormularios(TfrmEntPreNotaEntradaCx, form);
  try
    form.strAutoincrem := strAutoincrem;
    form.ShowModal;
  finally
    pFreeAndNil(form);
  end;

end;

procedure TProcessoPreNota.pOnCancelar(strAutoincrem: String);
  Var
    frmEntSelecionaNotaElet: TfrmEntSelecionaNotaElet;
begin
  if not fVerificaAcessoSistema('frmPreNotaCancel') then
    raise ExceptionMessage.Create('Operador sem direito de acesso para essa operação!');


  pCriarFormularios(TfrmEntSelecionaNotaElet, frmEntSelecionaNotaElet);
  frmEntSelecionaNotaElet.opcTipoOperacao := opeCancelaPreNota;
  frmEntSelecionaNotaElet.objConfPreNota := TConferePreNota.Create;
  frmEntSelecionaNotaElet.objConfPreNota.strAutoincremGERELE := strAutoincrem;
  frmEntSelecionaNotaElet.ShowModal;
  FreeAndNil(frmEntSelecionaNotaElet.objConfPreNota);
  pFreeAndNil(frmEntSelecionaNotaElet);
end;


{ TProcessoEntradaMercadoria }

constructor TProcessoEntradaMercadoria.Create;
begin
  inherited;

  tprTipoProcesso        := tprEntradaMercadoria;
  FComum.tprTipoProcesso := tprEntradaMercadoria;

  FComum.pSetaNumeroColunas(1);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME, 'Status', 'Status Entrada Mercadoria', 'TcxLabelProperties', taCenter, 130, skCount, '00');

  FComum.strChaveDireitoAcessoRealizar := CHAVE_DIREITO_ACESSO_REALIZAR;
  FComum.strTitulo                     := TITULO;
  FComum.OnRealizar                    := Self.pOnRealizar;
  FComum.OnCancelar                    := Self.pOnCancelar;
  FComum.GetRealizadoDB                := Self.fGetRealizadoDB;
  FComum.GetStatus                     := Self.fGetStatus;
  FComum.GetPodeCancelar               := fGetPodeCancelar;
end;

function TProcessoEntradaMercadoria.fGetPodeCancelar(Fields: TFields): Boolean;
begin
  Result := FComum.fGetRealizadoCds(Fields) and (not FComum.objProcessoComumSeguinte.fPodeCancelar(Fields));
end;

function TProcessoEntradaMercadoria.fGetRealizadoDB(
  strAutoincrem: String): boolean;
var
  qryGERELE : TUniQuery;
begin

  qryGERELE := fCriaQuery(nil);
  try
    qryGERELE.SQL.Add('SELECT                              ');
    qryGERELE.SQL.Add('  COUNT(*) AS QUANTIDADE            ');
    qryGERELE.SQL.Add('FROM                                ');
    qryGERELE.SQL.Add('  GERELE                            ');
    qryGERELE.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM      ');
    qryGERELE.SQL.Add('  AND IFNULL(GER_DOCENT, "") <> ""  ');

    qryGERELE.ParamByName('AUTOINCREM').AsString := strAutoincrem;

    qryGERELE.Open;

    Result := qryGERELE.FieldByName('QUANTIDADE').AsFloat > 0;

    qryGERELE.Close;
  finally
    FreeAndNil(qryGERELE);
  end;

end;

function TProcessoEntradaMercadoria.fGetStatus(strValor: String): TStatusProcesso;
begin
//  if (strValor = '0') then
  if (strValor = 'REALIZAR') then
    Result := stpRealizar
  else
    Result := stpRealizado;
end;

function TProcessoEntradaMercadoria.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

procedure TProcessoEntradaMercadoria.pOnCancelar(strAutoincrem: String);
begin
  if not fVerificaAcessoSistema('frmCancelamentoDocumentos') then
    raise ExceptionMessage.Create('Operador sem direito de acesso para essa operação!');

  TfrmCancelamentoDocumentos.pCancelaNotaEntrada(strAutoincrem);
end;

procedure TProcessoCompras.pChamaEntradaSimplificada(strAutoincrem: String; blnRealizarEntrada: Boolean);
Begin
  {If Not fChecaConfiguracoesEntradaMercadorias Then
    Exit;     }

  Try
    pCriarFormularios(TfrmRecTransfEstoque, frmRecTransfEstoque);

    frmRecTransfEstoque.blnRealizarEntrada := blnRealizarEntrada;
    frmRecTransfEstoque.strAutincrem := strAutoincrem;
    frmRecTransfEstoque.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TProcessoEntradaMercadoria.pOnRealizar]');
    End;
  End;
  pFreeAndNil(frmRecTransfEstoque);
End;

procedure TProcessoEntradaMercadoria.pOnRealizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);
var
  form       : TfrmEntMercadorias;
  qryGerEle: TUniQuery;
  recNotEle: TRecInfoNotaEletronica;
begin
  if blnProcessoIniciado Then
    Exit;
  blnProcessoIniciado := True;

  If strTipFor = 'SIMPLIFICADA' Then
  Begin

    pChamaEntradaSimplificada(strAutoincrem, True);

  End

  Else If strTipFor = 'M' Then
  Begin

    TEntradaAutomatizada.pCarregaNota(strAutoincrem);

  End Else
  Begin
    try
      qryGerEle := fCriaQuery;
      qryGerEle.SQL.Text := fSQLConsultaXMLParaEntrada + ' WHERE GERELE.AUTOINCREM = ' + QuotedStr(strAutoincrem);
      qryGerEle.Open;
      pCarregaCabecalhoNota(qryGerEle, recNotEle);
      recNotEle.strClaBri := fretCFOPBonificacaoNotaElet(recNotEle.strAutInc);

      pCriarFormularios(TfrmEntMercadorias, form);
      try
        form.recNotEle := recNotEle;
        form.fltValFre := recNotEle.fltValFre;

        form.ShowModal;
      finally
        pFreeAndNil(form);
      end;

    finally
      FreeAndNil(qryGerEle);
    end;

  End;
  blnProcessoIniciado := False;
end;

{ TProcessoDataRecebimentoMercadoria }

constructor TProcessoDataRecebimentoMercadoria.Create;
begin
  inherited;

  tprTipoProcesso        := tprDataRecebimentoMercadoria;
  FComum.tprTipoProcesso := tprDataRecebimentoMercadoria;

  FComum.pSetaNumeroColunas(1);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME, 'Data', 'Data Recebimento', 'TcxTextEditProperties', taCenter, 130);

  FComum.strChaveDireitoAcessoRealizar := CHAVE_DIREITO_ACESSO_REALIZAR;
  FComum.strTitulo                     := TITULO;
  FComum.OnRealizar                    := Self.pOnRealizar;
  FComum.OnCancelar                    := Self.pOnCancelar;
  FComum.GetRealizadoDB                := Self.fGetRealizadoDB;
  FComum.GetStatus                     := Self.fGetStatus;
  FComum.GetPodeCancelar               := fGetPodeCancelar;
end;

function TProcessoDataRecebimentoMercadoria.fGetPodeCancelar(
  Fields: TFields): Boolean;
begin
  Result := False;
end;

function TProcessoDataRecebimentoMercadoria.fGetRealizadoDB(
  strAutoincrem: String): boolean;
begin
  Result := True;
end;

function TProcessoDataRecebimentoMercadoria.fGetStatus(
  strValor: String): TStatusProcesso;
begin
  Result := stpRealizado;
end;

function TProcessoDataRecebimentoMercadoria.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

procedure TProcessoDataRecebimentoMercadoria.pOnCancelar(strAutoincrem: String);
begin

end;

procedure TProcessoDataRecebimentoMercadoria.pOnRealizar(strAutoincrem,
  strTipFor, strTipReg, strNomeCampo: String);
begin

end;

{ TProcessoEfetivacaoMovimentoFiscal }

constructor TProcessoEfetivacaoMovimentoFiscal.Create;
begin
  inherited;

  blnAntCon := fCfgSis('ANTCON', VarBoolean);

  tprTipoProcesso        := tprEfetivacaoMovimentoFiscal;
  FComum.tprTipoProcesso := tprEfetivacaoMovimentoFiscal;

  FComum.pSetaNumeroColunas(1);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME, 'Status', 'Status Efet. Mov. Fiscal', 'TcxLabelProperties', taCenter, 155, skCount, '00');

  FComum.strChaveDireitoAcessoRealizar := CHAVE_DIREITO_ACESSO_REALIZAR;
  FComum.strTitulo                     := TITULO;
  FComum.OnRealizar                    := Self.pOnRealizar;
  FComum.GetRealizadoDB                := Self.fGetRealizadoDB;
  FComum.GetStatus                     := Self.fGetStatus;
end;

function TProcessoEfetivacaoMovimentoFiscal.fGetRealizadoDB(
  strAutoincrem: String): boolean;
var
  qryMovimentoFiscal : TUniQuery;

begin

  qryMovimentoFiscal := fCriaQuery(nil);
  try
    qryMovimentoFiscal.SQL.Add('SELECT                                                      ');
    qryMovimentoFiscal.SQL.Add('  COUNT(*) AS QUANTIDADE                                    ');
    qryMovimentoFiscal.SQL.Add('FROM                                                        ');
    qryMovimentoFiscal.SQL.Add('  GERELE                                                    ');
    qryMovimentoFiscal.SQL.Add('  LEFT JOIN MOVGER ON MOVGER.GER_NUMDOC = GERELE.GER_DOCENT ');
    qryMovimentoFiscal.SQL.Add('									 AND MOVGER.GER_ESPDOC = GERELE.GER_ESPENT ');
    qryMovimentoFiscal.SQL.Add('									 AND MOVGER.GER_CODEMP = GERELE.GER_EMPENT ');
    qryMovimentoFiscal.SQL.Add('									 AND MOVGER.GER_SERIE_ = GERELE.B07_SERIE  ');
    qryMovimentoFiscal.SQL.Add('									 AND MOVGER.GER_CODFOR = GERELE.GER_CODFOR ');
    qryMovimentoFiscal.SQL.Add('WHERE GERELE.AUTOINCREM = :AUTOINCREM                       ');

    If Not blnAntCon Then
      qryMovimentoFiscal.SQL.Add('  AND MOVGER.GER_DTAENT IS NOT NULL                         ')
    Else
    Begin


      If fExigeConferenciaQuandoConfiguradoConferenciaDepoisEntrada Then
        qryMovimentoFiscal.SQL.Add('  AND MOVGER.GER_DTAENT IS NOT NULL                         ')

    End;


    qryMovimentoFiscal.ParamByName('AUTOINCREM').AsString := strAutoincrem;

    qryMovimentoFiscal.Open;

    Result := qryMovimentoFiscal.FieldByName('QUANTIDADE').AsFloat > 0;

    qryMovimentoFiscal.Close;
  finally
    FreeAndNil(qryMovimentoFiscal);
  end;

end;
function TProcessoEfetivacaoMovimentoFiscal.fGetStatus(strValor: String): TStatusProcesso;
begin
//  if (strValor = '0') then
  if (strValor = 'REALIZAR') then
    Result := stpRealizar
  else
    Result := stpRealizado;
end;

function TProcessoEfetivacaoMovimentoFiscal.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

procedure TProcessoEfetivacaoMovimentoFiscal.pOnRealizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);
  var
    stlAutoincrem : TStringList;
begin

  stlAutoincrem := TStringList.Create;
  try
    stlAutoincrem.Text := strAutoincrem;
    TfrmEntMercadoriasEfetivaMovFiscal.pEfetivaMovimentoConferencia(stlAutoincrem);
  finally
    FreeAndNil(stlAutoincrem);
  end;
end;



{ TProcessoLotePreco }


constructor TProcessoLotePreco.Create;
begin
  inherited;

  tprTipoProcesso        := tprLotePreco;
  FComum.tprTipoProcesso := tprLotePreco;

  FComum.pSetaNumeroColunas(1);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME, 'Status', 'Status Lote Preços', 'TcxLabelProperties', taCenter, 100, skCount, '00');

  FComum.strChaveDireitoAcessoRealizar := CHAVE_DIREITO_ACESSO_REALIZAR;
  FComum.strTitulo                     := TITULO;
  FComum.OnRealizar                    := Self.pOnRealizar;
  FComum.GetRealizadoDB                := Self.fGetRealizadoDB;
  FComum.GetStatus                     := Self.fGetStatus;
end;

function TProcessoLotePreco.fGetRealizadoDB(strAutoincrem: String): boolean;
var
  qryLotePreco : TUniQuery;
begin

  qryLotePreco := fCriaQuery(nil);
  try
    qryLotePreco.SQL.Add('SELECT                                                       ');
  	qryLotePreco.SQL.Add('  COUNT(*) AS QUANTIDADE                                     ');
  	qryLotePreco.SQL.Add('FROM                                                         ');
    qryLotePreco.SQL.Add('  GERELE                                                     ');
  	qryLotePreco.SQL.Add('	INNER JOIN LOTPRE ON LOTPRE.LTP_NUMDOC = GERELE.GER_DOCENT ');
  	qryLotePreco.SQL.Add('                   AND LOTPRE.LTP_ESPDOC = GERELE.GER_ESPENT ');
  	qryLotePreco.SQL.Add('                   AND LOTPRE.LTP_CODEMP = GERELE.GER_EMPENT ');
  	qryLotePreco.SQL.Add('                   AND LOTPRE.LTP_SERIE_ = GERELE.B07_SERIE  ');
  	qryLotePreco.SQL.Add('                   AND LOTPRE.LTP_CODFOR = GERELE.GER_CODFOR ');
    qryLotePreco.SQL.Add('WHERE GERELE.AUTOINCREM = :AUTOINCREM                        ');
  	qryLotePreco.SQL.Add('	AND LTP_BAIXAD = "N"                                       ');

    qryLotePreco.ParamByName('AUTOINCREM').AsString := strAutoincrem;

    qryLotePreco.Open;

    Result := qryLotePreco.FieldByName('QUANTIDADE').AsFloat = 0;

    qryLotePreco.Close;
  finally
    FreeAndNil(qryLotePreco);
  end;

end;

function TProcessoLotePreco.fGetStatus(strValor: String): TStatusProcesso;
begin
//  if (strValor = '0') then
  if (strValor = 'REALIZAR') then
    Result := stpRealizar
  else
    Result := stpRealizado;
end;

function TProcessoLotePreco.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

procedure TProcessoLotePreco.pOnRealizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);
  var
    form : TfrmLotePrecosEfetivacaoCx;
begin
  pCriarFormularios(TfrmLotePrecosEfetivacaoCx, form);
  try
    If strTipReg = STR_REG_ENTRADA_SIMP Then
      form.strAutoincremMOVGER := strAutoincrem
    Else
      form.strAutoincremGERELE := strAutoincrem;
    form.blnFluxoCompra := True;
    form.ShowModal;
  finally
    pFreeAndNil(form);
  end;
end;



{ TProcessoConferenciaPreNota }

constructor TProcessoConferenciaPreNota.Create;
begin
  inherited;

  tprTipoProcesso        := tprConferenciaPreNota;
  FComum.tprTipoProcesso := tprConferenciaPreNota;

  FComum.pSetaNumeroColunas(1);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME, 'Status', 'Status Conferência Pré-nota', 'TcxLabelProperties', taCenter, 100, skCount, '00');

  FComum.strChaveDireitoAcessoRealizar := CHAVE_DIREITO_ACESSO_REALIZAR;
  FComum.strTitulo                     := TITULO;
  FComum.OnRealizar                    := Self.pOnVisualizarRealizar;
  FComum.OnVisualizar                  := Self.pOnVisualizarRealizar;
  FComum.OnCancelar                    := Self.pOnCancelar;
  FComum.GetRealizadoDB                := Self.fGetRealizadoDB;
  FComum.GetStatus                     := Self.fGetStatus;
  FComum.FGetPodeCancelar              := fGetPodeCancelar;
end;

function TProcessoConferenciaPreNota.fGetPodeCancelar(Fields: TFields): Boolean;
begin
  Result := FComum.fGetRealizadoCds(Fields) and (not FComum.objProcessoComumSeguinte.fGetRealizadoCds(Fields));
end;

function TProcessoConferenciaPreNota.fGetRealizadoDB(strAutoincrem: String): boolean;
var
  qryGERELE : TUniQuery;
begin
  qryGERELE := fCriaQuery(nil);
  try
    qryGERELE.SQL.Add('SELECT                         ');
    qryGERELE.SQL.Add('  COUNT(*) AS QUANTIDADE       ');
    qryGERELE.SQL.Add('FROM                           ');
    qryGERELE.SQL.Add('  GERELE                       ');
    qryGERELE.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM ');

    qryGERELE.SQL.Add('  AND GER_DTACON IS NOT NULL   ');


    qryGERELE.ParamByName('AUTOINCREM').AsString := strAutoincrem;

    qryGERELE.Open;

    Result := qryGERELE.FieldByName('QUANTIDADE').AsFloat > 0;

    qryGERELE.Close;
  finally
    FreeAndNil(qryGERELE);
  end;

end;

function TProcessoConferenciaPreNota.fGetStatus(strValor: String): TStatusProcesso;
begin
//  if (strValor = '0') then
  if (strValor = 'REALIZAR') then
    Result := stpRealizar
  else
    if fCfgSis('EMSRCS', varBoolean) then
      Result := stpRealizado
    else
      Result := stpVisualizar;
end;

function TProcessoConferenciaPreNota.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

procedure TProcessoConferenciaPreNota.pOnVisualizarRealizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);
var
  qryGERELE : TUniQuery;
begin

  If strTipFor = 'SIMPLIFICADA' Then
  Begin

    pChamaEntradaSimplificada(strAutoincrem, True);

  End Else
  Begin

    qryGERELE := fCriaQuery(nil);
    try
      qryGERELE.SQL.Text := 'SELECT * FROM GERELE WHERE AUTOINCREM = :AUTOINCREM';
      qryGERELE.ParamByName('AUTOINCREM').AsString := strAutoincrem;
      qryGERELE.Open;

      if fEmptyStr(qryGERELE.FieldByName('GER_IDEDIG').AsString) then
      begin
        qryGERELE.Edit;
        qryGERELE.FieldByName('GER_IDEDIG').AsString := fAtualizaProCod('DIGELE', 'GER_IDEDIG', 'GERELE');
        qryGERELE.Post;
      end;

      TfrmEntConferPreNota.pCarregaConferencia(qryGERELE.FieldByName('GER_IDEDIG').AsString);

      qryGERELE.Close;
    finally
      FreeAndNil(qryGERELE);
    end;

  End;
end;

procedure TProcessoConferenciaPreNota.pOnCancelar(strAutoincrem: String);
  Var
    frmEntSelecionaNotaElet: TfrmEntSelecionaNotaElet;
begin
  if not fVerificaAcessoSistema('frmConferenciaPreNotaCancel') then
    raise ExceptionMessage.Create('Operador sem direito de acesso para essa operação!');


  pCriarFormularios(TfrmEntSelecionaNotaElet, frmEntSelecionaNotaElet);
  frmEntSelecionaNotaElet.opcTipoOperacao := opeCancelaConferencia;
  frmEntSelecionaNotaElet.objConfPreNota := TConferePreNota.Create;
  frmEntSelecionaNotaElet.objConfPreNota.strAutoincremGERELE := strAutoincrem;
  frmEntSelecionaNotaElet.ShowModal;
  FreeAndNil(frmEntSelecionaNotaElet.objConfPreNota);
  pFreeAndNil(frmEntSelecionaNotaElet);
end;


{ TProcessoDevolucaoPreNota }

constructor TProcessoDevolucaoPreNota.Create;
begin
  inherited;

  tprTipoProcesso        := tprDevolucaoPreNota;
  FComum.tprTipoProcesso := tprDevolucaoPreNota;

  FComum.pSetaNumeroColunas(1);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME, 'Devolução Pré-Nota', 'Devolução Pré-Nota', 'TcxLabelProperties', taCenter, 90, skCount, '00');

  FComum.strChaveDireitoAcessoRealizar := CHAVE_DIREITO_ACESSO_REALIZAR;
  FComum.strTitulo                     := TITULO;
  FComum.OnRealizar                    := Self.pOnRealizar;
  FComum.GetStatus                     := Self.fGetStatus;
end;

function TProcessoDevolucaoPreNota.fGetStatus(strValor: String): TStatusProcesso;
begin
//  if (strValor = '0') then
  if (strValor = 'PENDENTE') then
    Result := stpRealizar
  else
    Result := stpRealizado;
end;

function TProcessoDevolucaoPreNota.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;


procedure TProcessoDevolucaoPreNota.pOnRealizar(strAutoincrem, strTipFor, strTipReg, strNomeCampo: String);
  Var
    frmEntConferPreNotaWMSDevolucao: TfrmEntConferPreNotaWMSDevolucao;
begin
  if not fVerificaAcessoSistema('frmEntConferPreNotaWMSDevolucao') then
    raise ExceptionMessage.Create('Operador sem direito de acesso para essa operação!');

  pCriarFormularios(TfrmEntConferPreNotaWMSDevolucao, frmEntConferPreNotaWMSDevolucao);

  frmEntConferPreNotaWMSDevolucao.strAutIncExterno := strAutoIncrem;
  frmEntConferPreNotaWMSDevolucao.ShowModal;
  FreeAndNil(frmEntConferPreNotaWMSDevolucao);
end;

{ TProcessoComum }

constructor TProcessoComum.Create;
begin
   inherited;
   SetLength(FColumn, 0);
   SetLength(FDataFieldName, 0);

   blnAtualizarGrid := True;

   strConSim := fCfgSis('CONSIM', varString);
   strLotSim := fCfgSis('LOTSIM', varString);

   FProcessando                := False;
   FComumAnterior              := nil;
   FComumSeguinte              := nil;
   FChaveDireitoAcessoRealizar := '';
   FTitulo                     := '';
   FOnRealizar                 := nil;
   FOnVisualizar               := nil;
   FOnCancelar                 := nil;
   FOnAposRealizar             := nil;
   FGetStatus                  := nil;
   FGetRealizadoDB             := nil;
end;

Destructor TProcessoComum.Destroy;
Begin
  SetLength(FDataFieldName, 0);
  SetLength(FColumn, 0);
End;

function TProcessoComum.fGetRealizadoCds(Fields: TFields): boolean;
begin
  if not Assigned(FGetStatus) then
    raise Exception.Create('FGetStatus não atribuído');

  Result := FGetStatus(Fields.FieldByName(FDataFieldName[0].strFieldName).AsString) in [stpRealizado, stpRealizadoDocumento, stpVisualizar];
end;

function TProcessoComum.fPodeCancelar(Fields: TFields): boolean;
begin
  Try
    if Assigned(FGetPodeCancelar) then
      Result := FGetPodeCancelar(Fields)
    else
      Result := False;
  Except
    Result := False;
  End;
end;

procedure TProcessoComum.pCancelar(strAutoincrem: String);
begin
  if Assigned(FOnCancelar) then
  begin
    try
      FProcessando := True;
      FOnCancelar(strAutoincrem);
    finally
      FProcessando := False;
    end;
  end;
end;

procedure TProcessoComum.pExecuta(strValor, strAutoincrem, strTipFor, strTipReg, srtNomeCampo, strClaRet: String);
begin
  if not Assigned(FGetStatus) then
    raise Exception.Create('FGetStatus não atribuído');

  if not fVerificaAcessoSistema(strChaveDireitoAcessoRealizar) then
    raise ExceptionMessage.Create('Usuário sem permissão de acesso a essa rotina!');

  case FGetStatus(strValor) of

    stpRealizar,
    stpRealizarDocumento   : pRealizar(strAutoincrem, strTipFor, strTipReg, srtNomeCampo, strClaRet);

    stpVisualizar,
    stpVisualizarDocumento : pVisualizar(strAutoincrem, strTipFor, strTipReg, srtNomeCampo);

  end;

end;

procedure TProcessoComum.pSetaNumeroColunas(intTamanho: Integer);
Begin
  SetLength(FDataFieldName, intTamanho);
End;

Procedure TProcessoComum.pIncluiColuna(intPosicao: Integer;
                                       strFieldName,
                                       strCaption,
                                       strAlternativeCaption,
                                       strClassName: String;
                                       aliAlignmentHorz: TAlignment;
                                       intWidth: Integer;
                                       objSummaryKid: TcxSummaryKind = skNone;
                                       strSummaryFormat: String = '');
Begin
  stlDataFieldName[intPosicao].strFieldName     := strFieldName;
  stlDataFieldName[intPosicao].strCaption       := strCaption;
  stlDataFieldName[intPosicao].strAlternativeCaption := strAlternativeCaption;
  stlDataFieldName[intPosicao].strClassName     := strClassName;
  stlDataFieldName[intPosicao].aliAlignmentHorz := aliAlignmentHorz;
  stlDataFieldName[intPosicao].intWidth         := intWidth;
  stlDataFieldName[intPosicao].objSummaryKid    := objSummaryKid;
  stlDataFieldName[intPosicao].strSummaryFormat := strSummaryFormat;
End;

procedure TProcessoComum.pFormataCelula(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strValor : String;
  varValor : Variant;
begin
  if (AViewInfo.GridRecord.IsData) and (AViewInfo.GridRecord.Index >= 0) then
  begin
    if not Assigned(FGetStatus) then
      raise Exception.Create('FGetStatus não atribuído');

    varValor := Sender.ViewData.Records[AViewInfo.GridRecord.Index].Values[(AViewInfo.Item as TcxGridDBBandedColumn).Index];

    if VarIsNull(varValor) then
      strValor := ''
    else
      strValor := Trim(VarAsType( varValor, varString ));

    case FGetStatus(strValor) of
      stpRealizar,
      stpRealizarDocumento   :  ACanvas.Font.Color := COR_REALIAR;

      stpRealizado,
      stpRealizadoDocumento,
      stpVisualizar,
      stpVisualizarDocumento : ACanvas.Font.Color := COR_REALIZADO;
    end;

  end;
end;

Function TProcessoComum.fColunaSoDisplay(intIndice: Integer): Boolean;
Begin
  Result := SameText(FCxgFluxoTBV.Columns[intIndice].DataBinding.FieldName, TProcessoNotaFiscal.DATA_FIELD_NAME_ESPECIE) Or
            SameText(FCxgFluxoTBV.Columns[intIndice].DataBinding.FieldName, TProcessoNotaFiscal.DATA_FIELD_NAME_SERIE) Or
            SameText(FCxgFluxoTBV.Columns[intIndice].DataBinding.FieldName, TProcessoNotaFiscal.DATA_FIELD_NAME_FORNECEDOR) Or
            SameText(FCxgFluxoTBV.Columns[intIndice].DataBinding.FieldName, TProcessoNotaFiscal.DATA_FIELD_NAME_CFOP) Or
            SameText(FCxgFluxoTBV.Columns[intIndice].DataBinding.FieldName, TProcessoNotaFiscal.DATA_FIELD_NAME_DEMI) Or
            SameText(FCxgFluxoTBV.Columns[intIndice].DataBinding.FieldName, TProcessoNotaFiscal.DATA_FIELD_NAME_DVENC) Or
            SameText(FCxgFluxoTBV.Columns[intIndice].DataBinding.FieldName, TProcessoNotaFiscal.DATA_FIELD_NAME_DIATRA) Or
            SameText(FCxgFluxoTBV.Columns[intIndice].DataBinding.FieldName, TProcessoNotaFiscal.DATA_FIELD_NAME_TRANSF_COMPRA) Or
            SameText(FCxgFluxoTBV.Columns[intIndice].DataBinding.FieldName, TProcessoNotaFiscal.DATA_FIELD_NAME_VNF);
End;

procedure TProcessoComum.pMouseMoveAuxiliar(strValor: String; AGridSite: TcxGridSite; X, Y, ARecordIndex, AColumnIndex: Integer;
                                AGridView: TcxGridDBBandedTableView);
Begin

  If fColunaSoDisplay(AColumnIndex) Then
  Begin
    AGridSite.Cursor := crDefault;
    Exit;
  End

  Else If (FGetStatus(strValor) = stpVisualizar) Then
  Begin
    strValor := Trim(VarToStr(AGridSite.GridView.DataController.Values[ARecordIndex, AGridView.GetColumnByFieldName('TIPFOR').Index]));

    If (strValor = 'M') Then
    Begin
      AGridSite.Cursor := crDefault;
      Exit;
    End

    Else If (strValor = 'SIMPLIFICADA') And (FGetStatus(strValor) in [stpVisualizar]) Then
    Begin
      AGridSite.Cursor := crDefault;
      Exit;
    End;

  End;

  AGridSite.Cursor := crHandPoint;
End;

procedure TProcessoComum.pMouseMove(AGridSite: TcxGridSite; X, Y: Integer);
var
  AGridView: TcxGridDBBandedTableView;
  AHitTest: TcxCustomGridHitTest;
  ARecordIndex, AColumnIndex: Integer;
  AValue: Variant;
  strValor : String;
begin
  if FProcessando then
    exit;

  AGridView := AGridSite.GridView as TcxGridDBBandedTableView;
  AHitTest := AGridView.GetHitTest(X, Y);

  if (AHitTest is TcxGridRecordCellHitTest) then
  begin
    if not Assigned(FGetStatus) then
      raise Exception.Create('FGetStatus não atribuído');

    ARecordIndex := (AHitTest as TcxGridRecordCellHitTest).GridRecord.RecordIndex;
    AColumnIndex := (AHitTest as TcxGridRecordCellHitTest).Item.Index;

    AValue := AGridSite.GridView.DataController.Values[ARecordIndex, AColumnIndex];

    if VarIsNull(AValue) then
      strValor := ''
    else
      strValor := Trim(VarAsType( AValue, varString ));


    if FGetStatus(strValor) in [stpRealizar, stpRealizarDocumento, stpVisualizar, stpVisualizarDocumento] then
    begin
      pMouseMoveAuxiliar(strValor, AGridSite, X, Y, ARecordIndex, AColumnIndex, AGridView);

      exit;
    end;

  end;

  AGridSite.Cursor := crDefault;

end;

procedure TProcessoComum.pRealizar(strAutoincrem, strTipFor, strTipReg, srtNomeCampo, strClaRet: String);
var
 blnClaRetIgnoraConferencia,
 blnIgnoraConferenciaParaLotePreco: Boolean;

begin
    if Assigned(FOnRealizar) then
    begin
      try
        FProcessando := True;
        blnClaRetIgnoraConferencia := ((Self.FDataFieldName[0].strFieldName = 'EFETIVACAO_MOVIMENTO_FISCAL') And
                                      { (strClaRet <> '0') and } (FComumAnterior.FDataFieldName[0].strFieldName = 'CONFERENCIA'));

        blnIgnoraConferenciaParaLotePreco := ((Self.FDataFieldName[0].strFieldName = 'LOTE_PRECO') AND (FComumAnterior.FDataFieldName[0].strFieldName = 'CONFERENCIA')
                                              And (Not fExigeConferenciaQuandoConfiguradoConferenciaDepoisEntrada));

        If ((tprTipoProcesso <> tprEntradaMercadoria) Or (strTipFor <> 'M')) And
           (strTipFor <> 'SIMPLIFICADA') And
           (Assigned(FComumAnterior)) And
           (not FComumAnterior.fGetRealizadoDB(strAutoincrem)) And
           (Not blnClaRetIgnoraConferencia) And
           (Not blnIgnoraConferenciaParaLotePreco) And
           (tprTipoProcesso <> tprDevolucaoPreNota) And
           (tprTipoProcesso <> tprEnderecamento) Then
        begin
          if Assigned(FOnAposRealizar) then
            FOnAposRealizar();

          raise ExceptionMessage.Create('Para prosseguir, é necessário realizar todos os processos anteriores');
        end;

        blnAtualizarGrid := True;

        FOnRealizar(strAutoincrem, strTipFor, strTipReg, srtNomeCampo);

        if blnAtualizarGrid And Assigned(FOnAposRealizar) then
          FOnAposRealizar();
      finally
        FProcessando := False;
      end;
    end;
end;

procedure TProcessoComum.pVisualizar(strAutoincrem, strTipFor, strTipReg, srtNomeCampo: String);
begin
  if Assigned(FOnVisualizar) then
  begin
    try
      FProcessando := True;
      FOnVisualizar(strAutoincrem, strTipFor, strTipReg, srtNomeCampo);
    finally
      FProcessando := False;
    end;
  end;
end;


{ TProcessoCompras }


constructor TProcessoCompras.Create;
begin
  inherited;

  cxEditRepositoryButtonVisibleCenter   := Nil;
  cxEditRepositoryButtonInvisibleCenter := Nil;

  FComum := TProcessoComum.Create();
end;

destructor TProcessoCompras.Destroy;
begin
  FreeAndNil(FComum);
  inherited;
end;

Function TProcessoCompras.fCampoSemExecuta(strCampo: String): Boolean;
Begin
  Result := Pos(strCampo, 'FORNECEDOR-TIPO_DOCUMENTO-SERIE_DOCUMENTO-CFOP-DATA_EMISSAO-DATA_VENCIMENTO-TOTAL_NF-TRANSF_COMPRA') > 0;
End;

procedure TProcessoCompras.pGetPropertiesEntredaSimplificada(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties; strValor, strTipReg: String);
Begin
  If TcxGridDBBandedColumn(Sender).DataBinding.FieldName = 'CONFERENCIA' Then
  Begin

    If (strTipReg = STR_REG_ENTRADA_SIMP) And (FComum.strConSim <> 'N') Then
      AProperties := cxEditRepositoryButtonVisibleCenter.Properties
    Else
      AProperties := cxEditRepositoryButtonInvisibleCenter.Properties;
  End

  Else If TcxGridDBBandedColumn(Sender).DataBinding.FieldName = 'ENTRADA_MERCADORIA' Then
  Begin

    If (strTipReg = STR_REG_ENTRADA_SIMP) Then
      AProperties := cxEditRepositoryButtonVisibleCenter.Properties
    Else
      AProperties := cxEditRepositoryButtonInvisibleCenter.Properties;

  End

  Else If TcxGridDBBandedColumn(Sender).DataBinding.FieldName = 'LOTE_PRECO' Then
  Begin

    If (strTipReg = STR_REG_LOTE_SIMP) Then
      AProperties := cxEditRepositoryButtonVisibleCenter.Properties
    Else
      AProperties := cxEditRepositoryButtonInvisibleCenter.Properties

   End;
End;

procedure TProcessoCompras.pGetPropertiesRealizaVisualiza(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties; strValor, strTipReg: String);
Begin
   strValor  := Trim(VarToStr(ARecord.Values[FCxgFluxoTBV.GetColumnByFieldName('TIPFOR').Index]));

   If (strTipReg = STR_REG_DIVERGENCIA) Then
   Begin

      If SameText(TcxGridDBBandedColumn(Sender).DataBinding.FieldName, TProcessoDivergenciaFiscal.DATA_FIELD_NAME) Or
         SameText(TcxGridDBBandedColumn(Sender).DataBinding.FieldName, TProcessoDivergenciaFiscal.DATA_FIELD_NAME_PENDENCIA) Then
         AProperties := cxEditRepositoryButtonVisibleCenter.Properties
      Else
         AProperties := cxEditRepositoryButtonInvisibleCenter.Properties

   End

   Else If strValor = 'M' Then
   Begin

     If TcxGridDBBandedColumn(Sender).DataBinding.FieldName = 'ENTRADA_MERCADORIA' Then
       AProperties := cxEditRepositoryButtonVisibleCenter.Properties
     Else
       AProperties := cxEditRepositoryButtonInvisibleCenter.Properties;

   End

   Else If strValor = 'SIMPLIFICADA' Then
     pGetPropertiesEntredaSimplificada(Sender, ARecord, AProperties, strValor, strTipReg)
   Else
     AProperties := cxEditRepositoryButtonVisibleCenter.Properties;

End;

procedure TProcessoCompras.pGetPropertiesAuxilar(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties; strValor: String);
  Var
    strTipReg: String;
Begin

  strTipReg := Trim(VarToStr(ARecord.Values[FCxgFluxoTBV.GetColumnByFieldName('TIPREG').Index]));

  If (TcxGridDBBandedColumn(Sender).DataBinding.FieldName = 'NUMERO_DOCUMENTO') And
     (strTipReg <> STR_REG_DIVERGENCIA) Then
  Begin
    AProperties := cxEditRepositoryButtonVisibleCenter.Properties;
    Exit;
  End;

  case FComum.fGetStatus(strValor) of
    stpRealizar,
    stpRealizarDocumento,
    stpVisualizar,
    stpVisualizarDocumento : pGetPropertiesRealizaVisualiza(
                                 Sender, ARecord, AProperties, strValor, strTipReg);
    stpRealizado,
    stpRealizadoDocumento : AProperties := cxEditRepositoryButtonInvisibleCenter.Properties;
  end;

End;

procedure TProcessoCompras.pGetProperties(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
  Var
    strValor: String;
begin
  Try
    If Not Assigned(ARecord) Then
      Exit;

    If ARecord.Index < 0 Then
    Begin
      AProperties := cxEditRepositoryTextItem.Properties;
      Exit;
    End;

    If fCampoSemExecuta(TcxGridDBBandedColumn(Sender).DataBinding.FieldName) Then
      Exit;

    If ARecord.IsData And
       (ARecord.Index >= 0) And
       Assigned(FComum) And
       Assigned(FComum.FGetStatus) And
       Assigned(cxEditRepositoryButtonVisibleCenter) And
       Assigned(cxEditRepositoryButtonInvisibleCenter) Then
    Begin
      strValor := Trim(VarToStr(ARecord.Values[Sender.Index]));

      pGetPropertiesAuxilar(Sender, ARecord, AProperties, strValor);
    End;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.message, 'TProcessoCompras.pGetProperties');
    End;

  End;

end;

procedure TProcessoCompras.pConfiguraColumn(cxgGrid: TcxGridDBBandedTableView; intBandIndex: Integer);
  Var
    cxColumn: TcxGridDBBandedColumn;
    intContador: Integer;
begin
  inherited;

  FCxgFluxoTBV := cxgGrid;
  FComum.FCxgFluxoTBV := cxgGrid;
  FCxgFluxoTBV.DataController.Summary.FooterSummaryItems.OnSummary := pItemsSummary;

  For intContador := Low(FComum.stlDataFieldName) To High(FComum.stlDataFieldName) Do
  Begin
    cxColumn := cxgGrid.CreateColumn;

    cxColumn.OnCustomDrawCell := FComum.pFormataCelula;
    cxColumn.OnGetProperties  := pGetProperties;

    cxColumn.DataBinding.FieldName := FComum.stlDataFieldName[intContador].strFieldName;
    cxColumn.Position.BandIndex := intBandIndex;
    cxColumn.Caption := FComum.stlDataFieldName[intContador].strCaption;
    cxColumn.AlternateCaption := FComum.stlDataFieldName[intContador].strAlternativeCaption;
    cxColumn.Visible := Not FComum.stlDataFieldName[intContador].strCaption.IsEmpty;

    cxColumn.HeaderAlignmentHorz := taCenter;
    cxColumn.Width := FComum.stlDataFieldName[intContador].intWidth;
    cxColumn.PropertiesClassName := FComum.stlDataFieldName[intContador].strClassName;
    cxColumn.Summary.FooterKind := FComum.stlDataFieldName[intContador].objSummaryKid;
    cxColumn.Summary.FooterFormat := FComum.stlDataFieldName[intContador].strSummaryFormat;

    If cxColumn.PropertiesClassName = 'TcxButtonEditProperties' Then
    Begin
      (cxColumn.Properties as TcxButtonEditProperties).Alignment.Horz := FComum.stlDataFieldName[intContador].aliAlignmentHorz;
      (cxColumn.Properties as TcxButtonEditProperties).Alignment.Vert := taVCenter;
      (cxColumn.Properties as TcxButtonEditProperties).CharCase := ecUpperCase;
    End

    Else If cxColumn.PropertiesClassName = 'TcxTextEditProperties' Then
    Begin
      (cxColumn.Properties as TcxTextEditProperties).Alignment.Horz := FComum.stlDataFieldName[intContador].aliAlignmentHorz;
      (cxColumn.Properties as TcxTextEditProperties).Alignment.Vert := taVCenter;
      (cxColumn.Properties as TcxTextEditProperties).CharCase := ecUpperCase;
    End

    Else If cxColumn.PropertiesClassName = 'TcxLabelProperties' Then
    Begin
      (cxColumn.Properties as TcxLabelProperties).Alignment.Horz := taCenter;
      (cxColumn.Properties as TcxLabelProperties).Alignment.Vert := taVCenter;
    End

    Else If cxColumn.PropertiesClassName = 'TcxMemoProperties' Then
    Begin
      (cxColumn.Properties as TcxMemoProperties).Alignment := taCenter;
      (cxColumn.Properties as TcxMemoProperties).CharCase := ecUpperCase;
    End

    Else If cxColumn.PropertiesClassName = 'TcxCurrencyEditProperties' Then
    Begin
      (cxColumn.Properties as TcxCurrencyEditProperties).DisplayFormat := '#,##0.00';
    End
  End;

end;

procedure TProcessoCompras.pItemsSummary(
  ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments;
  var OutArguments: TcxSummaryEventOutArguments);
begin
  OutArguments.Done := Not (VarToStrDef(OutArguments.Value,EmptyStr) = 'REALIZAR');
end;




end.



