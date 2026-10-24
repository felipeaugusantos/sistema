unit Fulfillment.RegrasMovimentacaoEstoque;

interface

uses
  Uni, System.SysUtils, System.StrUtils, Data.DB;

Type

  TOperacao = (opNaoDefinida,
               opRemessa,
               opVenda,
               opDevolucao,
               opRetorno,
               opTransferencia,
               opOrdemProducao,
               opOrdemProducaoRemessa,
               opBaixaLotesWMS,
               opBaixaLotesWMSRemessa);

  TTipoEstoque = (teExterno, teFisico, teTodos);

  TOperacaoHelper = record helper for TOperacao
    function GetValue(ADescricao : String) : TOperacao;
    function GetDescricao : String;
    function Equals(AOperacao : TOperacao) : Boolean;
  end;

  TTipoEstoqueHelper = record helper for TTipoEstoque
    function GetValue(ASigla : String) : TTipoEstoque;
  end;

  TBooleanHelper = record helper for Boolean
    function ToFilKar: Boolean;
    function ToFilFul: Boolean;
  end;

  FulfillmentRegrasMovimentacaoEstoque = Record
    MovimentaEstoqueExterno : Boolean;
    MovimentaEstoqueFisico  : Boolean;
    GeraAjusteDeEstoque     : Boolean;
    EntradaSaida            : String;
    EntradaSaidaExterno     : String;
    InformacaoAdicional     : String;
    TipoDeLogistica         : String;
    Operacao                : TOperacao;
  End;

  FulfillmentRegrasMovimentacaoEstoqueHelper = record helper for FulfillmentRegrasMovimentacaoEstoque
    procedure Limpar;
  end;

  IRegrasParametros = Interface
  ['{F19C6D94-EE9A-4E70-A635-74EAF27D79CB}']
    function ClaFis(const AValue : String) : IRegrasParametros; Overload;
    function ClaFis : String; Overload;

    function SigMkp(const AValue : String) : IRegrasParametros; Overload;
    function SigMkp : String; Overload;

    function CodEmp(const AValue : String) : IRegrasParametros; Overload;
    function CodEmp : String; Overload;

    function TemRef(const AValue : Boolean) : IRegrasParametros; Overload;
    function TemRef : Boolean; Overload;

    function ChaAce(const AValue : String) : IRegrasParametros; Overload;
    function ChaAce : String; Overload;

    function InfAdi(const AValue : String) : IRegrasParametros; Overload;
    function InfAdi : String; Overload;

    function Logist(const AValue : String) : IRegrasParametros; Overload;
    function Logist : String; Overload;

    function Operac(const AValue : TOperacao) : IRegrasParametros; Overload;
    function Operac : TOperacao; Overload;

    function ChaRef(const AValue : String) : IRegrasParametros; Overload;
    function ChaRef : String; Overload;

    function TxtMGL(const AValue : String) : IRegrasParametros; Overload;
    function TxtMGL : String; Overload;

    function BuscaDadosNfeImp(const AValue : Boolean) : IRegrasParametros; Overload;
    function BuscaDadosNfeImp : Boolean; Overload;

    procedure SetCamposAuxiliares;

  End;

  TRegrasParametros = Class(TInterfacedObject, IRegrasParametros)
  private
    FClaFis : String;
    FSigMkp : String;
    FCodEmp : String;
    FTemRef : Boolean;
    FChaAce : String;
    FInfAdi : String;
    FLogist : String;
    FOperac : TOperacao;
    FChaRef : String;
    FTxtMGL : String;
    FBuscaDadosNfeImp : Boolean;
    constructor Create;
  public

    function ClaFis(const AValue : String) : IRegrasParametros; Overload;
    function ClaFis : String; Overload;

    function SigMkp(const AValue : String) : IRegrasParametros; Overload;
    function SigMkp : String; Overload;

    function CodEmp(const AValue : String) : IRegrasParametros; Overload;
    function CodEmp : String; Overload;

    function TemRef(const AValue : Boolean) : IRegrasParametros; Overload;
    function TemRef : Boolean; Overload;

    function ChaAce(const AValue : String) : IRegrasParametros; Overload;
    function ChaAce : String; Overload;

    function InfAdi(const AValue : String) : IRegrasParametros; Overload;
    function InfAdi : String; Overload;

    function Logist(const AValue : String) : IRegrasParametros; Overload;
    function Logist : String; Overload;

    function Operac(const AValue : TOperacao) : IRegrasParametros; Overload;
    function Operac : TOperacao; Overload;

    function ChaRef(const AValue : String) : IRegrasParametros; Overload;
    function ChaRef : String; Overload;

    function TxtMGL(const AValue : String) : IRegrasParametros; Overload;
    function TxtMGL : String; Overload;

    function BuscaDadosNfeImp(const AValue : Boolean) : IRegrasParametros; Overload;
    function BuscaDadosNfeImp : Boolean; Overload;

    procedure SetCamposAuxiliares;
    class function New : IRegrasParametros;

  End;

  IRegrasMovimentacaoEstoque = Interface
  ['{A17A7B0E-9A0A-4220-BF52-20369FA715B3}']
    function ProcessarRegras : FulfillmentRegrasMovimentacaoEstoque;
  End;

  TRegraMovimentacaoEstoque = Class(TInterfacedObject, IRegrasMovimentacaoEstoque)
  private
    FParametros : IRegrasParametros;
    FExisteCamposDevParcial : Boolean;
    constructor Create(AParametros : IRegrasParametros);
    function SQL : String;
    function ExisteNotaReferenciada : Boolean;
    function BuscaNotaReferenciada(const AChaAce : String) : String;
    function BuscaInformacaoAdicional(const AChaAce : String) : String;
    function ProcessaRegrasDevolucaoParcial(const ADevParProcess : String) : Boolean;
    function ValidaCamposDevParcial : Boolean;
  public
    class function New(AParametros : IRegrasParametros) : IRegrasMovimentacaoEstoque;
    function ProcessarRegras : FulfillmentRegrasMovimentacaoEstoque;
  End;

  function FulfillmentMovimentacaoEstoque(AClaFis,
                                          AChaAce : String;
                                          ASigMkp : String    = '';
                                          AOperac : TOperacao = opNaoDefinida) : FulfillmentRegrasMovimentacaoEstoque;

  function CfgSisFulfillment(ACodCfg, ASigMkp: String; ACodEmp: String = ''): String;
  function EhDocumentoCrossDocking(const AChaAce, AStatus, ACodEmp, AClaFis, AArqXml: String): Boolean;
  function LocalizaCodIte(const ACodBar, ACodNfe, AHubMkp, ACodEmp: String): String;

  function FulfillmentSelectClassificacao(AOperacao : TOperacao; ASigMkp : String) : String;
  function FulfillmentRegrasESTFUL_OK(AAcesso : String; Out AMensagem : String) : Boolean;

  function MensagemValidacao01 : String;
  function MensagemValidacao02 : String;
  function MensagemValidacao03 : String;
  function MensagemValidacao04 : String;
  function MensagemValidacao05 : String;
  function MensagemValidacao06 : String;

implementation

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core;
{$ELSE}
  untFuncoesSimples;
{$ENDIF}

{ TRegrasParametros }

function TRegrasParametros.BuscaDadosNfeImp(const AValue: Boolean): IRegrasParametros;
begin
  FBuscaDadosNfeImp := AValue;
  Result := Self;
end;

function TRegrasParametros.BuscaDadosNfeImp: Boolean;
begin
  Result := FBuscaDadosNfeImp;
end;

function TRegrasParametros.ChaAce(const AValue: String): IRegrasParametros;
begin
  FChaAce := AValue;
  Result  := Self;
end;

function TRegrasParametros.ChaAce: String;
begin
  Result := FChaAce;
end;

function TRegrasParametros.ClaFis: String;
begin
  Result := FClaFis;
end;

function TRegrasParametros.CodEmp(const AValue: String): IRegrasParametros;
begin
  FCodEmp := AValue;
  Result  := Self;
end;

function TRegrasParametros.CodEmp: String;
begin
  Result := FCodEmp;
end;

function TRegrasParametros.ClaFis(const AValue: String): IRegrasParametros;
begin
  FClaFis := AValue;
  Result  := Self;
end;

function TRegrasParametros.ChaRef(const AValue: String): IRegrasParametros;
begin
  FChaRef := AValue;
  FTemRef := Not fEmptyStr(AValue);
  Result  := Self;
end;

function TRegrasParametros.ChaRef: String;
begin
  Result := FChaRef;
end;

constructor TRegrasParametros.Create;
begin
  Self.FClaFis := '';;
  Self.FSigMkp := '';
  Self.FCodEmp := '';
  Self.FTemRef := False;
  Self.FChaAce := '';
  Self.FInfAdi := '';
  Self.FLogist := '';
  Self.FOperac := opNaoDefinida;
  Self.FChaRef := '';
  Self.FTxtMGL := '';
  Self.FBuscaDadosNfeImp := True;
end;

class function TRegrasParametros.New: IRegrasParametros;
begin
  Result := TRegrasParametros.Create;
end;

function TRegrasParametros.Operac(const AValue: TOperacao): IRegrasParametros;
begin
  FOperac := AValue;
  Result  := Self;
end;

function TRegrasParametros.Operac: TOperacao;
begin
  Result := FOperac;
end;

function TRegrasParametros.TemRef(const AValue: Boolean): IRegrasParametros;
begin
  FTemRef := AValue;
  Result  := Self;
end;

function TRegrasParametros.TemRef: Boolean;
begin
  Result := FTemRef;
end;

function TRegrasParametros.InfAdi(const AValue: String): IRegrasParametros;
begin
  FInfAdi := AValue;
  Result  := Self;
end;

function TRegrasParametros.InfAdi: String;
begin
  Result := FInfAdi;
end;

function TRegrasParametros.Logist(const AValue: String): IRegrasParametros;
begin
  FLogist := AValue;
  Result  := Self;
end;

function TRegrasParametros.Logist: String;
begin
  Result := FLogist;
end;

function TRegrasParametros.TxtMGL(const AValue: String): IRegrasParametros;
begin
  FTxtMGL := AValue;
  Result  := Self;
end;

function TRegrasParametros.TxtMGL: String;
begin
  Result := FTxtMGL;
end;

procedure TRegrasParametros.SetCamposAuxiliares;
  var
    LNfeImp : TUniQuery;

  function GetSQL: String;
  begin
    Result := '';
    Result := Result + 'SELECT ';
    Result := Result + '  NFE_HUBMKP, ';
    Result := Result + '  NFE_CODEMP, ';

    If fCampoExiste('NFEIMP', 'NFE_TXTMGL') Then
      Result := Result + '  NFE_TXTMGL, '
    Else
      Result := Result + '  "" AS NFE_TXTMGL, ';

    Result := Result + '  IFNULL(NULLIF(NFE_LOGIST,""), "fulfillment") AS NFE_LOGIST, ';
    Result := Result + '  IFNULL(NFE_REFNFE, EXTRACTVALUE(NFE_ARQXML, "/nfeProc/NFe/infNFe/ide/NFref/refNFe")) AS CHAVE_REF, ';
    Result := Result + '  EXTRACTVALUE(NFE_ARQXML, "/nfeProc/NFe/infNFe/infAdic/obsCont/xTexto") AS INF_ADIC, ';
    Result := Result + '  EXTRACTVALUE(NFE_ARQXML, "/nfeProc/NFe/infNFe/infAdic/infCpl") AS INF_CPL, ';
    Result := Result + '  IF(POSITION("</CFOP>" IN NFE_ARQXML) > 0, SUBSTRING(NFE_ARQXML, POSITION("</CFOP>" IN NFE_ARQXML) -4, 4), "") AS CLAFIS ';
    Result := Result + 'FROM       ';
    Result := Result + '  NFEIMP ';
    Result := Result + 'WHERE      ';
    Result := Result + '  NFE_ACESSO = :ACESSO AND ';
    Result := Result + '  NFE_STATUS IN ("AT", "EE", "DN")';
   end;
begin

  If Not FBuscaDadosNfeImp Then
    Exit;

  If FChaAce.IsEmpty Then
    Exit;

  LNfeImp := fCriaQuery;

  Try

    LNfeImp.SQL.Add(GetSQL);
    LNfeImp.ParamByName('ACESSO').AsString := FChaAce;
    LNfeImp.Open;

    If LNfeImp.IsEmpty Then
      Exit;

    FSigMkp := LNfeImp.FieldByName('NFE_HUBMKP').AsString;
    FCodEmp := LNfeImp.FieldByName('NFE_CODEMP').AsString;
    FChaRef := LNfeImp.FieldByName('CHAVE_REF').AsString;
    FTemRef := Not fEmptyStr(LNfeImp.FieldByName('CHAVE_REF').AsString);
    FInfAdi := AnsiUpperCase(IIF(FSigMkp.Equals('MGL'),
                                 fRemoveAcento(LNfeImp.FieldByName('INF_CPL').AsString),
                                 LNfeImp.FieldByName('INF_ADIC').AsString)).Trim;
    FTxtMGL := AnsiUpperCase(LNfeImp.FieldByName('NFE_TXTMGL').AsString).Trim;
    FLogist := LNfeImp.FieldByName('NFE_LOGIST').AsString;

    If (FClaFis.IsEmpty) And (Not LNfeImp.FieldByName('CLAFIS').AsString.IsEmpty) Then
      FClaFis := LNfeImp.FieldByName('CLAFIS').AsString;

  Finally
    FreeAndNil(LNfeImp);
  End;

end;

function TRegrasParametros.SigMkp: String;
begin
  Result := FSigMkp;
end;

function TRegrasParametros.SigMkp(const AValue: String): IRegrasParametros;
begin
  FSigMkp := AValue;
  Result  := Self;
end;

{ TRegraMovimentacaoEstoque }

constructor TRegraMovimentacaoEstoque.Create(AParametros: IRegrasParametros);
begin
  FParametros := AParametros;

  FExisteCamposDevParcial := ValidaCamposDevParcial;
end;

class function TRegraMovimentacaoEstoque.New(AParametros: IRegrasParametros): IRegrasMovimentacaoEstoque;
begin
  Result := TRegraMovimentacaoEstoque.Create(AParametros);
end;

function TRegraMovimentacaoEstoque.ProcessarRegras: FulfillmentRegrasMovimentacaoEstoque;
  var
    LEstFul        : TUniQuery;
    LEntrada_Saida : String;
    LOperacao      : TOperacao;
    LTipoEstoque   : TTipoEstoque;
    LProcess       : String;
    LValRef        : String;
    LEh_Ref        : String;
    LValidouRegra  : Boolean;
    LEntrada_Saida_Ext   : String;
    LMovEstoqueExterno   : Boolean;
    LMovEstoqueFisico    : Boolean;
    LGeraAjusteDeEstoque : Boolean;
    LDevolucaoParcial    : Boolean;
    LDevParProcess       : String;
    LTipoDeLogistica     : String;
    LMethod              : String;
begin

  Result := Default(FulfillmentRegrasMovimentacaoEstoque);

  FParametros.SetCamposAuxiliares;

  If FParametros.ClaFis.IsEmpty Then
    Exit;

  If FParametros.SigMkp.IsEmpty Then
    Exit;

  LEstFul := fCriaQuery;

  Try

    LEstFul.SQL.Add(SQL);
    LEstFul.ParamByName('HUBMKP').AsString := FParametros.SigMkp;
    LEstFul.ParamByName('CLAFIS').AsString := FParametros.ClaFis;

    If Not FParametros.Operac.Equals(opNaoDefinida) Then
      LEstFul.ParamByName('OPERAC').AsString := FParametros.Operac.GetDescricao;

    LEstFul.Open;

    If LEstFul.IsEmpty Then
      Exit;

    LValidouRegra        := False;
    LMovEstoqueExterno   := False;
    LMovEstoqueFisico    := False;
    LGeraAjusteDeEstoque := False;
    LDevolucaoParcial    := False;

    LEstFul.First;

    While Not LEstFul.Eof Do
    Begin

      LEntrada_Saida := AnsiUpperCase(LEstFul.FieldByName('FUL_ENTSAI').AsString);
      LOperacao      := LOperacao.GetValue(LEstFul.FieldByName('FUL_OPERAC').AsString);
      LProcess       := AnsiUpperCase(LEstFul.FieldByName('FUL_PROCES').AsString).Trim;
      LTipoEstoque   := LTipoEstoque.GetValue(LEstFul.FieldByName('FUL_TIPEST').AsString);
      LValRef        := AnsiUpperCase(LEstFul.FieldByName('FUL_VALREF').AsString);
      LEh_Ref        := AnsiUpperCase(LEstFul.FieldByName('FUL_EH_REF').AsString);
      LGeraAjusteDeEstoque := AnsiUpperCase(LEstFul.FieldByName('FUL_GERAJU').AsString).Equals('S');
      LDevolucaoParcial    := AnsiUpperCase(LEstFul.FieldByName('FUL_DEVPAR').AsString).Equals('S');
      LDevParProcess       := AnsiUpperCase(LEstFul.FieldByName('FUL_DEVPAR_PROCES').AsString).Trim;
      LTipoDeLogistica     := LEstFul.FieldByName('FUL_LOGIST').AsString;
      LEntrada_Saida_Ext   := LEntrada_Saida;
      LMethod              := AnsiLowerCase(LEstFul.FieldByName('FUL_METHOD').AsString).Trim;

      Result.Operacao := LOperacao;

      LMovEstoqueExterno := LTipoEstoque In [teTodos, teExterno];
      LMovEstoqueFisico  := LTipoEstoque In [teTodos, teFisico];

      If LMovEstoqueExterno And (Not LEstFul.FieldByName('FUL_FULE_S').AsString.IsEmpty) Then
        LEntrada_Saida_Ext := AnsiUpperCase(LEstFul.FieldByName('FUL_FULE_S').AsString);

      If (Not FParametros.TxtMGL.IsEmpty) Then
      Begin
        //Magalu utiliza apenas 2 letras no process (ex: MP/DV/RS)
        //Foi usado "/" para não correr o risco de coincidir com alguma parte do InfAdi
        If AnsiUpperCase(LEstFul.FieldByName('FUL_TEMREF').AsString).Equals('I') Then
          If (Not LProcess.Replace('/','').IsEmpty) And FParametros.TxtMGL.StartsWith(LProcess.Replace('/','')) Then
          Begin
            LValidouRegra := True;
            Break;
          End;

        LEstFul.Next;
        Continue;
      End;

      If AnsiUpperCase(LEstFul.FieldByName('FUL_TEMREF').AsString).Equals('I') And (Not LProcess.IsEmpty) Then
      Begin
        If (Not MatchText(LMethod, ['contains', 'startswith', 'equals'])) Then
          LMethod := 'contains';

        If SameText(LMethod, 'contains') And FParametros.InfAdi.Contains(LProcess) Then
          LValidouRegra := True

        Else If SameText(LMethod, 'startswith') And FParametros.InfAdi.StartsWith(LProcess) Then
          LValidouRegra := True

        Else If SameText(LMethod, 'equals') And FParametros.InfAdi.Equals(LProcess) Then
          LValidouRegra := True;

        If LValidouRegra Then
        Begin
          Result.InformacaoAdicional := LProcess;
          Break;
        End;
      End;

      If AnsiUpperCase(LEstFul.FieldByName('FUL_TEMREF').AsString).Equals('S') Then
        If FParametros.TemRef Then
        Begin
          LValidouRegra := True;
          Break;
        End;

      If AnsiUpperCase(LEstFul.FieldByName('FUL_TEMREF').AsString).Equals('N') Then
        If Not FParametros.TemRef Then
        Begin
          LValidouRegra := True;
          Break;
        End;

      LEstFul.Next;

    End;

    If LValidouRegra And LValRef.Equals('S') Then
    Begin
      If LEh_Ref.Equals('N') Then
        If ExisteNotaReferenciada Then
          LValidouRegra := False;

      If LEh_Ref.Equals('S') Then
        If Not ExisteNotaReferenciada Then
          LValidouRegra := False;
    End;

    If LValidouRegra And LDevolucaoParcial And FExisteCamposDevParcial Then
    Begin
      If (LMovEstoqueExterno Or LMovEstoqueFisico) Then
        LValidouRegra := ProcessaRegrasDevolucaoParcial(LDevParProcess);
    End;

    If (LValidouRegra) Then
    Begin
      Result.MovimentaEstoqueExterno := LMovEstoqueExterno;
      Result.MovimentaEstoqueFisico  := LMovEstoqueFisico;
      Result.EntradaSaida            := LEntrada_Saida;
      Result.EntradaSaidaExterno     := LEntrada_Saida_Ext;
      Result.GeraAjusteDeEstoque     := LGeraAjusteDeEstoque;
      Result.TipoDeLogistica         := LTipoDeLogistica;
    End;

  Finally
    FreeAndNil(LEstFul);
  End;

end;

function TRegraMovimentacaoEstoque.ProcessaRegrasDevolucaoParcial(const ADevParProcess : String): Boolean;
  var
    LChaRef : String;
    LInfAdi : String;
begin
  Result := False;

  If FParametros.ChaRef.IsEmpty Then
    Exit;

  LChaRef := BuscaNotaReferenciada(FParametros.ChaRef);

  If LChaRef.IsEmpty Then
    Exit;

  LInfAdi := AnsiUpperCase(BuscaInformacaoAdicional(LChaRef));

  If LInfAdi.IsEmpty Then
    Exit;

  If Not LInfAdi.Contains(ADevParProcess) Then
    Exit;

  Result := True;
end;

function TRegraMovimentacaoEstoque.SQL: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  FUL_ENTSAI, ';
  Result := Result + '  FUL_OPERAC, ';
  Result := Result + '  FUL_TEMREF, ';
  Result := Result + '  FUL_TIPEST, ';
  Result := Result + '  FUL_PROCES, ';
  Result := Result + '  FUL_VALREF, ';
  Result := Result + '  FUL_EH_REF, ';
  Result := Result + '  FUL_GERAJU, ';
  Result := Result + '  FUL_LOGIST, ';

  If FExisteCamposDevParcial Then
  Begin
    Result := Result + '  FUL_DEVPAR, ';
    Result := Result + '  FUL_DEVPAR_PROCES, ';
  End
  Else
  Begin
    Result := Result + '  "" AS FUL_DEVPAR, ';
    Result := Result + '  "" AS FUL_DEVPAR_PROCES, ';
  End;

  If fCampoExiste('ESTFUL', 'FUL_FULE_S') Then
    Result := Result + '  FUL_FULE_S, '
  Else
    Result := Result + '  "" AS FUL_FULE_S, ';

  If fCampoExiste('ESTFUL', 'FUL_METHOD') Then
    Result := Result + '  IFNULL(NULLIF(FUL_METHOD,""), "contains") AS FUL_METHOD, '
  Else
    Result := Result + '  "contains" AS FUL_METHOD, ';

  Result := Result + '    (CASE FUL_TEMREF ';
  Result := Result + '     WHEN "I" THEN 1 ';
  Result := Result + '     WHEN "S" THEN 2 ';
  Result := Result + '     WHEN "N" THEN 3 ';
  Result := Result + '     ELSE 4 END) AS PRIORIDADE ';

  Result := Result + 'FROM          ';
  Result := Result + '  ESTFUL      ';
  Result := Result + 'WHERE FUL_HUBMKP = :HUBMKP ';
  Result := Result + '  AND FUL_CLAFIS = :CLAFIS ';

  If Not FParametros.Operac.Equals(opNaoDefinida) Then
    Result := Result + '  AND UPPER(FUL_OPERAC) = :OPERAC ';

  If Not FParametros.Logist.IsEmpty Then
    If CfgSisFulfillment('IMPFUL', FParametros.SigMkp, FParametros.CodEmp).Equals('N') Then
      Result := Result + '  AND FUL_LOGIST = "' + FParametros.Logist + '" ';

  Result := Result + 'ORDER BY PRIORIDADE ';

end;

function TRegraMovimentacaoEstoque.ValidaCamposDevParcial: Boolean;
begin
  Result := False;

  If Not fCampoExiste('ESTFUL', 'FUL_DEVPAR') Then
    Exit;

  If Not fCampoExiste('ESTFUL', 'FUL_DEVPAR_PROCES') Then
    Exit;

  If Not fCampoExiste('NFEIMP', 'NFE_XTEXTO') Then
    Exit;

  Result := True;
end;

function TRegraMovimentacaoEstoque.BuscaNotaReferenciada(const AChaAce: String): String;
begin
  Result := fCampoTabela('NFE_REFNFE', 'NFEIMP', ['NFE_ACESSO', 'NFE_STATUS'], [AChaAce, 'AT']);
end;

function TRegraMovimentacaoEstoque.BuscaInformacaoAdicional(const AChaAce: String): String;
begin
  Result := fCampoTabela('NFE_XTEXTO', 'NFEIMP', ['NFE_ACESSO', 'NFE_STATUS'], [AChaAce, 'AT']);
end;

function TRegraMovimentacaoEstoque.ExisteNotaReferenciada: Boolean;
begin
  Result := False;

  If FParametros.ChaAce.IsEmpty Then
    Exit;

  If FParametros.CodEmp.IsEmpty Then
    Exit;

  If FParametros.SigMkp.IsEmpty Then
    Exit;

  Result := fCampoTabela('COUNT(0)', 'NFEIMP',
                        ['NFE_REFNFE', 'NFE_CODEMP', 'NFE_HUBMKP'],
                        [FParametros.ChaAce, FParametros.CodEmp, FParametros.SigMkp]) > 0;
end;

function FulfillmentMovimentacaoEstoque(AClaFis,
                                        AChaAce : String;
                                        ASigMkp : String    = '';
                                        AOperac : TOperacao = opNaoDefinida) : FulfillmentRegrasMovimentacaoEstoque;
begin
  Result := TRegraMovimentacaoEstoque.New(
              TRegrasParametros.New()
                .ClaFis(AClaFis)
                .ChaAce(AChaAce)
                .SigMkp(ASigMkp)
                .Operac(AOperac)
            ).ProcessarRegras;
end;

function CfgSisFulfillment(ACodCfg, ASigMkp: String; ACodEmp: String = ''): String;
begin
  Result := EmptyStr;

  If ACodCfg.IsEmpty Then
    Exit;

  If ASigMkp.IsEmpty Then
    Exit;

  If ACodEmp.IsEmpty Then
    ACodEmp := VS_strCodEmp;

  Result := fCampoTabela('SIS_VALCFG', 'FULL_CFGSIS',
                        ['SIS_CODCFG', 'SIS_HUBMKP', 'SIS_CODEMP'],
                        ['CFG_' + ACodCfg, ASigMkp, ACodEmp], False);
end;

function EhDocumentoCrossDocking(const AChaAce, AStatus, ACodEmp, AClaFis, AArqXml: String): Boolean;
  var
    LLogist: String;
    LValCfg: String;
begin
  Result := False;

  If AStatus.Equals('IN') Then
    Exit;

  If AStatus.Equals('CN') Then
  Begin
    LLogist := fCampoTabela('NFE_LOGIST', 'NFEIMP', ['NFE_ACESSO', 'NFE_STATUS'], [AChaAce, 'AT']);

    Result := LLogist.Equals('cross_docking');
    Exit;
  End;

  If Not AClaFis.IsEmpty Then
  Begin
    LValCfg := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [ACodEmp, 'CFG_CROCFO'], False);

    If Not LValCfg.IsEmpty Then
      If LValCfg.Contains(AClaFis) Then
        Exit(True);
  End;

  If Not AArqXml.IsEmpty Then
    Result := (Not AArqXml.Contains('<xTexto>'));
end;

function LocalizaCodIte(const ACodBar, ACodNfe, AHubMkp, ACodEmp: String): String;
var
  qryAux: TUniQuery;
begin
  Result := EmptyStr;

  qryAux := fCriaQuery;
  try
    qryAux.SQL.Add('SELECT ITE_CODAUT AS CODITE');
    qryAux.SQL.Add('FROM FULL_CODITE');
    qryAux.SQL.Add('WHERE ITE_HUBMKP = :HUBMKP');
    qryAux.SQL.Add('  AND ITE_CODNFE = :CODNFE');
    qryAux.SQL.Add('  AND ITE_CODEMP = :CODEMP');

    qryAux.ParamByName('HUBMKP').AsString := AHubMkp;
    qryAux.ParamByName('CODNFE').AsString := ACodNfe;
    qryAux.ParamByName('CODEMP').AsString := ACodEmp;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
      Result := qryAux.FieldByName('CODITE').AsString;

    If Not Result.IsEmpty Then
      Exit;

    If ACodBar.IsEmpty Or ACodBar.Equals('SEM GTIN') Then
      Exit;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT ITE_CODITE AS CODITE');
    qryAux.SQL.Add('FROM CADITE');
    qryAux.SQL.Add('WHERE ITE_CODBAR = :CODBAR');
    qryAux.SQL.Add(' UNION ');
    qryAux.SQL.Add('SELECT BAR_CODITE AS CODITE');
    qryAux.SQL.Add('FROM ITEBAR');
    qryAux.SQL.Add('WHERE BAR_CODBAR = :CODBAR');

    qryAux.ParamByName('CODBAR').AsString := ACodBar;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
      Result := qryAux.FieldByName('CODITE').AsString;
  finally
    FreeAndNil(qryAux);
  end;
end;

function FulfillmentSelectClassificacao(AOperacao : TOperacao; ASigMkp : String) : String;
begin

  Result := '""';

  If ASigMkp.IsEmpty Then
    Exit;

  If AOperacao.GetDescricao.IsEmpty Then
    Exit;

  Result := 'SELECT FUL_CLAFIS FROM ESTFUL WHERE FUL_HUBMKP = '+ASigMkp.QuotedString+' AND UPPER(FUL_OPERAC) = '+AOperacao.GetDescricao.QuotedString;

end;

function ValidacaoEstFul03(AQry: TUniQuery): Boolean;
begin
  Result := True;

  If AQry.FieldByName('FUL_ENTSAI').IsNull Or
     AQry.FieldByName('FUL_ENTSAI').AsString.IsEmpty Then
    Exit(False);

  If AQry.FieldByName('FUL_OPERAC').IsNull Or
     AQry.FieldByName('FUL_OPERAC').AsString.IsEmpty Then
    Exit(False);

  If AQry.FieldByName('FUL_TEMREF').IsNull Or
     AQry.FieldByName('FUL_TEMREF').AsString.IsEmpty Then
    Exit(False);
end;

function ValidacaoEstFul04(AQry: TUniQuery): Boolean;
begin
  Result := True;

  If AQry.FieldByName('FUL_TIPEST').IsNull Or
     AQry.FieldByName('FUL_TIPEST').AsString.IsEmpty Or
     (Not MatchStr(AQry.FieldByName('FUL_TIPEST').AsString, ['E','F','T'])) Then
    Exit(False);

  If AQry.FieldByName('FUL_TEMREF').AsString.Equals('I') Then
    If AQry.FieldByName('FUL_PROCES').IsNull Or
       AQry.FieldByName('FUL_PROCES').AsString.Trim.IsEmpty Then
      Exit(False);
end;

function FulfillmentRegrasESTFUL_OK(AAcesso : String; Out AMensagem : String) : Boolean;
  const
    SQL_ESTFUL_HUBMKP               = 'SELECT * FROM ESTFUL WHERE FUL_HUBMKP = :HUBMKP';
    SQL_ESTFUL_HUBMKP_CLAFIS        = 'SELECT * FROM ESTFUL WHERE FUL_HUBMKP = :HUBMKP AND FUL_CLAFIS = :CLAFIS';
    SQL_ESTFUL_HUBMKP_CLAFIS_LOGIST = 'SELECT * FROM ESTFUL WHERE FUL_HUBMKP = :HUBMKP AND FUL_CLAFIS = :CLAFIS AND FUL_LOGIST = :LOGIST';

    SQL_NFEIMP  = 'SELECT ' +
                  '  NFE_NUMDOC, ' +
                  '  NFE_ESPDOC, ' +
                  '  NFE_CODEMP, ' +
                  '  NFE_HUBMKP, ' +
                  '  IFNULL(NULLIF(NFE_LOGIST,""), "fulfillment") AS NFE_LOGIST, ' +
                  '  SUBSTRING(NFE_ARQXML, POSITION("<CFOP>" IN NFE_ARQXML)+6, (POSITION("</CFOP>" IN NFE_ARQXML) - POSITION("<CFOP>" IN NFE_ARQXML))-6) AS NFE_NFCFOP ' +
                  'FROM       ' +
                  '  NFEIMP   ' +
                  'WHERE      ' +
                  '  NFE_ACESSO = :ACESSO AND ' +
                  '  NFE_STATUS = "AT"';

  var
    LNota      : TUniQuery;
    LRegra     : TUniQuery;
    LDocumento : String;

begin

  Result := True;

  If AAcesso.IsEmpty Then
    Exit;

  LNota  := fCriaQuery;
  LRegra := fCriaQuery;

  Try

    LNota.Close;
    LNota.SQL.Clear;
    LNota.SQL.Add(SQL_NFEIMP);
    LNota.ParamByName('ACESSO').AsString := AAcesso;
    LNota.Open;

    If LNota.IsEmpty Then
      Exit;

    LDocumento := LNota.FieldByName('NFE_NUMDOC').AsString + '-' +
                  LNota.FieldByName('NFE_ESPDOC').AsString + '-' +
                  LNota.FieldByName('NFE_CODEMP').AsString;

    LRegra.Close;
    LRegra.SQL.Clear;
    LRegra.SQL.Add(SQL_ESTFUL_HUBMKP);
    LRegra.ParamByName('HUBMKP').AsString := LNota.FieldByName('NFE_HUBMKP').AsString;
    LRegra.Open;

    If LRegra.IsEmpty Then
    Begin
      AMensagem := MensagemValidacao01.Replace('[NOTA]', LDocumento, [rfReplaceAll]);
      Exit(False);
    End;

    If (Pos(LNota.FieldByName('NFE_NFCFOP').AsString, fCfgSis('CLAVEN', varString, LNota.FieldByName('NFE_CODEMP').AsString)) > 0) Then
    Begin
      LRegra.Close;
      LRegra.SQL.Clear;
      LRegra.SQL.Add(SQL_ESTFUL_HUBMKP_CLAFIS);
      LRegra.ParamByName('HUBMKP').AsString := LNota.FieldByName('NFE_HUBMKP').AsString;
      LRegra.ParamByName('CLAFIS').AsString := LNota.FieldByName('NFE_NFCFOP').AsString;
      LRegra.Open;

      If LRegra.IsEmpty Then
      Begin
        AMensagem := MensagemValidacao02.Replace('[NOTA]', LDocumento, [rfReplaceAll])
                                        .Replace('[CLAFIS]', LNota.FieldByName('NFE_NFCFOP').AsString);
        Exit(False);
      End;
    End;

    LRegra.Close;
    LRegra.SQL.Clear;
    LRegra.SQL.Add(SQL_ESTFUL_HUBMKP_CLAFIS);
    LRegra.ParamByName('HUBMKP').AsString := LNota.FieldByName('NFE_HUBMKP').AsString;
    LRegra.ParamByName('CLAFIS').AsString := LNota.FieldByName('NFE_NFCFOP').AsString;
    LRegra.Open;

    If LRegra.IsEmpty Then
      Exit;

    LRegra.First;

    While Not LRegra.Eof Do
    Begin

      If Not ValidacaoEstFul03(LRegra) Then
      Begin
        AMensagem := MensagemValidacao03.Replace('[NOTA]', LDocumento, [rfReplaceAll])
                                        .Replace('[CLAFIS]', LNota.FieldByName('NFE_NFCFOP').AsString)
                                        .Replace('[OPERAC]', LRegra.FieldByName('FUL_OPERAC').AsString)
                                        .Replace('[ENTSAI]', LRegra.FieldByName('FUL_ENTSAI').AsString)
                                        .Replace('[TEMREF]', LRegra.FieldByName('FUL_TEMREF').AsString);
        Exit(False);
      End;

      If Not ValidacaoEstFul04(LRegra) Then
      Begin
        AMensagem := MensagemValidacao04.Replace('[NOTA]', LDocumento, [rfReplaceAll])
                                        .Replace('[TEMREF]', LRegra.FieldByName('FUL_TEMREF').AsString)
                                        .Replace('[PROCES]', LRegra.FieldByName('FUL_PROCES').AsString)
                                        .Replace('[TIPEST]', LRegra.FieldByName('FUL_TIPEST').AsString);
        Exit(False);
      End;

      LRegra.Next;

    End;

    If CfgSisFulfillment('IMPFUL',
                         LNota.FieldByName('NFE_HUBMKP').AsString,
                         LNota.FieldByName('NFE_CODEMP').AsString).Equals('N') Then
    Begin
      LRegra.Close;
      LRegra.SQL.Clear;
      LRegra.SQL.Add(SQL_ESTFUL_HUBMKP_CLAFIS_LOGIST);
      LRegra.ParamByName('HUBMKP').AsString := LNota.FieldByName('NFE_HUBMKP').AsString;
      LRegra.ParamByName('CLAFIS').AsString := LNota.FieldByName('NFE_NFCFOP').AsString;
      LRegra.ParamByName('LOGIST').AsString := LNota.FieldByName('NFE_LOGIST').AsString;
      LRegra.Open;

      If LRegra.IsEmpty Then
      Begin
        AMensagem := MensagemValidacao05.Replace('[NOTA]', LDocumento)
                                        .Replace('[LOGIST]', LNota.FieldByName('NFE_LOGIST').AsString)
                                        .Replace('[HUBMKP]', LNota.FieldByName('NFE_HUBMKP').AsString)
                                        .Replace('[CLAFIS]', LNota.FieldByName('NFE_NFCFOP').AsString);
        Exit(False);
      End;

      {Valida PROCES / XTEXTO}
      {
      If Assigned(LNota.FieldByName('NFE_XTEXTO')) And Not fEmptyStr(LNota.FieldByName('NFE_XTEXTO').AsString) Then
      Begin

        LRegra.First;

        While Not LRegra.Eof Do
        Begin

          If Not fEmptyStr(LRegra.FieldByName('FUL_PROCES').AsString) Then
            If LNota.FieldByName('NFE_XTEXTO').AsString.Contains(LRegra.FieldByName('FUL_PROCES').AsString) Then
              Exit(True);

          LRegra.Next;

        End;

        AMensagem := MensagemValidacao06.Replace('[NOTA]', LDocumento)
                                        .Replace('[PROCES]', LNota.FieldByName('NFE_XTEXTO').AsString);
        Exit(False);

      End;
      }

    End;

  Finally
    FreeAndNil(LNota);
    FreeAndNil(LRegra);
  End;

end;

function MensagemValidacao01 : String;
begin
  Result := 'Não foi possível importar a nota [NOTA] porque a movimentação de estoque do full não foi configurada (tabela "ESTFUL").' + #13 +
            'Por favor, entre em contato com a Citel.';
end;

function MensagemValidacao02 : String;
begin
  Result := 'Não foi possível importar a nota [NOTA] porque a CFOP [CLAFIS] está setada na "CFG_CLAVEN" mas não foi configurada na tabela '+
            'de movimentação de estoque (tabela "ESTFUL").' + #13 +
            'Por favor, entre em contato com a Citel.';
end;

function MensagemValidacao03 : String;
begin
  Result := 'Não foi possível importar a nota [NOTA] porque a CFOP [CLAFIS] não está configurada corretamente na tabela de movimentação de estoque '+
            '(tabela "ESTFUL", campos FUL_OPERAC: "[OPERAC]" / FUL_ENTSAI: "[ENTSAI]" / FUL_TEMREF: "[TEMREF]").' + #13 +
            'Por favor, entre em contato com a Citel.';
end;

function MensagemValidacao04 : String;
begin
  Result := 'Não foi possível importar a nota [NOTA] porque o tipo de movimentação de estoque não está configurado corretamente '+
            '(tabela "ESTFUL", campos FUL_TEMREF: "[TEMREF]" / FUL_PROCES: "[PROCES]" / FUL_TIPEST: "[TIPEST]").'+ #13 +
            'Por favor, entre em contato com a Citel.';
end;

function MensagemValidacao05 : String;
begin
  Result := 'Não foi possível importar a nota [NOTA] porque o tipo de logística não está configurado corretamente '+
            '(tabela "ESTFUL", campos FUL_HUBMKP: "[HUBMKP]" / FUL_CLAFIS: "[CLAFIS]" / FUL_LOGIST: "[LOGIST]").' + #13 +
            'Por favor, entre em contato com a Citel.';
end;

function MensagemValidacao06 : String;
begin
  Result := 'Não foi possível importar a nota [NOTA] porque a CFOP dela não está configurada corretamente na tabela de movimentação de estoque (tabela "ESTFUL", campos ' +
            '"FUL_OPERAC", "FUL_ENTSAI", "FUL_TEMREF" e "FUL_PROCES"), FUL_PROCES da nota = [PROCES].' + #13 +
            'Por favor, entre em contato com a Citel.';
end;

{ TBooleanHelper }

function TBooleanHelper.ToFilFul: Boolean;
begin
  // FilFul = 0 - False : Movimenta estoque
  // FilFul = 1 - True  : Não movimenta estoque
  Result := IIF(Self, False, True);
end;

function TBooleanHelper.ToFilKar: Boolean;
begin
  // FilKar = 0 - False : Movimenta estoque
  // FilKar = 1 - True  : Não movimenta estoque
  Result := IIF(Self, False, True);
end;

{ TOperacaoHelper }

function TOperacaoHelper.GetDescricao: String;
begin
  Case Self Of
    opRemessa              : Result := 'REMESSA';
    opVenda                : Result := 'VENDA';
    opDevolucao            : Result := 'DEVOLUCAO';
    opRetorno              : Result := 'RETORNO';
    opTransferencia        : Result := 'TRANSFERENCIA';
    opOrdemProducao        : Result := 'ORDEM DE PRODUCAO';
    opOrdemProducaoRemessa : Result := 'ORDEM DE PRODUCAO - REMESSA';
    opBaixaLotesWMS        : Result := 'BAIXA LOTES WMS';
    opBaixaLotesWMSRemessa : Result := 'BAIXA LOTES WMS - REMESSA';
    opNaoDefinida          : Result := '';
  End;
end;

function TOperacaoHelper.GetValue(ADescricao : String): TOperacao;
  var
    LDescricao : String;
begin

  LDescricao := AnsiUpperCase(fRemoveAcento(ADescricao));

  Result := opNaoDefinida;

  If LDescricao.Equals('REMESSA') Then
    Result := opRemessa
  Else
  If LDescricao.Equals('VENDA') Then
    Result := opVenda
  Else
  If LDescricao.Equals('DEVOLUCAO') Then
    Result := opDevolucao
  Else
  If LDescricao.Equals('RETORNO') Then
    Result := opRetorno
  Else
  If LDescricao.Equals('TRANSFERENCIA') Then
    Result := opTransferencia
  Else
  If LDescricao.Equals('ORDEM DE PRODUCAO') Then
    Result := opOrdemProducao
  Else
  If LDescricao.Equals('ORDEM DE PRODUCAO - REMESSA') Then
    Result := opOrdemProducaoRemessa
  Else
  If LDescricao.Equals('BAIXA LOTES WMS') Then
    Result := opBaixaLotesWMS
  Else
  If LDescricao.Equals('BAIXA LOTES WMS - REMESSA') Then
    Result := opBaixaLotesWMSRemessa;

end;

function TOperacaoHelper.Equals(AOperacao : TOperacao): Boolean;
begin
  Result := Self = AOperacao;
end;

{ TTipoEstoqueHelper }

function TTipoEstoqueHelper.GetValue(ASigla : String): TTipoEstoque;
begin

  Result := teTodos;

  If ASigla.IsEmpty Then
    Exit;

  Case AnsiUpperCase(ASigla)[1] Of
    'E': Result := teExterno;
    'F': Result := teFisico;
  End;

end;

{ FulfillmentRegrasMovimentacaoEstoqueHelper }

procedure FulfillmentRegrasMovimentacaoEstoqueHelper.Limpar;
begin
  Self.MovimentaEstoqueExterno := False;
  Self.MovimentaEstoqueFisico  := False;
  Self.EntradaSaida := EmptyStr;
  Self.Operacao     := opNaoDefinida;
end;

end.
