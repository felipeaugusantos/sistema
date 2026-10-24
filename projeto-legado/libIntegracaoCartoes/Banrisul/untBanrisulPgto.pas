{**************************************}
{* Importação de arquivos da BANRISUL *}
{***********************************AJ*}
unit untBanrisulPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls,
     Dialogs, Forms, untTBanrisul, System.Generics.Collections;

type

  TEstruturaBanrisulPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrEstruturaBanrisulPgto  = Array Of TEstruturaBanrisulPgto;

  TBanrisulPgto = Class(TInterfacedObject, ICartoes)
  Private
    FRegistroAntecipacao : TBanrisulAntecipacao;

    FDataDoArquivo                    : String;
    FDataLancamentoPagamentoHeader    : String;
    FStatusPagamentoHeader            : String;
    FUltimoIdentificadorDoArquivoLido : String;


    FListaAntecipacao: TList<TBanrisulAntecipacao>;
    FListaCredito    : TBanrisulCreditoList;
    FListaPagamento  : TList<TBanrisulPagamento>;
    FListaVendas     : TList<TBanrisulVendas>;

    function fFormataData(AData : String; APadraoBrasileiro : Boolean = False) : TDate;
    function fGetDados(ATexto : String; intIni, intTam: Integer; blnFlt: Boolean = False): Variant;
    function fGetSQLReplace(ANomeTabela : String) : String;

    procedure pAdicionaLinhaRegistroDeCancelamento(ALinha : string);
    procedure pAdicionaLinhaRegistroDeCredito(ALinha : string);
    procedure pAdicionaLinhaRegistroDePagamento(ALinha : string);
    procedure pAdicionaLinhaRegistroDeAntecipacao(ALinha : string);
    procedure pAdicionaLinhaRegistroDeVenda(ALinha : string);

    procedure pGravaRegistrosDeAntecipacao(pgbProg: TProgressBar);
    procedure pGravaRegistrosDeCredito(pgbProg: TProgressBar);
    procedure pGravaRegistrosDePagamento(pgbProg: TProgressBar);
    procedure pGravaRegistrosDeVenda(pgbProg: TProgressBar);

  Public
    constructor Create;
    destructor Destroy; Override;

    procedure pAdicionaLinha(ALinha: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaBanrisulPgto;
  End;

Var
  strNomArq: String;

implementation

uses untFuncoes, untIDataSet, untGetNet;

{ TBanrisulPgto }

constructor TBanrisulPgto.Create;
Begin
  FListaVendas      := TList<TBanrisulVendas>.Create;
  FListaCredito     := TBanrisulCreditoList.Create;
  FListaPagamento   := TList<TBanrisulPagamento>.Create;
  FListaAntecipacao := TList<TBanrisulAntecipacao>.Create;
  lstEstabel        := TStringList.Create;
End;

destructor TBanrisulPgto.Destroy;
begin
  FreeAndNil(FListaVendas);
  FreeAndNil(FListaCredito);
  FreeAndNil(FListaPagamento);
  FreeAndNil(FListaAntecipacao);
  FreeAndNil(lstEstabel);
end;

function TBanrisulPgto.fFormataData(AData : String; APadraoBrasileiro : Boolean = False): TDate;
begin
  Try
    if not APadraoBrasileiro then
      Result := StrToDate(Copy(AData, 7,2) + '/' +
                          Copy(AData, 5,2) + '/' +
                          Copy(AData, 1,4))
    else
      Result := StrToDate(Copy(AData, 1,2) + '/' +
                          Copy(AData, 3,2) + '/' +
                          Copy(AData, 5,4))
  Except
    Result := 0;
  End;
end;

function TBanrisulPgto.fGetDados(ATexto: String; intIni, intTam: Integer; blnFlt: Boolean): Variant;
Var rst: Variant;
Begin
  rst := Trim(Copy(ATexto, intIni, intTam));
  If blnFlt Then rst := fStrToFloat(rst) / 100;
  Result := rst;
End;

class function TBanrisulPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaBanrisulPgto;
begin
  If strTabela = 'BAN_BSVEND' Then Begin
    SetLength(Result, 30);

    Result[0].strDescri  := 'BAN_CODEST'; Result[0].strTipCmp  := 'VARCHAR(15)';
    Result[1].strDescri  := 'BAN_CNPJES'; Result[1].strTipCmp  := 'VARCHAR(14)';
    Result[2].strDescri  := 'BAN_REDEID'; Result[2].strTipCmp  := 'VARCHAR(11)';
    Result[3].strDescri  := 'BAN_ID_ARQ'; Result[3].strTipCmp  := 'VARCHAR(10)';
    Result[4].strDescri  := 'BAN_NUMNSU'; Result[4].strTipCmp  := 'VARCHAR(14)';
    Result[5].strDescri  := 'BAN_NUMPAR'; Result[5].strTipCmp  := 'VARCHAR(2)';
    Result[6].strDescri  := 'BAN_TOTPAR'; Result[6].strTipCmp  := 'VARCHAR(2)';
    Result[7].strDescri  := 'BAN_DTAVEN'; Result[7].strTipCmp  := 'DATE';
    Result[8].strDescri  := 'BAN_DTAORI'; Result[8].strTipCmp  := 'DATE';
    Result[9].strDescri  := 'BAN_NSUORI'; Result[9].strTipCmp  := 'VARCHAR(14)';
    Result[10].strDescri := 'BAN_CODMSG'; Result[10].strTipCmp := 'VARCHAR(4)';
    Result[11].strDescri := 'BAN_CODPRC'; Result[11].strTipCmp := 'VARCHAR(6)';
    Result[12].strDescri := 'BAN_SERVIC'; Result[12].strTipCmp := 'VARCHAR(4)';
    Result[13].strDescri := 'BAN_SITUAC'; Result[13].strTipCmp := 'VARCHAR(2)';
    Result[14].strDescri := 'BAN_VALVEN'; Result[14].strTipCmp := 'DECIMAL(15,2)';
    Result[15].strDescri := 'BAN_VALPAR'; Result[15].strTipCmp := 'DECIMAL(15,2)';
    Result[16].strDescri := 'BAN_DTACRE'; Result[16].strTipCmp := 'DATE';
    Result[17].strDescri := 'BAN_PERTAX'; Result[17].strTipCmp := 'DECIMAL(8,4)';
    Result[18].strDescri := 'BAN_TARIFA'; Result[18].strTipCmp := 'DECIMAL(12,2)';
    Result[19].strDescri := 'BAN_LIQPAR'; Result[19].strTipCmp := 'DECIMAL(15,2)';
    Result[20].strDescri := 'BAN_PRAZO_'; Result[20].strTipCmp := 'VARCHAR(3)';
    Result[21].strDescri := 'BAN_PRAULT'; Result[21].strTipCmp := 'VARCHAR(3)';
    Result[22].strDescri := 'BAN_DTACNF'; Result[22].strTipCmp := 'DATE';
    Result[23].strDescri := 'BAN_ID_PED'; Result[23].strTipCmp := 'VARCHAR(40)';
    Result[24].strDescri := 'BAN_CPFCLI'; Result[24].strTipCmp := 'VARCHAR(14)';
    Result[25].strDescri := 'BAN_BANDEI'; Result[25].strTipCmp := 'VARCHAR(3)';
    Result[26].strDescri := 'BAN_INICAR'; Result[26].strTipCmp := 'VARCHAR(6)';
    Result[27].strDescri := 'BAN_FINCAR'; Result[27].strTipCmp := 'VARCHAR(4)';
    Result[28].strDescri := 'BAN_DTAARQ'; Result[28].strTipCmp := 'DATE';
    Result[29].strDescri := 'BAN_NOMARQ'; Result[29].strTipCmp := 'VARCHAR(255)';
  End
  else
  If strTabela = 'BAN_BSCRED' Then Begin
    SetLength(Result, 29);

    Result[0].strDescri  := 'BAN_CODEST'; Result[0].strTipCmp  := 'VARCHAR(15)';
    Result[1].strDescri  := 'BAN_CODRED'; Result[1].strTipCmp  := 'VARCHAR(11)';
    Result[2].strDescri  := 'BAN_DTALAN'; Result[2].strTipCmp  := 'DATE';
    Result[3].strDescri  := 'BAN_CODLAN'; Result[3].strTipCmp  := 'VARCHAR(4)';
    Result[4].strDescri  := 'BAN_DTAVEN'; Result[4].strTipCmp  := 'DATE';
    Result[5].strDescri  := 'BAN_NUMNSU'; Result[5].strTipCmp  := 'VARCHAR(14)';
    Result[6].strDescri  := 'BAN_NUMCCD'; Result[6].strTipCmp  := 'VARCHAR(8)';
    Result[7].strDescri  := 'BAN_CNPJES'; Result[7].strTipCmp  := 'VARCHAR(14)';
    Result[8].strDescri  := 'BAN_NUMPAR'; Result[8].strTipCmp  := 'VARCHAR(2)';
    Result[9].strDescri  := 'BAN_VALPAR'; Result[9].strTipCmp  := 'DECIMAL(15,2)';
    Result[10].strDescri := 'BAN_VALLIQ'; Result[10].strTipCmp := 'DECIMAL(15,2)';
    Result[11].strDescri := 'BAN_TARFIX'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := 'BAN_TARADM'; Result[12].strTipCmp := 'DECIMAL(15,2)';
    Result[13].strDescri := 'BAN_TARCOM'; Result[13].strTipCmp := 'DECIMAL(15,2)';
    Result[14].strDescri := 'BAN_CODAGE'; Result[14].strTipCmp := 'VARCHAR(4)';
    Result[15].strDescri := 'BAN_CODCTA'; Result[15].strTipCmp := 'VARCHAR(10)';
    Result[16].strDescri := 'BAN_DTAARQ'; Result[16].strTipCmp := 'DATE';
    Result[17].strDescri := 'BAN_NOMARQ'; Result[17].strTipCmp := 'VARCHAR(255)';
    Result[18].strDescri := 'BAN_CONCIL'; Result[18].strTipCmp := 'INT';
    Result[19].strDescri := 'BAN_ID_ARQ'; Result[19].strTipCmp := 'VARCHAR(10)';
    Result[20].strDescri := 'BAN_TIPREG'; Result[20].strTipCmp := 'VARCHAR(2)';
    Result[21].strDescri := 'BAN_VALCAN'; Result[21].strTipCmp := 'DECIMAL(15,2)';
    Result[22].strDescri := 'BAN_NOMSOL'; Result[22].strTipCmp := 'VARCHAR(25)';
    Result[23].strDescri := 'BAN_CODSOL'; Result[23].strTipCmp := 'VARCHAR(6)';
    Result[24].strDescri := 'BAN_REDCAN'; Result[24].strTipCmp := 'VARCHAR(11)';
    Result[25].strDescri := 'BAN_CODMSG'; Result[25].strTipCmp := 'VARCHAR(4)';
    Result[26].strDescri := 'BAN_SEQLAN'; Result[26].strTipCmp := 'VARCHAR(2)';
    Result[27].strDescri := 'BAN_IMPTOT'; Result[27].strTipCmp := 'INT';
    Result[28].strDescri := 'BAN_DESCRI'; Result[28].strTipCmp := 'VARCHAR(50)';
  End
  else
  If strTabela = 'BAN_BSPGTO' Then Begin
    SetLength(Result, 12);

    Result[0].strDescri  := 'BAN_CNPJES'; Result[0].strTipCmp  := 'VARCHAR(14)';
    Result[1].strDescri  := 'BAN_CNPJCO'; Result[1].strTipCmp  := 'VARCHAR(14)';
    Result[2].strDescri  := 'BAN_STATUS'; Result[2].strTipCmp  := 'VARCHAR(2)';
    Result[3].strDescri  := 'BAN_BANDEI'; Result[3].strTipCmp  := 'VARCHAR(3)';
    Result[4].strDescri  := 'BAN_CODMOD'; Result[4].strTipCmp  := 'VARCHAR(5)';
    Result[5].strDescri  := 'BAN_TIPMOV'; Result[5].strTipCmp  := 'VARCHAR(1)';
    Result[6].strDescri  := 'BAN_DTALAN'; Result[6].strTipCmp  := 'DATE';
    Result[7].strDescri  := 'BAN_DTAREF'; Result[7].strTipCmp  := 'DATE';
    Result[8].strDescri  := 'BAN_VALLAN'; Result[8].strTipCmp  := 'DECIMAL(15,2)';
    Result[9].strDescri  := 'BAN_DTAARQ'; Result[9].strTipCmp  := 'DATE';
    Result[10].strDescri := 'BAN_NOMARQ'; Result[10].strTipCmp := 'VARCHAR(255)';
    Result[11].strDescri := 'BAN_CONCIL'; Result[11].strTipCmp := 'INT';
  End
  else
  If strTabela = 'BAN_BSANTE' Then Begin
    SetLength(Result, 28);

    Result[0].strDescri  := 'BAN_CNPJES'; Result[0].strTipCmp  := 'VARCHAR(14)';
    Result[1].strDescri  := 'BAN_CNPJCO'; Result[1].strTipCmp  := 'VARCHAR(14)';
    Result[2].strDescri  := 'BAN_DTACON'; Result[2].strTipCmp  := 'DATE';
    Result[3].strDescri  := 'BAN_NUMCON'; Result[3].strTipCmp  := 'VARCHAR(30)';
    Result[4].strDescri  := 'BAN_BANDEI'; Result[4].strTipCmp  := 'VARCHAR(3)';
    Result[5].strDescri  := 'BAN_CANAL_'; Result[5].strTipCmp  := 'VARCHAR(4)';
    Result[6].strDescri  := 'BAN_VALANT'; Result[6].strTipCmp  := 'DECIMAL(15,2)';
    Result[7].strDescri  := 'BAN_PERTAX'; Result[7].strTipCmp  := 'DECIMAL(7,4)';
    Result[8].strDescri  := 'BAN_VALTAX'; Result[8].strTipCmp  := 'DECIMAL(15,2)';
    Result[9].strDescri  := 'BAN_VALREG'; Result[9].strTipCmp  := 'DECIMAL(15,2)';
    Result[10].strDescri := 'BAN_VALLIQ'; Result[10].strTipCmp := 'DECIMAL(15,2)';
    Result[11].strDescri := 'BAN_DTAPAG'; Result[11].strTipCmp := 'DATE';
    Result[12].strDescri := 'BAN_CODBCO'; Result[12].strTipCmp := 'VARCHAR(3)';
    Result[13].strDescri := 'BAN_CODAGE'; Result[13].strTipCmp := 'VARCHAR(4)';
    Result[14].strDescri := 'BAN_CODCTA'; Result[14].strTipCmp := 'VARCHAR(13)';
    Result[15].strDescri := 'BAN_DTAVEN'; Result[15].strTipCmp := 'DATE';
    Result[16].strDescri := 'BAN_CODOPE'; Result[16].strTipCmp := 'VARCHAR(15)';
    Result[17].strDescri := 'BAN_DTATRA'; Result[17].strTipCmp := 'DATE';
    Result[18].strDescri := 'BAN_NUMNSU'; Result[18].strTipCmp := 'VARCHAR(14)';
    Result[19].strDescri := 'BAN_VALBRU'; Result[19].strTipCmp := 'DECIMAL(15,2)';
    Result[20].strDescri := 'BAN_NUMPAR'; Result[20].strTipCmp := 'VARCHAR(2)';
    Result[21].strDescri := 'BAN_TOTPAR'; Result[21].strTipCmp := 'VARCHAR(2)';
    Result[22].strDescri := 'BAN_VALTRA'; Result[22].strTipCmp := 'DECIMAL(15,2)';
    Result[23].strDescri := 'BAN_VALPAR'; Result[23].strTipCmp := 'DECIMAL(15,2)';
    Result[24].strDescri := 'BAN_VENPAR'; Result[24].strTipCmp := 'DATE';
    Result[25].strDescri := 'BAN_NOMARQ'; Result[25].strTipCmp := 'VARCHAR(255)';
    Result[26].strDescri := 'BAN_DTAARQ'; Result[26].strTipCmp := 'DATE';
    Result[27].strDescri := 'BAN_CONCIL'; Result[27].strTipCmp := 'INT';
  End;
end;

class function TBanrisulPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaBanrisulPgto;
    intCont  : Integer;
begin
  If strTabela = 'BAN_BSVEND' Then Begin
    Result := 'CREATE TABLE BAN_BSVEND (';
    arrCampos := fRetEstruturaPgto(strTabela);

    For intCont := 0 to Length(arrCampos) - 1 do
      Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

    Result := Result + ' PRIMARY KEY(BAN_CNPJES, BAN_REDEID, BAN_CODEST, BAN_DTAVEN, BAN_NUMNSU, BAN_NUMPAR, BAN_BANDEI)) ENGINE INNODB ' ;
  End
  else
  If strTabela = 'BAN_BSCRED' Then Begin
    Result := 'CREATE TABLE BAN_BSCRED (';
    arrCampos := fRetEstruturaPgto(strTabela);

    For intCont := 0 to Length(arrCampos) - 1 do
      Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

    Result := Result + ' PRIMARY KEY(BAN_CNPJES, BAN_CODRED, BAN_CODEST, BAN_DTALAN, BAN_CODLAN, BAN_SEQLAN, BAN_NUMNSU, BAN_NUMPAR)) ENGINE INNODB ' ;
  End
  else
  If strTabela = 'BAN_BSPGTO' Then Begin
    Result := 'CREATE TABLE BAN_BSPGTO (';
    arrCampos := fRetEstruturaPgto(strTabela);

    For intCont := 0 to Length(arrCampos) - 1 do
      Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

    Result := Result + ' PRIMARY KEY(BAN_CNPJES, BAN_CNPJCO, BAN_STATUS, BAN_BANDEI, BAN_CODMOD, BAN_DTALAN)) ENGINE INNODB ' ;
  End
  else
  If strTabela = 'BAN_BSANTE' Then Begin
    Result := 'CREATE TABLE BAN_BSANTE (';
    arrCampos := fRetEstruturaPgto(strTabela);

    For intCont := 0 to Length(arrCampos) - 1 do
      Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

    Result := Result + ' PRIMARY KEY(BAN_CNPJES, BAN_CNPJCO, BAN_NUMCON, BAN_BANDEI, BAN_DTAPAG, BAN_DTATRA, BAN_NUMNSU, BAN_NUMPAR)) ENGINE INNODB ' ;
  End
end;

function TBanrisulPgto.fGetSQLReplace(ANomeTabela: String): String;
var intCont   : Integer;
    arrCampos : TArrEstruturaBanrisulPgto;
begin
  Result := 'REPLACE INTO '+ANomeTabela+' (';
  arrCampos := fRetEstruturaPgto(ANomeTabela);
  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ',';
  Result := Copy(Result, 1, Length(Result) - 1) + ') VALUES (';
  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + ':' + arrCampos[intCont].strDescri + ',';
  Result := Copy(Result, 1, Length(Result) - 1) + ')';
end;

procedure TBanrisulPgto.pAdicionaLinha(ALinha: String);
begin
  If fGetDados(ALinha, 001,02) = '99' Then //TRAILER
    Exit
  else
  If fGetDados(ALinha, 001,02) = '00' Then //HEADER
  begin
    FUltimoIdentificadorDoArquivoLido := fGetDados(ALinha, 043, 008);
    FDataDoArquivo                    := fGetDados(ALinha, 059, 008);
  end
  else //MOVIMENTO
  begin
    if (FUltimoIdentificadorDoArquivoLido = 'BJRVCA1') or
       (FUltimoIdentificadorDoArquivoLido = 'BJRVCM8') then
      pAdicionaLinhaRegistroDeVenda(ALinha)
    else
    if (FUltimoIdentificadorDoArquivoLido = 'BJRVCC1') or
       (FUltimoIdentificadorDoArquivoLido = 'BJRVCMB') then
      pAdicionaLinhaRegistroDeCredito(ALinha)
    else
    if (FUltimoIdentificadorDoArquivoLido = 'BJRVCB1') then
      pAdicionaLinhaRegistroDeCancelamento(ALinha)
    else
    if (FUltimoIdentificadorDoArquivoLido = 'BKNFIN1') then
      pAdicionaLinhaRegistroDePagamento(ALinha)
    else
    if (FUltimoIdentificadorDoArquivoLido = 'BJRVCA8') then
      pAdicionaLinhaRegistroDeAntecipacao(ALinha);
  end;

end;

procedure TBanrisulPgto.pAdicionaLinhaRegistroDeCancelamento(ALinha: string);
Var
  SObjetoCancelamento        : TBanrisulCredito;
  SObjetoCancelamentoDetalhe : TBanrisulCreditoDetalhe;
begin
  if fGetDados(ALinha, 001,02) = '10' then
  begin
    SObjetoCancelamento            := TBanrisulCredito.create;
    SObjetoCancelamento.strTipReg  := '10';
    SObjetoCancelamento.strCodRed  := fGetDados(ALinha, 063, 011);
    SObjetoCancelamento.strCodEst  := fGetDados(ALinha, 074, 015);
    SObjetoCancelamento.strCNPJEst := fGetDados(ALinha, 049, 014);
    SObjetoCancelamento.strID_Arq  := FUltimoIdentificadorDoArquivoLido;
    SObjetoCancelamento.strCodMsg  := fGetDados(ALinha, 141, 004);
    SObjetoCancelamento.strCodAge  := '';
    SObjetoCancelamento.strCodCta  := '';
    SObjetoCancelamento.strNomArq  := strNomArq;
    SObjetoCancelamento.strCodLan  := '';
    SObjetoCancelamento.strSeqLan  := '';
    SObjetoCancelamento.dtaDtaArq  := FDataDoArquivo;
    SObjetoCancelamento.dtaDtaLan  := fGetDados(ALinha, 003, 008);
    FListaCredito.Add(SObjetoCancelamento);

    SObjetoCancelamentoDetalhe            := TBanrisulCreditoDetalhe.Create;
    SObjetoCancelamentoDetalhe.strTipReg  := '10';
    SObjetoCancelamentoDetalhe.strCodRed  := fGetDados(ALinha, 063, 011);
    SObjetoCancelamentoDetalhe.strCodEst  := fGetDados(ALinha, 074, 015);
    SObjetoCancelamentoDetalhe.strCNPJEst := fGetDados(ALinha, 049, 014);
    SObjetoCancelamentoDetalhe.strNumNsu  := fStrZero(fGetDados(ALinha, 105, 008),14);
    SObjetoCancelamentoDetalhe.strNumPar  := fGetDados(ALinha, 113, 002);
    SObjetoCancelamentoDetalhe.fltValCan  := fGetDados(ALinha, 172, 015, True);
    SObjetoCancelamentoDetalhe.strNomSol  := fGetDados(ALinha, 017, 025);
    SObjetoCancelamentoDetalhe.strCodSol  := fGetDados(ALinha, 043, 006);
    SObjetoCancelamentoDetalhe.strCodLan  := '';
    SObjetoCancelamentoDetalhe.strSeqLan  := '';
    SObjetoCancelamentoDetalhe.dtaDtaLan  := fGetDados(ALinha, 003, 008);
    SObjetoCancelamentoDetalhe.dtaDtaVen  := fGetDados(ALinha, 097, 008);
    SObjetoCancelamentoDetalhe.fltValPar  := fGetDados(ALinha, 172, 015, True);
    SObjetoCancelamentoDetalhe.fltValLiq  := fGetDados(ALinha, 172, 015, True);
    SObjetoCancelamentoDetalhe.fltTarFix  := fGetDados(ALinha, 195, 006, True);
    SObjetoCancelamentoDetalhe.fltTarAdm  := fGetDados(ALinha, 201, 006, True);
    SObjetoCancelamentoDetalhe.fltTarCom  := 0;
    SObjetoCancelamentoDetalhe.strNomArq  := strNomArq;
    SObjetoCancelamentoDetalhe.strDescri  := 'CANCELAMENTO';

    SObjetoCancelamento.ListaCreditoDetalhes.Add(SObjetoCancelamentoDetalhe);

    If (SObjetoCancelamentoDetalhe.strCNPJEst <> '') And
       (lstEstabel.IndexOf(SObjetoCancelamentoDetalhe.strCNPJEst) < 0) Then
      lstEstabel.Add(SObjetoCancelamentoDetalhe.strCNPJEst);
  end;

end;

procedure TBanrisulPgto.pAdicionaLinhaRegistroDeCredito(ALinha: string);
Var
  SObjetoCredito        : TBanrisulCredito;
  SObjetoCreditoDetalhe : TBanrisulCreditoDetalhe;
begin
  if fGetDados(ALinha, 001,02) = '10' then
  begin
    SObjetoCredito            := TBanrisulCredito.create;
    SObjetoCredito.strTipReg  := '10';
    SObjetoCredito.strCodRed  := fGetDados(ALinha, 003, 011);
    SObjetoCredito.strCodEst  := fGetDados(ALinha, 014, 015);
    SObjetoCredito.strCNPJEst := fGetDados(ALinha, 043, 014);
    SObjetoCredito.strID_Arq  := FUltimoIdentificadorDoArquivoLido;
    SObjetoCredito.strCodMsg  := '';
    SObjetoCredito.strCodAge  := fGetDados(ALinha, 057, 004);
    SObjetoCredito.strCodCta  := fGetDados(ALinha, 061, 010);
    SObjetoCredito.strNomArq  := strNomArq;
    SObjetoCredito.strCodLan  := fGetDados(ALinha, 037, 004);
    SObjetoCredito.strSeqLan  := fGetDados(ALinha, 041, 002);
    SObjetoCredito.dtaDtaArq  := FDataDoArquivo;
    SObjetoCredito.dtaDtaLan  := fGetDados(ALinha, 029, 008);

    FListaCredito.Add(SObjetoCredito);
  end
  else
  if fGetDados(ALinha, 001,02) = '20' then
  begin
    SObjetoCreditoDetalhe            := TBanrisulCreditoDetalhe.Create;
    SObjetoCreditoDetalhe.strTipReg  := '20';
    SObjetoCreditoDetalhe.strCodRed  := fGetDados(ALinha, 003, 011);
    SObjetoCreditoDetalhe.strCodEst  := fGetDados(ALinha, 014, 015);
    if FUltimoIdentificadorDoArquivoLido = 'BJRVCMB' then
      SObjetoCreditoDetalhe.strCNPJEst := fGetDados(ALinha, 163, 014);
    SObjetoCreditoDetalhe.strNumNsu  := fStrZero(fGetDados(ALinha, 051, 008),14);
    SObjetoCreditoDetalhe.strNumPar  := fGetDados(ALinha, 059, 002);
    SObjetoCreditoDetalhe.fltValCan  := 0;
    SObjetoCreditoDetalhe.strNomSol  := '';
    SObjetoCreditoDetalhe.strCodSol  := '';
    SObjetoCreditoDetalhe.strCodLan  := fGetDados(ALinha, 037, 004);
    SObjetoCreditoDetalhe.strSeqLan  := fGetDados(ALinha, 041, 002);
    SObjetoCreditoDetalhe.dtaDtaLan  := fGetDados(ALinha, 029, 008);
    SObjetoCreditoDetalhe.dtaDtaVen  := fGetDados(ALinha, 043, 008);
    SObjetoCreditoDetalhe.fltValPar  := fGetDados(ALinha, 061, 015, True);
    SObjetoCreditoDetalhe.fltValLiq  := fGetDados(ALinha, 108, 015, True);
    SObjetoCreditoDetalhe.fltTarFix  := fGetDados(ALinha, 076, 006, True);
    SObjetoCreditoDetalhe.fltTarAdm  := fGetDados(ALinha, 082, 006, True);
    SObjetoCreditoDetalhe.fltTarCom  := fGetDados(ALinha, 098, 010, True);
    SObjetoCreditoDetalhe.strNomArq  := strNomArq;
    SObjetoCreditoDetalhe.strDescri  := 'CREDITO\DEBITO';

    Try
      FListaCredito.Selecionado :=
         FListaCredito.fGetRegistroCredito(FUltimoIdentificadorDoArquivoLido,
                                           SObjetoCreditoDetalhe);

      FListaCredito.Selecionado.ListaCreditoDetalhes.Add(SObjetoCreditoDetalhe);
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;

    If (SObjetoCreditoDetalhe.strCNPJEst <> '') And
       (lstEstabel.IndexOf(SObjetoCreditoDetalhe.strCNPJEst) < 0) Then
      lstEstabel.Add(SObjetoCreditoDetalhe.strCNPJEst);
  end;
end;

procedure TBanrisulPgto.pAdicionaLinhaRegistroDePagamento(ALinha: string);
Var
  SObjetoPagamento : TBanrisulPagamento;
begin
  if fGetDados(ALinha, 001,02) = '10' then
  begin
    FDataLancamentoPagamentoHeader := fGetDados(ALinha, 096, 008);
    FStatusPagamentoHeader         := fGetDados(ALinha, 031, 002);
  end
  else
  if fGetDados(ALinha, 001,02) = '20' then
  begin
    SObjetoPagamento            := TBanrisulPagamento.create;
    SObjetoPagamento.strCNPJEst := fGetDados(ALinha, 017, 014);
    SObjetoPagamento.strCNPJCon := fGetDados(ALinha, 003, 014);
    SObjetoPagamento.strStatus  := FStatusPagamentoHeader;
    SObjetoPagamento.strBandei  := fGetDados(ALinha, 031, 003);
    SObjetoPagamento.strCodMod  := fGetDados(ALinha, 034, 005);
    SObjetoPagamento.strNomArq  := strNomArq;
    SObjetoPagamento.dtaDtaArq  := FDataDoArquivo;
    SObjetoPagamento.dtaDtaLan  := FDataLancamentoPagamentoHeader;
    SObjetoPagamento.dtaDtaRef  := fGetDados(ALinha, 055, 008);
    SObjetoPagamento.fltValLan  := fGetDados(ALinha, 040, 015, True);
    SObjetoPagamento.strTipMov  := fGetDados(ALinha, 039, 001);

    FListaPagamento.Add(SObjetoPagamento);

    If (SObjetoPagamento.strCNPJEst <> '') And
       (lstEstabel.IndexOf(SObjetoPagamento.strCNPJEst) < 0) Then
      lstEstabel.Add(SObjetoPagamento.strCNPJEst);
  end;
end;

procedure TBanrisulPgto.pAdicionaLinhaRegistroDeAntecipacao(ALinha: string);
begin
  If fGetDados(ALinha, 001,02) = '10' Then
  Begin
    FRegistroAntecipacao := TBanrisulAntecipacao.Create;
    FListaAntecipacao.Add(FRegistroAntecipacao);

    FRegistroAntecipacao.strCNPJEst := fGetDados(ALinha, 017, 014);
    FRegistroAntecipacao.strCNPJCon := fGetDados(ALinha, 003, 014);
    FRegistroAntecipacao.strNumCon  := fGetDados(ALinha, 039, 030);
    FRegistroAntecipacao.strBandei  := fGetDados(ALinha, 069, 003);
    FRegistroAntecipacao.strCanal_  := fGetDados(ALinha, 072, 004);
    FRegistroAntecipacao.strCodBco  := fGetDados(ALinha, 167, 003);
    FRegistroAntecipacao.strCodAge  := fGetDados(ALinha, 170, 004);
    FRegistroAntecipacao.strCodCta  := fGetDados(ALinha, 174, 013);
    FRegistroAntecipacao.dtaDtaCon  := fGetDados(ALinha, 031, 008);
    FRegistroAntecipacao.dtaDtaPag  := fGetDados(ALinha, 158, 008);
    FRegistroAntecipacao.dtaDtaArq  := FDataDoArquivo;
    FRegistroAntecipacao.strNomArq  := strNomArq;
    FRegistroAntecipacao.fltValAnt  := fGetDados(ALinha, 076, 015, True);
    FRegistroAntecipacao.fltPerTax  := fGetDados(ALinha, 091, 008, True);
    FRegistroAntecipacao.fltValTax  := fGetDados(ALinha, 099, 015, True);
    FRegistroAntecipacao.fltValReg  := fGetDados(ALinha, 114, 015);

    If (FRegistroAntecipacao.strCNPJEst <> '') And
       (lstEstabel.IndexOf(FRegistroAntecipacao.strCNPJEst) < 0) Then
      lstEstabel.Add(FRegistroAntecipacao.strCNPJEst);
  end
  else
  If fGetDados(ALinha, 001,02) = '20' Then
  begin
    FRegistroAntecipacao.strCodOpe  := fGetDados(ALinha, 095, 015);
    FRegistroAntecipacao.dtaDtaVen  := fGetDados(ALinha, 087, 008);
    FRegistroAntecipacao.fltValLiq  := fGetDados(ALinha, 069, 015, True);
    FRegistroAntecipacao.fltValBru  := fGetDados(ALinha, 039, 015, True);
  end
  else
  If fGetDados(ALinha, 001,02) = '40' Then
  begin
    FRegistroAntecipacao.strNumNSU  := fStrZero(fGetDados(ALinha, 025, 008),14);
    FRegistroAntecipacao.strNumPar  := fGetDados(ALinha, 051, 003);
    FRegistroAntecipacao.strTotPar  := fGetDados(ALinha, 048, 003);
    FRegistroAntecipacao.dtaDtaTra  := fGetDados(ALinha, 017, 008);
    FRegistroAntecipacao.dtaVenPar  := fGetDados(ALinha, 069, 008);
    FRegistroAntecipacao.fltValTra  := fGetDados(ALinha, 033, 015, True);
    FRegistroAntecipacao.fltValPar  := fGetDados(ALinha, 054, 015, True);
  end;
end;

procedure TBanrisulPgto.pAdicionaLinhaRegistroDeVenda(ALinha: string);
Var
  SObjetoVenda : TBanrisulVendas;
begin
  If fGetDados(ALinha, 001,02) = '10' Then
  Begin
    SObjetoVenda := TBanrisulVendas.Create;
    SObjetoVenda.strCodEst  := fGetDados(ALinha, 028, 015);
    SObjetoVenda.strCNPJEst := fGetDados(ALinha, 003, 014);
    SObjetoVenda.strRedeID  := fGetDados(ALinha, 017, 011);
    SObjetoVenda.strID_Arq  := FUltimoIdentificadorDoArquivoLido;
    SObjetoVenda.strNumNsu  := fStrZero(fGetDados(ALinha, 059, 008),14);
    SObjetoVenda.strNumPar  := fGetDados(ALinha, 067, 002);
    SObjetoVenda.strTotPar  := fGetDados(ALinha, 069, 002);
    SObjetoVenda.dtaDtaVen  := fGetDados(ALinha, 051, 008);
    SObjetoVenda.dtaDtaOri  := fGetDados(ALinha, 077, 008);
    SObjetoVenda.strNSUOri  := fStrZero(fGetDados(ALinha, 089, 006),14);
    SObjetoVenda.strCodMsg  := fGetDados(ALinha, 095, 004);
    SObjetoVenda.strCodPrc  := fGetDados(ALinha, 099, 006);
    SObjetoVenda.strServic  := fGetDados(ALinha, 105, 004);
    SObjetoVenda.strSituac  := fGetDados(ALinha, 109, 002);
    SObjetoVenda.fltValVen  := fGetDados(ALinha, 111, 015, True);
    SObjetoVenda.fltValPar  := fGetDados(ALinha, 126, 015, True);
    SObjetoVenda.dtaDtaCre  := fGetDados(ALinha, 141, 008);
    SObjetoVenda.fltPerTax  := fGetDados(ALinha, 155, 006, True);
    SObjetoVenda.fltTarifa  := fGetDados(ALinha, 161, 010, True);
    SObjetoVenda.fltLiqPar  := fGetDados(ALinha, 177, 015, True);
    SObjetoVenda.strPrazo_  := fGetDados(ALinha, 192, 003);
    SObjetoVenda.strPraUlt  := fGetDados(ALinha, 195, 003);
    SObjetoVenda.dtaDtaCnf  := fGetDados(ALinha, 198, 008);
    SObjetoVenda.strID_ped  := fGetDados(ALinha, 212, 040);
    SObjetoVenda.strCPFCli  := fGetDados(ALinha, 252, 014);

    SObjetoVenda.strBandei  := IIF(FUltimoIdentificadorDoArquivoLido = 'BJRVCM8',
                                   fGetDados(ALinha, 291, 003),
                                   '001');
    SObjetoVenda.strIniCar  := IIF(FUltimoIdentificadorDoArquivoLido = 'BJRVCM8',
                                   fGetDados(ALinha, 294, 006),
                                   fGetDados(ALinha, 291, 006));
    SObjetoVenda.strFinCar  := IIF(FUltimoIdentificadorDoArquivoLido = 'BJRVCM8',
                                   fGetDados(ALinha, 300, 004),
                                   fGetDados(ALinha, 297, 004));

    SObjetoVenda.dtaDtaArq  := FDataDoArquivo;
    SObjetoVenda.strNomArq  := strNomArq;

    FListaVendas.Add(SObjetoVenda);

    If (SObjetoVenda.strCNPJEst <> '') And
       (lstEstabel.IndexOf(SObjetoVenda.strCNPJEst) < 0) Then
      lstEstabel.Add(SObjetoVenda.strCNPJEst);
  End;
end;

procedure TBanrisulPgto.pGravaRegistrosDeAntecipacao(pgbProg: TProgressBar);
Var qryDados           : IDataSet;
    SObjetoAntecipacao : TBanrisulAntecipacao;
begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := fGetSQLReplace('BAN_BSANTE');

  pgbProg.Position := 0;

  If FListaAntecipacao.Count > 0 Then
  Begin
    pgbProg.Max := FListaAntecipacao.Count - 1;

    For SObjetoAntecipacao in FListaAntecipacao do
    Begin
      Application.ProcessMessages;

      Try
        qryDados.Close;
        qryDados.ParamByName('BAN_CNPJES').Value      := SObjetoAntecipacao.strCNPJEst;
        qryDados.ParamByName('BAN_CNPJCO').Value      := SObjetoAntecipacao.strCNPJCon;
        qryDados.ParamByName('BAN_DTACON').AsDateTime := fFormataData(SObjetoAntecipacao.dtaDtaCon ,True);
        qryDados.ParamByName('BAN_NUMCON').Value      := SObjetoAntecipacao.strNumCon;
        qryDados.ParamByName('BAN_BANDEI').Value      := SObjetoAntecipacao.strBandei;
        qryDados.ParamByName('BAN_CANAL_').Value      := SObjetoAntecipacao.strCanal_;
        qryDados.ParamByName('BAN_VALANT').Value      := SObjetoAntecipacao.fltValAnt;
        qryDados.ParamByName('BAN_PERTAX').Value      := SObjetoAntecipacao.fltPerTax/100;
        qryDados.ParamByName('BAN_VALTAX').Value      := SObjetoAntecipacao.fltValTax;
        qryDados.ParamByName('BAN_VALREG').Value      := SObjetoAntecipacao.fltValReg;
        qryDados.ParamByName('BAN_VALLIQ').Value      := SObjetoAntecipacao.fltValLiq;
        qryDados.ParamByName('BAN_DTAPAG').AsDateTime := fFormataData(SObjetoAntecipacao.dtaDtaPag ,True);
        qryDados.ParamByName('BAN_CODBCO').Value      := SObjetoAntecipacao.strCodBco;
        qryDados.ParamByName('BAN_CODAGE').Value      := SObjetoAntecipacao.strCodAge;
        qryDados.ParamByName('BAN_CODCTA').Value      := SObjetoAntecipacao.strCodCta;
        qryDados.ParamByName('BAN_DTAVEN').AsDateTime := fFormataData(SObjetoAntecipacao.dtaDtaVen ,True);
        qryDados.ParamByName('BAN_CODOPE').Value      := SObjetoAntecipacao.strCodOpe;
        qryDados.ParamByName('BAN_DTATRA').AsDateTime := fFormataData(SObjetoAntecipacao.dtaDtaTra ,True);
        qryDados.ParamByName('BAN_NUMNSU').Value      := SObjetoAntecipacao.strNumNSU;
        qryDados.ParamByName('BAN_VALBRU').Value      := SObjetoAntecipacao.fltValBru;
        qryDados.ParamByName('BAN_NUMPAR').Value      := SObjetoAntecipacao.strNumPar;
        qryDados.ParamByName('BAN_TOTPAR').Value      := SObjetoAntecipacao.strTotPar;
        qryDados.ParamByName('BAN_VALTRA').Value      := SObjetoAntecipacao.fltValTra;
        qryDados.ParamByName('BAN_VALPAR').Value      := SObjetoAntecipacao.fltValPar;
        qryDados.ParamByName('BAN_VENPAR').Value      := fFormataData(SObjetoAntecipacao.dtaVenPar ,True);
        qryDados.ParamByName('BAN_NOMARQ').Value      := SObjetoAntecipacao.strNomArq;
        qryDados.ParamByName('BAN_DTAARQ').AsDateTime := fFormataData(SObjetoAntecipacao.dtaDtaArq ,True);
        qryDados.ParamByName('BAN_CONCIL').Value      := 0;
        qryDados.ExecSQL;
      Except
        On E: Exception Do
          Raise Exception.Create('Erro ao grava registro de antecipação com N° NSU "'+SObjetoAntecipacao.strNumNsu+'" do arquivo: '+
          SObjetoAntecipacao.strNomArq+'. Erro gerado: '+E.Message);
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;
  End;
end;

procedure TBanrisulPgto.pGravaRegistrosDeCredito(pgbProg: TProgressBar);
Var qryDados              : IDataSet;
    SObjetoCredito        : TBanrisulCredito;
    SObjetoCreditoDetalhe : TBanrisulCreditoDetalhe;
begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := fGetSQLReplace('BAN_BSCRED');

  pgbProg.Position := 0;

  If FListaCredito.Count > 0 Then
  Begin
    pgbProg.Max := FListaCredito.Count - 1;

    For SObjetoCredito in FListaCredito do
      for SObjetoCreditoDetalhe in SObjetoCredito.ListaCreditoDetalhes do
      Begin
        Application.ProcessMessages;

        Try
          qryDados.Close;
          qryDados.ParamByName('BAN_CODEST').Value      := SObjetoCreditoDetalhe.strCodEst;
          qryDados.ParamByName('BAN_CODRED').Value      := SObjetoCreditoDetalhe.strCodRed;
          qryDados.ParamByName('BAN_DTALAN').AsDateTime := fFormataData(SObjetoCreditoDetalhe.dtaDtaLan);
          qryDados.ParamByName('BAN_CODLAN').Value      := SObjetoCreditoDetalhe.strCodLan;
          qryDados.ParamByName('BAN_DTAVEN').AsDateTime := fFormataData(SObjetoCreditoDetalhe.dtaDtaVen);
          qryDados.ParamByName('BAN_CNPJES').Value      := SObjetoCredito.strCNPJEst;
          qryDados.ParamByName('BAN_NUMNSU').Value      := SObjetoCreditoDetalhe.strNumNsu;
          qryDados.ParamByName('BAN_NUMCCD').Value      := '';
          qryDados.ParamByName('BAN_NUMPAR').Value      := SObjetoCreditoDetalhe.strNumPar;
          qryDados.ParamByName('BAN_VALPAR').Value      := SObjetoCreditoDetalhe.fltValPar;
          qryDados.ParamByName('BAN_VALLIQ').Value      := SObjetoCreditoDetalhe.fltValLiq;
          qryDados.ParamByName('BAN_TARFIX').Value      := SObjetoCreditoDetalhe.fltTarFix;
          qryDados.ParamByName('BAN_TARADM').Value      := SObjetoCreditoDetalhe.fltTarAdm/100;
          qryDados.ParamByName('BAN_TARCOM').Value      := SObjetoCreditoDetalhe.fltTarCom;
          qryDados.ParamByName('BAN_CODAGE').Value      := SObjetoCredito.strCodAge;
          qryDados.ParamByName('BAN_CODCTA').Value      := SObjetoCredito.strCodCta;
          qryDados.ParamByName('BAN_DTAARQ').AsDateTime := fFormataData(SObjetoCredito.dtaDtaArq);
          qryDados.ParamByName('BAN_NOMARQ').Value      := SObjetoCredito.strNomArq;
          qryDados.ParamByName('BAN_CONCIL').Value      := '0';
          qryDados.ParamByName('BAN_ID_ARQ').Value      := SObjetoCredito.strID_Arq;
          qryDados.ParamByName('BAN_TIPREG').Value      := SObjetoCreditoDetalhe.strTipReg;
          qryDados.ParamByName('BAN_VALCAN').Value      := SObjetoCreditoDetalhe.fltValCan;
          qryDados.ParamByName('BAN_NOMSOL').Value      := SObjetoCreditoDetalhe.strNomSol;
          qryDados.ParamByName('BAN_CODSOL').Value      := SObjetoCreditoDetalhe.strCodSol;
          qryDados.ParamByName('BAN_REDCAN').Value      := SObjetoCreditoDetalhe.strCodRed;
          qryDados.ParamByName('BAN_CODMSG').Value      := SObjetoCredito.strCodMsg;
          qryDados.ParamByName('BAN_SEQLAN').Value      := SObjetoCreditoDetalhe.strSeqLan;
          qryDados.ParamByName('BAN_IMPTOT').Value      := 0;
          qryDados.ParamByName('BAN_DESCRI').Value      := SObjetoCreditoDetalhe.strDescri;

          qryDados.ExecSQL;
        Except
          On E: Exception Do
            Raise Exception.Create('Erro ao grava registro de crédito com N° NSU "'+SObjetoCreditoDetalhe.strNumNsu+'" do arquivo: '+
            SObjetoCredito.strNomArq+'. Erro gerado: '+E.Message);
        End;

        pgbProg.Position := pgbProg.Position + 1;
      End;
  End;
end;

procedure TBanrisulPgto.pGravaRegistrosDePagamento(pgbProg: TProgressBar);
Var qryDados         : IDataSet;
    SObjetoPagamento : TBanrisulPagamento;
begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := fGetSQLReplace('BAN_BSPGTO');

  pgbProg.Position := 0;

  If FListaPagamento.Count > 0 Then
  Begin
    pgbProg.Max := FListaPagamento.Count - 1;

    For SObjetoPagamento in FListaPagamento do
    Begin
      Application.ProcessMessages;

      Try
        qryDados.Close;
        qryDados.ParamByName('BAN_CNPJES').Value      := SObjetoPagamento.strCNPJEst;
        qryDados.ParamByName('BAN_CNPJCO').Value      := SObjetoPagamento.strCNPJCon;
        qryDados.ParamByName('BAN_STATUS').Value      := SObjetoPagamento.strStatus;
        qryDados.ParamByName('BAN_BANDEI').Value      := SObjetoPagamento.strBandei;
        qryDados.ParamByName('BAN_CODMOD').Value      := SObjetoPagamento.strCodMod;
        qryDados.ParamByName('BAN_TIPMOV').Value      := SObjetoPagamento.strTipMov;
        qryDados.ParamByName('BAN_DTALAN').AsDateTime := fFormataData(SObjetoPagamento.dtaDtaLan);
        qryDados.ParamByName('BAN_DTAREF').AsDateTime := fFormataData(SObjetoPagamento.dtaDtaRef);
        qryDados.ParamByName('BAN_VALLAN').Value      := SObjetoPagamento.fltValLan;
        qryDados.ParamByName('BAN_DTAARQ').AsDateTime := fFormataData(SObjetoPagamento.dtaDtaArq);
        qryDados.ParamByName('BAN_NOMARQ').Value      := SObjetoPagamento.strNomArq;
        qryDados.ParamByName('BAN_CONCIL').Value      := 0;
        qryDados.ExecSQL;
      Except
        On E: Exception Do
          Raise Exception.Create('Erro ao grava registro de pagamento com CNPJ "'+SObjetoPagamento.strCNPJEst+'", '+
          'bandeira "'+SObjetoPagamento.strBandei+'" e valor "R$'+FloatToStr(SObjetoPagamento.fltValLan)+'" do arquivo: '+
          SObjetoPagamento.strNomArq+'. Erro gerado: '+E.Message);
      End;
      pgbProg.Position := pgbProg.Position + 1;
    End;
  End;
end;

procedure TBanrisulPgto.pGravaRegistrosDeVenda(pgbProg: TProgressBar);
Var qryDados     : IDataSet;
    SObjetoVenda : TBanrisulVendas;
begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := fGetSQLReplace('BAN_BSVEND');

  pgbProg.Position := 0;

  If FListaVendas.Count > 0 Then
  Begin
    pgbProg.Max := FListaVendas.Count - 1;

    For SObjetoVenda in FListaVendas do
    Begin
      Application.ProcessMessages;

      Try
        qryDados.Close;
        qryDados.ParamByName('BAN_CODEST').Value      := SObjetoVenda.strCodEst;
        qryDados.ParamByName('BAN_CNPJES').Value      := SObjetoVenda.strCNPJEst;
        qryDados.ParamByName('BAN_REDEID').Value      := SObjetoVenda.strRedeID;
        qryDados.ParamByName('BAN_ID_ARQ').Value      := SObjetoVenda.strID_Arq;
        qryDados.ParamByName('BAN_NUMNSU').Value      := SObjetoVenda.strNumNsu;
        qryDados.ParamByName('BAN_NUMPAR').Value      := SObjetoVenda.strNumPar;
        qryDados.ParamByName('BAN_TOTPAR').Value      := SObjetoVenda.strTotPar;
        qryDados.ParamByName('BAN_DTAVEN').AsDateTime := fFormataData(SObjetoVenda.dtaDtaVen);
        qryDados.ParamByName('BAN_DTAORI').AsDateTime := fFormataData(SObjetoVenda.dtaDtaOri);
        qryDados.ParamByName('BAN_NSUORI').Value      := SObjetoVenda.strNSUOri;
        qryDados.ParamByName('BAN_CODMSG').Value      := SObjetoVenda.strCodMsg;
        qryDados.ParamByName('BAN_CODPRC').Value      := SObjetoVenda.strCodPrc;
        qryDados.ParamByName('BAN_SERVIC').Value      := SObjetoVenda.strServic;
        qryDados.ParamByName('BAN_SITUAC').Value      := SObjetoVenda.strSituac;
        qryDados.ParamByName('BAN_VALVEN').Value      := SObjetoVenda.fltValVen;
        qryDados.ParamByName('BAN_VALPAR').Value      := SObjetoVenda.fltValPar;
        qryDados.ParamByName('BAN_DTACRE').AsDateTime := fFormataData(SObjetoVenda.dtaDtaCre);
        qryDados.ParamByName('BAN_PERTAX').Value      := SObjetoVenda.fltPerTax/100;
        qryDados.ParamByName('BAN_TARIFA').Value      := SObjetoVenda.fltTarifa;
        qryDados.ParamByName('BAN_LIQPAR').Value      := SObjetoVenda.fltLiqPar;
        qryDados.ParamByName('BAN_PRAZO_').Value      := SObjetoVenda.strPrazo_;
        qryDados.ParamByName('BAN_PRAULT').Value      := SObjetoVenda.strPraUlt;
        qryDados.ParamByName('BAN_DTACNF').AsDateTime := fFormataData(SObjetoVenda.dtaDtaCnf);
        qryDados.ParamByName('BAN_ID_PED').Value      := SObjetoVenda.strID_ped;
        qryDados.ParamByName('BAN_CPFCLI').Value      := SObjetoVenda.strCPFCli;
        qryDados.ParamByName('BAN_BANDEI').Value      := SObjetoVenda.strBandei;
        qryDados.ParamByName('BAN_INICAR').Value      := SObjetoVenda.strIniCar;
        qryDados.ParamByName('BAN_FINCAR').Value      := SObjetoVenda.strFinCar;
        qryDados.ParamByName('BAN_DTAARQ').AsDateTime := fFormataData(SObjetoVenda.dtaDtaArq);
        qryDados.ParamByName('BAN_NOMARQ').Value      := SObjetoVenda.strNomArq;
        qryDados.ExecSQL;
      Except
        On E: Exception Do
          Raise Exception.Create('Erro ao grava registro de venda com N° NSU "'+SObjetoVenda.strNumNsu+'" do arquivo: '+
          SObjetoVenda.strNomArq+'. Erro gerado: '+E.Message);
      End;
      pgbProg.Position := pgbProg.Position + 1;
    End;
  End;
end;

procedure TBanrisulPgto.pGravarRegistros(pgbProg: TProgressBar);
var qryDados : IDataSet;
    intCont  : Integer;
begin
  pGravaRegistrosDeVenda(pgbProg);
  pGravaRegistrosDeCredito(pgbProg);
  pGravaRegistrosDeAntecipacao(pgbProg);
  pGravaRegistrosDePagamento(pgbProg);

  qryDados := objFunctions.fGetDataSet;
  Try
    qryDados.Close;
    qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "BANRISUL")';
    For intCont := 0 To lstEstabel.Count - 1 Do
    Begin
      qryDados.ParamByName('ESTAB').AsString := lstEstabel[intCont];
      qryDados.ExecSQL;
    End;
  Except
    Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
  End;
end;

end.
