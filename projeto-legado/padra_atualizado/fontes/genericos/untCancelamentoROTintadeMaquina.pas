{***********************************************************************************}
{* CLASSE PARA CANCELAMENTO DE ORDEM DE PRODUÇÃO DE TINTA DE MAQUINA(ESPECIE = RO) *}
{********************************************************************************AC*}

unit untCancelamentoROTintadeMaquina;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, Controls,
     untCancelamentoROTintadeMaquinaSQL;

type
  TCancelamentoROTintadeMaquina = class(TCancelamentoROTintadeMaquinaSQL)
  private
    strCodEmp: String;
    strNumDoc: String;
    strEspDoc: String;
    strCodCli: String;
    strCliFil: String;

    procedure pProcessaDocumentoML(qryGen: TUniQuery);
    procedure pVerificaIntegridadeEAtualizaEstoqueML_MOVDET(qryGen: TUniQuery);
    procedure pVerificaIntegridadeML_MOVGER(qryGen: TUniQuery);
    procedure pDeletaML(qryGen: TUniQuery);
    procedure pDesmarcaTindetSeBaixado(qryRO: TUniQuery);
    procedure pVerificaIntegridadeRO_MOVDET(qryGen: TUniQuery);
    procedure pDeletaRO(qryGen: TUniQuery);
    procedure pProcessaDocumentoRO(qryGen: TUniQuery);
    procedure pVerificaIntegridadeRO_MOVGER(qryGen: TUniQuery);
    procedure pSelecionaDocumentoRO(Var qryGen: TUniQuery);
    procedure pSelecionaClienteFilial(qryGen: TUniQuery);
    procedure pSelecionaDocumentoTE(qryGen: TUniQuery);
    procedure pExibirMensagemTE(qryGen: TUniQuery);

    function fDesmarcarBaixaFormulacao(qryGen: TUniQuery): Boolean;
    function fAtualizarECancelarMLS(qryGen: TUniQuery): Boolean;
    function fCancelarRO(qryGen: TUniQuery): Boolean;
    function fDocumentosCancelados(qryGen: TUniQuery): Boolean;
    function fAtualizarProdutoAcabado(qryGen: TUniQuery): Boolean;
    function fAtualizarProdutoNormal(qryGen: TUniQuery): Boolean;

  protected

  public
    function fDocumentoROExiste: Boolean;
    function fCancelouDocumentoRO: Boolean;
    function fDocumentoTEExiste: Boolean;
    function fClientFilialExiste: Boolean;
    function fDocumentoROProAcaPreenchido: Boolean;

    Constructor Create(Owner: TComponent; strCodEmp, strNumDoc, strCodCli: String); Reintroduce;

    Destructor Destroy; Reintroduce;
  end;

implementation

uses untFuncoesSimples, untCadIte, untProdAcabado;

{ TCancelamentoROTintadeMaquina }

constructor TCancelamentoROTintadeMaquina.Create(Owner: TComponent; strCodEmp,
  strNumDoc, strCodCli: String);
begin
  Inherited Create(Owner);

  Self.strEspDoc := 'RO';

  Self.strCodEmp := strCodEmp;
  Self.strNumDoc := strNumDoc;
  Self.strCodCli := strCodCli;

  Self.strCliFil := '';
end;

destructor TCancelamentoROTintadeMaquina.Destroy;
begin

  inherited Destroy;
end;

function TCancelamentoROTintadeMaquina.fAtualizarECancelarMLS(
  qryGen: TUniQuery): Boolean;
var
  qryDet: TUniQuery;
begin
  Try
    qryDet := fCriaQuery;

    pRetornaSelect(qryDet,
                   fSQLDocumentoML_DET,
                   ['NUMFAT', 'TIPFAT', 'EMPFAT', 'CODACA', 'EMPACA'],
                   [qryGen.FieldByName('DET_NUMFAT').AsString,
                    qryGen.FieldByName('DET_TIPFAT').AsString,
                    qryGen.FieldByName('DET_EMPFAT').AsString,
                    qryGen.FieldByName('DET_CODACA').AsString,
                    qryGen.FieldByName('DET_EMPACA').AsString]);

    pProcessaDocumentoML(qryDet);

    Result := True;
  Finally
    If Assigned(qryDet) Then FreeAndNil(qryDet);
  End;
end;

function TCancelamentoROTintadeMaquina.fAtualizarProdutoAcabado(
  qryGen: TUniQuery): Boolean;
begin
  Result := TProdAcabado.fAtualizaEstoque(qryGen.FieldByName('DET_CODACA').AsString,
                                          qryGen.FieldByName('DET_EMPACA').AsString,
                                          qryGen.FieldByName('DET_CODEMP').AsString,
                                          'S',
                                          qryGen.FieldByName('DET_QTDITE').AsFloat);
end;

function TCancelamentoROTintadeMaquina.fAtualizarProdutoNormal(
  qryGen: TUniQuery): Boolean;
begin
  Result := fAtualizaEstoqueCadIte(qryGen.FieldByName('DET_CODITE').AsString,
                                   'E',
                                   qryGen.FieldByName('DET_QTDITE').AsFloat,
                                   0.0,
                                   '');
end;

function TCancelamentoROTintadeMaquina.fCancelarRO(qryGen: TUniQuery): Boolean;
begin
  pProcessaDocumentoRO(qryGen);
  Result := True;
end;

// tem que desmarcar a baixa
// tem que voltar o saldo e cancelar os mls
// tem que cancelar o documento RO
function TCancelamentoROTintadeMaquina.fCancelouDocumentoRO: Boolean;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;

    pSelecionaDocumentoRO(qryGen);

    Result := fDocumentosCancelados(qryGen);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TCancelamentoROTintadeMaquina.fClientFilialExiste: Boolean;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;

    pSelecionaDocumentoRO(qryGen);

    pSelecionaClienteFilial(qryGen);

    Result := True;

    If fEmptyStr(strCliFil) Then
    Begin
      fMensagem('ATENÇÃO!', 'A empresa solicitante [' +
        qryGen.FieldByName('DET_EMPFAT').AsString +
        '] não possui "Cliente Filial" cadastrado !', ['&OK']);
      Result := False;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TCancelamentoROTintadeMaquina.pSelecionaClienteFilial(
  qryGen: TUniQuery);
begin
  Self.strCliFil := fCampoTabela('EMP_CLIFIL','CADEMP',
                                 ['EMP_CODEMP'],
                                 [qryGen.FieldByName('DET_EMPFAT').AsString]);
end;

function TCancelamentoROTintadeMaquina.fDesmarcarBaixaFormulacao(
  qryGen: TUniQuery): Boolean;

begin
  //desmarcar a baixa da formulacao TINDOR e TINDET
  If Pos(qryGen.FieldByName('DET_TIPFAT').AsString, 'PD_OR_') > 0 Then
  Begin
    pDesmarcaTindetSeBaixado(qryGen);

    pExecutaSQL(fSQLUpdateBAIXAD_FDO(qryGen.FieldByName('DET_TIPFAT').AsString),
                ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODACA', 'EMPACA'],
                [qryGen.FieldByName('DET_NUMFAT').AsString,
                 qryGen.FieldByName('DET_TIPFAT').AsString,
                 qryGen.FieldByName('DET_EMPFAT').AsString,
                 qryGen.FieldByName('DET_CODACA').AsString,
                 qryGen.FieldByName('DET_EMPACA').AsString]);

  End
  Else
  Begin
    //desmarcar a baixa da formulacao TINDET
    pExecutaSQL(fSQLUpdateBAIXAD_DET(qryGen.FieldByName('DET_TIPFAT').AsString),
                ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODACA', 'EMPACA'],
                [qryGen.FieldByName('DET_NUMFAT').AsString,
                 qryGen.FieldByName('DET_TIPFAT').AsString,
                 qryGen.FieldByName('DET_EMPFAT').AsString,
                 qryGen.FieldByName('DET_CODACA').AsString,
                 qryGen.FieldByName('DET_EMPACA').AsString]);
  End;

  Result := True;
end;

function TCancelamentoROTintadeMaquina.fDocumentoROExiste: Boolean;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;

    pRetornaSelect(qryGen,
                   fSQLDocumentoROExiste,
                   ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODCLI'],
                   [strNumDoc, strEspDoc, strCodEmp, strCodCli]);

    Result := Not qryGen.IsEmpty;

    If Not Result Then
      fMensagem('ATENÇÃO!', 'Esse documento (RO) não existe!', ['&Ok']);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TCancelamentoROTintadeMaquina.fDocumentoROProAcaPreenchido: Boolean;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;

    pSelecionaDocumentoRO(qryGen);

    Result := True;

    //Trava por conta dos documentos anteriores a esta alteracao;
    //Os documentos RO anteriores nao gravavam codaca e nem empaca;
    If fEmptyStr(qryGen.FieldByName('DET_CODACA').AsString) And
       fEmptyStr(qryGen.FieldByName('DET_EMPACA').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse documento (RO) não está com o código do produto acabado ' + #13#10 +
                            'e a empresa do produto acabado preenchidos.' + #13#10 +
                            'Não será possível o cancelamento do documento!', ['&Ok']);
      Result := False;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TCancelamentoROTintadeMaquina.fDocumentosCancelados(
  qryGen: TUniQuery): Boolean;
begin
  Result := fDesmarcarBaixaFormulacao(qryGen);

  If Result Then
    Result := fAtualizarProdutoNormal(qryGen);
  If Result Then
    Result := fAtualizarProdutoAcabado(qryGen);
  If Result Then
    Result := fAtualizarECancelarMLS(qryGen);
  If Result Then
    Result := fCancelarRO(qryGen);
end;

function TCancelamentoROTintadeMaquina.fDocumentoTEExiste: Boolean;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;

    pSelecionaDocumentoRO(qryGen);

    pSelecionaDocumentoTE(qryGen);

    //Se vazio é pq nao foi gerada TE no processo de producao fora de loja;
    Result := qryGen.IsEmpty;

    If Not Result Then
      pExibirMensagemTE(qryGen);
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TCancelamentoROTintadeMaquina.pDeletaML(qryGen: TUniQuery);
begin
  pExecutaSQL(fSQLDeletaML_GER(qryGen.FieldByName('DET_TIPFAT').AsString),
              ['NUMDOC', 'ESPDOC', 'CODEMP'],
              [qryGen.FieldByName('DET_NUMDOC').AsString,
               qryGen.FieldByName('DET_ESPDOC').AsString,
               qryGen.FieldByName('DET_CODEMP').AsString]);

  pExecutaSQL(fSQLDeletaML_DET(qryGen.FieldByName('DET_TIPFAT').AsString),
              ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODACA', 'EMPACA'],
              [qryGen.FieldByName('DET_NUMDOC').AsString,
               qryGen.FieldByName('DET_ESPDOC').AsString,
               qryGen.FieldByName('DET_CODEMP').AsString,
               qryGen.FieldByName('DET_CODACA').AsString,
               qryGen.FieldByName('DET_EMPACA').AsString]);
end;

procedure TCancelamentoROTintadeMaquina.pDeletaRO(qryGen: TUniQuery);
begin
  pExecutaSQL(fSQLDeletaRO_GER,
              ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODCLI'],
              [qryGen.FieldByName('DET_NUMDOC').AsString,
               qryGen.FieldByName('DET_ESPDOC').AsString,
               qryGen.FieldByName('DET_CODEMP').AsString,
               qryGen.FieldByName('DET_CODCLI').AsString]);

  pExecutaSQL(fSQLDeletaRO_DET,
              ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODACA', 'EMPACA'],
              [qryGen.FieldByName('DET_NUMDOC').AsString,
               qryGen.FieldByName('DET_ESPDOC').AsString,
               qryGen.FieldByName('DET_CODEMP').AsString,
               qryGen.FieldByName('DET_CODACA').AsString,
               qryGen.FieldByName('DET_EMPACA').AsString]);
end;

procedure TCancelamentoROTintadeMaquina.pDesmarcaTindetSeBaixado(
  qryRO: TUniQuery);
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;

    pRetornaSelect(qryGen,
                   fSQLDocumentoFATDOR,
                   ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODACA', 'EMPACA'],
                   [qryRO.FieldByName('DET_NUMFAT').AsString,
                    qryRO.FieldByName('DET_TIPFAT').AsString,
                    qryRO.FieldByName('DET_EMPFAT').AsString,
                    qryRO.FieldByName('DET_CODACA').AsString,
                    qryRO.FieldByName('DET_EMPACA').AsString]);

    pRetornaSelect(qryGen,
                   fSQLDocumentoTINDET_BAIXAD(qryGen.FieldByName('FDO_TIPFAT').AsString),
                   ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODACA', 'EMPACA'],
                   [qryGen.FieldByName('FDO_NUMFAT').AsString,
                    qryGen.FieldByName('FDO_TIPFAT').AsString,
                    qryGen.FieldByName('FDO_EMPFAT').AsString,
                    qryGen.FieldByName('FDO_CODACA').AsString,
                    qryGen.FieldByName('FDO_EMPACA').AsString]);

    //Existe tindet baixado
    If Not qryGen.IsEmpty Then
    Begin
      //desmarcar a baixa da formulacao TINDET
      pExecutaSQL(fSQLUpdateBAIXAD_DET(qryGen.FieldByName('DET_ESPDOC').AsString),
                  ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODACA', 'EMPACA'],
                  [qryGen.FieldByName('DET_NUMDOC').AsString,
                   qryGen.FieldByName('DET_ESPDOC').AsString,
                   qryGen.FieldByName('DET_CODEMP').AsString,
                   qryGen.FieldByName('DET_CODACA').AsString,
                   qryGen.FieldByName('DET_EMPACA').AsString]);
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TCancelamentoROTintadeMaquina.pExibirMensagemTE(qryGen: TUniQuery);
begin
  //PCG_BAIXAD = 0 (EXISTE TE E NAO FOI FEITO ENTRADA DO PRODUTO ACABADO PELA SOLICITANTE)
  If qryGen.FieldByName('PCG_BAIXAD').AsInteger = 0 Then
    fMensagem('ATENÇÃO!', 'Foi emitido um documento de Transferência de Estoque TE [' + qryGen.FieldByName('GER_NUMDOC').AsString + '] ' +
                          'para a empresa ' + qryGen.FieldByName('DET_EMPACA').AsString + '.' + #13#10 +
                          'Para cancelar o documento RO, a documento TE precisa ser cancelado.' , ['&Ok'])
  Else
    //PCG_BAIXAD = 1 (EXISTE TE E FOI FEITA A ENTRADA PELA LOJA SOLICITANTE)
    fMensagem('ATENÇÃO!', 'O documento de transferência de estoque TE [' + qryGen.FieldByName('GER_NUMDOC').AsString + '] ' +
                          'já foi baixado pela empresa solicitante, ' + #13#10 +
                          'ocasionando entrada do produto acabado na empresa solicitante. ' + #13#10 +
                          'Para devolução da RO, será necessário o cancelamento ' +
                          'da nota fiscal de entreda do produto acabado pela empresa solicitante e ' + #13#10 +
                          'o cancelamento do documento de transferência TE pela empresa de produção', ['&Ok']);
end;

procedure TCancelamentoROTintadeMaquina.pProcessaDocumentoML(qryGen: TUniQuery);
begin
  pVerificaIntegridadeEAtualizaEstoqueML_MOVDET(qryGen);
  pVerificaIntegridadeML_MOVGER(qryGen);

  pDeletaML(qryGen);
end;

procedure TCancelamentoROTintadeMaquina.pProcessaDocumentoRO(qryGen: TUniQuery);
begin
  pVerificaIntegridadeRO_MOVDET(qryGen);
  pVerificaIntegridadeRO_MOVGER(qryGen);

  pDeletaRO(qryGen);
end;

procedure TCancelamentoROTintadeMaquina.pSelecionaDocumentoRO(
  Var qryGen: TUniQuery);
begin
  pRetornaSelect(qryGen,
                 fSQLDocumentoRO,
                 ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODCLI'],
                 [strNumDoc, strEspDoc, strCodEmp, strCodCli]);
end;

procedure TCancelamentoROTintadeMaquina.pSelecionaDocumentoTE(
  qryGen: TUniQuery);
begin
  pRetornaSelect(qryGen,
                 fSQLDocumentoTE,
                 ['CODCLI', 'CODACA', 'EMPACA'],
                 [strCliFil,
                  qryGen.FieldByName('DET_CODACA').AsString,
                  qryGen.FieldByName('DET_EMPACA').AsString]);
end;

procedure TCancelamentoROTintadeMaquina.pVerificaIntegridadeEAtualizaEstoqueML_MOVDET(
  qryGen: TUniQuery);
var
  strTabela: String;
begin
  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    fAtualizaEstoqueML(qryGen.FieldByName('DET_CODITE').AsString,
                      -qryGen.FieldByName('DET_QTDITE').AsFloat,
                       qryGen.FieldByName('DET_NUMLOT').AsString);

    strTabela := 'MOVDET';

    {*******************************************}
    {* GRAVA NOS ARQUIVOS DELETADOS            *}
    {*******************************************}
    fVerificaIntegridade(Self.Name, strTabela, qryGen, True, False);

    qryGen.Next;
  End;
end;

procedure TCancelamentoROTintadeMaquina.pVerificaIntegridadeML_MOVGER(
  qryGen: TUniQuery);
var
  qryGer: TUniQuery;
  strTabela: String;
begin
  Try
    qryGer := fCriaQuery;

    pRetornaSelect(qryGer,
                   fSQLDocumentoML_GER(qryGen.FieldByName('DET_TIPFAT').AsString),
                   ['NUMDOC', 'ESPDOC', 'CODEMP'],
                   [qryGen.FieldByName('DET_NUMDOC').AsString,
                    qryGen.FieldByName('DET_ESPDOC').AsString,
                    qryGen.FieldByName('DET_CODEMP').AsString]);

    strTabela := 'MOVGER';

    {*******************************************}
    {* GRAVA NOS ARQUIVOS DELETADOS            *}
    {*******************************************}
    fVerificaIntegridade(Self.Name, strTabela, qryGer, True, False);
  Finally
    If Assigned(qryGer) Then FreeAndNil(qryGer);
  End;
end;

procedure TCancelamentoROTintadeMaquina.pVerificaIntegridadeRO_MOVDET(
  qryGen: TUniQuery);
var
  qryDet: TUniQuery;
  strTabela: String;
begin
  Try
    qryDet := fCriaQuery;

    pRetornaSelect(qryDet,
                   fSQLDocumentoRO_DET,
                   ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODCLI'],
                   [qryGen.FieldByName('DET_NUMDOC').AsString,
                    qryGen.FieldByName('DET_ESPDOC').AsString,
                    qryGen.FieldByName('DET_CODEMP').AsString,
                    qryGen.FieldByName('DET_CODCLI').AsString]);

    strTabela := 'MOVDET';

    {*******************************************}
    {* GRAVA NOS ARQUIVOS DELETADOS            *}
    {*******************************************}
    fVerificaIntegridade(Self.Name, strTabela, qryDet, True, False);
  Finally
    If Assigned(qryDet) Then FreeAndNil(qryDet);
  End;
end;

procedure TCancelamentoROTintadeMaquina.pVerificaIntegridadeRO_MOVGER(
  qryGen: TUniQuery);
var
  qryGer: TUniQuery;
  strTabela: String;
begin
  Try
    qryGer := fCriaQuery;

    pRetornaSelect(qryGer,
                   fSQLDocumentoRO_GER,
                   ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODCLI'],
                   [qryGen.FieldByName('DET_NUMDOC').AsString,
                    qryGen.FieldByName('DET_ESPDOC').AsString,
                    qryGen.FieldByName('DET_CODEMP').AsString,
                    qryGen.FieldByName('DET_CODCLI').AsString]);

    strTabela := 'MOVGER';

    {*******************************************}
    {* GRAVA NOS ARQUIVOS DELETADOS            *}
    {*******************************************}
    fVerificaIntegridade(Self.Name, strTabela, qryGer, True, False);
  Finally
    If Assigned(qryGer) Then FreeAndNil(qryGer);
  End;
end;

end.
