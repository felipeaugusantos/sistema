{********************************}
{* Tipos de cadastros do auttin *}
{*****************************AC*}
unit untTipoCadastro;

interface

const
  ttBases = 0;
  ttColorantes = ttBases + 1;
  ttNovasFormulas = ttColorantes + 1;
  ttGeral = ttNovasFormulas + 1;
  ttPersonalizadas = ttGeral + 1;
  ttEmbalagens = ttPersonalizadas + 1;
  ttMontadoras = ttEmbalagens +1;
  ttAcabamentos = ttMontadoras + 1;
  ttLinhas = ttAcabamentos + 1;

type
  TTipoCadastro = Shortint;

implementation

end.
