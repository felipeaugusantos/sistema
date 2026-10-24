unit Fulfillment.Types;

interface

uses
  Classes, System.SysUtils, Fulfillment.Classes.Parametros;

Type

  ExceptionImportacaoFulFillmentNaoImportouVendaReferenteDocumentoRetornoSimbolico = Class(Exception);
  ExceptionImportacaoFulFillmentNaoGravouPedidoDeEnderecamento  = Class(Exception);
  ExceptionImportacaoFulFillmentNaoGravouGeracaoAjusteDeEstoque = Class(Exception);
  ExceptionImportacaoFulFillmentNaoGravouCancelamento           = Class(Exception);
  ExceptionImportacaoFulFillmentNaoGravouLivroFiscal            = Class(Exception);

  TFulfillmentOpcGeracaoPDEndereca = (opcComLote = 1, opcSemLote = 2);
  TFulfillmentModeloDeMovimentacao = (fmmQuantidadeSeparada = 1, fmmGerarPedidoParaGuardarAsDiferencas = 2);
  TStatusNotaRemessaVsPedidoVenda  = (staQtdCondizenteEntrePedidoENota, staQtdDivergente, staProdutoDivergente, staProdutoNaoEncontrado);

  TStatusNotaRemessaVsPedidoVendaHelper = record helper for TStatusNotaRemessaVsPedidoVenda
  public
    function RetIdx : Integer;
  end;

  VerificacaoException = class(Exception);

  TTipoEnvio = (teCriar, teCancelar, teInutilizar, teDenegado, teCartaCorrecao, teNaoDefinido);

  TStatus = (staErro, staNaoProcessado, staProcessamento, staJaImportado, staImportado);

  TSatusHelper = record helper for TStatus
  public
    function RetSigla : String;
  end;

  TNota = record
    strNumDoc  : String;
    strEspDoc  : String;
    strSerie   : String;
    strChave   : String;
    teEnvio    : TTipoEnvio;
    dtaDtaDoc  : TDateTime;
    dtaHorEmi  : TTime;
    strCFOP    : String;
    blnDenegar : Boolean;
    strNaturezaOperacao : String;
  end;

  TNotaInutilizada = record
    strData  : String;
    strSerie : String;
    strNumIni: String;
    strNumFin: String;
  end;

implementation

{ TSatusHelper }

function TSatusHelper.RetSigla: String;
begin

  Case Self Of
    staErro          : Result := 'E';
    staNaoProcessado : Result := 'N';
    staProcessamento : Result := 'P';
    staJaImportado   : Result := 'I';
    staImportado     : Result := 'S';
  End;

end;

{ TStatusNotaRemessaVsPedidoVendaHelper }

function TStatusNotaRemessaVsPedidoVendaHelper.RetIdx: Integer;
begin

  Case Self Of
    staQtdCondizenteEntrePedidoENota : Result := 0;
    staQtdDivergente                 : Result := 1;
    staProdutoDivergente             : Result := 2;
    staProdutoNaoEncontrado          : Result := 3;
    Else
      Result := -1;
  End;

end;

end.
