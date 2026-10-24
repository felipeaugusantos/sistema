{**************************************}
{* Importação de arquivos da BANRISUL *}
{***********************************AJ*}
unit untBanrisulPgto;

interface

uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Forms, System.Math, Dialogs,  System.Generics.Collections,

     Uni,Data.DB, cxProgressBar,

     untIBanrisulIntegracaoLibCartoes, untTBanrisulFuncoes, untBanrisulTipos;


Type

  TBanrisulPgto = Class(TInterfacedObject, ICartoes)
  Private
    FRegistroAntecipacao : TBanrisulAntecipacao;

    FDataDoArquivo                    : String;
    FDataLancamentoPagamentoHeader    : String;
    FStatusPagamentoHeader            : String;
    FUltimoIdentificadorDoArquivoLido : String;


    FListaAntecipacao: TObjectList<TBanrisulAntecipacao>;
    FListaCredito    : TBanrisulCreditoList;
    FListaPagamento  : TObjectList<TBanrisulPagamento>;
    FListaVendas     : TObjectList<TBanrisulVendas>;

    function fFormataData(AData : String; APadraoBrasileiro : Boolean = False) : TDate;
    function fGetDados(ATexto : String; intIni, intTam: Integer; blnFlt: Boolean = False): Variant;

    procedure pAdicionaLinhaRegistroDeCancelamento(ALinha : string);
    procedure pAdicionaLinhaRegistroDeCredito(ALinha : string);
    procedure pAdicionaLinhaRegistroDePagamento(ALinha : string);
    procedure pAdicionaLinhaRegistroDeAntecipacao(ALinha : string);
    procedure pAdicionaLinhaRegistroDeVenda(ALinha : string);

    procedure pGravaRegistrosDeAntecipacao(pgbProg: TcxProgressBar);
    procedure pGravaRegistrosDeCredito(pgbProg: TcxProgressBar);
    procedure pGravaRegistrosDePagamento(pgbProg: TcxProgressBar);
    procedure pGravaRegistrosDeVenda(pgbProg: TcxProgressBar);

  Public
    constructor Create;
    destructor Destroy; Override;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaBanrisulPgto;
  Private
    procedure pAdicionaLinhaRegistroDeVendaTodasBandeiras(ALinha : string);
  End;

Var
  strNomArq: String;

implementation

{ TBanrisulPgto }

constructor TBanrisulPgto.Create;
Begin
  FListaVendas      := TObjectList<TBanrisulVendas>.Create;
  FListaCredito     := TBanrisulCreditoList.Create;
  FListaPagamento   := TObjectList<TBanrisulPagamento>.Create;
  FListaAntecipacao := TObjectList<TBanrisulAntecipacao>.Create;
End;

destructor TBanrisulPgto.Destroy;
begin
  FreeAndNil(FListaVendas);
  FreeAndNil(FListaCredito);
  FreeAndNil(FListaPagamento);
  FreeAndNil(FListaAntecipacao);
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
Var
  Lrst: Variant;
Begin
  Lrst := Trim(Copy(ATexto, intIni, intTam));
  If blnFlt Then Lrst := TBanrisulFuncoes.fStrToFloat(Lrst) / 100;
  Result := Lrst;
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
    Result[18].strDescri := 'BAN_CONCIL'; Result[18].strTipCmp := 'INT DEFAULT 0';
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
    Result[11].strDescri := 'BAN_CONCIL'; Result[11].strTipCmp := 'INT DEFAULT 0';
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
    Result[27].strDescri := 'BAN_CONCIL'; Result[27].strTipCmp := 'INT DEFAULT 0';
  End;
end;

class function TBanrisulPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var
  arrCampos: TArrEstruturaBanrisulPgto;
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

procedure TBanrisulPgto.pAdicionaLinha(strString: String);
var
  LIdent : String;
begin
  If fGetDados(strString, 001,02) = '99' Then //TRAILER
    Exit
  else
  If fGetDados(strString, 001,02) = '00' Then //HEADER
  begin
    LIdent := Trim(fGetDados(strString, 043, 008));
    If (Length(LIdent) = 8) And (AnsiRightStr(LIdent, 1) = 'S') Then
      LIdent := Copy(LIdent, 1, 7);

    FUltimoIdentificadorDoArquivoLido := LIdent;
    FDataDoArquivo                    := fGetDados(strString, 059, 008);
  end
  else //MOVIMENTO
  begin
    if (FUltimoIdentificadorDoArquivoLido = 'BJRVCA1') or
       (FUltimoIdentificadorDoArquivoLido = 'BJRVCM8') then
      pAdicionaLinhaRegistroDeVenda(strString)
    else
    if (FUltimoIdentificadorDoArquivoLido = 'BJRVCC1') or
       (FUltimoIdentificadorDoArquivoLido = 'BJRVCMB') or
       (FUltimoIdentificadorDoArquivoLido = 'BJRVC41') then
      pAdicionaLinhaRegistroDeCredito(strString)
    else
    if (FUltimoIdentificadorDoArquivoLido = 'BJRVCB1') then
      pAdicionaLinhaRegistroDeCancelamento(strString)
    else
    if (FUltimoIdentificadorDoArquivoLido = 'BKNFIN1') then
      pAdicionaLinhaRegistroDePagamento(strString)
    else
    if (FUltimoIdentificadorDoArquivoLido = 'BJRVCA8') then
      pAdicionaLinhaRegistroDeAntecipacao(strString)
    else
    if (FUltimoIdentificadorDoArquivoLido = 'BJRVC21') then
      pAdicionaLinhaRegistroDeVendaTodasBandeiras(strString);
  end;

end;

procedure TBanrisulPgto.pAdicionaLinhaRegistroDeCancelamento(ALinha: string);
Var
  LObjetoCancelamento        : TBanrisulCredito;
  LObjetoCancelamentoDetalhe : TBanrisulCreditoDetalhe;
begin
  if fGetDados(ALinha, 001,02) = '10' then
  begin
    LObjetoCancelamento            := TBanrisulCredito.create;
    LObjetoCancelamento.strTipReg  := '10';
    LObjetoCancelamento.strCodRed  := fGetDados(ALinha, 063, 011);
    LObjetoCancelamento.strCodEst  := fGetDados(ALinha, 074, 015);
    LObjetoCancelamento.strCNPJEst := fGetDados(ALinha, 049, 014);
    LObjetoCancelamento.strID_Arq  := FUltimoIdentificadorDoArquivoLido;
    LObjetoCancelamento.strCodMsg  := fGetDados(ALinha, 141, 004);
    LObjetoCancelamento.strCodAge  := '';
    LObjetoCancelamento.strCodCta  := '';
    LObjetoCancelamento.strNomArq  := strNomArq;
    LObjetoCancelamento.strCodLan  := '';
    LObjetoCancelamento.strSeqLan  := '';
    LObjetoCancelamento.dtaDtaArq  := FDataDoArquivo;
    LObjetoCancelamento.dtaDtaLan  := fGetDados(ALinha, 003, 008);
    FListaCredito.Add(LObjetoCancelamento);

    LObjetoCancelamentoDetalhe            := TBanrisulCreditoDetalhe.Create;
    LObjetoCancelamentoDetalhe.strTipReg  := '10';
    LObjetoCancelamentoDetalhe.strCodRed  := fGetDados(ALinha, 063, 011);
    LObjetoCancelamentoDetalhe.strCodEst  := fGetDados(ALinha, 074, 015);
    LObjetoCancelamentoDetalhe.strCNPJEst := fGetDados(ALinha, 049, 014);
    LObjetoCancelamentoDetalhe.strNumNsu  := TBanrisulFuncoes.fStrZero(fGetDados(ALinha, 105, 008),14);
    LObjetoCancelamentoDetalhe.strNumPar  := fGetDados(ALinha, 113, 002);
    LObjetoCancelamentoDetalhe.fltValCan  := fGetDados(ALinha, 172, 015, True);
    LObjetoCancelamentoDetalhe.strNomSol  := fGetDados(ALinha, 017, 025);
    LObjetoCancelamentoDetalhe.strCodSol  := fGetDados(ALinha, 043, 006);
    LObjetoCancelamentoDetalhe.strCodLan  := '';
    LObjetoCancelamentoDetalhe.strSeqLan  := '';
    LObjetoCancelamentoDetalhe.dtaDtaLan  := fGetDados(ALinha, 003, 008);
    LObjetoCancelamentoDetalhe.dtaDtaVen  := fGetDados(ALinha, 097, 008);
    LObjetoCancelamentoDetalhe.fltValPar  := fGetDados(ALinha, 172, 015, True);
    LObjetoCancelamentoDetalhe.fltValLiq  := fGetDados(ALinha, 172, 015, True);
    LObjetoCancelamentoDetalhe.fltTarFix  := fGetDados(ALinha, 195, 006, True);
    LObjetoCancelamentoDetalhe.fltTarAdm  := fGetDados(ALinha, 201, 006, True);
    LObjetoCancelamentoDetalhe.fltTarCom  := 0;
    LObjetoCancelamentoDetalhe.strNomArq  := strNomArq;
    LObjetoCancelamentoDetalhe.strDescri  := 'CANCELAMENTO';

    LObjetoCancelamento.ListaCreditoDetalhes.Add(LObjetoCancelamentoDetalhe);

    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    If(LObjetoCancelamentoDetalhe.strCNPJEst <> '') And
       (VS_ListaEstabelecimentos.IndexOf(LObjetoCancelamentoDetalhe.strCNPJEst) < 0) Then
      VS_ListaEstabelecimentos.Add(LObjetoCancelamentoDetalhe.strCNPJEst);
  end;

end;

procedure TBanrisulPgto.pAdicionaLinhaRegistroDeCredito(ALinha: string);
Var
  LObjetoCredito        : TBanrisulCredito;
  LObjetoCreditoDetalhe : TBanrisulCreditoDetalhe;
begin
  if fGetDados(ALinha, 001,02) = '10' then
  begin
    LObjetoCredito            := TBanrisulCredito.create;
    LObjetoCredito.strTipReg  := '10';
    LObjetoCredito.strCodRed  := fGetDados(ALinha, 003, 011);
    LObjetoCredito.strCodEst  := fGetDados(ALinha, 014, 015);
    LObjetoCredito.strCNPJEst := fGetDados(ALinha, 043, 014);
    LObjetoCredito.strID_Arq  := FUltimoIdentificadorDoArquivoLido;
    LObjetoCredito.strCodMsg  := '';
    LObjetoCredito.strCodAge  := fGetDados(ALinha, 057, 004);
    LObjetoCredito.strCodCta  := fGetDados(ALinha, 061, 010);
    LObjetoCredito.strNomArq  := strNomArq;
    LObjetoCredito.strCodLan  := fGetDados(ALinha, 037, 004);
    LObjetoCredito.strSeqLan  := fGetDados(ALinha, 041, 002);
    LObjetoCredito.dtaDtaArq  := FDataDoArquivo;
    LObjetoCredito.dtaDtaLan  := fGetDados(ALinha, 029, 008);

    If FUltimoIdentificadorDoArquivoLido = 'BJRVC41' Then
    Begin
      LObjetoCredito.strCNPJEst := fGetDados(ALinha, 046, 014);
      LObjetoCredito.strCodAge  := '';
      LObjetoCredito.strCodCta  := '';
      LObjetoCredito.strCodLan  := fGetDados(ALinha, 038, 006);
      LObjetoCredito.strSeqLan  := fGetDados(ALinha, 044, 002);
    End;

    FListaCredito.Add(LObjetoCredito);
  end
  else
  if fGetDados(ALinha, 001,02) = '20' then
  begin
    LObjetoCreditoDetalhe            := TBanrisulCreditoDetalhe.Create;
    LObjetoCreditoDetalhe.strTipReg  := '20';
    LObjetoCreditoDetalhe.strCodRed  := fGetDados(ALinha, 003, 011);
    LObjetoCreditoDetalhe.strCodEst  := fGetDados(ALinha, 014, 015);
    if FUltimoIdentificadorDoArquivoLido = 'BJRVCMB' then
      LObjetoCreditoDetalhe.strCNPJEst := fGetDados(ALinha, 163, 014)
    else
    if FUltimoIdentificadorDoArquivoLido = 'BJRVC41' then
      LObjetoCreditoDetalhe.strCNPJEst := fGetDados(ALinha, 123, 014);
    LObjetoCreditoDetalhe.strNumNsu  := TBanrisulFuncoes.fStrZero(fGetDados(ALinha, 051, 008),14);
    LObjetoCreditoDetalhe.strNumPar  := fGetDados(ALinha, 059, 002);
    LObjetoCreditoDetalhe.fltValCan  := 0;
    LObjetoCreditoDetalhe.strNomSol  := '';
    LObjetoCreditoDetalhe.strCodSol  := '';
    LObjetoCreditoDetalhe.strCodLan  := fGetDados(ALinha, 037, 004);
    LObjetoCreditoDetalhe.strSeqLan  := fGetDados(ALinha, 041, 002);
    LObjetoCreditoDetalhe.dtaDtaLan  := fGetDados(ALinha, 029, 008);
    LObjetoCreditoDetalhe.dtaDtaVen  := fGetDados(ALinha, 043, 008);
    LObjetoCreditoDetalhe.fltValPar  := fGetDados(ALinha, 061, 015, True);
    LObjetoCreditoDetalhe.fltValLiq  := fGetDados(ALinha, 108, 015, True);
    LObjetoCreditoDetalhe.fltTarFix  := fGetDados(ALinha, 076, 006, True);
    LObjetoCreditoDetalhe.fltTarAdm  := fGetDados(ALinha, 082, 006, True);
    LObjetoCreditoDetalhe.fltTarCom  := fGetDados(ALinha, 098, 010, True);
    LObjetoCreditoDetalhe.strNomArq  := strNomArq;
    LObjetoCreditoDetalhe.strDescri  := 'CREDITO\DEBITO';

    Try
      If (FUltimoIdentificadorDoArquivoLido = 'BJRVC41') And (FListaCredito.Count > 0) Then
        FListaCredito.Selecionado := FListaCredito[FListaCredito.Count - 1]
      Else
        FListaCredito.Selecionado :=
           FListaCredito.fGetRegistroCredito(FUltimoIdentificadorDoArquivoLido,
                                             LObjetoCreditoDetalhe);

      FListaCredito.Selecionado.ListaCreditoDetalhes.Add(LObjetoCreditoDetalhe);
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;

    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    If(LObjetoCreditoDetalhe.strCNPJEst <> '') And
       (VS_ListaEstabelecimentos.IndexOf(LObjetoCreditoDetalhe.strCNPJEst) < 0) Then
      VS_ListaEstabelecimentos.Add(LObjetoCreditoDetalhe.strCNPJEst);
  end;
end;

procedure TBanrisulPgto.pAdicionaLinhaRegistroDePagamento(ALinha: string);
Var
  LObjetoPagamento : TBanrisulPagamento;
begin
  if fGetDados(ALinha, 001,02) = '10' then
  begin
    FDataLancamentoPagamentoHeader := fGetDados(ALinha, 096, 008);
    FStatusPagamentoHeader         := fGetDados(ALinha, 031, 002);
  end
  else
  if fGetDados(ALinha, 001,02) = '20' then
  begin
    LObjetoPagamento            := TBanrisulPagamento.create;
    LObjetoPagamento.strCNPJEst := fGetDados(ALinha, 017, 014);
    LObjetoPagamento.strCNPJCon := fGetDados(ALinha, 003, 014);
    LObjetoPagamento.strStatus  := FStatusPagamentoHeader;
    LObjetoPagamento.strBandei  := fGetDados(ALinha, 031, 003);
    LObjetoPagamento.strCodMod  := fGetDados(ALinha, 034, 005);
    LObjetoPagamento.strNomArq  := strNomArq;
    LObjetoPagamento.dtaDtaArq  := FDataDoArquivo;
    LObjetoPagamento.dtaDtaLan  := FDataLancamentoPagamentoHeader;
    LObjetoPagamento.dtaDtaRef  := fGetDados(ALinha, 055, 008);
    LObjetoPagamento.fltValLan  := fGetDados(ALinha, 040, 015, True);
    LObjetoPagamento.strTipMov  := fGetDados(ALinha, 039, 001);

    FListaPagamento.Add(LObjetoPagamento);

    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    If(LObjetoPagamento.strCNPJEst <> '') And
       (VS_ListaEstabelecimentos.IndexOf(LObjetoPagamento.strCNPJEst) < 0) Then
      VS_ListaEstabelecimentos.Add(LObjetoPagamento.strCNPJEst);
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

    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    If(FRegistroAntecipacao.strCNPJEst <> '') And
       (VS_ListaEstabelecimentos.IndexOf(FRegistroAntecipacao.strCNPJEst) < 0) Then
      VS_ListaEstabelecimentos.Add(FRegistroAntecipacao.strCNPJEst);

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
    FRegistroAntecipacao.strNumNSU  := TBanrisulFuncoes.fStrZero(fGetDados(ALinha, 025, 008),14);
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
  LObjetoVenda : TBanrisulVendas;
begin
  If fGetDados(ALinha, 001,02) = '10' Then
  Begin
    LObjetoVenda := TBanrisulVendas.Create;
    LObjetoVenda.strCodEst  := fGetDados(ALinha, 028, 015);
    LObjetoVenda.strCNPJEst := fGetDados(ALinha, 003, 014);
    LObjetoVenda.strRedeID  := fGetDados(ALinha, 017, 011);
    LObjetoVenda.strID_Arq  := FUltimoIdentificadorDoArquivoLido;
    LObjetoVenda.strNumNsu  := TBanrisulFuncoes.fStrZero(fGetDados(ALinha, 059, 008),14);
    LObjetoVenda.strNumPar  := fGetDados(ALinha, 067, 002);
    LObjetoVenda.strTotPar  := fGetDados(ALinha, 069, 002);
    LObjetoVenda.dtaDtaVen  := fGetDados(ALinha, 051, 008);
    LObjetoVenda.dtaDtaOri  := fGetDados(ALinha, 077, 008);
    LObjetoVenda.strNSUOri  := TBanrisulFuncoes.fStrZero(fGetDados(ALinha, 089, 006),14);
    LObjetoVenda.strCodMsg  := fGetDados(ALinha, 095, 004);
    LObjetoVenda.strCodPrc  := fGetDados(ALinha, 099, 006);
    LObjetoVenda.strServic  := fGetDados(ALinha, 105, 004);
    LObjetoVenda.strSituac  := fGetDados(ALinha, 109, 002);
    LObjetoVenda.fltValVen  := fGetDados(ALinha, 111, 015, True);
    LObjetoVenda.fltValPar  := fGetDados(ALinha, 126, 015, True);
    LObjetoVenda.dtaDtaCre  := fGetDados(ALinha, 141, 008);
    LObjetoVenda.fltPerTax  := fGetDados(ALinha, 155, 006, True);
    LObjetoVenda.fltTarifa  := fGetDados(ALinha, 161, 010, True);
    LObjetoVenda.fltLiqPar  := fGetDados(ALinha, 177, 015, True);
    LObjetoVenda.strPrazo_  := fGetDados(ALinha, 192, 003);
    LObjetoVenda.strPraUlt  := fGetDados(ALinha, 195, 003);
    LObjetoVenda.dtaDtaCnf  := fGetDados(ALinha, 198, 008);
    LObjetoVenda.strID_ped  := fGetDados(ALinha, 212, 040);
    LObjetoVenda.strCPFCli  := fGetDados(ALinha, 252, 014);

    LObjetoVenda.strBandei  := TBanrisulFuncoes.IIF(FUltimoIdentificadorDoArquivoLido = 'BJRVCM8',
                                   fGetDados(ALinha, 291, 003),
                                   '001');
    LObjetoVenda.strIniCar  := TBanrisulFuncoes.IIF(FUltimoIdentificadorDoArquivoLido = 'BJRVCM8',
                                   fGetDados(ALinha, 294, 006),
                                   fGetDados(ALinha, 291, 006));
    LObjetoVenda.strFinCar  := TBanrisulFuncoes.IIF(FUltimoIdentificadorDoArquivoLido = 'BJRVCM8',
                                   fGetDados(ALinha, 300, 004),
                                   fGetDados(ALinha, 297, 004));

    LObjetoVenda.dtaDtaArq  := FDataDoArquivo;
    LObjetoVenda.strNomArq  := strNomArq;

    FListaVendas.Add(LObjetoVenda);

    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    If(LObjetoVenda.strCNPJEst  <> '') And
       (VS_ListaEstabelecimentos.IndexOf(LObjetoVenda.strCNPJEst) < 0) Then
      VS_ListaEstabelecimentos.Add(LObjetoVenda.strCNPJEst);

  End;
end;

procedure TBanrisulPgto.pAdicionaLinhaRegistroDeVendaTodasBandeiras(ALinha: string);
Var
  LObjetoVenda : TBanrisulVendas;
  LCartao      : String;
  LAsterisco   : Integer;
begin
  If fGetDados(ALinha, 001,02) <> '10' Then
    Exit;

  LObjetoVenda := TBanrisulVendas.Create;
  LObjetoVenda.strCodEst  := fGetDados(ALinha, 028, 015);
  LObjetoVenda.strCNPJEst := fGetDados(ALinha, 003, 014);
  LObjetoVenda.strRedeID  := fGetDados(ALinha, 017, 011);
  LObjetoVenda.strID_Arq  := FUltimoIdentificadorDoArquivoLido;
  LObjetoVenda.strNumNsu  := TBanrisulFuncoes.fStrZero(fGetDados(ALinha, 065, 008),14);
  LObjetoVenda.strNumPar  := fGetDados(ALinha, 073, 002);
  LObjetoVenda.strTotPar  := fGetDados(ALinha, 075, 002);
  LObjetoVenda.dtaDtaVen  := fGetDados(ALinha, 051, 008);
  LObjetoVenda.dtaDtaOri  := fGetDados(ALinha, 077, 008);
  LObjetoVenda.strNSUOri  := TBanrisulFuncoes.fStrZero(fGetDados(ALinha, 089, 006),14);
  LObjetoVenda.strCodMsg  := fGetDados(ALinha, 095, 004);
  LObjetoVenda.strCodPrc  := fGetDados(ALinha, 099, 006);
  LObjetoVenda.strServic  := fGetDados(ALinha, 105, 004);
  LObjetoVenda.strSituac  := fGetDados(ALinha, 109, 002);
  LObjetoVenda.fltValVen  := fGetDados(ALinha, 111, 015, True);
  LObjetoVenda.fltValPar  := fGetDados(ALinha, 126, 015, True);
  LObjetoVenda.dtaDtaCre  := fGetDados(ALinha, 141, 008);
  LObjetoVenda.fltPerTax  := fGetDados(ALinha, 155, 006, True);
  LObjetoVenda.fltTarifa  := fGetDados(ALinha, 161, 010, True);
  LObjetoVenda.fltLiqPar  := fGetDados(ALinha, 177, 015, True);
  LObjetoVenda.strPrazo_  := fGetDados(ALinha, 192, 003);
  LObjetoVenda.strPraUlt  := fGetDados(ALinha, 195, 003);
  LObjetoVenda.dtaDtaCnf  := fGetDados(ALinha, 198, 008);
  LObjetoVenda.strBandei  := fGetDados(ALinha, 231, 003);
  LObjetoVenda.strID_ped  := fGetDados(ALinha, 254, 040);
  LObjetoVenda.strCPFCli  := fGetDados(ALinha, 294, 014);

  LCartao    := fGetDados(ALinha, 235, 019);
  LAsterisco := Pos('*', LCartao);
  If LAsterisco > 6 Then
    LObjetoVenda.strIniCar := Copy(LCartao, LAsterisco - 6, 6)
  Else
    LObjetoVenda.strIniCar := '';
  LObjetoVenda.strFinCar  := AnsiRightStr(LCartao, 4);

  LObjetoVenda.dtaDtaArq  := FDataDoArquivo;
  LObjetoVenda.strNomArq  := strNomArq;

  FListaVendas.Add(LObjetoVenda);

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If(LObjetoVenda.strCNPJEst  <> '') And
     (VS_ListaEstabelecimentos.IndexOf(LObjetoVenda.strCNPJEst) < 0) Then
    VS_ListaEstabelecimentos.Add(LObjetoVenda.strCNPJEst);
end;

procedure TBanrisulPgto.pGravaRegistrosDeAntecipacao(pgbProg: TcxProgressBar);
Var
  LRegistros           : TUniQuery;
  LObjetoAntecipacao : TBanrisulAntecipacao;
begin
  LRegistros := Nil;
  Try
    LRegistros := VS_FuncoesExternas.fICriaQuery;
    LRegistros.SQL.Text := TBanrisulFuncoes.RetornaSQLReplace('BAN_BSANTE',['BAN_CONCIL']);

    pgbProg.Position := 0;

    If FListaAntecipacao.Count = 0 Then
      Exit;

    pgbProg.Properties.MAX := FListaAntecipacao.Count - 1;

    For LObjetoAntecipacao in FListaAntecipacao do
    Begin
      LRegistros.Close;

      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CNPJES',LObjetoAntecipacao.strCNPJEst);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CNPJCO',LObjetoAntecipacao.strCNPJCon);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DTACON',fFormataData(LObjetoAntecipacao.dtaDtaCon ,True),ftDate);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_NUMCON',LObjetoAntecipacao.strNumCon);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_BANDEI',LObjetoAntecipacao.strBandei);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CANAL_',LObjetoAntecipacao.strCanal_);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_VALANT',LObjetoAntecipacao.fltValAnt);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_PERTAX',LObjetoAntecipacao.fltPerTax/100);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_VALTAX',LObjetoAntecipacao.fltValTax);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_VALREG',LObjetoAntecipacao.fltValReg);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_VALLIQ',LObjetoAntecipacao.fltValLiq);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DTAPAG',fFormataData(LObjetoAntecipacao.dtaDtaPag ,True),ftDate);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CODBCO',LObjetoAntecipacao.strCodBco);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CODAGE',LObjetoAntecipacao.strCodAge);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CODCTA',LObjetoAntecipacao.strCodCta);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DTAVEN',fFormataData(LObjetoAntecipacao.dtaDtaVen ,True),ftDate);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CODOPE',LObjetoAntecipacao.strCodOpe);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DTATRA',fFormataData(LObjetoAntecipacao.dtaDtaTra ,True),ftDate);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_NUMNSU',LObjetoAntecipacao.strNumNSU);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_VALBRU',LObjetoAntecipacao.fltValBru);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_NUMPAR',LObjetoAntecipacao.strNumPar);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_TOTPAR',LObjetoAntecipacao.strTotPar);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_VALTRA',LObjetoAntecipacao.fltValTra);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_VALPAR',LObjetoAntecipacao.fltValPar);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_VENPAR',fFormataData(LObjetoAntecipacao.dtaVenPar ,True),ftDate);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_NOMARQ',LObjetoAntecipacao.strNomArq);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DTAARQ',fFormataData(LObjetoAntecipacao.dtaDtaArq ,True),ftDate);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CONCIL',0);

      LRegistros.ExecSQL;
    End;

    TBanrisulFuncoes.pStepStatusGravacao(pgbProg);
  Finally
    TBanrisulFuncoes.FreeAndNilDatasets(LRegistros);
  End;
end;

procedure TBanrisulPgto.pGravaRegistrosDeCredito(pgbProg: TcxProgressBar);
Var
  LRegistros              : TUniQuery;
  LObjetoCredito        : TBanrisulCredito;
  LObjetoCreditoDetalhe : TBanrisulCreditoDetalhe;
begin
  LRegistros := Nil;
  Try
    LRegistros := VS_FuncoesExternas.fICriaQuery;
    LRegistros.SQL.Text :=  TBanrisulFuncoes.RetornaSQLReplace('BAN_BSCRED',['BAN_CONCIL']);

    pgbProg.Position := 0;

    If FListaCredito.Count = 0 Then
      Exit;

    pgbProg.Properties.Max := FListaCredito.Count - 1;

    For LObjetoCredito in FListaCredito do
    Begin
      for LObjetoCreditoDetalhe in LObjetoCredito.ListaCreditoDetalhes do
      Begin
        LRegistros.Close;

        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CODEST', LObjetoCreditoDetalhe.strCodEst);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CODRED', LObjetoCreditoDetalhe.strCodRed);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DTALAN', fFormataData(LObjetoCreditoDetalhe.dtaDtaLan),ftDate);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CODLAN', LObjetoCreditoDetalhe.strCodLan);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DTAVEN', fFormataData(LObjetoCreditoDetalhe.dtaDtaVen),ftDate);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CNPJES', LObjetoCredito.strCNPJEst);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_NUMNSU', LObjetoCreditoDetalhe.strNumNsu);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_NUMCCD', '');
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_NUMPAR', LObjetoCreditoDetalhe.strNumPar);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_VALPAR', LObjetoCreditoDetalhe.fltValPar);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_VALLIQ', LObjetoCreditoDetalhe.fltValLiq);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_TARFIX', LObjetoCreditoDetalhe.fltTarFix);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_TARADM', LObjetoCreditoDetalhe.fltTarAdm/100);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_TARCOM', LObjetoCreditoDetalhe.fltTarCom);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CODAGE', LObjetoCredito.strCodAge);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CODCTA', LObjetoCredito.strCodCta);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DTAARQ', fFormataData(LObjetoCredito.dtaDtaArq),ftDate);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_NOMARQ', LObjetoCredito.strNomArq);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CONCIL', '0');
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_ID_ARQ', LObjetoCredito.strID_Arq);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_TIPREG', LObjetoCreditoDetalhe.strTipReg);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_VALCAN', LObjetoCreditoDetalhe.fltValCan);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_NOMSOL', LObjetoCreditoDetalhe.strNomSol);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CODSOL', LObjetoCreditoDetalhe.strCodSol);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_REDCAN', LObjetoCreditoDetalhe.strCodRed);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CODMSG', LObjetoCredito.strCodMsg);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_SEQLAN', LObjetoCreditoDetalhe.strSeqLan);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_IMPTOT', 0);
        TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DESCRI', LObjetoCreditoDetalhe.strDescri);

        LRegistros.ExecSQL;
      End;

      TBanrisulFuncoes.pStepStatusGravacao(pgbProg);
    End;
  Finally
    TBanrisulFuncoes.FreeAndNilDatasets(LRegistros);
  End;
end;

procedure TBanrisulPgto.pGravaRegistrosDePagamento(pgbProg: TcxProgressBar);
Var
  LRegistros         : TUniQuery;
  LObjetoPagamento : TBanrisulPagamento;
begin
  LRegistros := Nil;
  Try
    LRegistros := VS_FuncoesExternas.fICriaQuery;
    LRegistros.SQL.Text :=  TBanrisulFuncoes.RetornaSQLReplace('BAN_BSPGTO',['BAN_CONCIL']);

    pgbProg.Position := 0;

    If FListaPagamento.Count = 0 Then
      Exit;

    pgbProg.Properties.Max := FListaPagamento.Count - 1;

    For LObjetoPagamento in FListaPagamento do
    Begin
      LRegistros.Close;
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CNPJES', LObjetoPagamento.strCNPJEst);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CNPJCO', LObjetoPagamento.strCNPJCon);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_STATUS', LObjetoPagamento.strStatus);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_BANDEI', LObjetoPagamento.strBandei);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CODMOD', LObjetoPagamento.strCodMod);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_TIPMOV', LObjetoPagamento.strTipMov);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DTALAN', fFormataData(LObjetoPagamento.dtaDtaLan),ftDate);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DTAREF', fFormataData(LObjetoPagamento.dtaDtaRef),ftDate);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_VALLAN', LObjetoPagamento.fltValLan);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DTAARQ', fFormataData(LObjetoPagamento.dtaDtaArq),ftDate);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_NOMARQ', LObjetoPagamento.strNomArq);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CONCIL', 0);

      LRegistros.ExecSQL;

      TBanrisulFuncoes.pStepStatusGravacao(pgbProg);
    End;
  Finally
    TBanrisulFuncoes.FreeAndNilDatasets(LRegistros);
  End;
end;

procedure TBanrisulPgto.pGravaRegistrosDeVenda(pgbProg: TcxProgressBar);
Var
  LRegistros     : TUniQuery;
  LObjetoVenda : TBanrisulVendas;
begin
  LRegistros := Nil;
  Try
    LRegistros := VS_FuncoesExternas.fICriaQuery;
    LRegistros.SQL.Text :=  TBanrisulFuncoes.RetornaSQLReplace('BAN_BSVEND',['BAN_CONCIL']);

    pgbProg.Position := 0;

    If FListaVendas.Count = 0 Then
      Exit;

    pgbProg.Properties.Max := FListaVendas.Count - 1;

    For LObjetoVenda in FListaVendas do
    Begin
      LRegistros.Close;

      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CODEST', LObjetoVenda.strCodEst);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CNPJES', LObjetoVenda.strCNPJEst);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_REDEID', LObjetoVenda.strRedeID);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_ID_ARQ', LObjetoVenda.strID_Arq);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_NUMNSU', LObjetoVenda.strNumNsu);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_NUMPAR', LObjetoVenda.strNumPar);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_TOTPAR', LObjetoVenda.strTotPar);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DTAVEN', fFormataData(LObjetoVenda.dtaDtaVen),ftDate);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DTAORI', fFormataData(LObjetoVenda.dtaDtaOri),ftDate);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_NSUORI', LObjetoVenda.strNSUOri);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CODMSG', LObjetoVenda.strCodMsg);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CODPRC', LObjetoVenda.strCodPrc);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_SERVIC', LObjetoVenda.strServic);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_SITUAC', LObjetoVenda.strSituac);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_VALVEN', LObjetoVenda.fltValVen);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_VALPAR', LObjetoVenda.fltValPar);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DTACRE', fFormataData(LObjetoVenda.dtaDtaCre),ftDate);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_PERTAX', LObjetoVenda.fltPerTax/100);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_TARIFA', LObjetoVenda.fltTarifa);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_LIQPAR', LObjetoVenda.fltLiqPar);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_PRAZO_', LObjetoVenda.strPrazo_);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_PRAULT', LObjetoVenda.strPraUlt);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DTACNF', fFormataData(LObjetoVenda.dtaDtaCnf),ftDate);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_ID_PED', LObjetoVenda.strID_ped);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_CPFCLI', LObjetoVenda.strCPFCli);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_BANDEI', LObjetoVenda.strBandei);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_INICAR', LObjetoVenda.strIniCar);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_FINCAR', LObjetoVenda.strFinCar);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_DTAARQ', fFormataData(LObjetoVenda.dtaDtaArq),ftDate);
      TBanrisulFuncoes.CarregaParametroDataset(LRegistros,'BAN_NOMARQ', LObjetoVenda.strNomArq);

      LRegistros.ExecSQL;

      TBanrisulFuncoes.pStepStatusGravacao(pgbProg);
    End;
  Finally
    TBanrisulFuncoes.FreeAndNilDatasets(LRegistros);
  End;
end;

procedure TBanrisulPgto.pGravarRegistros(pgbProg: TcxProgressBar);
begin
  pGravaRegistrosDeVenda(pgbProg);
  pGravaRegistrosDeCredito(pgbProg);
  pGravaRegistrosDeAntecipacao(pgbProg);
  pGravaRegistrosDePagamento(pgbProg);

  TBanrisulFuncoes.GravarEstabelecimentos;

end;

end.
