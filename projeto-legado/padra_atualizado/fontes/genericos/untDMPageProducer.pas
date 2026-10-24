unit untDMPageProducer;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Web.HTTPProd;

type
  TdmPageProducer = class(TDataModule)
    pageJsonBoaVistaAcerta: TPageProducer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPageProducer: TdmPageProducer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
