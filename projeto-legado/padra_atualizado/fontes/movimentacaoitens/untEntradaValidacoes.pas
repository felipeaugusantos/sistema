unit untEntradaValidacoes;

interface

uses System.DateUtils, System.SysUtils, untLiberacao, untFuncoesSimples, untFuncoes, StrUtils, Classes;

type
  TEntradaValidacoes = class
  private

  public
    class function fDataDeEntradaDeMesesAnteriores(strDtaEnt: String): Boolean;
    class function fMesDaDataDeEntradaMenorQueDataAtual(strDtaEnt: String): Boolean;
    class function fLiberouDataDeEntradaDeMesesAnteriores(const strNumDoc, strCodFor, strNomFor, strDtaEnt, strDtaDoc, strTotGer: String): Boolean;
    class function fLiberouDataDocumentoMaiorQueDataEntrada(const strDtaEnt, strDtaDoc: String): Boolean;
    class function fLiberouItensInativos: Boolean;
  end;

implementation

{ TEntradaValidacoes }

class function TEntradaValidacoes.fDataDeEntradaDeMesesAnteriores(
  strDtaEnt: String): Boolean;
begin
  Result := False;

  If Not fCfgSis('SLDRMA', varBoolean) Then
    Exit;

  If Not fMesDaDataDeEntradaMenorQueDataAtual(strDtaEnt) Then
    Exit;

  Result := True;
end;

class function TEntradaValidacoes.fLiberouDataDeEntradaDeMesesAnteriores(
  const strNumDoc, strCodFor, strNomFor, strDtaEnt, strDtaDoc,
  strTotGer: String): Boolean;
var
  objLiberacao : TLiberacao;
begin
  Try
    objLiberacao := TLiberacao.Create;
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(113);
    objLiberacao.objMsgLibera.pAddTexto('ENTRADA DE MERCADORIAS COM DATA DE ENTRADA EM MÊS ANTERIOR');
    objLiberacao.objMsgLibera.pAddSeparador(113);
    objLiberacao.objMsgLibera.pAddTextoCaption('Documento'    , strNumDoc                           , 23);
    objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor'   , strCodFor + ' - ' + strNomFor       , 23);
    objLiberacao.objMsgLibera.pAddTextoCaption('Dt.Documento' , strDtaDoc                           , 23);
    objLiberacao.objMsgLibera.pAddTextoCaption('Dt.Entrada'   , strDtaEnt                           , 23);
    objLiberacao.objMsgLibera.pAddTextoCaption('Vr.Documento' , strTotGer                           , 23);
    objLiberacao.objMsgLibera.pAddSeparador(113);
    objLiberacao.objMsgLibera.pAddTexto('Liberar esta solicitação pode causar divergência de estoque no inventário. Verifique com departamento fiscal.');
    objLiberacao.objMsgLibera.pAddSeparador(113);

    objLiberacao.strDirAce := 'LIBDTAENTMESANT';
    objLiberacao.strMsgSen := 'Liberar esta solicitação pode causar divergência de estoque no inventário. Verifique com departamento fiscal.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

class function TEntradaValidacoes.fLiberouDataDocumentoMaiorQueDataEntrada(const strDtaEnt, strDtaDoc: String): Boolean;
var
  objLiberacao : TLiberacao;
begin
  Try
    objLiberacao := TLiberacao.Create;
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(113);
    objLiberacao.objMsgLibera.pAddTexto('Entrada de mercadorias com data de entrada menor que data do documento.');

    objLiberacao.objMsgLibera.pAddTextoCaption('Dt.Entrada'   , strDtaEnt                           , 23);
    objLiberacao.objMsgLibera.pAddTextoCaption('Dt.Documento' , strDtaDoc                           , 23);
    objLiberacao.objMsgLibera.pAddTextoCaption('Operador Logado' , strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado)            , 23);
    objLiberacao.objMsgLibera.pAddSeparador(113);

    objLiberacao.strDirAce := 'LIBDTAENTMENORDTADOC';
    objLiberacao.strMsgSen := 'Entrada de mercadorias com data de entrada menor que data do documento.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

class function TEntradaValidacoes.fLiberouItensInativos: Boolean;
var
  objLiberacao : TLiberacao;
  strDesIte: String;
  listItensInativos: TStrings;
begin
  Try
    listItensInativos :=  TStringList.Create;
    fItemAtivoCompra(strDesIte, listItensInativos);
    objLiberacao := TLiberacao.Create;
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(113);
    objLiberacao.objMsgLibera.pAddTexto('Permitir pedido de compra e entrada de mercadorias com itens inativos para compra.');

    objLiberacao.objMsgLibera.pAddTextoCaption('Operador Logado' , strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado)            , 23);
    objLiberacao.objMsgLibera.pAddSeparador(113);
    objLiberacao.objMsgLibera.pAddTexto(listItensInativos.text);

    objLiberacao.strDirAce := 'ITEINA';
    objLiberacao.strMsgSen := 'Permitir pedido de compra e entrada de mercadorias com itens inativos para compra.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

class function TEntradaValidacoes.fMesDaDataDeEntradaMenorQueDataAtual(
  strDtaEnt: String): Boolean;
var
  intDiferencaAno: Integer;
begin
  Result := True;

  intDiferencaAno := YearsBetween(VS_Date, StrToDate(strDtaEnt));

  If intDiferencaAno > 0 Then
    Exit;

  If MonthOf(StrToDate(strDtaEnt)) < MonthOf(VS_Date) Then
    Exit;

  Result := False;
end;

end.
