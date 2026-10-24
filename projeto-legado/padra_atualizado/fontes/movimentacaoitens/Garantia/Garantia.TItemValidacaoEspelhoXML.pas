unit Garantia.TItemValidacaoEspelhoXML;

interface

uses
  Classes,
  SysUtils,

  Garantia.TItemNotaRecebimentoCliente,
  Garantia.TValidacaoNotaRecebimentoCliente;



Type
  TItemValidacaoEspelhoXML = class
    private
      FItemEspelho: TItemNotaRecebimentoCliente;
      FItemXML: TItemNotaRecebimentoCliente;
      FValidacao: TValidacaoNotaRecebimentoCliente;
      FExisteInconscistencia: boolean;
    public
      Const
        IDENTIFICADOR_XML = 1;
        IDENTIFICADOR_ESPELHO = 2;

      property objItemXML               : TItemNotaRecebimentoCliente       read FItemXML               write FItemXML;
      property objItemEspelho           : TItemNotaRecebimentoCliente       read FItemEspelho           write FItemEspelho;
      property blnExisteInconscistencia : boolean                           read FExisteInconscistencia write FExisteInconscistencia;
      property objValidacao             : TValidacaoNotaRecebimentoCliente  read FValidacao             write FValidacao;

      procedure pValidacao;
      procedure pNormalizaEspelhoXML;
      procedure pNormalizaItem(objItemOriginal, objItemNormalizar: TItemNotaRecebimentoCliente);

      constructor Create;
      destructor Destroy; override;

  End;

implementation

{ TItemValidacaoEspelhoXML }


constructor TItemValidacaoEspelhoXML.Create;
begin
  FItemXML               := TItemNotaRecebimentoCliente.Create( IDENTIFICADOR_XML );
  FItemEspelho           := TItemNotaRecebimentoCliente.Create( IDENTIFICADOR_ESPELHO );
  FValidacao             := TValidacaoNotaRecebimentoCliente.Create();
  FExisteInconscistencia := False;
end;

destructor TItemValidacaoEspelhoXML.Destroy;
begin
  FreeAndNil(FItemXML);
  FreeAndNil(FItemEspelho);
  FreeAndNil(FValidacao);
  inherited;
end;



procedure TItemValidacaoEspelhoXML.pNormalizaEspelhoXML;
begin
  pNormalizaItem(objItemXML, objItemEspelho);
  pNormalizaItem(objItemEspelho, objItemXML);
end;

procedure TItemValidacaoEspelhoXML.pNormalizaItem( objItemOriginal, objItemNormalizar : TItemNotaRecebimentoCliente);
begin
  if objItemNormalizar.strCodigo = '' then
  begin
    objItemNormalizar.strCodigo := objItemOriginal.strCodigo;
    objItemNormalizar.strDescricao := 'ITEM NÃO ENCONTRADO';
  end;
end;


procedure TItemValidacaoEspelhoXML.pValidacao;
begin

  FValidacao.blnDescricao :=  FItemXML.strDescricao = FItemEspelho.strDescricao;
  FValidacao.blnCodigoSituacaoTributaria :=  FItemXML.strCodigoSituacaoTributaria = FItemEspelho.strCodigoSituacaoTributaria;
  FValidacao.blnValorBruto := FItemXML.fltValorBruto = FItemEspelho.fltValorBruto;
  FValidacao.blnQuantidade := FItemXML.fltQuantidade = FItemEspelho.fltQuantidade;
  FValidacao.blnCodigoSituacaoTributaria := FItemXML.strCodigoSituacaoTributaria = FItemEspelho.strCodigoSituacaoTributaria;
  FValidacao.blnBaseCalculoICMS := FItemXML.fltBaseCalculoICMS = FItemEspelho.fltBaseCalculoICMS;
  FValidacao.blnAliquotaICMS := FItemXML.fltAliquotaICMS = FItemEspelho.fltAliquotaICMS;
  FValidacao.blnValorICMS := FItemXML.fltValorICMS = FItemEspelho.fltValorICMS;
  FValidacao.blnBaseCalculoSubstituicaoTributaria := FItemXML.fltBaseCalculoSubstituicaoTributaria = FItemEspelho.fltBaseCalculoSubstituicaoTributaria;
  FValidacao.blnValorSubstituicaoTributaria := FItemXML.fltValorSubstituicaoTributaria = FItemEspelho.fltValorSubstituicaoTributaria;
  FValidacao.blnBaseCalculoIPI := FItemXML.fltBaseCalculoIPI = FItemEspelho.fltBaseCalculoIPI;
  FValidacao.blnAliquotaIPI := FItemXML.fltAliquotaIPI = FItemEspelho.fltAliquotaIPI;
  FValidacao.blnValorIPI := FItemXML.fltValorIPI = FItemEspelho.fltValorIPI;
  FValidacao.blnCST := FItemXML.strCST = FItemEspelho.strCST;
  FValidacao.blnDesconto := FItemXML.fltDesconto = FItemEspelho.fltDesconto;
  FValidacao.blnBaseCalculoFundoCombatePobrezaST := FItemXML.fltBaseCalculoFundoCombatePobrezaST = FItemEspelho.fltBaseCalculoFundoCombatePobrezaST;
  FValidacao.blnAliquotaFundoCombatePobrezaST := FItemXML.fltAliquotaFundoCombatePobrezaST = FItemEspelho.fltAliquotaFundoCombatePobrezaST;
  FValidacao.blnValorFundoCombatePobrezaST := FItemXML.fltValorFundoCombatePobrezaST = FItemEspelho.fltValorFundoCombatePobrezaST;
  FValidacao.blnBaseCalculoFundoCombatePobreza := FItemXML.fltBaseCalculoFundoCombatePobreza = FItemEspelho.fltBaseCalculoFundoCombatePobreza;
  FValidacao.blnAliquotaFundoCombatePobreza := FItemXML.fltAliquotaFundoCombatePobreza = FItemEspelho.fltAliquotaFundoCombatePobreza;
  FValidacao.blnValorFundoCombatePobreza := FItemXML.fltValorFundoCombatePobreza = FItemEspelho.fltValorFundoCombatePobreza;
  FValidacao.blnClassificacaoFiscal := FItemXML.strClassificacaoFiscal = FItemEspelho.strClassificacaoFiscal;

  FExisteInconscistencia := FValidacao.fExisteInconscistencia;

end;

end.
