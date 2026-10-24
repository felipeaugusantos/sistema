unit Contabilidade.Classes.ConfigLucroPresumidoIrpj;

interface

uses Contabilidade.Interfaces.ConfigLucroPresumido, Data.DB, MemDS, DBAccess,
  Uni, untFuncoesSimples, Datasnap.DBClient, UniClientDataSet,
  System.Generics.Collections ;

type
  TTipoConfigLucroPresumidoSalvaIrpj = class(TInterfacedObject, ITipoConfigLucroPresumidoSalva)
  public
    function fSalva(const ACfg: IDadosConfigLucroPresumidoCfg): Boolean;
    class function New: ITipoConfigLucroPresumidoSalva;
  end ;

  TTipoConfigLucroPresumidoCarregaIrpj = class(TInterfacedObject, ITipoConfigLucroPresumidoCarrega)
  private
    FstrParame: String ;
    procedure pCarregaBd(const AstrCodEmp: String; const AintExercicio: Integer;
                         var AqryGeral, AqryGeralLancon, AqryDetalhe: TUniQuery;
                         var AcdsDetalhePlanco: TUniClientDataSet);
    function fCarregaInterno(const AstrCodEmp: String; const AintExercicio: Integer): IDadosConfigLucroPresumidoCfg;
  public
    function fCarrega(const AstrCodEmp: String; const AintExercicio: Integer; var AstrMensagem: String): IDadosConfigLucroPresumidoCfg;
    function fFiltroParame(const AstrParame: String): ITipoConfigLucroPresumidoCarrega ;
    class function New: ITipoConfigLucroPresumidoCarrega ;
    constructor Create;
  end ;

  TTipoConfigLucroPresumidoDeleteIrpj = class(TInterfacedObject, ITipoConfigLucroPresumidoDelete)
  public
    function fDelete(const AstrCodigo: String): Boolean;
    class function New: ITipoConfigLucroPresumidoDelete;
  end ;

  TTipoConfigLucroPresumidoClonaIrpj = class(TInterfacedObject, ITipoConfigLucroPresumidoClona)
  public
    function fClona(const AstrCodEmpDest: String; const AintExercicioDest: Integer; const AItem: IDadosConfigLucroPresumidoCfg): Boolean;
  end ;

  TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCIrpj = class(TInterfacedObject, ITipoConfigLucroPresumidoCadastroTabelaApuracaoBC)
  private
    FlstLista: TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC> ;
    FstrParame: String ;
    function fSelecionaInterno(): TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC>  ;
    procedure pSelecionaBd(var AqryTabela: TUniQuery) ;
  public
    function fSeleciona(): TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC>  ;
    function fFiltroParame(const AstrParame: String): ITipoConfigLucroPresumidoCadastroTabelaApuracaoBC ;
    constructor Create;
    destructor Destroy; override ;
  end ;

implementation

uses
  Contabilidade.Classes.ConfigLucroPresumidoComum, SysUtils, math,
  Contabilidade.Funcoes.ImpostoRenda, Contabilidade.Interfaces ;

{ TTipoConfigLucroPresumidoCarregaIrpj }

constructor TTipoConfigLucroPresumidoCarregaIrpj.Create;
begin
  FstrParame := 'S' ;
end;

function TTipoConfigLucroPresumidoCarregaIrpj.fCarrega(const AstrCodEmp: String; const AintExercicio: Integer; var AstrMensagem: String): IDadosConfigLucroPresumidoCfg;
begin
  Result := Nil ;

  if not fValidaParametrizacaoEmpresaLucroPresumido(AstrCodEmp, IntToStr(AintExercicio), AstrMensagem) then
    Exit ;

  Result := fCarregaInterno(AstrCodEmp, AintExercicio) ;
end;

function TTipoConfigLucroPresumidoCarregaIrpj.fCarregaInterno(
  const AstrCodEmp: String;
  const AintExercicio: Integer): IDadosConfigLucroPresumidoCfg;
var
  LqryGeral: TUniQuery ;
  LqryDetalhe: TUniQuery ;
  LcdsDetalhePlanco: TUniClientDataSet ;
  LqryGeralLancon: TUniquery ;
begin
  LcdsDetalhePlanco := Nil ;
  LqryGeral := fCriaQuery() ;
  LqryDetalhe := fCriaQuery() ;
  LqryGeralLancon := fCriaQuery() ;
  try

    pCarregaBd(AstrCodEmp,
               AintExercicio,
               LqryGeral,
               LqryGeralLancon,
               LqryDetalhe,
               LcdsDetalhePlanco) ;

    Result := TTipoConfigLucroPresumidoPreparaCarrega.New.fPrepara(LqryGeral,
                                                                   LqryGeralLancon,
                                                                   LqryDetalhe,
                                                                   LcdsDetalhePlanco);

  finally
    FreeAndNil(LqryGeral) ;
    FreeAndNil(LqryDetalhe) ;
    FreeAndNil(LqryGeralLancon) ;
    if Assigned(LcdsDetalhePlanco) then
      FreeAndNil(LcdsDetalhePlanco) ;
  end ;

end;

function TTipoConfigLucroPresumidoCarregaIrpj.fFiltroParame(
  const AstrParame: String): ITipoConfigLucroPresumidoCarrega;
begin
  Result := Self ;
  FstrParame := AstrParame ;
end;

class function TTipoConfigLucroPresumidoCarregaIrpj.New: ITipoConfigLucroPresumidoCarrega;
begin
  Result := Self.Create ;
end;

procedure TTipoConfigLucroPresumidoCarregaIrpj.pCarregaBd(
  const AstrCodEmp: String; const AintExercicio: Integer; var AqryGeral,
  AqryGeralLancon, AqryDetalhe: TUniQuery;
  var AcdsDetalhePlanco: TUniClientDataSet);
var
  LqryDetalhePlanco: TUniQuery ;
begin

  AqryGeral.SQL.Clear ;
  AqryGeral.SQL.Add(' SELECT ') ;
  AqryGeral.SQL.Add('  AUTOINCREM, ') ;
  AqryGeral.SQL.Add('  IRM_CODIGO AS CODIGO, ') ;
  AqryGeral.SQL.Add('  IRM_CODEMP AS CODEMP, ') ;
  AqryGeral.SQL.Add('  IRM_EXERCI AS EXERCI  ') ;
  AqryGeral.SQL.Add('  FROM PRIRPG ') ;
  AqryGeral.SQL.Add('    WHERE IRM_CODEMP = :CODEMP ') ;
  AqryGeral.SQL.Add('    AND IRM_EXERCI = :EXERCI ') ;
  AqryGeral.ParamByName('CODEMP').AsString := AstrCodEmp ;
  AqryGeral.ParamByName('EXERCI').AsInteger := AintExercicio ;
  AqryGeral.Open ;

  LqryDetalhePlanco := fCriaQuery() ;
  try
    AqryGeralLancon.SQL.Clear ;
    AqryGeralLancon.SQL.Add(' SELECT ') ;
    AqryGeralLancon.SQL.Add('  AUTOINCREM, ') ;
    AqryGeralLancon.SQL.Add('  IRL_SEQGER AS SEQGER, ') ;
    AqryGeralLancon.SQL.Add('  IRL_HISPAD AS HISPAD, ') ;
    AqryGeralLancon.SQL.Add('  IRL_HISTOR AS HISTOR, ') ;
    AqryGeralLancon.SQL.Add('  IRL_CODCON AS CODCON ') ;
    AqryGeralLancon.SQL.Add(' FROM PRIRLN ') ;
    AqryGeralLancon.SQL.Add(' WHERE IRL_SEQGER = :SEQGER ; ') ;
    AqryGeralLancon.ParamByName('SEQGER').AsString := AqryGeral.FieldByName('CODIGO').AsString ;
    AqryGeralLancon.Open ;

    AqryDetalhe.SQL.Clear ;
    AqryDetalhe.SQL.Add(' SELECT ') ;
    AqryDetalhe.SQL.Add('  PRIRPD.AUTOINCREM, ') ;
    AqryDetalhe.SQL.Add('  PRIRPD.IRD_CODIGO AS CODIGO, ') ;
    AqryDetalhe.SQL.Add('  PRIRPD.IRD_SEQGER AS SEQGER, ') ;
    AqryDetalhe.SQL.Add('  PRNIRP.AUTOINCREM AS PRNIRP, ') ;
    AqryDetalhe.SQL.Add('  PRNIRP.PRN_GRUPO_ AS GRUPO_, ') ;
    AqryDetalhe.SQL.Add('  PRNIRP.PRN_CODIGO AS CODPAR, ') ;
    AqryDetalhe.SQL.Add('  PRNIRP.PRN_DESCRI AS DESCRI, ') ;
    AqryDetalhe.SQL.Add('  PRNIRP.PRN_PORCEN AS PORCEN ') ;
    AqryDetalhe.SQL.Add(' FROM PRIRPD RIGHT JOIN PRNIRP ON PRIRPD.IRD_PRNIRP=PRNIRP.AUTOINCREM AND PRIRPD.IRD_SEQGER = :SEQGER ') ;
    if FstrParame = 'S' then
      AqryDetalhe.SQL.Add(' WHERE PRNIRP.PRN_PARAME = "S" ') ;
    AqryDetalhe.SQL.Add(' ORDER BY PRNIRP.PRN_SEQUEN ') ;
    AqryDetalhe.ParamByName('SEQGER').AsString := AqryGeral.FieldByName('CODIGO').AsString ;
    AqryDetalhe.Open ;

    LqryDetalhePlanco.SQL.Clear ;
    LqryDetalhePlanco.SQL.Add(' SELECT ') ;
    LqryDetalhePlanco.SQL.Add('  PRIRCN.AUTOINCREM, ') ;
    LqryDetalhePlanco.SQL.Add('  IRC_SEQGER AS SEQGER, ') ;
    LqryDetalhePlanco.SQL.Add('  IRC_CODCON AS CODCON, ') ;
    LqryDetalhePlanco.SQL.Add('  IRC_TPLACO AS TPLACO ') ;
    LqryDetalhePlanco.SQL.Add(' FROM PRIRCN ') ;
    LqryDetalhePlanco.SQL.Add('  INNER JOIN PRIRPD ON PRIRCN.IRC_SEQGER = PRIRPD.IRD_CODIGO ') ;
    LqryDetalhePlanco.SQL.Add(' WHERE PRIRPD.IRD_SEQGER = :SEQGER ; ') ;
    LqryDetalhePlanco.ParamByName('SEQGER').AsString := AqryGeral.FieldByName('CODIGO').AsString ;
    LqryDetalhePlanco.Open ;

    AcdsDetalhePlanco := fCriaClientDatset(LqryDetalhePlanco) ;
    AcdsDetalhePlanco.IndexFieldNames := 'SEQGER' ;

  finally
    FreeAndNil(LqryDetalhePlanco) ;
  end ;

end;

{ TTipoConfigLucroPresumidoSalvaIrpj }

function TTipoConfigLucroPresumidoSalvaIrpj.fSalva(
  const ACfg: IDadosConfigLucroPresumidoCfg): Boolean;
var
  LstrAutoInc: String ;
  LstrProCod: String ;
  LqryExecGeral: TUniQuery ;
  LqryExecCfgLancon: TUniQuery ;
  LqryExecDetalhe: TUniQuery ;
  LqryExecDetalhePlanco: TUniQuery ;
  LobjItem: IDadosConfigLucroPresumidoCfgDetalhe ;
  LobjItemConta: IDadosConfigLucroPresumidoCfgDetalheContas ;
  LintTamanhoCampoDetalhe: Integer ;
  LblnEmTransacao: Boolean ;
  LintTamanhoCampo: Integer ;
begin

  LblnEmTransacao := fInTransaction ;

  if not LblnEmTransacao then
    fStartTransaction() ;

  try

    if not fEmptyStr(ACfg.Geral.Codigo) then
      TTipoConfigLucroPresumidoDeleteIrpj.New.fDelete(ACfg.Geral.Codigo) ;

    LqryExecGeral := fCriaQuery() ;
    LqryExecCfgLancon := fCriaQuery() ;
    LqryExecDetalhe := fCriaQuery() ;
    LqryExecDetalhePlanco := fCriaQuery() ;
    try
      LqryExecGeral.Close ;
      LqryExecGeral.SQL.Clear ;
      LqryExecGeral.SQL.Add('SELECT * FROM PRIRPG WHERE FALSE') ;
      LqryExecGeral.Open ;

      LstrAutoInc := fRetAutoIncrem('PRIRPG', VS_strCodEmp) ;

      LintTamanhoCampo := fRetTamCampo('PRIRPG') ;
      LintTamanhoCampo := ifThen(LintTamanhoCampo = 0, 6, LintTamanhoCampo) ;

      LstrProCod  := fAtualizaProCod('PRIRPG', 'IRM_CODIGO', '', 1, Nil,
        function (const AValue: String) : String
        begin
          Result := fPadL(AValue, LintTamanhoCampo, '0');
        end
      );

      LqryExecGeral.Append ;
      LqryExecGeral.FieldByName('AUTOINCREM').AsString := LstrAutoInc ;
      LqryExecGeral.FieldByName('IRM_CODIGO').AsString := LstrProCod ;
      LqryExecGeral.FieldByName('IRM_CODEMP').AsString := ACfg.Geral.CodEmp ;
      LqryExecGeral.FieldByName('IRM_EXERCI').AsInteger := ACfg.Geral.Exerci ;
      LqryExecGeral.Post ;

      if Assigned(ACfg.GeralLanCon) then
      begin
        LqryExecCfgLancon.Close ;
        LqryExecCfgLancon.SQL.Clear ;
        LqryExecCfgLancon.SQL.Add('SELECT * FROM PRIRLN WHERE FALSE') ;
        LqryExecCfgLancon.Open ;

        LqryExecCfgLancon.Append ;
        LqryExecCfgLancon.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PRIRLN', VS_strCodEmp) ;
        LqryExecCfgLancon.FieldByName('IRL_SEQGER').AsString := LstrProCod ;
        if ACfg.GeralLanCon.HisPad > 0 then
          LqryExecCfgLancon.FieldByName('IRL_HISPAD').AsInteger := ACfg.GeralLanCon.HisPad ;
        LqryExecCfgLancon.FieldByName('IRL_HISTOR').AsString := Acfg.GeralLanCon.Histor ;
        LqryExecCfgLancon.FieldByName('IRL_CODCON').AsString := Acfg.GeralLanCon.CodCon ;
        LqryExecCfgLancon.Post ;
      end ;

      LqryExecDetalhe.Close ;
      LqryExecDetalhe.SQL.Clear ;
      LqryExecDetalhe.SQL.Add('SELECT * FROM PRIRPD WHERE FALSE') ;
      LqryExecDetalhe.Open ;

      LqryExecDetalhePlanco.Close ;
      LqryExecDetalhePlanco.SQL.Clear ;
      LqryExecDetalhePlanco.SQL.Add('SELECT * FROM PRIRCN WHERE FALSE') ;
      LqryExecDetalhePlanco.Open ;

      LintTamanhoCampoDetalhe := fRetTamCampo('PRIRPD') ;
      LintTamanhoCampoDetalhe := ifThen(LintTamanhoCampoDetalhe = 0, 6, LintTamanhoCampoDetalhe) ;

      for LobjItem in ACfg.Detalhe do
      begin
        LqryExecDetalhe.Append ;
        LqryExecDetalhe.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PRIRPD', VS_strCodEmp) ;
        LqryExecDetalhe.FieldByName('IRD_CODIGO').AsString := fAtualizaProCod('PRIRPD', 'IRD_CODIGO', '', 1, Nil,
          function ( const AValue: String): String
          begin
            Result := fPadL(AValue, LintTamanhoCampoDetalhe, '0');
          end
        );
        LqryExecDetalhe.FieldByName('IRD_SEQGER').AsString := LstrProCod ;
        LqryExecDetalhe.FieldByName('IRD_PRNIRP').AsInteger := LobjItem.Config ;
        LqryExecDetalhe.Post ;
        for LobjItemConta in LobjItem.Contas do
        begin
          LqryExecDetalhePlanco.Append ;
          LqryExecDetalhePlanco.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PRIRCN', VS_strCodEmp) ;
          LqryExecDetalhePlanco.FieldByName('IRC_SEQGER').AsString := LqryExecDetalhe.FieldByName('IRD_CODIGO').AsString ;
          LqryExecDetalhePlanco.FieldByName('IRC_CODCON').AsString := LobjItemConta.CodCon ;
          LqryExecDetalhePlanco.FieldByName('IRC_TPLACO').AsString := LobjItemConta.TpLaCo ;
          LqryExecDetalhePlanco.Post ;
        end ;
      end ;

      if not LblnEmTransacao then
        fCommit() ;

      Result := True ;
    finally
      FreeAndNil(LqryExecGeral) ;
      FreeAndNil(LqryExecCfgLancon) ;
      FreeAndNil(LqryExecDetalhe) ;
      FreeAndNil(LqryExecDetalhePlanco) ;
    end ;

  Except
    On E: Exception Do
    Begin
      if not LblnEmTransacao then
        fRollback();
      Raise Exception.Create(E.message + 'Problemas ao salvar configurações Lucro Presumido. Tente novamente!');
    End;
  End;

end;

class function TTipoConfigLucroPresumidoSalvaIrpj.New: ITipoConfigLucroPresumidoSalva;
begin
  Result := Self.Create ;
end;

{ TTipoConfigLucroPresumidoDeleteIrpj }

function TTipoConfigLucroPresumidoDeleteIrpj.fDelete(
  const AstrCodigo: String): Boolean;
var
  LqryExec: TUniQuery ;
  LblnEmTransacao: Boolean ;
begin

  if fEmptyStr(AstrCodigo) then
    Exit(True) ;

  LblnEmTransacao := fInTransaction ;

  if not LblnEmTransacao then
    fStartTransaction() ;

  try

    LqryExec := fCriaQuery() ;
    try
      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add('DELETE FROM PRIRPG WHERE IRM_CODIGO = :CODIGO') ;
      LqryExec.ParamByName('CODIGO').AsString := AstrCodigo ;
      LqryExec.ExecSQL ;

      if not LblnEmTransacao then
        fCommit() ;

      Result := True ;
    finally
      FreeAndNil(LqryExec) ;
    end ;

  Except
    On E: Exception Do
    Begin
      if not LblnEmTransacao then
        fRollback();
      Raise Exception.Create(E.message + 'Problemas ao deletar configurações Lucro Presumido. Tente novamente!');
    End;
  End;

end;

class function TTipoConfigLucroPresumidoDeleteIrpj.New: ITipoConfigLucroPresumidoDelete;
begin
  Result := Self.Create ;
end;

{ TTipoConfigLucroPresumidoClonaIrpj }

function TTipoConfigLucroPresumidoClonaIrpj.fClona(const AstrCodEmpDest: String;
  const AintExercicioDest: Integer;
  const AItem: IDadosConfigLucroPresumidoCfg): Boolean;
begin

  AItem.Geral.CodEmp(AstrCodEmpDest) ;
  AItem.Geral.Exerci(AintExercicioDest) ;
  AItem.Geral.Codigo('') ; //limpo o código para evitar a Deleção na hora de clonar

  Result := TTipoConfigLucroPresumidoSalvaIrpj.New.fSalva(Aitem) ;

end;

{ TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCIrpj }

constructor TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCIrpj.Create;
begin
  FlstLista := TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC>.Create ;
  FstrParame := 'S' ;
end;

destructor TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCIrpj.Destroy;
begin
  FreeAndNil(FlstLista);
  inherited;
end;

function TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCIrpj.fFiltroParame(
  const AstrParame: String): ITipoConfigLucroPresumidoCadastroTabelaApuracaoBC;
begin
  Result := Self ;
  FstrParame := AstrParame ;
end;

function TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCIrpj.fSeleciona: TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC>;
begin
  Result := fSelecionaInterno ;
end;

function TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCIrpj.fSelecionaInterno: TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC>;
var
  LqryTabela: TUniQuery ;
begin
  LqryTabela := fCriaQuery() ;
  try
    pSelecionaBd(LqryTabela) ;
    Result := TTipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC
                .New
                .fSetLista(FlstLista)
                .fPrepara(LqryTabela)
                .fListaProcessada ;
  finally
    FreeAndNil(LqryTabela) ;
  end ;
end;

procedure TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCIrpj.pSelecionaBd(
  var AqryTabela: TUniQuery);
begin
  AqryTabela.Close ;
  AqryTabela.SQL.Clear ;
  AqryTabela.SQL.Add(' SELECT ') ;
  AqryTabela.SQL.Add('   PRN_CODIGO, ') ;
  AqryTabela.SQL.Add('   PRN_DESCRI, ') ;
  AqryTabela.SQL.Add('   PRN_GRUPO_, ') ;
  AqryTabela.SQL.Add('   PRN_SEQUEN, ') ;
  AqryTabela.SQL.Add('   AUTOINCREM, ') ;
  AqryTabela.SQL.Add('   PRN_PORCEN, ') ;
  AqryTabela.SQL.Add('   PRN_PARAME ') ;
  AqryTabela.SQL.Add('   FROM PRNIRP ') ;
  if not fEmptyStr(FstrParame) then
  begin
    AqryTabela.SQL.Add(' WHERE PRN_PARAME = :PARAME ') ;
    AqryTabela.ParamByName('PARAME').AsString := FstrParame ;
  end ;
  AqryTabela.SQL.Add('   ORDER BY PRN_SEQUEN ') ;
  AqryTabela.Open ;
end;

end.
