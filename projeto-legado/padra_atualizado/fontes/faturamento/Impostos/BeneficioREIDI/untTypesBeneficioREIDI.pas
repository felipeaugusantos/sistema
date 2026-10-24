unit untTypesBeneficioREIDI;

interface

type
  TParametrosCalculoBeneficioREIDI = record
    ValorTotalDoItem: Double;
    AliquotaDeIcmsDoItem: Double;
    ValorDoIcmsDoItem: Double;
    BeneficioREIDI: Boolean;
    DeduzirIcmsDoBeneficioREIDI: Boolean;
    EspecieDeDevolucao: String;
    EhBaixaDeEntregaFutura: Boolean;
    DescontoEspecialBaixaDeEntregaFutura: Double;
    AliquotaPis: Double;
    AliquotaCofins: Double;
    BasePis: Double;
    BaseCofins: Double;
    EhOptanteDoSimples: Boolean;
  End;

  TResultadoCalculoBeneficioREIDI = record
    ValorDoDescontoBeneficioREIDI: Double;
  End;

implementation

end.
