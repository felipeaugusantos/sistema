unit TypesLayoutPedidoCompra;

interface

uses classes;

type
  TTelaOrigem = (ttoImpPedido, ttoConsulta);
  TOperacaoTela = (totIndefinido, totPdLayout, totEmail, totExcel, totPDF, totBoletimRecebimento);
  TOpcPedidoImpressaoOrigem = (opioIndeifinido, opioEmail, opioPdf, opioXls);
  TOpcBoletimRecebimento = (tobrPadrao, tobrRetrato, tobrPaisagem);
  TTipoQtdItePedido = (tqpCompleto, tqpPendente, tqpNaoExibir);

  TRecOpcaoImpressao = Record
    blnResumoMarca,
    blnResumoReferencia,
    blnResumoGrupo,
    blnResumoUnidade,
    blnResumoAcordoObjetivo,
    blnImprime,
    blnSemPre,
    blnImpOrd,
    blnMltCmp,
    blnOrdDig,
    blnComMar,
    blnCodFab,
    blnLocFis,
    blnCodBar,
    blnImpRef,
    blnGerPDF,
    blnImpDtaVen,
    blnImpObs: Boolean;
    chrOrdDig: Char;
    intOrient,
    intOpcao,
    intQtdVias,
    intQtdOrd: Integer;

    OperacaoTela: TOperacaoTela;
    Origem: TOpcPedidoImpressaoOrigem;
    TelaOrigem: TTelaOrigem;

    strNumPed,
    strEspDoc,
    strCodEmp,
    strCodFor,
    strEmpDes,

    strNomeFila,
    strTipImp,
    strNomArq,
    strCondPagBosh,
    strCodLay,
    strTipExp,
    strPathArq: String;
    ShowReport: Boolean;
    blnExcRes: Boolean;


    strEmail: String;
    strContato: String;

    tipQtdIte: TTipoQtdItePedido;

    stlCamposExcel: TStringList;

    TipoBoletim: TOpcBoletimRecebimento;
    strOrigemPedido: String;
  End;
implementation

end.
