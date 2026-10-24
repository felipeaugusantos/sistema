unit AgrupamentoDeOndaDeSeparacao.Types;

interface

uses
  System.SysUtils;

const
  SELECIONADO = 'M';
  DESMARCADO  = 'D';

  CARRINHO = 'C';
  UNITARIO = 'U';

  SIM = 'S';
  NAO = 'N';
  KIT = 'K';

type
  TGeracao = (geErro, geGerouComSucesso, geTenteNovamente);

  ExceptionAutComGeracaoRemessaDeSeparacao_Cortes = Class(Exception);
  ExceptionAutComGeracaoRemessaDeSeparacao_Agrupa = Class(Exception);
  ExceptionAutComGeracaoRemessaDeSeparacao_DefLot = Class(Exception);

  TItemRemessaSeparacao = Record
    strCodIte: String;
    strIdePro: String;
    strProAca: String;
  End;

  TItensAgrupadosRemessaSeparacao = Array Of TItemRemessaSeparacao;

  TItemDiverg = Record
    strCodIte: String;
    fltQtdIte: Double;
    fltSalDis: Double;
    strLotTin: String
  End;

  TItensDiverg = Array Of TItemDiverg;

  TItemRemessa = Record
    CodigoDoItem    : String;
    CodigoDaRemessa : String;
  End;

  TItensRemessa = array of TItemRemessa;

  TRecSalDis = Record
    fltSalDis: Double;
    fltQtdOnd: Double;
    strSeqOnd: String;
  end;

implementation

end.
