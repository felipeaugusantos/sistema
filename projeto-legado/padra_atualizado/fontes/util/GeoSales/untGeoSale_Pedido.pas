unit untGeoSale_Pedido;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils, strUtils;

Type
  [TTipoLayout(Importar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Pedido = Class(TGeoSale_Base)
  Private
    FCD_TIPO_PEDIDO: String;
    FID_PRIORIDADE: Integer;
    FNM_RZ_SOCIAL_ENTR: String;
    FNR_CGF_ENTR: String;
    FNR_FONE_ENTR: String;
    FDT_ENTREGA: TDateTime;
    FCD_ORG_VENDA: String;
    FID_ORCAMENTO: String;
    FNR_CNPJ_CPF_ENTR: String;
    FCD_PEDIDO_PALM_PAI: Int64;
    FVR_PEDIDO: Double;
    FID_TIPO_FRETE: String;
    FDS_ENDERECO_ENTR: String;
    FCD_TRANSPORTADORA: Integer;
    FCD_PEDIDO_CLIENTE: String;
    FCD_PEDIDO: String;
    FNM_CIDADE_ENTR: String;
    FDT_EMISSAO: TDateTime;
    FCD_PEDIDO_PALM: Int64;
    FNM_ESTADO_ENTR: String;
    FCD_CLIENTE: Integer;
    FCD_TAB_PRECO: Integer;
    FNR_CEP_ENTR: String;
    FCD_VENDEDOR: Integer;
    FCD_ST_PEDIDO: Integer;
    FNM_BAIRRO_ENTR: String;
    FDS_OBSERVACAO: String;
    FCD_MEIO_PGTO: String;
    FCD_COND_PGTO: Integer;

    procedure setID_ORCAMENTO(const Value: String);
  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    Property CD_PEDIDO_PALM              : Int64     Read FCD_PEDIDO_PALM                 Write FCD_PEDIDO_PALM;
    Property CD_CLIENTE                  : Integer   Read FCD_CLIENTE                     Write FCD_CLIENTE;
    Property DT_EMISSAO                  : TDateTime Read FDT_EMISSAO                     Write FDT_EMISSAO;
    Property VR_PEDIDO                   : Double    Read FVR_PEDIDO                      Write FVR_PEDIDO;
    Property CD_ORG_VENDA                : String    Read FCD_ORG_VENDA                   Write FCD_ORG_VENDA;
    Property CD_PEDIDO_CLIENTE           : String    Read FCD_PEDIDO_CLIENTE              Write FCD_PEDIDO_CLIENTE;
    Property CD_PEDIDO                   : String    Read FCD_PEDIDO                      Write FCD_PEDIDO;
    Property CD_COND_PGTO                : Integer   Read FCD_COND_PGTO                   Write FCD_COND_PGTO;
    Property CD_TIPO_PEDIDO              : String    Read FCD_TIPO_PEDIDO                 Write FCD_TIPO_PEDIDO;
    Property DT_ENTREGA                  : TDateTime Read FDT_ENTREGA                     Write FDT_ENTREGA;
    Property CD_MEIO_PGTO                : String    Read FCD_MEIO_PGTO                   Write FCD_MEIO_PGTO;
    Property CD_ST_PEDIDO                : Integer   Read FCD_ST_PEDIDO                   Write FCD_ST_PEDIDO;
    Property ID_PRIORIDADE               : Integer   Read FID_PRIORIDADE                  Write FID_PRIORIDADE;
    Property CD_VENDEDOR                 : Integer   Read FCD_VENDEDOR                    Write FCD_VENDEDOR;
    Property ID_TIPO_FRETE               : String    Read FID_TIPO_FRETE                  Write FID_TIPO_FRETE;
    Property CD_TRANSPORTADORA           : Integer   Read FCD_TRANSPORTADORA              Write FCD_TRANSPORTADORA;
    Property DS_OBSERVACAO               : String    Read FDS_OBSERVACAO                  Write FDS_OBSERVACAO;
    Property NM_RZ_SOCIAL_ENTR           : String    Read FNM_RZ_SOCIAL_ENTR              Write FNM_RZ_SOCIAL_ENTR;
    Property DS_ENDERECO_ENTR            : String    Read FDS_ENDERECO_ENTR               Write FDS_ENDERECO_ENTR;
    Property NM_BAIRRO_ENTR              : String    Read FNM_BAIRRO_ENTR                 Write FNM_BAIRRO_ENTR;
    Property NM_CIDADE_ENTR              : String    Read FNM_CIDADE_ENTR                 Write FNM_CIDADE_ENTR;
    Property NM_ESTADO_ENTR              : String    Read FNM_ESTADO_ENTR                 Write FNM_ESTADO_ENTR;
    Property NR_CEP_ENTR                 : String    Read FNR_CEP_ENTR                    Write FNR_CEP_ENTR;
    Property NR_FONE_ENTR                : String    Read FNR_FONE_ENTR                   Write FNR_FONE_ENTR;
    Property NR_CNPJ_CPF_ENTR            : String    Read FNR_CNPJ_CPF_ENTR               Write FNR_CNPJ_CPF_ENTR;
    Property NR_CGF_ENTR                 : String    Read FNR_CGF_ENTR                    Write FNR_CGF_ENTR;
    Property CD_PEDIDO_PALM_PAI          : Int64     Read FCD_PEDIDO_PALM_PAI             Write FCD_PEDIDO_PALM_PAI;
    Property CD_TAB_PRECO                : Integer   Read FCD_TAB_PRECO                   Write FCD_TAB_PRECO;
    Property ID_ORCAMENTO                : String    Read FID_ORCAMENTO                   Write setID_ORCAMENTO;



  End;

implementation

{ TGeoSale_Pedido }

uses untFuncoesSimples, untGeoSalePedidoSingletonCollection;

function TGeoSale_Pedido.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + VS_strCodEmp + 'P.TXT';
end;

function TGeoSale_Pedido.fGetSql: String;
begin
  Result := '';
end;

procedure TGeoSale_Pedido.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

procedure TGeoSale_Pedido.setID_ORCAMENTO(const Value: String);
begin
  FID_ORCAMENTO := Value;

  If FNomDir <> '' Then
    TGeoSalePedidoSingletonCollection.Instance.pAddPedido( Self );
end;

end.
