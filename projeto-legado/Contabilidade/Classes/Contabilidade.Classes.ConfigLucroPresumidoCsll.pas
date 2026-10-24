unit Contabilidade.Classes.ConfigLucroPresumidoCsll;

interface

uses Contabilidade.Interfaces.ConfigLucroPresumido, Data.DB, MemDS, DBAccess,
  Uni, Datasnap.DBClient, UniClientDataSet, System.Generics.Collections ;

type
  TTipoConfigLucroPresumidoSalvaCsll = class(TInterfacedObject, ITipoConfigLucroPresumidoSalva)
  public
    function fSalva(const ACfg: IDadosConfigLucroPresumidoCfg): Boolean;
    class function New: ITipoConfigLucroPresumidoSalva;
  end ;

  TTipoConfigLucroPresumidoCarregaCsll = class(TInterfacedObject, ITipoConfigLucroPresumidoCarrega)
  private
    FstrParame: String ;
    procedure pCarregaBd(const AstrCodEmp: String; const AintExercicio: Integer;
                         var AqryGeral, AqryGeralLancon, AqryDetalhe: TUniQuery;
                         var AcdsDetalhePlanco: TUniClientDataSet);
    function fCarregaInterno(const AstrCodEmp: String; const AintExercicio: Integer): IDadosConfigLucroPresumidoCfg;
  public
    function fFiltroParame(const AstrParame: String): ITipoConfigLucroPresumidoCarrega ;
    function fCarrega(const AstrCodEmp: String; const AintExercicio: Integer; var AstrMensagem: String): IDadosConfigLucroPresumidoCfg;
    class function New: ITipoConfigLucroPresumidoCarrega ;
    constructor Create;
  end ;

  TTipoConfigLucroPresumidoDeleteCsll = class(TInterfacedObject, ITipoConfigLucroPresumidoDelete)
  public
    function fDelete(const AstrCodigo: String): Boolean;
    class function New: ITipoConfigLucroPresumidoDelete;
  end ;

  TTipoConfigLucroPresumidoClonaCsll = class(TInterfacedObject, ITipoConfigLucroPresumidoClona)
  public
    function fClona(const AstrCodEmpDest: String; const AintExercicioDest: Integer; const AItem: IDadosConfigLucroPresumidoCfg): Boolean;
  end ;

  TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCCsll = class(TInterfacedObject, ITipoConfigLucroPresumidoCadastroTabelaApuracaoBC)
  private
    FstrParame: String ;
    FlstLista: TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC> ;
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
  Contabilidade.Classes.ConfigLucroPresumidoComum, untFuncoesSimples, SysUtils, math,
  Contabilidade.Funcoes.ImpostoRenda, Contabilidade.Interfaces ;

{ TTipoConfigLucroPresumidoCarregaCsll }

constructor TTipoConfigLucroPresumidoCarregaCsll.Create;
begin
  FstrParame := 'S' ;
end;

function TTipoConfigLucroPresumidoCarregaCsll.fCarrega(const AstrCodEmp: String; const AintExercicio: Integer; var AstrMensagem: String): IDadosConfigLucroPresumidoCfg;
begin
  Result := Nil ;

  if not fValidaParametrizacaoEmpresaLucroPresumido(AstrCodEmp, IntToStr(AintExercicio), AstrMensagem) then
    Exit ;

  Result := fCarregaInterno(AstrCodEmp, AintExercicio) ;
end;

function TTipoConfigLucroPresumidoCarregaCsll.fCarregaInterno(
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

function TTipoConfigLucroPresumidoCarregaCsll.fFiltroParame(
  const AstrParame: String): ITipoConfigLucroPresumidoCarrega;
begin
  Result := Self ;
  FstrParame := AstrParame ;
end;

class function TTipoConfigLucroPresumidoCarregaCsll.New: ITipoConfigLucroPresumidoCarrega;
begin
  Result := Self.Create ;
end;

procedure TTipoConfigLucroPresumidoCarregaCsll.pCarregaBd(
  const AstrCodEmp: String; const AintExercicio: Integer; var AqryGeral,
  AqryGeralLancon, AqryDetalhe: TUniQuery;
  var AcdsDetalhePlanco: TUniClientDataSet);
var
  LqryDetalhePlanco: TUniQuery ;
begin

  AqryGeral.SQL.Clear ;
  AqryGeral.SQL.Add(' SELECT ') ;
  AqryGeral.SQL.Add('  AUTOINCREM, ') ;
  AqryGeral.SQL.Add('  CSM_CODIGO AS CODIGO, ') ;
  AqryGeral.SQL.Add('  CSM_CODEMP AS CODEMP, ') ;
  AqryGeral.SQL.Add('  CSM_EXERCI AS EXERCI  ') ;
  AqryGeral.SQL.Add('  FROM PRCSLG ') ;
  AqryGeral.SQL.Add('    WHERE CSM_CODEMP = :CODEMP ') ;
  AqryGeral.SQL.Add('    AND CSM_EXERCI = :EXERCI ') ;
  AqryGeral.ParamByName('CODEMP').AsString := AstrCodEmp ;
  AqryGeral.ParamByName('EXERCI').AsInteger := AintExercicio ;
  AqryGeral.Open ;

  LqryDetalhePlanco := fCriaQuery() ;
  try
    AqryGeralLancon.SQL.Clear ;
    AqryGeralLancon.SQL.Add(' SELECT ') ;
    AqryGeralLancon.SQL.Add('  AUTOINCREM, ') ;
    AqryGeralLancon.SQL.Add('  CSL_SEQGER AS SEQGER, ') ;
    AqryGeralLancon.SQL.Add('  CSL_HISPAD AS HISPAD, ') ;
    AqryGeralLancon.SQL.Add('  CSL_HISTOR AS HISTOR, ') ;
    AqryGeralLancon.SQL.Add('  CSL_CODCON AS CODCON ') ;
    AqryGeralLancon.SQL.Add(' FROM PRCSLN ') ;
    AqryGeralLancon.SQL.Add(' WHERE CSL_SEQGER = :SEQGER ; ') ;
    AqryGeralLancon.ParamByName('SEQGER').AsString := AqryGeral.FieldByName('CODIGO').AsString ;
    AqryGeralLancon.Open ;

    AqryDetalhe.SQL.Clear ;
    AqryDetalhe.SQL.Add(' SELECT ') ;
    AqryDetalhe.SQL.Add('   PRCSLD.AUTOINCREM, ') ;
    AqryDetalhe.SQL.Add('   PRCSLD.CSD_CODIGO AS CODIGO, ') ;
    AqryDetalhe.SQL.Add('   PRCSLD.CSD_SEQGER AS SEQGER, ') ;
    AqryDetalhe.SQL.Add('   PRNCSL.AUTOINCREM AS PRNIRP, ') ;
    AqryDetalhe.SQL.Add('   PRNCSL.PRN_GRUPO_ AS GRUPO_, ') ;
    AqryDetalhe.SQL.Add('   PRNCSL.PRN_CODIGO AS CODPAR, ') ;
    AqryDetalhe.SQL.Add('   PRNCSL.PRN_DESCRI AS DESCRI, ') ;
    AqryDetalhe.SQL.Add('   PRNCSL.PRN_PORCEN AS PORCEN ') ;
    AqryDetalhe.SQL.Add('  FROM PRCSLD RIGHT JOIN PRNCSL ON PRCSLD.CSD_PRNCSL=PRNCSL.AUTOINCREM AND PRCSLD.CSD_SEQGER = :SEQGER ') ;
    if FstrParame = 'S' then
      AqryDetalhe.SQL.Add(' WHERE PRNCSL.PRN_PARAME = "S" ') ;
    AqryDetalhe.SQL.Add('  ORDER BY PRNCSL.PRN_SEQUEN ') ;
    AqryDetalhe.ParamByName('SEQGER').AsString := AqryGeral.FieldByName('CODIGO').AsString ;
    AqryDetalhe.Open ;

    LqryDetalhePlanco.SQL.Clear ;
    LqryDetalhePlanco.SQL.Add(' SELECT ') ;
    LqryDetalhePlanco.SQL.Add('  PRCSCN.AUTOINCREM, ') ;
    LqryDetalhePlanco.SQL.Add('  CSC_SEQGER AS SEQGER, ') ;
    LqryDetalhePlanco.SQL.Add('  CSC_CODCON AS CODCON, ') ;
    LqryDetalhePlanco.SQL.Add('  CSC_TPLACO AS TPLACO ') ;
    LqryDetalhePlanco.SQL.Add(' FROM PRCSCN ') ;
    LqryDetalhePlanco.SQL.Add('  INNER JOIN PRCSLD ON PRCSCN.CSC_SEQGER = PRCSLD.CSD_CODIGO ') ;
    LqryDetalhePlanco.SQL.Add(' WHERE PRCSLD.CSD_SEQGER = :SEQGER ; ') ;
    LqryDetalhePlanco.ParamByName('SEQGER').AsString := AqryGeral.FieldByName('CODIGO').AsString ;
    LqryDetalhePlanco.Open ;

    AcdsDetalhePlanco := fCriaClientDatset(LqryDetalhePlanco) ;
    AcdsDetalhePlanco.IndexFieldNames := 'SEQGER' ;

  finally
    FreeAndNil(LqryDetalhePlanco) ;
  end ;

end;

{ TTipoConfigLucroPresumidoSalvaCsll }

function TTipoConfigLucroPresumidoSalvaCsll.fSalva(
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
      TTipoConfigLucroPresumidoDeleteCsll.New.fDelete(ACfg.Geral.Codigo) ;

    LqryExecGeral := fCriaQuery() ;
    LqryExecCfgLancon := fCriaQuery() ;
    LqryExecDetalhe := fCriaQuery() ;
    LqryExecDetalhePlanco := fCriaQuery() ;
    try
      LqryExecGeral.Close ;
      LqryExecGeral.SQL.Clear ;
      LqryExecGeral.SQL.Add('SELECT * FROM PRCSLG WHERE FALSE') ;
      LqryExecGeral.Open ;

      LstrAutoInc := fRetAutoIncrem('PRCSLG', VS_strCodEmp) ;
      LintTamanhoCampo := fRetTamCampo('PRCSLG') ;
      LintTamanhoCampo := ifThen(LintTamanhoCampo = 0, 6, LintTamanhoCampo) ;

      LstrProCod := fAtualizaProCod('PRCSLG', 'CSM_CODIGO', '', 1, Nil,
        function ( const AValue: String): String
        begin
          Result := fPadL(AValue, LintTamanhoCampo, '0');
        end
      );

      LqryExecGeral.Append ;
      LqryExecGeral.FieldByName('AUTOINCREM').AsString := LstrAutoInc ;
      LqryExecGeral.FieldByName('CSM_CODIGO').AsString := LstrProCod ;
      LqryExecGeral.FieldByName('CSM_CODEMP').AsString := ACfg.Geral.CodEmp ;
      LqryExecGeral.FieldByName('CSM_EXERCI').AsInteger := ACfg.Geral.Exerci ;
      LqryExecGeral.Post ;

      if Assigned(ACfg.GeralLanCon) then
      begin
        LqryExecCfgLancon.Close ;
        LqryExecCfgLancon.SQL.Clear ;
        LqryExecCfgLancon.SQL.Add('SELECT * FROM PRCSLN WHERE FALSE') ;
        LqryExecCfgLancon.Open ;

        LqryExecCfgLancon.Append ;
        LqryExecCfgLancon.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PRCSLN', VS_strCodEmp) ;
        LqryExecCfgLancon.FieldByName('CSL_SEQGER').AsString := LstrProCod ;
        if ACfg.GeralLanCon.HisPad > 0 then
          LqryExecCfgLancon.FieldByName('CSL_HISPAD').AsInteger := ACfg.GeralLanCon.HisPad ;
        LqryExecCfgLancon.FieldByName('CSL_HISTOR').AsString := Acfg.GeralLanCon.Histor ;
        LqryExecCfgLancon.FieldByName('CSL_CODCON').AsString := Acfg.GeralLanCon.CodCon ;
        LqryExecCfgLancon.Post ;
      end ;

      LqryExecDetalhe.Close ;
      LqryExecDetalhe.SQL.Clear ;
      LqryExecDetalhe.SQL.Add('SELECT * FROM PRCSLD WHERE FALSE') ;
      LqryExecDetalhe.Open ;

      LqryExecDetalhePlanco.Close ;
      LqryExecDetalhePlanco.SQL.Clear ;
      LqryExecDetalhePlanco.SQL.Add('SELECT * FROM PRCSCN WHERE FALSE') ;
      LqryExecDetalhePlanco.Open ;

      LintTamanhoCampoDetalhe := fRetTamCampo('PRCSLD') ;
      LintTamanhoCampoDetalhe := ifThen(LintTamanhoCampoDetalhe = 0, 6, LintTamanhoCampoDetalhe) ;

      for LobjItem in ACfg.Detalhe do
      begin
        LqryExecDetalhe.Append ;
        LqryExecDetalhe.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PRCSLD', VS_strCodEmp) ;
        LqryExecDetalhe.FieldByName('CSD_CODIGO').AsString := fAtualizaProCod('PRCSLD', 'CSD_CODIGO', '', 1, Nil,
          function (const AValue: String) : String
          begin
            Result := fPadL(AValue, LintTamanhoCampoDetalhe, '0');
          end
        );
        LqryExecDetalhe.FieldByName('CSD_SEQGER').AsString := LstrProCod ;
        LqryExecDetalhe.FieldByName('CSD_PRNCSL').AsInteger := LobjItem.Config ;
        LqryExecDetalhe.Post ;
        for LobjItemConta in LobjItem.Contas do
        begin
          LqryExecDetalhePlanco.Append ;
          LqryExecDetalhePlanco.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PRCSCN', VS_strCodEmp) ;
          LqryExecDetalhePlanco.FieldByName('CSC_SEQGER').AsString := LqryExecDetalhe.FieldByName('CSD_CODIGO').AsString ;
          LqryExecDetalhePlanco.FieldByName('CSC_CODCON').AsString := LobjItemConta.CodCon ;
          LqryExecDetalhePlanco.FieldByName('CSC_TPLACO').AsString := LobjItemConta.TpLaCo ;
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

class function TTipoConfigLucroPresumidoSalvaCsll.New: ITipoConfigLucroPresumidoSalva;
begin
  Result := Self.Create ;
end;

{ TTipoConfigLucroPresumidoDeleteCsll }

function TTipoConfigLucroPresumidoDeleteCsll.fDelete(
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
      LqryExec.SQL.Add('DELETE FROM PRCSLG WHERE CSM_CODIGO = :CODIGO') ;
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

class function TTipoConfigLucroPresumidoDeleteCsll.New: ITipoConfigLucroPresumidoDelete;
begin
  Result := Self.Create ;
end;

{ TTipoConfigLucroPresumidoClonaCsll }

function TTipoConfigLucroPresumidoClonaCsll.fClona(const AstrCodEmpDest: String;
  const AintExercicioDest: Integer;
  const AItem: IDadosConfigLucroPresumidoCfg): Boolean;
begin
  AItem.Geral.CodEmp(AstrCodEmpDest) ;
  AItem.Geral.Exerci(AintExercicioDest) ;
  AItem.Geral.Codigo('') ; //limpo o código para evitar a Deleção na hora de clonar

  Result := TTipoConfigLucroPresumidoSalvaCsll.New.fSalva(Aitem) ;
end;

{ TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCCsll }

constructor TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCCsll.Create;
begin
  FlstLista := TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC>.Create ;
  FstrParame := 'S' ;
end;

destructor TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCCsll.Destroy;
begin
  FreeAndNil(FlstLista);
  inherited;
end;

function TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCCsll.fFiltroParame(
  const AstrParame: String): ITipoConfigLucroPresumidoCadastroTabelaApuracaoBC;
begin
  Result := Self ;
  FstrParame := AstrParame ;
end;

function TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCCsll.fSeleciona: TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC>;
begin
  Result := fSelecionaInterno ;
end;

function TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCCsll.fSelecionaInterno: TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC>;
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

procedure TTipoConfigLucroPresumidoCadastroTabelaApuracaoBCCsll.pSelecionaBd(
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
  AqryTabela.SQL.Add('   FROM PRNCSL ') ;
  if not fEmptyStr(FstrParame) then
  begin
    AqryTabela.SQL.Add(' WHERE PRN_PARAME = :PARAME ') ;
    AqryTabela.ParamByName('PARAME').AsString := FstrParame ;
  end ;
  AqryTabela.SQL.Add('   ORDER BY PRN_SEQUEN ') ;
  AqryTabela.Open ;
end;

end.
