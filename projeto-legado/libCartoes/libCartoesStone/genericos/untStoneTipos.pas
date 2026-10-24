unit untStoneTipos;

interface

Const
  NOME_CONCILIACAO = 'STONE';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

Type
  TRegistroPgto = class
    TipoRegistro,
    CodigoEstabelecimento,
    DataPagamento,
    NumeroNsu,
    IniKey,
    DataAutorizacao,
    DataVenda,
    strNumTer    : String;
    strTipPon    : String;
    Parcela,
    DataOrigem,
    Pag_ID,
    NumCancelamento    : String;

    ValorBruto,
    ValorLiquido,
    ValorAntecipacao,
    ValorDebito,
    ValorCancelamento    : Double;
  End;

  TRegistroCred = class
    TipoRegistro,
    CodigoEstabelecimento,
    NumeroNsu,
    IniKey,
    DataAutorizacao,
    DataVenda,
    TipoCartao,
    NumeroParcela,
    TotParcela,
    CodAutorizacao,
    DataPrevista,
    NumeroCartao: String;

    fltBruVen,
    ValorBruto,
    ValorLiquido: Double;
  End;

  TEstruturaPgto = class
    strDescri: String;
    strTipCmp: String;
  End;

  TEstruturaCred = class
    strDescri: String;
    strTipCmp: String;
  End;


  TChavesStone = class
  private
  public
    Empresa,
    Estabelecimento,
    Authorization,
    SHA512         : String;
  end;

  TArrEstruturaStoPgto  = Array Of TEstruturaPgto;
  TArrEstruturaStoCred  = Array Of TEstruturaCred;



implementation

end.
