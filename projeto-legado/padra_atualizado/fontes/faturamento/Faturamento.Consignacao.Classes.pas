unit Faturamento.Consignacao.Classes;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Windows, Forms, Buttons, Menus, frxClass,
  untFuncoesSimples, UniClientDataSet, untFuncoes,
{$ENDIF}
  Classes, Uni, Data.DB, System.Generics.Collections,
  System.SysUtils, System.StrUtils, untFuncFatTypes,
  System.Variants, untCadRec;

Type
  TFncReformaDoRetornoPeloEnvio = reference to function (var AMensagem: String) : Boolean;

  TValoresReformaItemRetorno = record
    fltBase   : Double;
    fltBaseIs : Double;
    fltCbs    : Double;
    fltIbs    : Double;
    fltIs     : Double;
  end;

  tTipoRetornoConsignacao = (ttrImportacaoXML, ttrEntradaManual);

  TRetornoConsignacaoDetalhe = class
  private
    FNumeroDoDocumentoDoEnvio,
    FEspecieDoDocumentoDoEnvio,
    FEmpresaDoDocumentoDoEnvio,
    FCodigoItemEnvio,
    FNumeroDoDocumentoDoFaturamento,
    FEspecieDoDocumentoDoFaturamento,
    FEmpresaDoDocumentoDoFaturamento,
    FCodigoProdutoAcabado,
    FIdMovDetFaturamento,
    FIdMovDetEnvio        : String;
    FQuantidadeFaturada,
    FQuantidadeRetornada : Double;
  public
    property NumeroDoDocumentoDoEnvio        : String read FNumeroDoDocumentoDoEnvio        write FNumeroDoDocumentoDoEnvio;
    property EspecieDoDocumentoDoEnvio       : String read FEspecieDoDocumentoDoEnvio       write FEspecieDoDocumentoDoEnvio;
    property EmpresaDoDocumentoDoEnvio       : String read FEmpresaDoDocumentoDoEnvio       write FEmpresaDoDocumentoDoEnvio;
    property CodigoItemEnvio                 : String read FCodigoItemEnvio                 write FCodigoItemEnvio;
    property NumeroDoDocumentoDoFaturamento  : String read FNumeroDoDocumentoDoFaturamento  write FNumeroDoDocumentoDoFaturamento;
    property EspecieDoDocumentoDoFaturamento : String read FEspecieDoDocumentoDoFaturamento write FEspecieDoDocumentoDoFaturamento;
    property EmpresaDoDocumentoDoFaturamento : String read FEmpresaDoDocumentoDoFaturamento write FEmpresaDoDocumentoDoFaturamento;
    property QuantidadeFaturada              : Double read FQuantidadeFaturada              write FQuantidadeFaturada;
    property QuantidadeRetornada             : Double read FQuantidadeRetornada             write FQuantidadeRetornada;
    property CodigoProdutoAcabado            : String read FCodigoProdutoAcabado            write FCodigoProdutoAcabado;
    property IdMovDetFaturamento             : String read FIdMovDetFaturamento             write FIdMovDetFaturamento;
    property IdMovDetEnvio                   : String read FIdMovDetEnvio                   write FIdMovDetEnvio;
  end;


  TRetornoConsignacao = class
  private
    FNumeroDoDocumentoDoFaturamento,
    FEspecieDoDocumentoDoFaturamento,
    FEmpresaDoDocumentoDoFaturamento,
    FSerieDoDocumentoDoFaturamento,
    FNumeroDoDocumentoDoRetorno,
    FEspecieDoDocumentoDoRetorno,
    FEmpresaDoDocumentoDoRetorno,
    FSerieDoDocumentoDoRetorno,
    FClienteDoDocumentoDoRetorno: String;
  public
    property NumeroDoDocumentoDoFaturamento    : String read FNumeroDoDocumentoDoFaturamento  write FNumeroDoDocumentoDoFaturamento;
    property EspecieDoDocumentoDoFaturamento   : String read FEspecieDoDocumentoDoFaturamento write FEspecieDoDocumentoDoFaturamento;
    property EmpresaDoDocumentoDoFaturamento   : String read FEmpresaDoDocumentoDoFaturamento write FEmpresaDoDocumentoDoFaturamento;
    property SerieDoDocumentoDoFaturamento     : String read FSerieDoDocumentoDoFaturamento   write FSerieDoDocumentoDoFaturamento;
    property NumeroDoDocumentoDoRetorno        : String read FNumeroDoDocumentoDoRetorno      write FNumeroDoDocumentoDoRetorno;
    property EspecieDoDocumentoDoRetorno       : String read FEspecieDoDocumentoDoRetorno     write FEspecieDoDocumentoDoRetorno;
    property EmpresaDoDocumentoDoRetorno       : String read FEmpresaDoDocumentoDoRetorno     write FEmpresaDoDocumentoDoRetorno;
    property SerieDoDocumentoDoRetorno         : String read FSerieDoDocumentoDoRetorno       write FSerieDoDocumentoDoRetorno;
    property ClienteDoDocumentoDoRetorno       : String read FClienteDoDocumentoDoRetorno     write FClienteDoDocumentoDoRetorno;
  end;

  TRetornoConsignacaoRepositorio = class
  private
    function fCarregarRetornosDaConsignacaoFaturada(ADocumentoDoFaturamento, AEspecieDoFaturameto, AEmpresaDoFaturamento, ASerieDoFaturamento : String) : TList<TRetornoConsignacao>;
    function fSalvar(ARetornoConsignacao : TRetornoConsignacao; var AMensagem : String) : Boolean;
  end;

  TRetornoConsignacaoDetalheRepositorio = class
  private
    function fSalvar(ARetornoConsignacaoDetalhe : TRetornoConsignacaoDetalhe; var AMensagem : String) : Boolean;
    procedure pApagarConsignacaoRetornoDetalhe(ANumeroDoDocumentoDoFaturamento, AEspecieDoDocumentoDoFaturamento,
      AEmpresaDoDocumentoDoFaturamento, AstrNomeFormulario : String);
  end;

  TRetornoConsignacaoBuilder = class
    FObjRetornoConsignacaoRepositorio : TRetornoConsignacaoRepositorio;
    FObjRetornoConsignacaoDetalheRepositorio : TRetornoConsignacaoDetalheRepositorio;
    FObjRetornoConsignacaoList : TList<TRetornoConsignacao>;
    FObjRetornoConsignacaoDetalheList : TList<TRetornoConsignacaoDetalhe>;
    FNumeroDoDocumentoDoFaturamento,
    FEspecieDoDocumentoDoFaturamento,
    FEmpresaDoDocumentoDoFaturamento,
    FSerieDoDocumentoDoFaturamento,
    FNumeroDoDocumentoDoRetorno,
    FEspecieDoDocumentoDoRetorno,
    FEmpresaDoDocumentoDoRetorno,
    FSerieDoDocumentoDoRetorno,
    FClienteDoDocumentoDoRetorno,
    FNumeroDoDocumentoDoEnvio,
    FEspecieDoDocumentoDoEnvio,
    FEmpresaDoDocumentoDoEnvio,
    FCodigoItemEnvio,
    FCodigoProdutoAcabado,
    FIdMovDetEnvio   : String;
    FQuantidadeFaturada,
    FQuantidadeRetornada : Double;
    FMatrizItens : TMatrizFechamento;
    FDicionarioObjeto : TDicionario;
    FcdsProporcaoNotaCosignacao : TUniClientDataSet;
    FTipoRetornoConsignacao : tTipoRetornoConsignacao;
    LQueryNotaGerada,
    LQueryNotaDoEnvio   : TUniQuery;
    FCodigoCliente : String;
    FblnEhDevolucaoSimbolica : Boolean;
    FcdsItensDoEnvio : TUniClientDataSet;
    FSequenciaConciliacaoFinanceiro : Integer;
    
    procedure pLimparCampos;
    procedure pAtualizarAutoIncremDoFaturamento;
    procedure pZerarImpostos(AintIndice : Integer);
    function fGravarReformaDoRetornoPeloEnvio(var AMensagem : String) : Boolean;
    function fValoresReformaDoItemGravado(const AstrSeqGer : String) : TValoresReformaItemRetorno;
    procedure pAjustarRetornoGravadoPelaReforma(const AstrSeqGer : String; const AAntes, ADepois : TValoresReformaItemRetorno);
    function fCriarcdsProporcaoNotaCosignacao : TUniClientDataSet;
    function fCriarcdsProporcaoNotaCosignacaoParaFinanceiro : TUniClientDataSet;
    function fGerarProporcaoDoRetornoDaConsignacao(AcdsEnvio : TUniClientDataSet; AQueryNotaGerada : TUniQuery; var AMensagem : String) : Boolean;
    procedure pAlimentarCdsProporcaoNotaConsignacao(AcdsEnvio : TUniClientDataSet; AfltQuantidade : Double; AstrIDMovDetGerado : String);
    function fGravarFinanceiroDoRetorno(var AMensagem : String) : Boolean;
    function fGravarMovimentoConsignacaoDoRetorno(var AMensagem : String) : Boolean;
    function fSQLNotaGeradaNoRetornoConsignacao : String;
    function fSQLNotaEnviadaDaConsignacao(AblnParaDefinicaoDeItens : Boolean = False) : String;

    {$IFNDEF LINUX}
    function fGerarRetornoConsignacaoViaImportacaoXML(var AMensagem : String) : Boolean;
    function fGerarRetornoConsignacaoViaDigitacaoManual(var AMensagem : String) : Boolean;
    function fFaturaConsignacao(var AMensagem : String) : Boolean;
    function fProcessarDevolucaoSimbolica(var AMensagem : String; const AFcnReforma : TFncReformaDoRetornoPeloEnvio) : Boolean;
    function fProcessarRetornoConsignacao(var AMensagem : String) : Boolean;
    function fTratarDefinicaoItensDoRetorno(var AMensagem : String) : Boolean;
    {$ENDIF}

    function fProcessarDevolucaoDefinitiva(var AMensagem : String; const AFcnReforma : TFncReformaDoRetornoPeloEnvio) : Boolean;
    function fGeraCONDEV(var AMensagem : String) : Boolean;

    procedure pRemoverNotaGeradaNoRetornoDaConsignacao;
    class procedure pLimparReferenciaComXMLImportado(const AstrNumeroDocumento, AstrEspecieDocumento, AstrEmpresaDocumento,
      AstrCliFor, AstrSerieSel: String);

    class function fRetornaChaveReferenciada(strAutInc, strCodIte: String): String;
  public
    constructor Create;
    destructor Destroy; override;
    function fAdiconarDocumento(var AMensagem : String) : Boolean;
    function fAdiconarDocumentoDetalhe(var AMensagem : String) : Boolean;
    procedure pApagarConsignacaoRetornoDetalhe(AstrNomeFormulario : String);
    procedure pCarregarRetornosDaConsignacaoFaturada(ADocumentoDoFaturamento, AEspecieDoFaturameto, AEmpresaDoFaturamento, ASerieDoFaturamento  : String);
    function fSalvar(var AMensagem : String)  : Boolean;
    procedure pLimparLista;
    procedure pCalcularImpostosProporcionalPelaNotaEnvio(AintIndice : Integer);

   {$IFNDEF LINUX}
    class function fDefineLoteParaRetornoConsignacaoViaXML(AstrIdDetEle, AstrCodigoItem : String;
      var AstrLote, AMensagem : String) : Boolean;
    function fGerarRetornoConsignacao(var AMensagem : String) : Boolean;
   {$ENDIF}

    class function fAtualizaCONDEV(AstrIdEnvioConsignacao : String; AfltValorMovimentado : Double; var AMensagem : String) : Boolean;
    class procedure pLimparFaturamentoDevolucaoSimbolica(const AstrNumeroDocumento, AstrEspecieDocumento, AstrEmpresaDocumento : String);
    class function fPermitidoCancelarNotaDevolucaoSimbolica(const AstrNumeroDocumento, AstrEspecieDocumento, AstrEmpresaDocumento : String;
      var AstrMensagem : String) : Boolean;
    class procedure pCancelarDevolucaoSimbolica(const AstrNumeroDocumento, AstrEspecieDocumento, AstrEmpresaDocumento, AstrCliFor, AstrSerieSel : String);
    class function RetornaChaveReferenciada(ACodCli: String; ANumDoc: String; ATipXML: Integer): String;

    property NumeroDoDocumentoDoFaturamento    : String                     read FNumeroDoDocumentoDoFaturamento  write FNumeroDoDocumentoDoFaturamento;
    property EspecieDoDocumentoDoFaturamento   : String                     read FEspecieDoDocumentoDoFaturamento write FEspecieDoDocumentoDoFaturamento;
    property EmpresaDoDocumentoDoFaturamento   : String                     read FEmpresaDoDocumentoDoFaturamento write FEmpresaDoDocumentoDoFaturamento;
    property SerieDoDocumentoDoFaturamento     : String                     read FSerieDoDocumentoDoFaturamento   write FSerieDoDocumentoDoFaturamento;
    property NumeroDoDocumentoDoRetorno        : String                     read FNumeroDoDocumentoDoRetorno      write FNumeroDoDocumentoDoRetorno;
    property EspecieDoDocumentoDoRetorno       : String                     read FEspecieDoDocumentoDoRetorno     write FEspecieDoDocumentoDoRetorno;
    property EmpresaDoDocumentoDoRetorno       : String                     read FEmpresaDoDocumentoDoRetorno     write FEmpresaDoDocumentoDoRetorno;
    property SerieDoDocumentoDoRetorno         : String                     read FSerieDoDocumentoDoRetorno       write FSerieDoDocumentoDoRetorno;
    property ClienteDoDocumentoDoRetorno       : String                     read FClienteDoDocumentoDoRetorno     write FClienteDoDocumentoDoRetorno;
    property ObjRetornoConsignacaoList         : TList<TRetornoConsignacao> read FObjRetornoConsignacaoList;
    property NumeroDoDocumentoDoEnvio          : String                     read FNumeroDoDocumentoDoEnvio        write FNumeroDoDocumentoDoEnvio;
    property EspecieDoDocumentoDoEnvio         : String                     read FEspecieDoDocumentoDoEnvio       write FEspecieDoDocumentoDoEnvio;
    property EmpresaDoDocumentoDoEnvio         : String                     read FEmpresaDoDocumentoDoEnvio       write FEmpresaDoDocumentoDoEnvio;
    property CodigoItemEnvio                   : String                     read FCodigoItemEnvio                 write FCodigoItemEnvio;
    property CodigoProdutoAcabado              : String                     read FCodigoProdutoAcabado            write FCodigoProdutoAcabado;
    property IdMovDetEnvio                     : String                     read FIdMovDetEnvio                   write FIdMovDetEnvio;
    property QuantidadeFaturada                : Double                     read FQuantidadeFaturada              write FQuantidadeFaturada;
    property QuantidadeRetornada               : Double                     read FQuantidadeRetornada             write FQuantidadeRetornada;
    property MatrizItens                       : TMatrizFechamento          read FMatrizItens                     write FMatrizItens;
    property DicionarioObjeto                  : TDicionario                read FDicionarioObjeto                write FDicionarioObjeto;
    property TipoRetornoConsignacao            : tTipoRetornoConsignacao    read FTipoRetornoConsignacao          write FTipoRetornoConsignacao;
    property CodigoCliente                     : String                     read FCodigoCliente                   write FCodigoCliente;
    property SequenciaConciliacaoFinanceiro    : Integer                    read FSequenciaConciliacaoFinanceiro  write FSequenciaConciliacaoFinanceiro;
  end;

  TFaturamentoConsignacao = Class
    Class function fGetValorParaBaixaDaDuplicata(AstrIDProduto : String; AfltQuantidadeFaturada : Double) : Double;
  End;


implementation

uses
{$IFNDEF LINUX}
  untFatFaturaConsignacao,
  Faturamento.Consignacao.DefinicaoItensRetorno,
{$ENDIF}
  untReformaTributariaCalculo;

{ TRetornoConsignacaoRepositorio }

function TRetornoConsignacaoRepositorio.fCarregarRetornosDaConsignacaoFaturada(ADocumentoDoFaturamento, AEspecieDoFaturameto,
  AEmpresaDoFaturamento, ASerieDoFaturamento: String): TList<TRetornoConsignacao>;
  Var
    LQuery : TUniQuery;
    LObjTRetornoConsignacao : TRetornoConsignacao;
Begin
  Result := Nil;

  Try
    Result := TList<TRetornoConsignacao>.Create;

    LQuery := fCriaQuery;
    Try
      LQuery.SQL.Text := ' SELECT * '+
                         '   FROM CONRET '+
                         '  WHERE RET_DOCFAT = :DOCFAT '+
                         '    AND RET_ESPFAT = :ESPFAT '+
                         '    AND RET_EMPFAT = :EMPFAT ';

      if not fEmptyStr(ASerieDoFaturamento) then
        LQuery.Sql.Add(' AND RET_SERFAT = :SERFAT ');

      LQuery.ParamByName('DOCFAT').AsString  := ADocumentoDoFaturamento;
      LQuery.ParamByName('ESPFAT').AsString  := AEspecieDoFaturameto;
      LQuery.ParamByName('EMPFAT').AsString  := AEmpresaDoFaturamento;

      if not fEmptyStr(ASerieDoFaturamento) then
        LQuery.ParamByName('SERFAT').AsString  := ASerieDoFaturamento;


      LQuery.Open;
      while not Lquery.eof do
      Begin
        LObjTRetornoConsignacao := TRetornoConsignacao.Create;
        LObjTRetornoConsignacao.NumeroDoDocumentoDoRetorno       := LQuery.FieldByName('RET_DOCRET').AsString;
        LObjTRetornoConsignacao.EspecieDoDocumentoDoRetorno      := LQuery.FieldByName('RET_ESPRET').AsString;
        LObjTRetornoConsignacao.EmpresaDoDocumentoDoRetorno      := LQuery.FieldByName('RET_EMPRET').AsString;
        LObjTRetornoConsignacao.SerieDoDocumentoDoRetorno        := LQuery.FieldByName('RET_SERRET').AsString;
        LObjTRetornoConsignacao.ClienteDoDocumentoDoRetorno      := LQuery.FieldByName('RET_CLIRET').AsString;
        LObjTRetornoConsignacao.NumeroDoDocumentoDoFaturamento   := LQuery.FieldByName('RET_DOCFAT').AsString;
        LObjTRetornoConsignacao.EspecieDoDocumentoDoFaturamento  := LQuery.FieldByName('RET_ESPFAT').AsString;
        LObjTRetornoConsignacao.EmpresaDoDocumentoDoFaturamento  := LQuery.FieldByName('RET_EMPFAT').AsString;
        LObjTRetornoConsignacao.SerieDoDocumentoDoFaturamento    := LQuery.FieldByName('RET_SERFAT').AsString;

        Result.Add(LObjTRetornoConsignacao);

        LQuery.Next;
      End;
      LQuery.Close;

    Finally
      FreeAndNil(LQuery);
    End;

  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '[TRetornoConsignacaoRepositorio.fCarregarRetornosDaConsignacaoFaturada]');
    End;
  End;
end;

function TRetornoConsignacaoRepositorio.fSalvar(ARetornoConsignacao: TRetornoConsignacao; var AMensagem : String): Boolean;
  Var
    LQuery : TUniQuery;
Begin
  Try
    LQuery := fCriaQuery;
    Try
      LQuery.SQL.Text := ' INSERT INTO CONRET (AUTOINCREM, RET_DOCFAT, RET_ESPFAT, RET_EMPFAT, RET_DOCRET, RET_ESPRET, RET_EMPRET, RET_SERFAT, RET_SERRET, RET_CLIRET) '+
                         ' VALUES (:AUTINC, :DOCFAT, :ESPFAT, :EMPFAT, :DOCRET, :ESPRET, :EMPRET, :SERFAT, :SERRET, :CLIRET) ';

      LQuery.ParamByName('AUTINC').AsString  := fRetAutoIncrem('CONRET', VS_strCodEmp);
      LQuery.ParamByName('DOCFAT').AsString  := ARetornoConsignacao.NumeroDoDocumentoDoFaturamento ;
      LQuery.ParamByName('ESPFAT').AsString  := ARetornoConsignacao.EspecieDoDocumentoDoFaturamento;
      LQuery.ParamByName('EMPFAT').AsString  := ARetornoConsignacao.EmpresaDoDocumentoDoFaturamento;
      LQuery.ParamByName('DOCRET').AsString  := ARetornoConsignacao.NumeroDoDocumentoDoRetorno     ;
      LQuery.ParamByName('ESPRET').AsString  := ARetornoConsignacao.EspecieDoDocumentoDoRetorno    ;
      LQuery.ParamByName('EMPRET').AsString  := ARetornoConsignacao.EmpresaDoDocumentoDoRetorno    ;
      LQuery.ParamByName('SERFAT').AsString  := ARetornoConsignacao.SerieDoDocumentoDoFaturamento  ;
      LQuery.ParamByName('SERRET').AsString  := ARetornoConsignacao.SerieDoDocumentoDoRetorno      ;
      If Not fEmptyStr(ARetornoConsignacao.ClienteDoDocumentoDoRetorno) Then
        LQuery.ParamByName('CLIRET').AsString := ARetornoConsignacao.ClienteDoDocumentoDoRetorno
      Else
        LQuery.ParamByName('CLIRET').Clear;
      LQuery.ExecSQL

    Finally
      FreeAndNil(LQuery);
    End;

    Result := True;

  Except
    On E : Exception Do
    Begin
      Result := False;
      AMensagem := E.Message;
    End;
  End;
end;

{ TRetornoConsignacaoBuilder }

constructor TRetornoConsignacaoBuilder.Create;
begin
  FObjRetornoConsignacaoRepositorio        := TRetornoConsignacaoRepositorio.Create;
  FObjRetornoConsignacaoDetalheRepositorio := TRetornoConsignacaoDetalheRepositorio.Create;
  FObjRetornoConsignacaoList               := TList<TRetornoConsignacao>.Create;
  FObjRetornoConsignacaoDetalheList        := TList<TRetornoConsignacaoDetalhe>.Create;
end;

destructor TRetornoConsignacaoBuilder.Destroy;
begin
  FreeAndNil(FObjRetornoConsignacaoRepositorio);
  FreeAndNil(FObjRetornoConsignacaoDetalheRepositorio);
  FreeAndNil(FObjRetornoConsignacaoList);
  FreeAndNil(FObjRetornoConsignacaoDetalheList);
  inherited;
end;

function TRetornoConsignacaoBuilder.fAdiconarDocumento(var AMensagem : String): Boolean;
  var
    LObjTRetornoConsignacao : TRetornoConsignacao;
begin
  Result := True;

  try
    if not fEmptyStr(FNumeroDoDocumentoDoRetorno) then
    Begin
      LObjTRetornoConsignacao := TRetornoConsignacao.Create;
      LObjTRetornoConsignacao.NumeroDoDocumentoDoRetorno   := FNumeroDoDocumentoDoRetorno;
      LObjTRetornoConsignacao.EspecieDoDocumentoDoRetorno  := FEspecieDoDocumentoDoRetorno;
      LObjTRetornoConsignacao.EmpresaDoDocumentoDoRetorno  := FEmpresaDoDocumentoDoRetorno;
      LObjTRetornoConsignacao.SerieDoDocumentoDoRetorno    := FSerieDoDocumentoDoRetorno;
      LObjTRetornoConsignacao.ClienteDoDocumentoDoRetorno  := FClienteDoDocumentoDoRetorno;

      FObjRetornoConsignacaoList.Add(LObjTRetornoConsignacao);
    End
    Else
    Begin
      for LObjTRetornoConsignacao in FObjRetornoConsignacaoList do
      Begin
        LObjTRetornoConsignacao.NumeroDoDocumentoDoFaturamento   := FNumeroDoDocumentoDoFaturamento;
        LObjTRetornoConsignacao.EspecieDoDocumentoDoFaturamento  := FEspecieDoDocumentoDoFaturamento;
        LObjTRetornoConsignacao.EmpresaDoDocumentoDoFaturamento  := FEmpresaDoDocumentoDoFaturamento;
        LObjTRetornoConsignacao.SerieDoDocumentoDoFaturamento    := FSerieDoDocumentoDoFaturamento;
      End;

      fAdiconarDocumentoDetalhe(AMensagem);
    End;

    pLimparCampos;

  Except
    On E: Exception Do
    Begin
      AMensagem := E.Message;
      Result := False;
    End;
  end;
end;

function TRetornoConsignacaoBuilder.fAdiconarDocumentoDetalhe(var AMensagem: String): Boolean;
  var
    LObjTRetornoConsignacaoDetalhe : TRetornoConsignacaoDetalhe;
begin
  Result := True;

  try
    if not fEmptyStr(FNumeroDoDocumentoDoFaturamento) then
    Begin
      for LObjTRetornoConsignacaoDetalhe in FObjRetornoConsignacaoDetalheList do
      Begin
        LObjTRetornoConsignacaoDetalhe.NumeroDoDocumentoDoFaturamento   := FNumeroDoDocumentoDoFaturamento;
        LObjTRetornoConsignacaoDetalhe.EspecieDoDocumentoDoFaturamento  := FEspecieDoDocumentoDoFaturamento;
        LObjTRetornoConsignacaoDetalhe.EmpresaDoDocumentoDoFaturamento  := FEmpresaDoDocumentoDoFaturamento;
      End;
    End
    Else
    Begin
      LObjTRetornoConsignacaoDetalhe := TRetornoConsignacaoDetalhe.Create;
      LObjTRetornoConsignacaoDetalhe.NumeroDoDocumentoDoEnvio   := FNumeroDoDocumentoDoEnvio;
      LObjTRetornoConsignacaoDetalhe.EspecieDoDocumentoDoEnvio  := FEspecieDoDocumentoDoEnvio;
      LObjTRetornoConsignacaoDetalhe.EmpresaDoDocumentoDoEnvio  := FEmpresaDoDocumentoDoEnvio;
      LObjTRetornoConsignacaoDetalhe.CodigoItemEnvio            := FCodigoItemEnvio;
      LObjTRetornoConsignacaoDetalhe.IdMovDetEnvio              := FIdMovDetEnvio;
      LObjTRetornoConsignacaoDetalhe.QuantidadeFaturada         := FQuantidadeFaturada;
      LObjTRetornoConsignacaoDetalhe.QuantidadeRetornada        := FQuantidadeRetornada;
      LObjTRetornoConsignacaoDetalhe.CodigoProdutoAcabado       := FCodigoProdutoAcabado;

      FObjRetornoConsignacaoDetalheList.Add(LObjTRetornoConsignacaoDetalhe);
    End;

    pLimparCampos;

  Except
    On E: Exception Do
    Begin
      AMensagem := E.Message;
      Result := False;
    End;
  end;

end;

class function TRetornoConsignacaoBuilder.fAtualizaCONDEV(AstrIdEnvioConsignacao: String; AfltValorMovimentado: Double; var AMensagem: String): Boolean;
  var
    LQuery               : TUniQuery;
    LfltDiferencaDeSaldo : Double;
begin
  Result := True;

  LQuery := fCriaQuery;

  Try
    Try
      LQuery.SQL.Text := 'SELECT * FROM CONDEV WHERE DEV_SEQENV = :SEQENV ';
      LQuery.ParamByName('SEQENV').AsString := AstrIdEnvioConsignacao;
      LQuery.Open;
      while not LQuery.Eof do
      Begin
        LfltDiferencaDeSaldo := LQuery.FieldByName('DEV_QTDITE').AsFloat - LQuery.FieldByName('DEV_QTDFAT').AsFloat;

        if LfltDiferencaDeSaldo = 0 then
        Begin
          LQuery.Next;
          continue;
        End;

        if LfltDiferencaDeSaldo > AfltValorMovimentado then
        Begin
          LQuery.Edit;
          LQuery.FieldByName('DEV_QTDFAT').AsFloat := LQuery.FieldByName('DEV_QTDFAT').AsFloat + AfltValorMovimentado;
          LQuery.Post;
          Exit;
        End
        Else
        Begin
          LQuery.Edit;
          LQuery.FieldByName('DEV_QTDFAT').AsFloat := LQuery.FieldByName('DEV_QTDFAT').AsFloat + LfltDiferencaDeSaldo;
          LQuery.Post;

          AfltValorMovimentado := AfltValorMovimentado - LfltDiferencaDeSaldo;
        End;

        LQuery.Next;
      End;
      LQuery.Close;

    Finally
      FreeAndNil(LQuery);
    End;
  Except
    On E: Exception Do
    Begin
      AMensagem := E.Message;
      Result    := False;
    End;
  End;
end;

function TRetornoConsignacaoBuilder.fGeraCONDEV(var AMensagem: String): Boolean;
  var
    LQuery : TUniQuery;
begin
  Result := True;

  LQuery := fCriaQuery;

  Try
    Try
      LQuery.SQL.Add('INSERT INTO CONDEV (AUTOINCREM, DEV_NUMDOC, DEV_ESPDOC, DEV_CODEMP, DEV_CODITE, DEV_QTDITE, DEV_CODACA, DEV_SEQENV, DEV_SEQDEV, DEV_QTDFAT) '+
                     ' VALUES (:AUTINC, :NUMDOC, :ESPDOC, :CODEMP, :CODITE, :QTDITE, :CODACA, :SEQENV, :SEQDEV, :QTDFAT) ');

      FcdsProporcaoNotaCosignacao.First;

      while not FcdsProporcaoNotaCosignacao.Eof do
      Begin
        LQuery.ParamByName('AUTINC').AsString := fRetAutoIncrem('CONDEV', VS_strCodEmp);;
        LQuery.ParamByName('NUMDOC').AsString := FcdsProporcaoNotaCosignacao.FieldByName('NUMDOC').AsString;
        LQuery.ParamByName('ESPDOC').AsString := FcdsProporcaoNotaCosignacao.FieldByName('ESPDOC').AsString;
        LQuery.ParamByName('CODEMP').AsString := FcdsProporcaoNotaCosignacao.FieldByName('CODEMP').AsString;
        LQuery.ParamByName('CODITE').AsString := FcdsProporcaoNotaCosignacao.FieldByName('CODITE').AsString;
        LQuery.ParamByName('QTDITE').AsFloat  := FcdsProporcaoNotaCosignacao.FieldByName('QTDITE').AsFloat;
        LQuery.ParamByName('CODACA').AsString := '';
        LQuery.ParamByName('SEQENV').AsString := FcdsProporcaoNotaCosignacao.FieldByName('AUTINC').AsString;
        LQuery.ParamByName('SEQDEV').AsString := FcdsProporcaoNotaCosignacao.FieldByName('SEQGER').AsString;
        LQuery.ParamByName('QTDFAT').AsFloat  := 0.00;
        LQuery.ExecSql;

        FcdsProporcaoNotaCosignacao.Next;
      End;

    Finally
      FreeAndNil(LQuery);
    End;
  Except
    On E: Exception Do
    Begin
      AMensagem := E.Message;
      Result    := False;
    End;
  End;

end;

function TRetornoConsignacaoBuilder.fCriarcdsProporcaoNotaCosignacao: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);
  Result.FieldDefs.Add('AUTINC', ftString,  20, False);
  Result.FieldDefs.Add('NUMDOC', ftString,  20, False);
  Result.FieldDefs.Add('ESPDOC', ftString,  20, False);
  Result.FieldDefs.Add('CODEMP', ftString,   3, False);
  Result.FieldDefs.Add('CODITE', ftString,   8, False);
  Result.FieldDefs.Add('VALDOC', ftFloat,    0, False);
  Result.FieldDefs.Add('QTDITE', ftFloat,    0, False);
  Result.FieldDefs.Add('SEQGER', ftString,  20, False);
  Result.CreateDataSet;
  Result.Open;
end;

function TRetornoConsignacaoBuilder.fCriarcdsProporcaoNotaCosignacaoParaFinanceiro: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);
  Result.FieldDefs.Add('NUMDOC', ftString,  20, False);
  Result.FieldDefs.Add('ESPDOC', ftString,  20, False);
  Result.FieldDefs.Add('CODEMP', ftString,   3, False);
  Result.FieldDefs.Add('VALDOC', ftFloat,    0, False);
  Result.CreateDataSet;
  Result.Open;

  FcdsProporcaoNotaCosignacao.First;
  while not FcdsProporcaoNotaCosignacao.Eof do
  Begin
    if not(Result.Locate('NUMDOC;ESPDOC;CODEMP', VarArrayOf([FcdsProporcaoNotaCosignacao.FieldByName('NUMDOC').AsString,
                                                             FcdsProporcaoNotaCosignacao.FieldByName('ESPDOC').AsString,
                                                             FcdsProporcaoNotaCosignacao.FieldByName('CODEMP').AsString]), [])) then
    Begin
      Result.Append;
      Result.FieldByName('NUMDOC').AsString := FcdsProporcaoNotaCosignacao.FieldByName('NUMDOC').AsString;
      Result.FieldByName('ESPDOC').AsString := FcdsProporcaoNotaCosignacao.FieldByName('ESPDOC').AsString;
      Result.FieldByName('CODEMP').AsString := FcdsProporcaoNotaCosignacao.FieldByName('CODEMP').AsString;
      Result.FieldByName('VALDOC').AsFloat  := FcdsProporcaoNotaCosignacao.FieldByName('VALDOC').AsFloat;
      Result.Post;
    End
    Else
    Begin
      Result.Edit;
      Result.FieldByName('VALDOC').AsFloat := Result.FieldByName('VALDOC').AsFloat + FcdsProporcaoNotaCosignacao.FieldByName('VALDOC').AsFloat;
      Result.Post;
    End;

    FcdsProporcaoNotaCosignacao.Next;
  End;
end;

{$IFNDEF LINUX}
function TRetornoConsignacaoBuilder.fFaturaConsignacao(var AMensagem: String): Boolean;
  var 
    frmFatFaturaConsignacao : TfrmFatFaturaConsignacao;
begin
  Result := True;

  if not fVerificaAcessoSistema('frmFatFaturaConsignacao') then
  Begin
    AMensagem := 'Operador sem acesso à rotina de Faturamento de Mercadoria em Consignação.';
    Exit(False);
  End;

  Try
    pCriarFormularios(TfrmFatFaturaConsignacao, frmFatFaturaConsignacao);

    Try
      frmFatFaturaConsignacao.blnRealizandoFaturamentoViaDevolucaoSimbolica := True;
      frmFatFaturaConsignacao.edtCodCliente.Text                            := FCodigoCliente;
      frmFatFaturaConsignacao.pAbreConsultaPorAcessoExterno;

      frmFatFaturaConsignacao.cdsAnalitico.Filtered := False;

      FcdsProporcaoNotaCosignacao.First;
      while not FcdsProporcaoNotaCosignacao.Eof do
      Begin
        if frmFatFaturaConsignacao.cdsAnalitico.Locate('AUTOINCREM', FcdsProporcaoNotaCosignacao.FieldByName('AUTINC').AsString, []) then
        Begin
          frmFatFaturaConsignacao.cdsAnalitico.Edit;
          frmFatFaturaConsignacao.cdsAnalitico.FieldByName('DET_QTDFAT').AsFloat := FcdsProporcaoNotaCosignacao.FieldByName('QTDITE').AsFloat;
          frmFatFaturaConsignacao.cdsAnalitico.Post;

          frmFatFaturaConsignacao.cdsAnalitico.Filtered := False;
        End;
    
        FcdsProporcaoNotaCosignacao.Next;
      End;

      frmFatFaturaConsignacao.btnConfirmaClick(frmFatFaturaConsignacao.btnConfirma);
      if not frmFatFaturaConsignacao.blnFaturado then
      Begin
        pRemoverNotaGeradaNoRetornoDaConsignacao;
        AMensagem := 'Faturamento de consignação não finalizado. Processo será abortado.';
        Exit(False);
      End;

    Finally
      pFreeAndNil(frmFatFaturaConsignacao);
    End;

  Except
    On E: Exception Do
    Begin
      AMensagem := E.Message;
      Result := False;
    End;
  end;  

end;
{$ENDIF}

{$IFNDEF LINUX}
function TRetornoConsignacaoBuilder.fGerarRetornoConsignacao(var AMensagem : String) : Boolean;
begin
  try
    FblnEhDevolucaoSimbolica := False;

    FcdsProporcaoNotaCosignacao := fCriarcdsProporcaoNotaCosignacao;

    LQueryNotaGerada          := fCriaQuery;
    LQueryNotaGerada.Sql.Text := fSQLNotaGeradaNoRetornoConsignacao;

    LQueryNotaDoEnvio          := fCriaQuery;
    LQueryNotaDoEnvio.Sql.Text := fSQLNotaEnviadaDaConsignacao(False);

    if FTipoRetornoConsignacao = ttrImportacaoXML then
      Result := fGerarRetornoConsignacaoViaImportacaoXML(AMensagem)
    else
      Result := fGerarRetornoConsignacaoViaDigitacaoManual(AMensagem);

    FreeAndNil(LQueryNotaGerada);
    FreeAndNil(LQueryNotaDoEnvio);
    FreeAndNil(FcdsProporcaoNotaCosignacao);

  Except
    On E: Exception Do
    Begin
      AMensagem := E.Message;
      Result := False;
    End;
  end;
end;
{$ENDIF}

{$IFNDEF LINUX}
function TRetornoConsignacaoBuilder.fGerarRetornoConsignacaoViaDigitacaoManual(var AMensagem: String): Boolean;
  var
    LcdsEnvio : TUniClientDataSet;
begin
  LQueryNotaGerada.ParamByName('NUMDOC').AsString := FNumeroDoDocumentoDoRetorno;
  LQueryNotaGerada.ParamByName('ESPDOC').AsString := FEspecieDoDocumentoDoRetorno;
  LQueryNotaGerada.ParamByName('CODEMP').AsString := FEmpresaDoDocumentoDoRetorno;
  LQueryNotaGerada.ParamByName('CODCLI').AsString := FCodigoCliente;
  LQueryNotaGerada.Open;

  if not fTratarDefinicaoItensDoRetorno(AMensagem) then
    Exit(False);

  if Pos(LQueryNotaGerada.FieldByName('DET_CLAFIS').AsString, fTransform(fCfgSis('CLADSC'), 4)) > 0 then
    FblnEhDevolucaoSimbolica := True;

  LQueryNotaGerada.First;
  while not LQueryNotaGerada.Eof do
  Begin
    LQueryNotaDoEnvio.Close;
    LQueryNotaDoEnvio.ParamByName('NUMDOC').AsString := LQueryNotaGerada.FieldByName('DET_DOCDEV').AsString;
    LQueryNotaDoEnvio.ParamByName('ESPDOC').AsString := LQueryNotaGerada.FieldByName('DET_ESPDEV').AsString;
    LQueryNotaDoEnvio.ParamByName('CODEMP').AsString := LQueryNotaGerada.FieldByName('DET_EMPDEV').AsString;
    LQueryNotaDoEnvio.ParamByName('CODITE').AsString := LQueryNotaGerada.FieldByName('DET_CODITE').AsString;
    LQueryNotaDoEnvio.ParamByName('CODCLI').AsString := LQueryNotaGerada.FieldByName('DET_CODCLI').AsString;

    if FcdsItensDoEnvio.Locate('ID_NOTA_GE', LQueryNotaGerada.FieldByname('AUTOINCREM').AsString, []) then
    Begin
      LQueryNotaDoEnvio.ParamByName('UNIDAD').ASString := FcdsItensDoEnvio.FieldByName('ITE_UNDENV').AsString;
      LQueryNotaDoEnvio.ParamByName('UNITAR').AsFloat  := FcdsItensDoEnvio.FieldByName('ITE_UNITAR').AsFloat
    End
    else
    Begin
      AMensagem := 'Problemas ao identificar os itens do envio da consignação.';
      Exit(False);
    End;

    LQueryNotaDoEnvio.Open;

    LcdsEnvio := fCriaClientDatSet(LQueryNotaDoEnvio, False);

    if not fGerarProporcaoDoRetornoDaConsignacao(LcdsEnvio, LQueryNotaGerada, AMensagem) then
      Exit(False);

    LQueryNotaGerada.Next;
  End;

  Result := fProcessarRetornoConsignacao(AMensagem);

  LQueryNotaGerada.Close;

end;
{$ENDIF}

{$IFNDEF LINUX}
function TRetornoConsignacaoBuilder.fGerarRetornoConsignacaoViaImportacaoXML(var AMensagem: String): Boolean;
  var
    LintIdx   : Integer;
    LcdsEnvio : TUniClientDataSet;
begin
  Result := True;

  For LintIdx := 0 To strListIdGerEle.Count-1 Do
  Begin
    LQueryNotaGerada.ParamByName('AUTINC').AsString := strListIdGerEle[LintIdx];
    LQueryNotaGerada.Open;

    if not fTratarDefinicaoItensDoRetorno(AMensagem) then
      Exit(False);

    if Pos(LQueryNotaGerada.FieldByName('DET_CLAFIS').AsString, fTransform(fCfgSis('CLADSC'), 4)) > 0 then
      FblnEhDevolucaoSimbolica := True;    

    LQueryNotaGerada.First;
    while not LQueryNotaGerada.Eof do
    Begin
      LQueryNotaDoEnvio.Close;
      LQueryNotaDoEnvio.ParamByName('AUTINC').AsString := strListIdGerEle[LintIdx];
      LQueryNotaDoEnvio.ParamByName('CODITE').AsString := LQueryNotaGerada.FieldByName('DET_CODITE').AsString;

      if FcdsItensDoEnvio.Locate('ID_NOTA_GE', LQueryNotaGerada.FieldByname('AUTOINCREM').AsString, []) then
      Begin
        LQueryNotaDoEnvio.ParamByName('UNIDAD').ASString := FcdsItensDoEnvio.FieldByName('ITE_UNDENV').AsString;
        LQueryNotaDoEnvio.ParamByName('UNITAR').AsFloat  := FcdsItensDoEnvio.FieldByName('ITE_UNITAR').AsFloat;
      End
      else
      Begin
        AMensagem := 'Problemas ao identificar os itens do envio da consignação.';
        Exit(False);
      End;

      LQueryNotaDoEnvio.Open;

      LcdsEnvio := fCriaClientDatSet(LQueryNotaDoEnvio, False);

      if not fGerarProporcaoDoRetornoDaConsignacao(LcdsEnvio, LQueryNotaGerada, AMensagem) then
        Exit(False);

      LQueryNotaGerada.Next;
    End;

    Result := fProcessarRetornoConsignacao(AMensagem);

    LQueryNotaGerada.Close;
  End;
end;
{$ENDIF}

function TRetornoConsignacaoBuilder.fGerarProporcaoDoRetornoDaConsignacao(AcdsEnvio : TUniClientDataSet; AQueryNotaGerada : TUniQuery; var AMensagem : String) : Boolean;
  var
    LfltQuantidadeARetornar : Double;
begin
  LfltQuantidadeARetornar := AQueryNotaGerada.FieldByName('DET_QTDITE').AsFloat;

  Result := True;

  if AcdsEnvio.RecordCount = 0 then
  Begin
    AMensagem := 'Problemas na identificação das notas de envio de consignação para realização da devolução.';
    Exit(False);
  End;

  AcdsEnvio.First;

  while not(LfltQuantidadeARetornar = 0) do
  Begin
    if AcdsEnvio.FieldByName('DET_SALDO_').AsFloat = 0 then
    Begin
      AcdsEnvio.Next;
      Continue;
    End;

    if AcdsEnvio.FieldByName('DET_SALDO_').AsFloat > LfltQuantidadeARetornar then
    Begin
      pAlimentarCdsProporcaoNotaConsignacao(AcdsEnvio, LfltQuantidadeARetornar, AQueryNotaGerada.FieldByName('AUTOINCREM').AsString);
      LfltQuantidadeARetornar := 0;
    end
    Else
    Begin
      pAlimentarCdsProporcaoNotaConsignacao(AcdsEnvio, AcdsEnvio.FieldByName('DET_SALDO_').AsFloat, AQueryNotaGerada.FieldByName('AUTOINCREM').AsString);
      LfltQuantidadeARetornar := LfltQuantidadeARetornar - AcdsEnvio.FieldByName('DET_SALDO_').AsFloat;

      AcdsEnvio.Edit;
      AcdsEnvio.FieldByName('DET_SALDO_').AsFloat := 0;
      AcdsEnvio.Post;
    End;
  End;
end;

function TRetornoConsignacaoBuilder.fGravarFinanceiroDoRetorno(var AMensagem : String) : Boolean;
  var
    LQuery                                    : TUniQuery;
    intSeqBaiConsig                           : Integer;
    strAutIncNovConsig                        : String;
    LcdsProporcaoNotaCosignacaoParaFinanceiro : TUniClientDataSet;
begin
  Result := True;

  LcdsProporcaoNotaCosignacaoParaFinanceiro := fCriarcdsProporcaoNotaCosignacaoParaFinanceiro;

  LQuery := fCriaQuery;

  Try
    Try
      LQuery.Close;
      LQuery.SQL.Clear;
      LQuery.SQL.Add('SELECT * FROM CADREC '+
                     'WHERE CTR_NUMDUP = :NUMDUP '+
                     '  AND CTR_ESPDOC = :ESPDOC '+
                     '  AND CTR_CODEMP = :CODEMP '+
                     '  AND CTR_SEQBAI = :SEQBAI ');

      LcdsProporcaoNotaCosignacaoParaFinanceiro.First;
      while not LcdsProporcaoNotaCosignacaoParaFinanceiro.Eof do
      begin
        LQuery.Close;
        LQuery.ParamByName('NUMDUP').AsString  := LcdsProporcaoNotaCosignacaoParaFinanceiro.FieldByName('NUMDOC').AsString;
        LQuery.ParamByName('ESPDOC').AsString  := LcdsProporcaoNotaCosignacaoParaFinanceiro.FieldByName('ESPDOC').AsString;
        LQuery.ParamByName('CODEMP').AsString  := LcdsProporcaoNotaCosignacaoParaFinanceiro.FieldByName('CODEMP').AsString;
        LQuery.ParamByName('SEQBAI').AsInteger := 0;
        LQuery.Open;

        if (fFormataFloat(LQuery.FieldByName('CTR_VALDUP').AsFloat, 2) >
            fFormataFloat(LcdsProporcaoNotaCosignacaoParaFinanceiro.FieldByName('VALDOC').AsFloat, 2)) then
        begin
          Result := fBaixaParcial(LQuery.FieldByName('CTR_NUMDUP').AsString,                      // Duplicata
                                  LQuery.FieldByName('CTR_PARCEL').AsString,                      // Parcela
                                  LQuery.FieldByName('CTR_CODEMP').AsString,                      // Empresa
                                  LQuery.FieldByName('CTR_ESPDOC').AsString,                      // Espécie
                                  LQuery.FieldByName('CTR_CODCLI').AsString,                      // Cliente
                                  LcdsProporcaoNotaCosignacaoParaFinanceiro.FieldByName('VALDOC').AsFloat,                       // Valor Recebido
                                  LQuery.FieldByName('CTR_VALJUR').AsFloat,                       // Valor Juros
                                  LQuery.FieldByName('CTR_VALDES').AsFloat,                       // Valor do Desconto
                                  fRetDataServidor,                                               // Data do Recebimento
                                  fRetDataServidor,                                               // Data do Vencimento
                                  fCfgSis('PORRCX'),                                       // Portador da Baixa
                                  'REF. Duplicata ' + LcdsProporcaoNotaCosignacaoParaFinanceiro.FieldByName('NUMDOC').AsString,    // Histórico da Baixa
                                  fCfgSis('CTAAVI'),                                               // Centro de Custo da Baixa
                                  strLoginUsuarioLogado,                                          // Operador da Baixa
                                  '',                                               // Doucmento de Baixa(MOVBAN)
                                  LQuery.FieldByName('CTR_VALORI').AsFloat,        // Novo Valor Original
                                  LQuery.FieldByName('CTR_VALDUP').AsFloat - LcdsProporcaoNotaCosignacaoParaFinanceiro.FieldByName('VALDOC').AsFloat,  // Novo Valor da Duplicata
                                  0,
                                  0,
                                  LcdsProporcaoNotaCosignacaoParaFinanceiro.FieldByName('VALDOC').AsFloat,
                                  0,
                                  0,
                                  0,
                                  0,                                                       // Resumo de Caixa
                                  0,
                                  False,
                                  False,
                                  True,
                                  False,
                                  False,
                                  False,
                                  intSeqBaiConsig,
                                  strAutIncNovConsig,
                                  FSequenciaConciliacaoFinanceiro,                                               // Sequencial de Controle
                                  LQuery.FieldByName('CTR_VALIPI').AsFloat,
                                  LQuery.FieldByName('CTR_VALRET').AsFloat,
                                  LQuery.FieldByName('CTR_VALACE').AsFloat,
                                  LQuery.FieldByName('CTR_VALFRE').AsFloat,
                                  LQuery.FieldByName('CTR_VALFCP').AsFloat,
                                  0,
                                  0,
                                  LcdsProporcaoNotaCosignacaoParaFinanceiro.FieldByName('VALDOC').AsFloat,
                                  0,
                                  1.0000000,
                                  0,
                                  0,
                                  LQuery.FieldByName('CTR_VALORI').AsFloat,
                                  LQuery.FieldByName('CTR_RECAUT').AsString,
                                  '',
                                  fGetValOriDuplicata(LQuery.FieldByName('CTR_NUMDUP').AsString,
                                                      LQuery.FieldByName('CTR_ESPDOC').AsString,
                                                      LQuery.FieldByName('CTR_CODEMP').AsString,
                                                      LQuery.FieldByName('CTR_PARCEL').AsString,
                                                      LQuery.FieldByName('CTR_CODCLI').AsString),
                                                      '',
                                                      '',
                                                      '',
                                                      'N',
                                                      0,
                                                      0,
                                                      LQuery.FieldByName('CTR_VALCBS').AsFloat,
                                                      LQuery.FieldByName('CTR_VALIBS').AsFloat,
                                                      LQuery.FieldByName('CTR_VAL_IS').AsFloat);
        end
        else
        begin
          Result := fBaixaTotal(LQuery.FieldByName('CTR_NUMDUP').AsString,                   // Duplicata
                                LQuery.FieldByName('CTR_PARCEL').AsString,                   // Parcela
                                LQuery.FieldByName('CTR_ESPDOC').AsString,                   // Espécie
                                LQuery.FieldByName('CTR_CODEMP').AsString,                   // Empresa
                                LQuery.FieldByName('CTR_CODCLI').AsString,                   // Cliente
                                LQuery.FieldByName('CTR_VALORI').AsFloat,
                                LcdsProporcaoNotaCosignacaoParaFinanceiro.FieldByName('VALDOC').AsFloat,                    // Valor Recebido
                                LQuery.FieldByName('CTR_VALJUR').AsFloat,                    // Valor Juros
                                LQuery.FieldByName('CTR_VALDES').AsFloat,                    // Valor Desconto
                                0,
                                0,
                                LcdsProporcaoNotaCosignacaoParaFinanceiro.FieldByName('VALDOC').AsFloat,
                                0,
                                0,
                                0,
                                fRetDataServidor,                                            // Data Recebimento
                                '',                                            // Sequencial de Baixa(MOVBAN)
                                'REF. Duplicata ' + LcdsProporcaoNotaCosignacaoParaFinanceiro.FieldByName('NUMDOC').AsString, // Histórico Baixa
                                fCfgSis('CTAAVI'),                                            // Centro de Custo Baixa
                                fCfgSis('PORRCX'),                                    // Portador Baixa
                                strLoginUsuarioLogado,                                       // Operador Baixa
                                0,
                                False,
                                False,
                                True,
                                False,
                                False,
                                False,
                                0,                                                    // Vem do resumo de caixa?
                                FSequenciaConciliacaoFinanceiro,                      // Sequencial de Controle
                                0,
                                LQuery.FieldByName('CTR_RECAUT').AsString,
                                '',
                                '',
                                '',
                                '',
                                False,
                                LQuery.FieldByName('CTR_DESCOB').AsFloat,    // Valor de Despesa de Cobrança
                                'S');
        end;

        LcdsProporcaoNotaCosignacaoParaFinanceiro.Next;
      end;

    Except
      On E: Exception Do
      Begin
        AMensagem := E.Message;
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(LQuery);
    FreeAndNil(LcdsProporcaoNotaCosignacaoParaFinanceiro);
  End;
end;

function TRetornoConsignacaoBuilder.fGravarMovimentoConsignacaoDoRetorno(var AMensagem: String): Boolean;
  var
    LQuery : TUniQuery;
begin
  Result := True;

  LQuery := fCriaQuery;

  Try
    Try
      LQuery.Close;
      LQuery.SQL.Clear;
      LQuery.SQL.Add('SELECT * FROM MOVCON WHERE FALSE ');
      LQuery.Open;

      FcdsProporcaoNotaCosignacao.First;
      while not FcdsProporcaoNotaCosignacao.Eof do
      begin
        LQuery.Insert;
        LQuery.FieldByName('CON_SEQGER').AsString := FcdsProporcaoNotaCosignacao.FieldByName('SEQGER').AsString;
        LQuery.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MOVCON', VS_strCodEmp);;
        LQuery.FieldByName('CON_NUMDOC').AsString := FcdsProporcaoNotaCosignacao.FieldByName('NUMDOC').AsString;
        LQuery.FieldByName('CON_ESPDOC').AsString := FcdsProporcaoNotaCosignacao.FieldByName('ESPDOC').AsString;
        LQuery.FieldByName('CON_CODITE').AsString := FcdsProporcaoNotaCosignacao.FieldByName('CODITE').AsString;
        LQuery.FieldByName('CON_CODEMP').AsString := FcdsProporcaoNotaCosignacao.FieldByName('CODEMP').AsString;
        LQuery.FieldByName('CON_QTDITE').AsFloat  := FcdsProporcaoNotaCosignacao.FieldByName('QTDITE').AsFloat;
        LQuery.FieldByName('CON_DESESP').AsFloat  := 0.00;
        LQuery.FieldByName('CON_CODACA').AsString := '';
        LQuery.FieldByName('CON_AUTICS').AsString := FcdsProporcaoNotaCosignacao.FieldByName('AUTINC').AsString;
        LQuery.FieldByName('CON_TIPMOV').AsString := 'D';
        LQuery.Post;

        FcdsProporcaoNotaCosignacao.Next;
      end;

    Except
      On E: Exception Do
      Begin
        AMensagem := E.Message;
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(LQuery);
  End;

end;

class function TRetornoConsignacaoBuilder.fPermitidoCancelarNotaDevolucaoSimbolica(const AstrNumeroDocumento, AstrEspecieDocumento,
  AstrEmpresaDocumento: String; var AstrMensagem : String): Boolean;
  var
    LqueryConDev       : TUniQuery;
begin
  Result := True;

  LqueryConDev := fCriaQuery;

  Try
    LqueryConDev.Sql.Text := ' SELECT SUM(CONDEV.DEV_QTDFAT) DEV_QTDFAT '+
                             '   FROM MOVDET '+
                             '   JOIN CONDEV ON CONDEV.DEV_SEQDEV = MOVDET.AUTOINCREM '+
                             '  WHERE MOVDET.DET_NUMDOC = :NUMDOC '+
                             '    AND MOVDET.DET_ESPDOC = :ESPDOC '+
                             '    AND MOVDET.DET_CODEMP = :CODEMP ';
    LqueryConDev.ParamByName('NUMDOC').AsString := AstrNumeroDocumento;
    LqueryConDev.ParamByName('ESPDOC').AsString := AstrEspecieDocumento;
    LqueryConDev.ParamByName('CODEMP').AsString := AstrEmpresaDocumento;
    LqueryConDev.Open;
    While not LqueryConDev.Eof do
    Begin

      if LqueryConDev.FieldBYName('DEV_QTDFAT').AsFloat > 0 then
      Begin
        Result := False;
        AstrMensagem := 'Nota envolvida com uma devolução simbólica de consignação já faturada, favor cancelar o '+
        'faturamento de consignação dos envios das notas: ';

        LqueryConDev.Close;
        LqueryConDev.Sql.Text := ' SELECT DISTINCT CONCAT(CONDEV.DEV_NUMDOC,"-",CONDEV.DEV_ESPDOC) DEV_NUMDOC '+
                                 '   FROM MOVDET '+
                                 '   JOIN CONDEV ON CONDEV.DEV_SEQDEV = MOVDET.AUTOINCREM '+
                                 '  WHERE MOVDET.DET_NUMDOC = :NUMDOC '+
                                 '    AND MOVDET.DET_ESPDOC = :ESPDOC '+
                                 '    AND MOVDET.DET_CODEMP = :CODEMP ';
        LqueryConDev.ParamByName('NUMDOC').AsString := AstrNumeroDocumento;
        LqueryConDev.ParamByName('ESPDOC').AsString := AstrEspecieDocumento;
        LqueryConDev.ParamByName('CODEMP').AsString := AstrEmpresaDocumento;
        LqueryConDev.Open;
        while not LqueryConDev.Eof do
        begin
          AstrMensagem := AstrMensagem + LqueryConDev.FieldByName('DEV_NUMDOC').AsString + ',';

          LqueryConDev.next;
        end;

        AstrMensagem := Copy(AstrMensagem,1, length(AstrMensagem)-1);

        Exit;
      End;

      LqueryConDev.next;
    End;
    LqueryConDev.Close;

  Finally
    FreeAndNil(LqueryConDev);
  End;

end;

function TRetornoConsignacaoBuilder.fProcessarDevolucaoDefinitiva(var AMensagem: String; const AFcnReforma : TFncReformaDoRetornoPeloEnvio): Boolean;
begin
  Result := True;

  if not fGravarFinanceiroDoRetorno(AMensagem) then
    Exit(False);

  if not fGravarMovimentoConsignacaoDoRetorno(AMensagem) then
    Exit(False);

  If Assigned(AFcnReforma) Then
    if not AFcnReforma(AMensagem) then
      Exit(False);

  fMensagem('', 'Operação de devolução de consignação definitiva realizada com sucesso!', ['&O k'])
end;

{$IFNDEF LINUX}
function TRetornoConsignacaoBuilder.fProcessarDevolucaoSimbolica(var AMensagem: String; const AFcnReforma : TFncReformaDoRetornoPeloEnvio): Boolean;
begin
  Result := True;

  if not fGeraCONDEV(AMensagem) then
    Exit(False);

  If Assigned(AFcnReforma) Then
    if not AFcnReforma(AMensagem) then
      Exit(False);

  if fMensagem('', 'Operação de devolução simbólica realizada com sucesso! Deseja emitir o documento de faturamento?', ['&Sim', '&Não']) = 1 then
  Begin
    if not fFaturaConsignacao(AMensagem) then
      Exit(False);
  End;

  fMensagem('', 'Operação de devolução de consignação simbólica realizada com sucesso!', ['&O k'])
end;
{$ENDIF}

{$IFNDEF LINUX}
function TRetornoConsignacaoBuilder.fProcessarRetornoConsignacao(var AMensagem: String): Boolean;
begin
  if not FblnEhDevolucaoSimbolica then
    Result := fProcessarDevolucaoDefinitiva(AMensagem, fGravarReformaDoRetornoPeloEnvio)
  Else
    Result := fProcessarDevolucaoSimbolica(AMensagem, fGravarReformaDoRetornoPeloEnvio);

  FcdsProporcaoNotaCosignacao.EmptyDataSet;
end;

class function TRetornoConsignacaoBuilder.RetornaChaveReferenciada(ACodCli,
  ANumDoc: String; ATipXML: Integer): String;
var
  LQuery: TUniQuery;
begin
  Result := EmptyStr;
  LQuery := fCriaQuery;

  Try
    LQuery.Close;
    LQuery.SQL.Clear;
    LQuery.SQL.Add('SELECT DISTINCT RETELE.RET_REFNFE AS CHAVE          ');
    LQuery.SQL.Add('FROM DETELE                                         ');
    LQuery.SQL.Add('JOIN GERELE ON DETELE.DET_SEQGER = GERELE.AUTOINCREM');
    LQuery.SQL.Add('JOIN RETELE ON GERELE.AUTOINCREM = RETELE.RET_SEQGER');
    LQuery.SQL.Add('WHERE GER_TIPXML = :GER_TIPXML                      ');
    LQuery.SQL.Add('  AND B08_NNF    = :B08_NNF                         ');
    LQuery.SQL.Add('  AND GER_CODCLI = :GER_CODCLI                      ');

    LQuery.ParamByName('GER_CODCLI').AsString  := ACodCli;
    LQuery.ParamByName('B08_NNF').AsString     := ANumDoc;
    LQuery.ParamByName('GER_TIPXML').AsInteger := ATipXML;

    LQuery.Open;

    If Not LQuery.IsEmpty Then
      Result := LQuery.FieldByName('CHAVE').AsString;

  Finally
    FreeAndNil(LQuery);
  End;
end;

{$ENDIF}

class function TRetornoConsignacaoBuilder.fRetornaChaveReferenciada(strAutInc,
  strCodIte: String): String;
var
  LQuery: TUniQuery;
begin
  Result := EmptyStr;
  LQuery := fCriaQuery;

  try
    LQuery.Close;
    LQuery.SQL.Clear;
    LQuery.SQL.Add('SELECT DISTINCT RETELE.RET_REFNFE AS CHAVE          ');
    LQuery.SQL.Add('FROM DETELE                                         ');
    LQuery.SQL.Add('JOIN GERELE ON DETELE.DET_SEQGER = GERELE.AUTOINCREM');
    LQuery.SQL.Add('JOIN RETELE ON GERELE.AUTOINCREM = RETELE.RET_SEQGER');
    LQuery.SQL.Add('WHERE DETELE.DET_CODITE = :CODITE                   ');
    LQuery.SQL.Add('AND DETELE.AUTOINCREM = :AUTINC                     ');

    LQuery.ParamByName('CODITE').AsString := strCodIte;
    LQuery.ParamByName('AUTINC').AsString := strAutInc;

    LQuery.Open;

    if not LQuery.IsEmpty then
      Result := LQuery.FieldByName('CHAVE').AsString;
  finally
    FreeAndNil(LQuery);
  end;
end;

procedure TRetornoConsignacaoBuilder.pAlimentarCdsProporcaoNotaConsignacao(AcdsEnvio: TUniClientDataSet; AfltQuantidade: Double; AstrIDMovDetGerado : String);
begin
  FcdsProporcaoNotaCosignacao.Append;
  FcdsProporcaoNotaCosignacao.FieldByName('AUTINC').AsString := AcdsEnvio.FieldByName('AUTOINCREM').AsString;
  FcdsProporcaoNotaCosignacao.FieldByName('NUMDOC').AsString := AcdsEnvio.FieldByName('DET_NUMDOC').AsString;
  FcdsProporcaoNotaCosignacao.FieldByName('ESPDOC').AsString := AcdsEnvio.FieldByName('DET_ESPDOC').AsString;
  FcdsProporcaoNotaCosignacao.FieldByName('CODEMP').AsString := AcdsEnvio.FieldByName('DET_CODEMP').AsString;
  FcdsProporcaoNotaCosignacao.FieldByName('CODITE').AsString := AcdsEnvio.FieldByName('DET_CODITE').AsString;
  FcdsProporcaoNotaCosignacao.FieldByName('VALDOC').AsFloat  := TFaturamentoConsignacao.fGetValorParaBaixaDaDuplicata(AcdsEnvio.FieldByName('AUTOINCREM').AsString,
                                                                                                                      AfltQuantidade);
  FcdsProporcaoNotaCosignacao.FieldByName('QTDITE').AsFloat  := AfltQuantidade;
  FcdsProporcaoNotaCosignacao.FieldByName('SEQGER').AsString := AstrIDMovDetGerado;
  FcdsProporcaoNotaCosignacao.Post;
end;

procedure TRetornoConsignacaoBuilder.pApagarConsignacaoRetornoDetalhe(AstrNomeFormulario : String);
begin
  FObjRetornoConsignacaoDetalheRepositorio.pApagarConsignacaoRetornoDetalhe(self.NumeroDoDocumentoDoFaturamento,
                                                                            self.EspecieDoDocumentoDoFaturamento,
                                                                            self.EmpresaDoDocumentoDoFaturamento,
                                                                            AstrNomeFormulario);
end;

procedure TRetornoConsignacaoBuilder.pAtualizarAutoIncremDoFaturamento;
  Var
    LintIdx : Integer;
    LObjTRetornoConsignacaoDetalhe : TRetornoConsignacaoDetalhe;
begin
  For LintIdx := Low(FMatrizItens) To High(FMatrizItens) Do
  Begin
    for LObjTRetornoConsignacaoDetalhe in FObjRetornoConsignacaoDetalheList do
    Begin
      if (LObjTRetornoConsignacaoDetalhe.CodigoItemEnvio = FMatrizItens[LintIdx].strCodIte) And
         (IIF(fEmptyStr(LObjTRetornoConsignacaoDetalhe.CodigoProdutoAcabado), True, (LObjTRetornoConsignacaoDetalhe.CodigoProdutoAcabado = FMatrizItens[LintIdx].strCodAca))) then
        if LObjTRetornoConsignacaoDetalhe.QuantidadeFaturada > 0 then
          LObjTRetornoConsignacaoDetalhe.IdMovDetFaturamento := FMatrizItens[LintIdx].strAutIncDet;
    End;
  End;
end;

procedure TRetornoConsignacaoBuilder.pCalcularImpostosProporcionalPelaNotaEnvio(AintIndice : Integer);
  Var
    LobjConsig           : TConsignacoes;
    LobjItensNotaEspelho : TItensNotaEspelho;
    LobjItemNotaEspelho  : TItemNotaEspelho;
    LIdx                 : integer;
Begin

  if not Assigned(FDicionarioObjeto) then
    Exit;

  LobjItensNotaEspelho := TItensNotaEspelho.Create(nil);

  Try
    LobjConsig := TConsignacoes(FDicionarioObjeto.RetornaObjeto(IntToStr(FMatrizItens[AintIndice].intAutInc)));

    if not Assigned(LobjConsig) then
      Exit;

    pZerarImpostos(AintIndice);

    // Reforma: o perfil vem do primeiro envio e os valores sao calculados sobre o retorno
    // (TFatVendaBase.pCalcularImpostosReformaTributariaItens), como a trigger faz na devolucao
    If Length(LobjConsig.arrConsignacoes) > 0 Then
      FMatrizItens[AintIndice].recRefGravacao.strSeqOrigem := LobjConsig.arrConsignacoes[Low(LobjConsig.arrConsignacoes)].strAutInc;

    For LIdx := Low(LobjConsig.arrConsignacoes) To High(LobjConsig.arrConsignacoes) Do
    Begin
      LobjItemNotaEspelho := LobjItensNotaEspelho[LobjConsig.arrConsignacoes[LIdx].strAutInc];

      If Assigned(LobjItemNotaEspelho) Then
      Begin
        LobjItemNotaEspelho.pCalculaImpostosProporcional(LobjConsig.arrConsignacoes[LIdx].fltQtdIte);

        FMatrizItens[AintIndice].fltDesEsp := FMatrizItens[AintIndice].fltDesEsp + LobjItemNotaEspelho.itemCalc.fltDesEsp;

        FMatrizItens[AintIndice].strCodFis := FMatrizItens[AintIndice].strCodFis + LobjItemNotaEspelho.itemCalc.strCodFis;

        FMatrizItens[AintIndice].fltAlqIcm := LobjItemNotaEspelho.itemCalc.fltAlqIcm;
        FMatrizItens[AintIndice].fltBasIcm := FMatrizItens[AintIndice].fltBasIcm + LobjItemNotaEspelho.itemCalc.fltBasIcm;
        FMatrizItens[AintIndice].fltValIcm := FMatrizItens[AintIndice].fltValIcm + LobjItemNotaEspelho.itemCalc.fltValIcm;

        FMatrizItens[AintIndice].strCstIpi := FMatrizItens[AintIndice].strCstIpi + LobjItemNotaEspelho.itemCalc.strCstIpi;
        FMatrizItens[AintIndice].strEnqIpi := FMatrizItens[AintIndice].strEnqIpi + LobjItemNotaEspelho.itemCalc.strEnqIpi;
        FMatrizItens[AintIndice].fltAlqIpi := LobjItemNotaEspelho.itemCalc.fltAlqIpi;
        FMatrizItens[AintIndice].fltBasIpi := FMatrizItens[AintIndice].fltBasIpi + LobjItemNotaEspelho.itemCalc.fltBasIpi;
        FMatrizItens[AintIndice].fltValIpi := FMatrizItens[AintIndice].fltValIpi + LobjItemNotaEspelho.itemCalc.fltValIpi;

        FMatrizItens[AintIndice].fltBasRet := FMatrizItens[AintIndice].fltBasRet + LobjItemNotaEspelho.itemCalc.fltBasRet;
        FMatrizItens[AintIndice].fltValRet := FMatrizItens[AintIndice].fltValRet + LobjItemNotaEspelho.itemCalc.fltValRet;

        FMatrizItens[AintIndice].fltValFre := FMatrizItens[AintIndice].fltValFre + LobjItemNotaEspelho.itemCalc.fltValFre;
        FMatrizItens[AintIndice].fltDesAce := FMatrizItens[AintIndice].fltDesAce + LobjItemNotaEspelho.itemCalc.fltDesAce;

        FMatrizItens[AintIndice].fltDesOpe := FMatrizItens[AintIndice].fltDesOpe + LobjItemNotaEspelho.itemCalc.fltDesOpe;
        FMatrizItens[AintIndice].fltImpFed := FMatrizItens[AintIndice].fltImpFed + LobjItemNotaEspelho.itemCalc.fltImpFed;
        FMatrizItens[AintIndice].fltIcmSai := FMatrizItens[AintIndice].fltIcmSai + LobjItemNotaEspelho.itemCalc.fltIcmSai;
        FMatrizItens[AintIndice].fltOutVal := LobjItemNotaEspelho.itemCalc.fltOutVal;

        FMatrizItens[AintIndice].fltTotCus := FMatrizItens[AintIndice].fltTotCus + LobjItemNotaEspelho.itemCalc.fltTotCus;
        FMatrizItens[AintIndice].fltTotCu2 := FMatrizItens[AintIndice].fltTotCu2 + LobjItemNotaEspelho.itemCalc.fltTotCu2;

        FMatrizItens[AintIndice].recDifalFCP.fltPerFcp := LobjItemNotaEspelho.itemCalc.fltPerFcp;
      End;
    End;

  Finally
    FreeAndNil(LobjItensNotaEspelho);
  End;
end;

class procedure TRetornoConsignacaoBuilder.pCancelarDevolucaoSimbolica(const AstrNumeroDocumento, AstrEspecieDocumento, AstrEmpresaDocumento, AstrCliFor, AstrSerieSel: String);
  var
    LqueryConDev       : TUniQuery;
begin
  LqueryConDev := fCriaQuery;

  Try
    LqueryConDev.Sql.Text := ' SELECT CONDEV.* '+
                             '   FROM MOVDET '+
                             '   JOIN CONDEV ON CONDEV.DEV_SEQDEV = MOVDET.AUTOINCREM '+
                             '  WHERE MOVDET.DET_NUMDOC = :NUMDOC '+
                             '    AND MOVDET.DET_ESPDOC = :ESPDOC '+
                             '    AND MOVDET.DET_CODEMP = :CODEMP ';
    LqueryConDev.ParamByName('NUMDOC').AsString := AstrNumeroDocumento;
    LqueryConDev.ParamByName('ESPDOC').AsString := AstrEspecieDocumento;
    LqueryConDev.ParamByName('CODEMP').AsString := AstrEmpresaDocumento;
    LqueryConDev.Open;
    While Not LqueryConDev.Eof Do
    Begin
      fVerificaIntegridade('untCancelamentoDocumentos', 'CONDEV', LqueryConDev, True, False, '', '', False, '');
      LqueryConDev.Next;
    End;
    LqueryConDev.Close;

    LqueryConDev.sql.Clear;
    LqueryConDev.Sql.Text := ' DELETE CONDEV '+
                             '   FROM CONDEV '+
                             '   JOIN MOVDET ON CONDEV.DEV_SEQDEV = MOVDET.AUTOINCREM '+
                             '  WHERE MOVDET.DET_NUMDOC = :NUMDOC '+
                             '    AND MOVDET.DET_ESPDOC = :ESPDOC '+
                             '    AND MOVDET.DET_CODEMP = :CODEMP ';
    LqueryConDev.ParamByName('NUMDOC').AsString := AstrNumeroDocumento;
    LqueryConDev.ParamByName('ESPDOC').AsString := AstrEspecieDocumento;
    LqueryConDev.ParamByName('CODEMP').AsString := AstrEmpresaDocumento;
    LqueryConDev.ExecSql;

    self.pLimparReferenciaComXMLImportado(AstrNumeroDocumento, AstrEspecieDocumento, AstrEmpresaDocumento, AstrCliFor, AstrSerieSel);

  Finally
    FreeAndNil(LqueryConDev);
  End;
end;

procedure TRetornoConsignacaoBuilder.pCarregarRetornosDaConsignacaoFaturada(ADocumentoDoFaturamento, AEspecieDoFaturameto, AEmpresaDoFaturamento, ASerieDoFaturamento: String);
begin
  FObjRetornoConsignacaoList := FObjRetornoConsignacaoRepositorio.fCarregarRetornosDaConsignacaoFaturada(ADocumentoDoFaturamento, AEspecieDoFaturameto,
    AEmpresaDoFaturamento, ASerieDoFaturamento);
end;

{$IFNDEF LINUX}
class function TRetornoConsignacaoBuilder.fDefineLoteParaRetornoConsignacaoViaXML(AstrIdDetEle, AstrCodigoItem : String;
  var AstrLote, AMensagem : String): Boolean;
  var
    LQuery            : TUniQuery;
    LarrLotesDeOrigem : Array of String;
    LintOpcao         : Integer;
    LstrChave         : String;
begin
  Result := True;

  LQuery := fCriaQuery;

  SetLength(LarrLotesDeOrigem, 0);

  Try
    Try
      LQuery.SQL.Add('SELECT DISTINCT MOVDET.DET_NUMLOT '+
                     '  FROM DETELE '+
                     '  JOIN GERELE ON DETELE.DET_SEQGER = GERELE.AUTOINCREM '+
                     '  JOIN RETELE ON GERELE.AUTOINCREM = RETELE.RET_SEQGER '+
                     '  JOIN CADFIS ON RETELE.RET_REFNFE = CADFIS.FIS_ACESSO '+
                     '  JOIN MOVDET ON MOVDET.DET_NUMDOC = CADFIS.FIS_NUMDOC '+
                     '             AND MOVDET.DET_ESPDOC = CADFIS.FIS_ESPDOC '+
                     '             AND MOVDET.DET_CODEMP = CADFIS.FIS_CODEMP '+
                     '             AND MOVDET.DET_CODCLI = GERELE.GER_CODCLI '+
                     ' WHERE DETELE.AUTOINCREM = :AUTINC '+
                     '   AND MOVDET.DET_CODITE = :CODITE ');
      LQuery.ParamByName('AUTINC').AsString := AstrIdDetEle;
      LQuery.ParamByName('CODITE').AsString := AstrCodigoItem;
      LQuery.Open;

      if LQuery.IsEmpty then
      begin
        LstrChave := fRetornaChaveReferenciada(AstrIdDetEle, AstrCodigoItem);
        AMensagem := 'Chave de referência '+LstrChave+' não encontrada, verifique xml!';
        Result := False;
        Exit;
      end;

      while not LQuery.Eof do
      Begin
        SetLength(LarrLotesDeOrigem, Length(LarrLotesDeOrigem) + 1);
        LarrLotesDeOrigem[Length(LarrLotesDeOrigem) - 1] := LQuery.FieldByName('DET_NUMLOT').AsString;

        LQuery.Next;
      End;
      LQuery.Close;

      if Length(LarrLotesDeOrigem) = 1 then
        AstrLote := LarrLotesDeOrigem[0]
      Else
      Begin
        LintOpcao := fGetMenu('Escolha o lote para importação do item "'+AstrCodigoItem+'"', LarrLotesDeOrigem, 1, False, False, 80);

        AstrLote := LarrLotesDeOrigem[LintOpcao-1]
      End;

    Finally
      FreeAndNil(LQuery);
    End;
  Except
    On E: Exception Do
    Begin
      AMensagem := E.Message;
      Result    := False;
    End;
  End;
end;
{$ENDIF}

function TRetornoConsignacaoBuilder.fSalvar(var AMensagem : String): Boolean;
  var
    LObjTRetornoConsignacao        : TRetornoConsignacao;
    LObjTRetornoConsignacaoDetalhe : TRetornoConsignacaoDetalhe;
begin
  Result := False;

  try
    for LObjTRetornoConsignacao in FObjRetornoConsignacaoList do
    Begin
      Result := FObjRetornoConsignacaoRepositorio.fSalvar(LObjTRetornoConsignacao, AMensagem);

      if not Result then
        Exit;
    End;

    for LObjTRetornoConsignacaoDetalhe in FObjRetornoConsignacaoDetalheList do
    Begin
      Result := FObjRetornoConsignacaoDetalheRepositorio.fSalvar(LObjTRetornoConsignacaoDetalhe, AMensagem);

      if not Result then
        Exit;
    End;

  Except
    On E: Exception Do
    Begin
      AMensagem := E.Message;
      Result := False;
    End;
  end;
end;

function TRetornoConsignacaoBuilder.fSQLNotaEnviadaDaConsignacao(AblnParaDefinicaoDeItens : Boolean = False): String;
begin
  if FTipoRetornoConsignacao = ttrImportacaoXML then
  Begin
    Result := 'SELECT MOVDET.AUTOINCREM, MOVDET.DET_NUMDOC, MOVDET.DET_ESPDOC, MOVDET.DET_CODEMP, MOVDET.DET_CODITE, MOVDET.DET_UNITAR, '+
              '       MOVDET.DET_UNIDAD, MOVDET.DET_QTDITE - IFNULL(TEMP.CON_QTDITE, 0) DET_SALDO_ '+
              '   FROM GERELE  '+
              '   JOIN RETELE ON GERELE.AUTOINCREM = RETELE.RET_SEQGER '+
              '   JOIN CADFIS ON RETELE.RET_REFNFE = CADFIS.FIS_ACESSO '+
              '   JOIN MOVDET ON MOVDET.DET_NUMDOC = CADFIS.FIS_NUMDOC '+
              '              AND MOVDET.DET_ESPDOC = CADFIS.FIS_ESPDOC '+
              '              AND MOVDET.DET_CODEMP = CADFIS.FIS_CODEMP '+
              '              AND MOVDET.DET_CODCLI = GERELE.GER_CODCLI '+
              '   LEFT JOIN (SELECT CON_NUMDOC, '+
              '         CON_ESPDOC, '+
              '         CON_CODEMP, '+
              '         CON_CODITE, '+
              '         CON_AUTICS, '+
              '         SUM(CON_QTDITE) AS CON_QTDITE '+
              '         FROM (SELECT CON_NUMDOC,      '+
              '                CON_ESPDOC,            '+
              '                CON_CODEMP,            '+
              '                CON_CODITE,            '+
              '                IFNULL(CON_AUTICS, "") AS CON_AUTICS, '+
              '                CON_QTDITE             '+
              '           FROM  MOVCON                '+
              '           UNION ALL                   '+
              '                SELECT CON_NUMDOC,     '+
              '                 CON_ESPDOC,           '+
              '                 CON_CODEMP,           '+
              '                 CON_CODITE,           '+
              '                 IFNULL(CON_AUTICS, "") AS CON_AUTICS, '+
              '                 CON_QTDITE            '+
              '               FROM NOTCON) AS A       '+
              '         GROUP BY CON_CODITE,          '+
              '            CON_NUMDOC,                '+
              '            CON_ESPDOC,                '+
              '            CON_CODEMP,                '+
              '            CON_AUTICS) AS TEMP        '+
              '          ON TEMP.CON_NUMDOC = MOVDET.DET_NUMDOC  '+
              '         AND TEMP.CON_ESPDOC = MOVDET.DET_ESPDOC  '+
              '         AND TEMP.CON_CODEMP = MOVDET.DET_CODEMP  '+
              '         AND TEMP.CON_CODITE = MOVDET.DET_CODITE  '+
              '         AND ((TEMP.CON_AUTICS = MOVDET.AUTOINCREM) OR (TEMP.CON_AUTICS IS NULL))  '+
              '  WHERE GERELE.AUTOINCREM = :AUTINC               '+
              '    AND MOVDET.DET_CODITE = :CODITE               '+
              '    AND MOVDET.DET_QTDITE - IFNULL(TEMP.CON_QTDITE, 0) > 0   ';

    if not AblnParaDefinicaoDeItens then
    Begin
      Result := Result + ' AND MOVDET.DET_UNITAR = :UNITAR '+
                         ' AND MOVDET.DET_UNIDAD = :UNIDAD ';
    End;
  End
  Else
  Begin
    Result := ' SELECT  MOVDET.AUTOINCREM,  '+
              '         MOVDET.DET_NUMDOC,  '+
              '         MOVDET.DET_ESPDOC,  '+
              '         MOVDET.DET_CODEMP,  '+
              '         MOVDET.DET_CODITE,  '+
              '         MOVDET.DET_UNITAR,  '+
              '         MOVDET.DET_UNIDAD,  '+
              '         MOVDET.DET_QTDITE - IFNULL(TEMP.CON_QTDITE, 0) DET_SALDO_ '+
              '         FROM MOVDET '+
              '           LEFT JOIN (SELECT CON_NUMDOC, '+
              '                             CON_ESPDOC, '+
              '                             CON_CODEMP, '+
              '                             CON_CODITE, '+
              '                             CON_AUTICS, '+
              '                             SUM(CON_QTDITE) AS CON_QTDITE '+
              '                           FROM                            '+
              '                             (SELECT                       '+
              '                               CON_NUMDOC,                 '+
              '                               CON_ESPDOC,                 '+
              '                               CON_CODEMP,                 '+
              '                               CON_CODITE,                 '+
              '                               IFNULL(CON_AUTICS, "") AS CON_AUTICS, '+
              '                               CON_QTDITE                  '+
              '                             FROM                          '+
              '                               MOVCON                      '+
              '                             UNION                         '+
              '                             ALL                           '+
              '                             SELECT                        '+
              '                               CON_NUMDOC,                 '+
              '                               CON_ESPDOC,                 '+
              '                               CON_CODEMP,                 '+
              '                               CON_CODITE,                 '+
              '                               IFNULL(CON_AUTICS, "") AS CON_AUTICS, '+
              '                               CON_QTDITE                  '+
              '                             FROM                          '+
              '                               NOTCON) AS A                '+
              '                    GROUP BY CON_CODITE,                   '+
              '                             CON_NUMDOC,                   '+
              '                             CON_ESPDOC,                   '+
              '                             CON_CODEMP,                   '+
              '                             CON_AUTICS) AS TEMP           '+
              '              ON TEMP.CON_NUMDOC = MOVDET.DET_NUMDOC       '+
              '             AND TEMP.CON_ESPDOC = MOVDET.DET_ESPDOC       '+
              '             AND TEMP.CON_CODEMP = MOVDET.DET_CODEMP       '+
              '             AND TEMP.CON_CODITE = MOVDET.DET_CODITE       '+
              '             AND ((TEMP.CON_AUTICS = MOVDET.AUTOINCREM) OR (TEMP.CON_AUTICS IS NULL))  '+
              '           WHERE MOVDET.DET_NUMDOC = :NUMDOC               '+
              '             AND MOVDET.DET_ESPDOC = :ESPDOC               '+
              '             AND MOVDET.DET_CODEMP = :CODEMP               '+
              '             AND MOVDET.DET_CODITE = :CODITE               '+
              '             AND MOVDET.DET_CODCLI = :CODCLI               '+
              '             AND MOVDET.DET_QTDITE - IFNULL(TEMP.CON_QTDITE, 0) > 0 ';

    if not AblnParaDefinicaoDeItens then
    Begin
      Result := Result + ' AND MOVDET.DET_UNITAR = :UNITAR '+
                         ' AND MOVDET.DET_UNIDAD = :UNIDAD ';
    End;
  End;
end;

function TRetornoConsignacaoBuilder.fSQLNotaGeradaNoRetornoConsignacao: String;
begin
  if FTipoRetornoConsignacao = ttrImportacaoXML then
    Result := 'SELECT MOVDET.DET_NUMDOC, MOVDET.DET_ESPDOC, MOVDET.DET_CODEMP, MOVDET.AUTOINCREM, MOVDET.DET_CODITE, MOVDET.DET_CODCLI, '+
              '       MOVDET.DET_UNIDAD, MOVDET.DET_UNITAR, MOVDET.DET_QTDITE, MOVDET.DET_CLAFIS '+
              ' FROM GERELE '+
              ' JOIN MOVDET ON GERELE.GER_DOCENT = MOVDET.DET_NUMDOC '+
              '            AND GERELE.GER_ESPENT = MOVDET.DET_ESPDOC '+
              '            AND GERELE.GER_EMPENT = MOVDET.DET_CODEMP '+
              '            AND GERELE.GER_CODCLI = MOVDET.DET_CODCLI '+
              ' WHERE GERELE.AUTOINCREM = :AUTINC '+
              '   AND MOVDET.DET_TIP_FC = "C" '
  else
    Result := 'SELECT MOVDET.DET_NUMDOC, MOVDET.DET_ESPDOC, MOVDET.DET_CODEMP, MOVDET.AUTOINCREM, MOVDET.DET_CODITE, MOVDET.DET_CODCLI, '+
              '       MOVDET.DET_UNIDAD, MOVDET.DET_UNITAR, MOVDET.DET_QTDITE, MOVDET.DET_CLAFIS, '+
              '       MOVDET.DET_DOCDEV, MOVDET.DET_ESPDEV, MOVDET.DET_EMPDEV '+
              ' FROM MOVDET  '+
              ' WHERE MOVDET.DET_NUMDOC = :NUMDOC '+
              '   AND MOVDET.DET_ESPDOC = :ESPDOC '+
              '   AND MOVDET.DET_CODEMP = :CODEMP '+
              '   AND MOVDET.DET_CODCLI = :CODCLI '+
              '   AND MOVDET.DET_TIP_FC = "C"     ';

end;

procedure TRetornoConsignacaoBuilder.pLimparCampos;
begin
  FNumeroDoDocumentoDoFaturamento  := '';
  FEspecieDoDocumentoDoFaturamento := '';
  FEmpresaDoDocumentoDoFaturamento := '';
  FNumeroDoDocumentoDoRetorno      := '';
  FEspecieDoDocumentoDoRetorno     := '';
  FEmpresaDoDocumentoDoRetorno     := '';
  FSerieDoDocumentoDoRetorno       := '';
  FClienteDoDocumentoDoRetorno     := '';
  FSerieDoDocumentoDoFaturamento   := '';
  FNumeroDoDocumentoDoEnvio        := '';
  FEspecieDoDocumentoDoEnvio       := '';
  FEmpresaDoDocumentoDoEnvio       := '';
  FCodigoItemEnvio                 := '';
  FQuantidadeFaturada              := 0;
  FQuantidadeRetornada             := 0;
end;

class procedure TRetornoConsignacaoBuilder.pLimparFaturamentoDevolucaoSimbolica(const AstrNumeroDocumento, AstrEspecieDocumento, AstrEmpresaDocumento: String);
  var
    LQueryMovCon,
    LqueryConDev       : TUniQuery;
    LfltValorACancelar : Double;
begin
  LQueryMovCon := fCriaQuery;
  LqueryConDev := fCriaQuery;

  Try
    LqueryConDev.Sql.Text := ' SELECT * '+
                             '   FROM CONDEV '+
                             '  WHERE CONDEV.DEV_SEQENV = :SEQENV '+
                             '    AND CONDEV.DEV_QTDFAT > 0 ';

    LQueryMovCon.SQL.Text := ' SELECT SUM(MOVCON.CON_QTDITE) CON_QTDITE, MOVCON.CON_AUTICS '+
                             '   FROM MOVDET '+
                             '   JOIN MOVCON ON MOVCON.CON_SEQGER = MOVDET.AUTOINCREM '+
                             '  WHERE MOVDET.DET_NUMDOC = :NUMDOC '+
                             '    AND MOVDET.DET_ESPDOC = :ESPDOC '+
                             '    AND MOVDET.DET_CODEMP = :CODEMP '+
                             '    AND MOVCON.CON_TIPMOV = "F" '+
                             '   GROUP BY MOVCON.CON_AUTICS ';
    LQueryMovCon.ParamByName('NUMDOC').AsString := AstrNumeroDocumento;
    LQueryMovCon.ParamByName('ESPDOC').AsString := AstrEspecieDocumento;
    LQueryMovCon.ParamByName('CODEMP').AsString := AstrEmpresaDocumento;
    LQueryMovCon.Open;

    while not LQueryMovCon.Eof do
    Begin
      LfltValorACancelar := LQueryMovCon.FieldByName('CON_QTDITE').AsFloat;

      LqueryConDev.ParamByName('SEQENV').AsString := LQueryMovCon.FieldByName('CON_AUTICS').Asstring;
      LqueryConDev.Open;

      if not LqueryConDev.IsEmpty then
      Begin
        Repeat

          if LqueryConDev.FieldByName('DEV_QTDFAT').AsFloat <> 0 then
          Begin
            if LqueryConDev.FieldByName('DEV_QTDFAT').AsFloat > LfltValorACancelar then
            Begin
              LqueryConDev.Edit;
              LqueryConDev.FieldByName('DEV_QTDFAT').AsFloat := LqueryConDev.FieldByName('DEV_QTDFAT').AsFloat - LfltValorACancelar;
              LqueryConDev.Post;

              LfltValorACancelar := 0;
            End
            Else
            Begin
              LfltValorACancelar := LfltValorACancelar - LqueryConDev.FieldByName('DEV_QTDFAT').AsFloat;

              LqueryConDev.Edit;
              LqueryConDev.FieldByName('DEV_QTDFAT').AsFloat := 0;
              LqueryConDev.Post;
            End;
          End;

          LqueryConDev.next;

          if LqueryConDev.Eof then
            Break;

        Until (LfltValorACancelar = 0);
      End;

      LqueryConDev.Close;

      LQueryMovCon.Next;
    End;

    LQueryMovCon.Close;

  Finally
    FreeAndNil(LQueryMovCon);
    FreeAndNil(LqueryConDev);
  End;
end;

procedure TRetornoConsignacaoBuilder.pLimparLista;
begin
  FObjRetornoConsignacaoList.Clear;
  FObjRetornoConsignacaoDetalheList.Clear;
end;

class procedure TRetornoConsignacaoBuilder.pLimparReferenciaComXMLImportado(const AstrNumeroDocumento, AstrEspecieDocumento, AstrEmpresaDocumento,
    AstrCliFor, AstrSerieSel: String);
  var
    Lquery : TUniQuery;
begin
  Lquery := fCriaQuery;

  Try
    Lquery.Sql.Text := ' UPDATE GERELE SET GER_DOCENT = NULL, GER_ESPENT = NULL, GER_EMPENT = NULL '+
                       '  WHERE GER_DOCENT = :DOCENT '+
                       '    AND GER_ESPENT = :ESPENT '+
                       '    AND GER_EMPENT = :EMPENT '+
                       '    AND GER_CODFOR = :CODFOR '+
                       '    AND GER_TIP_FC = "F" ' +
                       '    AND B07_SERIE = :SERIE_ ';

    Lquery.ParamByName('DOCENT').AsString := AstrNumeroDocumento;
    Lquery.ParamByName('ESPENT').AsString := AstrEspecieDocumento;
    Lquery.ParamByName('EMPENT').AsString := AstrEmpresaDocumento;
    Lquery.ParamByName('CODFOR').AsString := AstrCliFor;
    Lquery.ParamByName('SERIE_').AsString := AstrSerieSel;
    Lquery.ExecSql;

  Finally
    FreeAndNil(Lquery);
  End;
end;

procedure TRetornoConsignacaoBuilder.pRemoverNotaGeradaNoRetornoDaConsignacao;
  Var
    LQueryMovGer,
    LQueryCadFis,
    LQueryConDev,
    LQueryGerEle : TUniQuery;
Begin
  LQueryMovGer := fCriaQuery;
  LQueryMovGer.SQL.Text := ' DELETE FROM MOVGER '+
                           '  WHERE MOVGER.GER_NUMDOC = :NUMDOC '+
                           '    AND MOVGER.GER_ESPDOC = :ESPDOC '+
                           '    AND MOVGER.GER_CODEMP = :CODEMP '+
                           '    AND MOVGER.GER_CODEMP = :CODEMP '+
                           '    AND MOVGER.GER_CODCLI = :CODCLI ';

  LQueryCadFis := fCriaQuery;
  LQueryCadFis.SQL.Text := ' DELETE FROM CADFIS '+
                           '  WHERE CADFIS.FIS_NUMDOC = :NUMDOC '+
                           '    AND CADFIS.FIS_ESPDOC = :ESPDOC '+
                           '    AND CADFIS.FIS_CODEMP = :CODEMP '+
                           '    AND CADFIS.FIS_FORCLI = :CODCLI ';

  LQueryConDev := fCriaQuery;
  LQueryConDev.SQL.Text := ' DELETE FROM CONDEV '+
                           '  WHERE CONDEV.DEV_SEQDEV = :SEQDEV ';

  Try
    LQueryNotaGerada.First;
    while not LQueryNotaGerada.Eof do
    begin
      LQueryMovGer.ParamByName('NUMDOC').AsString  := LQueryNotaGerada.FieldByName('DET_NUMDOC').AsString;
      LQueryMovGer.ParamByName('ESPDOC').AsString  := LQueryNotaGerada.FieldByName('DET_ESPDOC').AsString;
      LQueryMovGer.ParamByName('CODEMP').AsString  := LQueryNotaGerada.FieldByName('DET_CODEMP').AsString;
      LQueryMovGer.ParamByName('CODCLI').AsString  := LQueryNotaGerada.FieldByName('DET_CODCLI').AsString;
      LQueryMovGer.ExecSQL;

      LQueryCadFis.ParamByName('NUMDOC').AsString  := LQueryNotaGerada.FieldByName('DET_NUMDOC').AsString;
      LQueryCadFis.ParamByName('ESPDOC').AsString  := LQueryNotaGerada.FieldByName('DET_ESPDOC').AsString;
      LQueryCadFis.ParamByName('CODEMP').AsString  := LQueryNotaGerada.FieldByName('DET_CODEMP').AsString;
      LQueryCadFis.ParamByName('CODCLI').AsString  := LQueryNotaGerada.FieldByName('DET_CODCLI').AsString;
      LQueryCadFis.ExecSQL;

      LQueryConDev.ParamByName('SEQDEV').AsString  := LQueryNotaGerada.FieldByName('AUTOINCREM').AsString;
      LQueryConDev.ExecSQL;

      LQueryNotaGerada.Next;
    end;

    if FTipoRetornoConsignacao = ttrImportacaoXML then
    Begin
      LQueryGerEle := fCriaQuery;
      LQueryGerEle.SQL.Text := ' UPDATE GERELE SET GER_DOCENT = NULL, GER_ESPENT = NULL, GER_EMPENT = NULL '+
                               '  WHERE AUTOINCREM = :AUTINC ';
      LQueryGerEle.ParamByName('AUTINC').AsString := strListIdGerEle[0];
      LQueryGerEle.ExecSQL;
    End;

  Finally
    FreeAndNil(LQueryMovGer);
    FreeAndNil(LQueryCadFis);
    FreeAndNil(LQueryConDev);

    if FTipoRetornoConsignacao = ttrImportacaoXML then
      FreeAndNil(LQueryGerEle);
  End;
end;

{$IFNDEF LINUX}
function TRetornoConsignacaoBuilder.fTratarDefinicaoItensDoRetorno(var AMensagem : String) : Boolean;
  var
    frmFaturamentoConsignacaoDefinicaoItensRetorno : TfrmFaturamentoConsignacaoDefinicaoItensRetorno;
    LstrMensagem                                   : String;
begin
  Try
    pCriarFormularios(TfrmFaturamentoConsignacaoDefinicaoItensRetorno, frmFaturamentoConsignacaoDefinicaoItensRetorno);

    frmFaturamentoConsignacaoDefinicaoItensRetorno.QueryNotaGerada                      := LQueryNotaGerada;
    frmFaturamentoConsignacaoDefinicaoItensRetorno.QueryNotaEnvio.Sql.Text              := fSQLNotaEnviadaDaConsignacao(True);
    frmFaturamentoConsignacaoDefinicaoItensRetorno.QueryNotaEnvioParaValidacao.Sql.Text := fSQLNotaEnviadaDaConsignacao;
    frmFaturamentoConsignacaoDefinicaoItensRetorno.TipoRetornoConsignacao               := FTipoRetornoConsignacao;

    if not(frmFaturamentoConsignacaoDefinicaoItensRetorno.fValidarInformacoesNaNotaDeRetorno(LstrMensagem)) then
    Begin
      fMensagem('Atenção', LstrMensagem, ['&O k']);
      frmFaturamentoConsignacaoDefinicaoItensRetorno.ShowModal;
    End;

    FcdsItensDoEnvio := frmFaturamentoConsignacaoDefinicaoItensRetorno.CdsItensDoEnvio;

    Result := frmFaturamentoConsignacaoDefinicaoItensRetorno.blnValidado;

    if not Result then
      AMensagem := 'Problemas com a identificação dos itens correspondentes nos documentos de envio de consignação.';

  Finally
    pFreeAndNil(frmFaturamentoConsignacaoDefinicaoItensRetorno);
  End;
end;
{$ENDIF}

procedure TRetornoConsignacaoBuilder.pZerarImpostos(AintIndice : Integer);
begin
  FMatrizItens[AintIndice].fltDesEsp             := 0.00;
  FMatrizItens[AintIndice].strCodFis             := '';
  FMatrizItens[AintIndice].fltAlqIcm             := 0.00;
  FMatrizItens[AintIndice].fltBasIcm             := 0.00;
  FMatrizItens[AintIndice].fltValIcm             := 0.00;
  FMatrizItens[AintIndice].strCstIpi             := '';
  FMatrizItens[AintIndice].strEnqIpi             := '';
  FMatrizItens[AintIndice].fltAlqIpi             := 0.00;
  FMatrizItens[AintIndice].fltBasIpi             := 0.00;
  FMatrizItens[AintIndice].fltValIpi             := 0.00;
  FMatrizItens[AintIndice].fltBasRet             := 0.00;
  FMatrizItens[AintIndice].fltValRet             := 0.00;
  FMatrizItens[AintIndice].fltValFre             := 0.00;
  FMatrizItens[AintIndice].fltDesAce             := 0.00;
  FMatrizItens[AintIndice].fltDesOpe             := 0.00;
  FMatrizItens[AintIndice].fltImpFed             := 0.00;
  FMatrizItens[AintIndice].fltIcmSai             := 0.00;
  FMatrizItens[AintIndice].fltOutVal             := 0.00;
  FMatrizItens[AintIndice].recDifalFCP.fltPerFcp := 0.00;
  FMatrizItens[AintIndice].fltTotCus             := 0.00;
  FMatrizItens[AintIndice].fltTotCu2             := 0.00;
  FMatrizItens[AintIndice].recRefGravacao        := Default(TRefTribValoresGravacao);
end;

function TRetornoConsignacaoBuilder.fGravarReformaDoRetornoPeloEnvio(var AMensagem : String) : Boolean;
  Var
    LstrSeqGer : String;
    LstrSeqEnvio : String;
    LIndexFieldNames : String;
    LrecAntes : TValoresReformaItemRetorno;
begin
  // Retorno lancado pela entrada (XML ou digitacao): a nota ja esta gravada e a trigger nao calcula.
  // Mesma regra da trigger na devolucao: perfil do primeiro envio, valores do proprio retorno gravado
  Result := True;
  Try
    LIndexFieldNames := FcdsProporcaoNotaCosignacao.IndexFieldNames;
    Try
      FcdsProporcaoNotaCosignacao.IndexFieldNames := 'SEQGER';
      FcdsProporcaoNotaCosignacao.First;

      While Not FcdsProporcaoNotaCosignacao.Eof Do
      Begin
        LstrSeqGer := FcdsProporcaoNotaCosignacao.FieldByName('SEQGER').AsString;
        LstrSeqEnvio := FcdsProporcaoNotaCosignacao.FieldByName('AUTINC').AsString;

        While (Not FcdsProporcaoNotaCosignacao.Eof) And (FcdsProporcaoNotaCosignacao.FieldByName('SEQGER').AsString = LstrSeqGer) Do
          FcdsProporcaoNotaCosignacao.Next;

        LrecAntes := fValoresReformaDoItemGravado(LstrSeqGer);
        TRefTribCalculo.fRecalcularRefDoItemGravado(LstrSeqGer, LstrSeqEnvio);
        pAjustarRetornoGravadoPelaReforma(LstrSeqGer, LrecAntes, fValoresReformaDoItemGravado(LstrSeqGer));
      End;
    Finally
      FcdsProporcaoNotaCosignacao.IndexFieldNames := LIndexFieldNames;
    End;
  Except
    On E: Exception Do
    Begin
      AMensagem := 'Falha ao gravar a reforma tributaria do retorno de consignacao: ' + E.Message;
      Result := False;
    End;
  End;
end;

function TRetornoConsignacaoBuilder.fValoresReformaDoItemGravado(const AstrSeqGer : String) : TValoresReformaItemRetorno;
  Var
    LQuery : TUniQuery;
begin
  Result := Default(TValoresReformaItemRetorno);

  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Text := ' SELECT IFNULL(SUM(REF_BASCAL), 0) AS BASCAL, IFNULL(SUM(REF_CBSVAL), 0) AS CBSVAL, '+
                       '        IFNULL(SUM(REF_VALIBS), 0) AS VALIBS, IFNULL(SUM(REF_SELVAL), 0) AS SELVAL, '+
                       '        IFNULL(SUM(REF_SELBAS), 0) AS SELBAS '+
                       '   FROM MOVREF '+
                       '  WHERE REF_SEQGER = :SEQGER ';
    LQuery.ParamByName('SEQGER').AsString := AstrSeqGer;
    LQuery.Open;

    Result.fltBase   := LQuery.FieldByName('BASCAL').AsFloat;
    Result.fltBaseIs := LQuery.FieldByName('SELBAS').AsFloat;
    Result.fltCbs    := LQuery.FieldByName('CBSVAL').AsFloat;
    Result.fltIbs    := LQuery.FieldByName('VALIBS').AsFloat;
    Result.fltIs     := LQuery.FieldByName('SELVAL').AsFloat;
  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure TRetornoConsignacaoBuilder.pAjustarRetornoGravadoPelaReforma(const AstrSeqGer : String; const AAntes, ADepois : TValoresReformaItemRetorno);
  Var
    LQuery : TUniQuery;
    LfltBase : Double;
    LfltBaseIs : Double;
    LfltCbs : Double;
    LfltIbs : Double;
    LfltIs : Double;
    LfltTotal : Double;
    LstrIdCadFis : String;
    LstrBloco : String;
    LintBloco : Integer;
begin
  If Not fSomarNovosImpostosDaReformaAoValorContabil Then
    Exit;

  LfltBase  := fFormataFloat(ADepois.fltBase - AAntes.fltBase, 2);
  LfltBaseIs := fFormataFloat(ADepois.fltBaseIs - AAntes.fltBaseIs, 2);
  LfltCbs   := fFormataFloat(ADepois.fltCbs - AAntes.fltCbs, 2);
  LfltIbs   := fFormataFloat(ADepois.fltIbs - AAntes.fltIbs, 2);
  LfltIs    := fFormataFloat(ADepois.fltIs - AAntes.fltIs, 2);
  LfltTotal := fFormataFloat(LfltCbs + LfltIbs + LfltIs, 2);

  If (Abs(LfltBase) < 0.005) And (Abs(LfltBaseIs) < 0.005) And (Abs(LfltTotal) < 0.005) Then
    Exit;

  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Text := ' UPDATE MOVDET SET DET_VLRCON = DET_VLRCON + :VALOR WHERE AUTOINCREM = :SEQGER ';
    LQuery.ParamByName('VALOR').AsFloat   := LfltTotal;
    LQuery.ParamByName('SEQGER').AsString := AstrSeqGer;
    LQuery.ExecSQL;

    LQuery.SQL.Text := ' UPDATE MOVGER G '+
                       '  INNER JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM '+
                       '    SET G.GER_VLRCON = G.GER_VLRCON + :VALOR '+
                       '  WHERE D.AUTOINCREM = :SEQGER ';
    LQuery.ParamByName('VALOR').AsFloat   := LfltTotal;
    LQuery.ParamByName('SEQGER').AsString := AstrSeqGer;
    LQuery.ExecSQL;

    LQuery.SQL.Text := ' UPDATE AUXMOV A '+
                       '  INNER JOIN MOVDET D ON D.DET_SEQGER = A.AUX_SEQGER '+
                       '    SET A.AUX_TOTCBS = IFNULL(A.AUX_TOTCBS, 0) + :CBS, '+
                       '        A.AUX_TOTIBS = IFNULL(A.AUX_TOTIBS, 0) + :IBS, '+
                       '        A.AUX_TOT_IS = IFNULL(A.AUX_TOT_IS, 0) + :VALIS '+
                       '  WHERE D.AUTOINCREM = :SEQGER ';
    LQuery.ParamByName('CBS').AsFloat     := LfltCbs;
    LQuery.ParamByName('IBS').AsFloat     := LfltIbs;
    LQuery.ParamByName('VALIS').AsFloat   := LfltIs;
    LQuery.ParamByName('SEQGER').AsString := AstrSeqGer;
    LQuery.ExecSQL;

    // Mesma chave do pRemoverNotaGeradaNoRetornoDaConsignacao; o bloco do item e o de mesma CFOP e aliquota de ICMS
    LQuery.SQL.Text := ' SELECT F.*, D.DET_CLAFIS, D.DET_ALQICM '+
                       '   FROM CADFIS F '+
                       '  INNER JOIN MOVDET D ON D.DET_NUMDOC = F.FIS_NUMDOC '+
                       '                     AND D.DET_ESPDOC = F.FIS_ESPDOC '+
                       '                     AND D.DET_CODEMP = F.FIS_CODEMP '+
                       '                     AND D.DET_CODCLI = F.FIS_FORCLI '+
                       '  WHERE D.AUTOINCREM = :SEQGER ';
    LQuery.ParamByName('SEQGER').AsString := AstrSeqGer;
    LQuery.Open;

    If LQuery.IsEmpty Then
      Exit;

    LstrIdCadFis := LQuery.FieldByName('AUTOINCREM').AsString;
    LstrBloco := EmptyStr;
    For LintBloco := 1 To 8 Do
    Begin
      If (LQuery.FindField('FIS_CLFSC' + IntToStr(LintBloco)) = Nil) Then
        Break;

      If (LQuery.FieldByName('FIS_CLFSC' + IntToStr(LintBloco)).AsString = LQuery.FieldByName('DET_CLAFIS').AsString) And
         (fFormataFloat(LQuery.FieldByName('FIS_ALQIC' + IntToStr(LintBloco)).AsFloat, 2) = fFormataFloat(LQuery.FieldByName('DET_ALQICM').AsFloat, 2)) Then
      Begin
        LstrBloco := IntToStr(LintBloco);
        Break;
      End;
    End;
    LQuery.Close;

    LQuery.SQL.Text := ' UPDATE CADFIS '+
                       '    SET FIS_TOTCBS = IFNULL(FIS_TOTCBS, 0) + :CBS, '+
                       '        FIS_TOTIBS = IFNULL(FIS_TOTIBS, 0) + :IBS, '+
                       '        FIS_TOT_IS = IFNULL(FIS_TOT_IS, 0) + :VALIS ';
    If (Not fEmptyStr(LstrBloco)) Then
      LQuery.SQL.Add(', FIS_VLCON' + LstrBloco + ' = IFNULL(FIS_VLCON' + LstrBloco + ', 0) + :VALOR ');
    LQuery.SQL.Add(' WHERE AUTOINCREM = :AUTINC ');
    LQuery.ParamByName('CBS').AsFloat     := LfltCbs;
    LQuery.ParamByName('IBS').AsFloat     := LfltIbs;
    LQuery.ParamByName('VALIS').AsFloat   := LfltIs;
    If (Not fEmptyStr(LstrBloco)) Then
      LQuery.ParamByName('VALOR').AsFloat := LfltTotal;
    LQuery.ParamByName('AUTINC').AsString := LstrIdCadFis;
    LQuery.ExecSQL;

    If (Not fEmptyStr(LstrBloco)) And fTabelaExiste('AUXFIS', True) Then
    Begin
      LQuery.SQL.Text := ' UPDATE AUXFIS '+
                         '    SET FIS_BCCBS' + LstrBloco + ' = IFNULL(FIS_BCCBS' + LstrBloco + ', 0) + :BASE, '+
                         '        FIS_VLCBS' + LstrBloco + ' = IFNULL(FIS_VLCBS' + LstrBloco + ', 0) + :CBS, '+
                         '        FIS_BCIBS' + LstrBloco + ' = IFNULL(FIS_BCIBS' + LstrBloco + ', 0) + :BASE, '+
                         '        FIS_VLIBS' + LstrBloco + ' = IFNULL(FIS_VLIBS' + LstrBloco + ', 0) + :IBS, '+
                         '        FIS_BC_IS' + LstrBloco + ' = IFNULL(FIS_BC_IS' + LstrBloco + ', 0) + :BASEIS, '+
                         '        FIS_VL_IS' + LstrBloco + ' = IFNULL(FIS_VL_IS' + LstrBloco + ', 0) + :VALIS '+
                         '  WHERE FIS_SEQFIS = :AUTINC ';
      LQuery.ParamByName('BASE').AsFloat    := LfltBase;
      LQuery.ParamByName('BASEIS').AsFloat  := LfltBaseIs;
      LQuery.ParamByName('CBS').AsFloat     := LfltCbs;
      LQuery.ParamByName('IBS').AsFloat     := LfltIbs;
      LQuery.ParamByName('VALIS').AsFloat   := LfltIs;
      LQuery.ParamByName('AUTINC').AsString := LstrIdCadFis;
      LQuery.ExecSQL;
    End;
  Finally
    FreeAndNil(LQuery);
  End;
end;

{ TRetornoConsignacaoDetalheRepositorio }

function TRetornoConsignacaoDetalheRepositorio.fSalvar(ARetornoConsignacaoDetalhe: TRetornoConsignacaoDetalhe; var AMensagem: String): Boolean;
  Var
    LQuery : TUniQuery;
Begin
  Try
    LQuery := fCriaQuery;
    Try
      LQuery.SQL.Text := ' INSERT INTO CONRED (AUTOINCREM, RED_DOCENV, RED_ESPENV, RED_EMPENV, RED_ITEENV, RED_QTDFAT, RED_QTDRET, RED_DOCFAT, '+
                         ' RED_ESPFAT, RED_EMPFAT, RED_SEQENV, RED_SEQFAT, RED_CODACA) '+
                         ' VALUES (:AUTINC, :DOCENV, :ESPENV, :EMPENV, :ITEENV, :QTDFAT, :QTDRET, :DOCFAT, :ESPFAT, :EMPFAT, :SEQENV, :SEQFAT, :CODACA) ';

      LQuery.ParamByName('AUTINC').AsString  := fRetAutoIncrem('CONRED', VS_strCodEmp);
      LQuery.ParamByName('DOCENV').AsString  := ARetornoConsignacaoDetalhe.NumeroDoDocumentoDoEnvio;
      LQuery.ParamByName('ESPENV').AsString  := ARetornoConsignacaoDetalhe.EspecieDoDocumentoDoEnvio;
      LQuery.ParamByName('EMPENV').AsString  := ARetornoConsignacaoDetalhe.EmpresaDoDocumentoDoEnvio;
      LQuery.ParamByName('ITEENV').AsString  := ARetornoConsignacaoDetalhe.CodigoItemEnvio;
      LQuery.ParamByName('QTDFAT').AsFloat   := ARetornoConsignacaoDetalhe.QuantidadeFaturada;
      LQuery.ParamByName('QTDRET').AsFloat   := ARetornoConsignacaoDetalhe.QuantidadeRetornada;
      LQuery.ParamByName('DOCFAT').AsString  := ARetornoConsignacaoDetalhe.NumeroDoDocumentoDoFaturamento ;
      LQuery.ParamByName('ESPFAT').AsString  := ARetornoConsignacaoDetalhe.EspecieDoDocumentoDoFaturamento;
      LQuery.ParamByName('EMPFAT').AsString  := ARetornoConsignacaoDetalhe.EmpresaDoDocumentoDoFaturamento;
      LQuery.ParamByName('SEQENV').AsString  := ARetornoConsignacaoDetalhe.IdMovDetEnvio;
      LQuery.ParamByName('SEQFAT').AsString  := ARetornoConsignacaoDetalhe.IdMovDetFaturamento;
      If (Not fEmptyStr(ARetornoConsignacaoDetalhe.CodigoProdutoAcabado)) Then
        LQuery.ParamByName('CODACA').AsString  := ARetornoConsignacaoDetalhe.CodigoProdutoAcabado;
      LQuery.ExecSQL;

    Finally
      FreeAndNil(LQuery);
    End;

    Result := True;

  Except
    On E : Exception Do
    Begin
      Result := False;
      AMensagem := E.Message;
    End;
  End;

end;

procedure TRetornoConsignacaoDetalheRepositorio.pApagarConsignacaoRetornoDetalhe(ANumeroDoDocumentoDoFaturamento, AEspecieDoDocumentoDoFaturamento,
  AEmpresaDoDocumentoDoFaturamento, AstrNomeFormulario: String);
  Var
    LQuery,
    LQueryDelete : TUniQuery;
Begin
  LQuery        := fCriaQuery;
  LQueryDelete  := fCriaQuery;
  Try
    LQueryDelete.Sql.Text := 'DELETE FROM CONRED WHERE AUTOINCREM = :AUTINC ';

    LQuery.SQL.Text := ' SELECT * FROM CONRED '+
                       ' WHERE RED_DOCFAT = :DOCFAT '+
                       '   AND RED_ESPFAT = :ESPFAT '+
                       '   AND RED_EMPFAT = :EMPFAT ';
    LQuery.ParamByName('DOCFAT').AsString  := ANumeroDoDocumentoDoFaturamento;
    LQuery.ParamByName('ESPFAT').AsString  := AEspecieDoDocumentoDoFaturamento;
    LQuery.ParamByName('EMPFAT').AsString  := AEmpresaDoDocumentoDoFaturamento;
    LQuery.Open;

    while not LQuery.Eof do
    Begin
      fVerificaIntegridade(AstrNomeFormulario, 'CONRED', LQuery);

      LQueryDelete.ParamByname('AUTINC').AsString := LQuery.FieldByName('AUTOINCREM').AsString;
      LQueryDelete.ExecSql;

      LQuery.next;
    End;

  Finally
    FreeAndNil(LQuery);
    FreeAndNil(LQueryDelete);
  End;
end;

{ TFaturamentoConsignacao }

class function TFaturamentoConsignacao.fGetValorParaBaixaDaDuplicata(AstrIDProduto: String; AfltQuantidadeFaturada: Double): Double;
  Var
    LQuery : TUniQuery;
Begin
  Result := 0;

  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Text := ' SELECT D.DET_VLRCON, D.DET_QTDITE '+
                       '   FROM MOVDET D '+
                       '  WHERE D.AUTOINCREM = :AUTOINCREM ';
    LQuery.ParamByName('AUTOINCREM').AsString  := AstrIDProduto;
    LQuery.Open;
    if not LQuery.IsEmpty then
      Result := fFormataFloat((AfltQuantidadeFaturada/LQuery.FieldByName('DET_QTDITE').AsFloat) * LQuery.FieldByName('DET_VLRCON').AsFloat, 2);

  Finally
    FreeAndNil(LQuery);
  End;

end;

end.
