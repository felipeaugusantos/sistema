unit untTRegistro0000Cat42;

interface

uses untTRegistroBaseCat42,
     SysUtils;

type
  TRegistro0000 = class(TRegistroBase)
  public
    procedure pGerar; override;
  end;

implementation

{ TRegistro0000 }

procedure TRegistro0000.pGerar;
begin
  inherited;

  intQuantidadeGerada := intQuantidadeGerada + 1;

  pInicializaLinha;

  pCampo(strTipoRegistro);                                   //001 Texto fixo contendo "0000"
  pCampo(FormatDateTime('MMYYYY', abertura.dtaDataInicial)); //002 Péríodo das informações contidas no arquivo
  pCampo(abertura.empresa.strRazaoSocial);                   //003 Nome empresarial da entidade
  pCampo(abertura.empresa.strCNPJ);                          //004 Número da inscrição da entidade no CNPJ
  pCampo(abertura.empresa.strInscricaoEstadual);             //005 Inscrição estadual da entidade
  pCampo(abertura.empresa.cidade.strCodigoIbge);             //006 Código do município do domicílio fiscal da entidade, conforme a tabela do IBGE
  pCampo(abertura.strVersaoLayout);                          //007 Código da versão do layout
  pCampo(abertura.strFinalidade, False);                     //008 Código da finalidade do arquivo

  pAdicionaLista;
end;

end.
