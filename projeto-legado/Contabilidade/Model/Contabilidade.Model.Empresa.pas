unit Contabilidade.Model.Empresa;

interface

type
  TEmpresa = class
  private
    FCodigo: string;
    FDescricao: string;
    FC_G_C_: string;
  public
    property strCodigo: string read FCodigo write FCodigo;
    property strDescricao: string read FDescricao write FDescricao;
    property strC_G_C: string read FC_G_C_ write FC_G_C_;
  end;

implementation

end.
