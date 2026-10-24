unit untRegrasCadastroCartaoTef;

interface

uses System.Generics.Collections, Uni, DB, UniClientDataSet, untTypesSistema,
  Vcl.StdCtrls, untFuncoesSimples ;

type
  TFornecedorTef = (ftClisitef, ftScope) ;
  TTipoCartao = (tcCredito, tcDebito) ;
  TTipoTransacao = (ttTef, ttPos) ;
  TTipoValidacao = (tvAdquirente, tvBandeira);
  TTiposTransacao = set of TTipoTransacao ;

  TInfoBandeira = class
  strict private
    FstrCodigoBandeiraTef: String ;
    FftFornecedor: TFornecedorTef ;
  public
    property CodigoBandeiraTef: String read FstrCodigoBandeiraTef write FstrCodigoBandeiraTef ;
    property Fornecedor: TFornecedorTef read FftFornecedor write FftFornecedor ;
  end ;

  TListInfoBandeira = TObjectList<TInfoBandeira> ;

  TInfoTipoCartao = class
  strict private
    FtcTipo: TTipoCartao ;
    FItensCodigo: TListInfoBandeira ;
  public
    property Tipo: TTipoCartao read FtcTipo write FtcTipo ;
    property ItensBandeira: TListInfoBandeira read FItensCodigo ;
    function fAdd(const AstrCodigo: String; const AftFornecedor: TFornecedorTef): integer ;
    constructor Create;
    destructor Destroy; override;
  end ;

  TListInfoTipoCartao = TObjectList<TInfoTipoCartao> ;

  TItemBandeiraTef = class
  strict private
    FstrDescricao: String ;
    FItensCodigo: TListInfoTipoCartao ;
  public
    property Descricao: String read FstrDescricao write FstrDescricao ;
    property ItensCodigo: TListInfoTipoCartao read FItensCodigo write FItensCodigo ;
    function fAdd(const AfcTipo: TTipoCartao): Integer ;
    function fIndexOf(const AfcTipo: TTipoCartao): Integer ;
    constructor Create(const AstrDescricao: String); reintroduce;
    destructor Destroy; override;
  end ;

  TListBandeiraTef = TObjectList<TItemBandeiraTef> ;

  TinfoAdquirente = class
  strict private
    FstrCodigoAdquirenteTef: String ;
    FftFornecedor: TFornecedorTef ;
  public
    property CodigoAdquirenteTef: String read FstrCodigoAdquirenteTef write FstrCodigoAdquirenteTef ;
    property Fornecedor: TFornecedorTef read FftFornecedor write FftFornecedor ;
  end ;

  TListInfoAdquirente = TObjectList<TInfoAdquirente> ;

  TItemAdquirenteTef = class
  strict private
    FstrDescricao: String ;
    FItensCodigo: TListInfoAdquirente ;
  public
    property Descricao: String read FstrDescricao write FstrDescricao ;
    property ItensCodigo: TListInfoAdquirente read FItensCodigo write FItensCodigo ;
    function fAdd(const AstrCodigo: String;
                  const AftFornecedor: TFornecedorTef): Integer ;
    constructor Create(const AstrDescricao: String); reintroduce;
    destructor Destroy; override;
  end ;

  TListAdquirenteTef = TObjectList<TItemAdquirenteTef> ;

  TCarregaBandeirasTef = class
  strict private
    FlstBandeiras: TListBandeiraTef ;
    procedure pCarregaInfo() ;
    procedure pClearParamByName(AQry: TUniQuery);
    function fMontaInsertMaster(): String ;
    function fMontaInsertDetail(): String ;
    function fEhRegistroCadastrado(const AItemBandeira: TItemBandeiraTef; const AConsulta: TUniQuery): Boolean ;
  public
    property Bandeiras: TListBandeiraTef read FlstBandeiras ;
    class procedure pPreparaColunasParams(var AstrColunas, AstrParams: String) ;
    function fPersistirBanco(const AVerificarRegistro: Boolean = False): Boolean ; overload ;
    function fPersistirBanco(const AItem:TItemBandeiraTef; const AAutoInc, ADescricao: String): Boolean ; overload ;
    constructor Create;
    destructor Destroy; override;
  end ;

  TCarregaAdquirentesTef = class
  strict private
    FlstAdquirentes: TListAdquirenteTef ;
    procedure pCarregaInfo() ;
    procedure pClearParamByName(AQry: TUniQuery);
    function fMontaInsert(): String ;
    function fMontaUpdate(): String ;
    function fEhRegistroCadastrado(const AItemAdquirente: TItemAdquirenteTef; const AConsulta: TUniQuery): Boolean ;
  public
    property Adquirentes: TListAdquirenteTef read FlstAdquirentes ;
    class procedure pPreparaColunasParams(var AstrColunas, AstrParams: String) ;
    function fPersistirBanco(const AVerificarRegistro: Boolean = False): Boolean ; overload ;
    function fPersistirBanco(const AItem:TItemAdquirenteTef; const AAutoInc, ADescricao: String): Boolean ; overload ;
    constructor Create;
    destructor Destroy; override;
  end ;

  TParamEntradaDadosTef = record
    codigo_bandeira: String ;
    codigo_adquirente: String ;
    tipo_cartao: TTipoCartao ;
    parcela_minima: Integer ;
    parcela_maxima: Integer ;
    tipo_transacao: TTiposTransacao ;
    pos_adquirente: Boolean;
  end ;

  TCodigosTef = record
    codigo_bandeira: String ;
    codigo_rede: String ;
  end ;

  TArrCodigosTef = array[TFornecedorTef] of TCodigosTef ;

  TParamSaidaDadosTef = record
    descricao: String ;
    codigos: TArrCodigosTef ;
  end ;

  TParamEntradaPesquisaCartao = record
    codigo_empresa: String ;
    tipo_cartao: TTipoCartao ;
    tipo_debito: char ;
    parcela: integer ;
    codigo_rede: string ;
    codigo_bandeira: string ;
    codigo_cardse: string ;
  end ;

  TRetornoPesquisaCartao = record
    codigo_empresa: String ;
    codigo_cartao: String ;
  end ;

  TParamEntradaValidacao = record
    TipoPos: Boolean;
    TipoTef: Boolean;
    CodAdq: String;
    NomAdq: String;
    TefCodAdqClisitef: String;
    TefCodBanClisitef: String;
    TefCodAdqScope: String;
    TefCodBanScope: String;
    Codban: String;
    NomBan: String;
  end;

  TRegrasCadastroCartaoTef = class
  public
    class function fTemRegistrosCadBan: Boolean ;
    class function fCadastraCadBanPadronizadoTef: Boolean ;
    class function fTemRegistrosCdAdqC: Boolean ;
    class function fCadastraCdAdqCPadronizadoTef: Boolean ;
    class function fDadosTransacaoCartao(const APesquisa: TParamEntradaDadosTef;
                                         var ARetorno: TParamSaidaDadosTef): Boolean ;
    class function fCarregaConferenciaCadBan(var AcdsTabela: TUniClientDataSet): Boolean ;
    class function fCarregaConferenciaCdAdqC(var AcdsTabela: TUniClientDataSet): Boolean ;
    class function fAlteraNomeCartaoDoCadastro(const ACodAdqAlt: String; const ACodBanAlt: String): Boolean;
    class function fProximoCodigo(const strNomeTabela, strCampoBusca : String): String;
    class function fAtualizaProCod(const strNomeTabela : String; const strCampoBusca : String; const strTabelaBusca : String = ''; const intQtdCod : Integer = 1; objConnection : TUniConnection = Nil; const objFncFmt : TFcnFormataProCod = Nil): String;
    class procedure pValidarProximoCodigo(Var intCodigoAtual : Int64; const intTamCodigo : Integer; const blnCodPorEmpresa : Boolean; const intQtdCod : Integer; const strCampoBusca, strTabelaBusca : String; const objConnection : TUniConnection; const objFncFmt : TFcnFormataProCod);
  end ;

  TUtilCadastroCartaoTef = class
  public
    class function fGetTipoCartao(const AstrTipoCartao: String): TTipoCartao ;
    class function fGetTipoCartaoToStr(const ATipoCartao: TTipoCartao):String ;
    class function fGetFornecedor(): TFornecedorTef ; overload ;
    class function fGetFornecedor(const AFornecedor: String): TFornecedorTef ; overload ;
    class function fInformaOperadorCartaoEncontrado(): Boolean ;
    class function fAdquirenteModoPos(const ACodAdq: String): Boolean;
    class function fPossuiDadosInvalidos(const AParam: TParamEntradaValidacao; out AMensagem: String): Boolean;
  end ;

  TRetornoDadosCartaoTef = class
  private
    class var FqryConsulta: TUniQuery ;
    class procedure pAbrirConsulta(const AtpacBusca: TTipoPesquisaAmarrarCartao; const AFiltro: TParamEntradaPesquisaCartao) ;
  public
    class function fRetornaCodigoCartao(const AFiltro: TParamEntradaPesquisaCartao): TRetornoPesquisaCartao ;
  end ;

  TTRegrasCartaoTefService = class
  public
    class function fDadosTransacaoCartao(const AEntrada: TParamEntradaDadosTef;
      out ARetorno: TParamSaidaDadosTef): Boolean;
    class function fGetText(AEdit: TEdit; AFieldName: string; ADataSet: TDataSet): string;
    class function fTFornecedorTefToStr(AFornecedorTef: TFornecedorTef): String;
    class function fValidaRegrasRetorno(AFornecedorTef: TFornecedorTef; const ARetorno: TParamSaidaDadosTef;
      APesquisa: TParamEntradaDadosTef; ATipoValidacao: TTipoValidacao; out AMensagem: String): Boolean;
  end;

const
  COLUNAS_CADBND : Array[TFornecedorTef] Of String = ('BAN_TFTBAN', 'BAN_TFBAN2') ;
  COLUNAS_CDADQC : Array[TFornecedorTef] Of String = ('ADQ_TFTRED', 'ADQ_TFRED2') ;
  TIPO_CARTAO    : Array[TTipoCartao] Of String = ('C', 'D') ;
  STATUS_CONFIGURADO : string = 'Configurado' ;
  STATUS_PENDENTE    : string = 'Pendente' ;
  STATUS_AJUSTADO    : string = 'Ajustado Manualmente' ;

implementation

uses SysUtils, StrUtils, Classes, untModulo, DateUtils, untGravando  ;

{ TRegrasCadastroCartaoTef }

class function TRegrasCadastroCartaoTef.fCadastraCadBanPadronizadoTef: Boolean;
var
  LCadastra: TCarregaBandeirasTef ;
begin
  Result := False ;
  LCadastra := TCarregaBandeirasTef.Create ;
  try
    fStartTransaction ;
    try
      Result := LCadastra.fPersistirBanco ;
      fCommit ;
    except
      on E: EUniError do
      begin
        fRollBack;
        pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, '[TRegrasCadastroCartaoTef.fCadastraCadBanPadronizadoTef]');
      end ;
    end ;
  finally
    FreeAndNil(LCadastra) ;
  end ;
end;

class function TRegrasCadastroCartaoTef.fCadastraCdAdqCPadronizadoTef: Boolean;
var
  LCadastra: TCarregaAdquirentesTef ;
begin
  Result := False ;
  LCadastra := TCarregaAdquirentesTef.Create ;
  try
    fStartTransaction ;
    try
      Result := LCadastra.fPersistirBanco ;
      fCommit ;
    except
      on E: EUniError do
      begin
        fRollBack;
        pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, '[TRegrasCadastroCartaoTef.fCadastraCdAdqCPadronizadoTef]');
      end ;
    end ;
  finally
    FreeAndNil(LCadastra) ;
  end ;
end;

class function TRegrasCadastroCartaoTef.fCarregaConferenciaCadBan(
  var AcdsTabela: TUniClientDataSet): Boolean;
var
  LqryConsulta: TUniQuery ;
  LprcScroll: TprcScroll ;
begin

  if Assigned(AcdsTabela) then
    FreeAndNil(AcdsTabela) ;

  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT ') ;
    LqryConsulta.SQL.Add('   AUTOINCREM, ') ;
    LqryConsulta.SQL.Add('   BAN_CODBAN, ') ;
    LqryConsulta.SQL.Add('   BAN_NOMBAN, ') ;
    LqryConsulta.SQL.Add('   (CAST(NULL AS CHAR(20))) AS AUXILI, ') ;
    LqryConsulta.SQL.Add('   (CAST(NULL AS CHAR(20))) AS STATUS, ') ;
    LqryConsulta.SQL.Add('   (SELECT COUNT(*) > 0 AS CNT FROM CADBND WHERE BAN_SEQBAN = CADBAN.AUTOINCREM) AS TEMTEF ') ;
    LqryConsulta.SQL.Add(' FROM CADBAN ; ') ;
    LqryConsulta.Open ;
    AcdsTabela := fCriaClientDatset(LqryConsulta) ;

    pDisableControls(AcdsTabela, LprcScroll);
    try
      AcdsTabela.First ;
      while not AcdsTabela.Eof do
      begin

        AcdsTabela.Edit ;
        if AcdsTabela.FieldByName('TEMTEF').AsInteger = 1 then
        begin
          AcdsTabela.FieldByName('AUXILI').AsString := AcdsTabela.FieldByName('BAN_NOMBAN').AsString ;
          AcdsTabela.FieldByName('STATUS').AsString := STATUS_CONFIGURADO ;
        end
        else
          AcdsTabela.FieldByName('STATUS').AsString := STATUS_PENDENTE ;
        AcdsTabela.Post ;

        AcdsTabela.Next ;
      end ;
    finally
      pEnableControls(AcdsTabela, LprcScroll);
    end ;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;
  Result := True ;
end;

class function TRegrasCadastroCartaoTef.fCarregaConferenciaCdAdqC(
  var AcdsTabela: TUniClientDataSet): Boolean;
var
  LqryConsulta: TUniQuery ;
  LprcScroll: TprcScroll ;
begin

  if Assigned(AcdsTabela) then
    FreeAndNil(AcdsTabela) ;

  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT ') ;
    LqryConsulta.SQL.Add('   AUTOINCREM, ') ;
    LqryConsulta.SQL.Add('   ADQ_CODADQ, ') ;
    LqryConsulta.SQL.Add('   ADQ_NOMADQ, ') ;
    LqryConsulta.SQL.Add('   (CAST(NULL AS CHAR(20))) AS AUXILI, ') ;
    LqryConsulta.SQL.Add('   (CAST(NULL AS CHAR(20))) AS STATUS, ') ;
    LqryConsulta.SQL.Add('   ((ADQ_TFTRED IS NOT NULL) OR (ADQ_TFRED2 IS NOT NULL)) AS TEMTEF ') ;
    LqryConsulta.SQL.Add(' FROM CDADQC ') ;
    LqryConsulta.Open ;
    AcdsTabela := fCriaClientDatset(LqryConsulta) ;

    pDisableControls(AcdsTabela, LprcScroll);
    try
      AcdsTabela.First ;
      while not AcdsTabela.Eof do
      begin

        AcdsTabela.Edit ;
        if AcdsTabela.FieldByName('TEMTEF').AsInteger = 1 then
        begin
          AcdsTabela.FieldByName('AUXILI').AsString := AcdsTabela.FieldByName('ADQ_NOMADQ').AsString ;
          AcdsTabela.FieldByName('STATUS').AsString := STATUS_CONFIGURADO ;
        end
        else
          AcdsTabela.FieldByName('STATUS').AsString := STATUS_PENDENTE ;
        AcdsTabela.Post ;

        AcdsTabela.Next ;
      end ;
    finally
      pEnableControls(AcdsTabela, LprcScroll);
    end ;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;
  Result := True ;
end;

class function TRegrasCadastroCartaoTef.fAlteraNomeCartaoDoCadastro(const ACodAdqAlt: String; const ACodBanAlt: String): Boolean;
var
  LqryCartoes: TUniQuery ;
  LPesquisa: TParamEntradaDadosTef ;
  LRetorno: TParamSaidaDadosTef ;
  LOk: Boolean ;
begin
  If fCadastroCartaoParamAutTef Then
  Begin
    If ((not fEmptyStr(ACodAdqAlt)) Or (not fEmptyStr(ACodBanAlt))) Then
    Begin
      LqryCartoes := fCriaQuery() ;
      try
        LqryCartoes.Close ;
        LqryCartoes.SQL.Clear ;
        LqryCartoes.SQL.Add(' SELECT AUTOINCREM, CAR_DESCAR, CAR_CODBAN, CAR_SUGPAR, CAR_MAXPAR, CAR_TIPCAR, CAR_CODADQ, CAR_TIPTEF, CAR_TIPPOS ' ) ;
        LqryCartoes.SQL.Add(' FROM CADCAR ') ;
        If not fEmptyStr(ACodAdqAlt) Then
        Begin
          LqryCartoes.SQL.Add(' WHERE CAR_CODADQ = :CODADQ' );
          LqryCartoes.ParamByName('CODADQ').AsString := ACodAdqAlt ;
        End
        Else
        Begin
          LqryCartoes.SQL.Add(' WHERE CAR_CODBAN = :CODBAN' );
          LqryCartoes.ParamByName('CODBAN').AsString := ACodBanAlt ;
        End;

        LqryCartoes.Open ;

        while not LqryCartoes.Eof do
        begin
          FillChar(LPesquisa, Sizeof(TParamEntradaDadosTef), #0);
          LPesquisa.codigo_bandeira   := LqryCartoes.FieldByName('CAR_CODBAN').AsString;
          LPesquisa.codigo_adquirente := LqryCartoes.FieldByName('CAR_CODADQ').AsString;

          If (not fEmptyStr(LPesquisa.codigo_bandeira)) and (not fEmptyStr(LPesquisa.codigo_adquirente)) Then
          Begin
            LPesquisa.parcela_minima    := StrToIntDef(LqryCartoes.FieldByName('CAR_SUGPAR').AsString, 0) ;
            LPesquisa.parcela_maxima    := StrToIntDef(LqryCartoes.FieldByName('CAR_MAXPAR').AsString, 0) ;
            LPesquisa.tipo_cartao       := TUtilCadastroCartaoTef.fGetTipoCartao(LqryCartoes.FieldByName('CAR_TIPCAR').AsString) ;
            LPesquisa.tipo_transacao    := [] ;

            if LqryCartoes.FieldByName('CAR_TIPPOS').AsString = 'S' then
              LPesquisa.tipo_transacao := LPesquisa.tipo_transacao + [ttPos] ;
            if LqryCartoes.FieldByName('CAR_TIPTEF').AsString = 'S' then
              LPesquisa.tipo_transacao := LPesquisa.tipo_transacao + [ttTef] ;

            LOk := TRegrasCadastroCartaoTef.fDadosTransacaoCartao(LPesquisa, LRetorno) ;

            If LOk then
            begin
              LqryCartoes.Edit;
              LqryCartoes.FieldByName('CAR_DESCAR').AsString := LRetorno.descricao;
              LqryCartoes.Post;
            end;
          End;

          LqryCartoes.Next;
        end;

      finally
        FreeAndNil(LqryCartoes) ;
      end;
    End;
  End;
  Result := true;
end;

class function TRegrasCadastroCartaoTef.fProximoCodigo(const strNomeTabela, strCampoBusca : String): String;
begin
  Result := fAtualizaProCod(strNomeTabela, strCampoBusca);
end;

class function TRegrasCadastroCartaoTef.fAtualizaProCod(const strNomeTabela : String; const strCampoBusca : String; const strTabelaBusca : String = ''; const intQtdCod : Integer = 1; objConnection : TUniConnection = Nil; const objFncFmt : TFcnFormataProCod = Nil): String;
  Var
    strSQL : String;
    intCodigoAtual : Int64;
    intTamCodigo : Integer;
    blnComita : Boolean;
    qryGenCod : TUniQuery;
    blnCodPorEmpresa : Boolean;
begin
  pValidaProCod(strNomeTabela);

  If Not Assigned(objConnection) then
    objConnection := frmModulo.GetCurrentConnection;

  qryGenCod := fCriaQuery(Nil, objConnection);
  Try
    blnComita := False;

    If Not objConnection.InTransaction Then
    Begin
      fStartTransaction(objConnection);
      blnComita := True;
    End;

    Try
      strSQL := fGetSelectProcodDoArquivoForUpdate;
      qryGenCod.Close;
      qryGenCod.SQL.Clear;
      qryGenCod.SQL.Add(strSQL);
      qryGenCod.ParamByName('NOMARQ').AsString := strNomeTabela;
      qryGenCod.Open;

      pCadastrarProcodProinc(qryGenCod, strSQL, strNomeTabela);

      intCodigoAtual := StrToInt64(qryGenCod.FieldByName('CODSEQ').AsString);
      intTamCodigo   := qryGenCod.FieldByName('TAMCOD').AsInteger;
      blnCodPorEmpresa := (qryGenCod.FieldByName('SEQEMP').AsString = 'S');
      qryGenCod.Close;

      pValidarProximoCodigo(intCodigoAtual, intTamCodigo, blnCodPorEmpresa, intQtdCod, strCampoBusca, IIF(fEmptyStr(strTabelaBusca), strNomeTabela, strTabelaBusca), objConnection, objFncFmt);

      strSQL := fGetUpdateProcodDoArquivo;
      qryGenCod.Close;
      qryGenCod.SQL.Clear;
      qryGenCod.SQL.Add(strSQL);
      qryGenCod.ParamByName('CODSEQ').AsString := fPadL(IntToStr(intCodigoAtual+intQtdCod), intTamCodigo, '0');
      qryGenCod.ParamByName('NOMARQ').AsString := strNomeTabela;
      qryGenCod.ExecSQL;

      Result := fProximoCodigoFormatado(blnCodPorEmpresa, intCodigoAtual, intQtdCod, intTamCodigo);

      If (Assigned(objFncFmt)) Then
        Result := objFncFmt(Result);

      If blnComita Then
        fCommit(objConnection);
    Except
      On E: Exception Do
      Begin
        If blnComita Then
          fRollBack(objConnection);
        Raise ExceptClass(E.ClassType).Create('Não consegui pegar o proximo sequencial de ' + strNomeTabela +
         ' em PROCOD. Tente novamente! ' + sLineBreak + '[' + E.Message + ']');
      End;
    End;
  Finally
    FreeAndNil(qryGenCod);
  End;
end;

class procedure TRegrasCadastroCartaoTef.pValidarProximoCodigo(Var intCodigoAtual : Int64; const intTamCodigo : Integer; const blnCodPorEmpresa : Boolean; const intQtdCod : Integer; const strCampoBusca, strTabelaBusca : String; const objConnection : TUniConnection; const objFncFmt : TFcnFormataProCod);
  Var
    dtaHraExc : TDateTime;
begin
  If fEmptyStr(strCampoBusca) Then
    Exit;
  If fEmptyStr(strTabelaBusca) Then
    Exit;
  If Not fExisteRegistroProcod(objConnection, strCampoBusca, strTabelaBusca, intCodigoAtual, blnCodPorEmpresa, intTamCodigo, intQtdCod, objFncFmt) Then
    Exit;
  dtaHraExc := Now();
  While True Do
  Begin
    If (SecondsBetween(Now(), dtaHraExc) >= 10) Then
      Exit;
    pNotificaFormGravandoAtivo('O próximo código disponível está demorando mais do que o esperado. Aguarde mais um instante.');
    pProcessMessages(True);
    If (intQtdCod = 1) Then
      intCodigoAtual := intCodigoAtual + 1
    Else
      intCodigoAtual := (intCodigoAtual + intQtdCod) + 1;
    If Not fExisteRegistroProcod(objConnection, strCampoBusca, strTabelaBusca, intCodigoAtual, blnCodPorEmpresa, intTamCodigo, intQtdCod, objFncFmt) Then
      Exit;
  End;
end;


class function TRegrasCadastroCartaoTef.fDadosTransacaoCartao(
  const APesquisa: TParamEntradaDadosTef;
  var ARetorno: TParamSaidaDadosTef): Boolean;
var
  LqryAdquirente: TUniQuery ;
  LqryBandeira: TUniQuery ;
  LstrColunas, LstrParams: String ;
  LstrParcela: String ;
  LstrTipoTransacao: String ;
  LstrTipoCartao: String ;
  LstrBandeira: String ;
  LstrAquirente: String ;
  LstrDescricao: String ;
  LFornecedor: TFornecedorTef ;
  LCodigoTef: TCodigosTef ;
begin
  FillChar(ARetorno, Sizeof(TParamSaidaDadosTef), #0);
  LstrBandeira  := '' ;
  LstrAquirente := '' ;

  LqryAdquirente := fCriaQuery() ;
  LqryBandeira := fCriaQuery() ;
  try
    TCarregaAdquirentesTef.pPreparaColunasParams(LstrColunas, LstrParams) ;
    LqryAdquirente.Close ;
    LqryAdquirente.SQL.Clear ;
    LqryAdquirente.SQL.Add(' SELECT ADQ_NOMADQ, ' + LstrColunas + ' ' ) ;
    LqryAdquirente.SQL.Add(' FROM CDADQC WHERE ADQ_CODADQ = :CODADQ' ) ;
    LqryAdquirente.ParamByName('CODADQ').AsString := APesquisa.codigo_adquirente ;
    LqryAdquirente.Open ;

    LstrAquirente := LqryAdquirente.FieldByName('ADQ_NOMADQ').AsString ;

    TCarregaBandeirasTef.pPreparaColunasParams(LstrColunas, LstrParams) ;
    LqryBandeira.Close ;
    LqryBandeira.SQL.Clear ;
    LqryBandeira.SQL.Add(' SELECT BAN_NOMBAN, ' + LstrColunas + ' ') ;
    LqryBandeira.SQL.Add(' FROM CADBAN LEFT JOIN CADBND ON CADBAN.AUTOINCREM = CADBND.BAN_SEQBAN AND CADBND.BAN_TIPCAR = :TIPCAR ') ;
    LqryBandeira.SQL.Add(' WHERE CADBAN.BAN_CODBAN = :CODBAN ') ;
    LqryBandeira.ParamByName('CODBAN').AsString := APesquisa.codigo_bandeira ;
    LqryBandeira.ParamByName('TIPCAR').AsString := TIPO_CARTAO[APesquisa.tipo_cartao] ;
    LqryBandeira.Open ;

    LstrBandeira := LqryBandeira.FieldByName('BAN_NOMBAN').AsString ;

    LstrParcela := '' ;
    if (APesquisa.parcela_minima > 0) and (APesquisa.parcela_maxima > 0) then
    begin
      if APesquisa.parcela_minima = APesquisa.parcela_maxima then
        LstrParcela := IntToStr(APesquisa.parcela_minima)+'x'
      else
        LstrParcela := IntToStr(APesquisa.parcela_minima) + 'x ATÉ ' + IntToStr(APesquisa.parcela_maxima)+'x' ;
    end ;

    LstrTipoTransacao := '' ;
    if APesquisa.tipo_transacao <> [] then
    begin
      if ttTef in APesquisa.tipo_transacao then
        LstrTipoTransacao := LstrTipoTransacao + 'TEF' ;
      if ttPos in APesquisa.tipo_transacao then
        LstrTipoTransacao := LstrTipoTransacao + IfThen(fEmptyStr(LstrTipoTransacao), '', '/') + 'POS' ;
    end ;

    LstrTipoCartao := '' ;
    if APesquisa.tipo_cartao = tcCredito then
      LstrTipoCartao := 'CRÉDITO'
    else if APesquisa.tipo_cartao = tcDebito then
      LstrTipoCartao := 'DÉBITO' ;

    LstrDescricao := Format('%s %s %s %s %s', [LstrTipoTransacao, LstrAquirente, LstrBandeira, LstrParcela, LstrTipoCartao]) ;

    ARetorno.descricao := LstrDescricao ;
    for LFornecedor := low(TFornecedorTef) to High(TFornecedorTef) do
    begin
      FillChar(LCodigoTef, Sizeof(TCodigosTef), #0);
      LCodigoTef.codigo_bandeira := LqryBandeira.FieldByName(COLUNAS_CADBND[LFornecedor]).AsString ;
      LCodigoTef.codigo_rede := LqryAdquirente.FieldByName(COLUNAS_CDADQC[LFornecedor]).AsString ;
      ARetorno.codigos[LFornecedor] := LCodigoTef ;
    end ;

  finally
    FreeAndNil(LqryAdquirente) ;
    FreeAndNil(LqryBandeira) ;
  end ;
  Result := True ;
end;

class function TRegrasCadastroCartaoTef.fTemRegistrosCadBan: Boolean;
var
  LqryVerifica: TUniQuery ;
begin
  Result := False ;
  LqryVerifica := fCriaQuery() ;
  try
    LqryVerifica.Close ;
    LqryVerifica.SQL.Clear ;
    LqryVerifica.SQL.Add('SELECT COUNT(*) AS CNT FROM CADBAN') ;
    LqryVerifica.Open ;
    if not LqryVerifica.IsEmpty then
      Result := LqryVerifica.FieldByName('CNT').AsInteger > 0 ;
  finally
    FreeAndNil(LqryVerifica) ;
  end ;
end;

class function TRegrasCadastroCartaoTef.fTemRegistrosCdAdqC: Boolean;
var
  LqryVerifica: TUniQuery ;
begin
  Result := False ;
  LqryVerifica := fCriaQuery() ;
  try
    LqryVerifica.Close ;
    LqryVerifica.SQL.Clear ;
    LqryVerifica.SQL.Add('SELECT COUNT(*) AS CNT FROM CDADQC') ;
    LqryVerifica.Open ;
    if not LqryVerifica.IsEmpty then
      Result := LqryVerifica.FieldByName('CNT').AsInteger > 0 ;
  finally
    FreeAndNil(LqryVerifica) ;
  end ;
end;

{ TItemBandeiraTef }

constructor TItemBandeiraTef.Create(const AstrDescricao: String);
begin
  FItensCodigo := TListInfoTipoCartao.Create ;
  Self.FstrDescricao := AstrDescricao ;
end;

destructor TItemBandeiraTef.Destroy;
begin
  FreeAndNil(FItensCodigo) ;
  inherited;
end;

function TItemBandeiraTef.fAdd(const AfcTipo: TTipoCartao): Integer;
var
  LCodigos: TInfoTipoCartao ;
begin
  LCodigos := TInfoTipoCartao.Create ;
  LCodigos.Tipo := AfcTipo ;
  Result := Self.FItensCodigo.Add(LCodigos) ;
end;

function TItemBandeiraTef.fIndexOf(const AfcTipo: TTipoCartao): Integer;
var
  LCodigos: TInfoTipoCartao ;
  LIndex: Integer ;
begin
  Result := -1 ;
  LIndex := 0 ;
  for LCodigos in Self.FItensCodigo do
  begin
    if LCodigos.Tipo = AfcTipo then
    begin
      Result := LIndex ;
      break ;
    end ;
    inc(LIndex) ;
  end ;
end;

{ TCarregaBandeirasTef }

constructor TCarregaBandeirasTef.Create;
begin
  FlstBandeiras := TListBandeiraTef.Create ;
  Self.pCarregaInfo() ;
end;

destructor TCarregaBandeirasTef.Destroy;
begin
  FreeAndNil(FlstBandeiras) ;
  inherited;
end;

function TCarregaBandeirasTef.fEhRegistroCadastrado(
  const AItemBandeira: TItemBandeiraTef; const AConsulta: TUniQuery): Boolean;
var
  LInfo: TInfoTipoCartao ;
  LInfoBandeira: TInfoBandeira ;
  LstrValor: String ;
begin
  Result := False  ;
  for LInfo in AItemBandeira.ItensCodigo do
  begin
    for LInfoBandeira in LInfo.ItensBandeira do
    begin
      LstrValor := LInfoBandeira.CodigoBandeiraTef ;
      if not fEmptyStr(LstrValor) then
      begin
        if AConsulta.Locate(COLUNAS_CADBND[LInfoBandeira.Fornecedor], LstrValor, [loCaseInsensitive]) then
        begin
          Result := True ;
          break ;
        end ;
      end ;
    end ;
  end ;
end;

function TCarregaBandeirasTef.fMontaInsertDetail: String;
var
  LstrColunas, LstrParams: String ;
begin
  pPreparaColunasParams(LstrColunas, LstrParams) ;
  Result := 'INSERT INTO CADBND (AUTOINCREM, BAN_TIPCAR, BAN_SEQBAN, ' + LstrColunas + ') VALUES (:AUTOINCREM, :BAN_TIPCAR, :BAN_SEQBAN, ' + LstrParams + ') ;' ;
end;

function TCarregaBandeirasTef.fMontaInsertMaster: String;
begin
  Result := 'INSERT INTO CADBAN (AUTOINCREM, BAN_CODEMP, BAN_CODBAN, BAN_NOMBAN) VALUES (:AUTOINCREM, :BAN_CODEMP, :BAN_CODBAN, :BAN_NOMBAN) ;' ;
end;

function TCarregaBandeirasTef.fPersistirBanco(const AItem: TItemBandeiraTef;
  const AAutoInc, ADescricao: String): Boolean;
var
  LInfo: TInfoTipoCartao ;
  LInfoBandeira: TInfoBandeira ;
  LstrInsertDetail: String ;
  LqryExecDetail: TUniQuery ;
  LqryMaster: TUniQuery ;
begin
  LstrInsertDetail := fMontaInsertDetail ;

  LqryMaster := fCriaQuery() ;
  LqryExecDetail := fCriaQuery() ;
  try
    try
      LqryMaster.Close ;
      LqryMaster.SQL.Clear ;
      LqryMaster.SQL.Add('SELECT * FROM CADBAN WHERE AUTOINCREM = :AUTOINCREM ') ;
      LqryMaster.ParamByName('AUTOINCREM').AsString := AAutoInc ;
      LqryMaster.Open ;

      LqryMaster.Edit ;
      LqryMaster.FieldByName('BAN_NOMBAN').AsString := ADescricao ;
      LqryMaster.Post ;

      LqryExecDetail.Close ;
      LqryExecDetail.SQL.Clear ;
      LqryExecDetail.SQL.Add(LstrInsertDetail) ;

      for LInfo in AItem.ItensCodigo do
      begin
        LqryExecDetail.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CADBND', VS_strCodEmp) ;
        LqryExecDetail.ParamByName('BAN_SEQBAN').AsString := AAutoInc ;
        LqryExecDetail.ParamByName('BAN_TIPCAR').AsString := TIPO_CARTAO[LInfo.Tipo] ;
        pClearParamByName(LqryExecDetail) ;
        for LInfoBandeira in LInfo.ItensBandeira do
          LqryExecDetail.ParamByName(COLUNAS_CADBND[LInfoBandeira.Fornecedor]).AsString := LInfoBandeira.CodigoBandeiraTef ;
        LqryExecDetail.ExecSQL ;
      end ;

    except
      on E: EUniError do
      begin
        pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, '[TCarregaBandeirasTef.fPersistirBanco AItem]');
        raise ;
      end ;
    end ;
  finally
    FreeAndNil(LqryMaster) ;
    FreeAndNil(LqryExecDetail) ;
  end ;
  Result := True ;
end;

function TCarregaBandeirasTef.fPersistirBanco(const AVerificarRegistro: Boolean = False): Boolean;
var
  LItemBandeira: TItemBandeiraTef ;
  LInfo: TInfoTipoCartao ;
  LInfoBandeira: TInfoBandeira ;
  LstrInsertMaster: String ;
  LstrInsertDetail: String ;
  LqryExecMaster, LqryExecDetail, LqryConsulta: TUniQuery ;
  LstrAutoIncMaster: String ;
  LProxCodBan : String;
begin
  Result := True ;
  LstrInsertMaster := fMontaInsertMaster ;
  LstrInsertDetail := fMontaInsertDetail ;

  LqryExecMaster := fCriaQuery() ;
  LqryExecDetail := fCriaQuery() ;
  LqryConsulta   := fCriaQuery() ;
  try
    LqryExecMaster.Close ;
    LqryExecMaster.SQL.Clear ;
    LqryExecMaster.SQL.Add(LstrInsertMaster) ;

    LqryExecDetail.Close ;
    LqryExecDetail.SQL.Clear ;
    LqryExecDetail.SQL.Add(LstrInsertDetail) ;

    if AVerificarRegistro then
    begin
      LqryConsulta.Close ;
      LqryConsulta.SQL.Clear ;
      LqryConsulta.SQL.Add(' SELECT * FROM CADBND ') ;
      LqryConsulta.Open ;
    end ;

    for LItemBandeira in FlstBandeiras do
    begin

      if AVerificarRegistro and fEhRegistroCadastrado(LItemBandeira, LqryConsulta) then
        Continue ;

      LProxCodBan := TRegrasCadastroCartaoTef.fProximoCodigo('CADBAN', 'BAN_CODBAN') ;
      If fCampoTabela('BAN_CODBAN', 'CADBAN', ['BAN_CODBAN'], [LProxCodBan], True) <> LProxCodBan Then
      Begin
        LstrAutoIncMaster := fRetAutoIncrem('CADBAN', VS_strCodEmp) ;
        LqryExecMaster.ParamByName('AUTOINCREM').AsString := LstrAutoIncMaster ;
        LqryExecMaster.ParamByName('BAN_CODBAN').asString := LProxCodBan;
        LqryExecMaster.ParamByName('BAN_CODEMP').asString := VS_strCodEmp ;
        LqryExecMaster.ParamByName('BAN_NOMBAN').asString := LItemBandeira.Descricao ;
        LqryExecMaster.ExecSQL ;
        //detalhe
        for LInfo in LItemBandeira.ItensCodigo do
        begin
          LqryExecDetail.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CADBND', VS_strCodEmp) ;
          LqryExecDetail.ParamByName('BAN_SEQBAN').AsString := LstrAutoIncMaster ;
          LqryExecDetail.ParamByName('BAN_TIPCAR').AsString := TIPO_CARTAO[LInfo.Tipo] ;
          pClearParamByName(LqryExecDetail) ;
          for LInfoBandeira in LInfo.ItensBandeira do
            LqryExecDetail.ParamByName(COLUNAS_CADBND[LInfoBandeira.Fornecedor]).AsString := LInfoBandeira.CodigoBandeiraTef ;
          LqryExecDetail.ExecSQL ;
        end ;
      end
      else
      Begin
        Result := False;
        pMensagemOk('O código gerado para o próximo código de Bandeira('+LProxCodBan+') já existe no cadastro de Bandeira de Cartões, portanto não foi possível inserir uma nova Bandeira de Cartão!'+#13+#10+
                    'Ajuste na rotina "Próximos Códigos" o valor do campo "Próximo Código" para a tabela de Bandeira de Cartões(CADBAN)!') ;

        Break;
      End;
    end ;
  finally
    FreeAndNil(LqryExecMaster) ;
    FreeAndNil(LqryExecDetail) ;
    FreeAndNil(LqryConsulta) ;
  end ;
end;

procedure TCarregaBandeirasTef.pCarregaInfo;
var
  LItem: TItemBandeiraTef ;
  LintItemAdd: Integer ;
  LConsulta: TUniQuery ;
  LControle: TStringList ;
  LNomeBandeira: String ;
  LIndexControle: Integer ;
  LCnt: Integer ;
  LTipoCartao: TTipoCartao ;
begin

  LConsulta := fCriaQuery() ;
  LControle := TStringList.Create ;
  try
    LConsulta.Close ;
    LConsulta.SQL.Clear ;
    LConsulta.SQL.Add(' SELECT SUG_NOMBAN, SUG_TIPCAR, SUG_CODBAN, SUG_FORTEF ') ;
    LConsulta.SQL.Add(' FROM BANSUG ') ;
    LConsulta.SQL.Add(' ORDER BY SUG_NOMBAN, SUG_TIPCAR, SUG_FORTEF ') ;
    LConsulta.Open ;
    LConsulta.First ;
    while not LConsulta.Eof do
    begin
      LNomeBandeira := LConsulta.FieldByName('SUG_NOMBAN').AsString ;
      LIndexControle := LControle.IndexOf(LNomeBandeira) ;
      if LIndexControle < 0 then
      begin
        LItem := TItemBandeiraTef.Create(LNomeBandeira) ;
        LIndexControle := LControle.AddObject(LNomeBandeira, LItem) ;
      end ;
      LItem := LControle.Objects[LIndexControle] as TItemBandeiraTef ;
      LTipoCartao := TUtilCadastroCartaoTef.fGetTipoCartao(LConsulta.FieldByName('SUG_TIPCAR').AsString) ;
      LintItemAdd := LItem.fIndexOf(LTipoCartao) ;
      if LintItemAdd < 0 then
        LintItemAdd := LItem.fAdd(LTipoCartao) ;
      LItem.ItensCodigo[LintItemAdd].fAdd(LConsulta.FieldByName('SUG_CODBAN').AsString, TUtilCadastroCartaoTef.fGetFornecedor(LConsulta.FieldByName('SUG_FORTEF').AsString)) ;
      LConsulta.Next ;
    end ;

    for LCnt := 0 to LControle.Count-1 do
    begin
      LItem := LControle.Objects[LCnt] as TItemBandeiraTef ;
      self.FlstBandeiras.Add(LItem) ;
    end ;

  finally
    FreeAndNil(LConsulta) ;
    FreeAndNil(LControle) ;
  end ;

end;

procedure TCarregaBandeirasTef.pClearParamByName(AQry: TUniQuery);
var
  LintCnt: TFornecedorTef ;
begin
  for LintCnt := Low(TFornecedorTef) to High(TFornecedorTef) do
    AQry.ParamByName(COLUNAS_CADBND[LintCnt]).Clear ;
end;

class procedure TCarregaBandeirasTef.pPreparaColunasParams(var AstrColunas,
  AstrParams: String);
var
  LstrColunas, LstrParams: String ;
  LintCnt: TFornecedorTef ;
begin
  LstrColunas := '' ;
  LstrParams  := '' ;

  for LintCnt := Low(TFornecedorTef) to High(TFornecedorTef) do
  begin
    LstrColunas := LstrColunas + IfThen(fEmptyStr(LstrColunas), '', ',') + COLUNAS_CADBND[LintCnt] ;
    LstrParams := LstrParams + IfThen(fEmptyStr(LstrParams), '', ',') + ':' + COLUNAS_CADBND[LintCnt] ;
  end ;

  AstrColunas := LstrColunas ;
  AstrParams  := LstrParams ;
end;

{ TItemAdquirenteTef }

constructor TItemAdquirenteTef.Create(const AstrDescricao: String);
begin
  Self.FstrDescricao := AstrDescricao ;
  FItensCodigo := TListInfoAdquirente.Create() ;
end;

destructor TItemAdquirenteTef.Destroy;
begin
  FreeAndNil(FItensCodigo) ;
  inherited;
end;

function TItemAdquirenteTef.fAdd(const AstrCodigo: String;
  const AftFornecedor: TFornecedorTef): Integer;
var
  LCodigos: TinfoAdquirente ;
begin
  LCodigos := TinfoAdquirente.Create ;
  LCodigos.CodigoAdquirenteTef := AstrCodigo ;
  LCodigos.Fornecedor := AftFornecedor ;
  Result := Self.FItensCodigo.Add(LCodigos) ;
end;

{ TCarregaAdquirentesTef }

constructor TCarregaAdquirentesTef.Create;
begin
  FlstAdquirentes := TListAdquirenteTef.Create ;
  Self.pCarregaInfo() ;
end;

destructor TCarregaAdquirentesTef.Destroy;
begin
  FreeAndNil(FlstAdquirentes) ;
  inherited;
end;

function TCarregaAdquirentesTef.fEhRegistroCadastrado(
  const AItemAdquirente: TItemAdquirenteTef;
  const AConsulta: TUniQuery): Boolean;
var
  LInfoAdquirente: TinfoAdquirente ;
  LstrValor: String ;
begin
  Result := False  ;
  for LInfoAdquirente in AItemAdquirente.ItensCodigo do
  begin
    LstrValor := LInfoAdquirente.CodigoAdquirenteTef ;
    if not fEmptyStr(LstrValor) then
    begin
      if AConsulta.Locate(COLUNAS_CDADQC[LInfoAdquirente.Fornecedor], LstrValor, [loCaseInsensitive]) then
      begin
        Result := True ;
        break ;
      end ;
    end ;
  end ;
end;

function TCarregaAdquirentesTef.fMontaInsert: String;
var
  LstrColunas, LstrParams: String ;
begin
  pPreparaColunasParams(LstrColunas, LstrParams) ;
  Result := 'INSERT INTO CDADQC (AUTOINCREM, ADQ_CODADQ, ADQ_NOMADQ, ' + LstrColunas + ') VALUES (:AUTOINCREM, :ADQ_CODADQ, :ADQ_NOMADQ, ' + LstrParams + ') ;' ;
end;

function TCarregaAdquirentesTef.fMontaUpdate: String;
var
  LstrComandoSql: String ;
  LstrColunas, LstrParams: String ;
  LlstColunas, LlstParams: TStringList ;
  LintCnt: Integer ;
  LstrSetUpdate: String ;
begin
  pPreparaColunasParams(LstrColunas, LstrParams) ;
  LlstColunas := TStringList.Create ;
  LlstParams  := TStringList.Create ;
  try
    LlstColunas.StrictDelimiter := True ;
    LlstColunas.Delimiter := ',' ;
    LlstColunas.DelimitedText := LstrColunas ;

    LlstParams.StrictDelimiter := True ;
    LlstParams.Delimiter := ',' ;
    LlstParams.DelimitedText := LstrParams ;

    LstrSetUpdate := '' ;
    for LintCnt := 0 to LlstColunas.Count -1 do
      LstrSetUpdate := LstrSetUpdate + IfThen(fEmptyStr(LstrSetUpdate), '', ',') + Trim(LlstColunas.Strings[LintCnt]) + '=' + Trim(LlstParams.Strings[LintCnt]) ;

  finally
    FreeAndNil(LlstColunas) ;
    FreeAndNil(LlstParams) ;
  end ;

  LstrComandoSql := 'UPDATE CDADQC SET ADQ_NOMADQ = :ADQ_NOMADQ, ' + LstrSetUpdate + ' WHERE AUTOINCREM = :AUTOINCREM ' ;

  Result := LstrComandoSql ;
end;

function TCarregaAdquirentesTef.fPersistirBanco(
  const AItem: TItemAdquirenteTef; const AAutoInc, ADescricao: String): Boolean;
var
  LstrUpdate: String ;
  LqryExec: TUniQuery ;
  LInfo: TinfoAdquirente ;
begin
  LstrUpdate := fMontaUpdate ;
  LqryExec := fCriaQuery() ;
  try
    try
      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add(LstrUpdate) ;
      LqryExec.ParamByName('AUTOINCREM').AsString := AAutoInc ;
      LqryExec.ParamByName('ADQ_NOMADQ').AsString := AItem.Descricao ;
      pClearParamByName(LqryExec) ;
      for LInfo in AItem.ItensCodigo do
        LqryExec.ParamByName(COLUNAS_CDADQC[LInfo.Fornecedor]).AsString := LInfo.CodigoAdquirenteTef ;
      LqryExec.ExecSQL ;
    except
      on E: EUniError do
      begin
        pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, '[TCarregaAdquirentesTef.fPersistirBanco AItem]');
        raise ;
      end ;
    end ;
  finally
    FreeAndNil(LqryExec) ;
  end ;
  Result := True ;
end;

function TCarregaAdquirentesTef.fPersistirBanco(const AVerificarRegistro: Boolean = False): Boolean;
var
  LItemAdq: TItemAdquirenteTef ;
  LInfo: TinfoAdquirente ;
  LstrInsert: String ;
  LqryExec, LqryConsulta: TUniQuery ;
  LProxCodAdq : String;
begin
  Result := True ;
  LstrInsert := fMontaInsert ;
  LqryExec := fCriaQuery() ;
  LqryConsulta := fCriaQuery() ;
  try
    LqryExec.Close ;
    LqryExec.SQL.Clear ;
    LqryExec.SQL.Add(LstrInsert) ;

    if AVerificarRegistro then
    begin
      LqryConsulta.Close ;
      LqryConsulta.SQL.Clear ;
      LqryConsulta.SQL.Add(' SELECT * FROM CDADQC ') ;
      LqryConsulta.Open ;
    end ;

    for LItemAdq in FlstAdquirentes do
    begin

      if AVerificarRegistro and fEhRegistroCadastrado(LItemAdq, LqryConsulta) then
        Continue ;

      LProxCodAdq := TRegrasCadastroCartaoTef.fProximoCodigo('CDADQC', 'ADQ_CODADQ') ;

      If fCampoTabela('ADQ_CODADQ', 'CDADQC', ['ADQ_CODADQ'], [LProxCodAdq], True) <> LProxCodAdq Then
      Begin
        LqryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CDADQC', VS_strCodEmp) ;
        LqryExec.ParamByName('ADQ_CODADQ').asString := LProxCodAdq;
        LqryExec.ParamByName('ADQ_NOMADQ').AsString := LItemAdq.Descricao ;
        pClearParamByName(LqryExec) ;
        for LInfo in LItemAdq.ItensCodigo do
          LqryExec.ParamByName(COLUNAS_CDADQC[LInfo.Fornecedor]).AsString := LInfo.CodigoAdquirenteTef ;
        LqryExec.ExecSQL ;
      End
      else
      Begin
        Result := False;
        pMensagemOk('O código gerado para o próximo código de Adquirente('+LProxCodAdq+') já existe no cadastro de Adquirentes, portanto não foi possível inserir um novo Adquirente!'+#13+#10+
                    'Ajuste na rotina "Próximos Códigos" o valor do campo "Próximo Código" para a tabela de Adquirente(CDADQC)!') ;

        Break;
      End;
    end ;
  finally
    FreeAndNil(LqryExec) ;
    FreeAndNil(LqryConsulta) ;
  end ;
end;

procedure TCarregaAdquirentesTef.pCarregaInfo;
var
  LItem: TItemAdquirenteTef ;
  LConsulta: TUniQuery ;
  LControle: TStringList ;
  LNomeAdq: String ;
  LIndexControle: Integer ;
  LCnt: Integer ;
begin
  LConsulta := fCriaQuery() ;
  LControle := TStringList.Create ;
  try
    LConsulta.Close ;
    LConsulta.SQL.Clear ;
    LConsulta.SQL.Add(' SELECT SUG_NOMADQ, SUG_CODADQ, SUG_FORTEF ') ;
    LConsulta.SQL.Add(' FROM ADQSUG ') ;
    LConsulta.SQL.Add(' ORDER BY SUG_NOMADQ, SUG_FORTEF ') ;
    LConsulta.Open ;
    LConsulta.First ;
    while not LConsulta.Eof do
    begin
      LNomeAdq := LConsulta.FieldByName('SUG_NOMADQ').AsString ;
      LIndexControle := LControle.IndexOf(LNomeAdq) ;
      if LIndexControle < 0 then
      begin
        LItem := TItemAdquirenteTef.Create(LNomeAdq) ;
        LIndexControle := LControle.AddObject(LNomeAdq, LItem) ;
      end ;
      LItem := LControle.Objects[LIndexControle] as TItemAdquirenteTef ;
      LItem.fAdd(LConsulta.FieldByName('SUG_CODADQ').AsString, TUtilCadastroCartaoTef.fGetFornecedor(LConsulta.FieldByName('SUG_FORTEF').AsString)) ;
      LConsulta.Next ;
    end ;

    for LCnt := 0 to LControle.Count-1 do
    begin
      LItem := LControle.Objects[LCnt] as TItemAdquirenteTef ;
      self.FlstAdquirentes.Add(LItem) ;
    end ;

  finally
    FreeAndNil(LConsulta) ;
    FreeAndNil(LControle) ;
  end ;

end;

procedure TCarregaAdquirentesTef.pClearParamByName(AQry: TUniQuery);
var
  LintCnt: TFornecedorTef ;
begin
  for LintCnt := Low(TFornecedorTef) to High(TFornecedorTef) do
    AQry.ParamByName(COLUNAS_CDADQC[LintCnt]).Clear ;
end;

class procedure TCarregaAdquirentesTef.pPreparaColunasParams(var AstrColunas,
  AstrParams: String);
var
  LstrColunas, LstrParams: String ;
  LintCnt: TFornecedorTef ;
begin
  LstrColunas := '' ;
  LstrParams  := '' ;

  for LintCnt := Low(TFornecedorTef) to High(TFornecedorTef) do
  begin
    LstrColunas := LstrColunas + IfThen(fEmptyStr(LstrColunas), '', ',') + COLUNAS_CDADQC[LintCnt] ;
    LstrParams := LstrParams + IfThen(fEmptyStr(LstrParams), '', ',') + ':' + COLUNAS_CDADQC[LintCnt] ;
  end ;

  AstrColunas := LstrColunas ;
  AstrParams  := LstrParams ;
end;

{ TInfoTipoCartao }

constructor TInfoTipoCartao.Create;
begin
  FItensCodigo := TListInfoBandeira.Create ;
end;

destructor TInfoTipoCartao.Destroy;
begin
  FreeAndNil(FItensCodigo) ;
  inherited;
end;

function TInfoTipoCartao.fAdd(const AstrCodigo: String;
  const AftFornecedor: TFornecedorTef): integer;
var
  LInfo: TInfoBandeira ;
begin
  LInfo := TInfoBandeira.Create ;
  LInfo.CodigoBandeiraTef := AstrCodigo ;
  LInfo.Fornecedor := AftFornecedor ;

  Result := FItensCodigo.Add(LInfo) ;
end;

{ TUtilCadastroCartaoTef }

class function TUtilCadastroCartaoTef.fGetFornecedor: TFornecedorTef;
var
  LstrFornecedorTef: String ;
begin
  LstrFornecedorTef := fCfgSis('TEFCIT') ;
  Result := Self.fGetFornecedor(LstrFornecedorTef) ;
end;

class function TUtilCadastroCartaoTef.fAdquirenteModoPos(
  const ACodAdq: String): Boolean;
begin
  Result := fCampoTabela('ADQ_MODPOS', 'CDADQC', ['ADQ_CODADQ'], [ACodAdq], False) = 'S';
end;

class function TUtilCadastroCartaoTef.fGetFornecedor(
  const AFornecedor: String): TFornecedorTef;
begin
  Result := ftClisitef ; //default
  if AFornecedor = 'S' then
    Result := ftClisitef
  else if AFornecedor = 'T' then
    Result := ftScope ;
end;

class function TUtilCadastroCartaoTef.fGetTipoCartao(
  const AstrTipoCartao: String): TTipoCartao;
begin
  Result := tcCredito ; //default
  if AstrTipoCartao = 'C' then
    Result := tcCredito
  else if AstrTipoCartao = 'D' then
    Result := tcDebito ;
end;

class function TUtilCadastroCartaoTef.fGetTipoCartaoToStr(
  const ATipoCartao: TTipoCartao): String;
begin
  Result := 'C' ; //default

  case ATipoCartao of
    tcCredito: Result:= 'C';
    tcDebito: Result:= 'D'
  end;
end;

class function TUtilCadastroCartaoTef.fInformaOperadorCartaoEncontrado: Boolean;
begin
  Result := fCadastroCartaoParamAutTef ;
  if Result then
    pMensagemOk('O cartão utilizado neste TEF não foi localizado no Cadastro de Cartões!'+#13+#10+
                'Pesquise um cartão para dar sequencia na transação') ;
end;

class function TUtilCadastroCartaoTef.fPossuiDadosInvalidos(
  const AParam: TParamEntradaValidacao; out AMensagem: String): Boolean;
var
  LAdqPos: Boolean ;
begin
  Result := True;
  AMensagem := '';
  if (not AParam.TipoPos) and (not AParam.TipoTef) then
  begin
    AMensagem := 'Selecione pelo menos um "Tipo de Transação"!';
    Exit ;
  end;

  if AParam.TipoTef then
  begin
    LAdqPos := TUtilCadastroCartaoTef.fAdquirenteModoPos(AParam.CodAdq) ;
    if LAdqPos then
    begin
      AMensagem := 'Adquirente ['+ AParam.CodAdq + '-' + AParam.NomAdq + '] configurada para ser usada em apenas POS.' + sLineBreak + 'Verificar o cadastro de Adquirente.';
      Exit;
    end ;

    if TUtilCadastroCartaoTef.fGetFornecedor = ftClisitef then
    begin
      if not fEmptyStr(AParam.NomAdq) then
      begin
        if fEmptyStr(AParam.TefCodAdqClisitef) then
        begin
          AMensagem := 'Código da Operadora não encontrado para a Adquirente selecionada. Verificar o cadastro de Adquirente.';
          Exit;
        end;
      end;
      if not fEmptyStr(AParam.NomBan) then
      begin
        if fEmptyStr(AParam.TefCodBanClisitef) then
        begin
          AMensagem := 'Código da Bandeira não encontrado para a Bandeira selecionada. Verificar o cadastro de Bandeira.';
          Exit;
        end;
      end;
    end
    else if TUtilCadastroCartaoTef.fGetFornecedor = ftScope then
    begin
      if not fEmptyStr(AParam.NomAdq) then
      begin
        if fEmptyStr(AParam.TefCodAdqScope) then
        begin
          AMensagem := 'Código da Operadora não encontrado para a Adquirente selecionada. Verificar o cadastro de Adquirente.';
          Exit;
        end;
      end;
      if not fEmptyStr(AParam.NomBan) then
      begin
        if fEmptyStr(AParam.TefCodBanScope) then
        begin
          AMensagem := 'Código da Bandeira não encontrado para a Bandeira selecionada. Verificar o cadastro de Bandeira.';
          Exit;
        end;
      end;
    end;
  end;
  Result := False;
end;

{ TRetornoDadosCartaoTef }

class function TRetornoDadosCartaoTef.fRetornaCodigoCartao(
  const AFiltro: TParamEntradaPesquisaCartao): TRetornoPesquisaCartao;
begin
  FillChar(Result, SizeOf(TRetornoPesquisaCartao), #0) ;
  FqryConsulta := fCriaQuery() ;
  try
    pAbrirConsulta(tpaEmpresa, AFiltro);

    If (FqryConsulta.IsEmpty) Then
    begin
      pAbrirConsulta(tpaEmpresaNull, AFiltro);
      If (FqryConsulta.IsEmpty) Then
        pAbrirConsulta(tpaEmpresaNotNull, AFiltro);
    end ;

    Result.codigo_empresa := FqryConsulta.FieldByName('CAR_CODEMP').AsString ;
    Result.codigo_cartao := FqryConsulta.FieldByName('CAR_CODCAR').AsString ;
  finally
    FreeAndNil(FqryConsulta) ;
  end ;
end;

class procedure TRetornoDadosCartaoTef.pAbrirConsulta(
  const AtpacBusca: TTipoPesquisaAmarrarCartao;
  const AFiltro: TParamEntradaPesquisaCartao);
begin
  FqryConsulta.Close ;
  FqryConsulta.SQL.Clear ;
  FqryConsulta.SQL.Add(' SELECT ') ;
  FqryConsulta.SQL.Add('   CADCAR.CAR_CODEMP, ') ;
  FqryConsulta.SQL.Add('   CADCAR.CAR_CODCAR ') ;
  FqryConsulta.SQL.Add(' FROM CADCAR ') ;
  FqryConsulta.SQL.Add('    INNER JOIN CDADQC ON CADCAR.CAR_CODADQ = CDADQC.ADQ_CODADQ ') ;
  FqryConsulta.SQL.Add('    INNER JOIN CADBAN ON CADCAR.CAR_CODBAN = CADBAN.BAN_CODBAN ') ;
  FqryConsulta.SQL.Add('    INNER JOIN CADBND ON CADBAN.AUTOINCREM = CADBND.BAN_SEQBAN AND CADBND.BAN_TIPCAR = CADCAR.CAR_TIPCAR ') ;
  FqryConsulta.SQL.Add(' WHERE CAR_STATUS = "S" AND CAR_TIPTEF = "S" AND ') ;
  FqryConsulta.SQL.Add('     CDADQC.' + COLUNAS_CDADQC[TUtilCadastroCartaoTef.fGetFornecedor()] + ' = :TFTRED AND ') ;
  FqryConsulta.SQL.Add('     CADBND.' + COLUNAS_CADBND[TUtilCadastroCartaoTef.fGetFornecedor()] + ' = :TFTBAN AND ') ;
  FqryConsulta.SQL.Add('     CADCAR.CAR_TIPCAR = :TIPCAR AND ') ;
  FqryConsulta.ParamByName('TFTRED').AsString := AFiltro.codigo_rede ;
  FqryConsulta.ParamByName('TFTBAN').AsString := AFiltro.codigo_bandeira ;
  FqryConsulta.ParamByName('TIPCAR').AsString := TIPO_CARTAO[AFiltro.tipo_cartao] ;
  FqryConsulta.SQL.Add(' :QTDPAR BETWEEN CADCAR.CAR_SUGPAR AND CADCAR.CAR_MAXPAR AND ');
  FqryConsulta.ParamByName('QTDPAR').AsInteger := AFiltro.parcela ;
  If AtpacBusca = tpaEmpresa Then
  begin
    FqryConsulta.SQL.Add(' CADCAR.CAR_CODEMP = :CODEMP AND  ');
    FqryConsulta.ParamByName('CODEMP').AsString := AFiltro.codigo_empresa ;
  end
  else If AtpacBusca = tpaEmpresaNull Then
    FqryConsulta.SQL.Add(' CADCAR.CAR_CODEMP IS NULL AND ')
  else If AtpacBusca = tpaEmpresaNotNull Then
    FqryConsulta.SQL.Add(' CADCAR.CAR_CODEMP IS NOT NULL AND ') ;

  FqryConsulta.SQL.Add('   COALESCE(CAR_CARDSE, "") =  :CARDSE AND ');
  FqryConsulta.SQL.Add('   COALESCE(CAR_TIPDEB, "0") = :TIPDEB ');
  FqryConsulta.ParamByName('CARDSE').AsString := AFiltro.codigo_cardse;
  FqryConsulta.ParamByName('TIPDEB').AsString := AFiltro.tipo_debito;

  FqryConsulta.SQL.Add(' ORDER BY CADCAR.CAR_MAXPAR, CADCAR.CAR_CODEMP ');
  FqryConsulta.Open ;
end;

{ TTRegrasCartaoTefService }

class function TTRegrasCartaoTefService.fDadosTransacaoCartao(
  const AEntrada: TParamEntradaDadosTef; out ARetorno: TParamSaidaDadosTef): Boolean;
var
  LPesquisa: TParamEntradaDadosTef;
begin
  FillChar(LPesquisa, Sizeof(TParamEntradaDadosTef), #0);

  LPesquisa.codigo_bandeira   := AEntrada.codigo_bandeira;
  LPesquisa.codigo_adquirente := AEntrada.codigo_adquirente;
  LPesquisa.parcela_minima    := AEntrada.parcela_minima;
  LPesquisa.parcela_maxima    := AEntrada.parcela_maxima;
  LPesquisa.tipo_cartao       := AEntrada.tipo_cartao;
  LPesquisa.tipo_transacao    := AEntrada.tipo_transacao;

  Result := TRegrasCadastroCartaoTef.fDadosTransacaoCartao(LPesquisa, ARetorno);
end;

class function TTRegrasCartaoTefService.fGetText(AEdit: TEdit;
  AFieldName: string; ADataSet: TDataSet): string;
begin
  Result := '';

  if Trim(AEdit.Text) <> '' then
  begin
    Result := AEdit.Text;
    exit;
  end;

  if Assigned(ADataSet) then
    Result := ADataSet.FieldByName(AFieldName).AsString;
end;

class function TTRegrasCartaoTefService.fTFornecedorTefToStr(
  AFornecedorTef: TFornecedorTef): String;
begin
  case AFornecedorTef of
    ftClisitef: Result:= 'Clisitef';
    ftScope: Result:= 'Conexão Tech-Scope';
  end;
end;

class function TTRegrasCartaoTefService.fValidaRegrasRetorno(
  AFornecedorTef: TFornecedorTef; const ARetorno: TParamSaidaDadosTef;
  APesquisa: TParamEntradaDadosTef;
  ATipoValidacao: TTipoValidacao;
  out AMensagem: String): Boolean;
var
  LValorRede: string;
  LValorBandeira: string;
begin
  Result:= True;

  LValorRede:= ARetorno.codigos[AFornecedorTef].codigo_rede;
  LValorBandeira:= ARetorno.codigos[AFornecedorTef].codigo_bandeira;

  if APesquisa.pos_adquirente then
    Exit ;

  if (ATipoValidacao = tvAdquirente) then
  begin
    if fEmptyStr(APesquisa.codigo_adquirente) then
      Exit;

    if fEmptyStr(LValorRede) then
    begin
      AMensagem := TTRegrasCartaoTefService.fTFornecedorTefToStr(AFornecedorTef) +
                   ': Código da Operadora não encontrado para o cadastro da Adquirente: ' +
                   APesquisa.codigo_adquirente + ' Verificar o cadastro de Adquirente.';
      exit(False);
    end;
    Exit;
  end;

  if (ATipoValidacao = tvBandeira) then
  begin
    if fEmptyStr(APesquisa.codigo_bandeira) then
      Exit;

    if fEmptyStr(LValorBandeira) then
    begin
      AMensagem := TTRegrasCartaoTefService.fTFornecedorTefToStr(AFornecedorTef) +
                   ': Código da Bandeira não encontrado para o cadastro da Bandeira: ' +
                   APesquisa.codigo_Bandeira + ' Verificar o cadastro de Bandeira.';
      exit(False);
    end;
  end;
end;

end.
