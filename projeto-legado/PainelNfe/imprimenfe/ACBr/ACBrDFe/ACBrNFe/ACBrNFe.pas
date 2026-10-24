unit ACBrNFe;

interface

uses
  Classes, SysUtils, ACBrBase,
  ACBrDFe, ACBrDFeException,
  ACBrNFeNotasFiscais,
  ACBrNFeDANFEClass,
  untNFe, untConversao, untConversaoNFe,   ACBrUtil;

const
  ACBRNFE_VERSAO = '2.0.0a';
  ACBRNFE_NAMESPACE = 'http://www.portalfiscal.inf.br/nfe';
  CErroAmbienteDiferente = 'Ambiente do XML (tpAmb) é diferente do '+
     'configurado no Componente (Configuracoes.WebServices.Ambiente)';

type
  EACBrNFeException = class(EACBrDFeException);


  { TACBrNFe }
  {$IFDEF UNIDAC}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF UNIDAC}
  TACBrNFe = class(TACBrDFe)
  private
    FDANFE: TACBrNFeDANFEClass;
    FNotasFiscais: TNotasFiscais;
    FStatus: TStatusACBrNFe;

    procedure SetDANFE(const Value: TACBrNFeDANFEClass);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function GetAbout: String; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;


    function GetNameSpaceURI: String; override;
    function EhAutorizacao(AVersao: TVersaoDF; AModelo: TModeloDF;
      AUFCodigo: Integer): Boolean;

    function CstatConfirmada(AValue: integer): Boolean;
    function CstatProcessado(AValue: integer): Boolean;
    function CstatCancelada(AValue: integer): Boolean;


    function IdentificaSchema(const AXML: String): TSchemaNFe;
    function GerarChaveContingencia(FNFe: TNFe): String;

    property NotasFiscais: TNotasFiscais read FNotasFiscais write FNotasFiscais;
    property Status: TStatusACBrNFe read FStatus;

    procedure SetStatus(const stNewStatus: TStatusACBrNFe);

  published
    property DANFE: TACBrNFeDANFEClass read FDANFE write SetDANFE;
  end;


implementation

uses
  strutils, dateutils, math,
  untAuxiliar;

 {$R ACBrNFeServicos.res}

{ TACBrNFe }

constructor TACBrNFe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FNotasFiscais := TNotasFiscais.Create(Self, NotaFiscal);
end;

destructor TACBrNFe.Destroy;
begin
  FNotasFiscais.Free;

  inherited;
end;


procedure TACBrNFe.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FDANFE <> nil) and
    (AComponent is TACBrNFeDANFEClass) then
    FDANFE := nil;
end;

function TACBrNFe.GetAbout: String;
begin
  Result := 'ACBrNFe Ver: ' + ACBRNFE_VERSAO;
end;

procedure TACBrNFe.SetDANFE(const Value: TACBrNFeDANFEClass);
var
  OldValue: TACBrNFeDANFEClass;
begin
  if Value <> FDANFE then
  begin
    if Assigned(FDANFE) then
      FDANFE.RemoveFreeNotification(Self);

    OldValue := FDANFE;   // Usa outra variavel para evitar Loop Infinito
    FDANFE := Value;    // na remoção da associação dos componentes

    if Assigned(OldValue) then
      if Assigned(OldValue.ACBrNFe) then
        OldValue.ACBrNFe := nil;

    if Value <> nil then
    begin
      Value.FreeNotification(self);
      Value.ACBrNFe := self;
    end;
  end;
end;

function TACBrNFe.GetNameSpaceURI: String;
begin
  Result := ACBRNFE_NAMESPACE;
end;

function TACBrNFe.CstatConfirmada(AValue: integer): Boolean;
begin
  case AValue of
    100, 110, 150, 301, 302, 303: Result := True;
    else
      Result := False;
  end;
end;

function TACBrNFe.CstatProcessado(AValue: integer): Boolean;
begin
  case AValue of
    100, 110, 150, 301, 302, 303: Result := True;
    else
      Result := False;
  end;
end;

function TACBrNFe.CstatCancelada(AValue: integer): Boolean;
begin
  case AValue of
    101, 151, 155: Result := True;
    else
      Result := False;
  end;
end;

function TACBrNFe.EhAutorizacao( AVersao: TVersaoDF; AModelo: TModeloDF;
  AUFCodigo: Integer ): Boolean;
begin
  Result := (AVersao >= ve310);

  if (AModelo = moNFCe) and (AVersao = ve310) then
    Result := not (AUFCodigo in [13]); // AM
end;

function TACBrNFe.IdentificaSchema(const AXML: String): TSchemaNFe;
var
  lTipoEvento: String;
  I: integer;
begin
  Result := schNfe;
  I := pos('<infNFe', AXML);

  if I = 0 then
  begin
    I := pos('<infCanc', AXML);
    if I > 0 then
      Result := schCancNFe
    else
    begin
      I := pos('<infInut', AXML);
      if I > 0 then
        Result := schInutNFe
      else
      begin
        I := Pos('<infEvento', AXML);
        if I > 0 then
        begin
          lTipoEvento := Trim(RetornarConteudoEntre(AXML, '<tpEvento>', '</tpEvento>'));
          if lTipoEvento = '110111' then
            Result := schEnvEventoCancNFe // Cancelamento
          else if lTipoEvento = '210200' then
            Result := schEnvConfRecebto //Manif. Destinatario: Confirmação da Operação
          else if lTipoEvento = '210210' then
            Result := schEnvConfRecebto
          //Manif. Destinatario: Ciência da Operação Realizada
          else if lTipoEvento = '210220' then
            Result := schEnvConfRecebto
          //Manif. Destinatario: Desconhecimento da Operação
          else if lTipoEvento = '210240' then
            Result := schEnvConfRecebto // Manif. Destinatario: Operação não Realizada
          else if lTipoEvento = '110140' then
            Result := schEnvEPEC // EPEC
          else
            Result := schEnvCCe; //Carta de Correção Eletrônica
        end ;
      end;
    end;
  end;
end;

function TACBrNFe.GerarChaveContingencia(FNFe: TNFe): String;

  function GerarDigito_Contigencia(out Digito: integer; chave: String): Boolean;
  var
    i, j: integer;
  const
    PESO = '43298765432987654329876543298765432';
  begin
    // Manual Integracao Contribuinte v2.02a - Página: 70 //
    chave := OnlyNumber(chave);
    j := 0;
    Digito := 0;
    Result := True;
    try
      for i := 1 to 35 do
        j := j + StrToInt(copy(chave, i, 1)) * StrToInt(copy(PESO, i, 1));
      Digito := 11 - (j mod 11);
      if (j mod 11) < 2 then
        Digito := 0;
    except
      Result := False;
    end;
    if length(chave) <> 35 then
      Result := False;
  end;

var
  wchave: String;
  wicms_s, wicms_p: String;
  Digito: integer;
begin
  //ajustado de acordo com nota tecnica 2009.003

  //UF
  if FNFe.Dest.EnderDest.UF = 'EX' then
    wchave := '99' //exterior
  else
  begin
    if FNFe.Ide.tpNF = tnSaida then
      wchave := copy(IntToStr(FNFe.Dest.EnderDest.cMun), 1, 2) //saida
    else
      wchave := copy(IntToStr(FNFe.Emit.EnderEmit.cMun), 1, 2); //entrada
  end;

  if FNFe.Ide.tpEmis in [teContingencia, teFSDA, teSVCAN, teSVCRS] then
    wchave := wchave + TpEmisToStr(FNFe.Ide.tpEmis)
  else
    wchave := wchave + '0'; //este valor caracteriza ERRO, valor tem q ser  2, 5, 6 ou 7

  //CNPJ OU CPF
  if (FNFe.Dest.EnderDest.UF = 'EX') then
    wchave := wchave + Poem_Zeros('0', 14)
  else
    wchave := wchave + Poem_Zeros(FNFe.Dest.CNPJCPF, 14);

  //VALOR DA NF
  wchave := wchave + IntToStrZero(Round(FNFe.Total.ICMSTot.vNF * 100), 14);

  //DESTAQUE ICMS PROPRIO E ST
  wicms_p := IfThen(NaoEstaZerado(FNFe.Total.ICMSTot.vICMS), '1', '2');
  wicms_s := IfThen(NaoEstaZerado(FNFe.Total.ICMSTot.vST), '1', '2');
  wchave := wchave + wicms_p + wicms_s;

  //DIA DA EMISSAO
  wchave := wchave + Poem_Zeros(DayOf(FNFe.Ide.dEmi), 2);

  //DIGITO VERIFICADOR
  GerarDigito_Contigencia(Digito, wchave);
  wchave := wchave + IntToStr(digito);

  //RETORNA A CHAVE DE CONTINGENCIA
  Result := wchave;
end;


procedure TACBrNFe.SetStatus(const stNewStatus: TStatusACBrNFe);
begin
  if stNewStatus <> FStatus then
  begin
    FStatus := stNewStatus;
    if Assigned(OnStatusChange) then
      OnStatusChange(Self);
  end;
end;

end.

